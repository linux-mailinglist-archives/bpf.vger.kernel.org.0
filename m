Return-Path: <bpf+bounces-22280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8B85B1A8
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 04:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE76F1C210F3
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9256B6C;
	Tue, 20 Feb 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ACTkIr9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664C55E60
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401074; cv=none; b=n5xoUdkz+M/GYyHHWlhtbew3kvhE99AsbPTY+FB5vh2d16jBjC+7qqBMSdDiU71cfnIdhLkXhqUHuexmrhBt/pAW2/WHxsIxwHgAbSr9yRfJ5KSzDlwmcqE4BgNT4nuxH0FkwiaE7edA+cXXVXEDqEB2CXHg4rQrj5WgFa8N388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401074; c=relaxed/simple;
	bh=WCeJYOWpFA4aAYG9AU6cqenBm2lq0LDB3RA405EROwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOon7nJXtedHwYaRUK1l9uyQ2/0v1qmJ/kmlLkx1lxyha1GNdxZujA14p5cSf/VcvT1Ger9CSNiCGEWoF6s+DOToLRcoBnQ8pEmE5a0Wi1rJjg5K67ul2Ukw2iBgp7uCBRaLrU8CrR+X9bJOrR6HxjEhRv7qEH6yszY8dwi/skU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ACTkIr9x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso4207439b3a.2
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 19:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401071; x=1709005871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHXPVUB1nr0Sthgk6cohE38ljuRgW7sUP/a10lgKv7E=;
        b=ACTkIr9xj//tSv77Mh3wVhdbBIsjhVyRHdOYAhRDLQaNIkaUoaZ++O3l7nP/RoYehB
         bCt3cPHQ7uhFW7Zf4pr3apx0NDDg7Ii9s1rEJubMsoHoJglDLlQaCsBWmzgudb5XAZO6
         Z2haZQwfuMyO7GjCFAUPXuqNao+C1Xbt9nkIr1UkGZPoK07q/drH8KIKk6wlepejINzh
         mLE1wZ03+PIxARAlDtLZcdLeHfUK7su6ce4DaGecIKpY37SmTSKZhwQjFQNOWZngsrcO
         xY2ptpByehN0AxSFUz3jKqEBHmRII7iDcNJm4RmzVKD5NUMf1iBioxM4piMoj4VZ6Qsr
         OzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401071; x=1709005871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHXPVUB1nr0Sthgk6cohE38ljuRgW7sUP/a10lgKv7E=;
        b=dilOsMMcOcuskqpfrtdlT7TYNHBObJVulCuzDlL8gNnJbBLC0mWk5H+ImOWSeIm832
         6jOEVZlkKXWw97P04qPwbMgjtUjEwg/2MJg+bGeWxgwc77ItULhDxlMZV60haicYCnf5
         BDOWWpHebBb1ppu1eeeICp7ltnaAGtw9lzaiU+oGH+g8rlH4HrEcwWcCb1vGHtqFCRMp
         Rpi2xe5ihCwc4qFeHd5e4GPiddVxHrST+Aw1nAXo2gOTYswngsumSwdvg26Ka/2Bu7HR
         3Ctjk2KBCmwtSKjTuik6wDxXKwn39bA0zpdizGD5YhQTFVNj6uA4O0ISycNxmPhaJrgK
         zlJA==
X-Forwarded-Encrypted: i=1; AJvYcCXnOjAG8O1e/hghzcLAWXAuQ+/m4vH0V8fy8P3ZRQf2GyrU1JqRtnJjSgn0CFXSUsLXKh1Nz8XZNHeKAYzXLTvITuS8
X-Gm-Message-State: AOJu0Ywe6NfFL21XSiricIYPYBYsQqsaUSNrS6PNO05YdAHqA1S3wpvH
	wsANKmyyI7CLZz05wlEuN7mBJBYTrHUu6tY0u1jWD7suA03e+eAy+rkGn1+1l0E=
X-Google-Smtp-Source: AGHT+IGeBfzA8FmCoaAXcu5vb3lemy5d1ibyBHJoQ+3L0JF9gidLlGX8eVqpkabuA9fCIJVy1Z3Z2w==
X-Received: by 2002:a05:6a20:6f88:b0:19a:47f2:5766 with SMTP id gv8-20020a056a206f8800b0019a47f25766mr13853615pzb.56.1708401071235;
        Mon, 19 Feb 2024 19:51:11 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:11 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 1/5] bpf: tracing: add support to record and check the accessed args
Date: Tue, 20 Feb 2024 11:51:01 +0800
Message-Id: <20240220035105.34626-2-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
which is used to record the accessed index of the function args in
btf_ctx_access().

Meanwhile, we add the function btf_check_func_part_match() to compare the
accessed function args of two function prototype. This function will be
used in the following commit.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h |   4 ++
 kernel/bpf/btf.c    | 121 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c7aa99b44dbd..0225b8dbdd9d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1464,6 +1464,7 @@ struct bpf_prog_aux {
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
 	const char *attach_func_name;
+	u64 accessed_args;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
@@ -2566,6 +2567,9 @@ struct bpf_reg_state;
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
 			 struct btf *btf, const struct btf_type *t);
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *t1,
+			      struct btf *btf2, const struct btf_type *t2,
+			      u64 func_args);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type *pt,
 				    int comp_idx, const char *tag_key);
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6ff0bd1a91d5..3a6931402fe4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6203,6 +6203,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		/* skip first 'void *__data' argument in btf_trace_##name typedef */
 		args++;
 		nr_args--;
+		prog->aux->accessed_args |= (1 << (arg + 1));
+	} else {
+		prog->aux->accessed_args |= (1 << arg);
 	}
 
 	if (arg > nr_args) {
@@ -7010,6 +7013,124 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
 
+static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_param *args;
+	u32 size = 0, nr_args;
+	int i;
+
+	nr_args = btf_type_vlen(t);
+	args = (const struct btf_param *)(t + 1);
+	for (i = 0; i < nr_args; i++) {
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		size += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+	}
+
+	return size;
+}
+
+static int get_ctx_arg_idx_aligned(struct btf *btf, const struct btf_type *t,
+				   int off)
+{
+	const struct btf_param *args;
+	u32 offset = 0, nr_args;
+	int i;
+
+	nr_args = btf_type_vlen(t);
+	args = (const struct btf_param *)(t + 1);
+	for (i = 0; i < nr_args; i++) {
+		if (offset == off)
+			return i;
+
+		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+		if (offset > off)
+			return -1;
+	}
+	return -1;
+}
+
+/* This function is similar to btf_check_func_type_match(), except that it
+ * only compare some function args of the function prototype t1 and t2.
+ */
+int btf_check_func_part_match(struct btf *btf1, const struct btf_type *func1,
+			      struct btf *btf2, const struct btf_type *func2,
+			      u64 func_args)
+{
+	const struct btf_param *args1, *args2;
+	u32 nargs1, i, offset = 0;
+	const char *s1, *s2;
+
+	if (!btf_type_is_func_proto(func1) || !btf_type_is_func_proto(func2))
+		return -EINVAL;
+
+	args1 = (const struct btf_param *)(func1 + 1);
+	args2 = (const struct btf_param *)(func2 + 1);
+	nargs1 = btf_type_vlen(func1);
+
+	for (i = 0; i <= nargs1; i++) {
+		const struct btf_type *t1, *t2;
+
+		if (!(func_args & (1 << i)))
+			goto next;
+
+		if (i < nargs1) {
+			int t2_index;
+
+			/* get the index of the arg corresponding to args1[i]
+			 * by the offset.
+			 */
+			t2_index = get_ctx_arg_idx_aligned(btf2, func2,
+							   offset);
+			if (t2_index < 0)
+				return -EINVAL;
+
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, args2[t2_index].type,
+						     NULL);
+		} else {
+			/* i == nargs1, this is the index of return value of t1 */
+			if (get_ctx_arg_total_size(btf1, func1) !=
+			    get_ctx_arg_total_size(btf2, func2))
+				return -EINVAL;
+
+			/* check the return type of t1 and t2 */
+			t1 = btf_type_skip_modifiers(btf1, func1->type, NULL);
+			t2 = btf_type_skip_modifiers(btf2, func2->type, NULL);
+		}
+
+		if (t1->info != t2->info ||
+		    (btf_type_has_size(t1) && t1->size != t2->size))
+			return -EINVAL;
+		if (btf_type_is_int(t1) || btf_is_any_enum(t1))
+			goto next;
+
+		if (btf_type_is_struct(t1))
+			goto on_struct;
+
+		if (!btf_type_is_ptr(t1))
+			return -EINVAL;
+
+		t1 = btf_type_skip_modifiers(btf1, t1->type, NULL);
+		t2 = btf_type_skip_modifiers(btf2, t2->type, NULL);
+		if (!btf_type_is_struct(t1) || !btf_type_is_struct(t2))
+			return -EINVAL;
+
+on_struct:
+		s1 = btf_name_by_offset(btf1, t1->name_off);
+		s2 = btf_name_by_offset(btf2, t2->name_off);
+		if (strcmp(s1, s2))
+			return -EINVAL;
+next:
+		if (i < nargs1) {
+			t1 = btf_type_skip_modifiers(btf1, args1[i].type, NULL);
+			offset += btf_type_is_ptr(t1) ? 8 : roundup(t1->size, 8);
+		}
+	}
+
+	return 0;
+}
+
 static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 {
 	const char *name;
-- 
2.39.2


