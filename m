Return-Path: <bpf+bounces-79077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D54D2659E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D21D130049F5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE53D1CD4;
	Thu, 15 Jan 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv68rUWY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F33C1FCE
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497163; cv=none; b=VsJ+4vvgLK7gvEBeC9tj9M2nYFJtB5ZwSetVIT4ExfKj0alf34y/AZIPmAHL0pemz91XaAikM940zuHOAa5xwRXz0Qi+liBrNgmu8XJ+pIx5MM54gsGMPgXaqUxzK0UG/GMribQOdchoOota2bXY0hdeLDmeXhvFlCnozApx/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497163; c=relaxed/simple;
	bh=ozJe/DZktvt1THhlIH8e13meT+GK+nb2peuvZHdYIB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnejIWFzntw7jpz1CWY1GVKFVMltbzSn7f1NsK9LGpOzak5AuCP1idQmk2Eg1zQppnQlKGbLFqcfDU9Rz3ytz4+G20DC/FUWc4jN78DIbS5Y/zeHEnbyjVcVNRNeycyTV1LBiOSPrG2QcY9zotKTb3MRXG9dCMDERf4+6X0niF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv68rUWY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso7917705e9.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 09:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497158; x=1769101958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUwAm1Dn1V0YNHJ06qHaA7B/DEkukzNU8MJR12KV7b4=;
        b=jv68rUWYhRMUVaQfK92x5EMA0vdJHU3qpp61axNVrr9/wMOVD3Y8IgWKe4QNDWKNUR
         HsnZOlgtxcvB/x1YGKC3nrRZvAocSJivD48lquEF0YLTHL0y81Kzb8HK1+WsYZiZyX60
         5KCsHivQpfrnydWnhu8Ri/yd7X0pogRtwlimzX9ufGwSYwlQ62Br+EyxE3jNEZTl+Oj+
         zHM+GQ8EiY0CWlv8IayDXJkUcizVKdJL83CoS7UMvdTwgP8ebqpTvoju1gJfi0uDokhP
         cTNqVxaNtDkFS8LVYSjCxmmtSsHvdpl/SxwY7yf/xkUnpT6aRzHOjhfRRHfH/1e+pqHT
         ZHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497158; x=1769101958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUwAm1Dn1V0YNHJ06qHaA7B/DEkukzNU8MJR12KV7b4=;
        b=InZBPyCCGIR+iRaa0cfUJIGnWcPWS3ZychFwXn1q5loonhmocJW5Jpw2qZkdHQBLXT
         /CvSpKwmAifwTsCFF1JLjj2OOlSMclLW2Xz8uycZsZwWOc70im+yVsSrKr4WoHihWXNl
         cgq0EzEnu0uVB9uUKPqJB29rDmlFfdFTX+6odcsO6lGk0SHc6iWxQZeKX2ngEBqrzuxj
         eWXSiGtY3yUueQuO6izfKDB9haU1YkDaNZm6lbA+ksaspMozvNqHeWIMOQAwTGx5ZFdj
         TC3VcrUsePbtBl4IAYjhsQjFDx+CaeojIpJh5GD4a2sF3OwzWIkl3FcQgh+e/Nym9S5f
         w3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVbLluQYPy8LJVy1ZUVW82ks17ClpT05X2QMxYUK6Qz3VPHgELlua1T2+UBKhrztRdXtms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACjhFv2py0OaqJXlvA7IbwwvaaXWw3gilERdCHhK7JLlJ18fi
	aW7P7ClhytLCKQOXAHfTsQeblEMq0mpvn2JduPp1jYAN1YlD4rn756bb
X-Gm-Gg: AY/fxX65gnsWY8pvoA8CZfbkhg2O2LU+CDIyUQpwD0YJz5ipg2KkwfYuGzDTnSIe+kD
	04LS0XNGSNIfpNW1fVuV55d8a59m2sknJDDsj+gMSwwpyvpfywPQ2INjJlF6l+D0hULjjbl6P7H
	UmaOJpwuvA1m3sBV6BGABpdfBH//dSMdOrrg3meWV2arnxydDihC650j/nNh0KRXwhRUlEf18lk
	27uW6lGbvjeNTbZ7FqaFBVDqWXGzTE5yPfZXLpTiLn2tldvFzzWPgkyC4oz6Eywd9F9LHJb+KfF
	0mAWjJlvRBaBVDfQfHIqtZiRDgrGa256S+EJcUnO0sd05vw4wbimm6np3WWcUo+xN+YIm+KTLCL
	qLY3FEH39VTtjBC7rdmY8rFsNXLRv0lnnmF5Ft7WZyfqxf31PxpXoE06Bem5IcsXLZrfFL52QB/
	cUW3Iw53g4TI15n8xq0VfLMw4feuP1dcFE1HbytbMiONvnnRSGEYzu1YXVZh4WnDRTIlXHpRqcN
	0tbPvtR0YehoqFH0w==
X-Received: by 2002:a05:600c:8b58:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-4801e345987mr6476985e9.31.1768497158402;
        Thu, 15 Jan 2026 09:12:38 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:37 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 8/9] selftests: iou-zcrx: test large chunk sizes
Date: Thu, 15 Jan 2026 17:12:01 +0000
Message-ID: <a32bb32d019332394aee9e2befea4fec05a672e4.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test using large chunks for zcrx memory area.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 72 +++++++++++++++----
 .../selftests/drivers/net/hw/iou-zcrx.py      | 39 ++++++++++
 2 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 62456df947bc..240d13dbc54e 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 
 #include <arpa/inet.h>
+#include <linux/mman.h>
 #include <linux/errqueue.h>
 #include <linux/if_packet.h>
 #include <linux/ipv6.h>
@@ -37,6 +38,23 @@
 
 #include <liburing.h>
 
+#define SKIP_CODE	42
+
+struct t_io_uring_zcrx_ifq_reg {
+	__u32	if_idx;
+	__u32	if_rxq;
+	__u32	rq_entries;
+	__u32	flags;
+
+	__u64	area_ptr; /* pointer to struct io_uring_zcrx_area_reg */
+	__u64	region_ptr; /* struct io_uring_region_desc * */
+
+	struct io_uring_zcrx_offsets offsets;
+	__u32	zcrx_id;
+	__u32	rx_buf_len;
+	__u64	__resv[3];
+};
+
 static long page_size;
 #define AREA_SIZE (8192 * page_size)
 #define SEND_SIZE (512 * 4096)
@@ -65,6 +83,8 @@ static bool cfg_oneshot;
 static int cfg_oneshot_recvs;
 static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
+static unsigned int cfg_rx_buf_len;
+static bool cfg_dry_run;
 
 static char *payload;
 static void *area_ptr;
@@ -128,14 +148,28 @@ static void setup_zcrx(struct io_uring *ring)
 	if (!ifindex)
 		error(1, 0, "bad interface name: %s", cfg_ifname);
 
-	area_ptr = mmap(NULL,
-			AREA_SIZE,
-			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE,
-			0,
-			0);
-	if (area_ptr == MAP_FAILED)
-		error(1, 0, "mmap(): zero copy area");
+	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
+		area_ptr = mmap(NULL,
+				AREA_SIZE,
+				PROT_READ | PROT_WRITE,
+				MAP_ANONYMOUS | MAP_PRIVATE |
+				MAP_HUGETLB | MAP_HUGE_2MB,
+				-1,
+				0);
+		if (area_ptr == MAP_FAILED) {
+			printf("Can't allocate huge pages\n");
+			exit(SKIP_CODE);
+		}
+	} else {
+		area_ptr = mmap(NULL,
+				AREA_SIZE,
+				PROT_READ | PROT_WRITE,
+				MAP_ANONYMOUS | MAP_PRIVATE,
+				0,
+				0);
+		if (area_ptr == MAP_FAILED)
+			error(1, 0, "mmap(): zero copy area");
+	}
 
 	ring_size = get_refill_ring_size(rq_entries);
 	ring_ptr = mmap(NULL,
@@ -157,17 +191,23 @@ static void setup_zcrx(struct io_uring *ring)
 		.flags = 0,
 	};
 
-	struct io_uring_zcrx_ifq_reg reg = {
+	struct t_io_uring_zcrx_ifq_reg reg = {
 		.if_idx = ifindex,
 		.if_rxq = cfg_queue_id,
 		.rq_entries = rq_entries,
 		.area_ptr = (__u64)(unsigned long)&area_reg,
 		.region_ptr = (__u64)(unsigned long)&region_reg,
+		.rx_buf_len = cfg_rx_buf_len,
 	};
 
-	ret = io_uring_register_ifq(ring, &reg);
-	if (ret)
+	ret = io_uring_register_ifq(ring, (void *)&reg);
+	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
+			       ret == -ERANGE)) {
+		printf("Large chunks are not supported %i\n", ret);
+		exit(SKIP_CODE);
+	} else if (ret) {
 		error(1, 0, "io_uring_register_ifq(): %d", ret);
+	}
 
 	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
 	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
@@ -323,6 +363,8 @@ static void run_server(void)
 	io_uring_queue_init(512, &ring, flags);
 
 	setup_zcrx(&ring);
+	if (cfg_dry_run)
+		return;
 
 	add_accept(&ring, fd);
 
@@ -383,7 +425,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -418,6 +460,12 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_send_size = strtoul(optarg, NULL, 0);
 			break;
+		case 'x':
+			cfg_rx_buf_len = page_size * strtoul(optarg, NULL, 0);
+			break;
+		case 'd':
+			cfg_dry_run = true;
+			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 712c806508b5..7f596a33eb2b 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -7,6 +7,7 @@ from lib.py import ksft_run, ksft_exit, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
 
+SKIP_CODE = 42
 
 def _get_current_settings(cfg):
     output = ethtool(f"-g {cfg.ifname}", json=True)[0]
@@ -132,6 +133,44 @@ def test_zcrx_rss(cfg) -> None:
         cmd(tx_cmd, host=cfg.remote)
 
 
+def test_zcrx_large_chunks(cfg) -> None:
+    """Test zcrx with large buffer chunks."""
+
+    cfg.require_ipver('6')
+
+    combined_chans = _get_combined_channels(cfg)
+    if combined_chans < 2:
+        raise KsftSkipEx('at least 2 combined channels required')
+    (rx_ring, hds_thresh) = _get_current_settings(cfg)
+    port = rand_port()
+
+    ethtool(f"-G {cfg.ifname} tcp-data-split on")
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
+
+    ethtool(f"-G {cfg.ifname} hds-thresh 0")
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
+
+    ethtool(f"-G {cfg.ifname} rx 64")
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
+
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -x 2"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+
+    probe = cmd(rx_cmd + " -d", fail=False)
+    if probe.ret == SKIP_CODE:
+        raise KsftSkipEx(probe.stdout)
+
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
-- 
2.52.0


