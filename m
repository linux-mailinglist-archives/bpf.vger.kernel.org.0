Return-Path: <bpf+bounces-72328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D5C0E302
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D57C334DFB4
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6185309DC0;
	Mon, 27 Oct 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEe77FDh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA23090DE
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573285; cv=none; b=LGzmThl+z+23tRbZBvz1xv7URbZFd+N7sMENICTGpDlg0W2tAGk5mq/Di6Ot2Pa1bFEc2tHaH9Nb0POpt8SqPnUIZiTvFFJU94BIoD8HsFbnZLjIdRVsAlI5yOmCVVusU70Xp1O/o8TdslmdQZxAsn0wvxyjt2Y4CbLcPb3TJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573285; c=relaxed/simple;
	bh=Cjh5/g2g/jA0t8pIW0Qr1oO+2rUFIay2nimYcNijtxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyHmaw4YlMjMde8Tnk2ukZtb3TN1+MMeTZU09At4UcUWkfcppNNa8P5zPAqJtIfkVbTypEssBzs+SatCKuIzek1IJr3E4NmsvK5b0lv6xdrwZBBZckOfaoguD8pQAg3O8m7tPfGQXukaWCWwbs+ur/Hxq1rinylKqPBVHcI5zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEe77FDh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33292adb180so4763356a91.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761573283; x=1762178083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYRuzhTmcuAouHjw8Rk9AXVRkzW/8jCaMjKPsnybwR4=;
        b=UEe77FDhBefI1TZyhPC+L7bujvwCmN9JFl5N/ynlvMW9Yta2uM1ParX99BgOL0/diF
         Pl9Zhjh/awViZmb01clgiupNu14ok8fjpri6B+shjdTsyvLi0T1aRrjvlgP5JfeqbVKZ
         w5wLTQTmVJDlVnOhJ49U3R9GkiXzmhz3t5vckp2ij/hezQNgftHwz6CwoWfFKxM/tzRa
         Hj2bmeCv7jLfviSk9y3Yi8fOlBDQ9mePfc3r0a5dCOjViRjMbDJ9Y09bRchkMLcarHkW
         5B9YD1aNRckoY9GlY41uRuTvBWkWZkrc8ZiO5L2OoeBcDe62qMhnpGj4ykw/3f0gg8zY
         CLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573283; x=1762178083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYRuzhTmcuAouHjw8Rk9AXVRkzW/8jCaMjKPsnybwR4=;
        b=vZ8suTVI+z8YN5YwBr3cI4vdqzKsdscTqW3fyPc/0c1j1zxp+c3Kdz0UEtbg1Npj8f
         a8SJG+5DCpUH3xD/8q3arN7h6M+uOYkKAKYQeplCzCnqPeBvSdL9EemXieKwe01xIzzK
         rBBUDzOT6xiKPNX1H1z8sPxo7vpmCbtq9SaVmRg+Fj0FdL4SwjBK03a75Q0qoB6ra7AT
         DgYRh6aIBPc22PS5GbOzxK1U5dOKSaTLSLBuSzDTHx3kSu6q70QJbbu4ScAvb+TxsSxm
         vaiWSVhsXisp/PjeaQ/5eDIMyvzj0hCXg0rst/nfv4IU2AGX6IASd4U2/c2gWad/xGdD
         qhaA==
X-Forwarded-Encrypted: i=1; AJvYcCWXmCUCsLDqlkjgQsvtqWttE7ll9r+bnjUHWTFfgp07mnLrY0bNt9PyvmKy6fLbTTnVUuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWygBSKT32smsF8/73BoOnw8tlLBmlrWaj/+eCZtZn14aVTS/
	spBZzNgig55qc0n4e4Pt1nnUmDIsj1FsxvqtrEa0YDRyLF9tH3YF6OkJ
X-Gm-Gg: ASbGncsKWAWxvcBm8D/mZU+KQz6LJoVJWCSJ7NvuAqg+amG8Fvuu0TFQRtSqbuEbPje
	fo+aqqA6+GiaMIt+iYVifftmvYMJCPMzYezLDsSgTfjUdU3QFC+faj3wJq1fY+zOyF5z3E+Ww0A
	9SEvxt0Pp7iVha1Os+RtI6M8jEFwb1XUHf9kNwncpZ5bf7rNSk34RwAPDLCXOdFpE/hHqfk8zgr
	7iOcqWJ5alXzb1VCZxA2V6nC3SqfrJJxu6yKM9JkgiuNp9so0BGegdpLhyuL7eoOANwNS6zWQLR
	h4giM6IutBlCkrTQtKObyDKi7W+HCVCkGd9cVdUWWT/44+TUrY2QsKCI2nOJQ63SuyMzGJRxLQ9
	xlL9SgNxJfAGRWEztRRoNqe8s315NT7kSsOF8sIK7OC4jrl3olN1IQX2aCG3q84VGTa2xXLTriG
	sRaFiAPqXifEoTy4/9
X-Google-Smtp-Source: AGHT+IHwNYL6A4DZns7ec+5bESV0e3nM9DzapwGirzgHfVhHI6fBerJH30YECQ5BiM9K/Yykza1d3g==
X-Received: by 2002:a17:90b:5908:b0:33f:ee05:56e7 with SMTP id 98e67ed59e1d1-33fee0557f7mr10189589a91.16.1761573282951;
        Mon, 27 Oct 2025 06:54:42 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm8574361a91.4.2025.10.27.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:54:41 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting verification and binary search
Date: Mon, 27 Oct 2025 21:54:23 +0800
Message-Id: <20251027135423.3098490-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027135423.3098490-1-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit implemented BTF sorting verification and binary
search algorithm in libbpf. This patch enables this functionality in
the kernel.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v2->v3:
- Include btf_sort.c directly in btf.c to reduce function call overhead
---
 kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..df258815a6ca 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -33,6 +33,7 @@
 #include <net/sock.h>
 #include <net/xdp.h>
 #include "../tools/lib/bpf/relo_core.h"
+#include "../tools/lib/bpf/btf_sort.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
  * the data types of BPF program/map.  Hence, it basically focus
@@ -259,6 +260,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* All named types in the sorted BTF instance */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -527,6 +529,11 @@ static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 	       btf_type_is_var(t) || btf_type_is_typedef(t);
 }
 
+static u32 btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_is_vmlinux(const struct btf *btf)
 {
 	return btf->kernel_btf && !btf->base_btf;
@@ -546,22 +553,7 @@ u32 btf_nr_types(const struct btf *btf)
 
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
-	const struct btf_type *t;
-	const char *tname;
-	u32 i, total;
-
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
-
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
-	}
-
-	return -ENOENT;
+	return _btf_find_by_name_kind(btf, 1, name, kind);
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -6230,6 +6222,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf, 1);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6362,6 +6355,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
+	btf_check_sorted(btf, btf_nr_types(base_btf));
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
@@ -9577,3 +9571,11 @@ bool btf_param_match_suffix(const struct btf *btf,
 	param_name += len - suffix_len;
 	return !strncmp(param_name, suffix, suffix_len);
 }
+
+/*
+ * btf_sort.c is included directly to avoid function call overhead
+ * when accessing BTF private data, as this file is shared between
+ * libbpf and kernel and may be called frequently (especially when
+ * funcgraph-args or func-args tracing options are enabled).
+ */
+#include "../../tools/lib/bpf/btf_sort.c"
-- 
2.34.1


