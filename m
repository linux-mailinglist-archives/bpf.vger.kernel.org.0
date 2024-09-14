Return-Path: <bpf+bounces-39894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6E978FE5
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 12:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72581C21E82
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D421CEAA7;
	Sat, 14 Sep 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFNWIMHx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1513B280;
	Sat, 14 Sep 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726308763; cv=none; b=GCjZqSjyNAiio4iX1STW0vP2umOoy2Nq0MSlegRIF7Z+/Svb+IN4okZyv0dkdRayh+2mTZaxMoYcG6cappJRfyoA4WwT4D3EkvPmHwIGeCH1SfPWMy3q0vO9mE4J+GxcGU3sMBedV5R4XIFH6UMCBDwBaCdb4/d+K1u9m0hWIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726308763; c=relaxed/simple;
	bh=/wvBbstadsYKOA9TpfXl2WOHHiShhGngkgmK4RiUXLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IWdDwk9heiNxn5EMovmIKu0Uik1IQvWZmSrqaDk0BWQt+4zkss/F3hNJjLJAfq1744s4vVjtG2CidFjB2CtsUfJa3GlYiFSP+admoZ7EQ9ODRvxLqOW1XQY2MHIrh34gP+RWtGaSeFfYQ3XbVUQHGdtpKxF2+nBp3jHL8j8drXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFNWIMHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F77C4CEC0;
	Sat, 14 Sep 2024 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726308762;
	bh=/wvBbstadsYKOA9TpfXl2WOHHiShhGngkgmK4RiUXLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HFNWIMHx+Mp4SXtPRaZxlvwChVk+C78KCG6SdHsfv588X2fJ5uHjGgwP/us9QxZHX
	 VuZo2GwKAlbFiz3zv5vr1slcWQx3KChCJ5Nuk6GW6rBnZi3XEW2si1IM6PtFJihtMd
	 HsyoqWTQt7fiant+Z/BwsIGBgXsLRBtF5iSgXWQFK5i91sGi3cJVCFX+eBUTB62jqt
	 TSLYQAhHO88oiZw/3Pe4hAbIBBpSZzlMo0f8Bdh6VNxm6SaoYrljh8UgqgWU7cbcIs
	 a3OEaMK8pwQJ4SVGDlQJR2xONd0OOm47t0RxcB76i6bpbEbfrSirp1OgeS0szPR1e8
	 KLtKgDmsfyiDg==
Message-ID: <b623745d19dd1d9743674def8d565ef779ef0952.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
From: Geliang Tang <geliang@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, mptcp@lists.linux.dev, 
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, Martin KaFai
 Lau <martin.lau@kernel.org>
Date: Sat, 14 Sep 2024 18:12:36 +0800
In-Reply-To: <766062c8fd8920dcc51e7ab2c097541d96bb8ab8.camel@kernel.org>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
	 <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
	 <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
	 <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
	 <CAEf4Bza4qtP5EVOk08XmGOjWgy1-671gciK5j5vg5Lr=5ggm0Q@mail.gmail.com>
	 <849457c0-5a34-4d5d-9c4f-ba004809269b@linux.dev>
	 <766062c8fd8920dcc51e7ab2c097541d96bb8ab8.camel@kernel.org>
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

On Sat, 2024-09-14 at 16:40 +0800, Geliang Tang wrote:
> Hi Martin, Andrii, Matt,
> 
> On Fri, 2024-09-13 at 17:41 -0700, Martin KaFai Lau wrote:
> > On 9/13/24 1:57 PM, Andrii Nakryiko wrote:
> > > > > > +__bpf_kfunc int bpf_iter_mptcp_subflow_new(struct
> > > > > > bpf_iter_mptcp_subflow *it,
> > > > > > +                                          struct
> > > > > > mptcp_sock
> > > > > > *msk)
> > > > > > +{
> > > > > > +       struct bpf_iter_mptcp_subflow_kern *kit = (void
> > > > > > *)it;
> > > > > > +
> > > > > > +       kit->msk = msk;
> > > > > > +       if (!msk)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       kit->pos = &msk->conn_list;
> > > > > > +       return 0;
> > > > > > +}
> > 
> > [ ... ]
> > 
> > > > > >   BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
> > > > > > +BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
> > > > > 
> > > > > I'm not 100% sure, but I suspect you might need to specify
> > > > > KF_TRUSTED_ARGS here to ensure that `struct mptcp_sock *msk`
> > > > > is
> > > > > a
> > 
> > +1
> 
> So we must add KF_TRUSTED_ARGS flag, right?
> 
> > 
> > > > > > @@ -241,6 +286,8 @@ static int __init
> > > > > > bpf_mptcp_kfunc_init(void)
> > > > > >          int ret;
> > > > > > 
> > > > > >          ret =
> > > > > > register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> > > > > > +       ret = ret ?:
> > > > > > register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > > > > > +
> > > > > > &bpf_mptcp_sched_kfunc_set);
> > 
> > This cannot be used in tracing.
> 
> Actually, we don’t need to use mptcp_subflow bpf_iter in tracing.
> 
> We plan to use it in MPTCP BPF packet schedulers, which are not
> tracing, but "struct_ops" types. And they work well with
> KF_TRUSTED_ARGS flag in bpf_iter_mptcp_subflow_new:
> 
> BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW |
> KF_TRUSTED_ARGS);
> 
> An example of the scheduler is:
> 
> SEC("struct_ops")
> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
>              struct mptcp_sched_data *data)
> {
>         struct mptcp_subflow_context *subflow;
> 
>         bpf_rcu_read_lock();
>         bpf_for_each(mptcp_subflow, subflow, msk) {
>                 mptcp_subflow_set_scheduled(subflow, true);
>                 break;
>         }
>         bpf_rcu_read_unlock();
> 
>         return 0;
> }
> 
> SEC(".struct_ops")
> struct mptcp_sched_ops first = { 
>         .init           = (void *)mptcp_sched_first_init,
>         .release        = (void *)mptcp_sched_first_release,
>         .get_subflow    = (void *)bpf_first_get_subflow,
>         .name           = "bpf_first",
> };
> 
> But BPF mptcp_sched_ops code has not been merged into bpf-next yet,
> so
> I simply test this bpf_for_each(mptcp_subflow) in tracing since I
> noticed other bpf_iter selftests are using tracing too:
> 
> progs/iters_task.c
> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
> 
> progs/iters_css.c
> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
> 
> If this bpf_for_each(mptcp_subflow) can only be used in struct_ops, I
> will try to move the selftest into a struct_ops.
> 
> > 
> > Going back to my earlier question in v1. How is the msk->conn_list
> > protected?
> > 
> 
> msk->conn_list is protected by msk socket lock. (@Matt, am I right?)
> We
> use this in kernel code:
> 
> 	struct sock *sk = (struct sock *)msk;
> 
> 	lock_sock(sk);
> 	kfunc(&msk->conn_list);
> 	release_sock(sk);
> 
> If so, should we also use lock_sock/release_sock in
> bpf_iter_mptcp_subflow_next()?

bpf_for_each(mptcp_subflow) is expected to be used in the get_subflow()
interface of mptcp_sched_ops to traverse all subflows and then pick one
subflow to send data. This interface is invoked in
mptcp_sched_get_send(), here the msk socket lock is hold already:

int mptcp_sched_get_send(struct mptcp_sock *msk)
{
        struct mptcp_subflow_context *subflow;
        struct mptcp_sched_data data;

        msk_owned_by_me(msk);

	... ...

        mptcp_for_each_subflow(msk, subflow) {
                if (READ_ONCE(subflow->scheduled))
                        return 0;
        }

        data.reinject = false;
        if (msk->sched == &mptcp_sched_default || !msk->sched)
                return mptcp_sched_default_get_subflow(msk, &data);
        return msk->sched->get_subflow(msk, &data);
}

So no need to hold msk socket lock again in BPF schedulers. This means
we can walk the conn_list without any lock. bpf_rcu_read_lock() and
bpf_rcu_read_unlock() can be dropped in BPF schedulers too. Am I right?

Thanks,
-Geliang


