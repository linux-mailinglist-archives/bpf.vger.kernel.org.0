Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D069507284
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354320AbiDSQHQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354279AbiDSQHO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4837AA4
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bb21so3655476qtb.3
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4O2OSpmLUp+4cB4W8n/8YKgBIPTIe2YgXCavOkNNVs=;
        b=XL6uwnRxsn8aSytR4PNtjy/NYvXZ89ypqZHqt8Z5OCrOomPcP7XE19+u6lPylpaUq3
         E8kaAeJrayZbyEQjxRa8qQbc+jPWH1XS3qxzg8NyfKUM9vjrQvnzTjPnuCLPORQsi28K
         miNDvAcezXvaULTzcmzrMsDEklYB+P2JJRy8HmlIKmtJg45oxVs5xcxVrVH9es90kxj4
         N3Oz04Zb/A2WWo6rlAmAB6H2uH5cR409LKf4kfLH+W2a0GTZrDjXOKzn14u9429z6azR
         qLQnwK6Cm3t/kso2UQgOgqMl7R26pXSrVcIFqRB6LtIrGwDzo0LlWlmQL+iI2ciSO4qv
         8GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4O2OSpmLUp+4cB4W8n/8YKgBIPTIe2YgXCavOkNNVs=;
        b=UR4j7EQAgmckeZZKYfqQEBAtISZOG4QAdxuaV6AAZtig+iViqVey5APFMnp804r/Uv
         rrxGAk7u5coVi6bJPzm3lx1AuLcaETUkKCv3yReLDDVyVn7ovfRMJKn1CpXka8F8dM5/
         GB8fjolZ2wGSjzifazKQNPfoJARrO4qVpk9KOjs1rD97M/QNgcJnXqdh0tXZjvj7HYz3
         Bag6f6F2Mxg/lehe3Zm1uMHzLLBouANnKRXzjAlFy8QlKUpWTxkWdpurjX89EK9RcWSA
         kZ25NQGC2EALYW9xa1DuVUZJnkc9U3+htxVLZgZjHz60Dl71fYWctnV4KpKzOO622O+j
         gQAQ==
X-Gm-Message-State: AOAM531ru4eKqguFITztSLQNVYXl0w+xdLnZRbYGEzSDw2OGCed3jFVz
        +a5Tb+OPbNGTIWHBTG+gKRdQyrmdtH9lXQ==
X-Google-Smtp-Source: ABdhPJxXmChYvNKzegGVv0ZCqX0ox9kJZys2c0lA84ejDN09JyrjYMJBCqZI1AfyWBW4C/nYaVWiyg==
X-Received: by 2002:a05:622a:1212:b0:2f1:fdbe:4b39 with SMTP id y18-20020a05622a121200b002f1fdbe4b39mr7062906qtx.115.1650384267497;
        Tue, 19 Apr 2022 09:04:27 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm232204qtd.44.2022.04.19.09.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:04:27 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v3 2/3] Update API functions usage to check error
Date:   Tue, 19 Apr 2022 12:03:45 -0400
Message-Id: <20220419160346.35633-2-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419160346.35633-1-grantseltzer@gmail.com>
References: <20220419160346.35633-1-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Grant Seltzer <grantseltzer@gmail.com>

This updates usage of the following API functions within
libbpf so their newly added error return is checked:

- bpf_program__set_expected_attach_type()
- bpf_program__set_type()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0ed1a8c9c398..7635c50a05c6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7005,9 +7005,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 			continue;
 		}
 
-		bpf_program__set_type(prog, prog->sec_def->prog_type);
-		bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
+		err = bpf_program__set_type(prog, prog->sec_def->prog_type);
+		if (err) {
+			pr_warn("prog '%s': failed to initialize: %d, could not set program type\n",
+				prog->name, err);
+			return err;
+		}
 
+		err = bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
+		if (err) {
+			pr_warn("prog '%s': failed to initialize: %d, could not set expected attach type\n",
+				prog->name, err);
+			return err;
+		}
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 		if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
@@ -8570,8 +8580,7 @@ int bpf_program__set_##NAME(struct bpf_program *prog)		\
 {								\
 	if (!prog)						\
 		return libbpf_err(-EINVAL);			\
-	bpf_program__set_type(prog, TYPE);			\
-	return 0;						\
+	return bpf_program__set_type(prog, TYPE);			\
 }								\
 								\
 bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
@@ -9678,9 +9687,17 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
 		 * bpf_object__open guessed
 		 */
 		if (attr->prog_type != BPF_PROG_TYPE_UNSPEC) {
-			bpf_program__set_type(prog, attr->prog_type);
-			bpf_program__set_expected_attach_type(prog,
+			err = bpf_program__set_type(prog, attr->prog_type);
+			if (err) {
+				pr_warn("could not set program type\n");
+				return libbpf_err(err);
+			}
+			err = bpf_program__set_expected_attach_type(prog,
 							      attach_type);
+			if (err) {
+				pr_warn("could not set expected attach type\n");
+				return libbpf_err(err);
+			}
 		}
 		if (bpf_program__type(prog) == BPF_PROG_TYPE_UNSPEC) {
 			/*
-- 
2.34.1

