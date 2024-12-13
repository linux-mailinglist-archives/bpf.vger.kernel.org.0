Return-Path: <bpf+bounces-46956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3D9F1A11
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BA5165963
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AB1F4E4A;
	Fri, 13 Dec 2024 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GONLaLu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9841F4721
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132617; cv=none; b=YsSkpD2Rw8MjpOzB1MoPBn4BXQWajVcM1w0gLNlI1PGDwdbRfTHaPhAZpAQidvId03g9oDk+ZCHPGFnZWp+3h6F7kIsSKE2OeUANwVe+64ZM2WeWm3yIkZrbv+G1JJolkJorFhqR+4+BUz4rSsQUrlUfJXrf/gSrXtI1PoOMQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132617; c=relaxed/simple;
	bh=6fNr52hIlUdxuXN5zxa6X9cf2YP/mL6odLZiCeVZxms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxseOrtjywVVuXImGKYOoNaKDuWgW6Ad/m4Dg+hz5umWKNIcfKITngLEvr9MGbgX72s9if76kOd5XwsCFnfeAGRoSLmi9naRyJmiHcGtDy675LUcig5NzZGWyx7pxP857Sts7aU1x/VrSekIzftgTOh7vR2y8UOKYVoaFCbKQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GONLaLu4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f1b54dc3so312450985a.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132614; x=1734737414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD/XW9sp24gNBySE5fg54poVHx1ltK4R3XGpnG2I6f0=;
        b=GONLaLu42fLNpOejTg+0sAe+bKVDz++4hdF6BTOkUekwyle7PalHFmhbTOboIgzMaF
         ZfNhrCrCB0wilKcCsCXtJ6GFTGFtFThH1Y+kvlVsuZ//+ot+k7uB4nC9PqhRSVMqGRWr
         RHEwRsooS3rBaWzasy2UhQw4VkMn7VMgXpyt/K5xLR9C65pciROJJvLGAm9KQ1TjFoHU
         Zi3UWnVDPIreG+k6I4fmPE0Tgc+KGNqd7DjXTCfpJEgNu1h5AFYFsz4p0s4zHZmYRUUJ
         kNhFFMPGV0s9KX2po3meG/vYCQYHYUlJXej0I8tEGE7AHE/U5eVd71uanumCYRF8pniC
         gUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132614; x=1734737414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD/XW9sp24gNBySE5fg54poVHx1ltK4R3XGpnG2I6f0=;
        b=SLFDxhV2G03Xd+lovlgcMwfQFePhUrG5dXY1ah63+XnPZJzemOqTmX89fDqPDUO/lg
         1kJw3KsWteF4Hz1zmRl3Lw8VMqEL8z8Mtdhpjp7TSo5GjtKhC3OmfJyOjsX6ZZuHQdbH
         5ePuMmlaMtBPkVMFw0i2va4F/PwLuGPUjHXbd//BJNnNx6uTKYoFUZh9SpIEYZ6qQNJ2
         D3ciPUfbkE3wIqOJ7lZMikl4ixs6GZqYLIaWbM3ygx7NBeHhRjZATAcX7UtE0IXi716f
         CsYR/Nzf7mG+upJKM09v58VsCNTEIefBXFwD50IRACJUgiRbfxm2vrpKJhQ3agUsT6Ow
         KiMw==
X-Gm-Message-State: AOJu0YxoMxEkt9aOccLWIruBbsq09eMz/EcpgdrxGLGvJIKZzZE8R/fM
	mg49Bu8w3RTJ7R+nkJ9U3Wk1iBHEwNHsV7Natr0eFYsrzL10D5lSs8oVa0rJB5w=
X-Gm-Gg: ASbGncsXc1YTmtzM3x/PCbALYifHlGGfRvwcHrAMBbG3V/s0oHFaQeNdCXh2tF0MNk8
	P/2Eb6tpoPxHTHQY1L5Nq0eIpUNgDc+TRrUI60+ZJMAAtn5U6evJp+E9iMihbBYhn/1fE4Oby2w
	i27HRaHerl9Mn8O8IUaMDPHY+AFlZmA7oT8UxBUxRNvAQkRwB0lhyyj8dcbHejZIw98FIHEdaXS
	GX+EiI1lZ75kDRSs3UFsASQUhBBnYdsB159cotf7SiERZTaVWKLoCiVjKbwGpX0qkklxmgpDHUV
X-Google-Smtp-Source: AGHT+IH+TpyKTKM0jmg1lEPLJifd6b/6oH7jA2xJzXnFaRGp+6ziYkg/ksfZuux8T2i799ZjVmcLsg==
X-Received: by 2002:a05:620a:2986:b0:7b6:d4df:2890 with SMTP id af79cd13be357-7b6fbecc8abmr584177785a.4.1734132614104;
        Fri, 13 Dec 2024 15:30:14 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:13 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 11/13] libbpf: Support creating and destroying qdisc
Date: Fri, 13 Dec 2024 23:29:56 +0000
Message-Id: <20241213232958.2388301-12-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
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
index b2ce3a72b11d..b05d95814776 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1268,6 +1268,7 @@ enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
 	BPF_TC_CUSTOM  = 1 << 2,
+	BPF_TC_QDISC   = 1 << 3,
 };
 
 #define BPF_TC_PARENT(a, b) 	\
@@ -1282,9 +1283,11 @@ struct bpf_tc_hook {
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


