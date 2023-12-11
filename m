Return-Path: <bpf+bounces-17396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23D480C9CD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E4281E5B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CB3B7A9;
	Mon, 11 Dec 2023 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvAw4cuE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E9DF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c25973988so46720425e9.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297845; x=1702902645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4cJhFzjC8+j3oUxHH97gxDoE2G0Phu0klYF0+0STEk=;
        b=gvAw4cuEPq1DMkUYS473FER7JgGvrij+NSfojrlpU5FMed4GQAZ4eBzqSQ4dquy3F6
         fuSmyHHDZ6sSQI73nf/EXAWxstVDfhXqmO8NZQYw5P26K/jS6ke2h+j5WVJ7LM/sX5Fs
         Aru6zTUePMpwYFgYrabRkVOTu8Plbb8KU4gEYEzfRDY2Ud1eMAOiJP1TeFO32IGromBb
         InFqci74l8G/Sk6/0eGF3R6vZ9SGfGTSiXhl9n5j4L2eVgB/NXPNSxtgJW7BrCDkEZma
         zCYP1k5fkDqeQnGF2RSEdFaNGRTZlJuplgo4KxnMO5zESos8usTBV/XsiWIFDxnBqv5S
         ji8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297845; x=1702902645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4cJhFzjC8+j3oUxHH97gxDoE2G0Phu0klYF0+0STEk=;
        b=Al8fP7AxQ+TV3zYL0L77TypkLgTpuUzM0Y2DMUPgj6tx0B+1dvpBccsiMY9Un6vJ1X
         rcdlUF3L4Ipg2ywxV6Y5HIUUpnAKQuKsOxLU+phgih2QJZEpF1JehWDmEtRBXjU5zF+M
         XqkigQP6oIjw4c/EcOJKumdr+dy/tmXhvNoTGpMplcd3YoRHQIXiBAXumSE1Pmyusamn
         jzWS2oPUEkNaPA+d1LNTKXI/YELtsq34gzKtwlOXtiORPJdSV9YVKFsNIjfg4QOgt6Ia
         k7PLE7EV8wcPJEfkvpQfGio3eKbkiCKTB1g8Jq7gMOX5hRR7j4mbU6cb9Fj1Dm9DNcHr
         9Hmw==
X-Gm-Message-State: AOJu0YxXkKsQTt6OmhZwGu7Ar4Gm/yWgxfAcPrVnZKV629roTJG+zuL0
	VEmcuTgjF4inACHn9cXoKsE=
X-Google-Smtp-Source: AGHT+IGIrW8bJwcVc4D1roQ7BFROEPdipPYmhYFXOwB5jS2mhiiJ7v1UQ1CkKZpb3O0GAhdrRQxF6w==
X-Received: by 2002:a05:600c:331b:b0:40b:5e59:da79 with SMTP id q27-20020a05600c331b00b0040b5e59da79mr2262471wmp.140.1702297844602;
        Mon, 11 Dec 2023 04:30:44 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm15100757wms.30.2023.12.11.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:30:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:30:42 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: Test re-attachment fix
 for bpf_tracing_prog_attach
Message-ID: <ZXcAi9Hmdtu5Hfbh@krava>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-5-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208185557.8477-5-9erthalion6@gmail.com>

On Fri, Dec 08, 2023 at 07:55:56PM +0100, Dmitrii Dolgov wrote:
> Add a test case to verify the fix for "prog->aux->dst_trampoline and
> tgt_prog is NULL" branch in bpf_tracing_prog_attach. The sequence of
> events:
> 
> 1. load rawtp program
> 2. load fentry program with rawtp as target_fd
> 3. create tracing link for fentry program with target_fd = 0
> 4. repeat 3
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  .../bpf/prog_tests/recursive_attach.c         | 48 +++++++++++++++++++
>  .../bpf/progs/fentry_recursive_target.c       | 11 +++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> index 7248d0661ee9..6296bcf95481 100644
> --- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -67,3 +67,51 @@ void test_recursive_fentry_attach(void)
>  			fentry_recursive__destroy(tracing_chain[i]);
>  	}
>  }
> +
> +/*
> + * Test that a tracing prog reattachment (when we land in
> + * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
> + * bpf_tracing_prog_attach) does not lead to a crash due to missing attach_btf
> + */
> +void test_fentry_attach_btf_presence(void)
> +{
> +	struct fentry_recursive_target *target_skel = NULL;
> +	struct fentry_recursive *tracing_skel = NULL;
> +	struct bpf_program *prog;
> +	int err, link_fd, tgt_prog_fd;
> +
> +	target_skel = fentry_recursive_target__open_and_load();
> +	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
> +		goto close_prog;
> +
> +	tracing_skel = fentry_recursive__open();
> +	if (!ASSERT_OK_PTR(tracing_skel, "fentry_recursive__open"))
> +		goto close_prog;
> +
> +	prog = tracing_skel->progs.recursive_attach;
> +	tgt_prog_fd = bpf_program__fd(target_skel->progs.fentry_target);
> +	err = bpf_program__set_attach_target(prog, tgt_prog_fd, "fentry_target");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto close_prog;
> +
> +	err = fentry_recursive__load(tracing_skel);
> +	if (!ASSERT_OK(err, "fentry_recursive__load"))
> +		goto close_prog;
> +
> +	LIBBPF_OPTS(bpf_link_create_opts, link_opts);

we don't need link_opts, you can pass NULL to below bpf_link_create call

> +
> +	link_fd = bpf_link_create(bpf_program__fd(tracing_skel->progs.recursive_attach),
> +							  0, BPF_TRACE_FENTRY, &link_opts);

wrong indentation

> +	if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +		goto close_prog;
> +
> +	fentry_recursive__detach(tracing_skel);
> +
> +	err = fentry_recursive__attach(tracing_skel);
> +	if (!ASSERT_ERR(err, "fentry_recursive__attach"))
> +		goto close_prog;

no need to call goto in here, let's just have ASSERT_ERR without the if

> +
> +close_prog:
> +	fentry_recursive_target__destroy(target_skel);
> +	fentry_recursive__destroy(tracing_skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> index b6fb8ebd598d..f812d2de0c3c 100644
> --- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> +++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
> @@ -18,3 +18,14 @@ int BPF_PROG(test1, int a)
>  	test1_result = a == 1;
>  	return 0;
>  }
> +
> +/*
> + * Dummy bpf prog for testing attach_btf presence when attaching an fentry
> + * program.
> + */
> +SEC("raw_tp/sys_enter")
> +int BPF_PROG(fentry_target, struct pt_regs *regs, long id)
> +{
> +	test1_result = id == 1;

please remove test1_result

thanks,
jirka

> +	return 0;
> +}
> -- 
> 2.41.0
> 

