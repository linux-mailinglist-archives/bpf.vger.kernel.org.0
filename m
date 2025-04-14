Return-Path: <bpf+bounces-55855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB190A87F8B
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 13:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D7E166447
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC12989AE;
	Mon, 14 Apr 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqSQbwAw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2F17A305;
	Mon, 14 Apr 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631282; cv=none; b=bVy23i9XeLto8dZjA0EOKtm7Jam+YKFnNwYpzZDCZszatLT3jzfQyRNWX7ShOLfe1gJTj56ORsGqb1VYagniR71Ej35/01IYvwPwk/c3Ag7mX+FZqh0T/bIlkm5Av0MKkzAk279gj2W2DsLa/xscZp3jEC9TOzJVW4qEEX4Dc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631282; c=relaxed/simple;
	bh=s7jkJAHUB4r4svTwfgwHyX8slcJ4MwPFj5TT5N+7+Ik=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jow2ltHF7B0YpqRf8I46w3Bo/lve24epHfmGlvnxTImu9A2pFN7MA2WolKyC3WNV1BUHy+jtWBGQDPDF0wKBbl9fnk2yMJlF1Sqr64MMUaki7AZTgZl3p0kMPyFbGufTlJcX0/xOfOyfwsVR46gSP/ZcAOZ5arrDZlKNAuO2X9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqSQbwAw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so36768195e9.1;
        Mon, 14 Apr 2025 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744631278; x=1745236078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gg46kXKghmlwR4V0VYttP7ydLE60NSEZU5k87GACm3g=;
        b=FqSQbwAwI86XoaRm4fnX++8u1gbXnMXaCjtC5vfqiHCse0NIrHb5jrDwm0YLcNQkLp
         AonGQPaZ1uu7XmY4mBLLD4Ch2qrJYpuPETs414uaj3SFzcFPHScywbhu9b1kuWmhsFFf
         tKFEUJn+A9lZMbapxDTajEZo1B40f6GvG23DbadeR626V7VChaNIijpNSBOgB3akd5mA
         +7eZFNAZvzkUVsLecg1PABXWyaNJ/t8wwmqZC3RltO5gjeqCfOGFS5HY9uZ9A0ty4FXw
         PfqgxPC0aRJOT1Si38/b5C/IVOKyapLB7VIqvMZHUHwSZnfG4isWEGQ54eELBZRBWXFt
         w4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744631278; x=1745236078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg46kXKghmlwR4V0VYttP7ydLE60NSEZU5k87GACm3g=;
        b=P9xf2tBGw0rC2MjcXToNog2iFY2vMAxkDYe4GMc8722FjqVmjG6+PbADrApzYMdOV6
         tHzKzLqSOPE+cUGgqoPm3+jzK+Z7VWyvQ20b3OCp+EidgH5KOngfAFUsmfFYmZpNbqou
         YVqQTVzTbgRKaGfUt8CTeG4OxMynGh0WTzvFWpNzFVGcKLYt8/vMWvSGoqZI0Fm5CZIL
         hJUcHO7j7IMy5WmGWeFVipwYIpwipTGzqvqATRdLpbUkzu7RXjBIPccVWxIK4HepeEqw
         JQjoo6ZH1xfCLeKwTGGQS3AnfyL+EUI2btkmOElmVVPQhzRMskWEJz1SkPIk1H8jcNU0
         B86Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0dUPq+RDWIn5B0BbHu+0Hh/nNH6MInU2SCFrWtQEXm4zpo0qbxjOnpy9W2WyjJO+yQpg=@vger.kernel.org, AJvYcCXQtCMdriC6GzTDcVFJNuQIlTGsVMJWKXNJdaCRF50t/EvD9MQFNJqPahtZgU5fRQieCUE07N+qdXvCuhku@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw+POETgtFnYtnixRNlDbKxei2ly/BJ0CxKL0ffrP6nvqOFfg
	kaSHvxUTBo2RTUc3V4sapTbAy6grq5qsykTYtZx86GUe2uwGzm3u
X-Gm-Gg: ASbGnctCpfFuuQ722aJrvBiYdtsuLdnsinF8Vzsx01KCbF3VVQcnDCia98Y3GHeSK7x
	mG7nd1uD/lJRXYehuhBc9g9vR1CBBLMEmlrw5ly16ZkVmwR8WuBhVU1sFUiTvJoKIH+Fe7Wx6y8
	sH/LQkGXhfPb5PeHmAfC3qpIfSi+00YYbXoaxorQonqLO+DpsXpfD9WHQ3HpsWnfp6jVoWQn35K
	pJ6VEFxu3zh1Lkml9EHcHqSe9COyfZ7W4l9EZBJXpWB1FfM2FlZQ8qhd5nBMfaHhsX8yFIYZ+Pr
	PUAeJeFV78AJ2b0w3/DBABRBB3AnJf4=
X-Google-Smtp-Source: AGHT+IFOgv5QME8CMQweMgkj4Ts4mnQDOQZLGLIxWRFWa6t3TzGiX+SGniEyCr5y450a1xdHFc1D+A==
X-Received: by 2002:a05:600c:1e09:b0:43e:b027:479a with SMTP id 5b1f17b1804b1-43f3a9593ffmr124705325e9.16.1744631278131;
        Mon, 14 Apr 2025 04:47:58 -0700 (PDT)
Received: from krava ([2a00:102a:4007:73e1:1681:405:90b2:869b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c817dsm171748715e9.23.2025.04.14.04.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:47:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Apr 2025 13:47:55 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	hengqi.chen@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: Add test for attaching
 kprobe with long event names
Message-ID: <Z_z161cpsaR2uQm3@krava>
References: <20250414093402.384872-1-yangfeng59949@163.com>
 <20250414093402.384872-4-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414093402.384872-4-yangfeng59949@163.com>

On Mon, Apr 14, 2025 at 05:34:02PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> This test verifies that attaching kprobe/kretprobe with long event names
> does not trigger EINVAL errors.
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  5 +++
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 ++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9b7f36f39c32..633b5eb4379b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -168,6 +168,39 @@ static void test_attach_uprobe_long_event_name(void)
>  	test_attach_probe_manual__destroy(skel);
>  }
>  
> +/* attach kprobe/kretprobe long event name testings */
> +static void test_attach_kprobe_long_event_name(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct bpf_link *kprobe_link, *kretprobe_link;
> +	struct test_attach_probe_manual *skel;
> +
> +	skel = test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
> +		return;
> +
> +	/* manual-attach kprobe/kretprobe */
> +	kprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
> +	kprobe_opts.retprobe = false;
> +	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
> +						      "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
> +						      &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_long_event_name"))
> +		goto cleanup;
> +	skel->links.handle_kprobe = kprobe_link;
> +
> +	kprobe_opts.retprobe = true;
> +	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
> +							 "bpf_kfunc_looooooooooooooooooooooooooooooong_name",
> +							 &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_long_event_name"))
> +		goto cleanup;
> +	skel->links.handle_kretprobe = kretprobe_link;
> +
> +cleanup:
> +	test_attach_probe_manual__destroy(skel);
> +}
> +
>  static void test_attach_probe_auto(struct test_attach_probe *skel)
>  {
>  	struct bpf_link *uprobe_err_link;
> @@ -371,6 +404,8 @@ void test_attach_probe(void)
>  
>  	if (test__start_subtest("uprobe-long_name"))
>  		test_attach_uprobe_long_event_name();
> +	if (test__start_subtest("kprobe-long_name"))
> +		test_attach_kprobe_long_event_name();
>  
>  cleanup:
>  	test_attach_probe__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index f38eaf0d35ef..439f6c2b2456 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1053,6 +1053,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
>  	return args->a;
>  }
>  
> +__bpf_kfunc void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void)
> +{
> +}

does it need to be a kfunc? IIUC it just needs to be a normal kernel/module function

jirka


> +
>  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -1093,6 +1097,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_SLEEPABL
>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_looooooooooooooooooooooooooooooong_name)
>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>  
>  static int bpf_testmod_ops_init(struct btf *btf)
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index b58817938deb..e5b833140418 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -159,4 +159,6 @@ void bpf_kfunc_trusted_task_test(struct task_struct *ptr) __ksym;
>  void bpf_kfunc_trusted_num_test(int *ptr) __ksym;
>  void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
>  
> +void bpf_kfunc_looooooooooooooooooooooooooooooong_name(void) __ksym;
> +
>  #endif /* _BPF_TESTMOD_KFUNC_H */
> -- 
> 2.43.0
> 

