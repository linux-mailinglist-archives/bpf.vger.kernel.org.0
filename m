Return-Path: <bpf+bounces-56732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD1A9D3A6
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760461C00D41
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF9224250;
	Fri, 25 Apr 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df0dr2tZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B7224225;
	Fri, 25 Apr 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614708; cv=none; b=Hz5GmHOUsH+HqsDJYa3IyhZAbn4klt+m9vFA6/H8gMhUzN7KDoGMQJQSx7yuXz/jEq0RVskWZi2h14DCMpmWvFleWa8nQ+TRPq72libqBciiPID8eXjVht7/pFbwzLzZCJxQfXGrENK3k41u8ZKX7nAi4OdV6Sn1+ALQticB7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614708; c=relaxed/simple;
	bh=pxZfBu6NOh1K8xXdxxfWMYR0YDxFURGAeLYEV4Q5PUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTFnOc48uv1SSrnn3YR2wCMMoPonqRjsfGyPltpZa2q5FxhuNI8BSC2lYe183+h1JKli0mizMEPvVqvLaxN4LZJ0XtwgKXvsLWXbw/fVtmeJn2HK/nviFeJ49EZILJksJurZRC3R8fI6b0PDmIdMTHyjTD5Iz5Xo8FPASjipvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df0dr2tZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-309fac646adso933159a91.1;
        Fri, 25 Apr 2025 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745614706; x=1746219506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZITaaOyEhv72XP9ZJM0D0OjL0yMF9nleZR/L1t/NHA=;
        b=Df0dr2tZdF4kZfAV1mJrF7U1+6skeQrZosXJP/FO4F03mxQ9Jk/KZzK60Ez1HNBiUl
         S0uSIkw4WAYeVRiw0+vnrohmAln0K98nSzPsT0PA+oIdGwq3HeQ7fg3s7ATqgIhgQlDW
         xwdf8g8EExoIxn8dVkM8R3DTwxHXsxHyf5hxyBeA5uhWr5jfPG7gSBxX7O5CrByLwT4/
         Pzp+wq68BQLaBqZ9HXYBjDGWJl0Qa3TN9xpS5Aq35O6OSkTRLZ88h+TkHZF4q0lKKlfa
         QaDO9JUsF44fISKdjdffZzFgwQMxmI/deWRrLCo5toSW1sxwWT1TQHrdDWmtxDsSonnV
         ZvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614706; x=1746219506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZITaaOyEhv72XP9ZJM0D0OjL0yMF9nleZR/L1t/NHA=;
        b=oq3Kn8WRgtrR1bH/CgZQUqY14PPPed7m25GynInWUBN87NmdqqRTuyf9DE3r+s4pxZ
         MLJYOTlBMjgNCArD9t5XiS+r3SUhk8LY389lRi1cWYnOClFDeV/ON41k5nR7VGh7pdmF
         j+tu+tqYtibjtvDvI4hknMrEnAJEmSh/nGi1qQk5pqxLc/+fQk3Xkg8W7pR+zK+UC2uS
         UqAVxplrFr/tjdWnOopJ+y7UAoyl1S0tPTlpOLJpOK7AG4mrIAwmT2GKwVQkARrOOCLN
         3LMPpkIpmSf1h7kbkLyM+H/r5zJABrxZoKS476uuD7voQSQwzZRb6M1vnFOlfVrikyG5
         LoQg==
X-Forwarded-Encrypted: i=1; AJvYcCVY34z963MBcx3l0QdJE8uyO0oKbY4TBW9K4zj37cqSZFCmOle6kkUxYVlvHNG5zPXWhEI=@vger.kernel.org, AJvYcCXG+vbrhTHhPMRMk1QlAL04eGWnoH/tB0/B1kM+qyCqPv//w1zP2yyXhbKjszDG8xel+WTVBAJUMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8VxF3K1s0aO9ZsZoY9FqlSQwcUIHJ0zcHVwUMUQpkD7C/GPo
	ApjACosJpFgfaZfVofVjqvDdnSi8YexHCXNuF8Rosn7Fnoi04NAqt+uARHsszMaWDiLJBFJwWLc
	Mq4rRHo7ZOugHUKRVSqPM4ZA7e4ROKi9e
X-Gm-Gg: ASbGnctJqednUNncVekLurizE9gfrbjAGHo96wa3Rm879jQ+6Z2LNnSznsvdaLT0SVs
	7k0u4PsBkN6Qdc+5hy0kwotucYCrldD/OYuv/d8VrXgzzJ9+LFUDCWa+qAldZY3o2+rE69ph7s7
	0aygDarN622ImZrpnr83cojQUKv9h793IehMAz/IygxN4psESQ
X-Google-Smtp-Source: AGHT+IGrr46HR3K9gAlPQ4TJrHwGIted5H0CrcKy0b+MdxozDfpsBuTET1Pd7BuReH6q9kaA6mmzj1kfZRuIUa9mi88=
X-Received: by 2002:a17:90b:2749:b0:2fa:6793:e860 with SMTP id
 98e67ed59e1d1-309ee2c9ecemr11193183a91.0.1745614705955; Fri, 25 Apr 2025
 13:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 13:58:13 -0700
X-Gm-Features: ATxdqUHxEuP7_f52QC06XborETk_EUkhbkco5ZGcNaCGcTAM1uw7fg5hIEf6O0Y
Message-ID: <CAEf4BzYOdta8xmDBMm=SL++Q=dtiVJqYvQQnE8noh6wiPkkO4w@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 25, 2025 at 10:50=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >
> > On 25/04/2025 15:50, Alexei Starovoitov wrote:
> > > Hi All,
> > >
> > > Looks like pahole fails to deduplicate BTF when kernel and
> > > kernel module are built with gcc-14.
> > > I see this issue with various kernel .config-s on bpf and
> > > bpf-next trees.
> > > I tried pahole 1.28 and the latest master. Same issues.
> > >
> > > BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> > > When built with gcc-13 it has 454 types.
> > > So something is confusing dedup logic.
> > > Would be great if dedup experts can take a look,
> > > since this dedup issue is breaking a lot of selftests/bpf.
> > >
> > > Also vmlinux.h generated out of the kernel compiled with gcc-13
> > > and out of the kernel compiled with gcc-14 shows these differences:
> > >
> > > --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
> > > +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
> > > @@ -148815,7 +148815,6 @@
> > >  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
> > > hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> > >  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak =
__ksym;
> > >  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
> > > hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> > > -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
> > >  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
> > >  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
> > >  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
> > > @@ -148825,12 +148824,8 @@
> > >  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
> > >  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
> > > slice, u64 enq_flags) __weak __ksym;
> > >  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
> > > -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
> > > *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> > > __ksym;
> > > -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
> > > bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
> > >  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
> > > bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
> > >  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
> > > -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id=
,
> > > u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> > > -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
> > > *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> > > __ksym;
> > >  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u6=
4
> > > slice, u64 enq_flags) __weak __ksym;
> > >  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
> > > dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> > >  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
> > > struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
> > >
> > > gcc-14's kernel is clearly wrong.
> > > These 5 kfuncs still exist in the kernel.
> > > I manually checked there is no if __GNUC__ > 13 in the code.
> > > Also:
> > > nm bld/vmlinux|grep -w scx_bpf_consume
> > > ffffffff8159d4b0 T scx_bpf_consume
> > > ffffffff8120ea81 t scx_bpf_consume.cold
> > >
> > > I suspect the second issue is not related to the dedup problem.
> > > All 5 missing kfuncs have ".cold" optimized bodies.
> > > But ".cold" maybe a red herring, since
> > > nm bld/vmlinux|grep -w scx_bpf_dispatch
> > > ffffffff8159d020 T scx_bpf_dispatch
> > > ffffffff8120ea0f t scx_bpf_dispatch.cold
> > > but this kfunc is present in vmlinux14.h
> > >
> > > If it makes a difference I have these configs:
> > > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > > # CONFIG_DEBUG_INFO_REDUCED is not set
> > > CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> > > # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> > > # CONFIG_DEBUG_INFO_SPLIT is not set
> > > CONFIG_DEBUG_INFO_BTF=3Dy
> > > CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> > > CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> >
> > thanks for the report! I've just reproduced this now with gcc 14; my
> > initial theory was it might be DWARF5-related, but dedup issues occur
> > for modules with CONFIG_DEBUG_INFO_DWARF4=3Dy also. I'm seeing task_str=
uct
> > duplicates in module BTF among other things, so I will try and dig
> > further and report back when I find something. Like you I suspect the
>
> This is a bizarre case. I have a custom small tool that recursively
> traverses two parallel subgraphs of BTF types and prints anything that
> differs between them ([0]). (I had to disable distilled BTF to make
> use of this, the issue is present both with distilled BTF and
> without).
>
> I see that struct sock both in vmlinux and bpf_testmod.ko are
> *IDENTICAL*. There is no difference I could detect. So very weird. I'm
> thinking of bisecting, as this didn't happen before with exactly the
> same compiler and pahole, so this must be a kernel-side change.

Ok, so while you guys had fun chasing distilled BTF quirks... ;)

This is the commit introducing a regression:

eb0ece16027f ("Merge tag 'mm-stable-2025-03-30-16-52' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

Yes, it's a "merge commit", but there is a lot of code introduced in
it. Among it:

+ /*
+  * Use __typeof_unqual__() when available.
+  *
+  * XXX: Remove test for __CHECKER__ once
+  * sparse learns about __typeof_unqual__().
+  */
+ #if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
+ # define USE_TYPEOF_UNQUAL 1
+ #endif
+
+ /*
+  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
+  * operator when available, to return an unqualified type of the exp.
+  */
+ #if defined(USE_TYPEOF_UNQUAL)
+ # define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
+ #else
+ # define TYPEOF_UNQUAL(exp) __typeof__(exp)
+ #endif
+


And that's exactly what causes this divergence. Commenting out that
USE_TYPEOF_UNQUAL #define fixes issues.

As to why that causes a problem. I suspect __typeof_unqual__() changes
how GCC generates DWARF information within any given compilation unit
(CU). Libbpf's BTF dedup relies on a property that compiler won't have
duplicate definitions of exactly the same type (i.e., DWARF itself
can't have two `struct blah` definitions), without which it's not
possible to deduplicate entire clusters of self-referencing BTF types.
It seems like typeof_unqual breaks this somehow.

We need to compare DWARF with and without TYPEOF_UNQUAL and see what
the differences are and how we can prevent or accommodate them.

>
>   [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack
>
> > issues with missing kfuncs are different; may be an issue with our logi=
c
> > handling inconsistent functions getting confused by the .cold
> > components. But right now understanding dedup issues is the top priorit=
y.
> >
> > Alan

