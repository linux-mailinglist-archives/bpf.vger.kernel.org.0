Return-Path: <bpf+bounces-59110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B2AC6072
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C77C165A46
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87221FF4D;
	Wed, 28 May 2025 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFFvXvF7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C821E091;
	Wed, 28 May 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404224; cv=none; b=h8uV1m0+mzvEC9t+VHBJPDdx86whRsM12l+y/cbFaAR0qi5Dp7E2oK2YYg22/cpkNO27riaVhWBtLiAFKr8JFaoOdjZ4LNuXe8/lYlwv1a5mWVRwn/HRQhsKNUcE0plFbGWl7ziomS4XTedpw4BcKT/RWThhVmq/Rbmw/xVZqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404224; c=relaxed/simple;
	bh=sJmwkTgPZfMSTWNcMK4YlEf4SczAz7/vvyliNjgTZgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNrLYQLxkHC1jvUsXDsTcqdmaUpn5JA0JuJWKP+6L/SFqXLKFODqHotAqzoaydeKLgVT/Wz6PUP5bJJz1j4el9VadvFhGNyeqbS/ZRne/O2C+txB3heckho2GBvlcs4tqLGiP7CX8tn1ah02PVWDaBvrcmQFABV1HuYGRJOllB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFFvXvF7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-23035b3edf1so30877885ad.3;
        Tue, 27 May 2025 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404222; x=1749009022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4ULvkeWo6R+wt2v8eLeuZgd3DEWdnv8cuyh2RcE8bQ=;
        b=FFFvXvF7l+TwmHzDBLpn4q1IpTT3b+BeLoKzNBVVoGvqVD+6v/ZZM/4M9bhDwToplN
         4ErdwlmNBpo6bHghquk8EOJTvVptpT+SoPZ0PkcqMXJ+zbOWdWPMVJjWSy0bGE/yyMvB
         rDdBXWHk0CrXPQOa5fs3q9CfZl6giSW3uY8XFyMWQnIjHCR1AzoSNWegMJAExxbSPiFL
         LJWKBpgYLcbtbIchTblm4wHU7FcB/AgSPVjBJVmx3sPrrI1nJnQFA28AIMO+scRKCcBU
         oRElkvcA7s+czj5MhbZbki6O8aLQ1Nub5w71jkWmvxU7aEQ36VKGTLiot/CVLm5uoumd
         ftGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404222; x=1749009022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4ULvkeWo6R+wt2v8eLeuZgd3DEWdnv8cuyh2RcE8bQ=;
        b=QD1udeNPlp2OOYG9MijunMPw6Yvs4e2yvyzbl9EaMdvO0IqU01zpc5o99Xgh3lnB2H
         YHy/FyDFqnSrJ4yg6+PwSKTHsVquR/Kia3ywsZGxc4LoAVpaC7x3hFUXR97DX+JE32j0
         yvhCyuoZME+C7cbHiW8YOAMVbp01tedXfsR5UM2k801YNme369rZt9HUxt1jcu7VRrTY
         B3E9GS6H7ReTrwkQ9v49tTYYx4o5uBsQlDPhsMk2bDOBKSKqS0vBVJvFY6EDV+CVigc+
         pyRPp8PgRWjS7vQkwef2amO7mhm/YS/TWjCWSXN+csoCGDjN9mj6OXYt593P23UuRzmY
         sNdA==
X-Forwarded-Encrypted: i=1; AJvYcCVrx0GTZftIaWiT8XpAm4uGdlHyBn4ldcEqRzvP1qCBtsZ4WUs2BuodsH5KwPDbrogc2rBUgHcAp5fpuRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrz3T0EJD1c+eP3BpOU9gErMj9qKzYauUeZcX/M1NRLyUzNdh
	yNNd6leF3hLC+8ZcJ+3Js1YpytcI7qa6AScktpFImb842ra4qeeF3E1G
X-Gm-Gg: ASbGncuj/bH1eLk7LsvC9i2Kpwde/ifVTzyOeiZ3ZMrYmQLPvVFF2aoNQTdCEbKTOA+
	mdheU1q2pgg4qyYOf3sRc46yOhrfQ1Se1aVlzBZsbcoZXDKcLBepwFvuUMhskB48/OWENybEy/O
	H/B0Z/aWynNuwYi5gPWVfN4LwLJfev1hzSK2IvDCXUzg8vJhbjnTKgFAliq+3b/JvU1wp9ShMjv
	SpMl2QQWBmffsKKcx/Bgn43FJIMRtVTuPRGJ2QZg0JyOq9Y3G4DtSb2ZzdpIMmpG0HQ0cjvlYDr
	QPpkfsx796XWktzwTgD4hWnLYHHplrwSz9py0QzqWm5D2OsaLABs9ixfpjPD6Gw3FfJi
X-Google-Smtp-Source: AGHT+IGrTl+R2r5VL+P6flkdaWz94R5YsISZycgZQK7Co5/DR4zquz85jMGX1WLjHOVrY2O7lEJ0/g==
X-Received: by 2002:a17:903:986:b0:234:c8f6:1b03 with SMTP id d9443c01a7336-234d2c4aa08mr13169505ad.47.1748404221993;
        Tue, 27 May 2025 20:50:21 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 21/25] libbpf: add skip_invalid and attach_tracing for tracing_multi
Date: Wed, 28 May 2025 11:47:08 +0800
Message-Id: <20250528034712.138701-22-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add skip_invalid and attach_tracing for tracing_multi for the
selftests.

When we try to attach all the functions in available_filter_functions with
tracing_multi, we can't tell if the target symbol can be attached
successfully, and the attaching will fail. When skip_invalid is set to
true, we will check if it can be attached in libbpf, and skip the invalid
entries.

We will skip the symbols in the following cases:

1. the btf type not exist
2. the btf type is not a function proto
3. the function args count more that 6
4. the return type is struct or union
5. any function args is struct or union

The 5th rule can be a manslaughter, but it's ok for the testings.

"attach_tracing" is used to convert a TRACING prog to TRACING_MULTI. For
example, we can set the attach type to FENTRY_MULTI before we load the
skel. And we can attach the prog with
bpf_program__attach_trace_multi_opts() with "attach_tracing=1". The libbpf
will attach the target btf type of the prog automatically. This is also
used to reuse the selftests of tracing.

(Oh my goodness! What am I doing?)

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/lib/bpf/libbpf.c | 97 ++++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h |  6 ++-
 2 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4a903102e0c7..911fda3f678c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10132,7 +10132,8 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
-			      int *btf_obj_fd, int *btf_type_id, bool use_hash)
+			      int *btf_obj_fd, int *btf_type_id, bool use_hash,
+			      const struct btf **btf)
 {
 	int ret, i, mod_len, err;
 	const char *fn_name, *mod_name = NULL;
@@ -10156,6 +10157,8 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 		if (ret > 0) {
 			*btf_obj_fd = 0; /* vmlinux BTF */
 			*btf_type_id = ret;
+			if (btf)
+				*btf = obj->btf_vmlinux;
 			return 0;
 		}
 		if (ret != -ENOENT)
@@ -10183,6 +10186,8 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 		if (ret > 0) {
 			*btf_obj_fd = mod->fd;
 			*btf_type_id = ret;
+			if (btf)
+				*btf = mod->btf;
 			return 0;
 		}
 		if (ret == -ENOENT)
@@ -10226,7 +10231,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	} else {
 		err = find_kernel_btf_id(prog->obj, attach_name,
 					 attach_type, btf_obj_fd,
-					 btf_type_id, false);
+					 btf_type_id, false, NULL);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
@@ -12836,6 +12841,53 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
 	return libbpf_get_error(*link);
 }
 
+static bool is_trace_valid(const struct btf *btf, int btf_type_id, const char *name)
+{
+	const struct btf_type *t;
+
+	t = skip_mods_and_typedefs(btf, btf_type_id, NULL);
+	if (btf_is_func(t)) {
+		const struct btf_param *args;
+		__u32 nargs, m;
+
+		t = skip_mods_and_typedefs(btf, t->type, NULL);
+		if (!btf_is_func_proto(t)) {
+			pr_debug("skipping no function btf type for %s\n",
+				 name);
+			return false;
+		}
+
+		args = (const struct btf_param *)(t + 1);
+		nargs = btf_vlen(t);
+		if (nargs > 6) {
+			pr_debug("skipping args count more than 6 for %s\n",
+				 name);
+			return false;
+		}
+
+		t = skip_mods_and_typedefs(btf, t->type, NULL);
+		if (btf_is_struct(t) || btf_is_union(t) ||
+		    (nargs && args[nargs - 1].type == 0)) {
+			pr_debug("skipping invalid return type for %s\n",
+				 name);
+			return false;
+		}
+
+		for (m = 0; m < nargs; m++) {
+			t = skip_mods_and_typedefs(btf, args[m].type, NULL);
+			if (btf_is_struct(t) || btf_is_union(t)) {
+				pr_debug("skipping not supported arg type %s\n",
+					 name);
+				break;
+			}
+		}
+		if (m < nargs)
+			return false;
+	}
+
+	return true;
+}
+
 struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
 						      const struct bpf_trace_multi_opts *opts)
 {
@@ -12856,7 +12908,7 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
 
 	cnt = OPTS_GET(opts, cnt, 0);
 	if (opts->syms) {
-		int btf_obj_fd, btf_type_id, i;
+		int btf_obj_fd, btf_type_id, i, j = 0;
 
 		if (opts->btf_ids || opts->tgt_fds) {
 			pr_warn("can set both opts->syms and opts->btf_ids\n");
@@ -12870,23 +12922,41 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
 			goto err_free;
 		}
 		for (i = 0; i < cnt; i++) {
+			const struct btf *btf = NULL;
+			bool func_hash;
+
 			/* only use btf type function hashmap when the count
 			 * is big enough.
 			 */
-			bool func_hash = cnt > 1024;
-
-
+			func_hash = cnt > 1024;
 			btf_obj_fd = btf_type_id = 0;
 			err = find_kernel_btf_id(prog->obj, opts->syms[i],
-					 prog->expected_attach_type, &btf_obj_fd,
-					 &btf_type_id, func_hash);
-			if (err)
-				goto err_free;
-			btf_ids[i] = btf_type_id;
-			tgt_fds[i] = btf_obj_fd;
+					prog->expected_attach_type, &btf_obj_fd,
+					&btf_type_id, func_hash, &btf);
+			if (err) {
+				if (!opts->skip_invalid)
+					goto err_free;
+
+				pr_debug("can't find btf type for %s, skip\n",
+					 opts->syms[i]);
+				continue;
+			}
+
+			if (opts->skip_invalid &&
+			    !is_trace_valid(btf, btf_type_id, opts->syms[i]))
+				continue;
+
+			btf_ids[j] = btf_type_id;
+			tgt_fds[j] = btf_obj_fd;
+			j++;
 		}
+		cnt = j;
 		link_opts.tracing_multi.btf_ids = btf_ids;
 		link_opts.tracing_multi.tgt_fds = tgt_fds;
+	} else if (opts->attach_tracing) {
+		link_opts.tracing_multi.btf_ids = &prog->attach_btf_id;
+		link_opts.tracing_multi.tgt_fds = &prog->attach_btf_obj_fd;
+		cnt = 1;
 	} else {
 		link_opts.tracing_multi.btf_ids = OPTS_GET(opts, btf_ids, 0);
 		link_opts.tracing_multi.tgt_fds = OPTS_GET(opts, tgt_fds, 0);
@@ -13957,7 +14027,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 			return libbpf_err(err);
 		err = find_kernel_btf_id(prog->obj, attach_func_name,
 					 prog->expected_attach_type,
-					 &btf_obj_fd, &btf_id, false);
+					 &btf_obj_fd, &btf_id, false,
+					 NULL);
 		if (err)
 			return libbpf_err(err);
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d7f0db7ab586..c087525ad25a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -846,8 +846,12 @@ struct bpf_trace_multi_opts {
 	__u64 *cookies;
 	/* number of elements in syms/btf_ids/cookies arrays */
 	size_t cnt;
+	/* skip the invalid btf type before attaching */
+	bool skip_invalid;
+	/* attach a TRACING prog as TRACING_MULTI */
+	bool attach_tracing;
 };
-#define bpf_trace_multi_opts__last_field cnt
+#define bpf_trace_multi_opts__last_field attach_tracing
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace_multi_opts(const struct bpf_program *prog,
-- 
2.39.5


