Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C8621D8C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 21:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKHUTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 15:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHUTn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 15:19:43 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E61A80A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 12:19:42 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b21so15157851plc.9
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pP2lyR7gKhRxnDBz/TA+PtrfZTZ93qVS1Fmo2twTGw=;
        b=QGGXifSf+KZC7Cg8OXL5oJBy5doIEr29IcgiDp3pXLjcO9FTFZmglA97bOvYmfEIPs
         9kR2530YAYldBAZacfxa5KnH9fiDSSgIDYI82Ka4URWwaylUit4P15v4xQR+9PUYz65W
         cnqK2nJ5mnc0E2NqWp5AeUf5l5ESnqNhlN3tEyroDhpVV+c1IQ9evl12VVuodYRveN/F
         Inp4TvX7hvoeoeWOpNjDG4oiu6O5rV5FYOMcn7fOoXbeJYCM54xox+G0E+gLRUFroaDV
         WXNU88UYJwtHAGUu1R3/7OU/qihh0GpzFrBFNHf6MD7qewhdI/hzgllLEUMwf3u1/lwk
         c4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pP2lyR7gKhRxnDBz/TA+PtrfZTZ93qVS1Fmo2twTGw=;
        b=fj2MO/+RrpC8kyR6PDEy7ePLJGtqvrG8l2uQb3h4zcSJMrJh1kkrbhlH/CjBo2ONzB
         jPSnEDvLdLGifPDKeEZtMGarZUvq5qfwyqZcln3eXUathhlv7sUhPmR6agEnoH+KwAQ5
         PRW3mLkll8ncsXJ3ePWNZkeKzDaWgrWDC5buKCDkHrrhrD/7fyH6emuEu5spjbMwd2rf
         rfNIA21w0iHWglwmwYR+eK05VZeFoPhTI7Tc9GxEvrUp5gRR5Jda02sHfF2alU7lbQda
         XJnygzXgOuYHNosuyck32wsu+OvXIqnWnEgOg1BBDSsaJrJ9zHZ9fLUDFV5rUAeWJOq5
         tgJA==
X-Gm-Message-State: ACrzQf3GhzhZ6VchDTFAf77NtMPH9Ay0u5YXt7ggs7l8/zFuNj2+DonE
        yKNcQZadm/LADTmlKmJ3VshFQ3CCnPJg0ftB
X-Google-Smtp-Source: AMsMyM65MIVRy6wCv81WKxnPrkIz9fuD/k1VSjwf5rQE5iVcDeehqHa3I8VlKy3fbO2mRaJsWWWRZA==
X-Received: by 2002:a17:90b:3b4a:b0:213:589d:d300 with SMTP id ot10-20020a17090b3b4a00b00213589dd300mr58617976pjb.139.1667938781763;
        Tue, 08 Nov 2022 12:19:41 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w9-20020a628209000000b005544229b992sm6776602pfd.22.2022.11.08.12.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:19:41 -0800 (PST)
Date:   Wed, 9 Nov 2022 01:49:38 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 5/8] bpf: Add bpf_rcu_read_lock() verifier
 support
Message-ID: <20221108201938.byemttanmpbh3gn4@apollo>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074114.264485-1-yhs@fb.com>
 <20221108170452.jq24rymkfeozxtwj@apollo>
 <04ed904e-a901-70ea-ddb6-a87aa5bd2736@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ed904e-a901-70ea-ddb6-a87aa5bd2736@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 01:33:04AM IST, Yonghong Song wrote:
>
>
> On 11/8/22 9:04 AM, Kumar Kartikeya Dwivedi wrote:
> > On Tue, Nov 08, 2022 at 01:11:14PM IST, Yonghong Song wrote:
> > > To simplify the design and support the common practice, no
> > > nested bpf_rcu_read_lock() is allowed. During verification,
> > > each paired bpf_rcu_read_lock()/unlock() has a unique
> > > region id, starting from 1. Each rcu ptr register also
> > > remembers the region id when the ptr reg is initialized.
> > > The following is a simple example to illustrate the
> > > rcu lock regions and usage of rcu ptr's.
> > >
> > >       ...                    <=== rcu lock region 0
> > >       bpf_rcu_read_lock()    <=== rcu lock region 1
> > >       rcu_ptr1 = ...         <=== rcu_ptr1 with region 1
> > >       ... using rcu_ptr1 ...
> > >       bpf_rcu_read_unlock()
> > >       ...                    <=== rcu lock region -1
> > >       bpf_rcu_read_lock()    <=== rcu lock region 2
> > >       rcu_ptr2 = ...         <=== rcu_ptr2 with region 2
> > >       ... using rcu_ptr2 ...
> > >       ... using rcu_ptr1 ... <=== wrong, region 1 rcu_ptr in region 2
> > >       bpf_rcu_read_unlock()
> > >
> > > Outside the rcu lock region, the rcu lock region id is 0 or negative of
> > > previous valid rcu lock region id, so the next valid rcu lock region
> > > id can be easily computed.
> > >
> > > Note that rcu protection is not needed for non-sleepable program. But
> > > it is supported to make cross-sleepable/nonsleepable development easier.
> > > For non-sleepable program, the following insns can be inside the rcu
> > > lock region:
> > >    - any non call insns except BPF_ABS/BPF_IND
> > >    - non sleepable helpers or kfuncs
> > > Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
> > > allocation flag) should be GFP_ATOMIC.
> > >
> > > If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
> > > this pointer and the load which gets this pointer needs to be
> > > protected by bpf_rcu_read_lock(). The following shows a couple
> > > of examples:
> > >    struct task_struct {
> > >          ...
> > >          struct task_struct __rcu        *real_parent;
> > >          struct css_set __rcu            *cgroups;
> > >          ...
> > >    };
> > >    struct css_set {
> > >          ...
> > >          struct cgroup *dfl_cgrp;
> > >          ...
> > >    }
> > >    ...
> > >    task = bpf_get_current_task_btf();
> > >    cgroups = task->cgroups;
> > >    dfl_cgroup = cgroups->dfl_cgrp;
> > >    ... using dfl_cgroup ...
> > >
> > > The bpf_rcu_read_lock/unlock() should be added like below to
> > > avoid verification failures.
> > >    task = bpf_get_current_task_btf();
> > >    bpf_rcu_read_lock();
> > >    cgroups = task->cgroups;
> > >    dfl_cgroup = cgroups->dfl_cgrp;
> > >    bpf_rcu_read_unlock();
> > >    ... using dfl_cgroup ...
> > >
> > > The following is another example for task->real_parent.
> > >    task = bpf_get_current_task_btf();
> > >    bpf_rcu_read_lock();
> > >    real_parent = task->real_parent;
> > >    ... bpf_task_storage_get(&map, real_parent, 0, 0);
> > >    bpf_rcu_read_unlock();
> > >
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >   include/linux/bpf.h          |  1 +
> > >   include/linux/bpf_verifier.h |  7 +++
> > >   kernel/bpf/btf.c             | 32 ++++++++++++-
> > >   kernel/bpf/verifier.c        | 92 +++++++++++++++++++++++++++++++-----
> > >   4 files changed, 120 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index b4bbcafd1c9b..98af0c9ec721 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -761,6 +761,7 @@ struct bpf_prog_ops {
> > >   struct btf_struct_access_info {
> > >   	u32 next_btf_id;
> > >   	enum bpf_type_flag flag;
> > > +	bool is_rcu;
> > >   };
> > >
> > >   struct bpf_verifier_ops {
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 1a32baa78ce2..5d703637bb12 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -179,6 +179,10 @@ struct bpf_reg_state {
> > >   	 */
> > >   	s32 subreg_def;
> > >   	enum bpf_reg_liveness live;
> > > +	/* 0: not rcu ptr; > 0: rcu ptr, id of the rcu read lock region where
> > > +	 * the rcu ptr reg is initialized.
> > > +	 */
> > > +	int active_rcu_lock;
> > >   	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
> > >   	bool precise;
> > >   };
> > > @@ -324,6 +328,8 @@ struct bpf_verifier_state {
> > >   	u32 insn_idx;
> > >   	u32 curframe;
> > >   	u32 active_spin_lock;
> > > +	/* <= 0: not in rcu read lock region; > 0: the rcu lock region id */
> > > +	int active_rcu_lock;
> > >   	bool speculative;
> > >
> > >   	/* first and last insn idx of this verifier state */
> > > @@ -424,6 +430,7 @@ struct bpf_insn_aux_data {
> > >   	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
> > >   	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
> > >   	bool zext_dst; /* this insn zero extends dst reg */
> > > +	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
> > >   	u8 alu_state; /* used in combination with alu_limit */
> > >
> > >   	/* below fields are initialized once */
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index d2ee1669a2f3..c5a9569f2ae0 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -5831,6 +5831,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
> > >   		if (btf_type_is_ptr(mtype)) {
> > >   			const struct btf_type *stype, *t;
> > >   			enum bpf_type_flag tmp_flag = 0;
> > > +			bool is_rcu = false;
> > >   			u32 id;
> > >
> > >   			if (msize != size || off != moff) {
> > > @@ -5850,12 +5851,16 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
> > >   				/* check __percpu tag */
> > >   				if (strcmp(tag_value, "percpu") == 0)
> > >   					tmp_flag = MEM_PERCPU;
> > > +				/* check __rcu tag */
> > > +				if (strcmp(tag_value, "rcu") == 0)
> > > +					is_rcu = true;
> > >   			}
> > >
> > >   			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
> > >   			if (btf_type_is_struct(stype)) {
> > >   				info->next_btf_id = id;
> > >   				info->flag = tmp_flag;
> > > +				info->is_rcu = is_rcu;
> > >   				return WALK_PTR;
> > >   			}
> > >   		}
> > > @@ -6317,7 +6322,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >   {
> > >   	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> > >   	bool rel = false, kptr_get = false, trusted_args = false;
> > > -	bool sleepable = false;
> > > +	bool sleepable = false, rcu_lock = false, rcu_unlock = false;
> > >   	struct bpf_verifier_log *log = &env->log;
> > >   	u32 i, nargs, ref_id, ref_obj_id = 0;
> > >   	bool is_kfunc = btf_is_kernel(btf);
> > > @@ -6356,6 +6361,31 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> > >   		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
> > >   		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
> > >   		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
> > > +		rcu_lock = kfunc_meta->flags & KF_RCU_LOCK;
> > > +		rcu_unlock = kfunc_meta->flags & KF_RCU_UNLOCK;
> > > +	}
> > > +
> > > +	/* checking rcu read lock/unlock */
> > > +	if (env->cur_state->active_rcu_lock > 0) {
> > > +		if (rcu_lock) {
> > > +			bpf_log(log, "nested rcu read lock (kernel function %s)\n", func_name);
> > > +			return -EINVAL;
> > > +		} else if (rcu_unlock) {
> > > +			/* change active_rcu_lock to its corresponding negative value to
> > > +			 * preserve the previous lock region id.
> > > +			 */
> > > +			env->cur_state->active_rcu_lock = -env->cur_state->active_rcu_lock;
> > > +		} else if (sleepable) {
> > > +			bpf_log(log, "kernel func %s is sleepable within rcu_read_lock region\n",
> > > +				func_name);
> > > +			return -EINVAL;
> > > +		}
> > > +	} else if (rcu_lock) {
> > > +		/* a new lock region started, increase the region id. */
> > > +		env->cur_state->active_rcu_lock = (-env->cur_state->active_rcu_lock) + 1;
> > > +	} else if (rcu_unlock) {
> > > +		bpf_log(log, "unmatched rcu read unlock (kernel function %s)\n", func_name);
> > > +		return -EINVAL;
> > >   	}
> > >
> >
> > Can you provide more context on why having ids is better than simply
> > invalidating the registers when the section ends, and making active_rcu_lock a
> > boolean instead? You can use bpf_for_each_reg_in_vstate to find every reg having
> > MEM_RCU and mark it unknown.
>
> I think we also need to invalidate rcu-ptr related states as well in spills.
>
> I also tried to support cases like:
> 	bpf_rcu_read_lock();
> 	rcu_ptr = ...
> 	   ... rcu_ptr ...
> 	bpf_rcu_read_unlock();
> 	... rcu_ptr ... /* no load, just use the rcu_ptr somehow */
>
> In the above case, outside the rcu read lock region, there is no
> load with rcu_ptr but it can still be used for other purposes
> with a property of a pointer.
>
> But for a second thought, it should be okay to invalidate
> rcu_ptr during bpf_rcu_read_unlock() as a scalar. This should
> satisfy almost all (if not all) cases.
>
> >
> > You won't have to match the id in btf_struct_access as such registers won't ever
> > reach that function (if marked unknown on invalidation, they become scalars).
> > The reg state won't need another active_rcu_lock member either, it is simply
> > part of reg->type.
>
> Right, if I don't maintain region id's, no need to have reg->active_rcu_lock
> and using MEM_RCU should be enough.
>
> >
> > It seems to that simply invalidating registers when rcu_read_unlock is called is
> > both less code to write and simpler to understand.
>
> invalidating rcu_ptr in registers and spills.
>

If you use bpf_for_each_reg_in_vstate, it should cover both.
