Return-Path: <bpf+bounces-50239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B82A24360
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC47A194F
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE51F543C;
	Fri, 31 Jan 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1foTLrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083D1F540E;
	Fri, 31 Jan 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351785; cv=none; b=OWJuz1yjoMNalJ/QBoX6MbufxOvHA8+qTfluc9qoV7lO086SeMAEZLZFnCfs+uApTWn2aAV703DZIVuyTv+AWikZaI6analLPt4GOfEIEgqQzbUWRzyD1FG8xo2TUqC/+A6Wpz1GF2zIrcvUhRQMpRroX3fK0FXifXNCft7zHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351785; c=relaxed/simple;
	bh=mlGlyxbLFEcczK4pQFhxrC/qDivTpB0ocgBa+jCOWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXCt/NDGH9bYDdLaawzTx/JhN3zOi24kKZmI+NqBOOiX9MqsOU90RhoRt7X4mPISPphGrtfUoNizvnNVMap/jOSPEYCNt4cjvbwPKl58E5uv0BTvW0el0M50nGBSqbhmkZvu77LGeYDsmezLDFD5cy2DgG+O5aQ2U5YwHzug4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1foTLrv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso4220383a91.0;
        Fri, 31 Jan 2025 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351782; x=1738956582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZO+JZUveFKqFj0FRWk6w5VCR/pGW5PYXof0XoaAvX4=;
        b=J1foTLrv5PiDCz0XuwNcILhjiEC86Q13xD1UNHrE8rbOc9fDSaApDR3Tciv5zUXKgQ
         2/KqPFlASBQpxQg0uxTtS42QKjDjx9sGPLHhSEzrUpsgETCVEP4vrhSObnbZ/RrS3NWZ
         jlRpPjRgBpFDDGxV7PF5ZbRtqwWcZnX6TgXDS7/gJaGWQ5ZLBbJH/KSixiom1veSNEZ3
         wIWT2sJ9AekqbyU4butpPEU6nlxPfrIM1eFpqCbImDbZ88QmhWlD9VgZavoZUHfnvfuV
         n7Hhbqmt+lOoDPLiGcnD7ur45yIRsqNYNoHUviLc/Hs+lNXBUTpeYrCEjxWNvy2ogH6m
         Wa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351782; x=1738956582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZO+JZUveFKqFj0FRWk6w5VCR/pGW5PYXof0XoaAvX4=;
        b=WexDRgMXYp+FqUILP33quGHKdrzuMzl+jkHdrXO4ChYaK8GWccM6Pp1XTOpmoVQE31
         KWRoFx9VWi7bWGdghPklN9qHEX+CydloWBTMswMXqLcDcuC4CYpK/5JRx7sNkptl2ciq
         kAoicBrSO4egVYjBC3XpL+uWsmyx712eobA+0i+2L7ItEh20VystlJkCYI89OEkLkPDW
         0QisBofNjUrxGPcWpRXUd6gbLuj0e8T82msBgHAIszeASY7Kp63PkTstevbWZd+Eh24g
         7+LHz2xZ6jaxzZrTWSPB49cqoc8TLRNfNmrtdOM+hTdMewhnhKX5Blbt1w0aMTskZJM+
         sq9g==
X-Gm-Message-State: AOJu0YzvISWr0NI07H2Z+kV8FXJCw5A0dIVySfaJvkNyiZ8dD0Ef6MZC
	l1LcsHvOf+wCut3E1YcJQZDez9hrl3d7c0L2geJThk7fkEuZ4igz+B1bXnNQsbI=
X-Gm-Gg: ASbGncuF2C+bsteTD3tfT+IIuQtRYSlmg0QTcIASZompHlOvbhhzqDQYpc+II56mmW0
	AYmqaO4+ZJttV3nwDOnERz2uhBlUE79zhHhahlFNBpt8jfzUA7UY0aHH9qSPogTMfOzE3eqKF75
	f2Npap9mvwmJoS+Eizk6naqPmN1CuixAPNiNyg7Cy7PQPOjnX2I1cO4W4X/J1xuSwGpQjZu3GcP
	SGeb+mijVXYburNqoR9D6WRFTjDJhrrfI9kLnrqa0qbGgqElUEhObqYmB2iV27yPFY8iu3aJgmJ
	0st22uS2K4aKv/w75hnhgdWWKz3wrIDo0iMfoM2pf8rF2qnhAtqJ31bSxM11odQt7Q==
X-Google-Smtp-Source: AGHT+IHzBRo8IJ8uBu2ZAke1h9oI55cpoyun0ISD0Ka/fo3p3Z0VUKxja2HfVfk/GULzuiO+g6OyWg==
X-Received: by 2002:a17:90b:3a0e:b0:2f2:8bdd:cd8b with SMTP id 98e67ed59e1d1-2f83ac7f028mr18265321a91.29.1738351782397;
        Fri, 31 Jan 2025 11:29:42 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:42 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 18/18] selftests/bpf: Test attaching bpf qdisc to mq and non root
Date: Fri, 31 Jan 2025 11:28:57 -0800
Message-ID: <20250131192912.133796-19-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 111 +++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

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
index 7e8e3170e6b6..f3158170edff 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -86,18 +86,125 @@ static void test_fq(void)
 	bpf_qdisc_fq__destroy(fq_skel);
 }
 
+static int netdevsim_write_cmd(const char *path, const char *cmd)
+{
+	FILE *fp;
+
+	fp = fopen(path, "w");
+	if (!ASSERT_OK_PTR(fp, "write_netdevsim_cmd"))
+		return -errno;
+
+	fprintf(fp, cmd);
+	fclose(fp);
+	return 0;
+}
+
+static void test_qdisc_attach_to_mq(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = 0x00010001,
+			    .handle = 0x8000000,
+			    .qdisc = "bpf_fifo");
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
+	int err;
+
+	hook.ifindex = if_nametoindex("eni1np1");
+	if (!ASSERT_NEQ(hook.ifindex, 0, "if_nametoindex"))
+		return;
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
+	ASSERT_OK(system("tc qdisc add dev eni1np1 root handle 1: mq"), "create mq");
+
+	err = bpf_tc_hook_create(&hook);
+	ASSERT_OK(err, "attach qdisc");
+
+	bpf_tc_hook_destroy(&hook);
+
+	ASSERT_OK(system("tc qdisc delete dev eni1np1 root mq"), "delete mq");
+
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
+static void test_qdisc_attach_to_non_root(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = 0x00010001,
+			    .handle = 0x8000000,
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
+	ASSERT_OK(system("tc qdisc add dev lo root handle 1: htb"), "create htb");
+	ASSERT_OK(system("tc class add dev lo parent 1: classid 1:1 htb rate 75Kbit"), "create htb class");
+
+	err = bpf_tc_hook_create(&hook);
+	ASSERT_ERR(err, "attach qdisc");
+
+	bpf_tc_hook_destroy(&hook);
+
+	ASSERT_OK(system("tc qdisc delete dev lo root htb"), "delete htb");
+
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
 void test_bpf_qdisc(void)
 {
+	struct nstoken *nstoken = NULL;
 	struct netns_obj *netns;
+	int err;
 
-	netns = netns_new("bpf_qdisc_ns", true);
+	netns = netns_new("bpf_qdisc_ns", false);
 	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		return;
 
+	err = netdevsim_write_cmd("/sys/bus/netdevsim/new_device", "1 1 4");
+	if (!ASSERT_OK(err, "create netdevsim")) {
+		netns_free(netns);
+		return;
+	}
+
+	ASSERT_OK(system("ip link set eni1np1 netns bpf_qdisc_ns"), "ip link set netdevsim");
+
+	nstoken = open_netns("bpf_qdisc_ns");
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto out;
+
 	if (test__start_subtest("fifo"))
 		test_fifo();
 	if (test__start_subtest("fq"))
 		test_fq();
-
+	if (test__start_subtest("attach to mq"))
+		test_qdisc_attach_to_mq();
+	if (test__start_subtest("attach to non root"))
+		test_qdisc_attach_to_non_root();
+
+out:
+	err = netdevsim_write_cmd("/sys/bus/netdevsim/del_device", "1");
+	ASSERT_OK(err, "delete netdevsim");
 	netns_free(netns);
 }
-- 
2.47.1


