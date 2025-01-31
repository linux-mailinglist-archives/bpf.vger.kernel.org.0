Return-Path: <bpf+bounces-50236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AEA2435E
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B346A1682A8
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E91F4E57;
	Fri, 31 Jan 2025 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg2IYtI1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDB1F4E32;
	Fri, 31 Jan 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351781; cv=none; b=aTnxbOlRUiD6kAchk+OxokYb9xdablqLVnxq+THfPJuAsJld2Ut0F60tG+SCTwE39oIaFmhHRtMSfJ5ERLrW8dIC3EPrmE8G3A0GF3yvA7/f3fzivUeV6o1kbfz+5dYWe/Y57AaOpt6XTZhptmZt6hz2IJF3ZBeTNNFpGQHxHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351781; c=relaxed/simple;
	bh=wecBTFOKU/7DDslMJtQcO1DcEyTkzBNNAGp1ShemhsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKxYC7Z+hXT91JQkPsiyqSz7Gu+ANdarCXjbGyR2G6pq20jsN7OUficcBBeE4MfK0YHg/lrtAqn7BZUE7WbNixL8fugmkE39+FMb9icd7K6ety7gqeuaaossrur0nvJyHqaro6LEGIqLZv3dBpMHeXEX92PQTUATb2V3R60m1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg2IYtI1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso5491906a91.1;
        Fri, 31 Jan 2025 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351779; x=1738956579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeAP7Bc6x9e9oxdbqzfBkmCuQiCzPgcgtTAZRyBQYU8=;
        b=Yg2IYtI1PbogV1jWvI42lKAjr8R1e25IzKUNSQ1jeWnS5fF4jqHwCDiVcr3H5k/Wnk
         GsfR/UHehe6f5+HsFssmWDI/FbBtS+YeXvWwHakEmUwdLU97+tbkYU7zOuo2kJCKLecO
         6c8aby7B7YjYbDTldoHDT5mXtEgp8CJJtgPVhCdtyE5r/YVc80PSpFJm/T17G+pNRYdF
         4f34ME+sfRlzzIJb9oSL8UExIpEySeL12lTK6Yg7SbSa/0yw1//j2h4ChOZqn+rHcEKc
         Yl0jFHjZYpEnDo2MrEPRp+jW7RpdcuVpqZeZE8E++BP62DRzQUZLTNIg9AqPGOLV5WFR
         AOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351779; x=1738956579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeAP7Bc6x9e9oxdbqzfBkmCuQiCzPgcgtTAZRyBQYU8=;
        b=Qfnj37O9jS9sslwOEfEuXB9uD8RemyZyBwoNuUO9/pt5Ke79w1CmZ58eg/Fp18IECQ
         azCTzCSKeBRsCkePBegf2R6hwkejCyNbF2Y5QMnfFgLzeYy+JWlQAPLWXbFTB9mcGjgn
         zQLsEpioTUlbiJVoSwVsBiVyEGCAu25AUmoYAd3cD/DB68imL4c0s00cqBjrqBiiF1Jh
         mhmIicu/OsFnoJb9WahALzUFz5MzLKNdeIxtSgDiWmuYiOGUxV//Sviau/1Op7udGyqs
         BY3+H+8wdHudFy1dHo4SAykQYhiSRFpLk92VqfNoQOqY1w8TEGn0+yNYqRGDXcv7HMau
         fvBQ==
X-Gm-Message-State: AOJu0Yw0OojEBVLsaVYFzCNPfkT7788PDkMh7o8ZFCTmC/F8i6ykWcLf
	Sgg6WHPPeQk+DqDVeys43/78SKq+Xtlra8+IZYFx1SR+LSaNjnGl65GVB8COjkU=
X-Gm-Gg: ASbGncvqspKs58U/VSFCt2zSvB9IxcX+qXOIlG57G+uyw7ntZNAUgCVzfo2NFAvoRvm
	L+uaO5rTwYiwYtydUrAxSSOTJ5mnlHNaDync3+cWuY7q/uZgy702rmVUhioKKkfC22yTMfaNzY2
	fH1ZjgM9dGy0/LnEn28Y0KbKs4UC9bqrJJIp1x7v8xafKiza9um0JyzBEjR20uA20UKHFbLJuVa
	D4EvsaHYhkkJUJB6wWD2dMpLSXwJ0fx/VKtGsblFQW+l9EHMo4gr48lWF/tIExmW1fFmQCIz4ZQ
	x83KH5s0L46P6rtbn1KF6W674dJg72Z+uOrIY+a8FP8NPNzb+4z86L5CirgYnF5CaA==
X-Google-Smtp-Source: AGHT+IETH6D8aPmHF7RVN6o45r66JYgqiVo5uti/kYyiDC/X1NCh/0NLaPHl3YBDdMv4rpIi5FEYcA==
X-Received: by 2002:a17:90a:38a3:b0:2f5:63a:44f8 with SMTP id 98e67ed59e1d1-2f994e50109mr7865153a91.8.1738351779400;
        Fri, 31 Jan 2025 11:29:39 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:39 -0800 (PST)
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
Subject: [PATCH bpf-next v3 15/18] libbpf: Support creating and destroying qdisc
Date: Fri, 31 Jan 2025 11:28:54 -0800
Message-ID: <20250131192912.133796-16-ameryhung@gmail.com>
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


