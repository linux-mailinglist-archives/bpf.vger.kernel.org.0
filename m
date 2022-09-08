Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC365B10C7
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 02:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIHAHr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 20:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIHAHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 20:07:46 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA0AF4A6
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 17:07:45 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 5B3DD117037F1; Wed,  7 Sep 2022 17:07:33 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 6/8] bpf: Add verifier support for custom callback return range
Date:   Wed,  7 Sep 2022 17:02:52 -0700
Message-Id: <20220908000254.3079129-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220908000254.3079129-1-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is ported from Dave Marchevsky's patch [0], which is needed for the
bpf iterators callback to return values beyond the 0, 1 range.

For comments, please refer to Dave's patch.

[0] https://lore.kernel.org/bpf/20220830172759.4069786-2-davemarchevsky@f=
b.com/

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8fbc1d05281e..63cda732ee10 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -248,6 +248,7 @@ struct bpf_func_state {
 	 */
 	u32 async_entry_cnt;
 	bool in_callback_fn;
+	struct tnum callback_ret_range;
 	bool in_async_callback_fn;
=20
 	/* The following fields should be last. See copy_func_state() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c8c101513f5..2eb2a4410344 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1814,6 +1814,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->callsite =3D callsite;
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
+	state->callback_ret_range =3D tnum_range(0, 1);
 	init_reg_state(env, state);
 	mark_verifier_state_scratched(env);
 }
@@ -6974,6 +6975,7 @@ static int set_find_vma_callback_state(struct bpf_v=
erifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_callback_fn =3D true;
+	callee->callback_ret_range =3D tnum_range(0, 1);
 	return 0;
 }
=20
@@ -7000,8 +7002,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
 	state->curframe--;
 	caller =3D state->frame[state->curframe];
 	if (callee->in_callback_fn) {
-		/* enforce R0 return value range [0, 1]. */
-		struct tnum range =3D tnum_range(0, 1);
+		struct tnum range =3D callee->callback_ret_range;
=20
 		if (r0->type !=3D SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
--=20
2.30.2

