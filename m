Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072006262E7
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKU17 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiKKU16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:27:58 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B276F81
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:27:57 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 6so5227982pgm.6
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS03vjLIroSZIkyHrOf+K4IrRoWOidwQJyrYr1fTaXA=;
        b=Lk4wyqyhZ+PUSU/P8lJx9Du8ciJ1yTtRJINotBoUcfy6LvOfxmkpYFWQbXXI455vWm
         H9UEJMs7I0KdTPvFLwEedbJ7olt9e0aLastxt2rk7j+APpYKybiAAkZLu9spmo10H1HD
         KuzgwZa6k0Z1Pgapj9KeCXoljghAsA1vjzMu0Gv7gUw9KEWB2cdaqFy0rwkiu3d7ukPe
         VEFzh8rAflWJgL0N/ZWNqDFR6ixBD+ralP0vsqiK/b/RbmgMHiWhi5eaukCEAIbYySGL
         neg5is70whqsbIGIZ7pZNLXGTNWVrTK5GM9LoNO+hOeb7l+rZqZEis9vcfjDKplBzc7f
         7YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS03vjLIroSZIkyHrOf+K4IrRoWOidwQJyrYr1fTaXA=;
        b=GDsl+ltxNGPtiIO0+JUOO7JrMKoouVkZut0378gzqIMVGRkwjRllbyTWt64OPoiTQ3
         oi29L+PAPdkhZpPHwHUymmFpbnuDfAt2il4Z7k2EKrscNXDzj3zvROTX6mQyxPNBVEFJ
         +sIsv4EL/qado0JokDWLXlgLPxTfWbblIlha5SYZk0UPEW+Y9IL4g33fvxqZy9GCEXxh
         B4hQH26Qtd5COS3VWBXi0uMMNraay5icAaWeAoB4AjDUbP8N9WirPUYcdm/9EOjuoINF
         kXSbEfyedzhvXKQ2qxO2ZauEFwtyik+k6+JA5ZWvtGx4pOBASM0HClR9H6BLTN9eJ6hV
         gwCw==
X-Gm-Message-State: ANoB5pn66hMdKbxj4LvuazZqm5+n0zs5KPwSrySWh+DhxMDRNc9h/gNw
        toFMMAKCSCXDNUqH5ypZqvD0uDPt++7mgw==
X-Google-Smtp-Source: AA0mqf6jO1yRESlUetjZOygM3EAH8288rNBTFC66kNrhvZbb5jmPG/Um39qJWSFamCeaELgfi/Xr0Q==
X-Received: by 2002:aa7:9218:0:b0:562:ce80:1417 with SMTP id 24-20020aa79218000000b00562ce801417mr4322281pfo.19.1668198476881;
        Fri, 11 Nov 2022 12:27:56 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w190-20020a6230c7000000b0056bb99db338sm2033612pfw.175.2022.11.11.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 12:27:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>
Subject: [PATCH bpf v1 1/2] bpf: Fix state pruning check for PTR_TO_MAP_VALUE
Date:   Sat, 12 Nov 2022 01:57:18 +0530
Message-Id: <20221111202719.982118-2-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111202719.982118-1-memxor@gmail.com>
References: <20221111202719.982118-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703; i=memxor@gmail.com; h=from:subject; bh=+iKmCDqrZh4fPpK1FufVgf0AgNJZSsM2gmax3k0dc6Y=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbq/82o/QbdiMPu5GtzmexV0YG50aEDgyE+zZxV+h ODAgqXiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26v/AAKCRBM4MiGSL8RyvDqEA CrYaxm0jUjVB52LPu9RQeZnmWogZIlFD7Ixm1aOTDFkkb0PpWRjemSCWvr8aHyvOH5PM3gEHZV+llr NUaFRV+Mf9vLspPwG7eJjPb5dmyvioscA4FcUNbFSvXuvqgWjvVfGBZrRpUugX0HGg+/DqZQQSL2ff ikPe+Up6T7FxSfxqeqoOIKxzdyjNhmhHiFRktEaQ4dFvb0gIhFnZDhjQzjiO/gzuorHKOIHsLHOfGO tM/IHWrpH0aIOXSZrvruv2q5GeEkG0yZclW73FPN606zvmAXoHjLlsTvdAj39IMiHxziLgVey2LgmI 9LhM/iubHiAlF4X9RhTifDDiMLgk9bb7Quda24akV2Ow+kt82Bt8cSdgbEOxhQkFmvT3rzB4I2mVIK wewpGDhfAjU9cQv3cTYKRUQ37y6M9JNiGDzBOU/Qh5rWVSSgoZCHVXmd+qgOmIqu1Q852CzZ515Ijt N+JQVfXI4IvDiXlwzENm7K7oHfobYZ9NFMRg5FDMP2ttSc7nNYtxPbCAWsn6Ue50YIFMr8NLLt9ESr 6HjTm+g8TmAlt2Os0zzE4ObcAYvQ3o0dQC5Us9c89ZpM+M9w9OMErRrkVb9QSGkz7cL8vohnjUppLX budZw6C8qU7dJptqF31SDB2r5XpflfQQVNb34uNjJ74q3zJ6i4X7yEcZGuHw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the verifier preserves reg->id for PTR_TO_MAP_VALUE when it
points to a map value that contains a bpf_spin_lock element (see the
logic in reg_may_point_to_spin_lock and how it is used to skip setting
reg->id to 0 in mark_ptr_or_null_reg). This gives a unique lock ID for
each critical section begun by a bpf_spin_lock helper call.

The same reg->id is matched with env->active_spin_lock during unlock to
determine whether bpf_spin_unlock is called for the same bpf_spin_lock
object.

However, regsafe takes a different approach to safety checks currently.
The comparison of reg->id was explicitly skipped in the commit being
fixed with the reasoning that the reg->id value should have no bearing
on the safety of the program if the old state was verified to be safe.

This however is demonstrably not true (with a selftest having the
verbose working test case in a later commit), with the following pseudo
code:

	r0 = bpf_map_lookup_elem(&map, ...); // id=1
	r6 = r0;
	r0 = bpf_map_lookup_elem(&map, ...); // id=2
	r7 = r0;

	bpf_spin_lock(r1=r6);
	if (cond) // unknown scalar, hence verifier cannot predict branch
		r6 = r7;
	p:
	bpf_spin_unlock(r1=r7);

In the first exploration path, we would want the verifier to skip
over the r6 = r7 assignment so that it reaches BPF_EXIT and the
state branches counter drops to 0 and it becomes a safe verified
state.

The branch target 'p' acts a pruning point, hence states will be
compared. If the old state was verified without assignment, it has
r6 with id=1, but the new state will have r6 with id=2. The other
parts of register, stack, and reference state and any other verifier
state compared in states_equal remain unaffected by the assignment.

Now, when the memcmp fails for r6, the verifier drops to the switch case
and simply memcmp until the id member, and requires the var_off to be
more permissive in the current state. Once establishing this fact, it
returns true and search is pruned.

Essentially, we end up calling unlock for a bpf_spin_lock that was never
locked whenever the condition is true at runtime.

To fix this, also include id in the memcmp comparison. Since ref_obj_id
is never set for PTR_TO_MAP_VALUE, change the offsetof to be until that
member.

Note that by default the reg->id in case of PTR_TO_MAP_VALUE should be 0
(without PTR_MAYBE_NULL), so it should only really impact cases where a
bpf_spin_lock is present in the map element.

Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 264b3dc714cc..7e6bac344d37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11559,13 +11559,34 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
-		 * 'id' is not compared, since it's only used for maps with
-		 * bpf_spin_lock inside map element and in such cases if
-		 * the rest of the prog is valid for one map element then
-		 * it's valid for all map elements regardless of the key
-		 * used in bpf_map_lookup()
+		 *
+		 * 'id' must also be compared, since it's used for maps with
+		 * bpf_spin_lock inside map element and in such cases if the
+		 * rest of the prog is valid for one map element with a specific
+		 * id, then the id in the current state must match that of the
+		 * old state so that any operations on this reg in the rest of
+		 * the program work correctly.
+		 *
+		 * One example is a program doing the following:
+		 *	r0 = bpf_map_lookup_elem(&map, ...); // id=1
+		 *	r6 = r0;
+		 *	r0 = bpf_map_lookup_elem(&map, ...); // id=2
+		 *	r7 = r0;
+		 *
+		 *	bpf_spin_lock(r1=r6);
+		 *	if (cond)
+		 *		r6 = r7;
+		 * p:
+		 *	bpf_spin_unlock(r1=r6);
+		 *
+		 * The label 'p' is a pruning point, hence states for that
+		 * insn_idx will be compared. If we don't compare the id, the
+		 * program will pass as the r6 and r7 are otherwise identical
+		 * during the second pass that compares the already verified
+		 * state with the one coming from the path having the additional
+		 * r6 = r7 assignment.
 		 */
-		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, ref_obj_id)) == 0 &&
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
 	case PTR_TO_PACKET_META:
-- 
2.38.1

