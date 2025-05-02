Return-Path: <bpf+bounces-57281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14BAA7ABD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11DF986C16
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDE202981;
	Fri,  2 May 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YneE/mpg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449151FAC48;
	Fri,  2 May 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216989; cv=none; b=qKUuaoJWwDXtI2ZAH6HTF1Ows2gb7I8Gg+PzYolUCa1qK9DlN5XNm6w+IDO4nxedcMvAjvTg2VzkXNsRHb2D7U+EXxHBqkskHmYkGwhMjtVvh14eHIZIJtlmyQTTlfHy9ISCZhN7txYk3RIKs8lIiVeNsJfgMPRPbUBmzBs/xoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216989; c=relaxed/simple;
	bh=X61Ua6EZe5L0QNBBUkUeg4TllJS+LDESD8Y9jJa4gvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9nl1oIMye4JFCHDOn1bvWJ/z4H9d8R8aidlfZbn8IrITGq29Iy2RiQTByHpXBwfT5wY9JN6Fg9CV6HEEs5qGI8hYVi2Uo7DSYv0k3uyR63Pb5gU6e/qs6z7mjEZp/6LWRFF5psHiI+GToebL/MOoaHdsc2k+2erkatEpS+yS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YneE/mpg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b12b984e791so2249020a12.2;
        Fri, 02 May 2025 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216987; x=1746821787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fHvk6xtQGQz4m+ENUd3MvegHHI6KpybbbLU1TVCv9c=;
        b=YneE/mpgIXdeatqs0IWFgN5v/QN0PW0Fr2Y5vlU86tjCXReiNbP7DyErYpU9xMGJt0
         5T+8TWZXLylCnoBZSMuVLtRUumZMKjF3urUtvTpMO60uEwfEU4l5wbchrt0HrrJqjFuD
         wa37fJmKtwFZgvWxAPvBhmn+ENTvrcAf5ZUHuzMvTH0eSOskvo39ziguYmWzcFwE9AuJ
         Qq0Ihn/2nuZ2eZ+GUKV7MitBYbqRetTJ8Kv86gWWiZg/x4A9RX+6nnfBLBiniW4wy20E
         mWivPl+d1HTJYF+JiG+lIj11XEROu+xonyyJZm04ogwxMmtD7sGLwhru0D/FyikLMZoI
         OQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216987; x=1746821787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fHvk6xtQGQz4m+ENUd3MvegHHI6KpybbbLU1TVCv9c=;
        b=kwKudav5iUacYJQ4h3Sn0VEbwT5Hg1zHSXu47sJfMNhCgrLbOMap1yHKCCJL8Ciplo
         8SHz9IAyf/lrAuvAgLfOoroTExCR5xEZXB8Igq2mSxj9aTGcSTXgiBr9xIe7ibDd2CgR
         AH6YXW7gTTKoN+s6vffzIhsn+gat30MTshDGGCLVckuSCodiVZ48qetXvHMWmi0PmQPd
         cm5hFNnBdKjhlhOqva3I5m80T+Rx6sgmZC4Yo1ClL3eyaRvyqzsq+xiu5dr3ZqdHPpuy
         1doC8gXD3Gp2wVkgcrYaXNskzQbR2OB0Cjrxece89lTfdK6/ENveJYvhE0WMqwZea2qo
         vziQ==
X-Gm-Message-State: AOJu0YwpLAFKswiVkB8JrCL+pqWt3uSmXcH7+PAi3GADelYO+JZH5a7a
	0YWtdV42NkY4zrmyWHz+yLzEolJBZz1lxkd/i93P7JTbG/TACyhDZ9bmGg==
X-Gm-Gg: ASbGncuxnIolEM9d+AkrqtNdNN3swt0XnHcjc7PfMVngs/spnhjLkg/Qf/Z8EvUTUjP
	F54pHjp7bUJW5NIYEgBTRrim+A3lwXBHtgxPPy/KY0fy+KEQ3aDvoajLTk36ILjDIBvAAilK1Ue
	Hmih26g9cBOlttUTqCTTmkN5+m4hEKo0bns4v3yqMczw6wixyNS5O1E2CFfH7+8qkxRe5ZdF+DS
	s0gIJ5DWpo6N+D/FkgW46bnQ+/9aDbc/kWUxwvn/jBHTFjyITmRroBAlh7yRy3+a1H4ozsdrLDn
	vgNVrfz2EVfETX1b7SMKHznVfN4uqhzj
X-Google-Smtp-Source: AGHT+IHp3oW7Z0+NWRQLJ6asAUYF7e8XGfyUQ5BUmKaXx18JT4YUZz7GfyY7MaPbRdUmSD7+HoZI6g==
X-Received: by 2002:a17:90a:ac05:b0:2ff:52b8:2767 with SMTP id 98e67ed59e1d1-30a4e5cb28emr4765955a91.19.1746216987355;
        Fri, 02 May 2025 13:16:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150eaf49sm12095595ad.9.2025.05.02.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 2/5] selftests/bpf: Test setting and creating bpf qdisc as default qdisc
Date: Fri,  2 May 2025 13:16:21 -0700
Message-ID: <20250502201624.3663079-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
References: <20250502201624.3663079-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, test that bpf qdisc can be set as default qdisc. Then, attach
an mq qdisc to see if bpf qdisc can be successfully created and grafted.

The test is a sequential test as net.core.default_qdisc is global.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 61 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  3 +
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index c9a54177c84e..a22008fd31d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -159,6 +159,62 @@ static void test_qdisc_attach_to_non_root(void)
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
+static int get_default_qdisc(char *qdisc_name)
+{
+	FILE *f;
+	int num;
+
+	f = fopen("/proc/sys/net/core/default_qdisc", "r");
+	if (!f)
+		return -errno;
+
+	num = fscanf(f, "%s", qdisc_name);
+	fclose(f);
+
+	return num == 1 ? 0 : -EFAULT;
+}
+
+static void test_default_qdisc_attach_to_mq(void)
+{
+	char default_qdisc[IFNAMSIZ] = {};
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct netns_obj *netns = NULL;
+	int err;
+
+	fifo_skel = bpf_qdisc_fifo__open_and_load();
+	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	if (!ASSERT_OK(bpf_qdisc_fifo__attach(fifo_skel), "bpf_qdisc_fifo__attach"))
+		goto out;
+
+	err = get_default_qdisc(default_qdisc);
+	if (!ASSERT_OK(err, "read sysctl net.core.default_qdisc"))
+		goto out;
+
+	err = write_sysctl("/proc/sys/net/core/default_qdisc", "bpf_fifo");
+	if (!ASSERT_OK(err, "write sysctl net.core.default_qdisc"))
+		goto out;
+
+	netns = netns_new("bpf_qdisc_ns", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto out;
+
+	SYS(out, "ip link add veth0 type veth peer veth1");
+	SYS(out, "tc qdisc add dev veth0 root handle 1: mq");
+
+	ASSERT_EQ(fifo_skel->bss->init_called, true, "init_called");
+
+	SYS(out, "tc qdisc delete dev veth0 root mq");
+out:
+	if (netns)
+		netns_free(netns);
+	if (default_qdisc[0])
+		write_sysctl("/proc/sys/net/core/default_qdisc", default_qdisc);
+
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	struct netns_obj *netns;
@@ -178,3 +234,8 @@ void test_bpf_qdisc(void)
 
 	netns_free(netns);
 }
+
+void serial_test_bpf_qdisc_default(void)
+{
+	test_default_qdisc_attach_to_mq();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 0c7cfb82dae1..571fa7233ec0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -14,6 +14,8 @@ struct skb_node {
 private(A) struct bpf_spin_lock q_fifo_lock;
 private(A) struct bpf_list_head q_fifo __contains(skb_node, node);
 
+bool init_called;
+
 SEC("struct_ops/bpf_fifo_enqueue")
 int BPF_PROG(bpf_fifo_enqueue, struct sk_buff *skb, struct Qdisc *sch,
 	     struct bpf_sk_buff_ptr *to_free)
@@ -77,6 +79,7 @@ int BPF_PROG(bpf_fifo_init, struct Qdisc *sch, struct nlattr *opt,
 	     struct netlink_ext_ack *extack)
 {
 	sch->limit = 1000;
+	init_called = true;
 	return 0;
 }
 
-- 
2.47.1


