Return-Path: <bpf+bounces-40456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2545988D6D
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 03:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3E7B21CD9
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6C125B9;
	Sat, 28 Sep 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JjqPZbsi"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F018179AE
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727487303; cv=none; b=A1qB2t23fiMUc6m1etxBgKOVYr88BkBw1rbNxyUmVeoAMNLWLdLSDVHIsKZLZpzub5nG71Y022hb8vQMBMUQIvR4olMVkTbp43QCArXGT9uNyOC7/PnWCzwrmGtp94RYGHVBxRrpEdYLTRi25++JxwG0VSCJkh01gGcWcpfxSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727487303; c=relaxed/simple;
	bh=yHy0N4o/w0oGDjPNA6N1+Zu8Jd5fpOEzhTrsk3dhHho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3RgYbpVc1dnTB249R6tVWUYlm+nFU7d9Z12ohUplX5DmFgdnDw/AbLcotG69ApCSSzFNsrFoSjeAEFAnFwqreBu6M1ZkrXaLk9PJnoKeoUeUA7/40IMbcmKh8H/fUXHpcBxrKCMkgqTehi8IgpYw2dyxigBq7yjACreL7bh954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JjqPZbsi; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7829ef57-60e2-4648-b9cf-2d756fd85533@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727487299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGnY+WSXJZfDOV8f0OsUsD+4XFnt/k2AUHg+IRBL8oo=;
	b=JjqPZbsirQJCYqGZeFneL3mDx5tx4/i/5OvYGrb1PpV34x8gN98yg+1ZSURIae1AzjJIrE
	kWWhDl4RALRVJ53StbhP35RvRvfB6eSt0p7JWFwBAgi7+/OvUYSgWGTHiC4hCPRNMqvARf
	TBI3Hp1XzFkMxdtN+E8tNjcma51XoWM=
Date: Fri, 27 Sep 2024 18:34:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next v5 1/5] bpf: Add mptcp_subflow bpf_iter
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, mptcp@lists.linux.dev,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
 <5e5b91efc6e06a90fb4d2440ddcbe9b55ee464be.1726132802.git.tanggeliang@kylinos.cn>
 <CAEf4BzaVzVhoqhzpq-FD5GGJT1wW5=LbZ4ADs2+NdLO5rcJMMw@mail.gmail.com>
 <a9bd9aa00c702f98d86f5d7acd305cc477a4c91b.camel@kernel.org>
 <CAEf4Bza4qtP5EVOk08XmGOjWgy1-671gciK5j5vg5Lr=5ggm0Q@mail.gmail.com>
 <849457c0-5a34-4d5d-9c4f-ba004809269b@linux.dev>
 <766062c8fd8920dcc51e7ab2c097541d96bb8ab8.camel@kernel.org>
 <b623745d19dd1d9743674def8d565ef779ef0952.camel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b623745d19dd1d9743674def8d565ef779ef0952.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/14/24 12:12 PM, Geliang Tang wrote:
>>>>>>> @@ -241,6 +286,8 @@ static int __init
>>>>>>> bpf_mptcp_kfunc_init(void)
>>>>>>>           int ret;
>>>>>>>
>>>>>>>           ret =
>>>>>>> register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
>>>>>>> +       ret = ret ?:
>>>>>>> register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
>>>>>>> +
>>>>>>> &bpf_mptcp_sched_kfunc_set);
>>>
>>> This cannot be used in tracing.
>>
>> Actually, we don’t need to use mptcp_subflow bpf_iter in tracing.
>>
>> We plan to use it in MPTCP BPF packet schedulers, which are not
>> tracing, but "struct_ops" types. And they work well with
>> KF_TRUSTED_ARGS flag in bpf_iter_mptcp_subflow_new:
>>
>> BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW |
>> KF_TRUSTED_ARGS);
>>
>> An example of the scheduler is:
>>
>> SEC("struct_ops")
>> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
>>               struct mptcp_sched_data *data)
>> {
>>          struct mptcp_subflow_context *subflow;
>>
>>          bpf_rcu_read_lock();
>>          bpf_for_each(mptcp_subflow, subflow, msk) {
>>                  mptcp_subflow_set_scheduled(subflow, true);
>>                  break;
>>          }
>>          bpf_rcu_read_unlock();
>>
>>          return 0;
>> }
>>
>> SEC(".struct_ops")
>> struct mptcp_sched_ops first = {
>>          .init           = (void *)mptcp_sched_first_init,
>>          .release        = (void *)mptcp_sched_first_release,
>>          .get_subflow    = (void *)bpf_first_get_subflow,
>>          .name           = "bpf_first",
>> };
>>
>> But BPF mptcp_sched_ops code has not been merged into bpf-next yet,
>> so
>> I simply test this bpf_for_each(mptcp_subflow) in tracing since I
>> noticed other bpf_iter selftests are using tracing too:
>>
>> progs/iters_task.c
>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>>
>> progs/iters_css.c
>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>>
>> If this bpf_for_each(mptcp_subflow) can only be used in struct_ops, I
>> will try to move the selftest into a struct_ops.
>>
>>>
>>> Going back to my earlier question in v1. How is the msk->conn_list
>>> protected?
>>>
>>
>> msk->conn_list is protected by msk socket lock. (@Matt, am I right?)
>> We use this in kernel code:

A KF_TRUSTED_ARGS msk does not mean its sock locked. That said, only the tp_btf 
should have trusted msk args but still it is hard to audit all existing and 
future tracepoints which may or may not have msk lock held.

If the subflow list is rcu-ify, it will be easier to reason for tracing use 
case. Regardless, the use case is not for tracing, so this discussion is 
probably moot now.

>>
>> 	struct sock *sk = (struct sock *)msk;
>>
>> 	lock_sock(sk);
>> 	kfunc(&msk->conn_list);
>> 	release_sock(sk);
>>
>> If so, should we also use lock_sock/release_sock in
>> bpf_iter_mptcp_subflow_next()?
> 
> bpf_for_each(mptcp_subflow) is expected to be used in the get_subflow()
> interface of mptcp_sched_ops to traverse all subflows and then pick one
> subflow to send data. This interface is invoked in
> mptcp_sched_get_send(), here the msk socket lock is hold already:
> 
> int mptcp_sched_get_send(struct mptcp_sock *msk)
> {
>          struct mptcp_subflow_context *subflow;
>          struct mptcp_sched_data data;
> 
>          msk_owned_by_me(msk);
> 
> 	... ...
> 
>          mptcp_for_each_subflow(msk, subflow) {
>                  if (READ_ONCE(subflow->scheduled))
>                          return 0;
>          }
> 
>          data.reinject = false;
>          if (msk->sched == &mptcp_sched_default || !msk->sched)
>                  return mptcp_sched_default_get_subflow(msk, &data);
>          return msk->sched->get_subflow(msk, &data);
> }
> 
> So no need to hold msk socket lock again in BPF schedulers. This means
> we can walk the conn_list without any lock. bpf_rcu_read_lock() and
> bpf_rcu_read_unlock() can be dropped in BPF schedulers too. Am I right?

hmm... don't know how bpf_rcu_read_lock() comes into picture considering the msk 
lock has already been held in the struct_ops that you are planning to add.

Something you may need to consider on the subflow locking situation. Not sure 
exactly what the bpf prog needs to do on a subflow. e.g. If it needs to change 
some fields in the subflow, does it need to lock the subflow or the msk lock is 
good enough.

