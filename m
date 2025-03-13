Return-Path: <bpf+bounces-53993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D024DA60077
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017E97AE973
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4F1F4610;
	Thu, 13 Mar 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH2LH7Ac"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F21F4186;
	Thu, 13 Mar 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892611; cv=none; b=pTByKLduqFVcce2DQdPNvbmzwyFZbOuwwkF2R3+m4PJbjJVCWI54ZcE7uEsLB0M/oTMwDRCNL0zuKMFG95rSOxkiEgDpn3LUxin+Tyy4cSFfJcZIuEtrluSkbJ2Zof6yZ0sR4kusP9du7FpF7kXIpI1wfqG4iJz2iA1xsHYvBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892611; c=relaxed/simple;
	bh=jpOgH4a8Ds1xnL1nmdR7TDa9aI0Ex8U6aEF/JjDBYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfUHZycVJz47ykLcp7IAaIdO3qwEF7NPAsGVRt+hxTNq3MQNxPKnipS/N1jJyHxsRCycUBonPAaF6PB1Xz+2a/CvEQQz8ItYfudWIaaG7BkoIQ6PlXQwUzeSuxEaPpQRee9YwP4hlGbRovDDsE0yamV5RN7xochuEjT88mZSd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH2LH7Ac; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22355618fd9so28387515ad.3;
        Thu, 13 Mar 2025 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892609; x=1742497409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slC/xxmyiHhZuV5shK7ICE09JWvyZwyxSejcvp1dZss=;
        b=BH2LH7AcNTfSgsBC0MuG8imw5dp/8j1sUCxHlorGaaWh2K/9i384hPiq+vkL+JvRfr
         /YfUdD8H1RAXXmsuCFsfpADQvjxxF3XAUK3tv+uTF0qneYtCc9YjMdfYufylsJsMzEUL
         FDxw1DVT6m2RDdxbjCK4w94xSsO7WjhS0Pe/O/SRVFl52et+qeQFImC9qfM961h/wrUV
         rxzqWMLwKkBGwGY10Ge0oLCqMMN4jaPujOJX3+44OhyMMy8nfs9bp4/HSUOeEbkKHwVi
         3yaspfg849CGuUe5eP6TQGuSbr7YnCkLJqb+CzZhihqqumFwxtAGmbZO1UXHBOe3FQNy
         v9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892609; x=1742497409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slC/xxmyiHhZuV5shK7ICE09JWvyZwyxSejcvp1dZss=;
        b=Og4GpN4S0O4+puj9YEq0hsDt3VAtKkuv3iCr/L5wGvasGr5F4pngbe8sguDMuwpuv8
         jL/SPWanBaX2PjIbyc3cgtdJzkw8OD5dExte8n2CJiLrUXKwqTgmTE4bkFrsw6lmDSdJ
         j8/qvIcstoN2rbkaLRXHKPWZ+StJdt8hSxo3Ol2Yz3RAHR5OecDmVJnBH5d4shTCWjTW
         cuhmroT5XStdmMVMeA3oAJ8r2F5Evq941wJxc8Y8U0JCcMtgQgI90J5ztYPPEXWvi/nn
         K0fHvtxCdxXPcOCiB5gJ3AEteVBSFQSQCD6wfOXBHmMo8UTVd4/12hpz3uFCZKjRV5Pm
         I0JQ==
X-Gm-Message-State: AOJu0YwSG9ciyOaePClXgpVMo+A0/A+t4mX8HS7Xphs/KPX81iGJes5G
	/GTLFrsmBTJTHwwLhT625DleGUabgPhudYVTzGxWxc+necjI10anSJD+3s0P39ZUxQ==
X-Gm-Gg: ASbGncvPTEjJH9SJQH7zMd/U090KYmHxdL1XCF9VkphUZaPIlGUS2AgAr8szL1pntd+
	fpUwsKln0iElKRnAByhoVnrfIcQC9aPBy+Lw/+nRt1TH1hnQf6nTIAA0bSWbXIpihJ+asJI+sB6
	UmRYt4JmQM1ytGOFqyLF8nhOrLoL2z9EqRRkafApH25KiBmDPH0AIGTCM6nIZ6qky2NgSArKtUe
	Pd9DGpPyK647BBNuTCqblsKApHfrR3dTvHrecNgcPdvtIsgfCDyVlhLNlxMXCXo98O1t9TVKp/K
	Q7XvNq5KGWq71zuuGqyTU6IZZ+5SlvusfM82eEZZsvDQJHlMD/g1rbZabwAidlyLlPqwv6r7MLZ
	IIJcHNOAGPPZEACBqNYU=
X-Google-Smtp-Source: AGHT+IFudgtJbiQ9GR0vEaYspoRX+BDnwDdo9jMQMExrkrVoic2iL+mX29vH9/DUnwRmXI/n2Y5MMA==
X-Received: by 2002:a05:6a21:6e93:b0:1f5:6abb:7cbb with SMTP id adf61e73a8af0-1f5bf775535mr521232637.23.1741892608812;
        Thu, 13 Mar 2025 12:03:28 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 10/13] libbpf: Support creating and destroying qdisc
Date: Thu, 13 Mar 2025 12:03:04 -0700
Message-ID: <20250313190309.2545711-11-ameryhung@gmail.com>
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

Extend struct bpf_tc_hook with handle, qdisc name and a new attach type,
BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
addition to clsact.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/lib/bpf/libbpf.h  |  5 ++++-
 tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e0605403f977..fdcee6a71e0f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1283,6 +1283,7 @@ enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
 	BPF_TC_CUSTOM  = 1 << 2,
+	BPF_TC_QDISC   = 1 << 3,
 };
 
 #define BPF_TC_PARENT(a, b) 	\
@@ -1297,9 +1298,11 @@ struct bpf_tc_hook {
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


