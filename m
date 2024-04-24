Return-Path: <bpf+bounces-27613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67078AFDD8
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD02288001
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC2D29E;
	Wed, 24 Apr 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLkwYxqe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D15BE58
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922133; cv=none; b=CZH5gG0xaJ2KzLHRvXkp5rb1SzjUuw0PDsuJ7z6S+TM+GDYTuJR4/iirgzc8liBXulT0PZTfwlIk4c2y+GQeNJKyixQVPmS2/L5zF4A8PFJfdLkRWLaimksQqi1CW0i6mpXFRcgLy8fu+po+0Ax/flR62grR5D8CNakQ0CWR7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922133; c=relaxed/simple;
	bh=XNTFwPXq/zIkKx/7/jSsPYtHd3EJEu4EHGglxp4R8r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkCW+226Jz5Wa+3tTtpLrYcx05xGbEF0AS5dyjGGVtWl2O1K6g4pQt0h4byqBmsnEgfV2E79b8+Mv6fdUWu97IGjFKooSGp1Wi8M2giUIWfjShVx/UPGcAcJTfYsFrh0PORd4SAMATIqsRaE+xjUFHbWVjCcKUG9Ftp6AFegpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLkwYxqe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6effe9c852eso5390407b3a.3
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922131; x=1714526931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWRdC3oo/A3o44C4yupF67pCknfH6xg5tY+ELJrIY7g=;
        b=lLkwYxqeoIE0tkAEAsb8Sll+zrcW6NEpzko3gM050VXTbV6xq9mE5DhGHDsuYZXBgm
         YyEWV/h89Dis+E/8ILLwOKwMhu8IFb0tYdF9cC89iPFv/vArm/8zWFcg2CaIuRfTJyH0
         ElzQaT3EZHRiXs8AM7y19LlIKilObPOU0cJ+ImKUGJ/2S+P70oPN0kAAcbtm7chreKX2
         w1cmt84f8PO5IOLqAibmCKbNcmYOIEXBUREgwSovspqEHro9pWhAqLKDRdF1282JnOLl
         H6fqWcsU5dZMBuMexO4Hm8j8t0V+tCHroYg9JfjzCC9X7RLn82sLlMztLfdhmMiLV/Fq
         Yzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922131; x=1714526931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWRdC3oo/A3o44C4yupF67pCknfH6xg5tY+ELJrIY7g=;
        b=YMPiFrhL9ajbBc3tfEb/FXV7nj13/7E3Btsj07KqrEkLbK4iAB3k2X/0hBrUB4cvLk
         Oweq/gsjs0cqdb5FV9exyEST0v1ZJRVq3Zv1PvMO87Vy62svWjT3LRnJO5CdmYmg0vyU
         PDKss/VYV90GdX/NZYyWvT6qfUAhTn57szYO3wzHbbm5mbfDnvWfFIicp/HpwWsOeySP
         BqutMjJnSs29QFX4IBuFwshSMWV/Bi0Mzh20n8b0cNH0lhLD6MWMXtIfGazPrh3ChKF2
         XqUN8T7KVWEpqFCZpFqF8QhWETdwFNM8nDM6rtiWyVHc8R/JhnhXWC3mFBkvpaRNA0pH
         d6yA==
X-Gm-Message-State: AOJu0YzdiwwQbxJVOXNHfS59lOG/zuuyW6lmSPnYa69+olqO5EyxwPf8
	neVoSz4/9jIJyqwIm9vGmf0JFnzHhFm8AYs6SDjIGwsO1OP7SBHvToEwqw==
X-Google-Smtp-Source: AGHT+IGZRMs1xa68wB2IhzBIEqSv7YTp/HflRTneLVcX168AU6WDwsBYxPdmEoAHcO3TD37AfCUduw==
X-Received: by 2002:a05:6a00:1823:b0:6f0:c9b8:e8f9 with SMTP id y35-20020a056a00182300b006f0c9b8e8f9mr1409515pfa.33.1713922131260;
        Tue, 23 Apr 2024 18:28:51 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kui-Feng Lee <sinquersw@gmail.com>
Subject: [PATCH bpf-next 4/5] bpf: check bpf_dummy_struct_ops program params for test runs
Date: Tue, 23 Apr 2024 18:28:20 -0700
Message-Id: <20240424012821.595216-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012821.595216-1-eddyz87@gmail.com>
References: <20240424012821.595216-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing BPF_PROG_TEST_RUN for bpf_dummy_struct_ops programs,
reject execution when NULL is passed for non-nullable params.
For programs with non-nullable params verifier assumes that
such params are never NULL and thus might optimize out NULL checks.

Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 net/bpf/bpf_dummy_struct_ops.c | 51 +++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 8f413cdfd91a..891cdf61c65a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -79,6 +79,51 @@ static int dummy_ops_call_op(void *image, struct bpf_dummy_ops_test_args *args)
 		    args->args[3], args->args[4]);
 }
 
+static const struct bpf_ctx_arg_aux *find_ctx_arg_info(struct bpf_prog_aux *aux, int offset)
+{
+	int i;
+
+	for (i = 0; i < aux->ctx_arg_info_size; i++)
+		if (aux->ctx_arg_info[i].offset == offset)
+			return &aux->ctx_arg_info[i];
+
+	return NULL;
+}
+
+/* There is only one check at the moment:
+ * - zero should not be passed for pointer parameters not marked as nullable.
+ */
+static int check_test_run_args(struct bpf_prog *prog, struct bpf_dummy_ops_test_args *args)
+{
+	const struct btf_type *func_proto = prog->aux->attach_func_proto;
+
+	for (u32 arg_no = 0; arg_no < btf_type_vlen(func_proto) ; ++arg_no) {
+		const struct btf_param *param = &btf_params(func_proto)[arg_no];
+		const struct bpf_ctx_arg_aux *info;
+		const struct btf_type *t;
+		int offset;
+
+		if (args->args[arg_no] != 0)
+			continue;
+
+		/* Program is validated already, so there is no need
+		 * to check if t is NULL.
+		 */
+		t = btf_type_skip_modifiers(bpf_dummy_ops_btf, param->type, NULL);
+		if (!btf_type_is_ptr(t))
+			continue;
+
+		offset = btf_ctx_arg_offset(bpf_dummy_ops_btf, func_proto, arg_no);
+		info = find_ctx_arg_info(prog->aux, offset);
+		if (info && (info->reg_type & PTR_MAYBE_NULL))
+			continue;
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 extern const struct bpf_link_ops bpf_struct_ops_link_lops;
 
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
@@ -87,7 +132,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
-	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_links *tlinks = NULL;
 	struct bpf_tramp_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
@@ -109,6 +154,10 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(args))
 		return PTR_ERR(args);
 
+	err = check_test_run_args(prog, args);
+	if (err)
+		goto out;
+
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
 	if (!tlinks) {
 		err = -ENOMEM;
-- 
2.34.1


