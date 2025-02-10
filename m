Return-Path: <bpf+bounces-51025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9FDA2F5A7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF23A7D19
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C92566DA;
	Mon, 10 Feb 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrgBZ2H9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB5257ACE;
	Mon, 10 Feb 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209450; cv=none; b=QEqwLAesS+m8xBt12JP/2WNYH2BSvgtf9XIfqgPcyJKi5b+DQWpGdLM0kBphctddye76xRzxJUlOmbBlVTB9gCkQ1eDkNyNWZWHekp1xdptNPr0uGJf2efAd2e96ArrhMCLbNlZy+GusX6+Pi5v6l+zwhDdEXgOhyluuL1Q10x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209450; c=relaxed/simple;
	bh=sVVkbk0Gn1THhmgFQQYZXWJ516ceqWV7SjuSKbWsCVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJgQAForLUlK1dmB2jvTmgUx5iJjmg3nTSaq03N+J4+vK3eMsimO5Cn2sUhZo9T9xOqgup6wT0jflmGKGvFeGOvQfRcPC9SHelD3WwlRs6FZXjkBYJ4Rl82AJypKfN7dbRg9qL825povtDnWT5JFwPUuDkRU9p/AeG6/njzcHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrgBZ2H9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so4582396a91.0;
        Mon, 10 Feb 2025 09:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209448; x=1739814248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCot4AmKUdSjbCpz+84y1dF8CcLEygWZ6VcGHROBKi0=;
        b=OrgBZ2H9xgqfRzwspedh5cy7sxDwbimO7B/BppDOsiwahGWgIF92V6TDXQftrymsgZ
         GYuflqUMwIjBBKfLSrsStv/0HCCnLY11o3owE/1D/svRcMQb0jDgu6fZfbgIt9Wim3od
         DcwgBKENGU4Z33EB+eQ8zcy//tStSZc6Jw5W7FEyJ8teXq7FAG1/Ybcl7hgs5/hihG9g
         2RzKMadEI/dN3sLbRTGvWsPrNlFxs4hO+Cljrd7FDQijEKmM1H60XBMmSkrrzQVDJxT8
         WQnlEl0rZEzKSeNfDfpAZRZdO5rMua8qaTcS9n4DXNU6wEw3cWYdvMaecd8tS2u3nOjH
         10Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209448; x=1739814248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCot4AmKUdSjbCpz+84y1dF8CcLEygWZ6VcGHROBKi0=;
        b=CSK6bi4PbXgTgg6eoDwLp76ZgXf5VjwTlcEVkH+syuD+QyBX3Mo4dkGggOOMweIhDi
         qvebENqx5BsON06bw7guk5NUnuT0lZsr//3Z/jwVGW3z6C7qZd/tr71zdouM97QQ0FrX
         U2pKgexMN6p+QodAFLCuK9CtR9TuXsIUsRtHBkEtcJ0m+h32wC50FLuZcz1A4k9eXrJu
         miSPEOo8dZxUjFmD1VIktspvEMhXH0tMZZRCuzK1XVrvI6ZjD5OZ6874NvJBjGiC245F
         PbAddW8k+gROy7ajO3vsnuB1Oo5P1Et+dRVdXne7qTkOFRl712WaqsrSznvy594maexn
         yfxQ==
X-Gm-Message-State: AOJu0YzUkutGR6w+UHYbiW1AD8FWgVuVRdVkKw6fUc79wWvssR0SYFX6
	KF2X18L5JWEPdAcP9Y7Wjcb9fxU2siqC9FxGIpc+7Evf6BhwJh79KvmD6Kul
X-Gm-Gg: ASbGncte6f8VXJ7UFj+raCZUW2VXapUvSkKQaY3UKEImZJfOfK5pWB93Mugqxs9fuEK
	VpmsFXOeDgmocpGFnL4f6/JBpygG8+CHy6r5xr6CdQ3opbqr7J9xIn3ClHDHioRLCl38bCmuTUk
	68Vt6HSH027uwcmOhXHddVu2Gbl9H5XKWBSedXXeEkSz+XbNoZZpZnuhBUBUrxYC7SuiHM6uhjr
	AtOCEBdfhCZElohGCfEI9AH+N/BLovLWga5Nmba6sMBTCwCKgyd6vBDvNM+nWhUfIvy2D4FGd6J
	Lvngi178pHa4qc5L2xUNvlF+/Gw90vzwmLzis1/e0Rr3Udt+ZnMeTxVqXbY7vXqeTA==
X-Google-Smtp-Source: AGHT+IGOQqcef8+uXJOslKW4MqjO0+yfdJIEKy/ckO4RYPSE7YgsLhAZhQKf734vkt/D81RganGRcg==
X-Received: by 2002:a17:90b:350b:b0:2fa:228d:5af3 with SMTP id 98e67ed59e1d1-2fa24271b0bmr24427087a91.15.1739209448573;
        Mon, 10 Feb 2025 09:44:08 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:08 -0800 (PST)
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
	cong.wang@bytedance.com,
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
Subject: [PATCH bpf-next v4 19/19] selftests/bpf: Test attaching bpf qdisc to mq and non root
Date: Mon, 10 Feb 2025 09:43:33 -0800
Message-ID: <20250210174336.2024258-20-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until we are certain that existing classful qdiscs work with bpf qdisc,
make sure we don't allow attaching a bpf qdisc to non root. Meanwhile,
attaching to mq is allowed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
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
index 7e8e3170e6b6..5d4fa5ad40e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -86,6 +86,77 @@ static void test_fq(void)
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
@@ -98,6 +169,10 @@ void test_bpf_qdisc(void)
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


