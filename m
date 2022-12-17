Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05764F6FC
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 03:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLQCRn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 21:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiLQCRm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 21:17:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D087286F8
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y25so6140080lfa.9
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMx7mzBdU25HS+HEGhH8TvxGaEt099WYH8w/+oYIf/c=;
        b=mmLdKSVU9PB4Dtw1nPRJizrssreKPefdeVWFEY7ykAlbXBHKbSmPaNEFjwZlnKUEPX
         Gncoa0I4vTU21Bs/n49lgRqpywjLwpjTWLVGDucBctQUwfy130wGP64c4Ns8V6l39Sbn
         2cccA9MZXeSAC2AbGPbkJEFv+N03321mIX/mhJ8uoMPYOGtjVwiWD+QyctOwComQllY6
         wJY+uQm9ERbsZ3/FvUkyava7JdvfL+d/s0Ydl84U96mlsLVe/x2WGW1BLJciIQK4XDzc
         gYevodyPCU1x4IUzkoXPZ5P76+8YbdVFXp3PhE67ypM6WosK8WTvzNhMZYD87nP6qNoJ
         08HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMx7mzBdU25HS+HEGhH8TvxGaEt099WYH8w/+oYIf/c=;
        b=JNisTOLMnld4nurFO27lok8h9yEmE2LslWRfQO31mlPl1e29tRQ/PglvOszFObdENL
         RqZ8EjvcSLYy8+JAF0gjkgQ+z2EMR/fLwK/xmv3An+hWHMB2eH3LIazyAHFhVUriJwsV
         m0PH3nFlqsB7yrkoICTevJ0uOQMSi8tL7EiUsLKhTuPZjLYtLo7eKNSv43Vsd085nOtF
         wQ2Cb3N9xe3U9dfRv/xzxcA56GrE6q7Ul8CXxAVzzP5b35IctiGYeeKGK88B10kwuidh
         CF5Z2KYfZbnAjmmdTq2laDJBaqcoLfv8/DAAbMSZQcNfiDbWmvJSFI7GUVTmorIkmsHz
         G/CA==
X-Gm-Message-State: ANoB5pnjPuifKswC1tQ0DI6D4fN0dB/i3HAYGeBZtRnGBVbKua6GePyT
        74KkqXbt922i374PTLnfi4dTQr3FVyQ=
X-Google-Smtp-Source: AA0mqf6OVc387NxOw/ailo+P7N3vZnPf+1hcIORZ4jjaYBy5JwVIedZe+0gIv2pI+vqlHDoTqwvJIQ==
X-Received: by 2002:a05:6512:2613:b0:4a4:68b7:e717 with SMTP id bt19-20020a056512261300b004a468b7e717mr12695031lfb.1.1671243458818;
        Fri, 16 Dec 2022 18:17:38 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b0049e9122bd0esm370850lfn.114.2022.12.16.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:17:38 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/4] bpf: reduce BPF_ID_MAP_SIZE to fit only valid programs
Date:   Sat, 17 Dec 2022 04:17:10 +0200
Message-Id: <20221217021711.172247-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221217021711.172247-1-eddyz87@gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
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

BPF limits stack usage by MAX_BPF_STACK bytes across all call frames,
however this is enforced by function check_max_stack_depth() which is
executed after do_check_{subprogs,main}().

This means that when check_ids() is executed the maximal stack depth is not
yet verified, thus in theory the number of stack spills might be
MAX_CALL_FRAMES * MAX_BPF_STACK / BPF_REG_SIZE.

However, any program with stack usage deeper than
MAX_BPF_STACK / BPF_REG_SIZE would be rejected by verifier.

Hence save some memory by reducing the BPF_ID_MAP_SIZE.

This is a follow up for
https://lore.kernel.org/bpf/CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 4 ++--
 kernel/bpf/verifier.c        | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 53d175cbaa02..da72e16f1dee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -274,8 +274,8 @@ struct bpf_id_pair {
 };
 
 #define MAX_CALL_FRAMES 8
-/* Maximum number of register states that can exist at once */
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
+/* Maximum number of register states that can exist at once in a valid program */
+#define BPF_ID_MAP_SIZE (MAX_BPF_REG * MAX_CALL_FRAMES + MAX_BPF_STACK / BPF_REG_SIZE)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..fb040516a946 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12951,8 +12951,10 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
 		if (idmap[i].old == old_id)
 			return idmap[i].cur == cur_id;
 	}
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
+	/* Run out of slots in idmap, conservatively return false, cached
+	 * state will not be reused. The BPF_ID_MAP_SIZE is sufficiently
+	 * large to fit all valid programs.
+	 */
 	return false;
 }
 
-- 
2.38.2

