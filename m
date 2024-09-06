Return-Path: <bpf+bounces-39112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C682096F0C9
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF621F2349C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B71C9870;
	Fri,  6 Sep 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNc1c5GM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A9F17BBE;
	Fri,  6 Sep 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616968; cv=none; b=eU6K3P/SsULS4zd4NxFKa/GZeef8DG4w5pba5jiSqc+T7OCVBZvsGP0Eo1Do5uaQUO79wkm2Elx4IkSwhEN2DeELR+HTslF9dY0kYfWp/oIIGC/7XCg2YYOxcze+1MJYJFPayRi2Zr7MFPvd2GyzS3SxLN6YSz+vmmXh5SCMAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616968; c=relaxed/simple;
	bh=iYA90GDpqgtTo5U9amp1FTYHBndZHESotRROhndrYU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EFTk/NUucpeZXDMfCD70fMeljtu4qtNFVsFbFI0uf89TEevM9l1P/R3pwyBU2JpmFnMzqNCZ8Wv0xai8GWU/2mmuwYmF6WnpYiMezz8b3SNisRfyVVXRojG9Hqga2QKSpru/eTCurDlFK0O8XWXACtMgmNEBDSs5I7HcAOeMEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNc1c5GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC978C4CEC4;
	Fri,  6 Sep 2024 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725616967;
	bh=iYA90GDpqgtTo5U9amp1FTYHBndZHESotRROhndrYU0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WNc1c5GMH4SIZuzb1eANockt0P5pTnrLkblRvSprYWFrga6f2eDQWlb3eJYiLluJN
	 euS7IGc+M3YKuzfBj9bWjvXR1ttNBbGDZsvAN/7EbgMbkMNPV203la4KYDc37w4NZE
	 IygNJRkl82JmxuHqVbbWmWBsqpq7uHkMWCmMJVpKLqzGnxF60saiL9UxR8SDBD/3iz
	 G4Kf/F7C5ARnKCRhr3IgYc3j9vRcWvKfBvdpfOptmmL0WupkSfDGzhfZjzTWgYb4hQ
	 d0aonECpvj7sqITmF2JCDDq6OE+Z7nrGltQ3vEJ+2ulYp+CSVNPY+qnfGyO1h8xhjz
	 8x7tbRIXiTWhA==
Message-ID: <18eb1fcd91e7283fda1932ff72e2d0cc53dc9e56.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] bpf: Add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Martin KaFai Lau
	 <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Date: Fri, 06 Sep 2024 18:02:43 +0800
In-Reply-To: <288ad1c2-501a-4319-bc1e-e7a7e276ff63@linux.dev>
References: <cover.1725544210.git.tanggeliang@kylinos.cn>
	 <a75fc3e8df7141ce582448d3f092871a4943fbf4.1725544210.git.tanggeliang@kylinos.cn>
	 <288ad1c2-501a-4319-bc1e-e7a7e276ff63@linux.dev>
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

Hi Martin,

On Thu, 2024-09-05 at 11:24 -0700, Martin KaFai Lau wrote:
> On 9/5/24 6:52 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > It's necessary to traverse all subflows on the conn_list of an
> > MPTCP
> > socket and then call kfunc to modify the fields of each subflow. In
> > kernel space, mptcp_for_each_subflow() helper is used for this:
> > 
> >   mptcp_for_each_subflow(msk, subflow)
> >           kfunc(subflow);
> > 
> > But in the MPTCP BPF program, this has not yet been implemented. As
> > Martin suggested recently, this conn_list walking + modify-by-kfunc
> > usage fits the bpf_iter use case.
> > 
> > This patch adds a new bpf_iter type named "mptcp_subflow" to do
> > this.
> > 
> > Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >   kernel/bpf/helpers.c |  3 +++
> >   net/mptcp/bpf.c      | 57
> > ++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 60 insertions(+)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index b5f0adae8293..2340ba967444 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3023,6 +3023,9 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT |
> > KF_RET_NULL)
> >   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
> > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
> >   BTF_KFUNCS_END(common_btf_ids)
> >   
> >   static const struct btf_kfunc_id_set common_kfunc_set = {
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 9672a70c24b0..cda09bbfd617 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -204,6 +204,63 @@ static const struct btf_kfunc_id_set
> > bpf_mptcp_fmodret_set = {
> >    .set   = &bpf_mptcp_fmodret_ids,
> >   };
> >   
> > +struct bpf_iter__mptcp_subflow {
> > + __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > + __bpf_md_ptr(struct mptcp_sock *, msk);
> > + __bpf_md_ptr(struct list_head *, pos);
> > +};
> > +
> > +DEFINE_BPF_ITER_FUNC(mptcp_subflow, struct bpf_iter_meta *meta,
> > +      struct mptcp_sock *msk, struct list_head *pos)
> > +
> > +struct bpf_iter_mptcp_subflow {
> > + __u64 __opaque[3];
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_iter_mptcp_subflow_kern {
> > + struct mptcp_sock *msk;
> > + struct list_head *pos;
> > +} __attribute__((aligned(8)));
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
> > bpf_iter_mptcp_subflow *it,
> > +    struct mptcp_sock *msk)
> > +{
> > + struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > +
> > + kit->msk = msk;
> > + kit->pos = &msk->conn_list;
> > + spin_lock_bh(&msk->pm.lock);
> 
> I don't think spin_lock here without unlock can be used. e.g. What if
> bpf_iter_mptcp_subflow_new() is called twice back-to-back.
> 
> I haven't looked at the mptcp details, some questions:
> The list is protected by msk->pm.lock?
> What happen to the sk_lock of the msk?
> Can this be rcu-ify? or it needs some cares when walking the
> established TCP 
> subflow?

Thank you for your review. msk->pm.lock shouldn't be used here. The
conn_list is not protected by msk->pm.lock. I will remove it in v2.

> 
> 
> [ Please cc the bpf list. Helping to review patches is a good way to
> contribute 
> back to the mailing list. ]

This patch is for "mptcp-next", it depends on the "new MPTCP subflow
subtest" which is under review on the bpf list. We will send it to the
bpf list very soon.

Thanks,
-Geliang

> 
> > +
> > + return 0;
> > +}
> > +
> > +__bpf_kfunc struct mptcp_subflow_context *
> > +bpf_iter_mptcp_subflow_next(struct bpf_iter_mptcp_subflow *it)
> > +{
> > + struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > + struct mptcp_subflow_context *subflow;
> > + struct mptcp_sock *msk = kit->msk;
> > +
> > + subflow = list_entry((kit->pos)->next, struct
> > mptcp_subflow_context, node);
> > + if (list_entry_is_head(subflow, &msk->conn_list, node))
> > + return NULL;
> > +
> > + kit->pos = &subflow->node;
> > + return subflow;
> > +}
> > +
> > +__bpf_kfunc void bpf_iter_mptcp_subflow_destroy(struct
> > bpf_iter_mptcp_subflow *it)
> > +{
> > + struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
> > + struct mptcp_sock *msk = kit->msk;
> > +
> > + spin_unlock_bh(&msk->pm.lock);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> >   __diag_push();
> >   __diag_ignore_all("-Wmissing-prototypes",
> >      "kfuncs which will be used in BPF programs");
> 


