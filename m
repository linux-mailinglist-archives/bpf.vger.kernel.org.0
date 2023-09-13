Return-Path: <bpf+bounces-9919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A679ECB7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807361C20C59
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4C31F19D;
	Wed, 13 Sep 2023 15:24:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F81EA8F
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 15:24:11 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9051BCD
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:24:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401b393df02so81123625e9.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618649; x=1695223449; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baHpW50dkMveffkb7Vo7hMO1ai/XWc+fuG4feY6+V6Q=;
        b=Fmfb1yvAmykXRzaT48EOgue2fgwC4bxB41D7JsX3OyMxJpt+/WNAAAClGnWj2TCRWi
         GL1uaA7bLeT81hACjxOpTdySQXnPorux7Gkuq8nvMJ55dGOGZACg4yB69ux1kmx3FSJH
         vJJSBZgJuij87AzBPyuaTeDPorunSTOI2IGi9M4aoTrVX64nLnW52r4tok2grxiIkGGy
         OrjKOXXU0aHxRJigUAAPKMugTbxsisWCDVrCaIVvUg4FqReyDsp+AyGwS3jr4jpaAIVy
         nJWdwtIkVq7oH/co6tPVNBTE1gM4JFVxi2wp+Ot/lydKhanl8NqCv7ThIogVVU3eZ1VQ
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618649; x=1695223449;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baHpW50dkMveffkb7Vo7hMO1ai/XWc+fuG4feY6+V6Q=;
        b=om/Lyx1kDCFVqjMHI0tFPqneDGJnNTkbq4pmC/VH+73LvF3dlUrLjKZ3hySP+BDQMO
         MECzbNtOzPkXoKecn5b03xTs6k9w7IPYCqGmTP6NX207c4TbLRsYJwrSIxnpPp/fwE+/
         3C0vTy+KAMJylJS7M+nGABSFgwXI4nixM6ozpgKwRE4s+frhnDDG4vYVQ4VhraFaPqz+
         iPHFD8BFmO/HeiBtgxkz6vGIq7E0OOkLqE/kwXUBOwI2gWbSGOgdDKaIOgqQgY3s4qjs
         +jotOGxc7L41qILFZUfOqJsKYBQxCwbfTFKQf/YnOaLzYEpyQCoJez4FeZJGgEK9aZv0
         A+/g==
X-Gm-Message-State: AOJu0YwH87w7As/cUPVev6yf1a/GCnK2cx+9PgqVG0dJ5rQIO8dSQu2q
	MxPIWBVf1nW/kltZVraIZf8=
X-Google-Smtp-Source: AGHT+IH4AxpKjT67K1XGWwwHsG6SKp3S7/GR3Ff/q5Odm0saeWqQgHIwEpg/NILg7FfxwUSSYsLKlg==
X-Received: by 2002:a7b:c8cb:0:b0:403:e21:1355 with SMTP id f11-20020a7bc8cb000000b004030e211355mr2251246wml.36.1694618649088;
        Wed, 13 Sep 2023 08:24:09 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4001000000b0031435731dfasm15699115wrp.35.2023.09.13.08.24.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:24:08 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Yonghong Song
 <yonghong.song@linux.dev>,  David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Disallow fentry/fexit/freplace
 for exception callbacks
References: <20230912233214.1518551-1-memxor@gmail.com>
	<20230912233214.1518551-13-memxor@gmail.com>
Date: Wed, 13 Sep 2023 15:24:07 +0000
In-Reply-To: <20230912233214.1518551-13-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Wed, 13 Sep 2023 01:32:09 +0200")
Message-ID: <mb61pmsxq14h4.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 13 2023, Kumar Kartikeya Dwivedi wrote:

> During testing, it was discovered that extensions to exception callbacks
> had no checks, upon running a testcase, the kernel ended up running off
> the end of a program having final call as bpf_throw, and hitting int3
> instructions.
>
> The reason is that while the default exception callback would have reset
> the stack frame to return back to the main program's caller, the
> replacing extension program will simply return back to bpf_throw, which
> will instead return back to the program and the program will continue
> execution, now in an undefined state where anything could happen.
>
> The way to support extensions to an exception callback would be to mark
> the BPF_PROG_TYPE_EXT main subprog as an exception_cb, and prevent it
> from calling bpf_throw. This would make the JIT produce a prologue that
> restores saved registers and reset the stack frame. But let's not do
> that until there is a concrete use case for this, and simply disallow
> this for now.
>
> Similar issues will exist for fentry and fexit cases, where trampoline
> saves data on the stack when invoking exception callback, which however
> will then end up resetting the stack frame, and on return, the fexit
> program will never will invoked as the return address points to the main
> program's caller in the kernel. Instead of additional complexity and
> back and forth between the two stacks to enable such a use case, simply
> forbid it.
>
> One key point here to note is that currently X86_TAIL_CALL_OFFSET didn't
> require any modifications, even though we emit instructions before the
> corresponding endbr64 instruction. This is because we ensure that a main
> subprog never serves as an exception callback, and therefore the
> exception callback (which will be a global subprog) can never serve as
> the tail call target, eliminating any discrepancies. However, once we
> support a BPF_PROG_TYPE_EXT to also act as an exception callback, it
> will end up requiring change to the tail call offset to account for the
> extra instructions. For simplicitly, tail calls could be disabled for
> such targets.
>
> Noting the above, it appears better to wait for a concrete use case
> before choosing to permit extension programs to replace exception
> callbacks.
>
> As a precaution, we disable fentry and fexit for exception callbacks as
> well.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/helpers.c  |  1 +
>  kernel/bpf/verifier.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2c8e1ee97b71..7ff2a42f1996 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2490,6 +2490,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	 */
>  	kasan_unpoison_task_stack_below((void *)ctx.sp);
>  	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
> +	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>  
>  __diag_pop();
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0ba32b626320..21e37e46d792 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19750,6 +19750,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Subprog %s doesn't exist\n", tname);
>  			return -EINVAL;
>  		}
> +		if (aux->func && aux->func[subprog]->aux->exception_cb) {
> +			bpf_log(log,
> +				"%s programs cannot attach to exception callback\n",
> +				prog_extension ? "Extension" : "FENTRY/FEXIT");
> +			return -EINVAL;
> +		}
>  		conservative = aux->func_info_aux[subprog].unreliable;
>  		if (prog_extension) {
>  			if (conservative) {
> @@ -19762,6 +19768,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  					"Extension programs should be JITed\n");
>  				return -EINVAL;
>  			}
> +			if (aux->func && aux->func[subprog]->aux->exception_cb) {
> +				bpf_log(log,
> +					"Extension programs cannot replace exception callback\n");
> +				return -EINVAL;
> +			}

This check is redundant because you already did this check above if (prog_extension branch)
Remove this as it will never be reached.


>  		}
>  		if (!tgt_prog->jited) {
>  			bpf_log(log, "Can attach to only JITed progs\n");


Thanks,
Puranjay

