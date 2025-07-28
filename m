Return-Path: <bpf+bounces-64495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6537B1381D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C701884F98
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103F266571;
	Mon, 28 Jul 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNDiS3DN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A09264A60;
	Mon, 28 Jul 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695849; cv=none; b=FfIi/0AT1sHdNbEX4JCyBfnb8H56QCQQwrTSCLNV9J9Pv7OTq4mC64lqv4zZQkb++Zx8SE6FCSfOFgVI6/c8yIMXqJGey8EgHKPYeallbkDTgliZvNdZY4qIEc1F+ahBE64y2lmVx+GQqShJXUho3uhjQrDwGKiGP5kroJfLoBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695849; c=relaxed/simple;
	bh=4xXFPYbVAQVFYaiedRqz4YnnUv/G+c2nHre6wAx2+cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBScjMw75vSoge8cm6H7A3OFMOLW23s1ohhucaJj+3uGa6vgsKy4Fc6zAw5sXZHkaU2dU28diZaGJ2k1vBoMjEV8D0MkO4OnJpKPkBph9qdh6iezpacUuQ3FxIaZbT76cApKLlSLjQaGHA5D7JRWAUhi0JSztnYx/uNiO/xQ/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNDiS3DN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so22982505e9.2;
        Mon, 28 Jul 2025 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695845; x=1754300645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+P1pO0VcptRLVWqzHA93r4jnwUEPVrrjiHiUMAaRCc=;
        b=ZNDiS3DNxDdgxaB5epiH0XRV0srScgvEIn6sJjjh4Lf8ZeSS/SyyLnsdv4fEzbSYep
         w3SdwHpydda/hbk3PeU0P1HIkDF7rrfOBna/KJBhBRuRxHUo2Ko4rg/PNNhudXM4IUgZ
         dpTA1NY//E404M9I1CBpG82hWl73LyVMWQRNx+ZSLKtdSeHNWbqYQr1F/OfRhm8dTZxD
         Kpmhi7DYpXVZbQTLSbfCdCq0oIHxLMX/a7ztVXzM3RbTmhvbnpWlHxFhtwiZwetqwY9O
         0pNAZnUM8DukvPS2mdpzw/OfsyGEG7xVywYNdjSvb9y36QJRN/pTW99KlxG/+8l6bp9d
         byNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695845; x=1754300645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+P1pO0VcptRLVWqzHA93r4jnwUEPVrrjiHiUMAaRCc=;
        b=B8MN5mSeeIsXFPiyo+n0bDNGECXVVVgC/TOWLI0mqp8/sEyRiuzehBE8CsxMrYtpiP
         w9wbDTDnreZf1MZSIomppgsZ0nXdpBhN9jqYnqX8zKrClO57XVQIpK70ytR4774qourQ
         KSFuTboYe33oKn6Drz2sUcZaQSo3iJqclLRpAPxGMeUsWJRNYpGKuIsPi7zenIylXRmj
         j/h3B/85PYkJS7gpQjkkJ8mhVPinj64flHW7zeRVW4yq3UGYgKUQU+uGK0AlcxVbuMx/
         SvLOgxPoiqtxWsffeeR2xd4OssYW0WV56vookgtmyMqvAAmUVqVR0o/PSfZeOH6jTtIL
         jYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/hm61VwXOAkjf5BMsuGP1Ac6HQQo26tfB5TZ8SYkVjQb/G+RTtU/ks4iys1ONkkmByT6xwzPX6+KWhtHet/ov@vger.kernel.org, AJvYcCWA38u0sgPEwCka3/weQQ95BoSobs3AuMk8Wn+SZZxtUUEUvfOamK4/0L0yCaA2JcbCxDc2dAai@vger.kernel.org, AJvYcCXUXQGq8dGCHD3N2CFcLFU+4i2zmUXcJ2hnRI9P/qmDVgTpF8D/BEKa1RDyrpRoTPCoBGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cgFMXSZB507U6kMIc+75Yyl6xnNayUwJ2UsF0rW0UhuTD1y6
	0/sQPU6rBjZLo6W7ee9itm2TqbkqZcthc8uVEl54IRtezVCcc9jMq/XI
X-Gm-Gg: ASbGncuYIuGGMAJFDRROE5K/+jb0KssNk8CsI1FzC5z3vqZ5lDyCNHkXbDJrT4FNqY/
	5n++lZqzKKMhP1ZdSOFH4T0qEgAnWY6o/+dKzd9Os2ym1+szfeiTOOmn6534HfPZ+0Pe8idwGD/
	pF/0eiC/CQL6IuEMqXz6V0g2QUnXNEoYvyPhrnGOB7sTq2/XxL1oGVJMGioLyGT3jvQTQCHaMQ4
	i4wsyok5Gz6PH54StBI7MLhwzX11T146glYWPWO39kPfL2kjJJLNW1OyMOSh+Onk17aXhNfq/P0
	c7CguW/dJYu6ybqWAEtfcp8OjsUWxP7EPscO4jlBE9JOYw2I3v4+sD+ZBOvd6BPZ8y9RKMne2/n
	br7gTkSzyvysqyvSyBF13L+xujgmqpXeeKv9f282kvXCAMQfSYtBlYHi5Gqs=
X-Google-Smtp-Source: AGHT+IHzSy4NMd3Qx5rCatTn1WF/YbRKeEsCFDcF0eoLwVoG3FrjFskFfEqD9sCCMOiZbDxG++AB9g==
X-Received: by 2002:a05:600c:1e89:b0:456:2379:c238 with SMTP id 5b1f17b1804b1-45876439296mr107541165e9.17.1753695844953;
        Mon, 28 Jul 2025 02:44:04 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bcbfbsm153422725e9.16.2025.07.28.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:04 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: lkp@intel.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: add icmp_send_unreach kfunc tests
Date: Mon, 28 Jul 2025 09:43:45 +0000
Message-Id: <20250728094345.46132-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250728094345.46132-1-mahe.tardy@gmail.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
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


