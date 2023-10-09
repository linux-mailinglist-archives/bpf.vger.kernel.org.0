Return-Path: <bpf+bounces-11732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64847BE610
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69531281E15
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917DC38BBE;
	Mon,  9 Oct 2023 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF338BA8
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:14:26 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B222D8;
	Mon,  9 Oct 2023 09:14:21 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3526c9c401aso15576715ab.1;
        Mon, 09 Oct 2023 09:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868061; x=1697472861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oz2+J9eLTjHyn4qVA1tue5CmqKBSnkz6z7OJvEmTc0=;
        b=kHJhqvPwQU6jb5ZG0u1Az33HdKVJyFPDl5jiBUDtAUctOpU6Jq5UJLyj+uSJIHfTpg
         TJC9B8pITZ/qez3Y155oz6T/gZsMVmqyoqcJwp1JUc9wM/QwRKIxty8YSRAMhmqS2+yi
         n8xD7p1tt7vCsfaf65uTxJpf6MhS0zeyAHCd67inSxrUegE06eo3zSBKA5u7jhGUPt7U
         nXMEmiqyTePqtgKFEmPGzeKvvtOV/QmbPI727HN1/N0M2degSmvAe/F6XqEoEyOCP+sv
         JcmTjgwWIoKDTkGNxhPvm3bdlusmJixVyLefcRDfJUcTeo2tS66GU/Cchps2NTy/lDgj
         SXPA==
X-Gm-Message-State: AOJu0YzOHUPWQ86RwQlU93Ca7+h2ilYaX7ZvtATiuCxy0RqlKCI9I9lq
	nT402+haGDiB0kt+dl5E+kPB1pfZ78R4Aqit
X-Google-Smtp-Source: AGHT+IEPd5aeYH+JcNEYASnuKN/+aGbFmVjrwPIXtxlZDhvg9/Wu+bU96dcz1arMg7m9ai4g/l2/gw==
X-Received: by 2002:a05:6e02:178f:b0:350:f0e6:a7c5 with SMTP id y15-20020a056e02178f00b00350f0e6a7c5mr10686419ilu.16.1696868060761;
        Mon, 09 Oct 2023 09:14:20 -0700 (PDT)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id dp19-20020a0566381c9300b0043a1a45a7b2sm2208240jab.62.2023.10.09.09.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:14:20 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Fix verifier log for async callback return values
Date: Mon,  9 Oct 2023 11:14:13 -0500
Message-ID: <20231009161414.235829-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The verifier, as part of check_return_code(), verifies that async
callbacks such as from e.g. timers, will return 0. It does this by
correctly checking that R0->var_off is in tnum_const(0), which
effectively checks that it's in a range of 0. If this condition fails,
however, it prints an error message which says that the value should
have been in (0x0; 0x1). This results in possibly confusing output such
as the following in which an async callback returns 1:

At async callback the register R0 has value (0x1; 0x0) should have been
in (0x0; 0x1)

The fix is easy -- we should just pass the tnum_const(0) as the correct
range to verbose_invalid_scalar(), which will then print the following:

At async callback the register R0 has value (0x1; 0x0) should have been
in (0x0; 0x0)

Fixes: bfc6bb74e4f1 ("bpf: Implement verifier support for validation of async callbacks.")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed7350e15f4..9093fb74c88e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14729,7 +14729,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno)
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
 	struct bpf_reg_state *reg;
-	struct tnum range = tnum_range(0, 1);
+	struct tnum range = tnum_range(0, 1), const_0 = tnum_const(0);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
@@ -14777,8 +14777,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno)
 			return -EINVAL;
 		}
 
-		if (!tnum_in(tnum_const(0), reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &range, "async callback", "R0");
+		if (!tnum_in(const_0, reg->var_off)) {
+			verbose_invalid_scalar(env, reg, &const_0, "async callback", "R0");
 			return -EINVAL;
 		}
 		return 0;
-- 
2.41.0


