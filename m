Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90F665CBA1
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 02:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjADBrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 20:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjADBrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 20:47:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31281789B;
        Tue,  3 Jan 2023 17:47:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n4so34529326plp.1;
        Tue, 03 Jan 2023 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N93YY89WDpMZjTihyV1kEiKGVsyhZqvxZRbXkfy1dBE=;
        b=c/oGnk5YDdOxMv6HyaPaUUBNrHeXU9UmROddqkW2D1Vhtm77tujXWuJBLHbHotvJEt
         ZzhBSldYFuZO9nBMP1/QEyqXle7MKVLoXFHaXLKxFxUlBODA/OFAfSFaisDC5ZeM0ebB
         rN62CtXb498KrsK+R+uaO5aBix2y4SaRpg1UarZzwc72594V6OSsMpZEspG5/yuCUox8
         vFBquEThPCxU0p5qYMXlTZxVSIdo7qGWyPLp+yeTVV99xvUrdY6lx7+sTybF51jcahfK
         w1W4CbILjdNheev4ZowVXyXqughHR9Ew4FdFH1s3rIPo75rZj7JwlRAuRH7DNDUO4ks2
         9eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N93YY89WDpMZjTihyV1kEiKGVsyhZqvxZRbXkfy1dBE=;
        b=jXhjXN2n2ehnmevxVDfCimyEAYAygI0HaDA6PLAjm8Ru2srkIuDSafb/2XbYyn8B3U
         ZJ94HZkgR+nvCp1g/ky25UzPlTj4n+NsKpeQMUtiWHrShqikhYRq472Bd9QUZMCTLC1F
         eEiKMIWASkJ7BS8zC8Gm+t/3nvH3C75g8drqATxcRHdnMDRnxgjVm9C61z7ryqpJGSfS
         HXae2x07zXSreHOZaK4zqNtHroO49pLfgMy6guXf/TAZT0TveczegMTA4wFdmhJMBAxs
         cije5JFyNKHEtsOdWUXWt2Uc/e7RObdhIUgpQzScnxM5G7krhJ8hCDVyG6LRvUkzfrhP
         FSgQ==
X-Gm-Message-State: AFqh2kr8cPOgukuW+zm/Nkd3gKzlFvAS7LiT2Ns2ia4tkd7pzcehU3JA
        4OGjHBLkrJZrJYP+G+qINX1/yBzHOUlJ
X-Google-Smtp-Source: AMrXdXths8w3ORcAFDY3TxfvaKampKf1Foy9mlSdG0Nr6Eu+QTc70DKpDuuVyoR9PIuTjeXWIs77+g==
X-Received: by 2002:a17:902:edd1:b0:192:50fe:504a with SMTP id q17-20020a170902edd100b0019250fe504amr44577350plk.16.1672796849860;
        Tue, 03 Jan 2023 17:47:29 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00192bf7eaf28sm6758798plc.286.2023.01.03.17.47.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Jan 2023 17:47:29 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] bpf: skip invalid kfunc call in backtrack_insn
Date:   Wed,  4 Jan 2023 09:47:09 +0800
Message-Id: <20230104014709.9375-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
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

The verifier skips invalid kfunc call in check_kfunc_call(), which
would be captured in fixup_kfunc_call() if such insn is not
eliminated by dead code elimination. However, this can lead to the
following warning in backtrack_insn(), alse see [1]:

------------[ cut here ]------------
verifier backtracking bug
WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
kernel/bpf/verifier.c:2756
	__mark_chain_precision kernel/bpf/verifier.c:3065
	mark_chain_precision kernel/bpf/verifier.c:3165
	adjust_reg_min_max_vals kernel/bpf/verifier.c:10715
	check_alu_op kernel/bpf/verifier.c:10928
	do_check kernel/bpf/verifier.c:13821 [inline]
	do_check_common kernel/bpf/verifier.c:16289
...

So make backtracking conservative with this by returning ENOTSUPP.

[1] https://lore.kernel.org/bpf/CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com/

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a25375ebb0d..04887b1e4178 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2750,6 +2750,12 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 			 */
 			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
 				return -ENOTSUPP;
+			/* kfunc with imm==0 is invalid and fixup_kfunc_call will
+			 * catch this error later. Make backtracking conservative
+			 * with ENOTSUPP.
+			 */
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
+				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			*reg_mask &= ~1;
 			if (*reg_mask & 0x3f) {

base-commit: acd3b7768048fe338248cdf43ccfbf8c084a6bc1
-- 
2.39.0

