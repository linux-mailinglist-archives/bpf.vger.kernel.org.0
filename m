Return-Path: <bpf+bounces-15753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A257F6067
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 14:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C30B214CC
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C64625105;
	Thu, 23 Nov 2023 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="e5R0Q+3U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599B1B6
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 05:36:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b358f216dso5174425e9.1
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700746602; x=1701351402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVmbcGaNIXL8aPhcSQKopHvy0kj+YeN0D1gAuqtVTP0=;
        b=e5R0Q+3U57TdqbB3wGM0S9LGiQcqeSUa8zQGTWYGgWogZOty/ewe5qW/bnuCYV1rEG
         W1GwpNxpzx7slCBHgt4txQY4Wxbfwu7P72Mn7JhligHvtlo3q6Mp2n6i3d4eAK2OQq1n
         pbPO8D9gmIAJDsYr6MeQP9kKOYQuRK9woRk4ZnUcuakp7JLX9xTgSE33VVEBnF1RBHU4
         o1QNbdwdcI2xHflgASvNytJrtW4fXdxYngveucQgU3OF7X99kiTrak0+N7RRBa8Q5plC
         /V3SLdfh5c/UTZiNYAH7vrNXL6MWi4U7QZySM+2K+8SoAQ0dO/ZKXV2ytEXXJ1BDw4fA
         yTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746602; x=1701351402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVmbcGaNIXL8aPhcSQKopHvy0kj+YeN0D1gAuqtVTP0=;
        b=u7f5rPkBwXLsQCSDjXttYmpxePXaiZmvTswn+88q0V+sdiOJtB88sNWMGkc7qVzO1N
         newq4salr4Q0j+EqhWFS2OY68l0/6uWtNKaNrX0D9lyzYzu0OTf3fhYZ6hBnw+adfqEF
         e4v17peSsGBlOX/iotxfcL6Ef6OgfBS33A2TkcmJfAA6TtixPm9KGRUtfY8sZ4383iIf
         lzlvlI0ThNxyp8LYRd+9nu4GB0iV7txho/pvM3kxxshVmULbEipdeLaclTtuHC0FUskj
         mQ7iL51dWRi49a13DVWgTE/5CIBVovYMvu85XPVRlt1S6FwjEvyqA9YW9Pxd4WeBood/
         Q7IA==
X-Gm-Message-State: AOJu0Yzflv9mjOpGkkKi8/BuXxrrpGvC3CUBXKBD9Wk3b4VrjyhGXIyR
	pIMiUpQHC8lPcpNAMA3JoipK6A==
X-Google-Smtp-Source: AGHT+IHwYOTebGtQFQz4Wt9S1zkMf8J+zPRp7y92YMKabgzpweqrbYZ0DDcaed/l7Th51ElpkNOU4w==
X-Received: by 2002:a05:600c:1991:b0:401:daf2:2735 with SMTP id t17-20020a05600c199100b00401daf22735mr4343723wmq.31.1700746601703;
        Thu, 23 Nov 2023 05:36:41 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:9991:6fa:ae3e:f493? ([2a02:8011:e80c:0:9991:6fa:ae3e:f493])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4c9400b004064741f855sm1981688wmp.47.2023.11.23.05.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:36:41 -0800 (PST)
Message-ID: <402e2e7a-c01c-4aad-8ca2-0dd40282820e@isovalent.com>
Date: Thu, 23 Nov 2023 13:36:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: mark orphaned programs during
 prog show
Content-Language: en-GB
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
References: <20231122222335.1799186-1-sdf@google.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231122222335.1799186-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-22 22:23 UTC+0000 ~ Stanislav Fomichev <sdf@google.com>
> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> idr when the offloaded/bound netdev goes away. I was supposed to
> take a look and check in [0], but apparently I did not.
> 
> Martin points out it might be useful to keep it that way for
> observability sake, but we at least need to mark those programs as
> unusable.
> 
> Mark those programs as 'orphaned' and keep printing the list when
> we encounter ENODEV.
> 
> 0: unspec  tag 0000000000000000
>         xlated 0B  not jited  memlock 4096B orphaned
> 
> [0]: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
> 
> Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  tools/bpf/bpftool/prog.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 7ec4f5671e7a..a4f23692c187 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

> @@ -554,6 +555,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>  		printf("  memlock %sB", memlock);
>  	free(memlock);
>  
> +	if (orphaned)
> +		printf(" orphaned");

Please use a double space at the beginning of "  orphaned" here, this is
what we do elsewhere in bpftool to make the different fields easier to
dissociate visually (given that some contain multiple words).

Looks good otherwise. Thanks!

