Return-Path: <bpf+bounces-8319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FC784D74
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 01:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2792811D1
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639C20F02;
	Tue, 22 Aug 2023 23:45:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B0020EE3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 23:45:34 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E4CFE
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:45:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5657a28f920so3093918a12.3
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692747932; x=1693352732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W//NyNjpvVJf5rvCdf7F8j4DGFtFOv2CgzX+RGyugas=;
        b=WSUKNk+Z4cQNgKi6BbXxUseEio0kW5E/37LjFKpzhxkqPfz10zNowLhbRyA+gUZqwo
         id/DCUi3UWTWibnAk4ZPnu7bMe9FKywe94w8FPgBlh+LK3BLhdPrmt6tS8xTDbUwtCMg
         CqJe9UZrQQBbY3UvY8xW9lP05pMklQzcjjCn+PztbKpXI0CHZK+2OdlW0a0RXMApytFP
         F4VdaHe2oqlZ3tiAq7PbWkEDACEkK0vgdl7fP45dkV7RYVdmnkcncHnBDr2XhSzDh8jv
         zwXAH7rRxkjWWMRAoxEIuq877WaBp8waFQcM3NROAYq0r04ocPEv1EYv4qv8CDsMEOzf
         edNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747932; x=1693352732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W//NyNjpvVJf5rvCdf7F8j4DGFtFOv2CgzX+RGyugas=;
        b=VEQxlXD5ifntKeCR1DW+xSDnMfyjCY3H576+uOoa05SSpibbVE/7MrFAfQJiWeB9RH
         4cvKpOwJ/qJBZfAh1B7XHq0/FAvk8MQB2GpILwBXOeaf1rpWQEqgDkUPiWmetD/5z7N4
         kAFwSGlHTUAyF0IKS9AHupB/WgdKh22y8zeI7+mMNjadPyajngKBY2X83X7/3kxmuPb0
         b37Hu9TjVK3CIecttTPqdnBA6obNllvTkMT860/OZciVO1GoNfO4IR3HkVN7I0yAS03s
         y+7HPsiWogRMhxdsfR9ZwkrCRP/ZKAzTOSazRuQ/GBUxVtH3K4WdZrt+iRIfMq4lhkOF
         QCew==
X-Gm-Message-State: AOJu0YwRG8bP7tOTaTZ1wwHyhKJpU3VKRPixg2djcJh1mDmR2C7vXedc
	Eb+c+5sT1iIGAzOXrc58EYM=
X-Google-Smtp-Source: AGHT+IFh23B0XY6UTIik070ev4ET09it5RKUiLtomagmSPjZV3divPDTFk1MOUjEj4qcESoCBY6c1Q==
X-Received: by 2002:a05:6a20:f393:b0:133:dc0a:37e7 with SMTP id qr19-20020a056a20f39300b00133dc0a37e7mr9606745pzb.13.1692747932108;
        Tue, 22 Aug 2023 16:45:32 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:590e])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001b89b7e208fsm9577503plb.88.2023.08.22.16.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 16:45:31 -0700 (PDT)
Date: Tue, 22 Aug 2023 16:45:29 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: yonghong.song@linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 5/7] bpf: Consider non-owning refs to
 refcounted nodes RCU protected
Message-ID: <20230822234529.z6ogvsptbivobdmg@MacBook-Pro-8.local>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-6-davemarchevsky@fb.com>
 <fafb9664-2473-1993-ea0d-4e4228f32c7b@linux.dev>
 <21f00803-d20f-e584-6512-67e5107e3865@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f00803-d20f-e584-6512-67e5107e3865@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 01:47:01AM -0400, David Marchevsky wrote:
> On 8/21/23 10:37 PM, Yonghong Song wrote:
> > 
> > 
> > On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> >> An earlier patch in the series ensures that the underlying memory of
> >> nodes with bpf_refcount - which can have multiple owners - is not reused
> >> until RCU grace period has elapsed. This prevents
> >> use-after-free with non-owning references that may point to
> >> recently-freed memory. While RCU read lock is held, it's safe to
> >> dereference such a non-owning ref, as by definition RCU GP couldn't have
> >> elapsed and therefore underlying memory couldn't have been reused.
> >>
> >>  From the perspective of verifier "trustedness" non-owning refs to
> >> refcounted nodes are now trusted only in RCU CS and therefore should no
> >> longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
> >> MEM_RCU in order to reflect this new state.
> >>
> >> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >> ---
> >>   include/linux/bpf.h   |  3 ++-
> >>   kernel/bpf/verifier.c | 13 ++++++++++++-
> >>   2 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index eced6400f778..12596af59c00 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -653,7 +653,8 @@ enum bpf_type_flag {
> >>       MEM_RCU            = BIT(13 + BPF_BASE_TYPE_BITS),
> >>         /* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-owning.
> >> -     * Currently only valid for linked-list and rbtree nodes.
> >> +     * Currently only valid for linked-list and rbtree nodes. If the nodes
> >> +     * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
> >>        */
> >>       NON_OWN_REF        = BIT(14 + BPF_BASE_TYPE_BITS),
> >>   diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 8db0afa5985c..55607ab30522 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -8013,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
> >>       case PTR_TO_BTF_ID | PTR_TRUSTED:
> >>       case PTR_TO_BTF_ID | MEM_RCU:
> >>       case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
> >> +    case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
> >>           /* When referenced PTR_TO_BTF_ID is passed to release function,
> >>            * its fixed offset must be 0. In the other cases, fixed offset
> >>            * can be non-zero. This was already checked above. So pass
> >> @@ -10479,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> >>   static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >>   {
> >>       struct bpf_verifier_state *state = env->cur_state;
> >> +    struct btf_record *rec = reg_btf_record(reg);
> >>         if (!state->active_lock.ptr) {
> >>           verbose(env, "verifier internal error: ref_set_non_owning w/o active lock\n");
> >> @@ -10491,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
> >>       }
> >>         reg->type |= NON_OWN_REF;
> >> +    if (rec->refcount_off >= 0)
> >> +        reg->type |= MEM_RCU;
> > 
> > Should the above MEM_RCU marking be done unless reg access is in
> > rcu critical section?
> 
> I think it is fine, since non-owning references currently exist only within
> spin_lock CS. Based on Alexei's comments on v1 of this series [0], preemption
> disabled + spin_lock CS should imply RCU CS.
> 
>   [0]: https://lore.kernel.org/bpf/20230802230715.3ltalexaczbomvbu@MacBook-Pro-8.local/
> 
> > 
> > I think we still have issues for state resetting
> > with bpf_spin_unlock() and bpf_rcu_read_unlock(), both of which
> > will try to convert the reg state to PTR_UNTRUSTED.
> > 
> > Let us say reg state is
> >   PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU
> > 
> > (1). If hitting bpf_spin_unlock(), since MEM_RCU is in
> > the reg state, the state should become
> >   PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU
> > some additional code might be needed so we wont have
> > verifier complaints about ref_obj_id == 0.
> > 
> > (2). If hitting bpf_rcu_read_unlock(), the state should become
> >   PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
> > since register access still in bpf_spin_lock() region.
> 
> I agree w/ your comment in side reply stating that this
> case isn't possible since bpf_rcu_read_{lock,unlock} in spin_lock CS
> is currently not allowed.
> 
> > 
> > Does this make sense?
> > 
> 
> 
> IIUC the specific reg state flow you're recommending is based on the convos
> we've had over the past few weeks re: getting rid of special non-owning ref
> lifetime rules, instead using RCU as much as possible. Specifically, this
> recommended change would remove non-owning ref clobbering, instead just removing
> NON_OWN_REF flag on bpf_spin_unlock so that such nodes can no longer be passed
> to collection kfuncs (refcount_acquire, etc).

Overall the patch set makes sense to me, but I want to clarify above.
My understanding that after the patch set applied bpf_spin_unlock()
will invalidate_non_owning_refs(), so what Yonghong is saying in (1)
is not correct.
Instead PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU will become mark_reg_invalid().

Re: (2) even if/when bpf_rcu_read_unlock() will allowed inside spinlocked region
it will convert PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU to
PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | PTR_UNTRUSTED
which is a buggy combination which we would need to address if rcu_unlock is allowed eventually.

Did I get it right?
If so I think the whole set is good to do.

