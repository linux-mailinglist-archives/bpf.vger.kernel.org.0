Return-Path: <bpf+bounces-21246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70684A2D6
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DB4289D7F
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC8482FE;
	Mon,  5 Feb 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="D/2uKzWc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B24879E
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159362; cv=none; b=GmizM0D+NAvorHVd6rNA2Cjl44X4ps70J9j47lNRCfcqrxOnRDM4yc14wPghW0UH2svT8Ju3ZLktbEp1NQIsqDQUDjHyoQYI95N1ksr/gdSo4FF6/QfeI+XkblcMauwq6nuAJwkKWnwCdvqLn2f4ZmLqS2IBRoLAf1ThZ/R5Su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159362; c=relaxed/simple;
	bh=5B0FB3Yqe3JCOmDsTK5ikQ+ZtqetaPyUN+UgBS/jCnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOjCWiSh0FUY1riUSNlq9/4mKwO3fqVjs3slrWZQfwfUpQSOyzVqCI9oTNf8rBNsWch9QI4fZ+NBi8XRahYBivPeNV399dJBaNKq9fXDaIOS7yNCA36ZMO8aZnFB0xfcVlYJOA+rNtpF9SZT68pqWMgVZut6KF+u0hExE+faI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=D/2uKzWc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d932f6ccfaso35576585ad.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707159357; x=1707764157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=om2XWt3OTF4SoofjWJh3uzvdBwIQW++XooH1Pcka56M=;
        b=D/2uKzWc/EVDamP9Rr4O+2JwxpSEt5VQ8MEswb2W/lItMmsBHkCSF3VBfu0T7eAgMw
         GvxEswv62KNNwyMP/gdsgb/pv/7NbvIHibMm0pbO0NskedCVsXfrx8Zb3qEeU1C6vGK6
         eqyB99yW6tktHIT5uuz7bV8lVgtCQ8LOy3XgO1hKCX4H3Pis+2TcYJeXwVcCHNs5oLLj
         nqKqTiS4UCQThNnXZhWltnHzpPkgc/pYg1F8H/hKZNknbTbADPWpF/oePJbNNpTQEpqr
         JT1uM9FJlQq9VDeSgq1cOTUJy7xD+OEbdkaBbCVV8Dp2Qo8howsBezEZtXfABAh96RB1
         Gfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159357; x=1707764157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om2XWt3OTF4SoofjWJh3uzvdBwIQW++XooH1Pcka56M=;
        b=VwJKJXUlMXCia+ts23xYF50Ox1pSAzSEX1qKrtP7RFrQ3fHfSK7ep0pS2cpBheSzvm
         4Wrt2QawdAABqSX0N2UBasrBhwU79h7/heDTHgLHhwo72MFVRMGjTj/Yev8/KbmSDrCF
         Sj9HVIr5YxNUkoyUj/hdIvFs9UdNQUdFgbl5Iki0hLUXPKRGNKC2MsogYIYQJNzZZJI7
         5rWCwAocduXY2CWFYElFVGDfaUpsowWHJZhsIKL7BVVKAOAhLG5RMybMviVcpnQNxfxN
         VD2Qa5nqCahNGSRjfLvKPUblAX/joxQDJQJeJp5jWXQcZzm+do4NV9v9hrv2NMq8bQyi
         ewbw==
X-Gm-Message-State: AOJu0Yx/YofYMSRJSGCTqm/gBoSb1to2qnxfkOWGBwNvoSWYKys7zx1R
	y9XVLacDuQUiuLeKgA/X307Ucsj9gKWSFurWR6oe3itI4qC//rsUjqnb0AgAuEY=
X-Google-Smtp-Source: AGHT+IF6FG32nghyrf67pHBQssF2m6uj0Jw1CXEGysLpajV+urcs26RLf1HZWOcBYxT9YgVbl9Ks0Q==
X-Received: by 2002:a17:902:7802:b0:1d9:98fc:a950 with SMTP id p2-20020a170902780200b001d998fca950mr416450pll.6.1707159356630;
        Mon, 05 Feb 2024 10:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXonApRMJ0WsZUL2H5ErEG6Y9EYBiIaK9L3RqxlM02JbEaZPFCcPC1SsX9MzMgfo8B6YPMrVN9ztgF9Jduz4wW0ced2hPuJQRzn/z+fqu71NFInMLUPwfntxodbPK6be3Cszv7svEDAH7jKf886MR+/mb6MkBS0x40BEdvOFQMJ7sRpGYhqq+HkiROIkbJptnDkt5YBPHVBBHyBS2NDQ4eMquXu9yTeszqbJxAV1+M5oIqb+XxZLWUi+ue+r40csgRyLBvdwul+10qswJwy19BUDqI70QPTdUeJ3i1TpQDxxupTG8G6gMpbjVO1UE4AP5Z4xhy2k3hRNE7k9EtLaiaBRGaKL7t6BItekHx65MSGNmIojA1YmnVTg8y58FLaDR3b1yB58R/CdnR8gY4pJ2v7FH5ix4gXd0vqqV12f0i5F5GSgW9/J+R0zi65j8RXBBKnRmksvcN/DKK4p+SwlbTUd7dtkU7UrmWRdliKAZ6K5AO42VKDeyvqMX3/Mx1GzEIun2PLTFxO/gn89QUKgGm95PzMUmmRLagHjI906RlGRge/pJ1/D/r8570peFTPVwVNqSX2SgUvj06JsmuyJ5BI8YiQsY+xbwdNc4obicTWS/Li+0PLamOAvRbheA==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id km4-20020a17090327c400b001d94a245f3fsm206075plb.16.2024.02.05.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:55:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
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
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net/sched: actions report errors with extack
Date: Mon,  5 Feb 2024 10:52:40 -0800
Message-ID: <20240205185537.216873-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an action detects invalid parameters, it should
be adding an external ack to netlink so that the user is
able to diagnose the issue.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
v2 - use NL_REQ_ATTR_CHECK()

 net/sched/act_bpf.c      | 32 +++++++++++++++++++++++---------
 net/sched/act_connmark.c |  8 ++++++--
 net/sched/act_csum.c     |  9 +++++++--
 net/sched/act_ct.c       |  5 +++--
 net/sched/act_ctinfo.c   |  6 +++---
 net/sched/act_gact.c     | 14 +++++++++++---
 net/sched/act_gate.c     | 15 +++++++++++----
 net/sched/act_ife.c      |  8 ++++++--
 net/sched/act_mirred.c   |  6 ++++--
 net/sched/act_nat.c      |  9 +++++++--
 net/sched/act_police.c   | 13 ++++++++++---
 net/sched/act_sample.c   |  8 ++++++--
 net/sched/act_simple.c   | 11 ++++++++---
 net/sched/act_skbedit.c  | 17 ++++++++++++-----
 net/sched/act_skbmod.c   |  9 +++++++--
 net/sched/act_vlan.c     |  8 ++++++--
 16 files changed, 130 insertions(+), 48 deletions(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc..4dc6f27a4809 100644
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
@@ -193,12 +194,17 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	int ret;
 
 	bpf_num_ops = nla_get_u16(tb[TCA_ACT_BPF_OPS_LEN]);
-	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0)
+	if (bpf_num_ops	> BPF_MAXINSNS || bpf_num_ops == 0) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Invalid number of BPF instructions %u", bpf_num_ops);
 		return -EINVAL;
+	}
 
 	bpf_size = bpf_num_ops * sizeof(*bpf_ops);
-	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS]))
+	if (bpf_size != nla_len(tb[TCA_ACT_BPF_OPS])) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "BPF instruction size %u", bpf_size);
 		return -EINVAL;
+	}
 
 	bpf_ops = kmemdup(nla_data(tb[TCA_ACT_BPF_OPS]), bpf_size, GFP_KERNEL);
 	if (bpf_ops == NULL)
@@ -221,7 +227,8 @@ static int tcf_bpf_init_from_ops(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	return 0;
 }
 
-static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
+static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg,
+				 struct netlink_ext_ack *extack)
 {
 	struct bpf_prog *fp;
 	char *name = NULL;
@@ -230,8 +237,10 @@ static int tcf_bpf_init_from_efd(struct nlattr **tb, struct tcf_bpf_cfg *cfg)
 	bpf_fd = nla_get_u32(tb[TCA_ACT_BPF_FD]);
 
 	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_SCHED_ACT);
-	if (IS_ERR(fp))
+	if (IS_ERR(fp)) {
+		NL_SET_ERR_MSG_MOD(extack, "BPF program type mismatch");
 		return PTR_ERR(fp);
+	}
 
 	if (tb[TCA_ACT_BPF_NAME]) {
 		name = nla_memdup(tb[TCA_ACT_BPF_NAME], GFP_KERNEL);
@@ -292,16 +301,20 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_ACT_BPF_PARMS]);
 	index = parm->index;
@@ -336,14 +349,15 @@ static int tcf_bpf_init(struct net *net, struct nlattr *nla,
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
index 0fce631e7c91..00c7e52d91ca 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CONNMARK_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
+	}
 
 	nparms = kzalloc(sizeof(*nparms), GFP_KERNEL);
 	if (!nparms)
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 5cc8e407e791..b83e6d5f10ee 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -55,16 +55,21 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CSUM_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
+	}
+
 	parm = nla_data(tb[TCA_CSUM_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index baac083fd8f1..7984f9f6ea2c 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1329,10 +1329,11 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_CT_PARMS]) {
-		NL_SET_ERR_MSG_MOD(extack, "Missing required ct parameters");
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CT_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
 	}
+
 	parm = nla_data(tb[TCA_CT_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 5dd41a012110..dde047b6b839 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -178,11 +178,11 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_CTINFO_ACT]) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Missing required TCA_CTINFO_ACT attribute");
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_CTINFO_ACT)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
 	}
+
 	actparm = nla_data(tb[TCA_CTINFO_ACT]);
 
 	/* do some basic validation here before dynamically allocating things */
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e949280eb800..42c6b8d9002d 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_GACT_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
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
index 1dd74125398a..3e8056a2c304 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_GATE_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
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
index 107c6d83dc5c..b22881363029 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -508,8 +508,10 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_IFE_PARMS])
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_IFE_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
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
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d90..f1bdd19e0bbb 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -124,10 +124,12 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 					  mirred_policy, extack);
 	if (ret < 0)
 		return ret;
-	if (!tb[TCA_MIRRED_PARMS]) {
-		NL_SET_ERR_MSG_MOD(extack, "Missing required mirred parameters");
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_MIRRED_PARMS)) {
+		NL_SET_ERR_MSG(extack, "Missing required attribute");
 		return -EINVAL;
 	}
+
 	parm = nla_data(tb[TCA_MIRRED_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
index d541f553805f..42019977514e 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_NAT_PARMS)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required NAT parameters");
 		return -EINVAL;
+	}
+
 	parm = nla_data(tb[TCA_NAT_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 8555125ed34d..17708fe32ad1 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_POLICE_TBF)) {
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
index a69b53d54039..0492df144b39 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SAMPLE_PARMS)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required sample action parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_SAMPLE_PARMS]);
 	index = parm->index;
diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index f3abe0545989..0c56c8c9ef44 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_DEF_PARMS)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required sample action parameters");
 		return -EINVAL;
+	}
 
 	parm = nla_data(tb[TCA_DEF_PARMS]);
 	index = parm->index;
@@ -120,7 +124,8 @@ static int tcf_simp_init(struct net *net, struct nlattr *nla,
 	if (exists && bind)
 		return ACT_P_BOUND;
 
-	if (tb[TCA_DEF_DATA] == NULL) {
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_DEF_DATA)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing simple action default data");
 		if (exists)
 			tcf_idr_release(*a, bind);
 		else
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 1f1d9ce3e968..e9c4f2befb8b 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SKBEDIT_PARMS)) {
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
 
@@ -182,8 +188,8 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		if (*pure_flags & SKBEDIT_F_TXQ_SKBHASH) {
 			u16 *queue_mapping_max;
 
-			if (!tb[TCA_SKBEDIT_QUEUE_MAPPING] ||
-			    !tb[TCA_SKBEDIT_QUEUE_MAPPING_MAX]) {
+			if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_SKBEDIT_QUEUE_MAPPING) ||
+			    NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_SKBEDIT_QUEUE_MAPPING_MAX)) {
 				NL_SET_ERR_MSG_MOD(extack, "Missing required range of queue_mapping.");
 				return -EINVAL;
 			}
@@ -212,6 +218,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 		return ACT_P_BOUND;
 
 	if (!flags) {
+		NL_SET_ERR_MSG_MOD(extack, "No skbedit action flag");
 		if (exists)
 			tcf_idr_release(*a, bind);
 		else
diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index 39945b139c48..19b35666f357 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_SKBMOD_PARMS)) {
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
index 22f4b1e8ade9..414129539c4a 100644
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
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_VLAN_PARMS)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing required vlan action parameters");
 		return -EINVAL;
+	}
 	parm = nla_data(tb[TCA_VLAN_PARMS]);
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
-- 
2.43.0


