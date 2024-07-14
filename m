Return-Path: <bpf+bounces-34785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08108930B1B
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63654B20CC6
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2814373B;
	Sun, 14 Jul 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXxRi76b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3013E41A;
	Sun, 14 Jul 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979499; cv=none; b=pzSaZXIpjQSiV040/d6AR4rxu6ge9g9HAciu9I7D11+fysbq/SimZ/5U153dKoyGXTKbxczjdtBNfHMRRWQGzgvoq+S5qaSYfpfmInRGilVgrLqEiqMOL4IzBw2IPGq9EMZZ/qk7AXYeYdqRGHX293PUvwVV2WdWo+2aQ3/R7PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979499; c=relaxed/simple;
	bh=5/7PVeR4sVk6VM5DPEBKzHM3YGlxnATuiRH53a/Z5hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSuqK3tV9l5nybabkMNtCCn9u1mlFuQVCFT4bkbNUlDKPg7+ApLwHnitcgdYytWE+Qu36cLyTByl942raz546+aTWsDcjpcZAhJm5k0PvBvGeRY7/pDM7iUAN0L7aLzmC0dKTy5nqRv3ttGyrbDixWJIoPcg4wDHtXZDUqublmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXxRi76b; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79f1b569ab7so214328285a.3;
        Sun, 14 Jul 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979497; x=1721584297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BCOqlM5LK1vU/RnwpXYYvOWVT6XW2o3GkyNCOwIx70=;
        b=TXxRi76bF6yI3GPgwrN38l7vuhphjbNZCweOVfgfIukwP+YHJ0d1JTo1Bn5/KKpeRc
         DuwwtzHoB89mQgrnzytY+jBM6pG+GxNiZFeT1lpj62dGFSW01/eNZJ1ZYtj5ClL9WZhm
         kRsBJEp1yixvnI1a6EPl8uNtKNpWYrI9wCN80ay352cTh4FrozMgrW2JRfuPTh/0G9p/
         JSIkGWnN95VyjD+eGIVsWyNfZbj6AcDODo+fBFvuZHn0Xtk4mfGvrzanVbNOpucyAr6l
         lfQVAF91QEfTjTDSfbD89hcIWK8lddwRJFR7VqiBYLopkSZYy2RqcFlbkgLquT1DsAo7
         xXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979497; x=1721584297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BCOqlM5LK1vU/RnwpXYYvOWVT6XW2o3GkyNCOwIx70=;
        b=V0KpObcnhndMaLdQL546R2RUJoW6h31kSjNRCRLZYQor1nDaBhP0hAAUKYNrKT+U24
         RqMGBar9cELTu8I/shxaxr5nUortTpw/FSYV0C2P051bm+qvYTvD9mgy1rlDAocvNs4L
         kUVuquJ2yYUqwAq9gR7zZm2Bfq68Sb99zdqo67u31lVAhSY1gG4UtJ9jmmOcpfU7Gf55
         fTnl3NQnNZXJIRX4Coct1s9guDwPsKD4Nq05DYCJiwMcUtolb3lxm4uIv7vvLX3UntW3
         +havg3fiLjd4NFszvXjI1WG3Zs5r8osUhYin3uqMzSQQFok0Q6R6vJybFhFDCIfUt2u8
         IIVg==
X-Gm-Message-State: AOJu0Yz+kB3nY1LIPCx0XCSMw6l69OhtToehkWWudxrywHwIUpwH5BDs
	tcutza8k+bG3Ra0CcLGVWl5WkP6SwFbyuo4WY6/jZIq9imtnvw8ei87EkA==
X-Google-Smtp-Source: AGHT+IHlEy4dfOhiOUwK2gFUrEklq9mjj+UAlts+yqE9+htnzHezs/VIDGtLR6ucKLqk2KWaWOk+6w==
X-Received: by 2002:a05:620a:172a:b0:79c:4030:d891 with SMTP id af79cd13be357-79f19a440e0mr2348279985a.12.1720979496897;
        Sun, 14 Jul 2024 10:51:36 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:36 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 08/11] libbpf: Support creating and destroying qdisc
Date: Sun, 14 Jul 2024 17:51:27 +0000
Message-Id: <20240714175130.4051012-9-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend struct bpf_tc_hook with handle, qdisc name and a new attach type,
BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
addition to clsact.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/lib/bpf/libbpf.h  |  5 ++++-
 tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 64a6a3d323e3..f6329a901c9b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1258,6 +1258,7 @@ enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
 	BPF_TC_CUSTOM  = 1 << 2,
+	BPF_TC_QDISC   = 1 << 3,
 };
 
 #define BPF_TC_PARENT(a, b) 	\
@@ -1272,9 +1273,11 @@ struct bpf_tc_hook {
 	int ifindex;
 	enum bpf_tc_attach_point attach_point;
 	__u32 parent;
+	__u32 handle;
+	char *qdisc;
 	size_t :0;
 };
-#define bpf_tc_hook__last_field parent
+#define bpf_tc_hook__last_field qdisc
 
 struct bpf_tc_opts {
 	size_t sz;
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 68a2def17175..72db8c0add21 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -529,9 +529,9 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 }
 
 
-typedef int (*qdisc_config_t)(struct libbpf_nla_req *req);
+typedef int (*qdisc_config_t)(struct libbpf_nla_req *req, struct bpf_tc_hook *hook);
 
-static int clsact_config(struct libbpf_nla_req *req)
+static int clsact_config(struct libbpf_nla_req *req, struct bpf_tc_hook *hook)
 {
 	req->tc.tcm_parent = TC_H_CLSACT;
 	req->tc.tcm_handle = TC_H_MAKE(TC_H_CLSACT, 0);
@@ -539,6 +539,16 @@ static int clsact_config(struct libbpf_nla_req *req)
 	return nlattr_add(req, TCA_KIND, "clsact", sizeof("clsact"));
 }
 
+static int qdisc_config(struct libbpf_nla_req *req, struct bpf_tc_hook *hook)
+{
+	char *qdisc = OPTS_GET(hook, qdisc, NULL);
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
2.20.1


