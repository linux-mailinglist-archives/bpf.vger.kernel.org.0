Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17267A9D5
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjAYFEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAYFEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:04:12 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFA474F4;
        Tue, 24 Jan 2023 21:04:09 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9so16832255pll.9;
        Tue, 24 Jan 2023 21:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geJZ0n/Osgu93pxX9vL5o3+bzLvg1dQW9V/BZwV5zXs=;
        b=SdK8le0Oc3RV2VGyiqC5X5/c8O3ivrOV9JuDGc5CCgChhAgTX/kU4ADFuksHJMoHHo
         uZn16fni36zg9024Cfg+IxHK/itIi+Nj99WUA/neTRaZHTIALixkhuxtfgWwe+wOgtHu
         zQ0v+J6j6rbmCYwWnlNXLHrbDeYW6LAooJuTibHDMvGUXZQ25ix9CS2SH16G8OHuW3jT
         6shwAJQ0apAbMqIaJLDPBkcnv24MmRr+7DXqL59pCeWFnscjt5OjP8NbKl8hDISzGjXi
         4mpQ5xIrcdv7H8CVUQEr+eE/kc+Z6XsUXH9qOzsGPMTx3Ftnum60YVnLms+WEMWinfui
         LcBQ==
X-Gm-Message-State: AFqh2kqsCgzIfDQ86gD8UMUkxxaXyf12qfwQe6I3cpYdihiHt1Iy53mc
        tdN+GFJtbB1JTjclYfOa3fXwAoW1qrsQ2IXN
X-Google-Smtp-Source: AMrXdXv2QGb+DYsRsUdI31UA6j8j3Zb8Trb48OlYak4YArgfl449oDIC4xUqhzNHCwYwQIgZFZFRWA==
X-Received: by 2002:a05:6a20:c120:b0:b8:8027:13a5 with SMTP id bh32-20020a056a20c12000b000b8802713a5mr31697542pzb.33.1674623048109;
        Tue, 24 Jan 2023 21:04:08 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id u71-20020a63794a000000b004d346876d37sm2301166pgc.45.2023.01.24.21.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:04:07 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v3 1/4] bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
Date:   Tue, 24 Jan 2023 23:03:56 -0600
Message-Id: <20230125050359.339273-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125050359.339273-1-void@manifault.com>
References: <20230125050359.339273-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops programs currently cannot be marked as sleepable. This
need not be the case -- struct_ops programs can be sleepable, and e.g.
invoke kfuncs that export the KF_SLEEPABLE flag. So as to allow future
struct_ops programs to invoke such kfuncs, this patch updates the
verifier to allow struct_ops programs to be sleepable. A follow-on patch
will add support to libbpf for specifying struct_ops.s as a sleepable
struct_ops program, and then another patch will add testcases to the
dummy_st_ops selftest suite which test sleepable struct_ops behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c                            | 5 +++--
 tools/testing/selftests/bpf/verifier/sleepable.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 800488289297..2b8f0c0aa0cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17054,7 +17054,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		}
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
-	       prog->type == BPF_PROG_TYPE_KPROBE; /* only for uprobes */
+	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -17076,7 +17077,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index bea0daef908a..1f0d2bdc673f 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -85,7 +85,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter and uprobe programs can be sleepable",
+	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },
-- 
2.39.0

