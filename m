Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24FB69B985
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBRKxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 05:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRKxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 05:53:32 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE7193FE
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 02:53:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d4so515184pjc.5
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 02:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TwxY/+QXkZ8fBcKsVGyJDCPPvVyS+wPqYk8kS7rgxw=;
        b=Pr/yVWGbJIpx2S1kqActFcyvZuFJY7TAZp8TtgX7IQ8WO356vA3EW79D4hSJzM5S0u
         fX4jssoFgwoVikNRc8iwoxCVnPvjV4LKqvHQZvPbXpqfaB+EzFDUbtTz0HJYeQb6GdMC
         wp0gYIMHywmT3uVbXnHDlnC2NwrPpFcSoo5kkmcAO7zsILqYU/QcDfxC3ZevEj/pnxFd
         2CfPK4oA9lXQ7S3l/bWV0p+/43+GY7JYMZE65nqHDKgzCKRW4JhpP3C3j7xpvlXj/Y4W
         X2d1d6TXRd+NJFVbpm5CQh+CDPk1KdlpcipM3YjlfU8EbI+pXvwtx7Wvl8SS3R2Ql2ay
         n/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TwxY/+QXkZ8fBcKsVGyJDCPPvVyS+wPqYk8kS7rgxw=;
        b=OlcZ8ekba2sB91MYfv/kotjSP07ytwPaqsKjD/8fMgVJvoueosjE5bk77qjm8VsyEy
         ZdQBMq8T8FrePEEONVFy7iX6WbrPYBmqrYbOV5rLXxygTvkV9d0z9sheIRKANYauNj+x
         pZKyVMgxrLTB3YPSSD6uVSiy5ciuDymvcstUP4KrDYOmTDvGqjvy5zFAcD0IqIJ1QBqQ
         28/z9kDsPHdu7ewFLKB8a32ZbiiV1q2KxUbj3NcCxHUiSfsATXDaa5L5ylsuvTabZUOm
         HNtIiMFRrc7PwXoF6Ua4WlTXSVtkg1tOIZyrtojDKJtP11QrR8puztil7GtTTDdawDzV
         Mf1A==
X-Gm-Message-State: AO0yUKXfLgP2k1FwWW8yfUrkqlgFhuUC49hvgFxKsYaYKE27TZEf3Frl
        R9a1h21H/6U4PM+Q7mbONOstHBRyHvM=
X-Google-Smtp-Source: AK7set9F2IN0/X8ODA6RGcx1JbU5O0z7yoBeEix7U7LYPQgAiDiwCvKBLX19TDuJN+AasMKKaFSahQ==
X-Received: by 2002:a17:90b:33d1:b0:22c:afd6:e597 with SMTP id lk17-20020a17090b33d100b0022cafd6e597mr758152pjb.17.1676717611639;
        Sat, 18 Feb 2023 02:53:31 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0e8100b00234e6d2de3dsm654839pjx.11.2023.02.18.02.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 02:53:31 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Cc:     hengqi.chen@gmail.com, yangtiezhu@loongson.cn
Subject: [PATCH bpf-next] LoongArch: BPF: Support mixing bpf2bpf and tailcalls
Date:   Sat, 18 Feb 2023 10:53:17 +0000
Message-Id: <20230218105317.4139666-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.31.1
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

The current implementation already allow such mixing.
Let's enable it in JIT.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 288003a9f0ca..e70c846efaa1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1248,3 +1248,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)

 	return prog;
 }
+
+/* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
+bool bpf_jit_supports_subprog_tailcalls(void)
+{
+	return true;
+}
--
2.31.1
