Return-Path: <bpf+bounces-21973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B5F854C61
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A471D1C28068
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B55C604;
	Wed, 14 Feb 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="JpEw6dO6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A275BAC2
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923692; cv=none; b=D6MvaQanGDcOZ2o5Il0PSt85pyBJUOxLNSSAtyMNbWQmmlA4TsiZwVo8Ow42kQqmK533s08cI0uOlAsEECM13415WL2IoUBcSLDV3LsXthP47rNbrwGYWYL4CicW5dDbK97/9Erxg6kgxm2Z+rKGM4/QNhzy4wpT5zo1uDhabQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923692; c=relaxed/simple;
	bh=MSq1aHhyCOZwuB6HVLXhkIsc0Z/1YI2U6yTQBaiIqp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3gjfs8e+HTj04A5+Ql5qXqmRH8FobKPtyHFjorNJvz+ddAMjA3Sly/eM3l+swTvo/qnc3XCyNx8orQJoKzxzN6RLkCqSmdKLOJdHfUuuV7l20HBJGC38hT91DPnMXRAAcVf9GleuadH//xy7QhczRn4US+vj5P3owwVxUpIxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=JpEw6dO6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-411d253098eso10528455e9.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1707923688; x=1708528488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiPUoU/OSL+4s0/gfmeerSenEDwyaNer/qzbwOkxu3g=;
        b=JpEw6dO6iuIfqBWFCOko74cH15XuM1/st6UeI6vlR+HY9hlSoD4FH04zUMuODOEk9b
         fd0rttULK+rI5qLGcjGLGc++T8pvdiOLBIA7LaWSRXfHH4F4nj040RKPqng2m/2NmRZ4
         Frs0FvyQDHcDFZHk49/7KnvBARqBhYnIUpuDMjxaXQvnhhAwEdZoQ7WoKIpATXlWPuZ7
         KEo3W5MVgFROCMxmNr5R38seO2HtZ9/WBVb71R4oLmoIYFn19InzBAaPoeRzb3oXtydz
         dh30PyeGJvxZrIuqE/iq6nnACW/tL6ksskqaudiiwGNa4qzCPS4sz2aPY/H24VczQgHX
         3WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923688; x=1708528488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiPUoU/OSL+4s0/gfmeerSenEDwyaNer/qzbwOkxu3g=;
        b=ID74TZQkDN2ySChVe59qnMZ+cPR9O/7bR0HoDxshrOKwDkaSqGQra39jfnUjBun/S1
         8k6EcMtXaAfPKlYDsr2YfH/VcRnn0OV9DQfeV8ofTEnpSnyCdF8G6l+hOzOrU/37pU01
         40f5tdt/byyohB5sCiTR0OxaYdSljthO3ahIffvaUb3ZwshW0B1aIfgPLjZAXLC0h/T2
         XA+OE2Dot4S8NKlWsI71hA116WVL7sPi2dlZpO/BbTGH08JLIz6Zps04OzDB7gt4rz7L
         AKDC/gnkJQoiG60K43FNYATyIn+th8vsW/Pn3v75QFHDDkQjiEHlZmUN7/N7GkZrWY3z
         IZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWinGySBQuILih36gJ721bwx5DYkEdzlTMWk4lHFiUHMHiE+1LuUqG7bJh/hU+3OFKoeAVECCzn2pIbsghHXKaXwfGA
X-Gm-Message-State: AOJu0YwfxbCV8nb/UDslI8+oXtgvKP824H+15WYsbMsM1SXRggqphnR/
	c/iNsvkvSR5WN/DijeHwLTvj4mE86+QbrX6Q5LB2GMrDJm7JRnWZSLQi6dkFNKc=
X-Google-Smtp-Source: AGHT+IGEVz053KgocSLsMnqG2P0pn+W65e6jl9r1ASxuSK9ftBcG2FJaRGHvh2PfH1lRDJXA1UA5Vg==
X-Received: by 2002:adf:f285:0:b0:33b:63a5:feaf with SMTP id k5-20020adff285000000b0033b63a5feafmr1946972wro.20.1707923688231;
        Wed, 14 Feb 2024 07:14:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7xiIfn89urt5aSbJHCKWUeIhMcIDfy6bdDO+pIE3BC9PJTIUiWp71xaUHldy783YGwJz2ZQv6aLdzLdhd5AwgWS7SE3C9uM+OAM0mbX0vrurYxEH+R/jGFIxfathKcTOyKEHZ7q4XuWyuZN5lLeVdIfb/xjN1gRUwxGY8DIwuVrk8uM5OY0Wt2Z4R+h4zHFHDKo203H5cFim524OSqPvndw/usaGiqZh/Ys1U5x6Q8cuRx73EylGHqY1DnSlHGt/d10Iwkj8oo2clnK2op4vOdYEHzdWpDJZwEBoT4kOFa2YwATNEZKaWV0VzyOob13Xnx+VqNmlND/3AxQlOGtbMKr7NkpbCdsgvsBF7p22llEkNte7gSkMdDMFsXWJXzxirBfHPW9gf
Received: from ?IPV6:2a02:8011:e80c:0:bfa:fdd5:7522:6528? ([2a02:8011:e80c:0:bfa:fdd5:7522:6528])
        by smtp.gmail.com with ESMTPSA id u9-20020adfa189000000b0033cf35e8fd8sm779460wru.57.2024.02.14.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:14:47 -0800 (PST)
Message-ID: <5bb799e2-492b-49f2-b5f5-7e8f113bf56f@isovalent.com>
Date: Wed, 14 Feb 2024 15:14:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Corrected GPL license name
Content-Language: en-GB
To: Gianmarco Lusvardi <glusvardi@posteo.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240213230544.930018-3-glusvardi@posteo.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240213230544.930018-3-glusvardi@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-02-13 23:07 UTC+0000 ~ Gianmarco Lusvardi <glusvardi@posteo.net>
> The bpf_doc script refers to the GPL as the "GNU Privacy License".
> I strongly suspect that the author wanted to refer to the GNU General
> Public License, under which the Linux kernel is released, as, to the
> best of my knowledge, there is no license named "GNU Privacy License".
> 
> This patch corrects the license name in the script accordingly.
> 
> Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
> ---
>  scripts/bpf_doc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 61b7dddedc46..0669bac5e900 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -513,7 +513,7 @@ eBPF programs can have an associated license, passed along with the bytecode
>  instructions to the kernel when the programs are loaded. The format for that
>  string is identical to the one in use for kernel modules (Dual licenses, such
>  as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
> -programs that are compatible with the GNU Privacy License (GPL).
> +programs that are compatible with the GNU General Public License (GNU GPL).
>  
>  In order to use such helpers, the eBPF program must be loaded with the correct
>  license string passed (via **attr**) to the **bpf**\\ () system call, and this

Not sure how I came up with that one. Thanks for the fix!

Fixes: 56a092c89505 ("bpf: add script and prepare bpf.h for new helpers documentation")
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

