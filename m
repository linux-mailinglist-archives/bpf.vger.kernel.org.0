Return-Path: <bpf+bounces-64396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF8CB12475
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8D37AC911
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC925CC62;
	Fri, 25 Jul 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXYnFyH8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EC253925;
	Fri, 25 Jul 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469755; cv=none; b=huwoESkf8LrHGdSPxJBRZFWThL/+F+zTRq+EmvI/CqpSA3NlP5akb22etATPCD7C6hLg7Mc2BEs1o8fHgi9Twsz7rzLKYk10HVomg95P1lvlyowlaZfhM/698mGgoiRpVQ3gNYFWINTTjOOpRxYlsMw08mf/b8X7Sji2bZhLYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469755; c=relaxed/simple;
	bh=4xXFPYbVAQVFYaiedRqz4YnnUv/G+c2nHre6wAx2+cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKVZQlznqT0iWdNuGVfPXe0ZPQpD0PB2S8tgYWhJKEL41t7iDK788OChUMzoG2cLETmuA3eYfAphZ0FVeaUh87X0H095AnzRWQavTzqtgb5J3ANMqfPxDzGWJSCoUn4vnaR3mNOmm/CsxYMp3613chUOu+AXxqkCLs0Qd+pHAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXYnFyH8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b77377858bso1603876f8f.3;
        Fri, 25 Jul 2025 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469751; x=1754074551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+P1pO0VcptRLVWqzHA93r4jnwUEPVrrjiHiUMAaRCc=;
        b=iXYnFyH8XnkOP+iwBa/itUiDVEX15HerRWnhlG7wJhpuHQgj5EvX58OJjoYOlXZZvG
         3JJOd5ljMPgXmyaOWRB/0uu0DYt3KE54B0p0Xyv23ageh1KGCEIF1QZaFGW7TyBrwnx1
         uAYY1hVkDrycVjI7a792JzYubPi9W/HCX2J9u3O0vFlnn9tFkXx03Fv+9HwR9Bj9nHWI
         2cu1VfgOp6qR7dabihtDKyriXp1EKr1nfGJN/b+Eto1X8PVcE2B4eduQcdAT32ekgvA+
         k/olR32AVg8vfuvKkLZ5tOkC1xwk9uMmzoLqltn7WeiYjngnQq1oxdcqigjckkgSFR85
         7WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469751; x=1754074551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+P1pO0VcptRLVWqzHA93r4jnwUEPVrrjiHiUMAaRCc=;
        b=uVjdnkFzYYF88QVVsLvtCWQm15s3qB5kjmWYgs2XhgOGDdANAgKCxseiFMVnX8Nzal
         4Ig7QB0At//7edrdv8FfmYjORntTFEC6Y9j1g6zcgsdReIoTugku0D9UzJfQbFduUx2Z
         K5GXSVZhna8sFstX0rf8d+ZqI/JOVF6tYjcR45HaJfRN55UEEfrMhPMKMeFexZSRt8hr
         +FhW8RTbjBKMkAamKYRxhpBSlwDtE6U9vc7/h6XL1ONWDDBoQFEb77mKUX10tt0pfpRh
         ckXBTq1p5NLjyDyUIxsSXRhP/nXIRRO1k39m8vAMVBnbyPseb0qOkAw7X6mptKATrvLj
         C9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/JaLnYbm3cfCxUAPdhvGSIJvhFGV2Eg31SVuuu5c8FbGtYj2AzAZPZrq1r9TN7ce/kqnIfWFW@vger.kernel.org, AJvYcCUMuOky3y8zbyPt1G4KfIM01rCASWtQYJ6XNbHV3m4DzjuoY+CrQpcf1hrX2j7roS2zUCDp6pL3IRpwwEkVazYK@vger.kernel.org, AJvYcCVcmB9IrgmWrolTI9ydWgINUMgRYgebhKsZQQ71R19NKUnv8D1Sk8lap7pzOfwrN0lax3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNWJNxQmcma3Xao1T/vb+IsezDDmRv5MVS0xTvQNShiYdHQkS
	F/VGaBssIhWDHAupHPHv7IvLWX7D9/XevqTA1Mb/wkddNZY7/FaTDaGH
X-Gm-Gg: ASbGnctUBkRvQj9ZHbsn6gWRfNIYQweMMh80UCTam9AgSqdgAsEabmb837JiF+x4Mro
	xokC+CItG8rTuNPsj+i9q3hxQfAB6MBGTqYacXmNkVG2LLOx6sa1NWqyOiDD8JVUJ5zc/JZkYvk
	5DJaeKx/noyogcf3oNd+bhrNJLyZ1sw9hGDEdwthuCEhPXxSGSJbTkxVr2cgPO4zXmk1FLDlkvZ
	wDKrVE5idMysCBJyHkYGJJ34sw/oCTBM2klui7JjVgXvpcwV7o/VsrARdkaciVa+vrqR/CMQlT9
	N0yOwlLpmXWvl8F9gPLIAFTyfVyuCo94k6gPq7eHR79pd3BWh3kti5srrh3KiNNXH1OPSDXL4Rd
	DBsZFOkQwZ6qnfwH8YEPtze9RPXFXW1t6TA7UfYkSNF0e5el7
X-Google-Smtp-Source: AGHT+IH+qzbRUHgyZsobUO5oGyd5H2byoQchDyRA1NkLzNzhINe34lRZ+Qtx9ADULkVGsA8uBqTczA==
X-Received: by 2002:a5d:5f48:0:b0:3b5:f177:30a7 with SMTP id ffacd0b85a97d-3b7767339e3mr2526546f8f.16.1753469750690;
        Fri, 25 Jul 2025 11:55:50 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb276esm607743f8f.6.2025.07.25.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:55:50 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: add icmp_send_unreach kfunc tests
Date: Fri, 25 Jul 2025 18:53:42 +0000
Message-Id: <20250725185342.262067-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725185342.262067-1-mahe.tardy@gmail.com>
References: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
 <20250725185342.262067-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test opens a server and client, attach a cgroup_skb program on
egress and calls the icmp_send_unreach function from the client egress
so that an ICMP unreach control message is sent back to the client.
It then fetches the message from the error queue to confirm the correct
ICMP unreach code has been sent.

Note that the BPF program returns SK_PASS to let the connection being
established to finish the test cases quicker. Otherwise, you have to
wait for the TCP three-way handshake to timeout in the kernel and
retrieve the errno translated from the unreach code set by the ICMP
control message.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 99 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 36 +++++++
 2 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
new file mode 100644
index 000000000000..414c1ed8ced3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <linux/errqueue.h>
+#include "icmp_send_unreach.skel.h"
+
+#define TIMEOUT_MS 1000
+#define SRV_PORT 54321
+
+#define ICMP_DEST_UNREACH 3
+
+#define ICMP_FRAG_NEEDED 4
+#define NR_ICMP_UNREACH 15
+
+static void read_icmp_errqueue(int sockfd, int expected_code)
+{
+	ssize_t n;
+	struct sock_extended_err *sock_err;
+	struct cmsghdr *cm;
+	char ctrl_buf[512];
+	struct msghdr msg = {
+		.msg_control = ctrl_buf,
+		.msg_controllen = sizeof(ctrl_buf),
+	};
+
+	n = recvmsg(sockfd, &msg, MSG_ERRQUEUE);
+	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
+		return;
+
+	for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (!ASSERT_EQ(cm->cmsg_level, IPPROTO_IP, "cmsg_type") ||
+		    !ASSERT_EQ(cm->cmsg_type, IP_RECVERR, "cmsg_level"))
+			continue;
+
+		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
+
+		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
+			       "sock_err_origin_icmp"))
+			return;
+		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
+			       "sock_err_type_dest_unreach"))
+			return;
+		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
+	}
+}
+
+void test_icmp_send_unreach_kfunc(void)
+{
+	struct icmp_send_unreach *skel;
+	int cgroup_fd = -1, client_fd = 1, srv_fd = -1;
+	int *code;
+
+	skel = icmp_send_unreach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		goto cleanup;
+
+	skel->links.egress =
+		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
+		goto cleanup;
+
+	code = &skel->bss->unreach_code;
+
+	for (*code = 0; *code <= NR_ICMP_UNREACH; (*code)++) {
+		// The TCP stack reacts differently when asking for
+		// fragmentation, let's ignore it for now
+		if (*code == ICMP_FRAG_NEEDED)
+			continue;
+
+		skel->bss->kfunc_ret = -1;
+
+		srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1",
+				      SRV_PORT, TIMEOUT_MS);
+		if (!ASSERT_GE(srv_fd, 0, "start_server"))
+			goto for_cleanup;
+
+		client_fd = socket(AF_INET, SOCK_STREAM, 0);
+		ASSERT_GE(client_fd, 0, "client_socket");
+
+		client_fd = connect_to_fd(srv_fd, 0);
+		if (!ASSERT_GE(client_fd, 0, "client_connect"))
+			goto for_cleanup;
+
+		read_icmp_errqueue(client_fd, *code);
+
+		ASSERT_EQ(skel->bss->kfunc_ret, SK_DROP, "kfunc_ret");
+for_cleanup:
+		close(client_fd);
+		close(srv_fd);
+	}
+
+cleanup:
+	icmp_send_unreach__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
new file mode 100644
index 000000000000..15783e5d1d65
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+int unreach_code = 0;
+int kfunc_ret = 0;
+
+#define SERVER_PORT 54321
+#define SERVER_IP 0x7F000001
+
+SEC("cgroup_skb/egress")
+int egress(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+	struct tcphdr *tcph;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
+	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
+		return SK_PASS;
+
+	tcph = (void *)iph + iph->ihl * 4;
+	if ((void *)(tcph + 1) > data_end ||
+	    tcph->dest != bpf_htons(SERVER_PORT))
+		return SK_PASS;
+
+	kfunc_ret = bpf_icmp_send_unreach(skb, unreach_code);
+
+	/* returns SK_PASS to execute the test case quicker */
+	return SK_PASS;
+}
--
2.34.1


