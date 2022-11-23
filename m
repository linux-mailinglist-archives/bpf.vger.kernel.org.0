Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A11636BBE
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiKWVBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWVBa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:01:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769D14D01
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:01:29 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ha10so15324ejb.3
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXDkEi4/E6GPy1wpIs/naBm0Zt/Tx+cOhvt28AUTmVg=;
        b=pw6AjqV5Zgva3bGlUDG0Q0egEmsceQ7v6fKganrSJYlCFUdbER/qAzjoRB50WG1RY+
         peasx8RKgfkkfHI32ZfiycsIdvjiSRmpqOk0XcpYLyzDn0QATkZyG56iJx8KzuR4vsTg
         RJLRVr81NXToZWEpHFzFq6GzBVPYKhJUTY5Ixj0TrzL5GX/P2GlKdNl15MUOedmdyL0r
         BLpaOH8I+bQlEm3wx1ujn1uNKsQ1Bo9YtP3O/cuocN/Wjj1OSxxkTjQyo7voadEb8EZ0
         iozY1HJy1GhH8i1/hY9mbqYZlJnzOnrpEvRdUOcsNvbR8gNjlUkBqocSyzuxeXLb4tbQ
         5XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXDkEi4/E6GPy1wpIs/naBm0Zt/Tx+cOhvt28AUTmVg=;
        b=tUgzA+geXo9z224DUQQpoS3Q4z++hxYvxWEBLkhGg94iKuAirQ/bhqIUmufZ0lx0MT
         vNIvnlU/1/lBPJBRQSwGN6dJxJtj1/m/nXWaLMc5a8RKmuQODBLZLoJs4B29kXUkDC1r
         7W3rFadHWX3PoIMpsOXbCWCAezPfouc8qeSxei0aYqH9W/l8L/TGlTOW4cEnhRrOuYnk
         xW1r50TobE60p8urSCMKGpdmb11lTuXTOZax6g5WRLNB3bb63S3en8+2oihg73hCv7v6
         wDKpQ3rCQAmrKoUrqXldD80S1dbBb6wBv4cRu7yhHErMZpFJTUPi9eZXFYTA7MqD/zuQ
         4Bhw==
X-Gm-Message-State: ANoB5pkj7sBwvrwb3+8q2R5nsBeNvVALoLMWe84NS1mOJTvt/V7SkjwH
        HjCJmm40JpxaFz1UJoabtT3pe2ec+tbPowLQ7SocIWCERtE=
X-Google-Smtp-Source: AA0mqf6kVQg0WUbzlLZ2Z2oSWcyD1HM9Nzq+g/5V+rLyc3BUI1cqbviHQSNpMqKDZifM2P2IdV9pV9DChSxnwPp+Jx4=
X-Received: by 2002:a17:906:414c:b0:7a9:ecc1:2bd2 with SMTP id
 l12-20020a170906414c00b007a9ecc12bd2mr12987477ejk.545.1669237287855; Wed, 23
 Nov 2022 13:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20221111202719.982118-1-memxor@gmail.com> <20221111202719.982118-2-memxor@gmail.com>
In-Reply-To: <20221111202719.982118-2-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Nov 2022 13:01:16 -0800
Message-ID: <CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=rVoXfr_JVm8+1Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix state pruning check for PTR_TO_MAP_VALUE
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 12:27 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, the verifier preserves reg->id for PTR_TO_MAP_VALUE when it
> points to a map value that contains a bpf_spin_lock element (see the
> logic in reg_may_point_to_spin_lock and how it is used to skip setting
> reg->id to 0 in mark_ptr_or_null_reg). This gives a unique lock ID for
> each critical section begun by a bpf_spin_lock helper call.
>
> The same reg->id is matched with env->active_spin_lock during unlock to
> determine whether bpf_spin_unlock is called for the same bpf_spin_lock
> object.
>
> However, regsafe takes a different approach to safety checks currently.
> The comparison of reg->id was explicitly skipped in the commit being
> fixed with the reasoning that the reg->id value should have no bearing
> on the safety of the program if the old state was verified to be safe.
>
> This however is demonstrably not true (with a selftest having the
> verbose working test case in a later commit), with the following pseudo
> code:
>
>         r0 = bpf_map_lookup_elem(&map, ...); // id=1
>         r6 = r0;
>         r0 = bpf_map_lookup_elem(&map, ...); // id=2
>         r7 = r0;
>
>         bpf_spin_lock(r1=r6);
>         if (cond) // unknown scalar, hence verifier cannot predict branch
>                 r6 = r7;
>         p:
>         bpf_spin_unlock(r1=r7);
>
> In the first exploration path, we would want the verifier to skip
> over the r6 = r7 assignment so that it reaches BPF_EXIT and the
> state branches counter drops to 0 and it becomes a safe verified
> state.
>
> The branch target 'p' acts a pruning point, hence states will be
> compared. If the old state was verified without assignment, it has
> r6 with id=1, but the new state will have r6 with id=2. The other
> parts of register, stack, and reference state and any other verifier
> state compared in states_equal remain unaffected by the assignment.
>
> Now, when the memcmp fails for r6, the verifier drops to the switch case
> and simply memcmp until the id member, and requires the var_off to be
> more permissive in the current state. Once establishing this fact, it
> returns true and search is pruned.
>
> Essentially, we end up calling unlock for a bpf_spin_lock that was never
> locked whenever the condition is true at runtime.
>
> To fix this, also include id in the memcmp comparison. Since ref_obj_id
> is never set for PTR_TO_MAP_VALUE, change the offsetof to be until that
> member.
>
> Note that by default the reg->id in case of PTR_TO_MAP_VALUE should be 0
> (without PTR_MAYBE_NULL), so it should only really impact cases where a
> bpf_spin_lock is present in the map element.
>
> Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 264b3dc714cc..7e6bac344d37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11559,13 +11559,34 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>
>                 /* If the new min/max/var_off satisfy the old ones and
>                  * everything else matches, we are OK.
> -                * 'id' is not compared, since it's only used for maps with
> -                * bpf_spin_lock inside map element and in such cases if
> -                * the rest of the prog is valid for one map element then
> -                * it's valid for all map elements regardless of the key
> -                * used in bpf_map_lookup()
> +                *
> +                * 'id' must also be compared, since it's used for maps with
> +                * bpf_spin_lock inside map element and in such cases if the
> +                * rest of the prog is valid for one map element with a specific
> +                * id, then the id in the current state must match that of the
> +                * old state so that any operations on this reg in the rest of
> +                * the program work correctly.
> +                *
> +                * One example is a program doing the following:
> +                *      r0 = bpf_map_lookup_elem(&map, ...); // id=1
> +                *      r6 = r0;
> +                *      r0 = bpf_map_lookup_elem(&map, ...); // id=2
> +                *      r7 = r0;
> +                *
> +                *      bpf_spin_lock(r1=r6);
> +                *      if (cond)
> +                *              r6 = r7;
> +                * p:
> +                *      bpf_spin_unlock(r1=r6);
> +                *
> +                * The label 'p' is a pruning point, hence states for that
> +                * insn_idx will be compared. If we don't compare the id, the
> +                * program will pass as the r6 and r7 are otherwise identical
> +                * during the second pass that compares the already verified
> +                * state with the one coming from the path having the additional
> +                * r6 = r7 assignment.
>                  */
> -               return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
> +               return memcmp(rold, rcur, offsetof(struct bpf_reg_state, ref_obj_id)) == 0 &&

I don't think it's right to check ids exactly. I do think that this
check is missing check_ids(), though, but its unrelated to the problem
you are trying to solve.

As for the problem with spin_lock above. Again, there is nothing wrong
about doing the whole id remapping idea, it just establishes
equivalence between registers/slots without requiring absolute values
of IDs to be exact, rather it finds a consistent and correct
permutation.

I think the fix is what Ed suggested. Where we currently check

old->active_lock.ptr != cur->active_lock.ptr || old->active_lock.id !=
cur->active_lock.id

at least for IDs we should do the comparison with check_ids().


But another thing which I'm not sure about and jumped on me when I
looked at the code is that we reset ID map for each function frame,
not preserving the mapping across all frames. It might be sufficient,
but seems iffy. Also, I think we should take idmap into account when
doing refsafe(), which would require "global" idmap across all frames.

Thoughts?


>                        range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off);
>         case PTR_TO_PACKET_META:
> --
> 2.38.1
>
