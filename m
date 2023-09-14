Return-Path: <bpf+bounces-10029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8687A0883
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94B9281F01
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C421111;
	Thu, 14 Sep 2023 14:51:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5B28E11
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:51:38 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F82F9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 07:51:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdf4752c3cso8152505ad.2
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694703097; x=1695307897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw8Z5ZsdHe0R5PJlHhouptZdCrrEBGXwCzeH0ePBZGk=;
        b=CNNSXYimy5muI6wIKOWBmOETgxs6bYs6mliiOhaE5oIBaBZFGiLID4fdCaGgNtK4+y
         94u5z+Q+VmJ4CH3PXzet5X4yKNpY/JaZsVomh5kY2mkxJJx/qZAaIBGtjOC4YohbJ1vR
         6/w20JGHY1Q/DlCCv8tr8zYiYrTfB3UCmDY3jeC47OOkulW5HA14xcHU8oq4BAr9bRGX
         txzXjq+Vb5+gOZJPac/0WzeHkd8LZKhp/QYJFaHGZPl7B/Ky/Bmso7sERPCM3WPtdXAp
         VwBmQPwHkcJjEKB5N9vMuCdaMKoIvnx/neHFsSt9LnOmTE7IudtCsXGotjmPNY14WtlH
         HmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694703097; x=1695307897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw8Z5ZsdHe0R5PJlHhouptZdCrrEBGXwCzeH0ePBZGk=;
        b=DvZ1OW++daHN9XxzP/rG0/oJalZhDgmXrbyN7cr52cK+CfyH0AI43kco+CmA4m0VGv
         djyPVeQXmD3JT6qqBGRcNX0gqw5YDSGkiksAouqYzqrA7UvZ8Tx/mUAva01CJpRwj5fm
         kjfhgXP/ykSTKxNMCoi8PfbWdoz8OfATNATKyNXzSpZBjcsFSnENN4yr7KnzA913qimh
         0CLaWD2YeqvqA29INjRyTUjZtidyXq23ARNzRGTOy29neTWHm0o3t7ikv943B1VoNDCR
         sBnOYowMZZekui5zKg6fA7/ubY4BmqO+RwBpMilqP9O8Xfzq4m2GJpGUZT+GJMswWzl/
         SRWw==
X-Gm-Message-State: AOJu0YyG6nlDzKPf1Ilsg/ec6gGRTRBh8h7Wh+YJ3GtmMYQgt7WX9dQD
	CM2snzHBUVWnYq3S1su6cE5zwGuLYBc=
X-Google-Smtp-Source: AGHT+IFhO0m+i+weW3f4E6E9DviZHLNCgO8F9XrA30JONeqvKwyGJSIoAOuAuDYXmCP/+s2Unnwveg==
X-Received: by 2002:a17:902:bd46:b0:1bc:844:5831 with SMTP id b6-20020a170902bd4600b001bc08445831mr5348904plx.57.1694703096955;
        Thu, 14 Sep 2023 07:51:36 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001b8b26fa6c1sm1687565plg.115.2023.09.14.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:51:36 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	toke@redhat.com,
	sdf@google.com,
	lkp@intel.com,
	dan.carpenter@linaro.org,
	maciej.fijalkowski@intel.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf] bpf: Fix tr dereferencing
Date: Thu, 14 Sep 2023 22:51:26 +0800
Message-ID: <20230914145126.40202-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.

Like 'bpf_trampoline_get_progs()', return 'ERR_PTR()' and then check by
'IS_ERR()'. As a result, when CONFIG_BPF_JIT is turned off, it's able to
handle the case that 'bpf_trampoline_get()' returns
'ERR_PTR(-EOPNOTSUPP)'.

Fixes: 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to multiple attach points")
Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/syscall.c    | 4 ++--
 kernel/bpf/trampoline.c | 6 +++---
 kernel/bpf/verifier.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6a692f3bea150..5748d01c99854 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3211,8 +3211,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		}
 
 		tr = bpf_trampoline_get(key, &tgt_info);
-		if (!tr) {
-			err = -ENOMEM;
+		if (IS_ERR(tr)) {
+			err = PTR_ERR(tr);
 			goto out_unlock;
 		}
 	} else {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e97aeda3a86b5..1952614778433 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -697,8 +697,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 
 	bpf_lsm_find_cgroup_shim(prog, &bpf_func);
 	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
-		return  -ENOMEM;
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
 
 	mutex_lock(&tr->mutex);
 
@@ -775,7 +775,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 
 	tr = bpf_trampoline_lookup(key);
 	if (!tr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	mutex_lock(&tr->mutex);
 	if (tr->func.addr)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18e673c0ac159..054063ead0e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19771,8 +19771,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
-		return -ENOMEM;
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
 
 	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
 		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;

base-commit: cbb1dbcd99b0ae74c45c4c83c6d213c12c31785c
-- 
2.41.0


