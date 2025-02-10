Return-Path: <bpf+bounces-51024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44CA2F5A4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC43A7B9F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58E257AD8;
	Mon, 10 Feb 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMfc0qdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87325A333;
	Mon, 10 Feb 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209449; cv=none; b=Tt31W51KHaPxwVdTChpfGhAlgUrM7NiRmP4OMQlBCNKoi5Ml7jJdrQEGZX90StC0ZeeZ99pSwJsCUhstE/zqTluCGaw+uNfcAWx92MiPKzvFpb4MHBaXZ23nlF2CjWbWfp4OeV/B7dGWZrwy3YZ9VAvAG9CQsHXW4pWixiQIL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209449; c=relaxed/simple;
	bh=wecBTFOKU/7DDslMJtQcO1DcEyTkzBNNAGp1ShemhsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzMNcHJx9+/kLpJojG5Tyr0tAvKADgKe0Pzqtfau5yRXuWywU4U6t1N+W8Iuk9hGHPXB3MU79yaSfORFHdBZf9soHSWNkBDX2XPNb7IaFZdd6iIDTFwqhOEp3TtkhbPWh3/BAG3ZIkOS2y716/AEim9a8NQvNS+HJReYaG/jxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMfc0qdW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa21145217so7203950a91.3;
        Mon, 10 Feb 2025 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209447; x=1739814247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeAP7Bc6x9e9oxdbqzfBkmCuQiCzPgcgtTAZRyBQYU8=;
        b=FMfc0qdWD+p5k4WEwNzpibwFZeHxuq8nyNM+t9BiTNWGQhVXR7YNNDlERaMAjnsMxt
         1YBobMq/qUIEqrTr9jBgplQIgjIwCd30bKB6jLJTmnPM+4Yml/pqdm5d/F6bkrtgSN55
         DesTmJ1vV//UtirZyRT/1cm0dYPq3RJmvtfYhScDSgfKZqGelwW2JkEqwhKpgXZpqz8O
         YJiaOKC1zNULB+WFKyofegegLhBsF7t/uQtSGqkhqlowDTREBLQXz3G8TpCN8w7b2pyY
         ZKyTf/F3/ReOPxqPk0KR0TShohiVifr7PnabgJsdvvH+Xeie6h3Iz+5jMGgiBo9sSRMW
         ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209447; x=1739814247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeAP7Bc6x9e9oxdbqzfBkmCuQiCzPgcgtTAZRyBQYU8=;
        b=RR4WAuwRkLGOsM+nIEsQHGzhe5qaVrbBU0sm1zvGulnp5uNAZcZlGyNo5VGmEqfAB7
         3y8xi6drujzHJ2NWNzqD9NdPDZpdIuYG1FRSwlfw2m9ZAVLg1KoyJN8luj4Pk2/hN19H
         iTmMMvyFZ5n5tkw3rh/f8bdjlIDTvUZfpt0JtVD0ZtFd/mdIes93qeQfrgAXR8Ej7cXO
         4NGjQvciY1ZLU0TRViOmlC4WzJh4zd3OD9L4hQ12R0pCBIX9+QRd4TZxhgDcs1kR4dsJ
         tbSnHxprAk0RJUKaXEQSrXp4zKrx+nHZsq0XV9FEH0pIEisqqzI2T7QOE7hqwH853878
         xUww==
X-Gm-Message-State: AOJu0YweVOMCI8pWegTnHufWIbdBtk9YbHHcAXlX2rqt1oblSWPR2Dcc
	ODKBMOWVwvPOQ0QCDH4vlrCp2wWZsBl4dUzCGHQE5ajPqn/dwpZNO68zO3Uw
X-Gm-Gg: ASbGncvI3HZAQUJI4zBMbI5tivaxvpLz/QVLoEobKfdarhGdd82D9wPDk/PNRBzKjTf
	4ZltLp6Jv2X4YAqQj1xlIO+cxE3hePhI0UEhX4cG7nK7sZ+nq7gStAdDj4w4pkgc4VGDmT2T7LW
	wL14zPabINGwRRho79TO4fWgJceAyohfO5I3W0/gYgo8A1eoD8qyKBlc9otnkFDDklBPL0Bwe5x
	e0EtcCllg6o/8eRVDmcYiWtgaj3K03XqMbrIEXevzPGYSFPE3yH+wfG6pZUC5HtVNArrYbL9PpQ
	WIEswJBQGXP8sFNNMZcK0Ozjag7gMdglB+WgrDQYNhZjOeEBUb7WDTmKobXFdkUT7A==
X-Google-Smtp-Source: AGHT+IFhTVSIxmKwGH9dmYlhO4Vcd30EKVWJYTknTtHvOBBkOa6UXK/veI/brVLTkmTkXzklbNy0Ew==
X-Received: by 2002:a17:90b:2d8c:b0:2fa:2124:8782 with SMTP id 98e67ed59e1d1-2fa243db995mr22985231a91.25.1739209445174;
        Mon, 10 Feb 2025 09:44:05 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:04 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 16/19] libbpf: Support creating and destroying qdisc
Date: Mon, 10 Feb 2025 09:43:30 -0800
Message-ID: <20250210174336.2024258-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Extend struct bpf_tc_hook with handle, qdisc name and a new attach type,
BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
addition to clsact.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/lib/bpf/libbpf.h  |  5 ++++-
 tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..12c81e6da219 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1270,6 +1270,7 @@ enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
 	BPF_TC_CUSTOM  = 1 << 2,
+	BPF_TC_QDISC   = 1 << 3,
 };
 
 #define BPF_TC_PARENT(a, b) 	\
@@ -1284,9 +1285,11 @@ struct bpf_tc_hook {
 	int ifindex;
 	enum bpf_tc_attach_point attach_point;
 	__u32 parent;
+	__u32 handle;
+	const char *qdisc;
 	size_t :0;
 };
-#define bpf_tc_hook__last_field parent
+#define bpf_tc_hook__last_field qdisc
 
 struct bpf_tc_opts {
 	size_t sz;
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 68a2def17175..c997e69d507f 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -529,9 +529,9 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 }
 
 
-typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
+typedef int (*qdisc_config_t)(struct libbpf_nla_req *req, const struct bpf_tc_hook *hook);
 
-static int clsact_config(struct libbpf_nla_req *req)
+static int clsact_config(struct libbpf_nla_req *req, const struct bpf_tc_hook *hook)
 {
 	req->tc.tcm_parent = TC_H_CLSACT;
 	req->tc.tcm_handle = TC_H_MAKE(TC_H_CLSACT, 0);
@@ -539,6 +539,16 @@ static int clsact_config(struct libbpf_nla_req *req)
 	return nlattr_add(req, TCA_KIND, "clsact", sizeof("clsact"));
 }
 
+static int qdisc_config(struct libbpf_nla_req *req, const struct bpf_tc_hook *hook)
+{
+	const char *qdisc = OPTS_GET(hook, qdisc, NULL);
+
+	req->tc.tcm_parent = OPTS_GET(hook, parent, TC_H_ROOT);
+	req->tc.tcm_handle = OPTS_GET(hook, handle, 0);
+
+	return nlattr_add(req, TCA_KIND, qdisc, strlen(qdisc) + 1);
+}
+
 static int attach_point_to_config(struct bpf_tc_hook *hook,
 				  qdisc_config_t *config)
 {
@@ -552,6 +562,9 @@ static int attach_point_to_config(struct bpf_tc_hook *hook,
 		return 0;
 	case BPF_TC_CUSTOM:
 		return -EOPNOTSUPP;
+	case BPF_TC_QDISC:
+		*config = &qdisc_config;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -596,7 +609,7 @@ static int tc_qdisc_modify(struct bpf_tc_hook *hook, int cmd, int flags)
 	req.tc.tcm_family  = AF_UNSPEC;
 	req.tc.tcm_ifindex = OPTS_GET(hook, ifindex, 0);
 
-	ret = config(&req);
+	ret = config(&req, hook);
 	if (ret < 0)
 		return ret;
 
@@ -639,6 +652,7 @@ int bpf_tc_hook_destroy(struct bpf_tc_hook *hook)
 	case BPF_TC_INGRESS:
 	case BPF_TC_EGRESS:
 		return libbpf_err(__bpf_tc_detach(hook, NULL, true));
+	case BPF_TC_QDISC:
 	case BPF_TC_INGRESS | BPF_TC_EGRESS:
 		return libbpf_err(tc_qdisc_delete(hook));
 	case BPF_TC_CUSTOM:
-- 
2.47.1


