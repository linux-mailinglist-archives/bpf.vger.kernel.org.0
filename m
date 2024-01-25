Return-Path: <bpf+bounces-20345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AE83CDDC
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392B91F26257
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710C1386C1;
	Thu, 25 Jan 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdGYUUMT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851ED135A5E
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216122; cv=none; b=LO/J4OULIU4vxicMqmkoyMTwNFjMSeqhKnYl+I+tRb9AJgz7ZiPuhN+LZv4itrQO/NU1ZKK/N+QK3YzHaDlduEMY33yAcNjws1onD7fJxdl1SP2eReTvwLjYZmCNf30rMe8biykC5o1A6lSpk7dh7h3z/GVtp0kcZ60rBNGewn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216122; c=relaxed/simple;
	bh=NwSKEFQQlMnf24FOnRqtNM2rjHZ1bDND+UdLceTkfdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWC1vu/1gcSRd8LVmgNbLQ7CsIIyPRjw6cMXOLDyhxLyWH7s/QBCDFyUhTLil4cSxr15ZfaRvoX6Wvnk7SS9dBgjHo6g7sVRATjs9exz0p4NVV+Z3cDs4fmZCJ0c43m9Tc0qfucEB1UicUf5ccm34osfwQW7Ay1rg9anuadnP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdGYUUMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C46C433F1;
	Thu, 25 Jan 2024 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216122;
	bh=NwSKEFQQlMnf24FOnRqtNM2rjHZ1bDND+UdLceTkfdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdGYUUMTTgIz/7VOtLybwRpBvJiPy++Wzo9Kdmtf4sSdnKWid5gKMtJ6laoZ1weas
	 QkD31bwXqt+pvhfhveh4oj4NWZfqh6Hf5DR3l2qFYCi+QwCKKADDoD+NXDsV5ZX83i
	 p3cisLSa2NBSf1FurTp15M6WmCbmPIZ1wLgDW9UTGyNI+9YdfUzF64GHdw+WzdjIhw
	 blqx/qIcikNYDeeZdYzI2GIUd4TpxktjiHqXijqNjyh9BehuwTWUZbgpBvlricV+un
	 RyZNXD+b2o/DLdAWsqz+RhL4i8SIzfwbdyKeVbfbsnE59vyU8lG6A7FsUmddwAX7oU
	 A6lgKgtFw3KzQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/7] bpf: move arg:ctx type enforcement check inside the main logic loop
Date: Thu, 25 Jan 2024 12:55:06 -0800
Message-Id: <20240125205510.3642094-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that bpf and bpf-next trees converged and we don't run the risk of
merge conflicts, move btf_validate_prog_ctx_type() into its most logical
place inside the main logic loop.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index edef96ceffa3..9ec08cfb2967 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7112,6 +7112,10 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
 			}
+			if ((tags & ARG_TAG_CTX) &&
+			    btf_validate_prog_ctx_type(log, btf, t, i, prog_type,
+						       prog->expected_attach_type))
+				return -EINVAL;
 			sub->args[i].arg_type = ARG_PTR_TO_CTX;
 			continue;
 		}
@@ -7156,23 +7160,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < nargs; i++) {
-		const char *tag;
-
-		if (sub->args[i].arg_type != ARG_PTR_TO_CTX)
-			continue;
-
-		/* check if arg has "arg:ctx" tag */
-		t = btf_type_by_id(btf, args[i].type);
-		tag = btf_find_decl_tag_value(btf, fn_t, i, "arg:");
-		if (IS_ERR_OR_NULL(tag) || strcmp(tag, "ctx") != 0)
-			continue;
-
-		if (btf_validate_prog_ctx_type(log, btf, t, i, prog_type,
-					       prog->expected_attach_type))
-			return -EINVAL;
-	}
-
 	sub->arg_cnt = nargs;
 	sub->args_cached = true;
 
-- 
2.34.1


