Return-Path: <bpf+bounces-71893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB36C0091B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D97F3AAB14
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A930B512;
	Thu, 23 Oct 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRObtd/0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094632D9784
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216461; cv=none; b=NW7pM037IxgvFj54DvkmPUmLH5Xvu50aiPsW3ido8X1nKdVy3u2o3otLo8Ec+Vnv2xipLhmNavE/LGAw1K2fWgWoVN7v/YoV3/Vd2cX5GlN/LMGD6xImVTfe5Wpm+XCLDdPgfSVefM7gP/rq6QNDtQEaFVKqt5MApCLx+y2CEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216461; c=relaxed/simple;
	bh=5ifU/Wvg+kVhHnF9BQP9B3foPYA5Ik7jwpTbYYS73os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohuYmPxpxpuIBw7eKwiIj+FChq0BDYeO2QQD283DwNftDQk4d5o4c1YWTdkeh6YinoNdSnC2lldzvkQ5evTdhhxpIyyWU9nPRnIqofRjmoib+g8x2ads8ISFGfJsl7M5FBvpCxX3QAxem++kQYon1VKFwIRJ3xEC3N7Gf3jUiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRObtd/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
	b=IRObtd/0NbBCxcHYejm0YZe+YOvPASz/Mo/z5F1Uqq7hpZfLACWvhQ1NWPhOTPVOX5KAEp
	5BmPbtcrKhKsuuZ+UEL9BY2fsWBg5QMV2zjAdNm81RJ/Nxo+xJ42whdjFusNow6Gd8PVNi
	Q/wduR6HVHR6fCNbyIKK6H0rdHNHctw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-sHfQbGDWOtCGj0_qHgJlrg-1; Thu, 23 Oct 2025 06:47:35 -0400
X-MC-Unique: sHfQbGDWOtCGj0_qHgJlrg-1
X-Mimecast-MFC-AGG-ID: sHfQbGDWOtCGj0_qHgJlrg_1761216455
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47114d373d5so5243365e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216454; x=1761821254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
        b=lSLShBJilzrUeiWeqModta5gx1t3VsVRFdiq0pltkcGt39cvFwRk2/vPHt34l2aEeP
         wfhewdzbgRDDV/EJE0sVuz0eIMk3LEsaovNKK4NC7O/dGbPFWHWTvM4SK9MsQEQBvMUl
         YkOWfd9r3G9izNqIV1JFVN0gjOKPfTHzGsdJY64FhSTdHlnOBGBsfz3Oo7ySnsG5M2E2
         nX5qpDMxzhMRtTOJu9uT8CnDOozWmWtmlUhwsPd5EOgf3d30AR1h3E+aXcGZaPLIN7iQ
         2JutzdlNyDxDhhuz9DfsHJ+Ote/R0xF20vJezgFAQHDamo12IR8OcjufXcvLH3Itwopd
         bruA==
X-Forwarded-Encrypted: i=1; AJvYcCWcezZyeaC5hothtJ89l+l1O+q/Hnt0dktGwTRZhPO9cQnec5xlpOuIs7QW42r9x1Se7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4mstvr2zbLFL1duSGLB4Xm8+tsFVrQ4NVeRbV3Zwzy2/Y06m
	IfbaP83MjHj+0i/FCy+Os6WS7z/cKmIcuvHb14PCuYBGfKzUFE/+QzXvy2kNyNXknb3G0EHRFBf
	dfZM9C4Fw8qCiTbsAqQOz3FKhKlGceUyTdb5/zbxkiFweZwK9PoRwug==
X-Gm-Gg: ASbGncsYPuPs5btGwy+by9FFLRyjaPTOokVUqCYBdXcbT2dElj0Lj8bUi46fFiioH0g
	JUaWxvh2A5nqQt3kIv9RlogYb095LNoCejHWLg5v92MPcQze3EOvBQGuNY3ohSSie2suaRZk43l
	D1v/aH8xQvwyyyjwnTLLouxiGQb14JN3lS+MbwG0kP7jrYevISvC/GJDPmhz+foq682arYCd1Jd
	SY0rRvWLHUdxN1rTzTxai43ZZfeogeNR/UX6IReBJT1FbBJZYR4+O0manvyeDYwPV4YNIaNIw9j
	Kf/ZFZ413t4wjfQKlbAJ/EN3lnzAZPhADeUZwHvP6tT1YiEhfsBHUF87y+SOJ4KM/jbAwD/cYCD
	tojSDSBzA1OBfDDz0y0x7nvO7yTOmxVvwTDj+ixz2So7ZsuE=
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738595e9.27.1761216454576;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCjAG6BFqWGtyFJWnnSCkQuOtRF7p6tj9Xo7x9KfV4P2z7kmIFxIZPQ6J9DI6KJJoMB+iuQ==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738355e9.27.1761216454135;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm29122005e9.17.2025.10.23.03.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:47:33 -0700 (PDT)
Message-ID: <52c7bbac-da08-44d5-b1ec-315ce001b42a@redhat.com>
Date: Thu, 23 Oct 2025 12:47:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] net/l2tp: Add missing sa_family validation in
 pppol2tp_sockaddr_get_info
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
 <20251020212639.1223484-2-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> While reviewing the struct proto_ops connect() and bind() callback
> implementations, I noticed that there doesn't appear to be any
> validation that AF_PPPOX sockaddr structures actually have sa_family set
> to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
> sizes.
> 
> I don't see any way that this might actually cause problems as specific
> info fields are being populated, for which the existing size checks are
> correct, but it stood out as a missing address family check.
> 
> Add the check and return -EAFNOSUPPORT on mismatch.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  net/l2tp/l2tp_ppp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 5e12e7ce17d8..b7a9c224520f 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -535,6 +535,13 @@ struct l2tp_connect_info {
>  static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
>  				      struct l2tp_connect_info *info)
>  {
> +	const struct sockaddr_unspec *sockaddr = sa;
> +
> +	if (sa_len < offsetofend(struct sockaddr, sa_family))
> +		return -EINVAL;
> +	if (sockaddr->sa_family != AF_PPPOX)
> +		return -EAFNOSUPPORT;

I fear we can't introduce this check, as it could break existing
user-space application currently passing random data into sa_family but
still able to connect successfully.

/P


