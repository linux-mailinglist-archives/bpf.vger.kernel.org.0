Return-Path: <bpf+bounces-52286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7274A4117A
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB2B1897172
	for <lists+bpf@lfdr.de>; Sun, 23 Feb 2025 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1D22D7BF;
	Sun, 23 Feb 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWEAHpmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CB22A7F1;
	Sun, 23 Feb 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341540; cv=none; b=avLvjxzY4yuwrTKci2408Ilv7/ULMUDQydPpR8HCYsQp35UwRI5uwwCmrQo5XYJ1KoeXN80mmywdwcHzP4CgF0gqqDGCTGF4z2YmzuJK+rvjCGzCUsN2U2y1IoMp/oKDJkMUzKkLmOh80uTvWatU/c0NKW525wBNIgRPI3k2SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341540; c=relaxed/simple;
	bh=vX8Ya+KRy6BBDgOwYiAz6EXekliAEVM1yoFsb90n0SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSm3MH2jbihT1O8Qh8KEkMwHLG9NkRQZif89jxYPjRfn5PYiPHqD5eLh2lzI75iRbmSy7oAsOUZ277wBYHxiXPH6tuHxH6BGm/+V4SaAoxRpffmdc2Ot1DijM8hjk1eqpLStOUZWmOAH1q2C+BaNHlaCLldC6jrkSb3qyhtTrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWEAHpmE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so1779100f8f.0;
        Sun, 23 Feb 2025 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740341534; x=1740946334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW3EGNHGBVwdzGVDV9AF13cHQzdwAkoEvEWI4Vq3eqM=;
        b=KWEAHpmE06a7u34LJvuLxpgRojz0WJPYsM7uyO32Ls2mJFlLAsHb0NnrudczakgIhv
         lAuSjv+dTu5a54FzVDhRlEcJjU39FQbkAms4yvRDPhSuTrfhu3TcC+OX9qxh9OvXC6Ig
         7zZoNWnGT3S+JOJYGt5TwXt/nxzYn5a60TAOtncnuVIi70eFeInJg9CBzhawR53nInsA
         fFlAAlmeEWTJ6/jJZ4WVWNUv6d77r8WFMCDQ+TeWJRoXoxHXI4cGC1vC6QKl5bkzn5iV
         cAZPApV1lONyIxYum6BgXWOnu9o22y6w8N0QvILEnyOGksWp2QOg+d6X+w8QxQyPgyCp
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341534; x=1740946334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW3EGNHGBVwdzGVDV9AF13cHQzdwAkoEvEWI4Vq3eqM=;
        b=WZvlm1YIvdfQGM10KLnA+0ACe/bA92XVY8FvDqVsDTwtM9uj6zKa6wA+JEqhqMp5i/
         7ltD4Y2DIhNokahrUZIoANmmWdovAsYAn4ujcECpeNrOoKsVjDKmDtX89zGFp3cYOYoK
         Sc+ze9XCzbO5SBgq1hnGBZq5AMKjhRATOOb3lB0TX9NEgi0zHeJxTJUSzyrIdJeJQbUX
         zbeuLiCg5jmNwe+nczC5mWTUJTsY28Q9jzXMOBYK+oFeraB7FT1zUIiyz4fxtiwbsGU7
         Czd2Bq/BzzkmR4aj71q+lmtVGByV9/iSJgQ0olrO1cqm4u3d7nmp0vPqypHWr++fEoML
         JTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD9PnjRr9TwqrI/nIIJESb5VKnLjEK/ADj+ab+dxgu7XcEbw/qNhS/7gpn7ma1vQ48a6Q=@vger.kernel.org, AJvYcCX3Kt7WwOeHLrbCN0v3WaEM7TWyWfCu63RLerRFYvbGybX/kHV7wFsCqxlxGyrP2I33j4ecK868LolRd8t/@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJadWheFh45JTUxiC+CZHJyY/qR4Ba7DOy5h5Jqcqr/Ro37ge
	8eulLxnQ/gi4Cuv7BY3f6dKdhRwPaeJwqiH/rDAm83A4ggzZKmI9M0ixnFJSTWPcYtpCvPXBjNo
	Q0b6QXy8bxrklg9ZkGy0/eYRkxfQ=
X-Gm-Gg: ASbGncuDwFPJ5bNR1XoTquuulwWnt3ThSaRuxyE15BZufK4jj++T+u3AqakllMrMyY0
	4gcNJM1rfta6wf1rcumwcfHyrfjwblv/xkYXucz6TX4RHSeTqGB2P05RST1wWjckaGJQdJrGtBg
	3FmspaHPMCx7kV6jrT2vRGqiQ=
X-Google-Smtp-Source: AGHT+IG+/XlXb7rqQe5vquYK74kvCvNc9daUw83jU+xH2SpRzKCEdrK1yZh43fi3UhmjSuCRxf12bINTKaE790ojOIk=
X-Received: by 2002:a5d:5f51:0:b0:38d:dffc:c133 with SMTP id
 ffacd0b85a97d-38f70827ad7mr9506619f8f.44.1740341533944; Sun, 23 Feb 2025
 12:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223062735.3341-1-laoar.shao@gmail.com> <20250223062735.3341-2-laoar.shao@gmail.com>
In-Reply-To: <20250223062735.3341-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Feb 2025 12:12:02 -0800
X-Gm-Features: AWEUYZmJzuHhC8v0_Ept6EdxtrA7qcjW3mM6hjpy14Sxfxpc4U9ytSUHV3NGJfw
Message-ID: <CAADnVQ+zLZKyrNGnGQDThasdS6cvM-FheN5Ttz23pF5ttbGasw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] objtool: Copy noreturns.h to include/linux
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 10:28=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> It will used by bpf to reject attaching fexit prog to functions
> annotated with __noreturn.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/noreturns.h               | 52 +++++++++++++++++++++++++
>  tools/objtool/Documentation/objtool.txt |  3 +-
>  tools/objtool/sync-check.sh             |  2 +
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/noreturns.h
>
> diff --git a/include/linux/noreturns.h b/include/linux/noreturns.h
> new file mode 100644
> index 000000000000..b2174894f9f7
> --- /dev/null
> +++ b/include/linux/noreturns.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This is a (sorted!) list of all known __noreturn functions in the ker=
nel.
> + * It's needed for objtool to properly reverse-engineer the control flow=
 graph.
> + *
> + * Yes, this is unfortunate.  A better solution is in the works.
> + */
> +NORETURN(__fortify_panic)
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)
> +NORETURN(__kunit_abort)
> +NORETURN(__module_put_and_kthread_exit)
> +NORETURN(__stack_chk_fail)
> +NORETURN(__tdx_hypercall_failed)
> +NORETURN(__ubsan_handle_builtin_unreachable)
> +NORETURN(__x64_sys_exit)
> +NORETURN(__x64_sys_exit_group)
> +NORETURN(arch_cpu_idle_dead)
> +NORETURN(bch2_trans_in_restart_error)
> +NORETURN(bch2_trans_restart_error)
> +NORETURN(bch2_trans_unlocked_error)
> +NORETURN(cpu_bringup_and_idle)
> +NORETURN(cpu_startup_entry)
> +NORETURN(do_exit)
> +NORETURN(do_group_exit)
> +NORETURN(do_task_dead)
> +NORETURN(ex_handler_msr_mce)
> +NORETURN(hlt_play_dead)
> +NORETURN(hv_ghcb_terminate)
> +NORETURN(kthread_complete_and_exit)
> +NORETURN(kthread_exit)
> +NORETURN(kunit_try_catch_throw)
> +NORETURN(machine_real_restart)
> +NORETURN(make_task_dead)
> +NORETURN(mpt_halt_firmware)
> +NORETURN(nmi_panic_self_stop)
> +NORETURN(panic)
> +NORETURN(panic_smp_self_stop)
> +NORETURN(rest_init)
> +NORETURN(rewind_stack_and_make_dead)
> +NORETURN(rust_begin_unwind)
> +NORETURN(rust_helper_BUG)
> +NORETURN(sev_es_terminate)
> +NORETURN(snp_abort)
> +NORETURN(start_kernel)
> +NORETURN(stop_this_cpu)
> +NORETURN(usercopy_abort)
> +NORETURN(x86_64_start_kernel)
> +NORETURN(x86_64_start_reservations)
> +NORETURN(xen_cpu_bringup_again)
> +NORETURN(xen_start_kernel)
> diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Docu=
mentation/objtool.txt
> index 7c3ee959b63c..70a878e4dc36 100644
> --- a/tools/objtool/Documentation/objtool.txt
> +++ b/tools/objtool/Documentation/objtool.txt
> @@ -326,7 +326,8 @@ the objtool maintainers.
>
>     The call from foo() to bar() doesn't return, but bar() is missing the
>     __noreturn annotation.  NOTE: In addition to annotating the function
> -   with __noreturn, please also add it to tools/objtool/noreturns.h.
> +   with __noreturn, please also add it to tools/objtool/noreturns.h and
> +   include/linux/noreturns.h.
>
>  4. file.o: warning: objtool: func(): can't find starting instruction
>     or
> diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
> index 81d120d05442..23b9813cd5e9 100755
> --- a/tools/objtool/sync-check.sh
> +++ b/tools/objtool/sync-check.sh
> @@ -17,6 +17,7 @@ arch/x86/include/asm/emulate_prefix.h
>  arch/x86/lib/x86-opcode-map.txt
>  arch/x86/tools/gen-insn-attr-x86.awk
>  include/linux/static_call_types.h
> +tools/objtool/noreturns.h
>  "
>
>  SYNC_CHECK_FILES=3D'
> @@ -24,6 +25,7 @@ arch/x86/include/asm/inat.h
>  arch/x86/include/asm/insn.h
>  arch/x86/lib/inat.c
>  arch/x86/lib/insn.c
> +include/linux/noreturns.h

The copy looks pointless.
Since we cannot rely on objtool let's just list all noreturn funcs
directly in BTF_SET_START(fexit_deny) in a single patch.
So all changes will be under kernel/bpf directory.

pw-bot: cr

