Return-Path: <bpf+bounces-22357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAC985CD66
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9761C22CD1
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C853AC;
	Wed, 21 Feb 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJxFJd5n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DF5684
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478627; cv=none; b=I0sHGOD7ng2btY7AQkhDUPHLQIbtMUsfUPrHVwA0htJzE3PyGFgCwTyB/XhaZmGuZsncRJb+m9qQ8YXo4hgo4PGj7et/EyQspP1tA0ui/BhQffrS9bPGCQVYCtfC+Xzaa0HnYYr58giNcRVELintUhmLwI8FZoLG8kJrFuudLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478627; c=relaxed/simple;
	bh=XxyBx5VwFWqnv4jib9/VNRcbgnP0Uj3thPHnnZ7MGd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3n39DHgeng2+UtIthrNAhtFh+VXq/2szuDhMYwP5Ikp7v6F7cDChNaIlYIyR3GKKmDoUMT4ubAV/2L0FiL1+C30Fu7WaAft+FtA3lj8ILWScEy6ytdqqYUzgklbcTcPvp0Fm0ws7aLgi5df//ue8rTGDzpPBaZU0F9HMJiP0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJxFJd5n; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607d8506099so59700667b3.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478624; x=1709083424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQoqmUR5lihQSWPqil2BNYOwKpcS7L64zovRpaQOkag=;
        b=mJxFJd5npgu16n2ohyeEiTUhMuEQt/zj58hvcCBUTD3v/LYHbKvXZ83uWWUkKvUpf8
         E5qHIsATUjxF0AgK8tQbA6jig33YZyBlkCxUG1zUZtx0gUwwCnTUDfINQkWXSTSyvDYO
         eGWikFy/odNQIZSrnJuVVKWSdsMCUsDpPoTiAjfJIVPRNf6qr7AHBWYaz8lSyzoGUmoU
         mraWaNTMNGhM2t/8CJvwHL/ZrhPFBCnzU5lL87/mYAs0TZplBHMIR1/c4ID7o6/YYWSi
         xDDkVMzA+qwArqiKLmhjtVFZuDgLKSNggMJ3E4ub8l6Mycskt+CO9YpJecLGrutjbhtA
         K3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478624; x=1709083424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQoqmUR5lihQSWPqil2BNYOwKpcS7L64zovRpaQOkag=;
        b=oMnlSXgtgbyc/yxhv/UEMjE1PxOtZCjzbSSOT+qgLtuEbT2bZldwINyTikUtvvJxjJ
         KQmOyTzLGwPvAb6Wo/hypeTUM+hJK66Z3Rh0M1VKNt6NFBiE7JbdGYSpYjbX/eFydG83
         0bULvO40/Bk39zaZ5gs0RY2LSkkARaoeIJUa2pxBfT5LHMZr1tBzxK4HioRbU+ZQwWCD
         7EsbqdYMz2XfoYL+nDwhRUMFH9cIhsp4JGTK8UH5zN2gqXnPgiklhk1WZqLXxQM3HZKr
         DyqHKFbEW/W+zWqGBvioZVs4bK0RGA25F/Zu8vW8n7kDeerQ4H1cfc73Uw7p8iSFZOmr
         cPoA==
X-Gm-Message-State: AOJu0YziC1KOBYqhBFw3n5XZ1ViBWoPaZha9gS6mdLKPkJ6U6hOH93uL
	VgKiMmm7tJDpFua/HA5p1p0puRw47/cxyMdP+M2/tiRD0NE17UXB9M6n+GRW
X-Google-Smtp-Source: AGHT+IENKjQx8fkr9A4SJtojsITDvDbzgcw6743mPmTnnTZSr7sNwmelF7rnqAw74DUvKlE+E7r58w==
X-Received: by 2002:a81:4317:0:b0:608:7af2:f5f5 with SMTP id q23-20020a814317000000b006087af2f5f5mr910378ywa.50.1708478624505;
        Tue, 20 Feb 2024 17:23:44 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:44 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 1/5] libbpf: expose resolve_func_ptr() through libbpf_internal.h.
Date: Tue, 20 Feb 2024 17:23:25 -0800
Message-Id: <20240221012329.1387275-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221012329.1387275-1-thinker.li@gmail.com>
References: <20240221012329.1387275-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

bpftool is going to reuse this helper function to support shadow types of
struct_ops maps.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..ef8fd20f33ca 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 	return t;
 }
 
-static const struct btf_type *
+const struct btf_type *
 resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
 {
 	const struct btf_type *t;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..aec6d57fe5d1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,7 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1


