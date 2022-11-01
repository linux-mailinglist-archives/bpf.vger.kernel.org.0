Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3761564B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 00:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKAXy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAXy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 19:54:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4551A07B
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 16:54:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c25so9550698ljr.8
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77RgCksYwxkJD6kvcAlGoDlYuwlJwjtgAzjkHRdzR+o=;
        b=OssbHO4FhMULEjgbMBV+LbS0qkHHmdLrbHVLkWl85QFEtW0uD0hX6iyzB5+L96WZ2o
         spvy7zm9q28sBl7QIfKke7Hv73Rc+7E1MNgmQmuN7tFt7p+ylCd5+kDWoKfQ6dogKplD
         vHwHFdZSZfTdWD3iApCoWl5KLuZDF5SzOnvmXWL4am1Rx/h7dVxccqJhWF7Z9l3gU1xD
         Sk+DXwNJUVgoeT+A5mjc4kC8fnnYTCXD3klDinaoFxrsYvMta2vogB1ez9shqgH+RfJ3
         fsAn4YNXywHhyPivfxD9Ifg7Wm2XWYgYuLsLKh+EyoeVRSgPIhgGwkLkx/IdpeKwcbxZ
         P4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77RgCksYwxkJD6kvcAlGoDlYuwlJwjtgAzjkHRdzR+o=;
        b=DDfMrSnVp9FsfJ1xUVkYCJrM5P3aPtTe42DLncQbOFZKZereoT3Bc6Nm31lVwDj86/
         BIP0lDEAHrVD14GttPpKujWtZHLokBNriPYiuEtUqTtt14H7Q7eAtUWH7H8zpgt6Tfeg
         xRxA7xe561PW7eHDE6JbQt6q271oCnbMJqJAAa7X5NPL2Vtz0/XrbN+Q2iI6BEFcKAsc
         6yT91r1I2M2S5BcfwznUUWg+IR2rRSd+qUPIzM01Q5tasG5wc5rXsIyovnjTR78Ic4Ig
         VBYlBE/ekQJNMolBvi2ilnKPJFMudb1/4DnrjREpuvAEv0xcXDp5IdEFGoaUr9l+F7Hd
         tPmw==
X-Gm-Message-State: ACrzQf2lpHpazblf2gscT8yktklG0QE6sbk9DEIf+rZfAS4UEW0ymVDt
        8RQCfCtBMQcQDDmkVGyKYH6gKAt/Ybhpa0Kh
X-Google-Smtp-Source: AMsMyM5EOuhfdob1+V+jUp2NLh8d3dh19BKIbLLZhVLBQdIgjVeMhlbcZdlsSbff8BAEzV2p3k+aeQ==
X-Received: by 2002:a2e:82cd:0:b0:277:3cf:8ea3 with SMTP id n13-20020a2e82cd000000b0027703cf8ea3mr8078824ljh.59.1667346894898;
        Tue, 01 Nov 2022 16:54:54 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h17-20020a05651c125100b0026fbac7468bsm1673056ljh.103.2022.11.01.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:54:54 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Tests for enum fwd resolved as full enum64
Date:   Wed,  2 Nov 2022 01:54:13 +0200
Message-Id: <20221101235413.1824260-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101235413.1824260-1-eddyz87@gmail.com>
References: <20221101235413.1824260-1-eddyz87@gmail.com>
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

A set of test cases to verify enum fwd resolution logic:
- verify that enum fwd can be resolved as full enum64;
- verify that enum64 fwd can be resolved as full enum;
- verify that enum size is considered when enums are compared for
  equivalence.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 88 ++++++++++++++++++--
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 127b8caa3dc1..73fdb1c8efc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7120,7 +7120,7 @@ static struct btf_dedup_test dedup_tests[] = {
 				BTF_ENUM_ENC(NAME_NTH(4), 456),
 			/* [4] fwd enum 'e2' after full enum */
 			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 4),
-			/* [5] incompatible fwd enum with different size */
+			/* [5] fwd enum with different size, size does not matter for fwd */
 			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 1),
 			/* [6] incompatible full enum with different value */
 			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
@@ -7137,9 +7137,7 @@ static struct btf_dedup_test dedup_tests[] = {
 			/* [2] full enum 'e2' */
 			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
 				BTF_ENUM_ENC(NAME_NTH(4), 456),
-			/* [3] incompatible fwd enum with different size */
-			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 1),
-			/* [4] incompatible full enum with different value */
+			/* [3] incompatible full enum with different value */
 			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
 				BTF_ENUM_ENC(NAME_NTH(2), 321),
 			BTF_END_RAW,
@@ -7598,7 +7596,87 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0e1\0e1_val"),
 	},
 },
-
+{
+	.descr = "dedup: enum of different size: no dedup",
+	.input = {
+		.raw_types = {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 2),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+	.expect = {
+		.raw_types = {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 2),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+},
+{
+	.descr = "dedup: enum fwd to enum64",
+	.input = {
+		.raw_types = {
+			/* [1] enum64 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 0),
+			/* [2] enum 'e1' fwd */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 4),
+			/* [3] typedef enum 'e1' td */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), 2),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0td"),
+	},
+	.expect = {
+		.raw_types = {
+			/* [1] enum64 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 0),
+			/* [2] typedef enum 'e1' td */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), 1),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0td"),
+	},
+},
+{
+	.descr = "dedup: enum64 fwd to enum",
+	.input = {
+		.raw_types = {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] enum64 'e1' fwd */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+			/* [3] typedef enum 'e1' td */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), 2),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0td"),
+	},
+	.expect = {
+		.raw_types = {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] typedef enum 'e1' td */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_TYPEDEF, 0, 0), 1),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0td"),
+	},
+},
 };
 
 static int btf_type_size(const struct btf_type *t)
-- 
2.34.1

