Return-Path: <bpf+bounces-68615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D534B7C4D2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4386C327C74
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBE02FB0B1;
	Wed, 17 Sep 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXopivF1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ADF2FB09B
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080326; cv=none; b=C6WHMvdHm58NCbGZNuwUZfidY9SgT1CAj6KtNSTCAoa2IwDkrO4qgNKiegpGxUgI9a3+4gsv9wR/G9mz7ZFpIApfDOoQBdtXRnINNkudsbD//3z1srfDHZLop9+9vPMk0pOwSMpDSifdOWfNjY0n6gE1XERICc0WRNAdslThaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080326; c=relaxed/simple;
	bh=1W4zrBOgQSATW8K5f8c0Js9mDptdF+Hv8/elIOoq79U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo/+WsTSnL+3gX/z4s2CuU+w2qq+zHpfGzQ2P9m0sMhunz820mO5K6h4xNJVA9matLAejBYfa57VZlbd9Sj6bLBo0pvBQ1HmH5XfqRRwRDJ/oHqsyRN9EeBP8plMKfEC/l4cO8XT+4yTgaFPd4b/5AryFQ+RoRyVXrhTjkpa89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXopivF1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-724b9ba77d5so60958397b3.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758080323; x=1758685123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AORQstWDFZCpFiH2iyPZCHq7tnFpScQvnrRiQl4jgm0=;
        b=TXopivF1779I3rJryQIIvDZ6co0U04q0ODFZcyObsWnUN4caz42VaOc2n2ludTFjzi
         JWxOlf8toAE3cPXxWgoHSLRHf4gHkmU5o1SgbRy99rATiTOfn18AYdUHJU70YG4I19Cn
         tlOu94bpJK7mOOdaU+msvY9sRVLHQlJzVmyME1njGf6ZJOQpUjpVY88sCjP/DwfuXu2J
         urztEui0hZfBzy/92QFfaleWOJ6IOCh5U5kHaS4+mEI6jQ5ub4lRbcg0ojcNWydAd+b3
         mLqOt0i5+LJXandcvsK8US6zNdpFAJ8L0sGRNznZ01rGr15H7hoYuac2rKV1RwFjyji7
         dEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758080323; x=1758685123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AORQstWDFZCpFiH2iyPZCHq7tnFpScQvnrRiQl4jgm0=;
        b=bjbUNdXtwD/kAOe5PunxKY4DgCyaxPgWuGOS26GF30ofJ1AGNXFOcetTnNSmj5yYUp
         PcWtdhkQfXRpakFI5ZV/ADviKIzbbD88/hzCejUG+TAjOlfWxqgS/ClfDEEtaXafN/9G
         0XKKoX6fw+kQII1J3DP007Ub0M6MW2biQBOQ+jR2U++B6JmMQw6aahIJS7Lw+CyqeHQ5
         E+c5azMhRrWhMzQ9t05a9JbafJdlsBnc6LROZyZQwDp7J7uPAQqmUYil5MDHI8y6YubA
         8+2rOtZP0ZhaCQHJwcmYfZSl+kUh22eDtT/mOxCt2u1bTtsw4/ZHpcgRSvD57hRj76u2
         LLdg==
X-Gm-Message-State: AOJu0YxB5LfQK15cULl3gxnJw62Bdpuf9Ojkf4nfrYLcF6o2VymKhRVh
	CpBWtyOrKXN6jnrNOK+UYAy9defFlvO5aEnGf6eOsYy+YmxDAyoTDhaRJFkCEgzbfEgmgtpF/ze
	1cteWfXeVIrty6+uAd6Uq1y3n3ab1sko=
X-Gm-Gg: ASbGncvEk0STtBilcFs1REg+40xwSOXRx54M/uz0tmXbE/7r/NbZrZ7Cj0IAJ2vibWu
	UQA4KGPQpHXwzEOunrFuZ3Jgt5CI3Aj5NFuMzq4AfMZk/WR+348/2UMV7PG1DYgTYo17bIUj4Nj
	1CaD/d8OzCPSUY/nYVCL1v01CWWpzdE5tCLo0Ps0ihJzupNPYZ8/hVM2TATpHYRVsCbCklJMtzq
	Gs8pHltN2rzE/mXnP8elUXp2x6w8tRd/DdtkZCsTnxk3729SQA=
X-Google-Smtp-Source: AGHT+IEmov35YJyeaXeGV9IppMX8uBvciTaNS0LRdTu/cmYZDNhz7wpuXnU8i4FB1KkSyyjcTbYj5my0Au6C9+xiZMU=
X-Received: by 2002:a05:690c:490b:b0:722:8d7f:dab6 with SMTP id
 00721157ae682-73891b8750cmr4594227b3.28.1758080322900; Tue, 16 Sep 2025
 20:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907230415.289327-1-sidchintamaneni@gmail.com>
 <20250907230415.289327-2-sidchintamaneni@gmail.com> <CAP01T74Ag4UnME94mzEQSVEZRbh07gSm+CeoNUSXvEZ0xeFCgQ@mail.gmail.com>
In-Reply-To: <CAP01T74Ag4UnME94mzEQSVEZRbh07gSm+CeoNUSXvEZ0xeFCgQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 16 Sep 2025 20:38:32 -0700
X-Gm-Features: AS18NWCWoXgcfZfcHj7gqe_nt8FgSr5_MqCgbCkWfT_X480e9k6tx1dAQN6JcQE
Message-ID: <CAE5sdEhSFnJ0GJG=BPwjtLnPbpBraYy9N2CgZxbQMPgSgHipXA@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: Introduce new structs and struct fields for fast
 path termination
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 19:11, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 8 Sept 2025 at 01:04, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > Introduced the definition of struct bpf_term_aux_states
> > required to support fast-path termination of BPF programs.
> > Added the memory allocation and free logic for newly added
> > term_states feild in struct bpf_prog.
>
> typo: field
>
> >
> > Signed-off-by: Raj Sahu <rjsu26@gmail.com>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  include/linux/bpf.h | 75 +++++++++++++++++++++++++++++----------------
> >  kernel/bpf/core.c   | 31 +++++++++++++++++++
> >  2 files changed, 79 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 8f6e87f0f3a8..caaee33744fc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1584,6 +1584,25 @@ struct bpf_stream_stage {
> >         int len;
> >  };
> >
> > +struct call_aux_states {
> > +       int call_bpf_insn_idx;
> > +       int jit_call_idx;
> > +       u8 is_helper_kfunc;
> > +       u8 is_bpf_loop;
> > +       u8 is_bpf_loop_cb_inline;
> > +};
> > +
> > +struct bpf_term_patch_call_sites {
> > +       u32 call_sites_cnt;
> > +       struct call_aux_states *call_states;
> > +};
> > +
> > +struct bpf_term_aux_states {
> > +       struct bpf_prog *prog;
> > +       struct work_struct work;
> > +       struct bpf_term_patch_call_sites *patch_call_sites;
> > +};
> > +
> >  struct bpf_prog_aux {
> >         atomic64_t refcnt;
> >         u32 used_map_cnt;
> > @@ -1618,6 +1637,7 @@ struct bpf_prog_aux {
> >         bool tail_call_reachable;
> >         bool xdp_has_frags;
> >         bool exception_cb;
> > +       bool is_bpf_loop_cb_non_inline;
> >         bool exception_boundary;
> >         bool is_extended; /* true if extended by freplace program */
> >         bool jits_use_priv_stack;
> > @@ -1696,33 +1716,34 @@ struct bpf_prog_aux {
> >  };
> >
> >  struct bpf_prog {
> > -       u16                     pages;          /* Number of allocated pages */
> > -       u16                     jited:1,        /* Is our filter JIT'ed? */
> > -                               jit_requested:1,/* archs need to JIT the prog */
> > -                               gpl_compatible:1, /* Is filter GPL compatible? */
> > -                               cb_access:1,    /* Is control block accessed? */
> > -                               dst_needed:1,   /* Do we need dst entry? */
> > -                               blinding_requested:1, /* needs constant blinding */
> > -                               blinded:1,      /* Was blinded */
> > -                               is_func:1,      /* program is a bpf function */
> > -                               kprobe_override:1, /* Do we override a kprobe? */
> > -                               has_callchain_buf:1, /* callchain buffer allocated? */
> > -                               enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > -                               call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > -                               call_get_func_ip:1, /* Do we call get_func_ip() */
> > -                               tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> > -                               sleepable:1;    /* BPF program is sleepable */
> > -       enum bpf_prog_type      type;           /* Type of BPF program */
> > -       enum bpf_attach_type    expected_attach_type; /* For some prog types */
> > -       u32                     len;            /* Number of filter blocks */
> > -       u32                     jited_len;      /* Size of jited insns in bytes */
> > -       u8                      tag[BPF_TAG_SIZE];
> > -       struct bpf_prog_stats __percpu *stats;
> > -       int __percpu            *active;
> > -       unsigned int            (*bpf_func)(const void *ctx,
> > -                                           const struct bpf_insn *insn);
> > -       struct bpf_prog_aux     *aux;           /* Auxiliary fields */
> > -       struct sock_fprog_kern  *orig_prog;     /* Original BPF program */
> > +       u16                             pages;          /* Number of allocated pages */
> > +       u16                             jited:1,        /* Is our filter JIT'ed? */
> > +                                       jit_requested:1,/* archs need to JIT the prog */
> > +                                       gpl_compatible:1, /* Is filter GPL compatible? */
> > +                                       cb_access:1,    /* Is control block accessed? */
> > +                                       dst_needed:1,   /* Do we need dst entry? */
> > +                                       blinding_requested:1, /* needs constant blinding */
> > +                                       blinded:1,      /* Was blinded */
> > +                                       is_func:1,      /* program is a bpf function */
> > +                                       kprobe_override:1, /* Do we override a kprobe? */
> > +                                       has_callchain_buf:1, /* callchain buffer allocated? */
> > +                                       enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> > +                                       call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> > +                                       call_get_func_ip:1, /* Do we call get_func_ip() */
> > +                                       tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> > +                                       sleepable:1;    /* BPF program is sleepable */
> > +       enum bpf_prog_type              type;           /* Type of BPF program */
> > +       enum bpf_attach_type            expected_attach_type; /* For some prog types */
> > +       u32                             len;            /* Number of filter blocks */
> > +       u32                             jited_len;      /* Size of jited insns in bytes */
> > +       u8                              tag[BPF_TAG_SIZE];
> > +       struct bpf_prog_stats __percpu  *stats;
> > +       int __percpu                    *active;
> > +       unsigned int                    (*bpf_func)(const void *ctx,
> > +                                                   const struct bpf_insn *insn);
> > +       struct bpf_prog_aux             *aux;           /* Auxiliary fields */
> > +       struct sock_fprog_kern          *orig_prog;     /* Original BPF program */
> > +       struct bpf_term_aux_states      *term_states;
> >         /* Instructions for interpreter */
>
> This hunk looks bad, please only include what you touched, and don't
> reformat the rest.
>
>
I'll drop it

<SNIP>

