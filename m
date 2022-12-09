Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94A64831F
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIN6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIN6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 08:58:52 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FEA75BC5
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 05:58:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m18so11670943eji.5
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce9H78b0mHZuBP5UqB+KrWENWxRYvJN1Jl8hGp9aoGk=;
        b=YKbofFhgDO6g4RIYE+ShezvPmu0plzOwfj8/RI7daypdBflwjDdKRVHF+eUXFPuq2h
         LXbcTOypyDRm/SD38yTjgLZ7qFWMEiz02cQPLQo4EJijfsLdjKlQamSYsdDfeWFa+H0T
         ebpFq7cX4fwNq634/fNlbE8C/Wvkwyk60Mj8kn9BfmdbuPJXSCJESnw+oFJ/js3pOc5l
         tBd6gSfgQl6xnw+rbrfHmrKztQQ9KZ1JHHARVx7fFSR5bsdcF55pIlBAqhVukcPRESc5
         s8WU1/d4omswzp36O+oB3qyl6tV3DsBoQLM9hOldpngGE7+p1FMXPycMVGao3FI2TlSD
         i68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce9H78b0mHZuBP5UqB+KrWENWxRYvJN1Jl8hGp9aoGk=;
        b=UG1fszRQtfdi/swNueAVpssBNu28AhJIWHQvP5ccXV06Lwxf8KhvkJgl1wkT/XpLiY
         vnJyr+kI09AIrAFEbjuk41hKde8mSZXE0L5MIAUN72viDvwNa8QcVfp9bDyFILyPg1r/
         vxFArfoouVXEfTi9Fq8artAgR/Zh8llKUHfIqYykdXhDld56FvLKpQJwGrEeQHD5f0NW
         d2TLzL/iIdlTq8r8y/ByMtAdffOHSPTKsC0W95mII8l6g6gdfmMKdp50EIb7Qc6GlF9J
         T4qKqK3SrFHucKAUqbbe9JyFjSpJ6nsm8HWOIt48wusdEh8cfazbr1X+bMpn4SKypv5g
         FTWw==
X-Gm-Message-State: ANoB5pl8lKiRMtKiYdM17R1QA5U3wv0B81iRypuwvJopOm3uY02wHCJh
        05YtOlgFginm92CaKh5IHDXnyNp86VDv0g==
X-Google-Smtp-Source: AA0mqf4BZ6XjyD3koqjoGD1mk4cCV5U9PZF+ZEN9Q50brFV+wWHZLtLA4i8arTVAWiwGTKmU+T2VoA==
X-Received: by 2002:a17:906:3702:b0:7ad:a797:5bbb with SMTP id d2-20020a170906370200b007ada7975bbbmr4780238ejc.63.1670594330063;
        Fri, 09 Dec 2022 05:58:50 -0800 (PST)
Received: from pluto.. (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a170906830600b007c10fe64c5dsm589028ejx.86.2022.12.09.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:58:49 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, memxor@gmail.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next 3/7] bpf: states_equal() must build idmap for all function frames
Date:   Fri,  9 Dec 2022 15:57:29 +0200
Message-Id: <20221209135733.28851-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209135733.28851-1-eddyz87@gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

verifier.c:states_equal() must maintain register ID mapping across all
function frames. Otherwise the following example might be erroneously
marked as safe:

main:
    fp[-24] = map_lookup_elem(...)  ; frame[0].fp[-24].id == 1
    fp[-32] = map_lookup_elem(...)  ; frame[0].fp[-32].id == 2
    r1 = &fp[-24]
    r2 = &fp[-32]
    call foo()
    r0 = 0
    exit

foo:
  0: r9 = r1
  1: r8 = r2
  2: r7 = ktime_get_ns()
  3: r6 = ktime_get_ns()
  4: if (r6 > r7) goto skip_assign
  5: r9 = r8

skip_assign:                ; <--- checkpoint
  6: r9 = *r9               ; (a) frame[1].r9.id == 2
                            ; (b) frame[1].r9.id == 1

  7: if r9 == 0 goto exit:  ; mark_ptr_or_null_regs() transfers != 0 info
                            ; for all regs sharing ID:
                            ;   (a) r9 != 0 => &frame[0].fp[-32] != 0
                            ;   (b) r9 != 0 => &frame[0].fp[-24] != 0

  8: r8 = *r8               ; (a) r8 == &frame[0].fp[-32]
                            ; (b) r8 == &frame[0].fp[-32]
  9: r0 = *r8               ; (a) safe
                            ; (b) unsafe

exit:
 10: exit

While processing call to foo() verifier considers the following
execution paths:

(a) 0-10
(b) 0-4,6-10
(There is also path 0-7,10 but it is not interesting for the issue at
 hand. (a) is verified first.)

Suppose that checkpoint is created at (6) when path (a) is verified,
next path (b) is verified and (6) is reached.

If states_equal() maintains separate 'idmap' for each frame the
mapping at (6) for frame[1] would be empty and
regsafe(r9)::check_ids() would add a pair 2->1 and return true,
which is an error.

If states_equal() maintains single 'idmap' for all frames the mapping
at (6) would be { 1->1, 2->2 } and regsafe(r9)::check_ids() would
return false when trying to add a pair 2->1.

This issue was suggested in the following discussion:
https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=rVoXfr_JVm8+1Q@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 4 ++--
 kernel/bpf/verifier.c        | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 70d06a99f0b8..c1f769515beb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -273,9 +273,9 @@ struct bpf_id_pair {
 	u32 cur;
 };
 
-/* Maximum number of register states that can exist at once */
-#define BPF_ID_MAP_SIZE (MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE)
 #define MAX_CALL_FRAMES 8
+/* Maximum number of register states that can exist at once */
+#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d05c5d0344c6..9188370a7ebe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13122,7 +13122,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 {
 	int i;
 
-	memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
 			     env->idmap_scratch))
@@ -13146,6 +13145,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->curframe != cur->curframe)
 		return false;
 
+	memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
+
 	/* Verification state from speculative execution simulation
 	 * must never prune a non-speculative execution one.
 	 */
-- 
2.34.1

