Return-Path: <bpf+bounces-59965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8CAD0A3C
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363203B0515
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16B23ED75;
	Fri,  6 Jun 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IScGTyO2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5801126C17;
	Fri,  6 Jun 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252562; cv=none; b=h0JY8jkJmG+kIUYmn7GnAkdAApRuwhTVG8wrnQaqM+HN8i6lGi5DMirOULincDom+U4Mh1/SQr9C09pB6IbWbv6JalL4dqTeVHxKvBOO9ehlFoB5/xymAudez3r6Yl38+/zftfA77vSf+ao6oJ9KVhGC0O3zmpX8kVfWByb/XZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252562; c=relaxed/simple;
	bh=PPLUwSd/eNRMIKSvKnAQCmdG46voJcDMQTjXzLZDkF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVYe3L+ucSs/j3BfG2zpsdjTCpkeKbgHpjOXJMtlCiqtD9Bq7oiXpy+DOgNHWf1sdAykImEneJdtCCN77KAnOcLKVtDHKMHRhHCb74bRl1R6G7jSDCKa24BxcFpV+ofLoWDHdJTYg0XygT8HHe6Daouv8xEebEyMk7hkwy81dXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IScGTyO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BB9C4CEEF;
	Fri,  6 Jun 2025 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252562;
	bh=PPLUwSd/eNRMIKSvKnAQCmdG46voJcDMQTjXzLZDkF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IScGTyO2c3qy+ywLXcmxE/g/d/LSJuiMjQhww4zmrnLvipbjHPK3fSBxrziR0yVVy
	 uy3e+yGGNrs3e02VgGyY9+uuaEmEEmX5LpYrVVfhiEwXtQM97drj3ZyTdmrwW9123+
	 qrR7Srbm9PeoFlQn9Dbf54ajFH1uDaLAAICXsNrXN+p2XuRec3LYgaupJO8m3gB4e2
	 isSZ5WDWsxn32xnCzNtTA3fauTNdmHSr7Y8izOqDdHtVJO2763JQWSPxa9USfSlFL6
	 mf2JEcJQzrd0DNk2l6D2RLUJWeUIholo+zQXwES23qqyTEn5qcqnbIgFkhJHmHs3Hi
	 RzbqTpOL+12Dw==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH 01/12] bpf: Implement an internal helper for SHA256 hashing
Date: Sat,  7 Jun 2025 01:29:03 +0200
Message-ID: <20250606232914.317094-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces bpf_sha256, an internal helper function
that wraps the standard kernel crypto API to compute SHA256 digests of
the program insns and map content

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b25d278409b..d5ae43b36e68 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2086,6 +2086,7 @@ static inline bool map_type_contains_progs(struct bpf_map *map)
 }
 
 bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp);
+int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest);
 int bpf_prog_calc_tag(struct bpf_prog *fp);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e571688421..607d5322ef94 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -17,6 +17,7 @@
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
+#include <crypto/hash.h>
 #include <uapi/linux/btf.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
@@ -287,6 +288,44 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	vfree(fp);
 }
 
+int bpf_sha256(u8 *data, size_t data_size, u8 *output_digest)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash_desc;
+	size_t desc_size;
+	int ret = 0;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*shash_desc);
+	shash_desc = kmalloc(desc_size, GFP_KERNEL);
+	if (!shash_desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+
+	shash_desc->tfm = tfm;
+	ret = crypto_shash_init(shash_desc);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_update(shash_desc, data, data_size);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_final(shash_desc, output_digest);
+	if (ret)
+		goto out_free_desc;
+
+out_free_desc:
+	kfree(shash_desc);
+	crypto_free_shash(tfm);
+	return ret;
+}
+
 int bpf_prog_calc_tag(struct bpf_prog *fp)
 {
 	const u32 bits_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
-- 
2.43.0


