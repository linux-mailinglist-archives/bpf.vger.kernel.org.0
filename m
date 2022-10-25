Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6060D44B
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiJYTAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiJYTAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 15:00:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8594B42D63
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 12:00:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so17393450pji.1
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab0u38H/HvUJAzBK3T8VewA6769KxroAZBpGAu930AI=;
        b=eaeoQ3orDAZmp7V/QFR7egsOQ8fDNgqprZVTZBrUoRNz0kzLYYa8Prrr74FqidoyRe
         F+kcfZlXN+xBSnOmmIouc6q9DuPVvFb5r2i8zw5ux4+8+iFzEqwnuA0/FR356O8AhHNP
         dqEiww0Hwn8V9aaDw83+JA1c6iv49ZcvH9ptRxl12dFI5O/rbM+d6EaYOMvrfyoDnZZg
         sT7xWJAcYickW//78ozWcuXCMntXDQawQvAqt1S8SU8AqqgTR/9ncTYLfHyoEQm2q1QN
         BjYj2gZMmqVoM6l8Ic19ETz3RsZXRnFEjVxbYLNI8Nr45Wr73nnHtdnLhd+yTIAQo7rA
         ummw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab0u38H/HvUJAzBK3T8VewA6769KxroAZBpGAu930AI=;
        b=7Mn0itQ6qVeHuYEIHvvRrNsdEpbcoOI7huLN2bnFmut71MmOBk00J3KQn1HnJGW6Hq
         Uu4Z9xiakCf+1DF/ucviGBFjzSyEqNFF5UJsIlHz/VaaFkhAubr08zQo1wmc9DjpiyHm
         tTuAnHqAc/nU+vxfluZrY70K9LMx73i1+5liBRuM6603kIM7JCV4YMbJx53LMNHDc2/H
         eCT0CRpVtcjLRc6LxLSjF8Ptq3ExSUiIo3smWFmkIIA39SV+8RbFn1mLXMSFu05OQ08y
         W9PdeffGVo+egn3/BwqSKzQ/JA5b7l2jF3ZhBMxd9Dg3VQf9x4EgzG6pn+7QoajrfT/i
         V5iQ==
X-Gm-Message-State: ACrzQf3uyLDQd83PCLijyvYzl1Exnsv/sOP0IkaVq+ySAxxG3RdxUPtv
        j2s7d1eG/heeg00YZgdcWkw=
X-Google-Smtp-Source: AMsMyM6+8/0DwizgDpJvrVfydgM5uMezyzYngivuzLNqboswrDiENx0TS/FwZDWZxfNUNLZRsoILrQ==
X-Received: by 2002:a17:90a:ae16:b0:212:d2bd:82f0 with SMTP id t22-20020a17090aae1600b00212d2bd82f0mr27453883pjq.12.1666724434833;
        Tue, 25 Oct 2022 12:00:34 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b00186b86ed450sm1525314plg.156.2022.10.25.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:00:34 -0700 (PDT)
Date:   Wed, 26 Oct 2022 00:30:33 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 22/25] bpf: Introduce single ownership BPF
 linked list API
Message-ID: <20221025190033.bqjr7466o7pdd3wo@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-23-memxor@gmail.com>
 <8e902f3c-8f15-73c9-53ff-e24019afb1a4@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e902f3c-8f15-73c9-53ff-e24019afb1a4@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 11:15:12PM IST, Dave Marchevsky wrote:
> On 10/13/22 2:23 AM, Kumar Kartikeya Dwivedi wrote:
> > Add a linked list API for use in BPF programs, where it expects
> > protection from the bpf_spin_lock in the same allocation as the
> > bpf_list_head. Future patches will extend the same infrastructure to
> > have different flavors with varying protection domains and visibility
> > (e.g. percpu variant with local_t protection, usable in NMI progs).
> >
> > The following functions are added to kick things off:
> >
> > bpf_list_add
> > bpf_list_add_tail
> > bpf_list_del
> > bpf_list_del_tail
> >
> > The lock protecting the bpf_list_head needs to be taken for all
> > operations.
> >
> > Once a node has been added to the list, it's pointer changes to
> > PTR_UNTRUSTED. However, it is only released once the lock protecting the
> > list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
> > active ref_obj_id, it is still permitted to read and write to them as
> > long as the lock is held.
> >
> > bpf_list_del and bpf_list_del_tail delete the first or last item of the
> > list respectively, and return pointer to the element at the list_node
> > offset. The user can then use container_of style macro to get the actual
> > entry type. The verifier however statically knows the actual type, so
> > the safety properties are still preserved.
> >
> > With these additions, programs can now manage their own linked lists and
> > store their objects in them.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> > [...]
> > +static bool ref_obj_id_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
> > +{
> > +	struct bpf_func_state *state = cur_func(env);
> > +	struct bpf_reg_state *reg;
> > +	int i;
> > +
> > +	/* bpf_spin_lock only allows calling list_add and list_del, no BPF
> > +	 * subprogs, no global functions, so this acquired refs state is the
> > +	 * same one we will use to find registers to kill on bpf_spin_unlock.
> > +	 */
>
> It's unclear to me what "only allows calling ... is the same one" in this
> comment is trying to say. Are you trying to say something similar to your
> comment in the process_spin_lock change in this patch? e.g. "bpf_spin_lock CS
> does not allow functions that release the local kptr, so this ref_obj_id will
> still be valid then". At least to me the language in the other comment is
> clearer.

It's not even about the same ref_obj_id. It means what it says, when you call a
BPF function the reference state is copied into the callee func state, since
that is not allowed here, the walk over reference state IDs and killing
release_on_unlock ones on bpf_spin_unlock will always happen for this particular
bpf_reference_state only.

>
> > +	WARN_ON_ONCE(!ref_obj_id);
>
> Can this be a verbose("verifier internal error: ...") + return?
> Same for similar 'this should never happen' checks elsewhere in this function
> and patch.
>

Yes, I will address similar patterns elsewhere.

> > +	for (i = 0; i < state->acquired_refs; i++) {
> > +		if (state->refs[i].id == ref_obj_id) {
> > +			WARN_ON_ONCE(state->refs[i].release_on_unlock);
> > +			state->refs[i].release_on_unlock = true;
> > +			/* Now mark everyone sharing same ref_obj_id as untrusted */
> > +			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> > +				if (reg->ref_obj_id == ref_obj_id)
> > +					reg->type |= PTR_UNTRUSTED;
>
> To confirm my understanding: since ownership of the thing this reference points
> to has been transferred to the datastructure, it's now necessary to mark all
> instances of the reference PTR_UNTRUSTED to prevent them from being passed
> to helpers/kfuncs as the owning datastructure could make it dissapear
> at any time? Or because arbitrary kfunc might mess with bpf_list_node internal
> fields?
>

Yes, it's because the ownership through that reference is gone. So access to the
object is still permitted until unlock, but only through memory accesses handled
using PROBE_MEM.

'Through that reference' is key because it might return to the program in case
of push_front -> pop_back but we cannot know for sure (atleast not without more
complicated heap modelling for the list). It cannot know when this specific
object's ownership behind the reference returns back to the program, so this
particular reference (identified by the ref_obj_id) needs to become untrusted.

It serves both as a way to prevent passing it to list helpers anymore, and also
to give safe read access to a potentially invalid object after its ownership is
gone. This is the same state a kptr/kptr_ref loaded using load insn from a BPF
map ends up in.

I have switched things a bit to disallow stores, which is a bug right now in
this set, because one can do this:

push_front(head, &p->node);
p2 = container_of(pop_front(head));
// p2 == p
bpf_obj_drop(p2);
p->data = ...;

One can always fully initialize the object _before_ inserting it into the list,
in some cases that will be the requirement (like adding to RCU protected lists)
for correctness.

> > +			}));
> > +			return 0;
> > +		}
> > +	}
> > +	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
> > +	return -EFAULT;
>
> You're returning -EFAULT here, but the fn return type is 'bool' above.
>

Ack.

> > +}
> > +
> > +static bool is_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +	void *ptr;
> > +	u32 id;
> > +
> > +	switch ((int)reg->type) {
> > +	case PTR_TO_MAP_VALUE:
> > +		ptr = reg->map_ptr;
> > +		break;
> > +	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
> > +		ptr = reg->btf;
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		return false;
> > +	}
> > +	id = reg->id;
> > +
> > +	return env->cur_state->active_spin_lock_ptr == ptr &&
> > +	       env->cur_state->active_spin_lock_id == id;
> > +}
> > +
> > +static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
> > +					   struct bpf_reg_state *reg,
> > +					   u32 regno,
> > +					   struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	struct btf_type_fields *tab = NULL;
> > +	struct btf_field *field;
> > +	u32 list_head_off;
> > +
> > +	if (meta->btf != btf_vmlinux ||
> > +	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
> > +	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail] &&
> > +	     meta->func_id != special_kfunc_list[KF_bpf_list_del] &&
> > +	     meta->func_id != special_kfunc_list[KF_bpf_list_del_tail])) {
> > +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (reg->type == PTR_TO_MAP_VALUE) {
> > +		tab = reg->map_ptr->fields_tab;
> > +	} else /* PTR_TO_BTF_ID | MEM_TYPE_LOCAL */ {
> > +		struct btf_struct_meta *meta;
> > +
> > +		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> > +		if (!meta) {
> > +			verbose(env, "bpf_list_head not found for local kptr\n");
> > +			return -EINVAL;
> > +		}
> > +		tab = meta->fields_tab;
> > +	}
> > +
> > +	if (!tnum_is_const(reg->var_off)) {
> > +		verbose(env,
> > +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> > +			regno);
> > +		return -EINVAL;
> > +	}
> > +
> > +	list_head_off = reg->off + reg->var_off.value;
> > +	field = btf_type_fields_find(tab, list_head_off, BPF_LIST_HEAD);
> > +	if (!field) {
> > +		verbose(env, "bpf_list_head not found at offset=%u\n", list_head_off);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* All functions require bpf_list_head to be protected using a bpf_spin_lock */
> > +	if (!is_reg_allocation_locked(env, reg)) {
> > +		verbose(env, "bpf_spin_lock at off=%d must be held for manipulating bpf_list_head\n",
> > +			tab->spin_lock_off);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (meta->func_id == special_kfunc_list[KF_bpf_list_add] ||
> > +	    meta->func_id == special_kfunc_list[KF_bpf_list_add_tail]) {
> > +		if (!btf_struct_ids_match(&env->log, meta->arg_list_node.reg_btf,
> > +					  meta->arg_list_node.reg_btf_id, 0,
> > +					  field->list_head.btf, field->list_head.value_btf_id, true)) {
> > +			verbose(env, "bpf_list_head value type does not match arg#0\n");
> > +			return -EINVAL;
> > +		}
> > +		if (meta->arg_list_node.reg_offset != field->list_head.node_offset) {
> > +			verbose(env, "arg#0 offset must be for bpf_list_node at off=%d\n",
> > +				field->list_head.node_offset);
> > +			return -EINVAL;
> > +		}
> > +		/* Set arg#0 for expiration after unlock */
> > +		ref_obj_id_set_release_on_unlock(env, meta->arg_list_node.reg_ref_obj_id);
> > +	} else {
> > +		if (meta->arg_list_head.field) {
> > +			verbose(env, "verifier internal error: repeating bpf_list_head arg\n");
> > +			return -EFAULT;
> > +		}
> > +		meta->arg_list_head.field = field;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> > +					   struct bpf_reg_state *reg,
> > +					   u32 regno,
> > +					   struct bpf_kfunc_call_arg_meta *meta)
> > +{
> > +	struct btf_struct_meta *struct_meta;
> > +	struct btf_type_fields *tab;
> > +	struct btf_field *field;
> > +	u32 list_node_off;
> > +
> > +	if (meta->btf != btf_vmlinux ||
> > +	    (meta->func_id != special_kfunc_list[KF_bpf_list_add] &&
> > +	     meta->func_id != special_kfunc_list[KF_bpf_list_add_tail])) {
> > +		verbose(env, "verifier internal error: bpf_list_head argument for unknown kfunc\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (!tnum_is_const(reg->var_off)) {
> > +		verbose(env,
> > +			"R%d doesn't have constant offset. bpf_list_head has to be at the constant offset\n",
> > +			regno);
> > +		return -EINVAL;
> > +	}
> > +
> > +	struct_meta = btf_find_struct_meta(reg->btf, reg->btf_id);
> > +	if (!struct_meta) {
> > +		verbose(env, "bpf_list_node not found for local kptr\n");
> > +		return -EINVAL;
> > +	}
> > +	tab = struct_meta->fields_tab;
> > +
> > +	list_node_off = reg->off + reg->var_off.value;
> > +	field = btf_type_fields_find(tab, list_node_off, BPF_LIST_NODE);
> > +	if (!field || field->offset != list_node_off) {
> > +		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> > +		return -EINVAL;
> > +	}
> > +	if (meta->arg_list_node.field) {
> > +		verbose(env, "verifier internal error: repeating bpf_list_node arg\n");
> > +		return -EFAULT;
> > +	}
> > +	meta->arg_list_node.field = field;
> > +	meta->arg_list_node.reg_btf = reg->btf;
> > +	meta->arg_list_node.reg_btf_id = reg->btf_id;
> > +	meta->arg_list_node.reg_offset = list_node_off;
> > +	meta->arg_list_node.reg_ref_obj_id = reg->ref_obj_id;
> > +	return 0;
> > +}
> > +
> >  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> >  {
> >  	const char *func_name = meta->func_name, *ref_tname;
> > @@ -8157,6 +8393,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  			break;
> >  		case KF_ARG_PTR_TO_KPTR_STRONG:
> >  		case KF_ARG_PTR_TO_DYNPTR:
> > +		case KF_ARG_PTR_TO_LIST_HEAD:
> > +		case KF_ARG_PTR_TO_LIST_NODE:
> >  		case KF_ARG_PTR_TO_MEM:
> >  		case KF_ARG_PTR_TO_MEM_SIZE:
> >  			/* Trusted by default */
> > @@ -8194,17 +8432,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  				meta->arg_kptr_drop.btf_id = reg->btf_id;
> >  			}
> >  			break;
> > -		case KF_ARG_PTR_TO_BTF_ID:
> > -			/* Only base_type is checked, further checks are done here */
> > -			if (reg->type != PTR_TO_BTF_ID &&
> > -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> > -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> > -				return -EINVAL;
> > -			}
> > -			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> > -			if (ret < 0)
> > -				return ret;
> > -			break;
> >  		case KF_ARG_PTR_TO_KPTR_STRONG:
> >  			if (reg->type != PTR_TO_MAP_VALUE) {
> >  				verbose(env, "arg#0 expected pointer to map value\n");
> > @@ -8232,6 +8459,44 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
> >  				return -EINVAL;
> >  			}
> >  			break;
> > +		case KF_ARG_PTR_TO_LIST_HEAD:
> > +			if (reg->type != PTR_TO_MAP_VALUE &&
> > +			    reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
> > +				verbose(env, "arg#%d expected pointer to map value or local kptr\n", i);
> > +				return -EINVAL;
> > +			}
> > +			if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL) && !reg->ref_obj_id) {
> > +				verbose(env, "local kptr must be referenced\n");
> > +				return -EINVAL;
> > +			}
> > +			ret = process_kf_arg_ptr_to_list_head(env, reg, regno, meta);
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		case KF_ARG_PTR_TO_LIST_NODE:
> > +			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
> > +				verbose(env, "arg#%d expected point to local kptr\n", i);
> > +				return -EINVAL;
> > +			}
> > +			if (!reg->ref_obj_id) {
> > +				verbose(env, "local kptr must be referenced\n");
> > +				return -EINVAL;
> > +			}
> > +			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> > +		case KF_ARG_PTR_TO_BTF_ID:
> > +			/* Only base_type is checked, further checks are done here */
> > +			if (reg->type != PTR_TO_BTF_ID &&
> > +			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> > +				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> > +				return -EINVAL;
> > +			}
> > +			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> > +			if (ret < 0)
> > +				return ret;
> > +			break;
> >  		case KF_ARG_PTR_TO_MEM:
> >  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
> >  			if (IS_ERR(resolve_ret)) {
> > @@ -8352,11 +8617,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
> >
> >  		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
> > -			if (!btf_type_is_void(ptr_type)) {
> > -				verbose(env, "kernel function %s must have void * return type\n",
> > -					meta.func_name);
> > -				return -EINVAL;
> > -			}
> >  			if (meta.func_id == special_kfunc_list[KF_bpf_kptr_new_impl]) {
> >  				const struct btf_type *ret_t;
> >  				struct btf *ret_btf;
> > @@ -8394,6 +8654,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  				env->insn_aux_data[insn_idx].kptr_struct_meta =
> >  					btf_find_struct_meta(meta.arg_kptr_drop.btf,
> >  							     meta.arg_kptr_drop.btf_id);
> > +			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_del] ||
> > +				   meta.func_id == special_kfunc_list[KF_bpf_list_del_tail]) {
> > +				struct btf_field *field = meta.arg_list_head.field;
> > +
> > +				mark_reg_known_zero(env, regs, BPF_REG_0);
> > +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_TYPE_LOCAL;
> > +				regs[BPF_REG_0].btf = field->list_head.btf;
> > +				regs[BPF_REG_0].btf_id = field->list_head.value_btf_id;
> > +				regs[BPF_REG_0].off = field->list_head.node_offset;
> >  			} else {
> >  				verbose(env, "kernel function %s unhandled dynamic return type\n",
> >  					meta.func_name);
> > @@ -13062,11 +13331,18 @@ static int do_check(struct bpf_verifier_env *env)
> >  					return -EINVAL;
> >  				}
> >
> > -				if (env->cur_state->active_spin_lock_ptr &&
> > -				    (insn->src_reg == BPF_PSEUDO_CALL ||
> > -				     insn->imm != BPF_FUNC_spin_unlock)) {
> > -					verbose(env, "function calls are not allowed while holding a lock\n");
> > -					return -EINVAL;
> > +				if (env->cur_state->active_spin_lock_ptr) {
> > +					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
> > +					    (insn->src_reg == BPF_PSEUDO_CALL) ||
> > +					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> > +					     (insn->off != 0 ||
> > +					      (insn->imm != special_kfunc_list[KF_bpf_list_add] &&
> > +					       insn->imm != special_kfunc_list[KF_bpf_list_add_tail] &&
> > +					       insn->imm != special_kfunc_list[KF_bpf_list_del] &&
> > +					       insn->imm != special_kfunc_list[KF_bpf_list_del_tail])))) {
>
> There's some similar special_kfunc_list checking in
> process_kf_arg_ptr_to_list_head. Can you make a helper for this check?
> kfunc_manipulates_bpf_list or something? Similarly for
> KF_bpf_list_del{_tail} check in previous hunk, maybe
> something like kfunc_acquires_bpf_list_node?
>

Good point, it makes sense to hide this list behind a helper.
