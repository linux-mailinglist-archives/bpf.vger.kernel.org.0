Return-Path: <bpf+bounces-16281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491977FF346
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A321C20EC1
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999D51C55;
	Thu, 30 Nov 2023 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUQv958t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B310E3
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 07:14:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a00cbb83c80so154416466b.0
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357297; x=1701962097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYayEXRcOr/Ge0hVQdoowZCw8WeY4pGQPtDgJkx98nQ=;
        b=mUQv958tNLvjlspVO5lVPoUtxOYEyWmST/Ymq5++BTMq2dPlwJnkjS9W6iKrGcnbxG
         Cd7guk65jpHxx5PurzzEJCJKikFWKbJ4mQV1t0Fqezz1Q09hBhXlmJSflX8DDnNl8dnK
         5DfSp10tb0me4JymR1U1GMBdAMGBzsYtNmsoXvl95hSmEf3ydunAYW1ocJTVNSykKtUu
         3JP8mNlbtnKLNQWTsllp66cd/bvXlQYFCVPvN75E/SBiw7pMvBj6P2vgyZzXjl2tGorF
         T1iALA/TRuzX6eyx3/TgcLZJYzwMPHPTpu7pl84l7WARFJ7x5zRf5fV6p4rSr4Bmvu9a
         abhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357297; x=1701962097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYayEXRcOr/Ge0hVQdoowZCw8WeY4pGQPtDgJkx98nQ=;
        b=XoF8y3gXireDd2Wj7i6uDa8RPrOmZKnlam5qP3YUdvpW6LUQXl0fCFFYydnv9SgUwq
         /U08ZoL5IzUrri/VK0DnPP92LRGAJqSzslGmbcpLd0LpLBh2aRCyeDDCTJvmo5o3OOCw
         d3jEx/4apC0w+x4JAtyxoPHhJzZXzpn/qAoXlwmURbrL1DMfK2HGQVz2Hporvh3g03oQ
         uHsmOWYoEkkTL92eT8H8IGcE/hejVBBXgcwv0E1rrpT+HQH1wEo+MacapTnyeqwnzcp2
         Zjvtv94B4zj6uX3HEAYIwkApORQz5pz+crbNXdtxvTwWXK4EzoF2YsuhVoJoqQdftkiG
         8Umg==
X-Gm-Message-State: AOJu0YxqMepOp76ZBZIfigwqkThjdoDhug+bD5/fuHwz+hHonRZDh8NE
	3ozq8lxVU7sMDwtWlrDgdIw=
X-Google-Smtp-Source: AGHT+IHdlaIfUamvXsIX3zAwyg6dQKA6o9KUOcfTjRU9qA2zWdu2lrzPj1FWqs/CkLSShl7WiQdxqw==
X-Received: by 2002:a17:906:2082:b0:a18:65b8:ec3f with SMTP id 2-20020a170906208200b00a1865b8ec3fmr1871869ejq.50.1701357297397;
        Thu, 30 Nov 2023 07:14:57 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id gg6-20020a170906e28600b00a1848bc033csm769903ejb.128.2023.11.30.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:14:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Nov 2023 16:14:55 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v4 3/3] bpf, selftest/bpf: Fix re-attachment
 branch in bpf_tracing_prog_attach
Message-ID: <ZWim7zRLA-cgVQpr@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-4-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195240.19091-4-9erthalion6@gmail.com>

On Wed, Nov 29, 2023 at 08:52:38PM +0100, Dmitrii Dolgov wrote:
> It looks like there is an issue in bpf_tracing_prog_attach, in the
> "prog->aux->dst_trampoline and tgt_prog is NULL" case. One can construct
> a sequence of events when prog->aux->attach_btf will be NULL, and
> bpf_trampoline_compute_key will fail.
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000058
>     Call Trace:
>      <TASK>
>      ? __die+0x20/0x70
>      ? page_fault_oops+0x15b/0x430
>      ? fixup_exception+0x22/0x330
>      ? exc_page_fault+0x6f/0x170
>      ? asm_exc_page_fault+0x22/0x30
>      ? bpf_tracing_prog_attach+0x279/0x560
>      ? btf_obj_id+0x5/0x10
>      bpf_tracing_prog_attach+0x439/0x560
>      __sys_bpf+0x1cf4/0x2de0
>      __x64_sys_bpf+0x1c/0x30
>      do_syscall_64+0x41/0xf0
>      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> The issue seems to be not relevant to the previous changes with
> recursive tracing prog attach, because the reproducing test doesn't
> actually include recursive fentry attaching.
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  kernel/bpf/syscall.c                          |  4 +-
>  .../bpf/prog_tests/recursive_attach.c         | 48 +++++++++++++++++++
>  .../bpf/progs/fentry_recursive_target.c       | 11 +++++
>  3 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a595d7a62dbc..e01a949dfed7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3197,7 +3197,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  			goto out_unlock;
>  		}
>  		btf_id = prog->aux->attach_btf_id;
> -		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
> +		if (prog->aux->attach_btf)
> +			key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf,
> +											 btf_id);
>  	}

nice catch.. I'd think dst_trampoline would caught it, because the
program is loaded with attach_prog_fd=x and check_attach_btf_id should
create dst_trampoline.. hum

jirka

>  
>  	if (!prog->aux->dst_trampoline ||
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> index 9c422dd92c4e..a4abf1745e62 100644
> --- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -83,3 +83,51 @@ void test_recursive_fentry_attach(void)
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
> +
> +	link_fd = bpf_link_create(bpf_program__fd(tracing_skel->progs.recursive_attach),
> +							  0, BPF_TRACE_FENTRY, &link_opts);
> +	if (!ASSERT_GE(link_fd, 0, "link_fd"))
> +		goto close_prog;
> +
> +	fentry_recursive__detach(tracing_skel);
> +
> +	err = fentry_recursive__attach(tracing_skel);
> +	if (!ASSERT_ERR(err, "fentry_recursive__attach"))
> +		goto close_prog;
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
> +	return 0;
> +}
> -- 
> 2.41.0
> 

