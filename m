Return-Path: <bpf+bounces-55597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A44A833A2
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7841468733
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1332206AC;
	Wed,  9 Apr 2025 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D84GW04r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016621D3E4;
	Wed,  9 Apr 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235183; cv=none; b=L3/BBic0eDqNFZ1zI4fi+7uWqSzRmWotGOaJuxXdnBYYjOrCzkD5lKTCdbk6akzwsTL8wPVa97JltY2Loler1uUo/E8T3niFZyymlM1/gXZfXIG1s/dj0vVxrLmxyQ7lfNP1eZy5/kMGfps17527bl+wGuRD4cDxJ8n+E+fcqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235183; c=relaxed/simple;
	bh=QD9H9mqzgNHpluvagvhymBG621wAxj4V0HMO9BVA+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaTQ4ow4E8/fRdeIWli0xd4KtlVbaa8pNwu5I/zo+NZaVb+MU0sJrn3moWrVUcjXK76eC9770vM3kBRvxDNOfnprx9v4p98UN4Q/0+gUVA2Qm5f+tETY9LwAcoEXKaPtKpV6z6hbHQecr0oLmomLVcxY3qx+sBUmVePgtxqLB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D84GW04r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso1399395ad.2;
        Wed, 09 Apr 2025 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235181; x=1744839981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFOhTWLEYBOHG2TWNS1E2NePPrp1eOvdJzwGarC0dkY=;
        b=D84GW04r4d3L+YPc9mnrqXXzK91j18FEKNm6PhYCw6JNZtfE2xAL2GjMdq0tcxBcZW
         0cPMZqfIOWWLxdpgd5rJjSHr4TJXv0RjvYSrMyaGwiJgfIXMyidp0RGDWB28MWMCkuUR
         M21la5RRU3nDPDhs2/XglIZA8k9uZ4Re7V4mH1hhUeYlt/i1b6o6FJ1ll2h2tPtUiLP5
         E/jK09DZf0E8IkwoGxS77uJBuYDn6oXiVIDFu6CLda5RircVk8Gm/RrTu975ROoXB+AQ
         nZYHau9hvMXMV/T4iiAoyY5rMRGt41/ArGbhXSqpyzpU4yc/KV+ZHloy6mt7RopVJoFu
         e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235181; x=1744839981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFOhTWLEYBOHG2TWNS1E2NePPrp1eOvdJzwGarC0dkY=;
        b=ZcXRCUwu2SAWmlb2p80hHNxSc9shqf6TUQAUUgDulH7VSz8hck1BsekOvHOYKxNGiv
         0tIXX6VZ0nlGEcRcXWl6ok3JXvIFCy5f/FFEZYWtLncFBcJlF9NxA/acLeibFM7JKyrl
         5pWisuSp9fnq8JVFt8F+qWPCDU26asUGQY+CasAR2zcfuGkedsOFRxWbWMLvyPccFvfH
         CoRiQ7q5W+M2jzG8aoiP1Y42GWNb6b4vMJLjoSlGz9mI9J7jJRn/MAhM3sDaZYzdAtHK
         dkinuRqla5aOY+qhx30SnwJyjk3vm7yxqbLSw5Yofj1m9OMvbbD6aBpGgPRp/Q2u9rgn
         2joQ==
X-Gm-Message-State: AOJu0YwtseAqjAoO+23rAV4dPHSJNaTlsbyHyt/oAs/AdmP1bc/pVGvr
	3ScD9TRTbZ+Oql60+H9RrGjkFOfIU7JwHbrO6VniFpnpjlV1PXBTatiGiNIK
X-Gm-Gg: ASbGncsMEDXMiKYsXcH5suMXwc7BBKYZYPmhYHxypeoSQtdZVfxSHzdsEQzxdHrr6mo
	87rltGIC0VEVMbSgQGUqtMXOgjA5g299b593b0uaHJiDkac656900g5tnmbYcDG7DGEPaYE0gyC
	3X4W5hVz+vfaJrdyrhZY5CgfoXCc54vpvJ755TT2G7Ba1GcnR8IzgvLRhl+C8V8lQM5Jz2v19BX
	iQ4rMP4H0zSmUx4qu7QrDF54MXKWlxwryXp8tF5xrniuKLnipgm3j6ctEhYQx7yd0PAIfQ9Xhf0
	Y3GxC/6urV16xXBjJuuv2H9QpUlYDdtv
X-Google-Smtp-Source: AGHT+IEtDG3Vd88wpVCxoyfj0/FmMLLniXi4xn0LJX9/Pedg5luUHrq+/+cX78WvYGUYakrvYG+ceQ==
X-Received: by 2002:a17:903:46cb:b0:211:e812:3948 with SMTP id d9443c01a7336-22b1f5c6c08mr7571575ad.0.1744235180998;
        Wed, 09 Apr 2025 14:46:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccabebsm17077055ad.218.2025.04.09.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 10/10] selftests/bpf: Test attaching bpf qdisc to mq and non root
Date: Wed,  9 Apr 2025 14:46:06 -0700
Message-ID: <20250409214606.2000194-11-ameryhung@gmail.com>
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

Until we are certain that existing classful qdiscs work with bpf qdisc,
make sure we don't allow attaching a bpf qdisc to non root. Meanwhile,
attaching to mq is allowed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 6b0cab55bd2d..3201a962b3dc 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -74,6 +74,7 @@ CONFIG_NET_MPLS_GSO=y
 CONFIG_NET_SCH_BPF=y
 CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_SCH_HTB=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
 CONFIG_NETFILTER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 230d8f935303..c9a54177c84e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -88,6 +88,77 @@ static void test_fq(void)
 	bpf_qdisc_fq__destroy(fq_skel);
 }
 
+static void test_qdisc_attach_to_mq(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_MAKE(1 << 16, 1),
+			    .handle = 0x11 << 16,
+			    .qdisc = "bpf_fifo");
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
+	int err;
+
+	fifo_skel = bpf_qdisc_fifo__open_and_load();
+	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_fifo__destroy(fifo_skel);
+		return;
+	}
+
+	SYS(out, "ip link add veth0 type veth peer veth1");
+	hook.ifindex = if_nametoindex("veth0");
+	SYS(out, "tc qdisc add dev veth0 root handle 1: mq");
+
+	err = bpf_tc_hook_create(&hook);
+	ASSERT_OK(err, "attach qdisc");
+
+	bpf_tc_hook_destroy(&hook);
+
+	SYS(out, "tc qdisc delete dev veth0 root mq");
+out:
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
+static void test_qdisc_attach_to_non_root(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_MAKE(1 << 16, 1),
+			    .handle = 0x11 << 16,
+			    .qdisc = "bpf_fifo");
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
+	int err;
+
+	fifo_skel = bpf_qdisc_fifo__open_and_load();
+	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_fifo__destroy(fifo_skel);
+		return;
+	}
+
+	SYS(out, "tc qdisc add dev lo root handle 1: htb");
+	SYS(out_del_htb, "tc class add dev lo parent 1: classid 1:1 htb rate 75Kbit");
+
+	err = bpf_tc_hook_create(&hook);
+	if (!ASSERT_ERR(err, "attach qdisc"))
+		bpf_tc_hook_destroy(&hook);
+
+out_del_htb:
+	SYS(out, "tc qdisc delete dev lo root htb");
+out:
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	struct netns_obj *netns;
@@ -100,6 +171,10 @@ void test_bpf_qdisc(void)
 		test_fifo();
 	if (test__start_subtest("fq"))
 		test_fq();
+	if (test__start_subtest("attach to mq"))
+		test_qdisc_attach_to_mq();
+	if (test__start_subtest("attach to non root"))
+		test_qdisc_attach_to_non_root();
 
 	netns_free(netns);
 }
-- 
2.47.1


