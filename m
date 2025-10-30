Return-Path: <bpf+bounces-72984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F0C1F79B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 634E334DBCF
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF234DB59;
	Thu, 30 Oct 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRizGNLB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A631815D
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819326; cv=none; b=cCxi9xDZjJyKx5p2xvKhxpAV6VxRE9qa/u1q7geUGFJWzrh1eC8LzoeK2jHChovntvuba+L9NVzxqDIBhRVy3UEY0emAP4E3073cjpOwcuqLD0W0PwFvomXxWCF75ul5LVMxbGpQSir7ftEKjYXkCaM4Epjf7aGQEVDWq7RhNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819326; c=relaxed/simple;
	bh=HwuBL7/j8iddX6AaVhQYYIFhCQoJyE/42FRGYgfEbzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4aivtlCjjQQURqb28rXGMGwJ5vNcZEv4J97lSRucoZrPetIykUizWdW9NqY138Ofmf0RA3OTP/OMnE9lG+GKuFcGGUHDphLaI6PrIHaagXBfhlva5rEqo2ZU0Bpyln3FKRv7E7dgAl57vfqMayFLMj8XuGJvbhYd8yQ73FpY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRizGNLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761819323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOlCRowd2cbEJIalDQ+zCUHAgo4uy8C8YJgtAhPsurY=;
	b=eRizGNLBp7l1lxjoV4ldlsLBJ1+1VJ3lDhdbPFn+bBiDEAt2Fqb4onXzgVaSmUG7OtgOCS
	mcTZaPpzbTMtn9rmYON5rf74FgrSBAmO+mPO7nILrOH2YvtjX1DBmzizRuckwv3OgcTZLK
	u1yj1AdEaxKrTHHDxoC666GPc9TSCIg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-b1mSsDDcNT231FQlUGUsbw-1; Thu, 30 Oct 2025 06:15:22 -0400
X-MC-Unique: b1mSsDDcNT231FQlUGUsbw-1
X-Mimecast-MFC-AGG-ID: b1mSsDDcNT231FQlUGUsbw_1761819321
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4771e696e76so11647675e9.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 03:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819321; x=1762424121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOlCRowd2cbEJIalDQ+zCUHAgo4uy8C8YJgtAhPsurY=;
        b=g+n4hDGyQfQb2ciqvhLO8EIbrXXi6gOgtCVDf+ze1bUihh/7CTfFZusBdqAw0bfs+m
         nOFAVu6oo385FxQNypT40CzQpVcoxW6A7slRD8uDButEdT4YT7nJGlY79rTnWTVAAsoS
         OPj6oAnALGVsPjEu18ormchRGp2Rz6xkSBQ0EjLUmEBi9c/dGv1Hb6n7S5JBm/HxQJCc
         8FZhlJHuJC5i9ecUhkbio/NCUxKJjOUqnkGTT3aAVzZBL/Cl2VI/JmZKl19Djv2+SiNd
         CRIf6vh+N+7sIuU2QEADZRebtGpIRZiteBPcxmpwi3YfiXIvLg6Bj/GS6Z0BmxIGZLzH
         LfgA==
X-Gm-Message-State: AOJu0YwFzn4X4TDzSVlDAc9pL5XG7/txamsehkDoOU6KTIUq+zCvsUNr
	Lk3RMKp8u3kXiipB5oiCgKn3Hk7hPgc370nqFEpF4G1tXgAHo4LFk5r96bHk4B+JiA2Z2y/aqRm
	52HYawpeap5FZ1YWqE46drgMnUL4XqXafY/YHrjp6d6ArBC1SiEtSxg==
X-Gm-Gg: ASbGncvbfvCgF5KBy72JxkBRj2X/aLL/8cxnYw2eFs23appW6ALMdObS223TXzi6F26
	Ouq0RfNDuEe99SkByUDw30jp1aLtlIxSNBAEKzSodqRj/UtE03H7IQdYMoFuOotUSVGwtPtfX58
	SAmOWjZJk4/Nh4RP1JAQXrW7Q14XfJv6evVsXbKfr8D4ifRhO92F+qMwoIR4yJj50W55dyIeeC1
	FBJD0N6ju10t/unr4eFEaqkd1aAiBBVquatCC7bJ6f/cFawgS/APm49igmTyDexq/QEW5WJZ9Tx
	beJWilY9hLdVuo6EgWBkEIVGfHFBWwW9AQKJjWCzVkvnNjZ80joQT91SUPBPc92/oxbSO83exWs
	pHCSqh0XNLCGo3gCFDTYzwUjGmwSTvYum+sOjKAyjIAih
X-Received: by 2002:a05:600c:35c3:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4772684f823mr26612045e9.34.1761819321149;
        Thu, 30 Oct 2025 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPrpvB9n94QmEp5mdsdi+Ry3jLFqF5DP/uud3K/QL/6/hTmUd566gZ2nFWiXbJf2cLc4FZA==
X-Received: by 2002:a05:600c:35c3:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-4772684f823mr26611665e9.34.1761819320702;
        Thu, 30 Oct 2025 03:15:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fe36sm32094485e9.2.2025.10.30.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:15:20 -0700 (PDT)
Message-ID: <54d1ac44-8e53-4056-8061-0c620d9ec4bf@redhat.com>
Date: Thu, 30 Oct 2025 11:15:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251026145824.81675-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 3:58 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since Eric proposed an idea about adding indirect call for UDP and

Minor nit:                          ^^^^^^

either 'remove an indirect call' or 'adding indirect call wrappers'

> managed to see a huge improvement[1], the same situation can also be
> applied in xsk scenario.
> 
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. 

If I follow the conversation correctly, Jakub's concern is mostly about
this change affecting only the copy mode.

Out of sheer ignorance on my side is not clear how frequent that
scenario is. AFAICS, applications could always do zero-copy with proper
setup, am I correct?!?

In such case I think this patch is not worth.

Otherwise, please describe/explain the real-use case needing the copy mode.

Thanks,

Paolo


