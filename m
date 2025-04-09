Return-Path: <bpf+bounces-55594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712F4A8339B
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CED446865D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573921CA12;
	Wed,  9 Apr 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaNTe+uZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6EB21B9D5;
	Wed,  9 Apr 2025 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235180; cv=none; b=GCJc2t8umMCZW1rFLTGN8BgvoBHpadethL9a0spADoOlKm5cIntzGolyFxnxpoKhLGlrXNEoK9dqo3PPtVuHXcEvaqqK/gd8NUVONcdWFTVVfRGpTsOIF24kME4KU9eHBnDIbeVjXXmruN7Pxj7370fbxlFKqVXZnQFA7P0FNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235180; c=relaxed/simple;
	bh=H65Rd6PJNUiZCQZxJba7/R0D+DJJvwvv5AQi47YKh/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA8j4nZihcnRnIpVpVVlpu0obu5rAqeYgiSi6IM/gNfHs98zI+03mlsF6C1dVxcdcTdF6WwB74De+P/ugSuyon0uTfkaqCN8jcRjIg9MhGPhCHaUzpXQtpCBi2zmriCj6TL5wydINEwqHk0W/ZtmvpmueEuSYpfaf0wEjpEaUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaNTe+uZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225477548e1so1286445ad.0;
        Wed, 09 Apr 2025 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235177; x=1744839977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8ejcrrrC6yV6s9uq4HHgS9blRXEVLqg2s5IbclXas8=;
        b=LaNTe+uZ5evW/GRQNX75CYkwJoVFZ5ktA3mg3u2M0xn28E24iNfQyjyT0l3VMDa2ac
         FgEpRfz9KkbzxHjTvUSEFgRe3DKw2w8nXycublzZnmKL9MKO/LViBQj290J/tg/Ni5oM
         hMqkpYyBwrtQTlOnWDFBU7ngdmkcqQSsYJd0hRwHvUPnuHrGg//fE9v+BsTvSJno9qCA
         j4ZrLPMB+9dLGcEhi/B5Tuxzmf6vEtNrFnWjFiuaGlS3RF2uiu3IvBoGYcSMqcN4pQ3H
         fqiq/N6F+fyQJYkDhrDKenQArz80S4qqpxL5qiig+emRIgOp4IgDgRiGv59MNrOfwzaQ
         Tndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235177; x=1744839977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8ejcrrrC6yV6s9uq4HHgS9blRXEVLqg2s5IbclXas8=;
        b=M7eAKYcjSAJz4qexNMgre86lgv+EBifeTpGa76HwA58gB9VXUQtAwtTM1yxl+d9ghk
         iWuV+wARCpsqdyRd7gNYFFF24Ms9XvI4y9ZgT1Fxyn+gfFgjH5fYAC2TtMVuqSnkb74S
         Mgbag9+BHLjZ2hbnFRFH6RPtMn+Ut1VFrxRkHCA9kpCxRNuaq7LAw/Fq6DtG2c5SOfst
         GtGVgxBZ7I6hdhtKSoaRl9hQNM2qMXKesI1AfygQUXLG5BpsrHpZJTByBwmhHqR6L//b
         4s17LFC8UbQ6OZyy7J+0z0CCQoNylpSjahsN/pFtZSV+3bMP4YSyXZhZhBNJa1kQBYFR
         0yJw==
X-Gm-Message-State: AOJu0YwQu17hq9L1yPCVc4a2XKqWdMPvc+01Y0MGolU1PKbuIuDUcvPY
	xawcwW1/i1nmotbjeylsbqLQzBrR+hb9OpzF31nE7jMJ5NwYXGFIgZ57BX0m
X-Gm-Gg: ASbGncvxJ1ddThd4NUzf3nFaurBJpiXEdb95I30jZKg9+77Fr6zh/WBjgileE3we7zA
	DdG7Wwta+Q3fjRAD+3yiUKINX+O8XQGphVLPvATdJTg6Gi7vyiUIOi3RzytSe8aw6ceRCCaIOl2
	M0gik7N4VqPK0x7rsBsyX1OsnfxrrQQk1nqY9Zw0ts00+yUsNjECFDIiiQ8016anNMfBwrOcnpk
	DSMOUo8E0iEzSEgNBQ2JjtGO+jILT00EGcNdt7OD8TSrafNOzFkz69pw4y0+8MbrmegtjY4BQyr
	QOHqMwtMZF5W5+iMUyXdBcT/JGwR
X-Google-Smtp-Source: AGHT+IEL/GGTDqTzsJKIFZsR9IhN7TE+KMTqtPPeFijRl8wNEY8YSjIfir5ZB/KdT4poEh5hQ/5dEw==
X-Received: by 2002:a17:902:f64d:b0:224:1935:fb7e with SMTP id d9443c01a7336-22b2edeb89fmr9806365ad.24.1744235176822;
        Wed, 09 Apr 2025 14:46:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c992aasm17090015ad.157.2025.04.09.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 07/10] libbpf: Support creating and destroying qdisc
Date: Wed,  9 Apr 2025 14:46:03 -0700
Message-ID: <20250409214606.2000194-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Extend struct bpf_tc_hook with handle, qdisc name and a new attach type,
BPF_TC_QDISC, to allow users to add or remove any qdisc specified in
addition to clsact.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
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


