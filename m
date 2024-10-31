Return-Path: <bpf+bounces-43633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75B9B74A3
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 07:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385451C25229
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100331465A5;
	Thu, 31 Oct 2024 06:35:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FC126BF5;
	Thu, 31 Oct 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356533; cv=none; b=jfyUOSSa6ymfrSJhh9Ana/UOCahag586rls8Q8AP4EG6B8AQ/lUkXZ0ZNUWcxBYidntil8LaO0vwd3zrf5cbbOBxiyjZr1+xEBIHVtsp24a1v/6nFcE/K3P+s7MdFoQvZH7j8A8BtHS5dJeCPtl+Wfd1+kUlXeUgTd8atH7tyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356533; c=relaxed/simple;
	bh=JcLQm5cN5XbuT6oX0Qh9tU7pY9cEpUHdv+lzKZYAUwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOBWhyhOvjJf3cW+nsp3IbYHrq3i/nCAy2ZH8NI3udCNj6yhIAfXCM4nJrWSQqDfgr7Stp/aVdkT8BkO7fiXeRaljUfeLpDtX3ovZxT5TnICqf0ihEsDm7HJb4N2ilbPI8i9i3dFb4LwSeubvGRJAR1Ngxk3UHIzb1oUUgFRxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XfDkg2QXRz4f3lfX;
	Thu, 31 Oct 2024 14:35:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC8101A018C;
	Thu, 31 Oct 2024 14:35:25 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgDnEIUsJSNnwi_BAQ--.1214S2;
	Thu, 31 Oct 2024 14:35:25 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 6.6] Revert "selftests/bpf: Implement get_hw_ring_size function to retrieve current and max interface size"
Date: Thu, 31 Oct 2024 06:37:02 +0000
Message-Id: <20241031063702.3256343-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnEIUsJSNnwi_BAQ--.1214S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry3Xr4fuF1ftr4UtryrZwb_yoWrCry3pa
	48A345t3yIqF17t3ZrJrW2gF4rKrs7WrWUGry0qw1UZr47Gr97Xr4xKr4jgF90grZ0qrs5
	ZayIgr1rCr48ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This reverts commit c8c590f07ad7ffaa6ef11e90b81202212077497b which is
commit 90a695c3d31e1c9f0adb8c4c80028ed4ea7ed5ab upstream.

Commit c8c590f07ad7 ("selftests/bpf: Implement get_hw_ring_size function
to retrieve current and max interface size") will cause the following
bpf selftests compilation error in the 6.6 stable branch, and it is not
the Stable-dep-of of commit 103c0431c7fb ("selftests/bpf: Drop unneeded
error.h includes"). So let's revert commit c8c590f07ad7 to fix this
compilation error.

  ./network_helpers.h:66:43: error: 'struct ethtool_ringparam' declared
    inside parameter list will not be visible outside of this definition or
    declaration [-Werror]
      66 | int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 24 -------------------
 tools/testing/selftests/bpf/network_helpers.h |  4 ----
 .../selftests/bpf/prog_tests/flow_dissector.c |  1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 14 +++++++++++
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index d2acc8875212..0877b60ec81f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -465,27 +465,3 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
-
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
-{
-	struct ifreq ifr = {0};
-	int sockfd, err;
-
-	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
-	if (sockfd < 0)
-		return -errno;
-
-	memcpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
-
-	ring_param->cmd = ETHTOOL_GRINGPARAM;
-	ifr.ifr_data = (char *)ring_param;
-
-	if (ioctl(sockfd, SIOCETHTOOL, &ifr) < 0) {
-		err = errno;
-		close(sockfd);
-		return -err;
-	}
-
-	close(sockfd);
-	return 0;
-}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 11cbe194769b..5eccc67d1a99 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -9,11 +9,8 @@ typedef __u16 __sum16;
 #include <linux/if_packet.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <linux/ethtool.h>
-#include <linux/sockios.h>
 #include <netinet/tcp.h>
 #include <bpf/bpf_endian.h>
-#include <net/if.h>
 
 #define MAGIC_VAL 0x1234
 #define NUM_ITER 100000
@@ -63,7 +60,6 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		  struct sockaddr_storage *addr, socklen_t *len);
 char *ping_command(int family);
 int get_socket_local_port(int sock_fd);
-int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
 struct nstoken;
 /**
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 3171047414a7..b81046806579 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -2,6 +2,7 @@
 #define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <linux/if.h>
 #include <linux/if_tun.h>
 #include <sys/uio.h>
 
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 79f2da8f6ead..adb77c1a6a74 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -288,6 +288,20 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	return 0;
 }
 
+struct ethtool_channels {
+	__u32	cmd;
+	__u32	max_rx;
+	__u32	max_tx;
+	__u32	max_other;
+	__u32	max_combined;
+	__u32	rx_count;
+	__u32	tx_count;
+	__u32	other_count;
+	__u32	combined_count;
+};
+
+#define ETHTOOL_GCHANNELS	0x0000003c /* Get no of channels */
+
 static int rxq_num(const char *ifname)
 {
 	struct ethtool_channels ch = {
-- 
2.34.1


