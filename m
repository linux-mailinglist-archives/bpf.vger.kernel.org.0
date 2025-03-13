Return-Path: <bpf+bounces-53987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82949A60065
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6157D7AAF25
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90751F3B91;
	Thu, 13 Mar 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvAbvMnZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37841F2BAD;
	Thu, 13 Mar 2025 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892605; cv=none; b=WdbWQmQGsOJ0wu/JYtPfkOkVU1uF5cgnY9VRQ1IJh9+Km/3Xsn/iPCCYyt9pq8O0tf7biwBK64wekvpjZjaqr9qHpEiPrEMZJlcq/gDouBQWyeqOSVbL0NQGXJVJMRbwO4Cvm0fa7tzfOWS1nkfnaCTyTplVFpwKIGxSg+yzhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892605; c=relaxed/simple;
	bh=599R3VpgWsxsLh3hGv15v6EwAOq/yg+P4ROah6qR1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbex5as0qQoX6Tc4AhRf5zfwxav4aRmx0UdJvdRMlyg65nzM00lcf2EFRcwsI6SUdYUHqSaX3FnmNaAKMRDTKcVpww5clQd4I5eFacoLbG7/eSijKwHL2l1pRvSAx5zD5nl/MEhFjczULDZrm0VFZv0B9vGs1h0Vcn5GcnjT648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvAbvMnZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224341bbc1dso28767265ad.3;
        Thu, 13 Mar 2025 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892603; x=1742497403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSydafaY/WsmiIQMqJfn70C+BmyUY73FTlIyW6eivNs=;
        b=IvAbvMnZ0K4aQO+SXpqGkBdnOupreyRCW26KHKyonJbB74mJWnj9VgbM0fqlkVcqfY
         pAXjXcv/anEDKhQykJCxnNFYN4qOAdXDwrycNr1GkRnb5HS0KC81tGDgICRMa9Hp84Ui
         3RigYYOWH9tYG3Z0nt0wnWu+YOsaOgAzIJxSXIY7E2GyPQFQCoUOkX4H7518/6XgdL72
         B0wD3807dlwVBb90cGXMOeJ6m/6juLGOqY6Cq8HZLNtXdchHjxzurRFs7ECXiCDWBILS
         RWTbZ9hAcu8gjMX2G+WJKpuvK9qh7OiDo90jPIBXAbBKI0Uy1QV5txYSirGXovqS8And
         5Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892603; x=1742497403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSydafaY/WsmiIQMqJfn70C+BmyUY73FTlIyW6eivNs=;
        b=AXRshL33c4A0NtaWQKGnB2jK2GADlRyrpxjbSHpHTeEfamgrbwsgr0I0+slWWuF1bU
         DObyMwLs5FW0Qh881k0RCtXrjK54eaTn/ujNlQu+BKxNdI7eJnGni/oFEYTbkT/0ZhYp
         X0IVQ5ZoKPTGFq2yhjTUeki/fXh5KduX9efCIEEnThjzCEHpCj/3X+RAoGG3y9tnUSdh
         JF4nyzbB2Ywof3+JZ53+WF2cfMZmqcP6r2jytO+bs5lzqki6Av6qsS8c3yI+RZkPMt9K
         pxka4ztGHmyg5PIo3SJBWol74i+3zU6MbDhGZ9dYIejKQoXYqCeQqgB82yvQHMvTEyMl
         NCOA==
X-Gm-Message-State: AOJu0YzUjgXHHPZfBdyIo+DhvzTZSQJ+Gtyb6thRQsPxdJX7RDzaAMsp
	ro8lxEy8uxFtcWVe1l/nC37tnkgHnKJYY5SB4fC7Dsqg3sPaQqXNfphWcONydmee3w==
X-Gm-Gg: ASbGncsSshXpl+Uqq1CTfhd5aPvsr/TWyG3Iae3RPrP4BVkxNdHs+7UYwgxrgVgbaQR
	IOz3k3O0mxT8+sdH7r/NTMknN617ySE2hZhJG1kAgm2Hu13qmWkwVs/YSJId1k+J6ho0W9Ig4ws
	k93wsUz9ZinxHowlb7pO7iLF5uAefFW2/xzAVX8lNNR+s0UrJ52fXXEYMuXGj4UXphsc5/11ajm
	VnVQVteMEoP7ls4SZbaH6ZxE57y1RATnryeA45uaFZl9vXYSOY6Gq/NON6kioDVvT06g2K2+Z4a
	hDTGnalsT1KFDBITwMOocYixab1+Apx+tXOyslpe2DNegHtRP6aKft6g9uIC3uwCADM3yfbIjZL
	Pvl37wahnWL6coiNNKAI=
X-Google-Smtp-Source: AGHT+IEjRSvJWjMEcJjnrGwACOKswdEe7h16nT1S4pm2y869/gQrM0zxLxMLzZ6jCvDzbHnSzys0SQ==
X-Received: by 2002:a05:6a21:2d85:b0:1f5:80a3:afe8 with SMTP id adf61e73a8af0-1f58cbdd61dmr17296335637.39.1741892602685;
        Thu, 13 Mar 2025 12:03:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:22 -0700 (PDT)
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
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 04/13] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Thu, 13 Mar 2025 12:02:58 -0700
Message-ID: <20250313190309.2545711-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
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
index 463e922cb0f5..d3b0c4ccaebf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1826,6 +1826,7 @@ struct bpf_struct_ops {
 	void *cfi_stubs;
 	struct module *owner;
 	const char *name;
+	const struct btf_type *type;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1a5a9dee1e4a..e0a8a9319b84 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -461,6 +461,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		goto errout;
 	}
 
+	st_ops->type = t;
+
 	return 0;
 
 errout:
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 00f3232f4a98..69a1d547390c 100644
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
+			return 0;
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


