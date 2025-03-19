Return-Path: <bpf+bounces-54411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF74A69B8D
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9440B171DAB
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9F92206AE;
	Wed, 19 Mar 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrd9xD86"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992921D5BD;
	Wed, 19 Mar 2025 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421261; cv=none; b=jC9y8sPEJuAc8ruCHkr97pAX7FcxtT0MJhoORJTd0sMH0SvgRKc1SZxYv5u7StMXYYKz+w0F++bFMrrNVhdXwsVrKo+Zlj30vfBlUpr53gZtaExN+6uSdSBE9+Wt5WG0JPMFPI7xyONEv/8AcfFJTdyYPczpYC6RA5PfXcO0jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421261; c=relaxed/simple;
	bh=H65Rd6PJNUiZCQZxJba7/R0D+DJJvwvv5AQi47YKh/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vm580HtVItJS5g3TTXHZSdNoG+I5HX4xMbZ+1+oSo6FukUmV1itOVxvy7VcoSYoN0OpgVyeLfp9OEN9lmss3+P5vPqrM879/ftX7E6QAf7YX2ez+rv6tbPhZB0KGlp3bZBpFgZHKZVfhdyRSyZsvBi5nhmWbzBGSjDO/OxepDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrd9xD86; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so738525ad.2;
        Wed, 19 Mar 2025 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421259; x=1743026059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8ejcrrrC6yV6s9uq4HHgS9blRXEVLqg2s5IbclXas8=;
        b=jrd9xD86kX05I0wwKvWLSi39KGb0e06z9h+pBTYJehtNV4wfHua7c5hg6X2vg+uXYD
         9flL8qv8cDa0UvUv7Yi5pGBebA61pT5tGjDN7Fn0Keyze4eIobrT02Duyl1EkFQNeKd1
         TQEGloo4YoUIwPsZXUxKBzhJMGwvjYYyRDsRX8yLDn0RCHBDWOSzkigkv9weXFzfr2AS
         89nAHQoWkUslunTd8253+oo+R5YMBQeMWHZCeBaEZDiO//ZlfUrAeXZL3z6SYIbttlOU
         tKOG0OCk/IeNI3fYIeDyrvEBhZdrI0fTgg8e550Jv5UbG7QJihZTkti/eihBitmOFYcC
         0ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421259; x=1743026059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8ejcrrrC6yV6s9uq4HHgS9blRXEVLqg2s5IbclXas8=;
        b=k6KQp0LGk40XPWR/I0oj5wDiAahUuQWiW39GWDySG5MGw2pDQ/Ly62eVo14NF4Xb/g
         xaUlfR30hDB4ENC/4KkcdSHD4iEV7OdcwUO4dSCZuxE891grzS6oPcTQIK6Osh2rOZ+v
         Otq2JalDR3TZUszgqE0f4pnQ17NIwfpPOBeRc9+QL+H6G0+ExZFYiv8hFcpvEwSVBY6X
         A1CC4n466ogj1LIGF/nDKnskPCRQBTgYxlMljrohZO7AbpljKDQA/w0rKHI//b8k+VLI
         zZOwferU27BeSjOtKFrc26B04dhc23/RVlstvvS8BIvrJl0gT8k2E8XoU5utS3R1aU5f
         DcfA==
X-Gm-Message-State: AOJu0YzC9zQavoDc8xMITQmF6ryWyrvBIj1/UCALnxJ2ctnxUma9H9yy
	2BtzrRPJqHD3fhVqkShChKLVzllJk8mIzXqZ1b3k7sws4khDlkBkd0KOLmKVUf0=
X-Gm-Gg: ASbGncul//RnxpYNmyWdiUNgkyAnC7yoVwoffypf06xbDYWQaznNVWj6L7AhTn2Hir7
	w0RKNw6w2Bdwd2KVfLYI8liKhoTemve+SQWbBWpT5gw7xDUThKRubXMYDSfRvgx0n661mVTem/M
	9X7eYkc10MYfHUOmu/GYH+d8dsfxfv8pjdaRIGjgCtmLud821wPmhWibGGphmk38lULR5HGuabt
	pBI6QkL28ddub7M7Zx2qT0oYI7rIFuB4dO64H32oky35q1ECc1d+RvB+udL8UrJny52Wm0mTv89
	4GhLAWK8puIzxlIl6ko8cgeN12GQLlr4G3k5lMB1zDBOG8M4YHxQ2O82SrwyXvqWzSiXHyjW4E0
	kzzRlFJl5xz4kUKThTRlfzfLGlKwfQw==
X-Google-Smtp-Source: AGHT+IEPplkzUeVG9njCT7k0txZiZVG8WI5gOjKnLJQEle+H+oESowMwmpttkNFdBA81hP/4L6ehXQ==
X-Received: by 2002:a05:6a00:2291:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-7376d631cddmr5939387b3a.11.1742421258538;
        Wed, 19 Mar 2025 14:54:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:18 -0700 (PDT)
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
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 08/11] libbpf: Support creating and destroying qdisc
Date: Wed, 19 Mar 2025 14:53:55 -0700
Message-ID: <20250319215358.2287371-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
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


