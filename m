Return-Path: <bpf+bounces-50230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77F9A24352
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59ECE1682BE
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A01F4292;
	Fri, 31 Jan 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKQw4ucL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADF1F4275;
	Fri, 31 Jan 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351774; cv=none; b=hb924JE/wVNRkqdz7hKOoomzGQBrc8FnM5ZEB1FJ6KavXlssDf6mSwnFvRM65GOa3xYSlaegG+MGlG5mF4U+BM3knwCdiwu4AoQC4aVkNushv2cmzSM9uz6JULbpcHVA0HouItSX66iLaRzUl7BfEODwBKQCA+s7tIEJybtB8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351774; c=relaxed/simple;
	bh=GPsQE8JRKuwT8SbG2JwH65Q2PUIB137RV3jOot94V64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acJNygB7/WhAu9W8JtUb6LzqXw5lWKFMhXlPOWsONhO5Lhx2FbMpjlikgF8Y2kxofuee81fOhCXUkcDiyhGYNg8T/2eQ/Ve5XpfME8ToRnIraA+Txionwdt3UHnM3v1fe+Gr6M4++1wY8FMY+VXcXWrUWpfhtdmqqvLqBnXXfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKQw4ucL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so4187456a91.3;
        Fri, 31 Jan 2025 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351772; x=1738956572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3cHzm0uEOud7HRhJ1FrC8HEWxtQmFr04yI2MB9NIwI=;
        b=ZKQw4ucLFn6BeEA+53YEPIBbhzRvq2z1P0NEvNy4/oLw7kfNo0RaCJSvPfpkgICqmH
         gYYNjzLRsffY30cvTg+8SPyM+hzscme4HK3n2jH7u+v/xlUXeGloM25kUgfbistDwriQ
         QSjAe+vGbf2vBcL618ElOCDheaGLvKea7eYaQ9r7utdmkL/hpYN/Ei2y5Oa5msaysXeV
         XZTP4v9SRIEfSMjhSWup3/AD9b+uic6FillmPU7pJLd43t6kqXssFt/4r9BNPFMXennF
         NO3U8a0ltLYcaZ4CMIhvDKyC13yIBjI9hUpxxfWWdUJwTdQEM+M4XCy1zbbtd9eq0lXu
         WdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351772; x=1738956572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3cHzm0uEOud7HRhJ1FrC8HEWxtQmFr04yI2MB9NIwI=;
        b=uB6pSXHYnks2rplRSHoQyUqS/8V1XxNe+wSWX9OGzwjTE92OfzYlLXqlF3UvnulK6J
         NPbyh3uTl+zQ+yGK6SssAc7u8Qb7OLhsFVNF57SAj+/33p0Rx7j9Zei0TlAA5eH4Xv4G
         MZ/tMw/I5GepPYY9/a/KFOTkaKGPOAuVvY6vAdkd1uoep/JJKRYZespq0VP0W8kZhk2l
         jEZKWf4He1RsnuT9WzlA/rS9hIEspHLwzPipNTKsdNVb7/fQBAqOxy29gawYgF6Sk4yR
         snZf3MfzWfmOFCNO/IEyvsciO7EVle3vRPfF2bt8yYWP+xYwpr15JNT90Pqc8TrEsDJk
         4hhA==
X-Gm-Message-State: AOJu0YyxOnOEvmAZe967BQSmjGFVHsesh/YI/vP4BLHIJPesESu1703N
	smDdeiGLmE5ORS9efRKsNnCTYUqp+4DCnLfLJgrt7HZVFHM+8tvkYs7wXKkYfYE=
X-Gm-Gg: ASbGncvO9z0YliQie+xeyYMN/DtQUOSCRjoKNIxwSvcbd9lkYffOvPwjMtDjwtIVtnf
	Pde8nFEIsDkVEVBqdtchqEv0YF1tPyTP5sbVqDyDqi/b7oct97Ga8LfmFlv92PCqW8IACggE6Xl
	VzlZVOTD4MZtU5BqN+7Keeepnz2nHNzQ6+TzdqDNWC6vl5N0MnH3KFpXg3oBCGKtsDgjF9l/OLw
	eezDUGRY0Fdes+h730zdXUM/C/ay3wcZj4LyHJ+Lh7tLLIq+GNDEQPNZpOIUQIWPGxF7UPeDU5I
	313iFGisbg5onvDV42pJSRP+bla1i59Xm2gWlW6umg6GVIZtimQ9S1q9yh3dL0sUAg==
X-Google-Smtp-Source: AGHT+IF5nYo754SHrDlyACzRUruOwRNHSBiinnS95KhOCs+q7P4S3q91VJWQ14g1wcLIPHi6wVTmgA==
X-Received: by 2002:a17:90a:e183:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2f83ac83853mr18079559a91.35.1738351771864;
        Fri, 31 Jan 2025 11:29:31 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:31 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/18] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Fri, 31 Jan 2025 11:28:48 -0800
Message-ID: <20250131192912.133796-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add basic kfuncs for working on skb in qdisc.

Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. bpf_kfree_skb() should be used elsewhere. It is also used
in bpf_obj_free_fields() when cleaning up skb in maps and collections.

bpf_skb_get_hash() returns the flow hash of an skb, which can be used
to build flow-based queueing algorithms.

Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c |  2 +
 net/sched/bpf_qdisc.c       | 93 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6003ba36f6c5..bbca7b537cf8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1810,6 +1810,7 @@ struct bpf_struct_ops {
 	void *cfi_stubs;
 	struct module *owner;
 	const char *name;
+	const struct btf_type *type;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3a76f0c5a82..1ee6d41d4948 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -460,6 +460,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		goto errout;
 	}
 
+	st_ops->type = t;
+
 	return 0;
 
 errout:
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 00f3232f4a98..e188616c86a4 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -111,6 +111,80 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+__bpf_kfunc_start_defs();
+
+/* bpf_skb_get_hash - Get the flow hash of an skb.
+ * @skb: The skb to get the flow hash from.
+ */
+__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
+{
+	return skb_get_hash(skb);
+}
+
+/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
+ * @skb: The skb whose reference to be released and dropped.
+ */
+__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
+ * @skb: The skb whose reference to be released and dropped.
+ * @to_free_list: The list of skbs to be dropped.
+ */
+__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list)
+{
+	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(qdisc_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(qdisc_kfunc_ids)
+
+BTF_SET_START(qdisc_common_kfunc_set)
+BTF_ID(func, bpf_skb_get_hash)
+BTF_ID(func, bpf_kfree_skb)
+BTF_ID(func, bpf_dynptr_from_skb)
+BTF_SET_END(qdisc_common_kfunc_set)
+
+BTF_SET_START(qdisc_enqueue_kfunc_set)
+BTF_ID(func, bpf_qdisc_skb_drop)
+BTF_SET_END(qdisc_enqueue_kfunc_set)
+
+static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
+						 prog->aux->attach_btf_id))
+		return 0;
+
+	/* Skip the check when prog->attach_func_name is not yet available
+	 * during check_cfg().
+	 */
+	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
+	    !prog->aux->attach_func_name)
+		return 0;
+
+	if (bpf_struct_ops_prog_moff(prog) == offsetof(struct Qdisc_ops, enqueue)) {
+		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
+		       return 0;
+	}
+
+	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &qdisc_kfunc_ids,
+	.filter = bpf_qdisc_kfunc_filter,
+};
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -203,8 +277,25 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
+BTF_ID_LIST(bpf_sk_buff_dtor_ids)
+BTF_ID(func, bpf_kfree_skb)
+
 static int __init bpf_qdisc_kfunc_init(void)
 {
-	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = bpf_sk_buff_ids[0],
+			.kfunc_btf_id = bpf_sk_buff_dtor_ids[0]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_qdisc_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
+	ret = ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+
+	return ret;
 }
 late_initcall(bpf_qdisc_kfunc_init);
-- 
2.47.1


