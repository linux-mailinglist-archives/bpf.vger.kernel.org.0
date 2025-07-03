Return-Path: <bpf+bounces-62270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57035AF73C4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24433B6043
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DD2ED87A;
	Thu,  3 Jul 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM75S7Ze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14A2ED856;
	Thu,  3 Jul 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545086; cv=none; b=VKPvpt7E9xgL/DSTqgWJjgmMSSH+FTsCPh2PUjugdJj7LcRUDYBrfPEHrPXBVQIhgBG3RJzTEiFo4nNY0bzL2m/xcqY1bDgOfEDuHiYmxufjbLaHI8fekSbBZLTXVQKi9jeiGHWCq0rfkwhIds9ylB0j6aZtZT6RxPhvEyvqego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545086; c=relaxed/simple;
	bh=me2wHPE+RKO81R/XZ4CvxniL2+6beofNPvhYQDcXDzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qaKHfwsPetGbfwhv28ZurDFahzjeEITf2hpaspNAXJYSqXbHGbC5ImRk8t3bvriQuMr1kAx5MhYI/L7MCJhVwf+HZEOhRaKM/bY5ST4jxdYLc6lbcp47HqKxG82DNDfr/KhsHlxSV/ca47fnqj7gOyWZGL9/deuWmNqNFO4pv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM75S7Ze; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7426c44e014so7875357b3a.3;
        Thu, 03 Jul 2025 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545084; x=1752149884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFByRrAg1K4AEkhPppXHajMjtxJsifH2J6DBQuqLFGA=;
        b=eM75S7ZekNf6OAwmFtPH0h1SXyBJgg/FJSPolyj3/K/bouoREY9MuwccK3bzhhlD21
         Uyt/iOTqnuVGT2fnP85wNK1DvGxgXNgHdakR5022EtViGrXtIIraVA7RiF5NXBl0nP1f
         ea2H5RQp993M3+1C+tpoWsOmEzOajkCBXmWjceqzUh7pFDYvvTIy6jQqbWmMYL4F5TNP
         yydR+sq6+VH2NTI1YLM9Hz3ZJp3WYVficSRQ9Groclg9haMq6JlEucEcPt4ab/R41jnB
         TYLQAD14Kfx96UZ25BeNK7Sr/mBxT2y5nknTFFpcO41INNyUVSIJDltfwGtnXk+kn/uN
         AU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545084; x=1752149884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFByRrAg1K4AEkhPppXHajMjtxJsifH2J6DBQuqLFGA=;
        b=mzyIocDGP40pIEYY/DtNIBBWNdRzqRIQA9iL7lEjD7P0PQiil+dCxwIqRHdnbitljm
         KUdRnu1VbiOMr79AkWAPw/h7JT36muMHs/OmB9T27+rK06ZeFo2j+SwnbjiTGH3Hbjbf
         E6Lz3PMiYOx/nD9lKKTkpaEOWVfPnGwKjwblwCY/e5GWklX/YLCmiEXtRPKMjmppeOFp
         br1oFAdHDXk+fYtbjXUVal46dTQjTJu66NGxzuiCFYWteWK4g4oWkfdA4vteLQduZtg5
         1kpQ7a6Gl3MSBaHBEp61t3jQ4zjd9aTCgQ51i6KF1UWk3WIsJdfaks5dNAHTErE5EHcZ
         hPJg==
X-Forwarded-Encrypted: i=1; AJvYcCXXJwaTPiRltvhKlUMdAMjivS7IekXSVMcdPQcZISx93bxsIV/imcOUM1i8yepiHNsPUIWtxFxF8FQae5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/kyHQXaCkyxLlM0jRBVNFj1Y2ivXnVoPyh939BPd/a+Lx5Ll
	Tw3pU2wXy9kssONubpMJmfHlO/459HwusCshNpP9fe8ItmN8FxZDyIGT
X-Gm-Gg: ASbGncsc2q7wZRPfiz1V/k1iS9HcSmlhmYM39fonMPbIVw9yLN8MPb5zQX30tWMYq+S
	4IfLzOL1aDTZ8ZLgMOv036UxnyE0tPazzEnVrHVM45BTG4iKG9NE3w12eStWEljpoGAwcBJg2Vj
	pTOL5iiaDVdqVtkjNpH419G52DXPSrhkl5c7nqoVKdkUcR1/jG3t3ctUqNLob3Z+OdnFY5t7Ket
	qDpQCk5XHA8Y7HRJj4Izj05kqYmNtcP43wirLlZ8EoP1nZKKfMdpVVLNTNZXLRXp56vf7+Rjuiu
	u7DmNXYVrXIKwQ0jkzBzdioAxvS9pKDH/xMHjzuj3PvHi8GxCyX0rmIOfol2M2mrqX6TYZdDSR3
	nyVo=
X-Google-Smtp-Source: AGHT+IE/VhgZTP/mTyptqyGpVOsJsAMYjJiE9SvL0jggcgAdXKDNQYBlnGv2WoynBxSiiYxcFV9C3Q==
X-Received: by 2002:a05:6a00:2191:b0:748:2b23:308c with SMTP id d2e1a72fcca58-74cd170bb94mr3508011b3a.14.1751545083503;
        Thu, 03 Jul 2025 05:18:03 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:18:03 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and attach_tracing for tracing_multi
Date: Thu,  3 Jul 2025 20:15:18 +0800
Message-Id: <20250703121521.1874196-16-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
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
index 4c67f6ee8a90..e8068ca58149 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10144,7 +10144,8 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
-			      int *btf_obj_fd, int *btf_type_id, bool use_hash)
+			      int *btf_obj_fd, int *btf_type_id, bool use_hash,
+			      const struct btf **btf)
 {
 	int ret, i, mod_len, err;
 	const char *fn_name, *mod_name = NULL;
@@ -10168,6 +10169,8 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 		if (ret > 0) {
 			*btf_obj_fd = 0; /* vmlinux BTF */
 			*btf_type_id = ret;
+			if (btf)
+				*btf = obj->btf_vmlinux;
 			return 0;
 		}
 		if (ret != -ENOENT)
@@ -10195,6 +10198,8 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 		if (ret > 0) {
 			*btf_obj_fd = mod->fd;
 			*btf_type_id = ret;
+			if (btf)
+				*btf = mod->btf;
 			return 0;
 		}
 		if (ret == -ENOENT)
@@ -10238,7 +10243,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	} else {
 		err = find_kernel_btf_id(prog->obj, attach_name,
 					 attach_type, btf_obj_fd,
-					 btf_type_id, false);
+					 btf_type_id, false, NULL);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
@@ -12848,6 +12853,53 @@ static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_
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
@@ -12868,7 +12920,7 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
 
 	cnt = OPTS_GET(opts, cnt, 0);
 	if (opts->syms) {
-		int btf_obj_fd, btf_type_id, i;
+		int btf_obj_fd, btf_type_id, i, j = 0;
 
 		if (opts->btf_ids || opts->tgt_fds) {
 			pr_warn("can set both opts->syms and opts->btf_ids\n");
@@ -12882,23 +12934,41 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
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
@@ -13997,7 +14067,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
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
index 1e7603c75224..2f65a9cd57f9 100644
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


