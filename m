Return-Path: <bpf+bounces-47480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF99F9AD9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D69B169C04
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9112236E8;
	Fri, 20 Dec 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3VoNXZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A0228C8D;
	Fri, 20 Dec 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724602; cv=none; b=dmcVv2wTpJEs3KQnz15v0j/LLr2d4D//upZWM2IRvip8S+D7aFctOw+0jkcR9JoMTtxwCjfkz9cOIagJGMfwRZoZBdGJTTBXHhH7MEb6dRsL8s+akCi/N2tyCVCQo9pdt6S/Vx9OOeb4jO+W3vAhqu0szz2xUf9Vf+UNG+o6mB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724602; c=relaxed/simple;
	bh=vJ1MpMFR4Axn9se4BBWi3ls8XVfvWLVEF43BdAt4CqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDArOC/5FvTS4nBky3EbUreA8YiMGEn8MZo9tf8qJok+GlwpNHopnUahey7j32jhN6FTR1zqxJpc//ryicbcjsB3Sha6k6CQ+jqMvIDPX79/R7X+scet4SMOnKTCwJMA+E9Dm2DYeCiKw4UI8Ukk6l3TNjqpE0d0g8oKft8ULFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3VoNXZH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc93152edcso1849110a12.0;
        Fri, 20 Dec 2024 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724600; x=1735329400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66ODIwKGv3cNgTZY2u+oon01SX0j/MqOmDaqK5pK014=;
        b=M3VoNXZHJtBX1QCXcnB+Ghmx6gIJXAeHAUw+j84K+v2HJIioKdWIj1oS80O27B/kav
         JV+uw4xNOhTTLuQk6m1/DY87Ea66t0c2YHQxVkgkB4J03i8wU5XPY2TnKtGPvLYqPyxu
         aB5GO9ppjTb/Wy9Z54hVz7JEgXjf7fMkjVBRnnGMf91O4lmkVPRtJCXVqn4LPlSdCpbA
         arqPaIiuzRTCOYl9XRXdAfgmp+A6YBHNWtrgmJZCQu/aUtadtsc5xFou7Gj6SfKyzCxS
         zEck+O3Qb1RIgw9PzDTEELHrCVaP463EUdeHNQ7iXfJNhrUdrk98pXbougK4MqnfVj30
         W7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724600; x=1735329400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66ODIwKGv3cNgTZY2u+oon01SX0j/MqOmDaqK5pK014=;
        b=BYNg0JqDVTp3d6CdITJwfMo4swx0ND/BoD7HwGFNneDpbCzZ5xIFsyG0KwqvKa8psH
         HvJ6ar3JMyYdLAv5OAYosTvDeMcPZDNvi2ppv8ubvOjWNfQDSnPIf8aPw3lZRIkx7WaK
         9QlOgDNqk5zZuAttriUZ76d0SELmmwkC4Jepbq9QXIwAeFAQEUVnih6mHM4bcfC6Z2XB
         i/kOOaVGgocEfvlB3bit5CVMANh2AscXxr3pUU5KYXk28ttv1AWtWK7VzdvhrIKdcHUF
         bbst85/9x8BWHxPYjeR3DfI2uBJkmC1cRo9Ggtbez5IGp/Zj19GhMfzaJcu2xGfAHurQ
         9Zpw==
X-Gm-Message-State: AOJu0YzJBg0+TbUyfexACqmb0Q7qp3tREIdsVMDG8tBjAPx3/0We9L5H
	BKM7UjA8F/VD3FnpjolVEEyK1RlFkil6nom3jtl+mIKUr/g121WvpulwBg==
X-Gm-Gg: ASbGncv+SCiIcEQfzuzRYwljq+g6UWp6HU8E1cvYOGbR3a1Pj2gevP8Ttt9LfWEdlBU
	h8zEOr50fVQsuub+DgnR7tzMUkffvIazaTcwBCXAEtUza6lM6t9Eyhf39TOR4cP/KDYnDoDLaa5
	ZVGDEX6A7DgaOq+xMsmH7zJAgjJMoY9sr/9D4acXD5tlGDl0xPtBbKRZwW8A0xjU4xihv/7ihyy
	GvgglZV2TYSnBR5dH0avQSv8YnIyWL0bFgz5VdPmsY+jwsmanUS3X2K3aoK9AwqFn10+OxntA+8
	TRRMI0R+cIQnGVnKIioRlptqEKoBHpdH
X-Google-Smtp-Source: AGHT+IHwMgVOcaCC2dcfVtrVTCxc3NMxKGgUyzjnWEYCSA+V3qEds1zsUvnnhye8KYcMgIvzv8G2SA==
X-Received: by 2002:a05:6a20:1593:b0:1e1:ad90:dda6 with SMTP id adf61e73a8af0-1e5e1fa249amr6397091637.20.1734724600182;
        Fri, 20 Dec 2024 11:56:40 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:39 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
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
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 12/14] libbpf: Support creating and destroying qdisc
Date: Fri, 20 Dec 2024 11:55:38 -0800
Message-ID: <20241220195619.2022866-13-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index d45807103565..062ed3f273a1 100644
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
2.47.0


