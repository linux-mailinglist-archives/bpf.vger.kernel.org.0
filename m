Return-Path: <bpf+bounces-66137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4AB2E97D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59288681315
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206571CEADB;
	Thu, 21 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ipSeWOOF"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9241C4A10
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736589; cv=none; b=RRVW6KwSEvxBvUeMxYooYn7i1Oy4Pl6nVUt4MiFHWKfC6SPXRk6ANOYP6cFoL9osX92eC6TFJhenJkJe9Rm89bm6dv7Nk0IWZQDYrWhkfDxh0s0NYNI31XEVREZzPNeap6hL1QGMdjCpX+R8DuUeRcYpc6zjDxrUg8rP+mQvRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736589; c=relaxed/simple;
	bh=1ZrZkwfjdjBIGf7+TCFHT8kuNz8Ew45xVedvbr+IWhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/AnTOZMiGMHVXz4CvlTz+cQIMJx6Ys0k6Q03rFQ9KJ8gMGezmNUrW+xw18J6VV3ClM/esLCjNnP3Q0bT+YZmqLQP8Qy3NKcec7t/BoDl71z8IxeRPwt7JRCpWjABLNBPkLHsk5Ai8K0rz+wvzVNYwa9+FvE5M/kWiO3QxvRmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ipSeWOOF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755736575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmAgbVQ/ACAO5m7Amd6P0JATfhN3du7SEHI/iZDYSQI=;
	b=ipSeWOOFYKfsVwr4p3rcwTbO+HBxyw+cONhpnJopIZx3iQVIWk3w/CurYP7/J69ul6kN8g
	KQX6FA8i3o6GOpVAAb2PslhjoElKxda3gzx2NI3NCwOYDzq+zH1Ds6UL4zIQxwHajXjDKs
	6hU1b8DZMuCN+/AUJtTGnoL4pDYJWz0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/14] sched: psi: implement bpf_psi_create_trigger()
 kfunc
In-Reply-To: <CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 20 Aug 2025 13:30:43 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-14-roman.gushchin@linux.dev>
	<CAEf4BzaSLWB1xpCjX35oxg2ySvvgRvEmQ01PtXv+xEz-Zkz07w@mail.gmail.com>
Date: Wed, 20 Aug 2025 17:36:05 -0700
Message-ID: <87ect5lde2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Aug 18, 2025 at 10:06=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> Implement a new bpf_psi_create_trigger() bpf kfunc, which allows
>> to create new psi triggers and attach them to cgroups or be
>> system-wide.
>>
>> Created triggers will exist until the struct ops is loaded and
>> if they are attached to a cgroup until the cgroup exists.
>>
>> Due to a limitation of 5 arguments, the resource type and the "full"
>> bit are squeezed into a single u32.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>>  kernel/sched/bpf_psi.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
>> index 2ea9d7276b21..94b684221708 100644
>> --- a/kernel/sched/bpf_psi.c
>> +++ b/kernel/sched/bpf_psi.c
>> @@ -156,6 +156,83 @@ static const struct bpf_verifier_ops bpf_psi_verifi=
er_ops =3D {
>>         .is_valid_access =3D bpf_psi_ops_is_valid_access,
>>  };
>>
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_psi_create_trigger - Create a PSI trigger
>> + * @bpf_psi: bpf_psi struct to attach the trigger to
>> + * @cgroup_id: cgroup Id to attach the trigger; 0 for system-wide scope
>> + * @resource: resource to monitor (PSI_MEM, PSI_IO, etc) and the full b=
it.
>> + * @threshold_us: threshold in us
>> + * @window_us: window in us
>> + *
>> + * Creates a PSI trigger and attached is to bpf_psi. The trigger will be
>> + * active unless bpf struct ops is unloaded or the corresponding cgroup
>> + * is deleted.
>> + *
>> + * Resource's most significant bit encodes whether "some" or "full"
>> + * PSI state should be tracked.
>> + *
>> + * Returns 0 on success and the error code on failure.
>> + */
>> +__bpf_kfunc int bpf_psi_create_trigger(struct bpf_psi *bpf_psi,
>> +                                      u64 cgroup_id, u32 resource,
>> +                                      u32 threshold_us, u32 window_us)
>> +{
>> +       enum psi_res res =3D resource & ~BPF_PSI_FULL;
>> +       bool full =3D resource & BPF_PSI_FULL;
>> +       struct psi_trigger_params params;
>> +       struct cgroup *cgroup __maybe_unused =3D NULL;
>> +       struct psi_group *group;
>> +       struct psi_trigger *t;
>> +       int ret =3D 0;
>> +
>> +       if (res >=3D NR_PSI_RESOURCES)
>> +               return -EINVAL;
>> +
>> +#ifdef CONFIG_CGROUPS
>> +       if (cgroup_id) {
>> +               cgroup =3D cgroup_get_from_id(cgroup_id);
>> +               if (IS_ERR_OR_NULL(cgroup))
>> +                       return PTR_ERR(cgroup);
>> +
>> +               group =3D cgroup_psi(cgroup);
>> +       } else
>> +#endif
>> +               group =3D &psi_system;
>
> just a drive-by comment while skimming through the patch set: can't
> you use IS_ENABLED(CONFIG_CGROUPS) and have a proper if/else with
> proper {} ?

Fixed.
It required defining cgroup_get_from_id() and cgroup_psi()
for !CONFIG_CGROUPS, but I agree, it's much better.
Thanks

>
>> +
>> +       params.type =3D PSI_BPF;
>> +       params.bpf_psi =3D bpf_psi;
>> +       params.privileged =3D capable(CAP_SYS_RESOURCE);
>> +       params.res =3D res;
>> +       params.full =3D full;
>> +       params.threshold_us =3D threshold_us;
>> +       params.window_us =3D window_us;
>> +
>> +       t =3D psi_trigger_create(group, &params);
>> +       if (IS_ERR(t))
>> +               ret =3D PTR_ERR(t);
>> +       else
>> +               t->cgroup_id =3D cgroup_id;
>> +
>> +#ifdef CONFIG_CGROUPS
>> +       if (cgroup)
>> +               cgroup_put(cgroup);
>> +#endif
>> +
>> +       return ret;
>> +}
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_KFUNCS_START(bpf_psi_kfuncs)
>> +BTF_ID_FLAGS(func, bpf_psi_create_trigger, KF_TRUSTED_ARGS)
>> +BTF_KFUNCS_END(bpf_psi_kfuncs)
>> +
>> +static const struct btf_kfunc_id_set bpf_psi_kfunc_set =3D {
>> +       .owner          =3D THIS_MODULE,
>> +       .set            =3D &bpf_psi_kfuncs,
>> +};
>> +
>>  static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
>>  {
>>         struct bpf_psi_ops *ops =3D kdata;
>> @@ -238,6 +315,13 @@ static int __init bpf_psi_struct_ops_init(void)
>>         if (!bpf_psi_wq)
>>                 return -ENOMEM;
>>
>> +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>> +                                       &bpf_psi_kfunc_set);
>
> would this make kfunc callable from any struct_ops, not just this psi
> one?

It will. Idk how big of a problem it is, given that the caller needs
a trusted reference to bpf_psi. Also, is there a simple way to constrain
it? Wdyt?

