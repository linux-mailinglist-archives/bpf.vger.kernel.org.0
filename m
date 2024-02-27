Return-Path: <bpf+bounces-22788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170FA86A0FB
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3CD2874A8
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B1914DFF5;
	Tue, 27 Feb 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBpc9xMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1014C5B6
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066793; cv=none; b=VbcqGn0V+Iz7EuHcuyOdwQJ7e1e6oKwqcvJ4MsNqFNcW1QVVLK0eS5mtmzo7Z35hHlryli+jtv2E2t28t1bQchdZBQLROqYIGx9YjHslR0VK69IFDmGZhoMeMYx2Idp5acIYjAguzwzBjv/eGoIznGj1VtVVn5z3/RaZWRHmPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066793; c=relaxed/simple;
	bh=JZLPYWwur253VYYmx7lHkzSA5g3GXygzBOw0X4jXqh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbJnLH8ML5847rA+You/zUy8U5O2MlmUrLDabqtGLYPvFgEb7CnS8a/kWwOqgPlw6amLxN9/5cSJYjyrFp8ZvD04UlH+mmSNQWPsxHkv9Hwt+M4ikCdAHG88VoXr/xhHOj6hV5pjyywOU+3YM92EhKVJGUyJuipxm9qwEv9BuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBpc9xMM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4396b785b8so212871666b.3
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066789; x=1709671589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck4ahKqvUsLRPZMERtckLP+GrzJt9TdWlwFGKbWZO2M=;
        b=UBpc9xMMXv6AukvmoDvfvI/iipAwCW/Zyoa3C1aR5oF/hkszDUxKUGk+pRliKAHyon
         xHN/D8teqab0gIwptz+9eAUM6PPyI5ISG57H3j/n2gWmMFts0tEvpmXFLtn4GHkYBfZv
         CJ5UMaA19nPEo0ayjmKP6a6Jh3TNC3a7AvMyLHP0ybhezq/g7j5lfpfTSWLhdX2iqqAo
         loQV0Q0Zyl3zZI+d+C/Am+y/QqL0hgjxO6bDrh2K82Pl68AhgSwdtV58W0ECbGq+fgGG
         PZ8k2GUmsoD52HDcDYj/yYthQ8pwFiza75KtAZSWAyWeippvY5ijVbMyNArWlnE52zoj
         PNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066789; x=1709671589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck4ahKqvUsLRPZMERtckLP+GrzJt9TdWlwFGKbWZO2M=;
        b=PVWGpiTshV3GQEbq13Go4kJ2PqwwQoer8Bww0NxcySCdV+LLXKFu/nY9MSzlLf4Zk+
         x0wLeg7Nh/eUewFpUKDy437w0cDv5htYpRUk085kP8I1g6PqTJQ2d7qotPESM3vhV9k2
         MfvM+kPySIgtq0KI7EzdWztAx7z2vINnBo5PcRb4ZTEvgnDzepJXrXgEgB/D+Q9ExQVe
         kxCPdtdntUxF/hmGhyg/Mr/5pmy3HFDvqZVXGmkq4Nr1tNWV1PDdVwH4coVCNuIwU9Na
         Pl1FWsGLMh4F46yVH7s/Q3ZP/rMNGVeivtg0Lz4yNIme74t6MDOL2rqNlabiJycbWOvo
         m3Sw==
X-Gm-Message-State: AOJu0YyeWMIC1S58IGle7nYtg/rj6YPTUKLZMP8n74NU5cbafqbwUy0T
	fgjuRJLEzD/GBY3bAL/WQJi71x0asT5fQf0naacu5LWCzahmzrW6An1HHAD+uOM=
X-Google-Smtp-Source: AGHT+IF7xETZyKvrXEJyDgsRy5ofg3V+k51mCMyInKCVeaFG8jVedZYMps1VpBlQ7N9rMQg6qgPwyg==
X-Received: by 2002:a17:906:2419:b0:a3e:5adb:cb21 with SMTP id z25-20020a170906241900b00a3e5adbcb21mr6556981eja.59.1709066789618;
        Tue, 27 Feb 2024 12:46:29 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:29 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes (___smth) for struct_ops types
Date: Tue, 27 Feb 2024 22:45:49 +0200
Message-ID: <20240227204556.17524-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E.g. allow the following struct_ops definitions:

    struct bpf_testmod_ops___v1 { int (*test)(void); };
    struct bpf_testmod_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v1 a = { .test = ... }
    SEC(".struct_ops.link")
    struct bpf_testmod_ops___v2 b = { .test = ... }

Where both bpf_testmod_ops__v1 and bpf_testmod_ops__v2 would be
resolved as 'struct bpf_testmod_ops' from kernel BTF.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..abe663927013 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -948,7 +948,7 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
@@ -957,15 +957,21 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	const struct btf_type *kern_type, *kern_vtype;
 	const struct btf_member *kern_data_member;
 	struct btf *btf;
-	__s32 kern_vtype_id, kern_type_id;
+	__s32 kern_vtype_id, kern_type_id, err;
+	char *tname;
 	__u32 i;
 
+	tname = strndup(tname_raw, bpf_core_essential_name_len(tname_raw));
+	if (!tname)
+		return -ENOMEM;
+
 	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
 					&btf, mod_btf);
 	if (kern_type_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
 			tname);
-		return kern_type_id;
+		err = kern_type_id;
+		goto err_out;
 	}
 	kern_type = btf__type_by_id(btf, kern_type_id);
 
@@ -979,7 +985,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	if (kern_vtype_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
 			STRUCT_OPS_VALUE_PREFIX, tname);
-		return kern_vtype_id;
+		err = kern_vtype_id;
+		goto err_out;
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
 
@@ -997,7 +1004,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	if (i == btf_vlen(kern_vtype)) {
 		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
 			tname, STRUCT_OPS_VALUE_PREFIX, tname);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_out;
 	}
 
 	*type = kern_type;
@@ -1007,6 +1015,10 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
 	*data_member = kern_data_member;
 
 	return 0;
+
+err_out:
+	free(tname);
+	return err;
 }
 
 static bool bpf_map__is_struct_ops(const struct bpf_map *map)
-- 
2.43.0


