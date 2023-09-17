Return-Path: <bpf+bounces-10227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99D7A3649
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E961C20D6E
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B365381;
	Sun, 17 Sep 2023 15:39:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805964C6A
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 15:39:31 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA10199
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 08:38:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c4586b12feso4063875ad.2
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694965138; x=1695569938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1x1xZWr+Te0ZEK62vCuwQXv37jCmU67EXdbbtAC+jw=;
        b=KBObSoDWSwfCAm0z24lFRShT+4ZJRsaWf2tP/KIA3bzXkdM1eAbWkFcrrBdrTfvI/s
         pRcKEGdanGd2WSNPb+Z59qWpxJgDne94utyQQmPJafy4+b6wwSiwz1CXGZthJoHkgBSu
         xICHeQZFvSf2htp4rxYlCQv0w7mjQF0pB8wmGSzBToykI9FnsVSu1bR4kRgSCpXHcL6+
         ZSa2zXWjxINPxUS7vcjhisptOQZEaBYUTYkpB0GqI4+9H2FEQGETE21m15Ve0r9VhE+Q
         K8tv/v+yJcXrpoeAa8jpgKInUQ30CoWrKVxhCcwIb/mJabjqnMRCdMeRDhVDq0SLD3pO
         CF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694965138; x=1695569938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1x1xZWr+Te0ZEK62vCuwQXv37jCmU67EXdbbtAC+jw=;
        b=xTvd7uJRSGGAUdWlTwQE3ZKaRPznw2TKb3csCaN5lwlrD46flI4hL9mi88JbfzWbfC
         voq4qVhUKhVFd789FbOKfJPRy3/5yh1u6lHzsKy32VVZqAFybexuvTrfxoGaOfdBKS+f
         /d+eNOmGykLwxEX+wNYen6yYQ1C6WO1UY17WnMDaxzPzalIF1149UtWmsnobps3FKwTP
         5mkIyFyOFLslnkNqxzEenkNg3C0VLiu7BxQgPtCh22cicAWgcyRKWNA+jBPaSROLvrd1
         LnUy5tCtTw/K5GUAjunK2ahoEU5mjzz71WEzrNcbpb/DwzdoBvyM/9NTQwp4iJ0iriwK
         ujlA==
X-Gm-Message-State: AOJu0YxVhhGy4bpenme/FulSKyClSLOlA4RylzFV/BfDCgm3r956N1Xo
	7xm8H/SVZMM36K9Uzjs0SmszJJ7hKTk=
X-Google-Smtp-Source: AGHT+IGlzhTvbgyo4CoF7P7gr8u7mio7E8LI6S9++I6jdaVttiQxVKf0rfVmMr5rORmZEwVPK75sEQ==
X-Received: by 2002:a17:902:d70a:b0:1bd:b8c0:b57e with SMTP id w10-20020a170902d70a00b001bdb8c0b57emr5196849ply.40.1694965137881;
        Sun, 17 Sep 2023 08:38:57 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b001b89045ff03sm6721645pld.233.2023.09.17.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:38:57 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	toke@redhat.com,
	lkp@intel.com,
	dan.carpenter@linaro.org,
	jolsa@kernel.org,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v2] bpf: Fix tr dereferencing
Date: Sun, 17 Sep 2023 23:38:46 +0800
Message-ID: <20230917153846.88732-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.

When CONFIG_BPF_JIT is turned off, 'bpf_trampoline_get()' returns NULL,
which is same as the cases when CONFIG_BPF_JIT is turned on.

v1->v2:
 * Comments from Alexei:
   * Return NULL in that case.

Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 024e8b28c34b8..49f8b691496c4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1307,7 +1307,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
 							struct bpf_attach_target_info *tgt_info)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
 #define DEFINE_BPF_DISPATCHER(name)
-- 
2.41.0


