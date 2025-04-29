Return-Path: <bpf+bounces-56915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32EAA08D1
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C221B65CC7
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB52C1083;
	Tue, 29 Apr 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L84mSrcS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973741C4609
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923559; cv=none; b=q8pG4ev2eUS3Tmx78NyfVCZlMS8z0zKKaDv/BYXQmVr7XhLFnXoZVmqJWw6Dc9bSDxA/5cWAUYJwh0jNE+wbBiBVBlrT4J/Y3DvQVra+eOcq7E7lUPu5tbF6aRas9GwIrHTGRKztSvNaR76utWpl/kgT0nf6xFjQwdarysohjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923559; c=relaxed/simple;
	bh=0NSKurciESBFEUjfZdIo82rXaTeTXcfkyDzLrLZIYIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ptzn9YiVzw6r3cZiRMqUBHsdxEks1R3wvjIQ1TH17WUl8aXc+6jS2o3zFAMsTVRxWzphYtPEJOtpv5qjt6JOX+brQir2r65NG9blA1WAZmT+h7HVgmn9TPPzydT1H4JxW9KWanXXcu8+hl24JXeTOkpXUTKrm1H8yRQtnBqFRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L84mSrcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745923556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
	b=L84mSrcSu7ocwOKurliAqhnA7QSYblF1Nlr7KtbYHKmhdIW+VSGSTpvsCvCfEFEzuqg/6v
	/gEX7278ymfSdpDxWl+BflUzP9q/lVNDAVU8i8x2PLMom0GnFsiXzP3wxZiLqVlA/zj7dI
	2MFWGv4AiNxwOMwobQQEKrW1HHhBc+U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-LjkUsLMDMbGOHMmCXjptAA-1; Tue, 29 Apr 2025 06:45:54 -0400
X-MC-Unique: LjkUsLMDMbGOHMmCXjptAA-1
X-Mimecast-MFC-AGG-ID: LjkUsLMDMbGOHMmCXjptAA_1745923554
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb90bccc16so398232966b.3
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 03:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745923553; x=1746528353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN+UKNlb4Wy7kol3NSyz5lz02pJ0x8EuJYg2sYbM+jY=;
        b=VPZv/rIOGZjdL0vywDZDfO549HFoNRoiLZcYs2ca22rrTEqeDrtIrl9gWaWPMrxpCb
         es6fNzXhWEubJcoS2p4QMcphgtocZFAnT8tFXVYZUQu6L8fCTC3qk0ivj4bry3t2fjXy
         tw0FbuXTuWWUEKvL1DL/trbXqInUYunYQAFFJu4GSjJcwXLeLa1ieI//IzoPDVkPOVoN
         913xhAkEQp3J3IT0SuIe9r1L6TvDd3saty56hasOptFKx4/2pN9odxBfGf+H7JFenriG
         5MuSb2ikL6fVhj/YD4pjWKjHg12GwCGkDgaf9qliPKSTRkN10Blmh/HPEqNxh01lyqr+
         y/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXL8s90ZB3CCqD47T0xuvf2Ho14KHoUMmCRaDKaSFKkx3xD2rH0BeznLSoeuPhZ0UePGOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpV48jRs+cmGnn9USX7hgtDrR99byKwzK/6GhzCr9OYLPwEad8
	uF9nwEyL6Cd13IMOqFq8jFtY9LcigSkwQlI+538UoI//euxnOxNfEC0b2g3FNGYcvg7wCWWSQdU
	ZkGhZNs/tNF+n6JderRA+nEdw6OOj+12JYcujs7HbmccdR1JdFK8KUszOLUrA
X-Gm-Gg: ASbGncvWDK0nbpHw+IX23rjFTYRnEOEEbsMiYSUOxQwxeBCEXPndubY0ICeo4eRsY/H
	dCE4XEq7ebzhCKrC7JPYY+Z7ZsCPkcyuG3sNNc48JIWEAAIexRcPS8MHYxVX0nqTD9+D/KfurvL
	AixwnFdrHvqxcj722hzdQqER2lT/gVw5BCoo/5EZ2D6HKrATquKCq6IhShvPZ8FMwVf7MgHxH3o
	7dMp2kemVUA8c9eCCL+eAQ8Fkw7/0sCkPMyvOjNGd5dN06yBsk5pObQnRE0aN/Em5k4KkdGBej0
	zRuzeYwk48Pj3BtHSA5mfBanpHvFYwxvpmtj0sdG8GTxjwl5ZdM66UYriHs=
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102945166b.48.1745923553454;
        Tue, 29 Apr 2025 03:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGozcf6FjAPnL3LZPQMJPZBCYzwfasWb1qRqTn81hns/gqHo3eKbml0IfXHZplrtmlSv+ODGw==
X-Received: by 2002:a17:907:7289:b0:acb:52cb:415f with SMTP id a640c23a62f3a-ace84b279e1mr1102942166b.48.1745923552966;
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cb08sm772460366b.19.2025.04.29.03.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:45:52 -0700 (PDT)
Message-ID: <5f7897f3-5225-4f86-8596-a5793989a9c3@redhat.com>
Date: Tue, 29 Apr 2025 12:45:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/15] tcp: accecn: add AccECN rx byte
 counters
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index af38fff24aa4..9cbfefd693e3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -303,6 +303,7 @@ struct tcp_sock {
>  	u32	delivered;	/* Total data packets delivered incl. rexmits */
>  	u32	delivered_ce;	/* Like the above but only ECE marked packets */
>  	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
> +	u32	received_ecn_bytes[3];

I'm unsure if this should belong to the fast-path area. In any case
AFAICS this is the wrong location, as the fields are only written and
only in the rx path, while the above chunk belongs to the
tcp_sock_write_txrx group.

/P



