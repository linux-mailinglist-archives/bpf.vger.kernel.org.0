Return-Path: <bpf+bounces-45798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E49DB19A
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC2C166C52
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B8537F8;
	Thu, 28 Nov 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwPbUiwY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D25134BD
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762536; cv=none; b=olgNSLCEZZTO/WHVxOeWOc9pCeivvH/BBZQrWt6LfbgntSVwnpRGiLPLypxl0zhfG0/A7rO1iJWJfB/UKtRRKiUpWQIGmBPs8YC77Ne+a6Zz8Ihw/C2Yhco+pGmntdAkfJFfNpyLUYpEm2UcOCOlWxPRbRNfRcG3SNiLyuTpok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762536; c=relaxed/simple;
	bh=GnlcAa88tWu3dR+uLKsj3l4NmIbQSxJAVVQSMS8sdOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRZQKFsCayyZt8jO6ko/wlUD6MgJYbtjyMK99qJEP6SG5Vp4NuTv6+tW6v1aKluhd5Usj62VLNxsDZmN0FMN8cjfAkaN/W7TnHTkZaHJOwfj34LgiUYlqEIDqQp+wV+kX3IwtitB59DiM2JibkIq35ZtBSFm6CJlG1BSPS73hHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwPbUiwY; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so420477a12.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732762533; x=1733367333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEpNgMzfviSe4z4B/teU8XY/AX067F8XhbuBc5P1kVY=;
        b=VwPbUiwYLG8N+ZEyGbED8WJtrKS8UpAU2mbDmAnr1edRcSVdg7UodJWfnytSC5cNLn
         hJ52wcq/WSVOqqZ3KH8LGal8gb+22z+Sj4wQQtEfIsK0OQKH8bmpzDpMDPgJz9qxvj5V
         4AipMKRN0nVEqqCBy2i08bEdG2oUhR67UMLoCoj9wL9BqqnHfSmbZE5FHYmosep3gSvT
         2rbHtKJE8+enGdAYfeimi7XyO9wFOgL/meeho8cgV8ibP5bwlbrAsBSqFstR6O9Wzcym
         i/582tR9ZiwtVrJoS3efgeUb4A1YU8LPvOcjaWf5PHIuz0FFMU9/CGv4df+9Y2XXhg2/
         nzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732762533; x=1733367333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEpNgMzfviSe4z4B/teU8XY/AX067F8XhbuBc5P1kVY=;
        b=mL7GE9dq5cuN79UFTrNTtTJHSCNJLV3OiiLGzBbgLAaLPaCnXrw8Sa7t5JHkKd7BSa
         Srjt+JOZcoaCG69wBXM+bp8ceJPIXMsy4vvet6DmVI3G0qWQs3UWVXsoDKuMTj5OOIF5
         kY6Dq8yZZi55FeHW/WnAoDWwVXyR4Rvp8zk8OSgCLeU/owh5dMU+01lsiXPS6H4hPzs5
         NCJmTPta6dWh8T776ttaWjiocCq6+2Tt7lEXW5o/wsNHKFWInxXTye2HiMGVSIWk6GEy
         sYZ6jJSBWBfmppK+eV0MkuoxtqFZhNj3ADHVZggCprHbl7ehc7MSwmwd6YjVa9yGOjGV
         hbBA==
X-Gm-Message-State: AOJu0Yw3tDag6K2eH6pJSdb1R+v7HAtkYgq8LFjy4MMr8zgxEE9Ymwfn
	0YtPPJeOz7ghg4r2kfPJjKEdgPR3VOJI/Qr8eyhbxEE9Qy2/7A2YLfJX3SVEoovihKb1dh84SHK
	A6OTz+s10fIVDLoHJbZrSNyXE7b4=
X-Gm-Gg: ASbGncv6ESjLU7qO86+7wgBE42P+gVHefpI1CEBxRKk9f8ICuPxB7iR/7hRLiKXc/18
	EPKZyMjLmP/vWxfswIIV4vqwSDEv/IDT2
X-Google-Smtp-Source: AGHT+IEfqxpOnc6xgRaLDxrF4OWuKN+m7qvWADHx/mg6kMYSyVXEHrbnoz7QO5VH7SlVsCtMwoOgt0cR471uI4Kx7RQ=
X-Received: by 2002:a05:6402:2808:b0:5cf:db7d:76dd with SMTP id
 4fb4d7f45d1cf-5d080b8d47amr4311359a12.5.1732762533343; Wed, 27 Nov 2024
 18:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165846.2001009-1-memxor@gmail.com> <20241127165846.2001009-2-memxor@gmail.com>
 <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
In-Reply-To: <a4690c29ca3b5f34945cd507def7e0c6ecdec9e1.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 03:54:57 +0100
Message-ID: <CAP01T77t=FmvzyeCJ_3Bp+8D0-Z4GGUHNeGbNBmSY6xFXi-ZgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Consolidate locks and reference
 state in verifier state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 03:39, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
> > Currently, state for RCU read locks and preemption is in
> > bpf_verifier_state, while locks and pointer reference state remains in
> > bpf_func_state. There is no particular reason to keep the latter in
> > bpf_func_state. Additionally, it is copied into a new frame's state and
> > copied back to the caller frame's state everytime the verifier processes
> > a pseudo call instruction. This is a bit wasteful, given this state is
> > global for a given verification state / path.
> >
> > Move all resource and reference related state in bpf_verifier_state
> > structure in this patch, in preparation for introducing new reference
> > state types in the future.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> lgtm, but please fix the 'print_verifier_state' note below.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> > ---
> >  include/linux/bpf_verifier.h |  11 ++--
> >  kernel/bpf/log.c             |  11 ++--
> >  kernel/bpf/verifier.c        | 112 ++++++++++++++++-------------------
> >  3 files changed, 64 insertions(+), 70 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index f4290c179bee..af64b5415df8 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -315,9 +315,6 @@ struct bpf_func_state {
> >       u32 callback_depth;
> >
> >       /* The following fields should be last. See copy_func_state() */
> > -     int acquired_refs;
> > -     int active_locks;
> > -     struct bpf_reference_state *refs;
> >       /* The state of the stack. Each element of the array describes BPF_REG_SIZE
> >        * (i.e. 8) bytes worth of stack memory.
> >        * stack[0] represents bytes [*(r10-8)..*(r10-1)]
> > @@ -419,9 +416,13 @@ struct bpf_verifier_state {
> >       u32 insn_idx;
> >       u32 curframe;
> >
> > -     bool speculative;
> > +     struct bpf_reference_state *refs;
> > +     u32 acquired_refs;
> > +     u32 active_locks;
> > +     u32 active_preempt_locks;
> >       bool active_rcu_lock;
> > -     u32 active_preempt_lock;
> > +
> > +     bool speculative;
>
> Nit: pahole says there are two holes here:
>
>      $ pahole kernel/bpf/verifier.o
>      ...
>      struct bpf_verifier_state {
>         struct bpf_func_state *    frame[8];             /*     0    64 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct bpf_verifier_state * parent;              /*    64     8 */
>         u32                        branches;             /*    72     4 */
>         u32                        insn_idx;             /*    76     4 */
>         u32                        curframe;             /*    80     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct bpf_reference_state * refs;               /*    88     8 */
>         u32                        acquired_refs;        /*    96     4 */
>         u32                        active_locks;         /*   100     4 */
>         u32                        active_preempt_locks; /*   104     4 */
>         u32                        active_irq_id;        /*   108     4 */
>         bool                       active_rcu_lock;      /*   112     1 */
>         bool                       speculative;          /*   113     1 */
>         bool                       used_as_loop_entry;   /*   114     1 */
>         bool                       in_sleepable;         /*   115     1 */
>         u32                        first_insn_idx;       /*   116     4 */
>         u32                        last_insn_idx;        /*   120     4 */
>
>         /* XXX 4 bytes hole, try to pack */
>
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct bpf_verifier_state * loop_entry;          /*   128     8 */
>         u32                        insn_hist_start;      /*   136     4 */
>         u32                        insn_hist_end;        /*   140     4 */
>         u32                        dfs_depth;            /*   144     4 */
>         u32                        callback_unroll_depth; /*   148     4 */
>         u32                        may_goto_depth;       /*   152     4 */
>
>         /* size: 160, cachelines: 3, members: 22 */
>         /* sum members: 148, holes: 2, sum holes: 8 */
>
>     maybe move the 'refs' pointer?
>     e.g. moving it after 'parent' makes both holes disappear.

Ack, will fix.

>
> >       /* If this state was ever pointed-to by other state's loop_entry field
> >        * this flag would be set to true. Used to avoid freeing such states
> >        * while they are still in use.
> > diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> > index 4a858fdb6476..8b52e5b7504c 100644
> > --- a/kernel/bpf/log.c
> > +++ b/kernel/bpf/log.c
> > @@ -756,6 +756,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
> >  void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_func_state *state,
> >                         bool print_all)
> >  {
> > +     struct bpf_verifier_state *vstate = env->cur_state;
>
> This is not always true.
> For example, __mark_chain_precision does 'print_verifier_state(env, func, true)'
> for func obtained as 'func = st->frame[fr];' where 'st' iterates over parents
> of env->cur_state.

Looking through the code, I'm thinking the only proper fix is
explicitly passing in the verifier state, I was hoping there would be
a link from func_state -> verifier_state but it is not the case.
Regardless, explicitly passing in the verifier state is probably cleaner. WDYT?

>
> >       const struct bpf_reg_state *reg;
> >       int i;
> >
>
> [...]
>

