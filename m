Return-Path: <bpf+bounces-17982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D771D8144C7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D2D284127
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B21805D;
	Fri, 15 Dec 2023 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3/E7qr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1F1A702
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso426670a12.0
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633418; x=1703238218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EGJXOp+glQ4ydyicykgyTEsUsGW/ARXwXuh1I5VSdg=;
        b=FT3/E7qrfyzeWieoozUeTiLX0fsVT96umAHxDpoMNXyDmzBnR71VAHRgsT5WHI5hQs
         OZnqcsRRmtRgnLHto5j4JhaUtCDWKdMr0Fh2ouVMJMrEBOBnn3TYHqqE5UgdRc2yFLfA
         k1YaPgZfPRA51PhyMPV3kdSNOm/2/Z9T/7zOEydHMDn3OGcSS3ni8SsiYBwN057yKrMB
         ZULXlHLfiYfZTBjIklFAaBVnE06VMtD1CTHf0Dlm91GSp8ynVpCs/fS1yQbRngSooH6w
         AOO1gsIe69xL+E3oVYTPHW/I6vtNaUHs9y9teEX3hlDhGRCXazHj2YvJBR68vCXDZZkh
         SlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633418; x=1703238218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EGJXOp+glQ4ydyicykgyTEsUsGW/ARXwXuh1I5VSdg=;
        b=oPjs6ouzxbtd4iLKrzgF4y/vY/1WnTzfTMUc3q0bJZ/8yWI9C/UugRGLycJJmA1EN1
         BxSFuYImxL0hDgMg8ArK1lwDK2X+ri+crIhCdirTtx+P+w3npEOL5RvC/Lq2gX3tTG5z
         ReFprdtuIoe3RsKPHegmmxudlG48505eS8EleUVOUHu642dL/e4sEIfn8IJp0XVgQUol
         ubXvcBq09g1jj0l0YK0xD2GwknLs//OsZdjB7fjsRn9p/0PR6W6QYiW6z0e4brE2c/UQ
         uqRM2jWiwJZ/a5lm+GeewLmvHki3pj+GKukiGsp9ktw1G/mqJ/QRyHGcpUFhu+R/kSDZ
         O5Yg==
X-Gm-Message-State: AOJu0YwVZnQyaP0sVrlh8bzv/33hnlioR8OMnTOTVyhMUTb/nmrV1sQb
	w7MQNatwMPTs7OO9417GxC4=
X-Google-Smtp-Source: AGHT+IHd1dovmquicwsHI+Y+ySNozoasjRE/Y1hmmdMna2FP1oUxR7O4p7pdVwbSsDcQyQb9Op7EUQ==
X-Received: by 2002:a17:906:af72:b0:9fa:d1df:c2c4 with SMTP id os18-20020a170906af7200b009fad1dfc2c4mr11275984ejb.36.1702633418054;
        Fri, 15 Dec 2023 01:43:38 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ty6-20020a170907c70600b00a1d71c57cb1sm10595054ejc.68.2023.12.15.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:43:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 10:43:36 +0100
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
Message-ID: <ZXwfyNCkkP_iAzkG@krava>
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

fyi also there's probably another related usse in global_func17 test:

	run_subtest:FAIL:unexpected_load_success unexpected success: 0
	#290/17  test_global_funcs/global_func17:FAIL

looks like clang optimized the call out and returns the value directly:

	Disassembly of section .text:

	0000000000000000 <foo>:
	       0:       b4 00 00 00 00 00 00 00 w0 = 0x0
	       1:       15 01 02 00 00 00 00 00 if r1 == 0x0 goto +0x2 <LBB0_2>
	       2:       b4 00 00 00 2a 00 00 00 w0 = 0x2a
	       3:       63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0x0) = r0

	0000000000000020 <LBB0_2>:
	       4:       95 00 00 00 00 00 00 00 exit

	Disassembly of section tc:

	0000000000000000 <global_func17>:
	       0:       b4 00 00 00 2a 00 00 00 w0 = 0x2a
	       1:       95 00 00 00 00 00 00 00 exit

jirka


> 
> thanks,
> jirka
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

