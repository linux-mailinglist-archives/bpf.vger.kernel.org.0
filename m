Return-Path: <bpf+bounces-51567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A53A36018
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86840188F87F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC36265CA1;
	Fri, 14 Feb 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqmi2/5d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D7245002;
	Fri, 14 Feb 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542644; cv=none; b=Mui140uwnqhlSrYLJZJvqCT/2DB+k7Hf/Z65o4DjlspNlmaeTIDdeZKUzWHGFbKgTdBCpMnsGyFp7CEaHwBvwn7S2uJEMZ3WNi0qgSj9at8/2b5ayCsvo1Kx5FIQmZ7v8oc9T1rwMA6GL/IZkexima1pV5zIwDRbK4cqcXEqV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542644; c=relaxed/simple;
	bh=lhrd0AQI9s3FEnz8yxPBJXpKc3rwdBVNzPcFb5HJIkc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a3UQCE6Xlf6Xl82vZnm1xLki2aP0wdf46TLEl8gfwswHpv8h9YVB/58c9O7CSKxdyrArxW/gi797aWVJty4oKe4M7+42IYEbfdrGqkR8dum/rbV36IOTAo5wxxnHuE7hhaNIxOQxu31uzEeYq2YzOf5/wlwV7wGQwHZ+dduNA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqmi2/5d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so36783065ad.3;
        Fri, 14 Feb 2025 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739542642; x=1740147442; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBaplg3g3rUu8/rRc+aYsCsq7KMcM5ySIdriDejyTSg=;
        b=Rqmi2/5d4bzI/W+6nugk5EmoMAZjgeR50zCicI7t2DjdkAqLYm94lu0THHbLxiXJOi
         IB2kU0Sy3Ix17+R3uWVM80k0ERBcDT4Ds+NlnLMCcwwTBIdy/zv1aUkuM2HFxnf35iWV
         NXXdVP7IwvHP/kclmbbjXYO0PBgDD6ptTE6yb07blZkKwdlNAQKIPt3FUZaf8liyCwvO
         LdMIM12y7WsfRa8BGUxnKhwNRfFmeqMU1okozep+1PXWdPpNBB4btVsLQn3OPSJWqzPl
         1jReXrgUfcXM65mFJHXs8MR7wjbKBOAnm/ZvAOPTi9Koy7KLhETLo/rSnKuePpAUxrIJ
         aXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542642; x=1740147442;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBaplg3g3rUu8/rRc+aYsCsq7KMcM5ySIdriDejyTSg=;
        b=pyYhGxVVE4Sa50xnOJmb7FGnGsw6Aa0G8a5LG59ureRtIg0gbLuxoAB31cSOpB4wUc
         WS6N6dj3pe/JXGaznAdEkDbiR5xKd1zlIB5J4nX5m5b37GPcZvU5Z68rk1p1hD1z3Qkm
         CMrE6uDrIfggv91S5II7ZFp8/TJXhEA+Z9haqfF4Y5d8mYXLI5ugJoTGwWPwnOqVwHu7
         iJsnA4VUlMfKArL4cdLOPAgl0L+GzsxVe0i7owKf57WrCXwEppqXAy734A1FMobPDnMc
         zTkEIUIZGz69F0Hhvoh8GddVmY5hAhCaab4g4LxunpzGbnNFhow09oQj1BtzLUHzJson
         MoSw==
X-Forwarded-Encrypted: i=1; AJvYcCVyGPFjtJTITDvwPNXIvC3qZ2GQfG1mneIp7QQ6cF11MCuFuZryCsxkxb2A0ro+GtBCnXQad3dgbG5PS+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmhzcXm2Oy4fu2oI/RjdmeoS5D2mY3PLQ4C1wxcr3gHJCSRon
	ZPl14Jp96neFVLn2aJiIK8WtQDXzHS62Pd90x4XhneyLo6TTbxef
X-Gm-Gg: ASbGncsQP/xQLiMJnr8Kv8LGlUP/6h4afKjvQleNvK1gzFJ+tluhMQfRv1fP33ryuDM
	IXliuUtMApG7d+k/isdNzBCy7aOmC6YFhPZMh4E/3glSWG7N3ZuTRI8vR8PYcvzRhesRSu3/0+/
	s4cHqyEOeKRcrdV5XJ6Hn9oVpdNsK73yIPN7T03WwJFyAs9dtcv/UqX1Ktx9SshuHn/94jWBpOn
	B/w8Y0WKtPDyuEpstF4IDOO7n0I7xZTEgMGGU1JLmfW01OXg6gT01eWfBypaUcAhytVGDTho3UR
	U+OFFgCUKjzVohzi
X-Google-Smtp-Source: AGHT+IGMeaAmAk7JHdUA61NoW5qEMxJ74S4M+agQkmVqXdZ8LK7RDRQmSCgjEa4XLBD+DPnywEPKjg==
X-Received: by 2002:a17:902:ea09:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-220f1a1b7bfmr28922575ad.19.1739542642225;
        Fri, 14 Feb 2025 06:17:22 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d051sm29241955ad.108.2025.02.14.06.17.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2025 06:17:21 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
Date: Fri, 14 Feb 2025 22:17:17 +0800
Message-Id: <20250214141717.26847-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Just wrap the direct err with libbpf_err, keep consistency
with other APIs.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..6f2f3072f5a2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9145,12 +9145,12 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 	struct bpf_gen *gen;
 
 	if (!opts)
-		return -EFAULT;
+		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	gen = calloc(sizeof(*gen), 1);
 	if (!gen)
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	gen->opts = opts;
 	gen->swapped_endian = !is_native_endianness(obj);
 	obj->gen_loader = gen;
@@ -9262,13 +9262,13 @@ int bpf_program__set_insns(struct bpf_program *prog,
 	struct bpf_insn *insns;
 
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
 	/* NULL is a valid return from reallocarray if the new count is zero */
 	if (!insns && new_insn_cnt) {
 		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	}
 	memcpy(insns, new_insns, new_insn_cnt * sizeof(*insns));
 
@@ -9379,11 +9379,11 @@ const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_siz
 int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
 {
 	if (log_size && !log_buf)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->log_size > UINT_MAX)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
 	prog->log_size = log_size;
@@ -13070,17 +13070,17 @@ int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
 	int err;
 
 	if (!bpf_map__is_struct_ops(map))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	if (map->fd < 0) {
 		pr_warn("map '%s': can't use BPF map without FD (was it created?)\n", map->name);
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	}
 
 	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
 	/* Ensure the type of a link is correct */
 	if (st_ops_link->map_fd < 0)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
 	/* It can be EBUSY if the map has been used to create or
-- 
2.43.0


