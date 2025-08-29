Return-Path: <bpf+bounces-66978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7561B3B983
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1366158082B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3D313537;
	Fri, 29 Aug 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2srUIEY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07644311C30
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465005; cv=none; b=oEEPYISp+KzgZXERh5NJ3j4ZsHqg6XD3+mUNlTQX2HM2+t919Uveh6isAmmGsmsnh7lV/biTJuq9BVE1UQQQs3QbIbEKYLyNszbgYZyRUHl2ZQnMYqEEh1zuIThEQEl1oYoAEenoD0Tvsp/nnsRTwUk71tbCgS1uQexITZBpzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465005; c=relaxed/simple;
	bh=inbltJcud415RfOLdtDWb4ZRPiVNmpE13gKJhy8SUBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC+hOD/dveH47diYWxnhws35gVzaWHNnQEYHAPEe4IQECDTr6hhD0q7toLGdaerV7PTQAWFdxrXscqrPMPbTp6JS1KMDvF3ljCw8gdn/TQKJ2dx1lyhtoofGT7SM3mC1gBnNgcnkZifnrFvYjrC0PFpN8PR/WyYzVL1jhC7xhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2srUIEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756465003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EaP7Ha620z7PGq0bZ/BqrUJv9Q8RkZ+3RzVayMVbaTE=;
	b=D2srUIEYXfStuj8ptWfVdvcq14JNe+GEoC1DcTbArICDEN5gn13414iY5KEwCXuHf4jJar
	OTJZfhNBEjIV+i09YmeEHKLKWNNVxxZa1eRNt+tbeRQxkgOq/qCT9aMVM2XqrXsH2WsxH0
	XkmI/IUuV5LF1Fiu2K9Dpzh09PpHv5Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Yl5PNM60P7Cx6UW5ijC7kg-1; Fri, 29 Aug 2025 06:56:41 -0400
X-MC-Unique: Yl5PNM60P7Cx6UW5ijC7kg-1
X-Mimecast-MFC-AGG-ID: Yl5PNM60P7Cx6UW5ijC7kg_1756465000
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7f0d1449so3718085e9.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 03:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465000; x=1757069800;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaP7Ha620z7PGq0bZ/BqrUJv9Q8RkZ+3RzVayMVbaTE=;
        b=hJ316Lhlmm8APdoRQad4TNEXIz66l82Ol9R4s7FwEa/aMZrab9fcW5/zkA7VbUAVOx
         nDbVBv4oixJeEFkvzVe9T+rhrTA9tSVlFOdKHvLyA3/gDZfRtUR30HfGHl++kjOH3JeM
         PEUC8A+XqFneHGJyVOUsLw9pMFN2R7fWo5/8Tr1S2KiBVMmssiDqC0Ymv3qglT2e1qaC
         dNSNjaIhyD5nus2m+RCNubsNaeNHkux6xfJ8O9GOcH4y+sBjWO68xb29BZmVVdLg3cjw
         EEm+dI3hrkIl2Apt4eOLfsVOKTJgzdAR3DtrUsd//Ay1HaR6xVpjs7VEsYqTgf87TCoZ
         imEg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ShUA3uFFS20WnprZ/94wz6jOroEBhn4axln5M1vjCT+kVYlEN/U0w946YCMjIGiikiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f1W4WHLCjZtcpKXXUX69K9cYCwCFSiee5VH+4M+/nxHcixHw
	k/iQV7OHp9y5PjEERRqhdrvtTB0qj9I56kPZpjd45VzcWVMsRWWe067coeP3NCe+5xpKlS2E+/h
	RQVM0V0nxGUY6hvgEDvcR1ENUzX/jtFgCUmhHKLEXK/XG7zdEAXV3
X-Gm-Gg: ASbGncvPi+uoA1yeH0rNPcg5Hrn4rt3BvM/mqeN5evccDerC/I94yCSYyJT8dZjiilb
	ONwxk2jQissptHTvxSfMlQt3Z1wdqngXWsjyLvYkQPF32ouPjrbWCNIqvBBeG/UuPoY2DvOKXzU
	JGL4gTIFyVuLdKUaR9DvQf+oZ6zU6AAzvMiC+EBVLgVHc2UCB73YSQefyZ2BOxdkspZaYj8Szgz
	R1cbUNecdcrLLVmFbNtrWBT8+vMQr8WEmdwXwLiQ8KBnqdQGo7/WljnbbWQfemKmqav88m90SdK
	yFHF5ipiM99rHY9S7dTWGKbH02tiuZV36DFZ+6E65nsRn5JlCbXXs8HIkOJAvUx7DmETFhuwCg=
	=
X-Received: by 2002:a05:600c:1c96:b0:45b:7608:3ca5 with SMTP id 5b1f17b1804b1-45b761d6183mr63569455e9.6.1756465000393;
        Fri, 29 Aug 2025 03:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVwvGfPI/MYjQRGZTZ+NOvbRfl9s4GjAwqHmXYox48PYZsps29gxhwdHfvLN5DCLN/+ixVg==
X-Received: by 2002:a05:600c:1c96:b0:45b:7608:3ca5 with SMTP id 5b1f17b1804b1-45b761d6183mr63569115e9.6.1756464999966;
        Fri, 29 Aug 2025 03:56:39 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e887fdcsm33676505e9.13.2025.08.29.03.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 03:56:39 -0700 (PDT)
Message-ID: <9a1973bf-88d7-4270-b979-d3ea0280a80b@redhat.com>
Date: Fri, 29 Aug 2025 12:56:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpf/helpers: bpf_strnstr: Exact match
 length
To: Rong Tao <rtoax@foxmail.com>, andrii.nakryiko@gmail.com, ast@kernel.org,
 daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756433400.git.rongtao@cestc.cn>
 <tencent_CBD40091C14056E8298BE3725B65EE156405@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_CBD40091C14056E8298BE3725B65EE156405@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 04:12, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> strnstr should not treat the ending '\0' of s2 as a matching character
> if the parameter 'len' equal to s2 string length, for example:

A good catch, thanks!

But this doesn't fix just the `len == strlen(s2)` case but a more
general case when s2 is a suffix of the first len characters of s1,
right? The commit message should reflect that.

> 
>     1. bpf_strnstr("openat", "open", 4) = -ENOENT
>     2. bpf_strnstr("openat", "open", 5) = 0
> 
> This patch makes (1) return 0, indicating a successful match.
> 
> Fixes: e91370550f1f ("bpf: Add kfuncs for read-only string operations")
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..bf04881f96ec 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3672,10 +3672,18 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
>  
>  	guard(pagefault)();
>  	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
>  			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
>  			if (c2 == '\0')
>  				return i;
> +			/**
> +			 * corner case i+j==len to ensure that we matched
> +			 * entire s2. for example, param len=3:
> +			 *     s1: A B C D E F  -> i==1
> +			 *     s2:   B C D      -> j==2
> +			 */

This is not really a good example as it's not clear whether D is a null
byte or not. How about something like:

/**
 * We allow reading an extra byte from s2 (note the
 * `i + j <= len` above) to cover the case when s2 is
 * a suffix of the first len chars of s1.
 */

> +			if (i + j == len)
> +				break;

Viktor

>  			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
>  			if (c1 == '\0')
>  				return -ENOENT;


