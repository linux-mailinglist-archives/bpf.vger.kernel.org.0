Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF2508CEB
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbiDTQPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 12:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiDTQPc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 12:15:32 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490091AF32
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id y19so1665616qvk.5
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rcz5MZpojZ6vlq7WhobGUsKiSv0/Ah0cbFHiZac70I=;
        b=XTmQ1pb4Mr2bOTKCi9IBQc+aqNh7Jdjsi2T7zN8U0XU2hh8lh2naTpEdCbn79ndsnD
         ahTxRpzrowHf/F4/JhBQEiH/NiIU1Sh87/Z27M+gdVFBvE0qxbAK18TLtSURfT2uX7Xe
         af2tF9WuAiPW42cM3CDBw6JajwYV8mKB/Njn54bK+BxQy7Bl8Xpmn1Gu6jXTGdM+kMAQ
         1jr+HeV236MdQWj/AhxWpitkUREdlQhDVD+FbLRdWY3vd+oWevwp5bHloXWbBmmKJ8Oa
         V3wLkMjloFVwyTdjvcjE3yKevGs9pvKYc6QWhZesuPq96+cAy9TTEjAJXMlkhs4P6RiD
         5m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rcz5MZpojZ6vlq7WhobGUsKiSv0/Ah0cbFHiZac70I=;
        b=JTXhX0CHiwyqmAp6JqdVTLT6+NgRi8vVeovqoaM6nJrEMVXcnZDGHEsKb8C6q2puWd
         KSwUSt7f8/SVorFjthsdXWemiCqCy0kZJrpVahL78+A3NkO0HDIBfmuGXo4LnYtSZX+S
         FIscbeOHn8qyARZ1ia1vBT5ZgSO5bUx4hg4N6mZVVK3s46UnAx+04kA+cMLcmTYGZBZQ
         4veLLKsLG/RWoms/s81CPPp5p3u1F7uVtBLI/EZDBEUj7CfIc+S42j+XEVfZKnnHL6l/
         Ara03MdmamJHoDUspY+VmT+T1scEyWElTfI2RfzAE6nGct+DEmX3IV39osw7xaIiIe2I
         JlqA==
X-Gm-Message-State: AOAM532//4qJkpQ+LZA6zmP0ld9A/zBu5i4ST+EHNf3ODhrAYWDuhrQz
        JJXaaYMBeEU0klhEkDO4tgllibpgh+/tOg==
X-Google-Smtp-Source: ABdhPJzWLNGitSpMEkmJNQt6iLhG2p3lTkr2JdA2dG3aUKgb4lBf/fqbLOqGaHDtSBNiaCFzNHrnUQ==
X-Received: by 2002:ad4:4ea5:0:b0:44b:b26f:634b with SMTP id ed5-20020ad44ea5000000b0044bb26f634bmr1367228qvb.69.1650471164224;
        Wed, 20 Apr 2022 09:12:44 -0700 (PDT)
Received: from localhost.localdomain (pool-96-250-109-131.nycmny.fios.verizon.net. [96.250.109.131])
        by smtp.gmail.com with ESMTPSA id f28-20020a05620a20dc00b0069d98e6bff9sm1694090qka.32.2022.04.20.09.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:12:43 -0700 (PDT)
From:   grantseltzer <grantseltzer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, grantseltzer@gmail.com, song@kernel.org
Subject: [PATCH bpf-next v4 2/3] Update API functions usage to check error
Date:   Wed, 20 Apr 2022 12:12:25 -0400
Message-Id: <20220420161226.86803-2-grantseltzer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420161226.86803-1-grantseltzer@gmail.com>
References: <20220420161226.86803-1-grantseltzer@gmail.com>
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

From: Grant Seltzer <grantseltzer@gmail.com>

This updates usage of the following API functions within
libbpf so their newly added error return is checked:

- bpf_program__set_expected_attach_type()
- bpf_program__set_type()

Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 707cb973b09c..6487b1ccf7c3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7005,8 +7005,8 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 			continue;
 		}
 
-		bpf_program__set_type(prog, prog->sec_def->prog_type);
-		bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
+		prog->type = prog->sec_def->prog_type;
+		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
@@ -8571,8 +8571,7 @@ int bpf_program__set_##NAME(struct bpf_program *prog)		\
 {								\
 	if (!prog)						\
 		return libbpf_err(-EINVAL);			\
-	bpf_program__set_type(prog, TYPE);			\
-	return 0;						\
+	return bpf_program__set_type(prog, TYPE);			\
 }								\
 								\
 bool bpf_program__is_##NAME(const struct bpf_program *prog)	\
@@ -9679,9 +9678,8 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
 		 * bpf_object__open guessed
 		 */
 		if (attr->prog_type != BPF_PROG_TYPE_UNSPEC) {
-			bpf_program__set_type(prog, attr->prog_type);
-			bpf_program__set_expected_attach_type(prog,
-							      attach_type);
+			prog->type = attr->prog_type;
+			prog->expected_attach_type = attach_type;
 		}
 		if (bpf_program__type(prog) == BPF_PROG_TYPE_UNSPEC) {
 			/*
-- 
2.34.1

