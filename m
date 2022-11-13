Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A09626D61
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 02:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKMB6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 20:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiKMB6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 20:58:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178562DED
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 17:58:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t5-20020a5b07c5000000b006dfa2102debso2286606ybq.4
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 17:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoMmIMpf4RD5dt8dZBCDE+bIJuy0GA2QFmMHiqu0czw=;
        b=iW84YXsyot5bLcfsrAWwo2iuj8UvtwCg/yqrb55L2wReZSGLP/m9nXV1tLB0pDmGqg
         IyNQaR3hJf1Z9z67ENTLVDmTUiOCBkMI4tUfUIEmdowUdKW/mv0F7u4IN8N4FZ1kX/i6
         tihJ/5/D0BDMsqZywCGHcI9LlHaYrE+6pn+uZQMANDy/t3IxS5hwd9ln+XuIpQz3mLDz
         Zo9FXlgpalsROgIA9CArDJs2DNrtW4bbu69JSHpOVT/Z/O+rOVSdYvx0jG3VMVgH59vp
         dApXFzVtZix9BXJP6H1KYvHGyJldtH7QtuRO4F+kaN7OCmKzQUWWwrtWdpzc4GBzV1XF
         s3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoMmIMpf4RD5dt8dZBCDE+bIJuy0GA2QFmMHiqu0czw=;
        b=DNeYWjzz/p7JNNLuIeeS8eE5Ugqank+yT0+4drfHzLsdrhME+s60PzjEsn5gY8AInF
         UtzE0cVhLSlASPEfVJ582ceoxkjsvrKF+6Em1ulH3b6x0lE/YQlTxMP82BSmBJyxTQ82
         pe7HkkIAoqr3GNqhJz6S14YXj2ds0pnqdbYmS46xlm5UTHrsqOSH6CvtGZJ/U8njrjLN
         s+qp+z27I1t5eV3dny3Vua2RASTkhAfSNeOCr1LGt0Tpft1DjGXzg2Aicf4gJrmrbAMY
         OKwDW/KQpP5snL8oDyPJviro2DxJTmBzuYt2LmIwvafXtiLss99BfhLulqkH2W1uwCGR
         xGfQ==
X-Gm-Message-State: ACrzQf15LNb/p1L6hMrsHjalVFbVZTyr09Vh0uVfvtEhna59aACt4Cok
        97yuSC1JdNXzvcw0F6uV6YXOpCM=
X-Google-Smtp-Source: AMsMyM4cjqen1gXXOLL040RZyb05LlBl/pv+vtv9K+fXBHsGhG1PZIOAcyD5yij5yGVIqLu9B+xC0m8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:3941:0:b0:370:4850:e086 with SMTP id
 g62-20020a813941000000b003704850e086mr60461991ywa.152.1668304693079; Sat, 12
 Nov 2022 17:58:13 -0800 (PST)
Date:   Sat, 12 Nov 2022 17:58:11 -0800
In-Reply-To: <20221111202719.982118-2-memxor@gmail.com>
Mime-Version: 1.0
References: <20221111202719.982118-1-memxor@gmail.com> <20221111202719.982118-2-memxor@gmail.com>
Message-ID: <Y3BPMwmK2DahdiK5@google.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix state pruning check for PTR_TO_MAP_VALUE
From:   sdf@google.com
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12, Kumar Kartikeya Dwivedi wrote:
> Currently, the verifier preserves reg->id for PTR_TO_MAP_VALUE when it
> points to a map value that contains a bpf_spin_lock element (see the
> logic in reg_may_point_to_spin_lock and how it is used to skip setting
> reg->id to 0 in mark_ptr_or_null_reg). This gives a unique lock ID for
> each critical section begun by a bpf_spin_lock helper call.

> The same reg->id is matched with env->active_spin_lock during unlock to
> determine whether bpf_spin_unlock is called for the same bpf_spin_lock
> object.

> However, regsafe takes a different approach to safety checks currently.
> The comparison of reg->id was explicitly skipped in the commit being
> fixed with the reasoning that the reg->id value should have no bearing
> on the safety of the program if the old state was verified to be safe.

> This however is demonstrably not true (with a selftest having the
> verbose working test case in a later commit), with the following pseudo
> code:

> 	r0 = bpf_map_lookup_elem(&map, ...); // id=1
> 	r6 = r0;
> 	r0 = bpf_map_lookup_elem(&map, ...); // id=2
> 	r7 = r0;

> 	bpf_spin_lock(r1=r6);
> 	if (cond) // unknown scalar, hence verifier cannot predict branch
> 		r6 = r7;
> 	p:
> 	bpf_spin_unlock(r1=r7);

> In the first exploration path, we would want the verifier to skip
> over the r6 = r7 assignment so that it reaches BPF_EXIT and the
> state branches counter drops to 0 and it becomes a safe verified
> state.

> The branch target 'p' acts a pruning point, hence states will be
> compared. If the old state was verified without assignment, it has
> r6 with id=1, but the new state will have r6 with id=2. The other
> parts of register, stack, and reference state and any other verifier
> state compared in states_equal remain unaffected by the assignment.

> Now, when the memcmp fails for r6, the verifier drops to the switch case
> and simply memcmp until the id member, and requires the var_off to be
> more permissive in the current state. Once establishing this fact, it
> returns true and search is pruned.

> Essentially, we end up calling unlock for a bpf_spin_lock that was never
> locked whenever the condition is true at runtime.

> To fix this, also include id in the memcmp comparison. Since ref_obj_id
> is never set for PTR_TO_MAP_VALUE, change the offsetof to be until that
> member.

> Note that by default the reg->id in case of PTR_TO_MAP_VALUE should be 0
> (without PTR_MAYBE_NULL), so it should only really impact cases where a
> bpf_spin_lock is present in the map element.

> Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Sounds convincing. Also run the selftest to make sure it fails w/o this
patch.

> ---
>   kernel/bpf/verifier.c | 33 +++++++++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 6 deletions(-)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 264b3dc714cc..7e6bac344d37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11559,13 +11559,34 @@ static bool regsafe(struct bpf_verifier_env  
> *env, struct bpf_reg_state *rold,

>   		/* If the new min/max/var_off satisfy the old ones and
>   		 * everything else matches, we are OK.
> -		 * 'id' is not compared, since it's only used for maps with
> -		 * bpf_spin_lock inside map element and in such cases if
> -		 * the rest of the prog is valid for one map element then
> -		 * it's valid for all map elements regardless of the key
> -		 * used in bpf_map_lookup()
> +		 *
> +		 * 'id' must also be compared, since it's used for maps with
> +		 * bpf_spin_lock inside map element and in such cases if the
> +		 * rest of the prog is valid for one map element with a specific
> +		 * id, then the id in the current state must match that of the
> +		 * old state so that any operations on this reg in the rest of
> +		 * the program work correctly.
> +		 *
> +		 * One example is a program doing the following:
> +		 *	r0 = bpf_map_lookup_elem(&map, ...); // id=1
> +		 *	r6 = r0;
> +		 *	r0 = bpf_map_lookup_elem(&map, ...); // id=2
> +		 *	r7 = r0;
> +		 *
> +		 *	bpf_spin_lock(r1=r6);
> +		 *	if (cond)
> +		 *		r6 = r7;
> +		 * p:
> +		 *	bpf_spin_unlock(r1=r6);
> +		 *
> +		 * The label 'p' is a pruning point, hence states for that
> +		 * insn_idx will be compared. If we don't compare the id, the
> +		 * program will pass as the r6 and r7 are otherwise identical
> +		 * during the second pass that compares the already verified
> +		 * state with the one coming from the path having the additional
> +		 * r6 = r7 assignment.
>   		 */
> -		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
> +		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, ref_obj_id))  
> == 0 &&
>   		       range_within(rold, rcur) &&
>   		       tnum_in(rold->var_off, rcur->var_off);
>   	case PTR_TO_PACKET_META:
> --
> 2.38.1

