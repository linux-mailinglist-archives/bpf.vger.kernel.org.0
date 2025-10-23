Return-Path: <bpf+bounces-71894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EEC009A2
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0808F359AD5
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157B30C348;
	Thu, 23 Oct 2025 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq22W/IH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450E30BF4F
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217208; cv=none; b=A30ECrCI60QhyT5WoxhwTMSNMQaVl1VOf1q5vBPM7jyQwew6dgywZUSEh+7hBHkD0CCOTlUPNQS7+nDlyZ5ZNkTSJB3qn8QsE5yeDzYX1xslXcDtB64AI3E8ZBK1X03YzLXzgZTrIHiaFCWvpkzIgXNXEbHFb/CuNVEwldrC+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217208; c=relaxed/simple;
	bh=C1Pp292wr9u8EzQo5FGAynEK1LI49VCDkvagkZiSjy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loQKTIDbrPpMQs5iuxNlM1wOadhIyFc4t3tgu7FPoyVxKUzoEdxrEsAGl2x41elmypeRD9j/IbUl/IOdgZurfeucYtJQeAmeqTUSrp2Q1P0GdbQtZxhCmoYsf0aAh+aC2tbRli4EUEg/vB1ElQGrARN80I68cBLOKmfCFd27T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq22W/IH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
	b=Cq22W/IHktldJONEZayu10Be3rZLtm02DhF4991bZacAa0NAbjhzcL5+C5iQCX08LBX9sH
	7oD9FZQNOzVHsr+npiMt5kN6ulCZo0fNHq64ONbwGF+EyG8RHo0ZU92BJuDtwObvke8B0b
	F6yHeHcavOnc/HS3bDD0KP18cAphavg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-lTBP5H4hPz6fCBhzehCvJw-1; Thu, 23 Oct 2025 07:00:03 -0400
X-MC-Unique: lTBP5H4hPz6fCBhzehCvJw-1
X-Mimecast-MFC-AGG-ID: lTBP5H4hPz6fCBhzehCvJw_1761217202
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso5471055e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217202; x=1761822002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
        b=Rg4y9NoQa85MSS39QQkISYth+hUByIIigiN8cXYtsQBfHs2kPdCQhW4PMbdbTp4oQP
         QXOBJ7YaZy51oMMGKGAJCKQXMKJYqtCBPzVxQj8z4L8AJSUgzLVtR/uvddjaDjRd5SWO
         JOccHcx2KYKWMwvdP+RDw+nHLPI6ROTns6B1Y1drw+RstcFEJRIr5L28lQkGvqNgSDzX
         xAR+fMpmsziRK72Hus59Rff48f8pvm6HHYy6hfZlDKV6r/s8CRFyeI2sb45B33kGO7ca
         PlXlXdt2w9hGvqcTdzqrru7IDJWXXKGtGhFamsKEX/q1IrNBpCbVrVZTGQCT1PWR+OUj
         lhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx7KvFrui1OYKKr1aFgTJErHTg85emogt/btZ+0ZyzVDOG2TMMZQU6VIBvhi8rgaM3YTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPoUpo/hYpaJU+Che3q5UlGXXP0x8yz90Tx3te4JO5iJ86Qau
	QiXdDZVnffex8JvbJqRHBcU22L+1Vc3X1sBz8D1ZSWJD2XesdsIHAG90dcLUaRlsJ0hvyCGRy1w
	62mHV+RajjGY7CiUvRMmvxi19BWS3bvloCdoaf5SDiOUnenyoEnqAZw==
X-Gm-Gg: ASbGncsCmXWlykonFA6NE8NHKnRk1jd4SjgYroQY3jP1DOQO+B0RLSsnqzmbMWG39Zj
	YOEL6bUYfhB10jeNBtgaNVKgneacbPhuo5bEGZn8sMR4/RprZCcVzJPCwF4TSc3C5z2HOO6oM4d
	CRzkKxspOFJO/jDZhSik1wnDzekGi//nynd2tHB+/uo8/VhLdxrtMu2rByYi59OUwjwYHdWPyKG
	A8M3/SGufxNSmf2I21xPJNLamz16AOl/nwvCIjOSRoF7yKSKh8MGgTIXqXzyvIHgVLasCITeu7F
	SXkyDDixNZadLbA3iOj7iH4+R3G8gJbQnLdJCwZoHQl1UBxLjPyOcQ64LGv3T6/a80C5QroZbwO
	EgsOgZ11QEFdghxtNl8iR8e+t/f6be9HSpymNlVniPWGg3as=
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330295e9.8.1761217202290;
        Thu, 23 Oct 2025 04:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVkcD6BOYZ24anCxqkCdENWyVIeDStBshfMtRIpeohF2t+fEegH7komx/yFzU5BEDs7jhjg==
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330125e9.8.1761217201896;
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc6esm3288915f8f.25.2025.10.23.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Message-ID: <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>
Date: Thu, 23 Oct 2025 12:59:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Another side note: please include the 'net-next' subj prefix in next
submissions, otherwise patchwork could be fouled, and the patches will
not be picked by our CI - I guess we need all the possible testing done
here ;)

/P


