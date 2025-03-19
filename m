Return-Path: <bpf+bounces-54414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B3A69BA2
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB8188BBD4
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6122172B;
	Wed, 19 Mar 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGFn9JcW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC40221566;
	Wed, 19 Mar 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421264; cv=none; b=pZJhYDr6uixAH+uk5l47TCKCUyaR15KVtpfkQLkKLJN+MZy9mmv4UIHZQqMorPWFIGShH32NLxykliiUHyvv1832m9WKauCOVsenAYBeOWpSjYi7mmSfIQ4n86IAsCPDp5YYXa5j4xiOBP3UdiYmMtgLI0s181cZvd4EW4JrtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421264; c=relaxed/simple;
	bh=QD9H9mqzgNHpluvagvhymBG621wAxj4V0HMO9BVA+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg3TJDEyjJBJm6l86et7e63GkY6UsrOfRJvvpJFQ6eK7XbX2ajdf6J9/cmsy9CV+XfEnDKpEgZsxQgz22793/qD1Gd/uM4QnMa+Bm4J6UDh8+6jm8JgREB0UGDkb4Xny/Ul8vUDAnOZbou1h6B6gHZ24w/Vn8H61CarPHYc/sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGFn9JcW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so771135ad.1;
        Wed, 19 Mar 2025 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421262; x=1743026062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFOhTWLEYBOHG2TWNS1E2NePPrp1eOvdJzwGarC0dkY=;
        b=FGFn9JcWR1JffOoR8B1g0WiCdyvkv3MjuvQSWGW9yMrDhnxuj9opSsprW1wGwmwMpS
         /Pv+7No78ZxFPkTqtpXKaOgO+FhyQPIa1iUEr29Z4bDHwMXzbX4rxM8zVONC3NUpK9Q7
         uWQRnVqlZy9/Mc4uJB8yjTfyq1bRTSHJvf2eJAApFo92ggtWnZjL5WmtSMXmoftVDW04
         yeipRKdZMxzML1ZqaoNkCX3HcylnIEnYhMMMg3IWug9CJPj93tH/WMFgNPkKm35D6ve4
         KJgV8WEjPtq4Z4YKAnqLPhwNqJZgwoW9IieLmLSXjlyDkciCSymf9rfPX3hlolbaWA3l
         js+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421262; x=1743026062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFOhTWLEYBOHG2TWNS1E2NePPrp1eOvdJzwGarC0dkY=;
        b=ePJRhFQzX+hilaBZFC19jGm3EkWYA4MOnKCa+LIR5W2fynDKczHXCIVk33yqofbLQH
         J/KS3YVK/NhHW1GSmtm5NIBZhojUWpm2x5qikLcxbeGspHESG0rK5F6PLyfkGrBDqjub
         DAGuOzQVvJZobvrFVhvTyq224UeYQJO+nuPJeT3m+JW9h9dLjw6c0fCAXS9/14Q0PF0m
         wXhU0z01JuEJHk6qDgtqSsAR9zdbQGAXcW+pdlg1mztoPOhTc7oIjK1cxYGx7o5sGpfk
         GU7DGdWmYH8dVieIuJo8bTwWzS9bG5s1zNJLxR4N2ky0W+ignjvUNHHvi7BXNbeAt0rP
         TMsw==
X-Gm-Message-State: AOJu0YzsInjQF4/PTiULvBiiWLuKFiPUJ2t2WZoicZQVEh53qsFPZI8o
	LykiuLNhhG1hXJC2EhFDdiP43heD7JSiXsdL2IzIUE29/tdg/HcCD5hHIlC0jJY=
X-Gm-Gg: ASbGncsBVCpXbeXwhSdGMEYU4/SvpMJxHdv4kHpgj0xTXO8g96JT9Vaf1CBGJzG2LcO
	73pJ8YVoAfoNgrAQkRRcGF7MmxUFdSEPH94aSaqmI+55EB2bUR839/2e72H0Zbz4ahiLARxnmdX
	oU//HhDeqGHV+nSF1MDqB+20dkOkD5NJTH8oDCV4s+3R6QPEYKEPeZ432Foc6lmjfuN2P4rmMwA
	1kBSg/WdqFXXg3UTW6zEFRf9kadiQf/EqeC/hTrgf8w/THyjV0FLd4jtpb8oVDueTLYwVtCtPAx
	jHGLKAg1kciXrnOB0XwELl2zwkMnyXW/+Wuj++khuMbCddJ7etBwOSN8OPF5JGaKZhWQN5pPI8l
	Y7NVzYc2MSXZEDeYnAcAE6MjPsgytgw==
X-Google-Smtp-Source: AGHT+IG/zL0ChyNjjHYv8bMWloE+jx26VvglCpJxLBuHntESbJK0TADHU1qhC9gRPwIKp+sDWY10Ug==
X-Received: by 2002:a05:6a00:ac8:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-7377a819993mr1165410b3a.4.1742421262456;
        Wed, 19 Mar 2025 14:54:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 11/11] selftests/bpf: Test attaching bpf qdisc to mq and non root
Date: Wed, 19 Mar 2025 14:53:58 -0700
Message-ID: <20250319215358.2287371-12-ameryhung@gmail.com>
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


