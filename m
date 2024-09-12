Return-Path: <bpf+bounces-39684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A9D975F89
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 05:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D2C1F22CFF
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBED7603A;
	Thu, 12 Sep 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGmNITUo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AC22EE5;
	Thu, 12 Sep 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110372; cv=none; b=u1MeZl9UkN27/CK/piKXA6qmz0SvWHWFJp8fgSvlzMUOKQtV+0v87gD0Jbmrjl7NmW76pIviVYL0SJhDKwxoxMEU7EXTI/MEsRwjT8uG2W9gx9QoZ6GHFIdlpijSmKAXYFfWLwIBvatsACVLIXaSyfWwXM8BkkKP08+2scHPOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110372; c=relaxed/simple;
	bh=0YdpvGTczmIbRkZk+V7qWJYh5oR6u9o2xOsH6ZmNXXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUx7m5t1QjR4OB6FM1SwgqOD2TusIhpFtgPDSYIUpmESNXdfh/zA5UywwQhjar3qQKKjxZWAcH81PIbzCvGzSuo19C7/xUi9K2ERHjW89934RGpptf95qTrzkjYkrg5yiqnCJnPte3f36wli8SbwyczFnXXKpmu6ZqL0lUj9JSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGmNITUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88997C4CEC0;
	Thu, 12 Sep 2024 03:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726110371;
	bh=0YdpvGTczmIbRkZk+V7qWJYh5oR6u9o2xOsH6ZmNXXw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fGmNITUogNiddUa8fMEm/Du/GPFk+ZI6fQZZBg28vmUuxWvK/iuNg/o9lckWeVQaP
	 mwafMe0sLeDTbbrKZIoiiOwi13skYVkEXE5mN+LLR89DS/mMc3TrZMRGRkFigqHNpn
	 RFbDfjyzuLWK9TcqX4kV3iypo39Xgb19U0SCRpNGDnxQtb/wiKinhOJtoUF9l0fTRB
	 1o0s6/C/D0mwy1IIPe38XDA+eK75DdQhMIysVYq4GG4fJzdQTehdODV9so3/mWNQym
	 +3ttizTB4ePj5v9dBT2FL4VNMjuFAXIQR3M2O3lfndL6r9Teiz234D+0L+zwa3+LU3
	 9Q/cimbbmsq2w==
Message-ID: <914e4b84caae7fc14ace9dc6e82a6f94e4cdd4dc.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/5] bpf: Add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, bpf
	 <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 12 Sep 2024 11:06:05 +0800
In-Reply-To: <CAEf4BzamHdsUnRJN1sVA2rrotug8dFOrSUdE6GZAaF83nU58Og@mail.gmail.com>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
	 <026dce3d6903ad189e4b0518a64b60c910e660c0.1725946276.git.tanggeliang@kylinos.cn>
	 <CAEf4BzamHdsUnRJN1sVA2rrotug8dFOrSUdE6GZAaF83nU58Og@mail.gmail.com>
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

On Wed, 2024-09-11 at 14:00 -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 10:37 PM Geliang Tang <geliang@kernel.org>
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
> > Then bpf_for_each() for mptcp_subflow can be used in BPF program
> > like
> > this:
> > 
> >         bpf_rcu_read_lock();
> >         bpf_for_each(mptcp_subflow, subflow, msk)
> >                 kfunc(subflow);
> >         bpf_rcu_read_unlock();
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c | 47 +++++++++++++++++++++++++++++++++++++++++++--
> > --
> >  1 file changed, 43 insertions(+), 4 deletions(-)
> > 
> 
> Not sure why, but only this patch made it to the BPF mailing list?
> Did
> you cc bpf@vger on all patches?

This patch is for "mptcp-next" [1], it depends on the "new MPTCP
subflow subtest" which is under review on the bpf list. We will send it
to the bpf list very soon.

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1726023577.git.tanggeliang@kylinos.cn/

> 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 6414824402e6..350672e24a3d 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -201,9 +201,48 @@ static const struct btf_kfunc_id_set
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
> > +       if (!msk)
> > +               return -EINVAL;
> 
> you still need to initialize at least kit->msk to NULL to prevent
> next
> implementation below doing the wrong thing
> 
> keep in mind, iterator constructor returning error doesn't prevent
> BPF
> program from still calling next() and destroy(), so implementation
> has
> to set iterator state such that next can return NULL if iterator was
> never successfully initialized
> 

I'll move "kit->msk = msk;" earlier like this:

{
        struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;

        kit->msk = msk;
        if (!msk)
                return -EINVAL;

        kit->pos = &msk->conn_list;
        return 0;
}

> pw-bot: cr
> 
> > +
> > +       kit->msk = msk;
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
> 
> you should check if (!msk) early here, before accessing kit->pos-
> >next below
> 
> > +       subflow = list_entry((kit->pos)->next, struct
> > mptcp_subflow_context, node);
> 
> nit: why () around kit->pos?
> 
> > +       if (!msk || list_entry_is_head(subflow, &msk->conn_list,
> > node))
> 
> as I mentioned, !msk check seems too late. Maybe list_entry_is_head()
> is a bit too late as well?

We can use list_is_last() to check kit->pos earlier. But here we use
list_entry_is_head(), it should be after list_entry().

I'll move "if (!msk)" check earlier like this:

{
        struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
        struct mptcp_subflow_context *subflow;
        struct mptcp_sock *msk = kit->msk;

        if (!msk)
                return NULL;

        subflow = list_entry(kit->pos->next, struct
mptcp_subflow_context, node);
        if (!subflow || list_entry_is_head(subflow, &msk->conn_list,
node))
                return NULL;

        kit->pos = &subflow->node;
        return subflow;
}

Thanks,
-Geliang

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
> > @@ -218,7 +257,7 @@ __bpf_kfunc bool
> > bpf_mptcp_subflow_queues_empty(struct sock *sk)
> >         return tcp_rtx_queue_empty(sk);
> >  }
> > 
> > -__diag_pop();
> > +__bpf_kfunc_end_defs();
> > 
> >  BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> >  BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
> > --
> > 2.43.0
> > 
> > 


