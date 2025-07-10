Return-Path: <bpf+bounces-62911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC45AFFF3A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80975A507E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72F2DFA48;
	Thu, 10 Jul 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzN+2O23"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711922D9485
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143204; cv=none; b=fEgYW/Sc7GNZ7m2/PVSnz4bNNv0akk2pOTKZbSrFLdmmS2UkO/zfV2bjAM224OFxv3Zm3idaskUHk7QSQI5/98ZfPlEFlDLo3SNXuk9qmIR3Jxbn98R95bz8a4CCsTtXAjDAVUuGDNJPFCsBsf/Hgqswb84RrvsVoJ1OWdv1CMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143204; c=relaxed/simple;
	bh=BoRKRH4ntN5MyIUTlCakkAAazcoHSxL1G1+DD7sc3OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdyS0KBVEFt8MXx7xzt3eyXBePDyBHkKCfz0sxCJfiR8mC5sktrkefRiRLTUpC6eL5Wi78P8TftA+2XUHg68CslU8sjivyGbYPQCKctaU/O4d5GtJWsynnYEq2BgZO3tZ9ICitKBcEQVBxddSyoTZEIxIaSiXCMvK3ByhQA1HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzN+2O23; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso831591f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143201; x=1752748001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aowrnU3KLJ+CLPW+L5+BNqloQpmKeTIz87NtSThMIa8=;
        b=gzN+2O23plK3iLDOtGbSJCTI+zccUlRMWO7NsWzVjz+WPObZLyw3cIxGWolP2uGdyX
         W448l7ZaxsLLpCHN0zJPzvDxhdlquMIUamHelBTW+5mwt7fgHgqzMsQ6PHJ3zpEzGb1y
         ZIHs39J31Qxr4joTzIt4AaGIHGWC5I24V9xWY1tbJuCI2RhvFeUkCHTcIhSEMpzVfbX7
         LJ9Gt571n59d72q+x62yf1b32rYzlsyPOMjrM4VYohYCgeQsjb9zjgnzIy6FJcVM/QaC
         EA3AH89lM3cl3AA6n1d3S/LplOV55P8IAArz3f35BSThtLi5ecnBpEHgCG7IqiK/349j
         cD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143201; x=1752748001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aowrnU3KLJ+CLPW+L5+BNqloQpmKeTIz87NtSThMIa8=;
        b=f45QubcN1JAH+NM9nhpUdRktxUx7YhTpkpSOsm9S9Kesym5sEaG5L+HrWVRtKmZ8Mb
         FbwwuSsYav3YpIUlza89YbcHhfodNFEGcxwSJUrcfVDzun9fmfcIDWpXFQoaxCHIOQe7
         Gbx+uciO0YCp+2aDRg4CT8J3L1E3K5pqs5bqFYszKG8IzhN+ofKtWoOrzOviWzB3MIMq
         9PomnYgiQxeNNsKNoWw4oGkwjhv76+0K0fo5ougB9MkLXvlXV5qe0LNO1mslHBDWl7zE
         lPK8Ez/4VwyszzRJ7c5gpsxpp5CadskOX3MzwGlPsF5zF3lzQa5vfZvjVmF2AXY/uoyd
         zYiA==
X-Gm-Message-State: AOJu0YxhuAwqAxefg6HWEtdOr/ETggQfaw0pkFOMII2/3bcaSmmT640r
	k0AZSfPSEAV6joTzUSiZYTqtIMA866B0fR2yLcT3SGuuNH7TGSyfcPikhtaKND8gWAWiZw==
X-Gm-Gg: ASbGncsOWWzD+N2+g6no3xsbkSLLHru6eORS0MHOBDiOFHWyQh4isOIqQgKFxEPiYHd
	8k6rmZyD/lMO1B/LxiMFkgfTh+aHZo4rNJA3hP+D42EtiHGfJhP6vqli7y9QxUVfOzJ5OmGL8BU
	qnCI7Nb/Fa3KSD5f0jNoQfuXZqjvZGrhQNnUT+KDs0YY8zwqy180a+LxPFx1iEvVBeKVg1ZwA+Y
	q3L11ArBp6WmyPQmmRr3NonMqJtWmov1CP8UXV0pvAq6iB7xXHNOGZc5zibb8INgZTcCJok0Mjv
	5IpNFGXlX/yUw9INVHW6QU0Hfhke0qQ6IVhXsvz+ZTMPSKLx4SCPvcqck4s1DRJZrOn1w1qUJoL
	5rmjTt/wrB6cl
X-Google-Smtp-Source: AGHT+IG2HLq8l9p2WRFkH92BCX33l6skfWoF+Y18r8Qzod0kTX2cY8z4iwatSgjxh4Wbg5h7DrEebw==
X-Received: by 2002:a05:6000:2484:b0:3a5:39d5:d962 with SMTP id ffacd0b85a97d-3b5e452a772mr5117368f8f.41.1752143200502;
        Thu, 10 Jul 2025 03:26:40 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm52639745e9.36.2025.07.10.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:26:40 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: add icmp_send_unreach kfunc tests
Date: Thu, 10 Jul 2025 10:26:07 +0000
Message-Id: <20250710102607.12413-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710102607.12413-1-mahe.tardy@gmail.com>
References: <20250710102607.12413-1-mahe.tardy@gmail.com>
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
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 96 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 35 +++++++
 2 files changed, 131 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
new file mode 100644
index 000000000000..2896d0619358
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
@@ -0,0 +1,96 @@
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
index 000000000000..ec406028be5f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+int unreach_code = 0;
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
+	bpf_icmp_send_unreach(skb, unreach_code);
+
+	/* returns SK_PASS to execute the test case quicker */
+	return SK_PASS;
+}
--
2.34.1


