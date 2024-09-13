Return-Path: <bpf+bounces-39865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20EF978A49
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 22:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8C1F23547
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579315098A;
	Fri, 13 Sep 2024 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey8qOrhw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB45126BF0
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261090; cv=none; b=qcMqulqE3cPxsdlke5JlMkmq0FHA9voTuunDGDWWwDiZmkzRGz6Kr6gXnmj3+T8j4sjr0EK/pgmRSobgP8NP/YJwZ7vHtE+UKmOtG/UfXPInck6Wc3GoyJPwqXHnq05FaUqizwb7TLE5O2XrPgy6FZu5mhEV5I2sOdx6DZil0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261090; c=relaxed/simple;
	bh=1c0L09Qx22mq/ZD5i5LJFCqAYGwzXGjmXQAMrwGv00A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2jn0qkPIfBii7X4cZHI+s1QlCprwm+bAKN8qgHG1SgDVzlVlBA1H0yv9ZJu+0CRkcU/kpiWGKyCcVWvu26Y7ODy1ENdtWQ3wh6yWMEUv1cAY1xlfSyFMlkUYBb6oQV1hcYVf55RutkYHRVgDYzYT6BbOBycIDzB5mX3p+fW7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey8qOrhw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso1054292a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726261087; x=1726865887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxPPwiDegDxin6YRoGsOSYyWMCa3hpbc7r/1/A2gOC4=;
        b=Ey8qOrhwagK/lWxUuzPisi2m7262yl0tTgiUbOe0LBzAa63lMp8G7ivKCUF0vnR7JO
         TveTsMcobNKG88xxbNJ5DPfJr9aLaTxkcI65Uu3ePPbVg+0c5lTPzG5cDDDTDKR1naKR
         TXKw0/n44IQJou5hsRI1sWHJTIdLKjdzkUMg8qyMhJfQh+2zgAnBJ+2FGiruPVa11iJs
         5W8MHd3+52MyCxwaAtKiQktzvepT2IrgJXLBxieebk9XHhEgPozvLwyMdqHlSMRQs0qk
         GevVI8y0994UsTrmRmZdWi/DlOiAUW2GrQae9KGwp7wXNj7t1QWGPONTIbQWkfPZOq9I
         tEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261087; x=1726865887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxPPwiDegDxin6YRoGsOSYyWMCa3hpbc7r/1/A2gOC4=;
        b=X6re+21ot+pF2GmjhQilE3hdakXrtrqped2Bpz77iS9+7vN5mPU5tOKAumZ5Scvmux
         IKXt0V2Zjczj6i7i6Fz52pkG7fGv2WPTn4Q5kHNK80cVcMuwUbWsn9rTzS8L0mgZfl/9
         0X5T2d2b7cHBwbGvzHO2OOj/sD5QPd1MQ9InWg22CDJLepVhRBPvJyVCxILGs2dTq1MN
         y+1Erhoni6uYEvkDc7+4JKFVaCactfB1wl0mit9rYuXPgR2nQRbNrbdA3rITKafEp/9D
         iuQ9ZAxxTfPEREP41XPLia5DjGYj56xkFDo21p0j4zHw+q4zLq3kNo/jywuJis9ku/H+
         h25g==
X-Forwarded-Encrypted: i=1; AJvYcCXJLCwS+Ak63ue0jsOiP5vxTLGME3o/wz9JYNr2GlTYFguUJ+tNaz3ar100sDWjA6sdHEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlJpCDkLn7pfRm24JYKdLVIM5FZEidkLzciyim3b/PnLpauL/
	+5rz8lcKEKUxe1uK/qAJ0w2Cp/03dy6dsDQSZv+AVrNjg5Kxf2L07ErYExHm4Wussp4mgxRyPy9
	BhWYWxss7ktN/DFKTH6PSIxdaPVFC2qbz
X-Google-Smtp-Source: AGHT+IF8emqpz1aElnbsUB7erdNF7dkR7N/GQv+i2foPBOZIA7YDFi7jRnjTZLok2rhiYunocyb+q571isv8OwN4BbM=
X-Received: by 2002:a17:90a:12c4:b0:2d3:de40:d767 with SMTP id
 98e67ed59e1d1-2dbb9e22f1amr4995706a91.24.1726261087472; Fri, 13 Sep 2024
 13:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726132802.git.tanggeliang@kylinos.cn> <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
 <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com> <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
In-Reply-To: <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Sep 2024 13:57:55 -0700
Message-ID: <CAEf4Bza4qtP5EVOk08XmGOjWgy1-671gciK5j5vg5Lr=5ggm0Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:04=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> Hi Andrii,
>
> On Thu, 2024-09-12 at 11:24 -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 12, 2024 at 2:26=E2=80=AFAM Geliang Tang <geliang@kernel.or=
g>
> > wrote:
> > >
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > >
> > > It's necessary to traverse all subflows on the conn_list of an
> > > MPTCP
> > > socket and then call kfunc to modify the fields of each subflow. In
> > > kernel space, mptcp_for_each_subflow() helper is used for this:
> > >
> > >         mptcp_for_each_subflow(msk, subflow)
> > >                 kfunc(subflow);
> > >
> > > But in the MPTCP BPF program, this has not yet been implemented. As
> > > Martin suggested recently, this conn_list walking + modify-by-kfunc
> > > usage fits the bpf_iter use case. So this patch adds a new bpf_iter
> > > type named "mptcp_subflow" to do this and implements its helpers
> > > bpf_iter_mptcp_subflow_new()/_next()/_destroy().
> > >
> > > Since these bpf_iter mptcp_subflow helpers are invoked in its
> > > selftest
> > > in a ftrace hook for mptcp_sched_get_send(), it's necessary to
> > > register
> > > them into a BPF_PROG_TYPE_TRACING type kfunc set together with
> > > other
> > > two used kfuncs mptcp_subflow_active() and
> > > mptcp_subflow_set_scheduled().
> > >
> > > Then bpf_for_each() for mptcp_subflow can be used in BPF program
> > > like
> > > this:
> > >
> > >         i =3D 0;
> > >         bpf_rcu_read_lock();
> > >         bpf_for_each(mptcp_subflow, subflow, msk) {
> > >                 if (i++ >=3D MPTCP_SUBFLOWS_MAX)
> > >                         break;
> > >                 kfunc(subflow);
> > >         }
> > >         bpf_rcu_read_unlock();
> > >
> > > v2: remove msk->pm.lock in _new() and _destroy() (Martin)
> > >     drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2]
> > > (Andrii)
> > > v3: drop bpf_iter__mptcp_subflow
> > > v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
> > > it in
> > >     _next() (Andrii)
> > >
> > > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  net/mptcp/bpf.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-
> > > ----
> > >  1 file changed, 52 insertions(+), 5 deletions(-)
> > >
> >
> > Looks ok from setting up open-coded iterator things, but I can't
> > speak
> > for other aspects I mentioned below.
> >
> > > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > > index 6414824402e6..fec18e7e5e4a 100644
> > > --- a/net/mptcp/bpf.c
> > > +++ b/net/mptcp/bpf.c
> > > @@ -201,9 +201,51 @@ static const struct btf_kfunc_id_set
> > > bpf_mptcp_fmodret_set =3D {
> > >         .set   =3D &bpf_mptcp_fmodret_ids,
> > >  };
> > >
> > > -__diag_push();
> > > -__diag_ignore_all("-Wmissing-prototypes",
> > > -                 "kfuncs which will be used in BPF programs");
> > > +struct bpf_iter_mptcp_subflow {
> > > +       __u64 __opaque[2];
> > > +} __attribute__((aligned(8)));
> > > +
> > > +struct bpf_iter_mptcp_subflow_kern {
> > > +       struct mptcp_sock *msk;
> > > +       struct list_head *pos;
> > > +} __attribute__((aligned(8)));
> > > +
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
> > > bpf_iter_mptcp_subflow *it,
> > > +                                          struct mptcp_sock *msk)
> > > +{
> > > +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> > > +
> > > +       kit->msk =3D msk;
> > > +       if (!msk)
> > > +               return -EINVAL;
> > > +
> > > +       kit->pos =3D &msk->conn_list;
> > > +       return 0;
> > > +}
> > > +
> > > +__bpf_kfunc struct mptcp_subflow_context *
> > > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > > +{
> > > +       struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
> > > +       struct mptcp_subflow_context *subflow;
> > > +       struct mptcp_sock *msk =3D kit->msk;
> > > +
> > > +       if (!msk)
> > > +               return NULL;
> > > +
> > > +       subflow =3D list_entry(kit->pos->next, struct
> > > mptcp_subflow_context, node);
> > > +       if (!subflow || list_entry_is_head(subflow, &msk-
> > > >conn_list, node))
> >
> > it's a bit weird that you need both !subflow and
> > list_entry_is_head().
> > Can you have NULL subflow at all? But this is the question to
> > msk->conn_list semantics.
>
> Do you mean to return subflow regardless of whether subflow is NULL? If

Can you have a NULL subflow in the middle of the list and some more
items after that? If yes, then you should *skip* NULL subflow.

But if the NULL subflow is always last, then do you even need
list_entry_is_head() or list_is_last()?

But ultimately, I have no idea what the data looks like, just
double-check that the stopping condition is correct, that's all. Has
nothing to do with BPF open-coded iterators.

> so, we need to use list_is_last() instead of list_entry_is_head():
>
> {
>     struct bpf_iter_mptcp_subflow_kern *kit =3D (void *)it;
>
>     if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
>             return NULL;
>
>     kit->pos =3D kit->pos->next;
>     return list_entry(kit->pos, struct mptcp_subflow_context, node);
> }
>
> Hope this is a better version.

ok, works for me as well

>
> >
> > > +               return NULL;
> > > +
> > > +       kit->pos =3D &subflow->node;
> > > +       return subflow;
> > > +}
> > > +
> > > +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct
> > > bpf_iter_mptcp_subflow *it)
> > > +{
> > > +}
> > >
> > >  __bpf_kfunc struct mptcp_subflow_context *
> > >  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> > > unsigned int pos)
> > > @@ -218,12 +260,15 @@ __bpf_kfunc bool
> > > bpf_mptcp_subflow_queues_empty(struct sock *sk)
> > >         return tcp_rtx_queue_empty(sk);
> > >  }
> > >
> > > -__diag_pop();
> > > +__bpf_kfunc_end_defs();
> > >
> > >  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> > > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> >
> > I'm not 100% sure, but I suspect you might need to specify
> > KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk` is a
>
> KF_TRUSTED_ARGS breaks the selftest in patch 2 [1]:

Please, for the next revision, CC bpf@vger.kernel.org on *all* patches
in your series, so we don't have to search for the selftests in
another mailing list.

>
> '''
> libbpf: prog 'trace_mptcp_sched_get_send': BPF program load failed:
> Invalid argument
> libbpf: prog 'trace_mptcp_sched_get_send': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk) @
> mptcp_bpf_iter.c:13
> 0: (79) r6 =3D *(u64 *)(r1 +0)
> func 'mptcp_sched_get_send' arg0 has btf_id 28019 type STRUCT
> 'mptcp_sock'
> 1: R1=3Dctx() R6_w=3Dptr_mptcp_sock()
> ; if (bpf_get_current_pid_tgid() >> 32 !=3D pid) @ mptcp_bpf_iter.c:17
> 1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
> 2: (77) r0 >>=3D 32                     ;
> R0_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
> 3: (18) r1 =3D 0xffffb766c1684004       ;
> R1_w=3Dmap_value(map=3Dmptcp_bp.bss,ks=3D4,vs=3D8,off=3D4)
> 5: (61) r1 =3D *(u32 *)(r1 +0)          ;
> R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
> 6: (67) r1 <<=3D 32                     ;
> R1_w=3Dscalar(smax=3D0x7fffffff00000000,umax=3D0xffffffff00000000,smin32=
=3D0,sm
> ax32=3Dumax32=3D0,var_off=3D(0x0; 0xffffffff00000000))
> 7: (c7) r1 s>>=3D 32                    ;
> R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> 8: (5d) if r0 !=3D r1 goto pc+39        ;
> R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=
=3D(0x0;
> 0x7fffffff))
> R1_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dumax32=3D0x7fffffff,var_off=
=3D(0x0;
> 0x7fffffff))
> ; iter =3D 0; @ mptcp_bpf_iter.c:20
> 9: (18) r8 =3D 0xffffb766c1684000       ;
> R8_w=3Dmap_value(map=3Dmptcp_bp.bss,ks=3D4,vs=3D8)
> 11: (b4) w1 =3D 0                       ; R1_w=3D0
> 12: (63) *(u32 *)(r8 +0) =3D r1         ; R1_w=3D0
> R8_w=3Dmap_value(map=3Dmptcp_bp.bss,ks=3D4,vs=3D8)
> ; bpf_rcu_read_lock(); @ mptcp_bpf_iter.c:22
> 13: (85) call bpf_rcu_read_lock#84967         ;
> 14: (bf) r7 =3D r10                     ; R7_w=3Dfp0 R10=3Dfp0
> ; iter =3D 0; @ mptcp_bpf_iter.c:20
> 15: (07) r7 +=3D -16                    ; R7_w=3Dfp-16
> ; bpf_for_each(mptcp_subflow, subflow, msk) { @ mptcp_bpf_iter.c:23
> 16: (bf) r1 =3D r7                      ; R1_w=3Dfp-16 R7_w=3Dfp-16
> 17: (bf) r2 =3D r6                      ; R2_w=3Dptr_mptcp_sock()
> R6=3Dptr_mptcp_sock()
> 18: (85) call bpf_iter_mptcp_subflow_new#62694
> R2 must be referenced or trusted
> processed 17 insns (limit 1000000) max_states_per_insn 0 total_states 1
> peak_states 1 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'trace_mptcp_sched_get_send': failed to load: -22
> libbpf: failed to load object 'mptcp_bpf_iter'
> libbpf: failed to load BPF skeleton 'mptcp_bpf_iter': -22
> test_bpf_iter:FAIL:skel_open_load: mptcp_iter unexpected error: -22
> #169/4   mptcp/bpf_iter:FAIL
> '''
>
> I don't know how to fix it yet.

And the verifier is pointing out the real problem (selftest is at [0]
for those interested).

struct mptcp_sock *msk argument for fentry/mptcp_sched_get_send can't
be trusted to be valid and be properly protected from being freed,
etc. You need to have kfuncs that will have KF_ACQUIRE semantics and
will take refcount or whatnot (or KF_RCU for RCU-protection).

See some examples where we do the same with tasks or maybe sockets,
I'm not very familiar with this area.

  [0] https://lore.kernel.org/mptcp/4467ab3af0f1a6c378778ca6be72753b16a1532=
c.1726132802.git.tanggeliang@kylinos.cn/

>
> > valid owned kernel object. Other BPF folks might help to clarify
> > this.
> >
> > > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> > > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> > > +BTF_ID_FLAGS(func, mptcp_subflow_active)
>
> But we do need to add KF_ITER_NEW/NEXT/DESTROY flags here:
>
> BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW)
> BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT |
> KF_RET_NULL)
> BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
>
> With these flags, we can drop this additional test in loop:
>
>         if (i++ >=3D MPTCP_SUBFLOWS_MAX)
>                 break;
>
>
> This problem has been bothering me for a while. I got "infinite loop
> detected" errors when walking the list with
> bpf_for_each(mptcp_subflow). So I had to use this additional test to
> break it.
>
> With these KF_ITER_NEW/NEXT/DESTROY flags, no need to use this
> additional test anymore.
>

These flags is what makes those functions an open-coded iterator
implementation, yes.

> Thanks,
> -Geliang
>
> [1]
> https://patchwork.kernel.org/project/mptcp/patch/4467ab3af0f1a6c378778ca6=
be72753b16a1532c.1726132802.git.tanggeliang@kylinos.cn/
>
> > >  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> > >  BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
> > > -BTF_ID_FLAGS(func, mptcp_subflow_active)
> > >  BTF_ID_FLAGS(func, mptcp_set_timeout)
> > >  BTF_ID_FLAGS(func, mptcp_wnd_end)
> > >  BTF_ID_FLAGS(func, tcp_stream_memory_free)
> > > @@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
> > >         int ret;
> > >
> > >         ret =3D register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > > +       ret =3D ret ?:
> > > register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > > +
> > > &bpf_mptcp_sched_kfunc_set);
> > >         ret =3D ret ?:
> > > register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> > >
> > > &bpf_mptcp_sched_kfunc_set);
> > >  #ifdef CONFIG_BPF_JIT
> > > --
> > > 2.43.0
> > >
> > >
>

