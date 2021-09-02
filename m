Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13F53FE969
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhIBGpu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 02:45:50 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:41632 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241528AbhIBGpu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 02:45:50 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 02:45:49 EDT
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowABHyo0bcTBhmXLEAA--.41163S2;
        Thu, 02 Sep 2021 14:37:15 +0800 (CST)
From:   jiasheng <jiasheng@iscas.ac.cn>
To:     bpf@vger.kernel.org
Cc:     jiasheng <jiasheng@iscas.ac.cn>
Subject: [PATCH] bpf: Add env_type_is_resolved() in front of env_stack_push() in btf_resolve()
Date:   Thu,  2 Sep 2021 06:37:13 +0000
Message-Id: <1630564633-552375-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: rQCowABHyo0bcTBhmXLEAA--.41163S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4UKr4fArWUKw48uw4fuFg_yoWkArg_K3
        W8uF1rGwsxKFsaya1jvw4furW2k3yYqFn7Za1aqFs8G3s8WF15Jrn8Xas3JrsrGrWkKrZF
        vFZ8G3sIgF1avjkaLaAFLSUrUUUUob8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbgkYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z2
        80aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq
        67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GF1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vj4RC5l1UUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have found that in the complied files env_stack_push()
appear more than 10 times, and under at least 90% circumstances
that env_type_is_resolved() and env_stack_push() appear in pairs.
For example, they appear together in the btf_modifier_resolve()
of the file complie from 'kernel/bpf/btf.c'.
But we have found that in the btf_resolve(), there is only
env_stack_push() instead of the pair.
Therefore, we consider that the env_type_is_resolved()
might be forgotten.

Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f982a9f0..454c249 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4002,7 +4002,8 @@ static int btf_resolve(struct btf_verifier_env *env,
 	int err = 0;
 
 	env->resolve_mode = RESOLVE_TBD;
-	env_stack_push(env, t, type_id);
+	if (env_type_is_resolved(env, type_id))
+		env_stack_push(env, t, type_id);
 	while (!err && (v = env_stack_peak(env))) {
 		env->log_type_id = v->type_id;
 		err = btf_type_ops(v->t)->resolve(env, v);
-- 
2.7.4

