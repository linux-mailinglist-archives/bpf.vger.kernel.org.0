Return-Path: <bpf+bounces-8330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F3784DC1
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4528A2811EA
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A7377;
	Wed, 23 Aug 2023 00:21:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773F7E
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 00:21:38 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A346CC7
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:21:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so901105f8f.0
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692750095; x=1693354895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELgoisJ3kQIn2pyAqaFjJSk+et18ElMd+gMXDuXLjiA=;
        b=hHX3amTd0YVMKDxtDqNdOpQ3hvokHLwqMD6wkaEidIGFGIV12EO2CUd0xtjqUsNmZA
         BViKD2W/JULWjGkjtWjcKmFPz6SFAviJOnopENu266ABe01Z/eEzGdZUUBlGjbpxxQFP
         yI4NFsXAcIyhOkc7rBwjU8hVOA2SraqvyGZ6sKylIXrjhGUqucSoLA4ulTO7R1haPtCK
         H9JsrUTW/k45/CkVtoJYW2lVJ74yfV68fs6nyUoNm0BZXrSU1cRF10QiEaszptlV43pL
         QZWGxFUVHfQ3jyh4NECPFRen5w8axTALoMhcAfWcYk2puHp/YjyfoIe+mz/TuEveqmZT
         VSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692750095; x=1693354895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELgoisJ3kQIn2pyAqaFjJSk+et18ElMd+gMXDuXLjiA=;
        b=J5sH0VfiX/rBcZBZlOo2Rd3hMp6t8km7bpqIdKz2JgPQnAcJqQXOWHvWfLCTz+AXCY
         UOK/uvAYOgmVcAsAnsi3Jqkt4k8iS0HpkmHf2dhT4/sf8x3LxsCkp2cHbOJYtBsP60s1
         BY4JI7aROq3KMTv9SNQ/nguzR/NJcfdVV1dgRJUytalK4YkJhYKAC2OuTEsI/vFjcpHI
         YvPVYB2e17/N01SRXKVpdPbER5KDPs6DxrehofZo+5sdAVHztxyoUXqylPw2Q3vEhpI0
         gv9fkV9bK+Z4mdua4EBrXd9Gq/fY80qSK5XJIY2IT1jtG1b9jnPxm8aK/ZyoLKqq8s+H
         9syA==
X-Gm-Message-State: AOJu0YwHbCBCqQKpLERuaLfUdYFMGmkKCgcaRzg4wSTyhmXo/dcpL0G3
	hJv803GfwDTXNQ284QAFHjenHf6N0avzRGFRGPA=
X-Google-Smtp-Source: AGHT+IEx5Oe3IuDzPrmxgEzwMhqb82/WR4IfdYtv4+6Qg7FBFDzTbpOJX6eLwjJIS0Le5g8TUS613Zh86usdiGKATw8=
X-Received: by 2002:adf:e911:0:b0:317:54de:9718 with SMTP id
 f17-20020adfe911000000b0031754de9718mr9337574wrm.22.1692750094730; Tue, 22
 Aug 2023 17:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-6-davemarchevsky@fb.com> <fafb9664-2473-1993-ea0d-4e4228f32c7b@linux.dev>
 <21f00803-d20f-e584-6512-67e5107e3865@linux.dev> <20230822234529.z6ogvsptbivobdmg@MacBook-Pro-8.local>
 <4a601c15-25d5-ec97-849a-97e54ace8f0d@linux.dev>
In-Reply-To: <4a601c15-25d5-ec97-849a-97e54ace8f0d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 17:21:23 -0700
Message-ID: <CAADnVQJxp6tQnTSd+LEur-qyVtK3a0Ex+4mo420SPBkkk2GpHw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/7] bpf: Consider non-owning refs to
 refcounted nodes RCU protected
To: Yonghong Song <yonghong.song@linux.dev>
Cc: David Marchevsky <david.marchevsky@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 5:18=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/22/23 4:45 PM, Alexei Starovoitov wrote:
> > On Tue, Aug 22, 2023 at 01:47:01AM -0400, David Marchevsky wrote:
> >> On 8/21/23 10:37 PM, Yonghong Song wrote:
> >>>
> >>>
> >>> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> >>>> An earlier patch in the series ensures that the underlying memory of
> >>>> nodes with bpf_refcount - which can have multiple owners - is not re=
used
> >>>> until RCU grace period has elapsed. This prevents
> >>>> use-after-free with non-owning references that may point to
> >>>> recently-freed memory. While RCU read lock is held, it's safe to
> >>>> dereference such a non-owning ref, as by definition RCU GP couldn't =
have
> >>>> elapsed and therefore underlying memory couldn't have been reused.
> >>>>
> >>>>   From the perspective of verifier "trustedness" non-owning refs to
> >>>> refcounted nodes are now trusted only in RCU CS and therefore should=
 no
> >>>> longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
> >>>> MEM_RCU in order to reflect this new state.
> >>>>
> >>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>>> ---
> >>>>    include/linux/bpf.h   |  3 ++-
> >>>>    kernel/bpf/verifier.c | 13 ++++++++++++-
> >>>>    2 files changed, 14 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>> index eced6400f778..12596af59c00 100644
> >>>> --- a/include/linux/bpf.h
> >>>> +++ b/include/linux/bpf.h
> >>>> @@ -653,7 +653,8 @@ enum bpf_type_flag {
> >>>>        MEM_RCU            =3D BIT(13 + BPF_BASE_TYPE_BITS),
> >>>>          /* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which a=
re non-owning.
> >>>> -     * Currently only valid for linked-list and rbtree nodes.
> >>>> +     * Currently only valid for linked-list and rbtree nodes. If th=
e nodes
> >>>> +     * have a bpf_refcount_field, they must be tagged MEM_RCU as we=
ll.
> >>>>         */
> >>>>        NON_OWN_REF        =3D BIT(14 + BPF_BASE_TYPE_BITS),
> >>>>    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>>> index 8db0afa5985c..55607ab30522 100644
> >>>> --- a/kernel/bpf/verifier.c
> >>>> +++ b/kernel/bpf/verifier.c
> >>>> @@ -8013,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier=
_env *env,
> >>>>        case PTR_TO_BTF_ID | PTR_TRUSTED:
> >>>>        case PTR_TO_BTF_ID | MEM_RCU:
> >>>>        case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
> >>>> +    case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
> >>>>            /* When referenced PTR_TO_BTF_ID is passed to release fun=
ction,
> >>>>             * its fixed offset must be 0. In the other cases, fixed =
offset
> >>>>             * can be non-zero. This was already checked above. So pa=
ss
> >>>> @@ -10479,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(stru=
ct bpf_verifier_env *env,
> >>>>    static int ref_set_non_owning(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
> >>>>    {
> >>>>        struct bpf_verifier_state *state =3D env->cur_state;
> >>>> +    struct btf_record *rec =3D reg_btf_record(reg);
> >>>>          if (!state->active_lock.ptr) {
> >>>>            verbose(env, "verifier internal error: ref_set_non_owning=
 w/o active lock\n");
> >>>> @@ -10491,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_ver=
ifier_env *env, struct bpf_reg_state
> >>>>        }
> >>>>          reg->type |=3D NON_OWN_REF;
> >>>> +    if (rec->refcount_off >=3D 0)
> >>>> +        reg->type |=3D MEM_RCU;
> >>>
> >>> Should the above MEM_RCU marking be done unless reg access is in
> >>> rcu critical section?
> >>
> >> I think it is fine, since non-owning references currently exist only w=
ithin
> >> spin_lock CS. Based on Alexei's comments on v1 of this series [0], pre=
emption
> >> disabled + spin_lock CS should imply RCU CS.
> >>
> >>    [0]: https://lore.kernel.org/bpf/20230802230715.3ltalexaczbomvbu@Ma=
cBook-Pro-8.local/
> >>
> >>>
> >>> I think we still have issues for state resetting
> >>> with bpf_spin_unlock() and bpf_rcu_read_unlock(), both of which
> >>> will try to convert the reg state to PTR_UNTRUSTED.
> >>>
> >>> Let us say reg state is
> >>>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU
> >>>
> >>> (1). If hitting bpf_spin_unlock(), since MEM_RCU is in
> >>> the reg state, the state should become
> >>>    PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU
> >>> some additional code might be needed so we wont have
> >>> verifier complaints about ref_obj_id =3D=3D 0.
> >>>
> >>> (2). If hitting bpf_rcu_read_unlock(), the state should become
> >>>    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF
> >>> since register access still in bpf_spin_lock() region.
> >>
> >> I agree w/ your comment in side reply stating that this
> >> case isn't possible since bpf_rcu_read_{lock,unlock} in spin_lock CS
> >> is currently not allowed.
> >>
> >>>
> >>> Does this make sense?
> >>>
> >>
> >>
> >> IIUC the specific reg state flow you're recommending is based on the c=
onvos
> >> we've had over the past few weeks re: getting rid of special non-ownin=
g ref
> >> lifetime rules, instead using RCU as much as possible. Specifically, t=
his
> >> recommended change would remove non-owning ref clobbering, instead jus=
t removing
> >> NON_OWN_REF flag on bpf_spin_unlock so that such nodes can no longer b=
e passed
> >> to collection kfuncs (refcount_acquire, etc).
> >
> > Overall the patch set makes sense to me, but I want to clarify above.
> > My understanding that after the patch set applied bpf_spin_unlock()
> > will invalidate_non_owning_refs(), so what Yonghong is saying in (1)
> > is not correct.
> > Instead PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU will become m=
ark_reg_invalid().
>
> I said it 'should become ...', but you are right. right now, it will do
> mark_reg_invalid(). So it is correct just MAYBE a little conservative.

Ahh. You mean that it should be fixed to do that. Got it.
non_own_ref after spin_unlock should become a pure mem_rcu pointer.
Need to think it through. Probably correct.

