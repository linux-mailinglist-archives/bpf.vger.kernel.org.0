Return-Path: <bpf+bounces-53392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D058BA50BEB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D1818954DD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4A255226;
	Wed,  5 Mar 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1ZCObl8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0225254B0F
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204198; cv=none; b=SIi869O2FPWYxxAgANky+fdynALez4vTYFtbNxdDOWLJuHGOM7cEp8HCd2mAVBA1y+1/tSALJL8K+C57BqeW0p89bEYI3prhA3IL8BbOnRmQCexTarR4eOqagkt1wmLi/ryz7prDW7EGt0ugtBH0LyTJD7gwQZYmrTBTevCcqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204198; c=relaxed/simple;
	bh=pAH6DJM5WKTVlhQa1dSW67kEovIMWL4V2bwazD63tZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BACqs5Z68JJA88LG+RnoeU2DK0F2o/cJCxC5pzFsVTZy8NSesE4zh5CSVTAdnU0gRD2ZrctrPf0OMG9+DQebTRDofelMLgvKBs3qt6epSjgIevFBD8fQDURmRYVms8P7vDv5WEnLmy/4if9AIkWNfay+gID6BxDkj6BKfAVjzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1ZCObl8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf628d653eso666350466b.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204195; x=1741808995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgEEAiOqgkfh9oPgNuZeeRzfgmXM/drUMjby4IjFxno=;
        b=i1ZCObl8F2v475/oIheWWOoKek5KfcbmBFtDpZz0qZbfEpFgxXgJJsbnZd6ad/DLX5
         SpSswl4XxTd/XZWkHtpzSTwiRsMHjLfBejwO7OA/9/GSKNPdEqxH7XMdThEozfy8aEA+
         8D9CaSo5Bf4a+OY5if6gqa+7tD3xbCy9QeOQapOIo3uTeOcAcZIcR++0OQPt6TkcGAV7
         IWhgjuVakaUEvAR0I8uOv/3FApOOw9wEuV3hGFOGf6vJlNITJX6+TdiBtwbbCdm30N7i
         FhRoiuj8tTIS9B/THMjs27N2Hlm6WhHMA8tym0nvrLoz6guNK+0OHEwomuYsJNMt0J7/
         IyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204195; x=1741808995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgEEAiOqgkfh9oPgNuZeeRzfgmXM/drUMjby4IjFxno=;
        b=ZQkllydl71Xz9ANyvOXJFT3WoI/WkcI6fjVtrB7ab5tlOE7Frkcz5bHJZGDZKSlfiX
         jhCLKaasN0EN5qoCTcxzIQN3r3Q4XlAJZAy7hANWN+7m3RRHVWOiA2d+NGenQZ4n4LV2
         FwFLR7xMgSdxcRqZZfQiUXu3r3i6yL3eEDBq0KTYyyPmIGRRy/Apm+YnhmjJYxcb/BkK
         acZAvtiBwbYaqmPdv+guvi8gAe7ptVwuATRP+L4NKaKhNrQ+VmIgxsCTQQBm5WXFID5h
         hiIh0g0lUqojBHTawESnWaanbcWZy/JrAnvAtJ2qG/kwNOAN3sqAOHqnv+E8BojSsiUR
         kRpg==
X-Gm-Message-State: AOJu0YzTfy0Ic0V7dICNEo4h9k723LFVVi0BQzowmR+Ney5jwrkLL+eC
	KHQul9/hj2ozdlGU/gAexjJ0qARzO9g2w8RMAkIRkDP/FSt6Vv+0JY0utA==
X-Gm-Gg: ASbGncuzSSzhhxPcYP9XOc2GT6633MW9ySCUESJdImBSE42tXfyUwAv2gbAHtm+FLY2
	Xfx1kvR0yafrygHu/S63RvoyLcR7thLlTAB0pRdzSaRwROA0JURAlLqvtcu8Xm2gk9XUp/dBy8J
	2ATGjO4wPoJI5s/HIqRN3CAF2eLCs5Sb7vss61ovAWe2BcL1LcCbqICfgM7eepPDQZAmTjvZi7o
	6Dq4zbDI5hiKs7nM/i5HIywvzWxw9/SCrgjodXom87vcQHeuKu5zcKzjLrfjj/CYqwl9EwlRFUx
	D0YhfHJLuiFBOebBrV7BCxEvi7dBbtSy/1GW06yXaLBGzAlGwDhT1FKatAo=
X-Google-Smtp-Source: AGHT+IEJUkKONnP97TRth4Nkc3fDYXNKc4U0+zsx1UuzG1+KjUNx83UaIZpVBprO9kU2vWZQn35zcQ==
X-Received: by 2002:a17:907:c22:b0:abf:6744:5e96 with SMTP id a640c23a62f3a-ac20d84a962mr412222266b.8.1741204194979;
        Wed, 05 Mar 2025 11:49:54 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:4624])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1daea1cd2sm481584066b.181.2025.03.05.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:49:54 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Wed,  5 Mar 2025 19:49:41 +0000
Message-ID: <20250305194942.123191-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
References: <20250305194942.123191-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Pass BPF token from bpf_program__set_attach_target to
BPF_BTF_GET_FD_BY_ID bpf command.
When freplace program attaches to target program, it needs to look up
for BTF of the target, this may require BPF token, if, for example,
running from user namespace.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/bpf.c             |  3 ++-
 tools/lib/bpf/bpf.h             |  4 +++-
 tools/lib/bpf/btf.c             | 14 ++++++++++++--
 tools/lib/bpf/libbpf.c          | 10 +++++-----
 tools/lib/bpf/libbpf_internal.h |  1 +
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 359f73ead613..783274172e56 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
 int bpf_btf_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
+	const size_t attr_sz = offsetofend(union bpf_attr, token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
 	memset(&attr, 0, attr_sz);
 	attr.btf_id = id;
 	attr.open_flags = OPTS_GET(opts, open_flags, 0);
+	attr.token_fd = OPTS_GET(opts, token_fd, 0);
 
 	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 435da95d2058..544215d7137c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -487,9 +487,11 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
 struct bpf_get_fd_by_id_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 open_flags; /* permissions requested for the operation on fd */
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_get_fd_by_id_opts__last_field open_flags
+
+#define bpf_get_fd_by_id_opts__last_field token_fd
 
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..466336f16134 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1619,12 +1619,17 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	return btf;
 }
 
-struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd)
 {
 	struct btf *btf;
 	int btf_fd;
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
+
+	opts.token_fd = token_fd;
+	if (token_fd)
+		opts.open_flags |= BPF_F_TOKEN_FD;
 
-	btf_fd = bpf_btf_get_fd_by_id(id);
+	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
 	if (btf_fd < 0)
 		return libbpf_err_ptr(-errno);
 
@@ -1634,6 +1639,11 @@ struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
 	return libbpf_ptr(btf);
 }
 
+struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+{
+	return btf_load_from_kernel(id, base_btf, 0);
+}
+
 struct btf *btf__load_from_kernel_by_id(__u32 id)
 {
 	return btf__load_from_kernel_by_id_split(id, NULL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8e32286854ef..6b85060f07b3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10024,7 +10024,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	return libbpf_err(err);
 }
 
-static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
+static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
 {
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
@@ -10044,7 +10044,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 		pr_warn("The target program doesn't have BTF\n");
 		goto out;
 	}
-	btf = btf__load_from_kernel_by_id(info.btf_id);
+	btf = btf_load_from_kernel(info.btf_id, NULL, token_fd);
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
@@ -10127,7 +10127,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 			pr_warn("prog '%s': attach program FD is not set\n", prog->name);
 			return -EINVAL;
 		}
-		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
+		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd, prog->obj->token_fd);
 		if (err < 0) {
 			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
 				prog->name, attach_prog_fd, attach_name, errstr(err));
@@ -12923,7 +12923,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	if (target_fd) {
 		LIBBPF_OPTS(bpf_link_create_opts, target_opts);
 
-		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
+		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd, prog->obj->token_fd);
 		if (btf_id < 0)
 			return libbpf_err_ptr(btf_id);
 
@@ -13744,7 +13744,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 
 	if (attach_prog_fd) {
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
-						 attach_prog_fd);
+						 attach_prog_fd, prog->obj->token_fd);
 		if (btf_id < 0)
 			return libbpf_err(btf_id);
 	} else {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index de498e2dd6b0..76669c73dcd1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -409,6 +409,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
+struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
-- 
2.48.1


