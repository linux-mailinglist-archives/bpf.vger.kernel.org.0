Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D35679E3A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjAXQJ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAXQJ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:09:28 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23071ABFC;
        Tue, 24 Jan 2023 08:09:27 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id a25so13420667qto.10;
        Tue, 24 Jan 2023 08:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geJZ0n/Osgu93pxX9vL5o3+bzLvg1dQW9V/BZwV5zXs=;
        b=iExaW15UXGcH5X2l1dvf9i8ktI2IL00jf87Sn/fU8AWWy5Ctq3lhhjSK5dWFYRU0kP
         8zQyYu9LlJ29UiPyLmsfCxC2QyOlN62dzdJpXf0Tf5iF3RWhWAnqmtdPs/EVqD5Bwj3A
         fxheHL+ov0pSUQjNt7eZzZqsbD2ZH0xVECuYby6RDP/nGMXd3OtBQjdUIt1ehCuuejJL
         2ociJmShOKxfvIoN8PhE+f41aWxXQKqYB63TGr/SybXpPe3AM+ECeZPOr3PKMxpqwMxR
         4XgH0f1eoMTcPbv/77nEYVhyve9FLDgzsuBkgNOpwAOsNaLrMRmI/nrTa9PntY8rXXOJ
         +hzQ==
X-Gm-Message-State: AFqh2krQhaaIz1PKtZdj2yRpRpVW+UFZb2E/53MXSdz+8zr+1PUmTb75
        mUFB4y7ei28hrlhnJTavntJioPtjqOTgb56N
X-Google-Smtp-Source: AMrXdXuRwLmWTdb1wwo0URe+zpsns5tlaGEWfSvXKgPLOfaea1Ytv5UPnDoFEOFIOkKaiWlyEr8eng==
X-Received: by 2002:ac8:4d04:0:b0:3b6:97f0:42dc with SMTP id w4-20020ac84d04000000b003b697f042dcmr23010708qtv.23.1674576566256;
        Tue, 24 Jan 2023 08:09:26 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id cr18-20020a05622a429200b003a97a71c906sm1448722qtb.78.2023.01.24.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:09:25 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next v2 1/4] bpf: Allow BPF_PROG_TYPE_STRUCT_OPS programs to be sleepable
Date:   Tue, 24 Jan 2023 10:07:59 -0600
Message-Id: <20230124160802.1122124-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124160802.1122124-1-void@manifault.com>
References: <20230124160802.1122124-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

