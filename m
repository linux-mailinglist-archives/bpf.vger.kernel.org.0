Return-Path: <bpf+bounces-17998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC28814A6B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 15:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D01B229AE
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AEE31A67;
	Fri, 15 Dec 2023 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex5ai04a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F4315B2
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so3846195e9.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702650264; x=1703255064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF4d8UBqrKPRAj3OMRgWtldkHb3vMQbyxPxK9MVLp6k=;
        b=ex5ai04aNXuka0SkuwfIDRdnoYJxqA8BGbVkq7PYAvg3YSj4Aj2i/tTyNL3A+/yW0E
         vd85kFWEKi4pJjx51zaCTXCj8H9p4/Wm+7jLGWoZizQFrf1SZ+UqC4QzfaBMPo1TbxLH
         tFLV4b5Ni9R8PIbX4MukYES57iPZctB6kVbaA2BK4xMXMdcGYWkbMT1t25T+HwpwnYKs
         tlgpkGCgZ6QtmpGn7Nrlu4VKI/gsJZ8TQrfBXtUfWahtJIx5FY31Fu23BVHH+cDwBfWD
         kBCTqyrLXHTI7bxwOahkLTDDWsPpPJBzGDzEHpE/9PHBc2yUgN/kKqRbFgWFoFH+uMua
         QudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650264; x=1703255064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF4d8UBqrKPRAj3OMRgWtldkHb3vMQbyxPxK9MVLp6k=;
        b=nN6i7tgbakJ/7dThiHzGP+qHR9ypAyD+BOHXPhIK3gBaJZnnig0+F9hZWXkBFI4iGd
         HTjvxAgBgSMQBjNd5M/ZT0MST+W8aXdmMV3cofsl3tCQQqiY2kC+VH9w5yvvTSjplv8O
         Aqyj+6NiS5akPqK6GUYceNn9aZ0NGSoahkmIv7qowKBex/IylCnqC6wVEuSeKptHxXSu
         tJbWCsuQXT45pO5U35Zf4SideANk2vKgiQ5HwJ8beeKuzJ1BjSP0b9V7loEadmgAAirc
         vHbwDxKhwQ0RKXzOEmOzVnMCs4C88M+5A9OpNBEH6btJO/6jG9w2PMcjDTID11BLUiXl
         8IKg==
X-Gm-Message-State: AOJu0YwSxKg+O9QIG24wK4LX7bhVlpz0Lsi+Tjh15Cy8D7AzZxKPl5rv
	hcMZwbRZxf31PGmjNQcxQRs=
X-Google-Smtp-Source: AGHT+IHpBCdTr2dFrFvXCKwSWWxlM+rN5dZg9Zcjv0GEkpi9hwrLOK51qrVdVTi1HW2h3VumxEmgRA==
X-Received: by 2002:a05:600c:4f41:b0:40c:2d74:b9b with SMTP id m1-20020a05600c4f4100b0040c2d740b9bmr5789111wmq.24.1702650263386;
        Fri, 15 Dec 2023 06:24:23 -0800 (PST)
Received: from krava ([83.240.61.143])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d60cf000000b0033635ee4543sm8499046wrt.67.2023.12.15.06.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:24:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 15:24:20 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [RFC] bpf: Issue with bpf_fentry_test7 call
Message-ID: <ZXxhlG2gndCZ71Ox@krava>
References: <ZXwZa_eK7bWXjJk7@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXwZa_eK7bWXjJk7@krava>

On Fri, Dec 15, 2023 at 10:16:27AM +0100, Jiri Olsa wrote:
> hi,   
> The bpf CI is broken due to clang emitting 2 functions for
> bpf_fentry_test7:
> 
>   # cat available_filter_functions | grep bpf_fentry_test7
>   bpf_fentry_test7
>   bpf_fentry_test7.specialized.1
> 
> The tests attach to 'bpf_fentry_test7' while the function with
> '.specialized.1' suffix is executed in bpf_prog_test_run_tracing.
> 
> It looks like clang optimalization that comes from passing 0
> as argument and returning it directly in bpf_fentry_test7.
> 
> I'm not sure there's a way to disable this, so far I came
> up with solution below that passes real pointer, but I think
> that was not the original intention for the test.
> 
> We had issue with this function back in august:
>   32337c0a2824 bpf: Prevent inlining of bpf_fentry_test7()
> 
> I'm not sure why it started to show now? was clang updated for CI?
> 
> I'll try to find out more, but any clang ideas are welcome ;-)
> 
> thanks,
> jirka


hm, there seems to be fix in bpf-next for this one:

  b16904fd9f01 bpf: Fix a few selftest failures due to llvm18 change

jirka

> 
> 
> ---
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index c9fdcc5cdce1..33208eec9361 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
>  int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>  {
>  	asm volatile ("");
> -	return (long)arg;
> +	return 0;
>  }
>  
>  int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
> @@ -668,7 +668,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>  		    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
>  		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
>  		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
> -		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
> +		    bpf_fentry_test7(&arg) != 0 ||
>  		    bpf_fentry_test8(&arg) != 0 ||
>  		    bpf_fentry_test9(&retval) != 0)
>  			goto out;
> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
> index 52a550d281d9..95c5c34ccaa8 100644
> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
> @@ -64,7 +64,7 @@ __u64 test7_result = 0;
>  SEC("fentry/bpf_fentry_test7")
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
> -	if (!arg)
> +	if (arg)
>  		test7_result = 1;
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
> index 8f1ccb7302e1..ffb30236ca02 100644
> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> @@ -65,7 +65,7 @@ __u64 test7_result = 0;
>  SEC("fexit/bpf_fentry_test7")
>  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
>  {
> -	if (!arg)
> +	if (arg)
>  		test7_result = 1;
>  	return 0;
>  }

