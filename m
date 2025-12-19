Return-Path: <bpf+bounces-77084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D9CCE187
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25C703032FCA
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0171C21765B;
	Fri, 19 Dec 2025 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT6UF6ON"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64335DDAB
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105739; cv=none; b=MFpE4uogmvSJd/KBM7WrhRFpHchiQADw1hy23E9uSM0d51/SQR6sdNCo8FTsejifcbtj6H6SZMvbeIKWvS9yYBRpltLoYtuQ+A5zV3oK9AheTTwtXTyTIsKRpO9wRmL8IGYVjywFYOI6VhOOV6WxdGucu4vFZSHL3Mmb5DwcAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105739; c=relaxed/simple;
	bh=JP1E3U0Gzf5VQ6cl7Il6a+42qITte063Iy96oSwNP+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIbj6wfleF47KZShV1L9o1e/2E0468QM5aVkuaCJPyp7eFA+heFBIjsUgXIYYHM2CAoclt1vP7RIez0GRypymeCvOzpBjOq5/35O+PfnMjBju6p5XBIzEw3ebBhqfBreiaLO7TZRPyiHOTU2zSRMNX3iTe0zA3h49nVD6w1Yu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT6UF6ON; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9387df58cso2112000b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766105737; x=1766710537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dsp2WwBfETjCKui8ZIJDbgjocXF3AXwxdQY+2AXB/c=;
        b=bT6UF6ONm0o3za8p+9PBTDetpp0Zf8L/Zc+RyDdcRku8jVgRnngn1mXVakM1moYSmf
         qT+hy4JgoW/oewhLNIeiq1ACmIJ+vQ1Zw42CVXGlxK8LlFkRTR3ZBnpTxcdD6MJfF7Vd
         4xMHPat9eN5qW3Xt1elkxfG0H0xRz+IBViyVs8lN9vXhUvmKjoXNbicTQsdMep2ODnjX
         uLm2UAzMkBiK/LPEODpyO3WkSG7bN7vqPZQmtDP+w4KDovnbNqmhHZ9OoriDSwED/1yv
         Y6WvmuS2tAIHkhZOOqroXmklVMQRuWD56vf7s9qUwz+n9WZT4oUkro8kFzdkZMqdiKt+
         iAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766105737; x=1766710537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Dsp2WwBfETjCKui8ZIJDbgjocXF3AXwxdQY+2AXB/c=;
        b=r2CPF2CqUOnN64DREL+Jx3V3pMpI4NLijvq+J1SVGwMjYMYGZQ+T5KmBdV17CEb8bR
         et11zltSEkh5TNBdXVg1d0+ArCPpl4sFObNo1CP3dqXBxl5Fm6umxXZsv88GqGFY8ICV
         HzGTb75BzsFbWSuXvEtVzbSLy4Ts8sfVJPPsmUJqLAieSkol7Z81aXdph1cQLawlEvWw
         Gre0mj+BACTRuwL/rctTqSspykxCc1Tzbg7ddvipGfsL794xb9EaEKgTgLcA4T5BMl1Y
         CrA8QrPfjRpaA79bCzvcY4VkdLIhAJBSRbLOENHQFHViQNfEJGCa70jmeEuh73Kpw+/m
         jeuw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0AijUf0itX1X8oM2ZLL96Np5ofaLKCrPJxxOOf/4BGCSlm9vVPqBRxojAU5UsQfsVz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzDpUtD6NGE7IrecGLLVuALFWiqtk/44vP6d0t3dSXwd6S0a3
	vL6cDjVHZ9gd9WiFkhIymlETA9nq8V5NpEOb9Q2PQPdn47KlYMdUh9/oqxeOZvZKSnpTnwc+AJI
	lbICtIMPFOE08cjsSXRn1HVMN4N2FrLQ=
X-Gm-Gg: AY/fxX6mqpwvoagWinuwbEp0UxfE9QS5m+mbCHFtQ2KyLhR4C135p7anMLHeT+nqs4J
	izaKLajBCzWgtH/s0dqeZL2N6/ZAva/HIj76Pm2kjnnjmixvvBS5/IQrvN90yj/JCJKWPXubmFb
	1sG2i1F5+en07gyCQjjtVOrEvG2RiQMiOc3UGV/CJDj0hQVi701hYLRZoBRXd0POcIJGVQvkh93
	33Nf65aU7vxhBFxYAmx0vBkv7HTNAstYUL0Bm+J1YSjAo1/kN/O4fcKUGJH0atTxltM6UF5erUw
	iAz8xAqfMMg=
X-Google-Smtp-Source: AGHT+IG93jGTSDKVm8+Mm96QmwIh3k7UWIMS9J62DKLnhYbke2RgPKZ6ftaX1+BtSaHaWu0fSfmjzKvfs509tzQ7J0Y=
X-Received: by 2002:a05:6a20:4323:b0:35f:2293:877f with SMTP id
 adf61e73a8af0-376a8ebe36amr1329187637.33.1766105736577; Thu, 18 Dec 2025
 16:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:55:23 -0800
X-Gm-Features: AQt7F2pItVsQNLZFecdCNJrvgORyyY0sKKslQT65UU6kVXiOC7iVPrEPsPnhYMg
Message-ID: <CAEf4Bzb8oooWbxctuVhNPsziRBd1Fv9Y11-5TiEML8ckjrCt+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Hi, all.
>
> In this version, I combined Alexei and Andrii's advice, which makes the
> architecture specific code much simpler.
>
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
>
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Session cookie is also
> supported with the kfunc bpf_fsession_cookie(). In order to limit the
> stack usage, we limit the maximum number of cookies to 4.
>
> The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are both
> inlined in the verifier.

We have generic bpf_session_is_return() and bpf_session_cookie() (that
currently works for ksession), can't you just implement them for the
newly added program type instead of adding type-specific kfuncs?

>
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK. Maybe we can prohibit the usage of bpf_get_func_ret()
> in the fentry in verifier, which can make the architecture specific code
> simpler.
>
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned i=
f
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
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
> Menglong Dong (9):
>   bpf: add tracing session support
>   bpf: use last 8-bits for the nr_args in trampoline
>   bpf: add the kfunc bpf_fsession_is_return
>   bpf: add the kfunc bpf_fsession_cookie
>   bpf,x86: introduce emit_st_r0_imm64() for trampoline
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: add testcases for tracing session
>   selftests/bpf: test fsession mixed with fentry and fexit
>
>  arch/x86/net/bpf_jit_comp.c                   |  47 +++-
>  include/linux/bpf.h                           |  39 +++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  50 +++-
>  kernel/bpf/verifier.c                         |  75 ++++--
>  kernel/trace/bpf_trace.c                      |  56 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 226 ++++++++++++++++++
>  17 files changed, 571 insertions(+), 44 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
>
> --
> 2.52.0
>

