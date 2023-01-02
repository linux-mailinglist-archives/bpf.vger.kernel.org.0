Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28B65B6F2
	for <lists+bpf@lfdr.de>; Mon,  2 Jan 2023 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjABT2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Jan 2023 14:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjABT2r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Jan 2023 14:28:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6D5F96
        for <bpf@vger.kernel.org>; Mon,  2 Jan 2023 11:28:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so42773952lfu.8
        for <bpf@vger.kernel.org>; Mon, 02 Jan 2023 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yo6JJVUQq0xwZNEtxyrA4mChIdVM9HZPPBMFqYc2vKg=;
        b=Qh8AXlcqGCFPiSdXDWsCgPNPKnRg6JcarZjunmllJedFJiWPcaSNRFuhFsUUSl8xOh
         qks1UJWbHqkhvfhMVCyq1D6pJX4glg3dp9Hcnkum3Cux2xupSGI2hNsV/Mxl5ihvJcHX
         uUIlYNHbCpnORDaZclTz89e5oUCrAdfEke+SvQlSNNitCS47+6RNCryhaoKEVXKDastj
         lToWExk0if+UGOviq+u/+aVkjQm0/3TDQXT44nLn9h8hQ989oQ28fuQLeEZ5XFtyXaZy
         OWRQxkrAfOY/AAhFsRA7SnwNLeIrVXgvFJKSfQgRGQio6U+0WkpxWhQ6tlV2PvkJLJVU
         i2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo6JJVUQq0xwZNEtxyrA4mChIdVM9HZPPBMFqYc2vKg=;
        b=lzIgs8czMNcJny57JZfeMUWpN/5LelYbKmh6uZ+/hjMMxXCGp3ICekJ7F7SAGRK37W
         xJs6jd2VmeBXD8PJLJJ06KQx5FIh3qP0xpZTSKmn43jnpTEU7+43VrOKYKd9C+KAdBzB
         P5WTg/vg+aEUlqgSafOMyVZqmEhrE/DoZF5fhYD+zmSlte6Uf+CnCAaZkQFlhkf8Wz9y
         B3K+8YnC7PPiS+HBRjEgRD0+fDcpPz0Sghezd97WUzpF9GjVy9NUJC0uztU9xDb/aqa4
         t5dDhEDjRXhpz/nn4D+E7RmMPUjPc8i55VngyNK0Kw21IhXrrckX6jHjAmQOsI3fKL/K
         mjvg==
X-Gm-Message-State: AFqh2kqFd8trbzZgRb+Q4jF+a5MGvLZLsTncertPV/pEOWsADAAK4Ypt
        7AR2kdkblGmymIG97hCAZ40=
X-Google-Smtp-Source: AMrXdXt/lc3XSNnd/0MBW2+DFeVXECMb7s5MI9YiI2lY/16kFHyiLI1hVEwTDBPqYlMtUGJ/9Hvyww==
X-Received: by 2002:a05:6512:e89:b0:4b5:b7be:136b with SMTP id bi9-20020a0565120e8900b004b5b7be136bmr12161716lfb.69.1672687722543;
        Mon, 02 Jan 2023 11:28:42 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id be33-20020a056512252100b004b56de48f05sm4510273lfb.27.2023.01.02.11.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 11:28:41 -0800 (PST)
Message-ID: <f4bde187c49109d041e44ab19bbd23c7eccfc716.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Fix state pruning for STACK_DYNPTR
 stack slots
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Date:   Mon, 02 Jan 2023 21:28:40 +0200
In-Reply-To: <20230101083403.332783-2-memxor@gmail.com>
References: <20230101083403.332783-1-memxor@gmail.com>
         <20230101083403.332783-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2023-01-01 at 14:03 +0530, Kumar Kartikeya Dwivedi wrote:
> The root of the problem is missing liveness marking for STACK_DYNPTR
> slots. This leads to all kinds of problems inside stacksafe.
>=20
> The verifier by default inside stacksafe ignores spilled_ptr in stack
> slots which do not have REG_LIVE_READ marks. Since this is being checked
> in the 'old' explored state, it must have already done clean_live_states
> for this old bpf_func_state. Hence, it won't be receiving any more
> liveness marks from to be explored insns (it has received REG_LIVE_DONE
> marking from liveness point of view).
>=20
> What this means is that verifier considers that it's safe to not compare
> the stack slot if was never read by children states. While liveness
> marks are usually propagated correctly following the parentage chain for
> spilled registers (SCALAR_VALUE and PTR_* types), the same is not the
> case for STACK_DYNPTR.
>=20
> clean_live_states hence simply rewrites these stack slots to the type
> STACK_INVALID since it sees no REG_LIVE_READ marks.
>=20
> The end result is that we will never see STACK_DYNPTR slots in explored
> state. Even if verifier was conservatively matching !REG_LIVE_READ
> slots, very next check continuing the stacksafe loop on seeing
> STACK_INVALID would again prevent further checks.
>=20
> Now as long as verifier stores an explored state which we can compare to
> when reaching a pruning point, we can abuse this bug to make verifier
> prune search for obviously unsafe paths using STACK_DYNPTR slots
> thinking they are never used hence safe.
>=20
> Doing this in unprivileged mode is a bit challenging. add_new_state is
> only set when seeing BPF_F_TEST_STATE_FREQ (which requires privileges)
> or when jmps_processed difference is >=3D 2 and insn_processed difference
> is >=3D 8. So coming up with the unprivileged case requires a little more
> work, but it is still totally possible. The test case being discussed
> below triggers the heuristic even in unprivileged mode.
>=20
> However, it no longer works since commit
> 8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF").
>=20
> Let's try to study the test step by step.
>=20
> Consider the following program (C style BPF ASM):
>=20
> 0  r0 =3D 0;
> 1  r6 =3D &ringbuf_map;
> 3  r1 =3D r6;
> 4  r2 =3D 8;
> 5  r3 =3D 0;
> 6  r4 =3D r10;
> 7  r4 -=3D -16;
> 8  call bpf_ringbuf_reserve_dynptr;
> 9  if r0 =3D=3D 0 goto pc+1;
> 10 goto pc+1;
> 11 *(r10 - 16) =3D 0xeB9F;
> 12 r1 =3D r10;
> 13 r1 -=3D -16;
> 14 r2 =3D 0;
> 15 call bpf_ringbuf_discard_dynptr;
> 16 r0 =3D 0;
> 17 exit;
>=20
> We know that insn 12 will be a pruning point, hence if we force
> add_new_state for it, it will first verify the following path as
> safe in straight line exploration:
> 0 1 3 4 5 6 7 8 9 -> 10 -> (12) 13 14 15 16 17
>=20
> Then, when we arrive at insn 12 from the following path:
> 0 1 3 4 5 6 7 8 9 -> 11 (12)
>=20
> We will find a state that has been verified as safe already at insn 12.
> Since register state is same at this point, regsafe will pass. Next, in
> stacksafe, for spi =3D 0 and spi =3D 1 (location of our dynptr) is skippe=
d
> seeing !REG_LIVE_READ. The rest matches, so stacksafe returns true.
> Next, refsafe is also true as reference state is unchanged in both
> states.
>=20
> The states are considered equivalent and search is pruned.
>=20
> Hence, we are able to construct a dynptr with arbitrary contents and use
> the dynptr API to operate on this arbitrary pointer and arbitrary size +
> offset.
>=20
> To fix this, first define a mark_dynptr_read function that propagates
> liveness marks whenever a valid initialized dynptr is accessed by dynptr
> helpers. REG_LIVE_WRITTEN is marked whenever we initialize an
> uninitialized dynptr. This is done in mark_stack_slots_dynptr. It allows
> screening off mark_reg_read and not propagating marks upwards from that
> point.
>=20
> This ensures that we either set REG_LIVE_READ64 on both dynptr slots, or
> none, so clean_live_states either sets both slots to STACK_INVALID or
> none of them. This is the invariant the checks inside stacksafe rely on.
>=20
> Next, do a complete comparison of both stack slots whenever they have
> STACK_DYNPTR. Compare the dynptr type stored in the spilled_ptr, and
> also whether both form the same first_slot. Only then is the later path
> safe.
>=20
> Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4a25375ebb0d..f7248235e119 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -781,6 +781,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifie=
r_env *env, struct bpf_reg_
>  		state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
>  	}
> =20
> +	state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> +	state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> +
>  	return 0;
>  }
> =20
> @@ -805,6 +808,26 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
> =20
>  	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
>  	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> +
> +	/* Why do we need to set REG_LIVE_WRITTEN for STACK_INVALID slot?
> +	 *
> +	 * While we don't allow reading STACK_INVALID, it is still possible to
> +	 * do <8 byte writes marking some but not all slots as STACK_MISC. Then=
,
> +	 * helpers or insns can do partial read of that part without failing,
> +	 * but check_stack_range_initialized, check_stack_read_var_off, and
> +	 * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
> +	 * the slot conservatively. Hence we need to screen off those liveness
> +	 * marking walks.
> +	 *
> +	 * This was not a problem before because STACK_INVALID is only set by
> +	 * default, or in clean_live_states after REG_LIVE_DONE, not randomly
> +	 * during verifier state exploration. Hence, for this case parentage
> +	 * chain will still be live, while earlier reg->parent was NULL, so we
> +	 * need REG_LIVE_WRITTEN to screen off read marker propagation.
> +	 */
> +	state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> +	state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> +

This is purely to assist with verifier state pruning and does not
affect correctness, right?
Commenting the lines does not seem to fail any tests, maybe add one
matching some "77 safe: ..." jump in the log?

>  	return 0;
>  }
> =20
> @@ -2388,6 +2411,30 @@ static int mark_reg_read(struct bpf_verifier_env *=
env,
>  	return 0;
>  }
> =20
> +static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg)
> +{
> +	struct bpf_func_state *state =3D func(env, reg);
> +	int spi, ret;
> +
> +	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
> +	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
> +	 * check_kfunc_call.
> +	 */
> +	if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> +		return 0;
> +	spi =3D get_spi(reg->off);
> +	/* Caller ensures dynptr is valid and initialized, which means spi is i=
n
> +	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
> +	 * read.
> +	 */
> +	ret =3D mark_reg_read(env, &state->stack[spi].spilled_ptr,
> +			    state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
> +	if (ret)
> +		return ret;
> +	return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
> +			     state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
> +}
> +
>  /* This function is supposed to be used by the following 32-bit optimiza=
tion
>   * code only. It returns TRUE if the source or destination register oper=
ates
>   * on 64-bit, otherwise return FALSE.
> @@ -5928,6 +5975,7 @@ int process_dynptr_func(struct bpf_verifier_env *en=
v, int regno,
>  			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
> +	int err;
> =20
>  	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
>  	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> @@ -6008,6 +6056,10 @@ int process_dynptr_func(struct bpf_verifier_env *e=
nv, int regno,
>  				err_extra, regno);
>  			return -EINVAL;
>  		}
> +
> +		err =3D mark_dynptr_read(env, reg);
> +		if (err)
> +			return err;
>  	}
>  	return 0;
>  }
> @@ -13204,6 +13256,27 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
>  			 * return false to continue verification of this path
>  			 */
>  			return false;
> +		/* Both are same slot_type, but STACK_DYNPTR requires more
> +		 * checks before it can considered safe.
> +		 */
> +		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_DYNPTR) {
> +			/* If both are STACK_DYNPTR, type must be same */
> +			if (old->stack[spi].spilled_ptr.dynptr.type !=3D cur->stack[spi].spil=
led_ptr.dynptr.type)
> +				return false;
> +			/* Both should also have first slot at same spi */
> +			if (old->stack[spi].spilled_ptr.dynptr.first_slot !=3D cur->stack[spi=
].spilled_ptr.dynptr.first_slot)
> +				return false;
> +			/* ids should be same */
> +			if (!!old->stack[spi].spilled_ptr.ref_obj_id !=3D !!cur->stack[spi].s=
pilled_ptr.ref_obj_id)
> +				return false;
> +			if (old->stack[spi].spilled_ptr.ref_obj_id &&
> +			    !check_ids(old->stack[spi].spilled_ptr.ref_obj_id,
> +				       cur->stack[spi].spilled_ptr.ref_obj_id, idmap))
> +				return false;
> +			WARN_ON_ONCE(i % BPF_REG_SIZE);
> +			i +=3D BPF_REG_SIZE - 1;
> +			continue;
> +		}

Nitpick: maybe move the checks above inside regsafe() as all
conditions operate on old/cur->stack[spi].spilled_ptr ?

Acked-by: Eduard Zingerman <eddyz@gmail.com>

>  		if (i % BPF_REG_SIZE !=3D BPF_REG_SIZE - 1)
>  			continue;
>  		if (!is_spilled_reg(&old->stack[spi]))

