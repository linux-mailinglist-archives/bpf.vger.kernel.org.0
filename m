Return-Path: <bpf+bounces-39801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC69777B3
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 06:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D22B24701
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DB21C3F29;
	Fri, 13 Sep 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5nX5JKb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043018C902;
	Fri, 13 Sep 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200265; cv=none; b=GoqBD6leUEdxY4+u5culsQxX7HieewWi/KptGrVPD5PzYw0c2wRHnunzRepCcPLS39WdmYtHvdl5fXQp2mLzqldGzEAV4G3OJo5ihPAcuycxSbOpagEUQpVFpfcTeqrpQ/K6owo6os/Rm6m45FHlFkdW95uAPn8H7h6reCRZcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200265; c=relaxed/simple;
	bh=ixqhFxXZVmVrp13hYxPPbDiYCfNJhuvCviiADJruvMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umhki6EH608kg7SS5zAY5Xoi+eAfliwf9D+SjNZ/gtV2L2kvxdHHjKDwEM/Sif7IwdIK7Fix6bo0Cmgz+pxyIImvF5Wou/Avq3A0RYKslS5iWZSV6DWF5V/CO+YPZ8uDOkqaRG8FjeONQ5Fm739rrH7z6x+BrVRF8BeqFH7ubkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5nX5JKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4CEC4CEC0;
	Fri, 13 Sep 2024 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726200265;
	bh=ixqhFxXZVmVrp13hYxPPbDiYCfNJhuvCviiADJruvMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R5nX5JKb3zeRCOla9nveZJv1RwTsBBsyuc6Zm6BPMJZs9aoCEjQBme7Q3KjkFyGtd
	 XkM7QHtp5dtV/hbhPo7u5hk63MAqOd8eSihfDFxHUam9r/uong/Wzh36lB0tWetokb
	 cdT9SwUBy+O1PWVZLhqFhtDGs7fsXoTb09S3Zg/1zJBALupI4TZt/bhEra52A+tFzM
	 cwIGmZ/bDFxYsTSCvdIHbmg2FZ3m6Fd7KJl1MXT84kM7F2SKeMn7N+X0YnS9fbKsP3
	 KLhYlNamUiT9CiNztc92wAfy45aaQQiEIeGkw9/+skOM2vNE9eFMWqmdttIzAkeCCp
	 jCUq+7RKBsiZg==
Message-ID: <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
	bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
Date: Fri, 13 Sep 2024 12:04:16 +0800
In-Reply-To: <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
	 <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
	 <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrii,

On Thu, 2024-09-12 at 11:24 -0700, Andrii Nakryiko wrote:
> On Thu, Sep 12, 2024 at 2:26 AM Geliang Tang <geliang@kernel.org>
> wrote:
> > 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > It's necessary to traverse all subflows on the conn_list of an
> > MPTCP
> > socket and then call kfunc to modify the fields of each subflow. In
> > kernel space, mptcp_for_each_subflow() helper is used for this:
> > 
> >         mptcp_for_each_subflow(msk, subflow)
> >                 kfunc(subflow);
> > 
> > But in the MPTCP BPF program, this has not yet been implemented. As
> > Martin suggested recently, this conn_list walking + modify-by-kfunc
> > usage fits the bpf_iter use case. So this patch adds a new bpf_iter
> > type named "mptcp_subflow" to do this and implements its helpers
> > bpf_iter_mptcp_subflow_new()/_next()/_destroy().
> > 
> > Since these bpf_iter mptcp_subflow helpers are invoked in its
> > selftest
> > in a ftrace hook for mptcp_sched_get_send(), it's necessary to
> > register
> > them into a BPF_PROG_TYPE_TRACING type kfunc set together with
> > other
> > two used kfuncs mptcp_subflow_active() and
> > mptcp_subflow_set_scheduled().
> > 
> > Then bpf_for_each() for mptcp_subflow can be used in BPF program
> > like
> > this:
> > 
> >         i = 0;
> >         bpf_rcu_read_lock();
> >         bpf_for_each(mptcp_subflow, subflow, msk) {
> >                 if (i++ >= MPTCP_SUBFLOWS_MAX)
> >                         break;
> >                 kfunc(subflow);
> >         }
> >         bpf_rcu_read_unlock();
> > 
> > v2: remove msk->pm.lock in _new() and _destroy() (Martin)
> >     drop DEFINE_BPF_ITER_FUNC, change opaque[3] to opaque[2]
> > (Andrii)
> > v3: drop bpf_iter__mptcp_subflow
> > v4: if msk is NULL, initialize kit->msk to NULL in _new() and check
> > it in
> >     _next() (Andrii)
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-
> > ----
> >  1 file changed, 52 insertions(+), 5 deletions(-)
> > 
> 
> Looks ok from setting up open-coded iterator things, but I can't
> speak
> for other aspects I mentioned below.
> 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 6414824402e6..fec18e7e5e4a 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -201,9 +201,51 @@ static const struct btf_kfunc_id_set
> > bpf_mptcp_fmodret_set = {
> >         .set   = &bpf_mptcp_fmodret_ids,
> >  };
> > 
> > -__diag_push();
> > -__diag_ignore_all("-Wmissing-prototypes",
> > -                 "kfuncs which will be used in BPF programs");
> > +struct bpf_iter_mptcp_subflow {
> > +       __u64 __opaque[2];
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_iter_mptcp_subflow_kern {
> > +       struct mptcp_sock *msk;
> > +       struct list_head *pos;
> > +} __attribute__((aligned(8)));
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
> > bpf_iter_mptcp_subflow *it,
> > +                                          struct mptcp_sock *msk)
> > +{
> > +       struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > +
> > +       kit->msk = msk;
> > +       if (!msk)
> > +               return -EINVAL;
> > +
> > +       kit->pos = &msk->conn_list;
> > +       return 0;
> > +}
> > +
> > +__bpf_kfunc struct mptcp_subflow_context *
> > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > +{
> > +       struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > +       struct mptcp_subflow_context *subflow;
> > +       struct mptcp_sock *msk = kit->msk;
> > +
> > +       if (!msk)
> > +               return NULL;
> > +
> > +       subflow = list_entry(kit->pos->next, struct
> > mptcp_subflow_context, node);
> > +       if (!subflow || list_entry_is_head(subflow, &msk-
> > >conn_list, node))
> 
> it's a bit weird that you need both !subflow and
> list_entry_is_head().
> Can you have NULL subflow at all? But this is the question to
> msk->conn_list semantics.

Do you mean to return subflow regardless of whether subflow is NULL? If
so, we need to use list_is_last() instead of list_entry_is_head():

{
    struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;

    if (!kit->msk || list_is_last(kit->pos, &kit->msk->conn_list))
            return NULL;

    kit->pos = kit->pos->next;
    return list_entry(kit->pos, struct mptcp_subflow_context, node);
}

Hope this is a better version.

> 
> > +               return NULL;
> > +
> > +       kit->pos = &subflow->node;
> > +       return subflow;
> > +}
> > +
> > +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct
> > bpf_iter_mptcp_subflow *it)
> > +{
> > +}
> > 
> >  __bpf_kfunc struct mptcp_subflow_context *
> >  bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> > unsigned int pos)
> > @@ -218,12 +260,15 @@ __bpf_kfunc bool
> > bpf_mptcp_subflow_queues_empty(struct sock *sk)
> >         return tcp_rtx_queue_empty(sk);
> >  }
> > 
> > -__diag_pop();
> > +__bpf_kfunc_end_defs();
> > 
> >  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> 
> I'm not 100% sure, but I suspect you might need to specify
> KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk` is a

KF_TRUSTED_ARGS breaks the selftest in patch 2 [1]:

'''
libbpf: prog 'trace_mptcp_sched_get_send': BPF program load failed:
Invalid argument
libbpf: prog 'trace_mptcp_sched_get_send': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(trace_mptcp_sched_get_send, struct mptcp_sock *msk) @
mptcp_bpf_iter.c:13
0: (79) r6 = *(u64 *)(r1 +0)
func 'mptcp_sched_get_send' arg0 has btf_id 28019 type STRUCT
'mptcp_sock'
1: R1=ctx() R6_w=ptr_mptcp_sock()
; if (bpf_get_current_pid_tgid() >> 32 != pid) @ mptcp_bpf_iter.c:17
1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
2: (77) r0 >>= 32                     ;
R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
3: (18) r1 = 0xffffb766c1684004       ;
R1_w=map_value(map=mptcp_bp.bss,ks=4,vs=8,off=4)
5: (61) r1 = *(u32 *)(r1 +0)          ;
R1_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
6: (67) r1 <<= 32                     ;
R1_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,sm
ax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
7: (c7) r1 s>>= 32                    ;
R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
8: (5d) if r0 != r1 goto pc+39        ;
R0_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0;
0x7fffffff))
R1_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0;
0x7fffffff))
; iter = 0; @ mptcp_bpf_iter.c:20
9: (18) r8 = 0xffffb766c1684000       ;
R8_w=map_value(map=mptcp_bp.bss,ks=4,vs=8)
11: (b4) w1 = 0                       ; R1_w=0
12: (63) *(u32 *)(r8 +0) = r1         ; R1_w=0
R8_w=map_value(map=mptcp_bp.bss,ks=4,vs=8)
; bpf_rcu_read_lock(); @ mptcp_bpf_iter.c:22
13: (85) call bpf_rcu_read_lock#84967         ;
14: (bf) r7 = r10                     ; R7_w=fp0 R10=fp0
; iter = 0; @ mptcp_bpf_iter.c:20
15: (07) r7 += -16                    ; R7_w=fp-16
; bpf_for_each(mptcp_subflow, subflow, msk) { @ mptcp_bpf_iter.c:23
16: (bf) r1 = r7                      ; R1_w=fp-16 R7_w=fp-16
17: (bf) r2 = r6                      ; R2_w=ptr_mptcp_sock()
R6=ptr_mptcp_sock()
18: (85) call bpf_iter_mptcp_subflow_new#62694
R2 must be referenced or trusted
processed 17 insns (limit 1000000) max_states_per_insn 0 total_states 1
peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'trace_mptcp_sched_get_send': failed to load: -22
libbpf: failed to load object 'mptcp_bpf_iter'
libbpf: failed to load BPF skeleton 'mptcp_bpf_iter': -22
test_bpf_iter:FAIL:skel_open_load: mptcp_iter unexpected error: -22
#169/4   mptcp/bpf_iter:FAIL
'''

I don't know how to fix it yet.

> valid owned kernel object. Other BPF folks might help to clarify
> this.
> 
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> > +BTF_ID_FLAGS(func, mptcp_subflow_active)

But we do need to add KF_ITER_NEW/NEXT/DESTROY flags here:

BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW)
BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT |
KF_RET_NULL)
BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)

With these flags, we can drop this additional test in loop:

	if (i++ >= MPTCP_SUBFLOWS_MAX)
		break;


This problem has been bothering me for a while. I got "infinite loop
detected" errors when walking the list with
bpf_for_each(mptcp_subflow). So I had to use this additional test to
break it.

With these KF_ITER_NEW/NEXT/DESTROY flags, no need to use this
additional test anymore.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/4467ab3af0f1a6c378778ca6be72753b16a1532c.1726132802.git.tanggeliang@kylinos.cn/

> >  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> >  BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
> > -BTF_ID_FLAGS(func, mptcp_subflow_active)
> >  BTF_ID_FLAGS(func, mptcp_set_timeout)
> >  BTF_ID_FLAGS(func, mptcp_wnd_end)
> >  BTF_ID_FLAGS(func, tcp_stream_memory_free)
> > @@ -241,6 +286,8 @@ static int __init bpf_mptcp_kfunc_init(void)
> >         int ret;
> > 
> >         ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > +       ret = ret ?:
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > +                                             
> > &bpf_mptcp_sched_kfunc_set);
> >         ret = ret ?:
> > register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> >                                               
> > &bpf_mptcp_sched_kfunc_set);
> >  #ifdef CONFIG_BPF_JIT
> > --
> > 2.43.0
> > 
> > 


