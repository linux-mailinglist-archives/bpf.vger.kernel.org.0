Return-Path: <bpf+bounces-20844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E65844573
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3AF1F2240D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B11D12BF2E;
	Wed, 31 Jan 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="h0RjWr9d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421912BE9D
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720435; cv=none; b=smMXnWZNvOAxq/slA2tpe5dfZF/Rgx+D0/vjuHDBZWO2A998s2PG6TJnKgocogZKAwv4TOPoL786xloHbfZpD9W0xFNOAhMaHaEbMrKVs1bcAjELtzmdNUw554C+iUmYKIPp+IQfmC49ydP9B6tZ1P67NmYg1SHhuTLIXoCGj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720435; c=relaxed/simple;
	bh=7ZI5OiUN/ZoXvxWDcRvjx22ns4EuR9iHRYQgmrHB4IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpqrJpNUmWG0IImFIFPxj/nHw4wJBhRCqKLR8PQsn43Nwd53sBKs0KHg+CIdvbEqX/YjCJ4FAm3k+bTyGvGLYy6CBvwcn2K7jUMuJpknlprEpwY0B9sI9B4QwWT5g+Hwe6UiN+7tEi/SXlrC8B06M1qmgn9nF0nWZtBbqfndQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=h0RjWr9d; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8bc1caf00so3359a12.1
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706720431; x=1707325231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orIE+m+kaBV/H9IsTBMWBHTEFbu8zhGx2d0kSUXoqu8=;
        b=h0RjWr9dfjhZuFdKDJNz25gdTlzgCt80nTM+Bi9j3G07C8e6I9j6IeyhXjvohESYq8
         YB6WND2FcdpvPzrKDZsGHjk69VHDJlqT6Dnkp8uSfIUZYw4accilgQOpGr/Ub7Wdq7vy
         MUD5G7FRrjx8VQYdTsSA7vffqBR03gyNZQ5xOzcXqMnGxAr8x6FOBVpBDE4wPqsA+OuJ
         9bSMuh1QZS/km463mMLsjs/j/VB3mdfIfwRhD3BpDvKlDqiTs/77xjQ1ScYVwAWfcK5O
         EbCrKc4blaEEb3/bnJ8RgWAOL8ITcWih0AiqJmW77CY7S7tn97bYTrohEKCzodOqDKcY
         470g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720431; x=1707325231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orIE+m+kaBV/H9IsTBMWBHTEFbu8zhGx2d0kSUXoqu8=;
        b=If7EtSEcYHhdAK6N9z2csfePzeH9XxjapB72e3YqzhvT3aEmmyR3uK8v/aT+Xrcx30
         jCV8sGAtYyYEwxEGaliRukk4kkw5v+FQZzGhVcMSficDbhrri/wnYZlSNd3jCdy98DPT
         2Hdq03leVUGvVijvLxWLrkjtszIOj6kQbNZXJ61rrsL60bNsdiLtvICJ55aTy/4ghMzq
         Q76NTcMXruVtxW/dcmGpVetjU+Jw7QW4+WMq/dV77KSU7BI00rT7h60OA1vrU2qZSTnC
         WVW2iCFK2B5qb5bNG/I/GfJqanWd9iU0RFR77BXGcUXHLSj+10fKlVBKdrmx/zbcsxux
         DDXA==
X-Gm-Message-State: AOJu0Yyieg0acIrjxPCA5ND6/qC1UNGCRnJ6gWXssyU3mtu7un/N7o2W
	KKYCyivNgiSk6ACkpywA8g585qcimpOT5/58jIjHXKt4LLQzoxIrtclz807x3Wk=
X-Google-Smtp-Source: AGHT+IGzlghiahCuiO2Gb18iwEaxiSN5NOIaXDisOmM+Oy6bEyyY3V6lzdiLI2cVqp77/xikhcgvjA==
X-Received: by 2002:a05:6a20:d90d:b0:19c:a0f0:b0ea with SMTP id jd13-20020a056a20d90d00b0019ca0f0b0eamr2345044pzb.19.1706720431221;
        Wed, 31 Jan 2024 09:00:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV3WHrZvGNEERtCOZWRcc7t5hlO9itp98eVqBq0GHz4idVx198YdS//u3gZ0RNU7cTnI3yGXSAWwmf1i0Fge1eB+VS2PMyQthjS8pk2a+F/y2DYfjiarZL8nmVxdV1hKMaYGtW7cat7c3ROMR/Z2o9zQ410XMUBgqFV9Uj6Ab22RLklLHO/BtC80o7l6mIYhQz3GXM8b4GFWfK8cA/Z8oWzKynInT5DlrkkoW16L0z778Na9RSlDZDfZMOQybORv8eIdKSzhftclPG+Abelc7mRDbZ+IB/93W+UFaM27jA9I8G73MEEJcb4HAzrdwPutVRuRs6p/g6hrsxPBLfzEQ38FRXWaOHOcIE6PY8yra3XvpdpWXq80E0Q3jBsw61mGr0zj43qvPNuyblIPibLP4OGr3bc2J1v4sIu8JC1ot6Of4Jhc7tYgMNoSJC5y/msPy9xBOHexYy+rYv7mXsZCoCxiuGfEyZTiLxpQDNJPngGJpkErwas1ro0TRzxl6sPa6xHz4Wp4kRgmKtPj8t6b/ho72R7MboJNl1ZdmanDnWVTQeEwq9ua2Wn554Jcw347YslvJMpL/DzBKpFpCOnUt2xDnn94EG9W3MdZXAg5JyUQgTaaE+az+WV051AYA==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id gu2-20020a056a004e4200b006dde1781800sm10447537pfb.94.2024.01.31.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:00:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org (open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net/sched: report errors with extack
Date: Wed, 31 Jan 2024 08:58:06 -0800
Message-ID: <20240131170019.106122-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working a BPF action, found that the error handling was
limited. The support of external ack was only added to some
but not all actions. 

When an action detects invalid parameters, it should
be adding an external ack to netlink so that the user is
able to diagnose the issue.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/act_bpf.c      | 31 ++++++++++++++++++++++---------
 net/sched/act_connmark.c |  8 ++++++--
 net/sched/act_csum.c     |  8 ++++++--
 net/sched/act_gact.c     | 14 +++++++++++---
 net/sched/act_gate.c     | 15 +++++++++++----
 net/sched/act_ife.c      |  8 ++++++--
 net/sched/act_nat.c      |  9 +++++++--
 net/sched/act_police.c   | 13 ++++++++++---
 net/sched/act_sample.c   |  8 ++++++--
 net/sched/act_simple.c   |  9 +++++++--
 net/sched/act_skbedit.c  | 13 ++++++++++---
 net/sched/act_skbmod.c   |  9 +++++++--
 net/sched/act_vlan.c     |  8 ++++++--
 13 files changed, 115 insertions(+), 38 deletions(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 6cfee6658103..f8a03d3bbf20 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -184,7 +184,8 @@ static const struct nla_policy act_bpf_policy[TCA_ACT_BPF_MAX + 1] = {
 				    .len = sizeof(struct sock_filter) * BPF_MAXINSNS },
 };
 
-static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
+static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg,
+				 struct netlink_ext_ack *extack)
 {
 	struct sock_filter *bpf_ops;
 	struct sock_fprog_kern fprog_tmp;
@@ -193,12 +194,16 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	int ret;
 
 	bpf_num_ops = nla_get_u16(tb[TCA_ACT_BPF_OPS_LEN]);
-	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0)
+	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid number of BPF instructions");
 		return -EINVAL;
+	}
 
 	bpf_size = bpf_num_ops * sizeof(*bpf_ops);
-	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS]))
+	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS])) {
+		NL_SET_ERR_MSG_MOD(extack, "BPF instruction size");
 		return -EINVAL;
+	}
 
 	bpf_ops = kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_KERNEL);
 	if (bpf_ops == NULL)
@@ -221,7 +226,8 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	return 0;
 }
 
-static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
+static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg,
+				 struct netlink_ext_ack *extack)
 {
 	struct bpf_prog *fp;
 	char *name = NULL;
@@ -230,8 +236,10 @@ static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	bpf_fd = nla_get_u32(tb[TCA_ACT_BPF_FD]);
 
 	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_SCHED_ACT);
-	if (IS_ERR(fp))
+	if (IS_ERR(fp)) {
+		NL_SET_ERR_MSG_MOD(extack, "BPF program type mismatch");
 		return PTR_ERR(fp);
+	}
 
 	if (tb[TCA_ACT_BPF_NAME]) {
 		name = nla_memdup(tb[TCA_ACT_BPF_NAME], GFP_KERNEL);
@@ -292,16 +300,20 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
 	int ret, res = 0;
 	u32 index;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Bpf requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	ret = nla_parse_nested_deprecated(tb, TCA_ACT_BPF_MAX, nla,
 					  act_bpf_policy, NULL);
 	if (ret < 0)
 		return ret;
 
-	if (!tb[TCA_ACT_BPF_PARMS])
+	if (!tb[TCA_ACT_BPF_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required bpf parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
 	index = parm->index;
@@ -336,14 +348,15 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
 	is_ebpf = tb[TCA_ACT_BPF_FD];
 
 	if (is_bpf == is_ebpf) {
+		NL_SET_ERR_MSG_MOD(extack, "Can not specify both BPF fd and ops");
 		ret = -EINVAL;
 		goto put_chain;
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
 
-	ret = is_bpf ? tcf_bpf_init_from_ops(tb, &cfg) :
-		       tcf_bpf_init_from_efd(tb, &cfg);
+	ret = is_bpf ? tcf_bpf_init_from_ops(tb, &cfg, extack) :
+		       tcf_bpf_init_from_efd(tb, &cfg, extack);
 	if (ret < 0)
 		goto put_chain;
 
diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index f8762756657d..0964d10dfc04 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -110,16 +110,20 @@ static int tcf_connmark_init(struct net *net, struct nlattr *nla,
 	int ret = 0, err;
 	u32 index;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Connmark requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	ret = nla_parse_nested_deprecated(tb, TCA_CONNMARK_MAX, nla,
 					  connmark_policy, NULL);
 	if (ret < 0)
 		return ret;
 
-	if (!tb[TCA_CONNMARK_PARMS])
+	if (!tb[TCA_CONNMARK_PARMS]) {
+		NL_SET_ERR_MSG(extack, "Missing required connmark parameters");
 		return -EINVAL;
+	}
 
 	nparms = kzalloc(sizeof(*nparms), GFP_KERNEL);
 	if (!nparms)
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 7f8b1f2f2ed9..7c7f74e37528 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -55,16 +55,20 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 	int ret = 0, err;
 	u32 index;
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Checksum requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_CSUM_MAX, nla, csum_policy,
 					  NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_CSUM_PARMS] == NULL)
+	if (!tb[TCA_CSUM_PARMS]) {
+		NL_SET_ERR_MSG(extack, "Missing required checksum parameters");
 		return -EINVAL;
+	}
 	parm = nla_data(tb[TCA_CSUM_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 4af3b7ec249f..5d04bcd5115e 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -68,16 +68,21 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 	struct tc_gact_p *p_parm = NULL;
 #endif
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG(extack, "Gact requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_GACT_MAX, nla, gact_policy,
 					  NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_GACT_PARMS] == NULL)
+	if (!tb[TCA_GACT_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required gact parameters");
 		return -EINVAL;
+	}
+
 	parm = nla_data(tb[TCA_GACT_PARMS]);
 	index = parm->index;
 
@@ -87,8 +92,11 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 #else
 	if (tb[TCA_GACT_PROB]) {
 		p_parm = nla_data(tb[TCA_GACT_PROB]);
-		if (p_parm->ptype >= MAX_RAND)
+		if (p_parm->ptype >= MAX_RAND) {
+			NL_SET_ERR_MSG(extack, "Invalid ptype in gact prob");
 			return -EINVAL;
+		}
+
 		if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c681cd011afd..c9e32822938c 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -239,8 +239,10 @@ static int parse_gate_list(struct nlattr *list_attr,
 	int err, rem;
 	int i = 0;
 
-	if (!list_attr)
+	if (!list_attr) {
+		NL_SET_ERR_MSG(extack, "Gate missing attributes");
 		return -EINVAL;
+	}
 
 	nla_for_each_nested(n, list_attr, rem) {
 		if (nla_type(n) != TCA_GATE_ONE_ENTRY) {
@@ -317,15 +319,19 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 	ktime_t start;
 	u32 index;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Gate requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested(tb, TCA_GATE_MAX, nla, gate_policy, extack);
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_GATE_PARMS])
+	if (!tb[TCA_GATE_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required gate parameters");
 		return -EINVAL;
+	}
 
 	if (tb[TCA_GATE_CLOCKID]) {
 		clockid = nla_get_s32(tb[TCA_GATE_CLOCKID]);
@@ -343,7 +349,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			tk_offset = TK_OFFS_TAI;
 			break;
 		default:
-			NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
+			NL_SET_ERR_MSG_MOD(extack, "Invalid 'clockid'");
 			return -EINVAL;
 		}
 	}
@@ -409,6 +415,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			cycle = ktime_add_ns(cycle, entry->interval);
 		cycletime = cycle;
 		if (!cycletime) {
+			NL_SET_ERR_MSG_MOD(extack, "cycle time is zero");
 			err = -EINVAL;
 			goto chain_put;
 		}
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 0e867d13beb5..85a58cfb23f3 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -508,8 +508,10 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_IFE_PARMS])
+	if (!tb[TCA_IFE_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required ife parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_IFE_PARMS]);
 
@@ -517,8 +519,10 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	 * they cannot run as the same time. Check on all other values which
 	 * are not supported right now.
 	 */
-	if (parm->flags & ~IFE_ENCODE)
+	if (parm->flags & ~IFE_ENCODE) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid ife flag parameter");
 		return -EINVAL;
+	}
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index a180e724634e..a990d0c626cd 100644
--- a/net/sched/act_nat.c
+++ b/net/sched/act_nat.c
@@ -46,16 +46,21 @@ static int tcf_nat_init(struct net *net, struct nlattr *nla, struct nlattr *est,
 	struct tcf_nat *p;
 	u32 index;
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Nat action requires attributes");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_NAT_MAX, nla, nat_policy,
 					  NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_NAT_PARMS] == NULL)
+	if (!tb[TCA_NAT_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Nat action parameters missing");
 		return -EINVAL;
+	}
+
 	parm = nla_data(tb[TCA_NAT_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index e119b4a3db9f..3eb41233257b 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -56,19 +56,26 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 	u64 rate64, prate64;
 	u64 pps, ppsburst;
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Police requires attributes");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_POLICE_MAX, nla,
 					  police_policy, NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_POLICE_TBF] == NULL)
+	if (!tb[TCA_POLICE_TBF]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required police action parameters");
 		return -EINVAL;
+	}
+
 	size = nla_len(tb[TCA_POLICE_TBF]);
-	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
+	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid size for police action parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_POLICE_TBF]);
 	index = parm->index;
diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index c5c61efe6db4..2442e001d92e 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -49,15 +49,19 @@ static int tcf_sample_init(struct net *net, struct nlattr *nla,
 	bool exists = false;
 	int ret, err;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Sample requires attributes to be passed");
 		return -EINVAL;
+	}
 	ret = nla_parse_nested_deprecated(tb, TCA_SAMPLE_MAX, nla,
 					  sample_policy, NULL);
 	if (ret < 0)
 		return ret;
 
-	if (!tb[TCA_SAMPLE_PARMS])
+	if (!tb[TCA_SAMPLE_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required sample action parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_SAMPLE_PARMS]);
 	index = parm->index;
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index 0a3e92888295..02b8e42c1bdd 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -100,16 +100,20 @@ static int tcf_simp_init(struct net *net, struct nlattr *nla,
 	int ret = 0, err;
 	u32 index;
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Sample requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_DEF_MAX, nla, simple_policy,
 					  NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_DEF_PARMS] == NULL)
+	if (!tb[TCA_DEF_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required sample action parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_DEF_PARMS]);
 	index = parm->index;
@@ -121,6 +125,7 @@ static int tcf_simp_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (tb[TCA_DEF_DATA] == NULL) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing simple action default data");
 		if (exists)
 			tcf_idr_release(*a, bind);
 		else
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 754f78b35bb8..671ca64a2c33 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -133,16 +133,20 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	int ret = 0, err;
 	u32 index;
 
-	if (nla == NULL)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Skbedit requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_SKBEDIT_MAX, nla,
 					  skbedit_policy, NULL);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_SKBEDIT_PARMS] == NULL)
+	if (!tb[TCA_SKBEDIT_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required skbedit parameters");
 		return -EINVAL;
+	}
 
 	if (tb[TCA_SKBEDIT_PRIORITY] != NULL) {
 		flags |= SKBEDIT_F_PRIORITY;
@@ -161,8 +165,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 
 	if (tb[TCA_SKBEDIT_PTYPE] != NULL) {
 		ptype = nla_data(tb[TCA_SKBEDIT_PTYPE]);
-		if (!skb_pkt_type_ok(*ptype))
+		if (!skb_pkt_type_ok(*ptype)) {
+			NL_SET_ERR_MSG_MOD(extack, "ptype is not a valid");
 			return -EINVAL;
+		}
 		flags |= SKBEDIT_F_PTYPE;
 	}
 
@@ -212,6 +218,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!flags) {
+		NL_SET_ERR_MSG_MOD(extack, "No skbedit action flag");
 		if (exists)
 			tcf_idr_release(*a, bind);
 		else
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index bcb673ab0008..c80828cdeb69 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -119,16 +119,20 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 	u16 eth_type = 0;
 	int ret = 0, err;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Skbmod requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_SKBMOD_MAX, nla,
 					  skbmod_policy, NULL);
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_SKBMOD_PARMS])
+	if (!tb[TCA_SKBMOD_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required skbmod parameters");
 		return -EINVAL;
+	}
 
 	if (tb[TCA_SKBMOD_DMAC]) {
 		daddr = nla_data(tb[TCA_SKBMOD_DMAC]);
@@ -160,6 +164,7 @@ static int tcf_skbmod_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!lflags) {
+		NL_SET_ERR_MSG_MOD(extack, "No skbmod action flag");
 		if (exists)
 			tcf_idr_release(*a, bind);
 		else
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 836183011a7c..b468a4c8a904 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -134,16 +134,20 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 	int ret = 0, err;
 	u32 index;
 
-	if (!nla)
+	if (!nla) {
+		NL_SET_ERR_MSG_MOD(extack, "Vlan requires attributes to be passed");
 		return -EINVAL;
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_VLAN_MAX, nla, vlan_policy,
 					  NULL);
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_VLAN_PARMS])
+	if (!tb[TCA_VLAN_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required vlan action parameters");
 		return -EINVAL;
+	}
 	parm = nla_data(tb[TCA_VLAN_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
-- 
2.43.0


