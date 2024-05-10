Return-Path: <bpf+bounces-29535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A38C2A99
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3321C217CE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EED74407;
	Fri, 10 May 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyZqvE8m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D76F53E13;
	Fri, 10 May 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369067; cv=none; b=OxS0goo130ukHOd/iIZUJwEcQ67u+4LD3+S6epoEY1JVbOZyjq7LFmKLwWJEkFrpHAdS2OsD78YqR7WlJNAuSPjeem/qGODuJpHBHBa1iflqzeT9Tq9LqXHD6EH4mfQgKqHvJj5wS5mUzBy2F+jQxSWOmhX33lWSz+rnGK9knIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369067; c=relaxed/simple;
	bh=Sg/pCugTRPuGlOYqJCAn9Ck8okRhHNs6C/2UjYppjhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkk9JwapuSogi3sS/M3pw5Mq3irHqy3Xd7EHbrrO/qnuiNSQSS1son3W2vtuJfVufJWUAe0PM2s9Ka0X5KNk7rfPCZVacNXMj2w893OvelKbjmQYW98KfvhHo0GCPYUCNxEV9ZvQvbr1sRbEgutM7RFLzHtcv+jrlXIR5Xc/yMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyZqvE8m; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47ef5a51829so813086137.2;
        Fri, 10 May 2024 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369064; x=1715973864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie8ysy/g3R/YaoIh+WlTihyZrX28jNlDoRj210xQ3/w=;
        b=jyZqvE8mqV1YPeZrqy3B/I4cjvaXeF2occFBNnbJhll1Jzjg0l0se8WJlDarxvKLIt
         MzCX+VYFiltIjip3myA4nIZg9kk+YpMcriGTGeueYO31nGXYMbeimHnhuLvtzHL2uNdh
         +KS5mwjDbEgXZKKqpJ0RCMt0f17+qkRdq74iF8OUSOvcXI56hEWLPCXZrXzsWeRBTvi+
         JS6WK6IeZ24bl38KIZff76iFUIMqBrvHh6tCJH9Z4NvKpbvfUMfPWAD/YIh9wZ+L7mKi
         xFikLn5Is+t/kCs9q0W9/ZBJv+fvRnACshzBRGygtI9zcmRTjb8aMeOqklqSBX3XepP9
         5dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369064; x=1715973864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie8ysy/g3R/YaoIh+WlTihyZrX28jNlDoRj210xQ3/w=;
        b=jwv2rcIZTIYbIBJV2wZX4S/bv+YQzN62FB554IBj+oSzxn1/FsiVwD92Ct3v9+eNYh
         oGkRCR6VC/O+AtJHo6Exz6JSQEcTaAGZNjshTcEMxpzfcc7kHwal29eiQwDFQvIoSOF0
         sk/CF7Xa5YGQhO995wVvdsdOheKh2OkFZRkZrR8Bn0ThfulwRGOl5EHGR9wGA3Qb4ncz
         USlq9U+W2/Kz4eqjGuQSlIN2eKQtKIZlDfiteM1u4IxayUQE+Cpu7pmBjECeyMtbR/g8
         WXkZAS9wiRmG92QVKhkLPN0bM118lUVVGek/WXDFm51y1WNWnTRXcS2wfJlRgopXj9fX
         WaAQ==
X-Gm-Message-State: AOJu0Yw94pn9u9KsYbAjT4r/Xs3LKN43iwjQEztZvJzbITMygEhzCTqO
	eYxCSbc3M29QLwq8p3CNrUPdIm6BYGicbqUtsdABKZ3dhPYaXeje+gplZA==
X-Google-Smtp-Source: AGHT+IGE9+RnmgGdFHRG0ftNAu564MzVV15w4WCa7/TQbCs/npIkKtrhZ8d2fS3eYt0WY7DVBTc09A==
X-Received: by 2002:a05:6102:6ca:b0:47e:f3af:c569 with SMTP id ada2fe7eead31-48077e273b3mr3974508137.21.1715369064371;
        Fri, 10 May 2024 12:24:24 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:24 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 16/20] libbpf: Support creating and destroying qdisc
Date: Fri, 10 May 2024 19:24:08 +0000
Message-Id: <20240510192412.3297104-17-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends support of adding and removing qdiscs beyond clsact
qdisc. In bpf_tc_hook_create() and bpf_tc_hook_destroy(), a user can
first set "attach_point" to BPF_TC_QDISC, and then specify the qdisc
with "qdisc".

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/lib/bpf/libbpf.h  |  5 ++++-
 tools/lib/bpf/netlink.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..2da4bc6f0cc1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1234,6 +1234,7 @@ enum bpf_tc_attach_point {
 	BPF_TC_INGRESS = 1 << 0,
 	BPF_TC_EGRESS  = 1 << 1,
 	BPF_TC_CUSTOM  = 1 << 2,
+	BPF_TC_QDISC   = 1 << 3,
 };
 
 #define BPF_TC_PARENT(a, b) 	\
@@ -1248,9 +1249,11 @@ struct bpf_tc_hook {
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


