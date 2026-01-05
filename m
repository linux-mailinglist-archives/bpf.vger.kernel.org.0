Return-Path: <bpf+bounces-77882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6ACF5A5D
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614CF30215FA
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584C2E1747;
	Mon,  5 Jan 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1IacCar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE2DEA78
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648052; cv=none; b=rR6QtZirN3S51Edc0BYSxg4zLOBmbWNpOJdABBy2bq9eBKMVwttP4YiZG13BzoD8DkOFW4oyeeEwJfAc/jl+9oe6IBAOvl2fL4b5jlyxWiaUKlm8XLcNTnghmOxfm95Spu0BtbddbtsE1RZNaKGuR+5ZByJ6Y1YQEs6rfrrGRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648052; c=relaxed/simple;
	bh=cJ4SIFLWKj05E2hxPipUk9CWXFpXh7zhvoeRkSYtiU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBKvqzsGc+CnpV4ZgySTo3fagfSpeNMWJGwAD5VP0wd7Tl08kTsBUD7tbxMS4wJ4q2KuJ4s4B6CzpcjVcvIF8zkcBoZiqbvN/rbr4tN/6tliQwu3j7e2GbVRLhmmVYBLAzB73ugJaxe80OQfIvnVYJOBQv/g2AYli73j6cLAvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1IacCar; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a099233e8dso3399475ad.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767648049; x=1768252849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGz9TDVdhRAHRG+zs1CaWP8ccI+nl/EcBr597+qWjvo=;
        b=O1IacCarSOIxty6IyNEiZcn7UPt2WdaG0sIXE1GlBm5c8UVrzVwv9WKVBwMj04SO/k
         3a7wxJ24thPfDoN7ixDeMO5o18hGxb+WX8NXFtvn+sX6Z5XQbRSd+Yp/bVXVYWF5z4XK
         Eq4UkuYXFcZu6rPjBkz5p4tE73lB9aIfH4sR62xwQSH+0whbJwbTrHZm1kq2e5okc6MB
         kiJUTmFHX+noQc8r9gO2Jkdcj4+9rV8265zU78JyFDqxPQyMlz/fbGjrKYMi+v8BRDa6
         huDHsj2TWV59cTS/8KsebZIMBvRCYBnHpd9iI/ZZKKfc3vJ1PM2TqAV0jiPVz3I5Z2us
         4OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767648049; x=1768252849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGz9TDVdhRAHRG+zs1CaWP8ccI+nl/EcBr597+qWjvo=;
        b=c2gvkeIw0jB1xUeK0axX3lf9CXuO07DcFwPhOfnEJ2i4qVej09B3k+4HR+IfF1IGB+
         h/hnjyqVE+Rff1g4H+7UkM+wsIgcbJi9+k4o0EN1w8Ow9rt9lcxMW5ONTBhv8kYkukn4
         hmXFIoFoRDSqlhAzkOIN9GlFwMQiCXtZMQGOJsmor+cMRec9Cl2sBwmNONJl8cNbyfa8
         msFylxqB8LkjFM0TUHOvYXAPbVc009qt6IarJ57yYJyQ29CsRf1tH8f1UAQAIpIJWHcL
         yoVRTGExaDpqUc3ohjPJo4uT48USufS1SXMpVKbm7fw2iGlS8b2U/TEYZmAWk/o/44/O
         BMfA==
X-Forwarded-Encrypted: i=1; AJvYcCXq0GahtEjqhQPamhpL/FqfK+sfz7TO0D1Th/+e4FKDIHVmWYGi67Kw1M6dd31pbSKQHck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQspWi4XxoPzBpB+m7SKjEm1vg3i1tztFcjcF3IgV/7a+0xqWw
	HziPt5uPzBVRTTZsC9S1AoP90HK4ZNCNjjlYFW/IV39ZjQaJMSL/3W48csGMiQG1cXjZCDuCypJ
	PkUQt42UN3FO0Eza/9RRHE4tkYywlJjU=
X-Gm-Gg: AY/fxX5PbyOmAZd/YBdUYN52UHQTXAjO+8NjXrj1cslb+vhLegoHom89jEVOzcQu+Al
	sp3wjqTn9mpG7grnNDbdtzsXAEQEBoBlwiMMslkpf2drXedORHDR+zwF0Cie4ylklfz4odxq7bQ
	EACwSF9Hkgm+SLXYswHi2tvczYR0+tPc/X+VsS2OOdlgmf/qZtskFxRFCgP04radLSd9TF99dcY
	IIkgdK2j88vmQ6hw86g9vYCLybH7zG2hv2UqYmTwP413K1qzHOaAzjtJMHyRDIwvJtCsfjFR+0Z
	PLJn5B5hm44=
X-Google-Smtp-Source: AGHT+IFxmIe3a2bsMaqKV9urz9MApx2Syw1asewDMpJomBHMGq8jiL5EYLkJS3DA9UD9bsHo93vAtO/24D5zMpGFuwQ=
X-Received: by 2002:a17:90b:51c8:b0:341:c964:125b with SMTP id
 98e67ed59e1d1-34f5f32f46emr457365a91.31.1767648048687; Mon, 05 Jan 2026
 13:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 13:20:36 -0800
X-Gm-Features: AQt7F2rwF4jOrJ9-nA8jVYp4TSYVKJ_sdhFf-iW48cgaWwfokSo5si1CdlRZ76Q
Message-ID: <CAEf4BzbCyMWr5tq5i45SB3jPvUFd4zOAYwJG3KBBeaoWmEq8kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Hi, all.
>
> No changes in this version, just a rebase to deal with conflicts.
>
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
>
> Session cookie is also supported with the kfunc bpf_fsession_cookie().
> In order to limit the stack usage, we limit the maximum number of cookies
> to 4.
>
> kfunc design
> ------------
> The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are
> introduced, and they are both inlined in the verifier.
>
> In current solution, we can't reuse the existing bpf_session_cookie() and
> bpf_session_is_return(), as their prototype is different from
> bpf_fsession_is_return() and bpf_fsession_cookie(). In
> bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> the cookie. However, the prototype of bpf_session_cookie() is "void".

How critical is it to inline bpf_session_is_return() and
bpf_session_cookie()? they are not inlined for ksessions, and it's
fine (at least for now). Are we micro-optimizing too early here?

>
> Maybe it's possible to reuse the existing bpf_session_cookie() and
> bpf_session_is_return(). First, we move the nr_regs from stack to struct
> bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the sessio=
n
> cookies as flexible array in bpf_tramp_run_ctx like this:
>     struct bpf_tramp_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         u64 bpf_cookie;
>         struct bpf_run_ctx *saved_run_ctx;
>         u64 func_meta; /* nr_args, cookie_index, etc */
>         u64 fsession_cookies[];
>     };
>
> The problem of this approach is that we can't inlined the bpf helper
> anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
> we can't use the "current" in BPF assembly.
>

We can, as Alexei suggested on your other patch set. Is this still a
valid concern?

I think having separate duplicated ksession and fsession specific
bpf_[f]session_{is_return,session_cookie}() APIs is really bad and
confusing long-term.

> So maybe it's better to use the new kfunc for now? And I'm analyzing that

there is no "for now", this decision will be with us for a really long time=
...

> if it is possible to inline "current" in verifier. Maybe we can convert t=
o
> the solution above if it success.
>
> architecture
> ------------
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
>
> Changes since v5:
> * No changes in this version, just a rebase to deal with conflicts.
>
> Changes since v4:
> * use fsession terminology consistently in all patches
> * 1st patch:
>   - use more explicit way in __bpf_trampoline_link_prog()
> * 4th patch:
>   - remove "cookie_cnt" in struct bpf_trampoline
> * 6th patch:
>   - rename nr_regs to func_md
>   - define cookie_off in a new line
> * 7th patch:
>   - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>     BPF_RAW_TRACEPOINT_OPEN
>
> Changes since v3:
> * instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> * introduce the 2nd patch to reuse the nr_args field in the stack to
>   store all the information we need(except the session cookies).
> * limit the maximum number of cookies to 4.
> * remove the logic to skip fexit if the fentry return non-zero.
>
> Changes since v2:
> * squeeze some patches:
>   - the 2 patches for the kfunc bpf_tracing_is_exit() and
>     bpf_fsession_cookie() are merged into the second patch.
>   - the testcases for fsession are also squeezed.
>
> * fix the CI error by move the testcase for bpf_get_func_ip to
>   fsession_test.c
>
> Changes since v1:
> * session cookie support.
>   In this version, session cookie is implemented, and the kfunc
>   bpf_fsession_cookie() is added.
>
> * restructure the layout of the stack.
>   In this version, the session stuff that stored in the stack is changed,
>   and we locate them after the return value to not break
>   bpf_get_func_ip().
>
> * testcase enhancement.
>   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
>   the testcase for get_func_ip and session cookie is added too.
>
> Menglong Dong (10):
>   bpf: add fsession support
>   bpf: use last 8-bits for the nr_args in trampoline
>   bpf: add the kfunc bpf_fsession_is_return
>   bpf: add the kfunc bpf_fsession_cookie
>   bpf,x86: introduce emit_st_r0_imm64() for trampoline
>   bpf,x86: add fsession support for x86_64
>   libbpf: add fsession support
>   selftests/bpf: add testcases for fsession
>   selftests/bpf: add testcases for fsession cookie
>   selftests/bpf: test fsession mixed with fentry and fexit
>
>  arch/x86/net/bpf_jit_comp.c                   |  48 ++++-
>  include/linux/bpf.h                           |  37 ++++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  53 ++++-
>  kernel/bpf/verifier.c                         |  76 +++++--
>  kernel/trace/bpf_trace.c                      |  56 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
>  17 files changed, 572 insertions(+), 42 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
>
> --
> 2.52.0
>

