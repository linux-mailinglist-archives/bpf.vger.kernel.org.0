Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7536C761
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhD0N4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhD0N4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 09:56:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD78C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 06:55:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so1114442wmm.0
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6nPFpTlkuCJlhgN+yJCTcFtqy6aXIl58iF6VVRx1Jsg=;
        b=SCzVaTea+5XmVjh3JZ/kP2Q5AE1PUWff/sOL0BXRTKt48H3neP3C7Wuz0XNqopECqs
         0+PXy6LXAVll3s0hJfv/dII7OciRLH+Mh95MCHHv3Xa5VIgYYlSgRn0hQjwmbiMkJm+I
         gcGdnrGrYhTNnp263RF61hydr6Fgw8OMg3AulsG7EN9Cxi8PHBeWezylQVdIaFkfv3+P
         UOFn1FVeM+l7/WX2GXa1vZaEsipb6yACGPZykpZXgODVlchwCkiRbZAiOMJ0V7JFAWu/
         50WeLNRK8ypbpp1wbHOGvjMejMYif6MwKIcuEuNpQk3uli1wYINC9xRyicYIst+u6Qjk
         1dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nPFpTlkuCJlhgN+yJCTcFtqy6aXIl58iF6VVRx1Jsg=;
        b=craZidyWkJRJgR9ziTHXa17eLiagGVc5oN675iwHEyMv109s6fjmDgQuUmjdwmR23I
         BC8u1WJdbxcrvY6zcET6TbpOpwaBlb40eK3S+m/z4wndCoh3qZVJlQejNFb9TQa0gIgK
         yh3oy15z+nMisxPpDvEysqRIhy41gorZkvvd8eWnERikRuYItIs7sF9WjH6Z+RTm/gei
         Ujq3BgTRU6PvSo84ei6UvvcZmWwRAx5pQ1qTljCTEvkiKaARmhpzGuYTSOarsWfkdqfU
         yWvmduJttfskl14HPvYGcSiJN+NZW5Ofz3jbCGtAhFqrKFcnRxCW6oZS1BTjr6iXbAXe
         DcwA==
X-Gm-Message-State: AOAM530E3IxoA7QxREydkbSsjlVaWZUrTj3fe9r7Wlx1R82ZlXtN7KgI
        iphSfa3wUPq1pXL+0fjAtVfykXe5MedB
X-Google-Smtp-Source: ABdhPJzV68F8OXHG+JsiAAsh3GOnADREol3mXBi1TRc/3IGE7X/3MMJ/v2bSjziLEx6lVI0YZ/90rw==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr4570320wmd.180.1619531757280;
        Tue, 27 Apr 2021 06:55:57 -0700 (PDT)
Received: from balnab.. (212-51-151-38.fiber7.init7.net. [212.51.151.38])
        by smtp.gmail.com with ESMTPSA id t7sm1086991wrw.60.2021.04.27.06.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 06:55:56 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for bpf_skb_change_head
Date:   Tue, 27 Apr 2021 13:55:50 +0000
Message-Id: <20210427135550.807355-2-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427135550.807355-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds test to check that bpf_skb_change_head can be used
in combination with bpf_redirect_peer to redirect a packet
from L3 device to veth.

Fixes: a426d97e970d ("bpf: Set mac_len in bpf_skb_change_head")
Signed-off-by: Jussi Maki <joamaki@gmail.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/progs/test_tc_peer.c        |  24 ++++
 .../testing/selftests/bpf/test_tc_peer_user.c | 127 ++++++++++++++++++
 .../testing/selftests/bpf/test_tc_redirect.sh |  95 ++++++++++---
 5 files changed, 233 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_tc_peer_user.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 4866f6a21901..49f3f050be4d 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -27,6 +27,7 @@ test_tcpnotify_user
 test_libbpf
 test_tcp_check_syncookie_user
 test_sysctl
+test_tc_peer_user
 xdping
 test_cpp
 *.skel.h
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 283e5ad8385e..0e05fefe2333 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -84,7 +84,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xdpxceiver
+	xdpxceiver test_tc_peer_user
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index fc84a7685aa2..49f0eefd58e7 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -5,8 +5,11 @@
 #include <linux/bpf.h>
 #include <linux/stddef.h>
 #include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
 
 enum {
 	dev_src,
@@ -42,4 +45,25 @@ SEC("src_ingress") int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(get_dev_ifindex(dev_dst), 0);
 }
 
+SEC("src_ingress_l3") int tc_src_l3(struct __sk_buff *skb)
+{
+	__u16 proto = skb->protocol;
+
+	if (bpf_skb_change_head(skb, ETH_HLEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	__u8 src_mac[] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
+	if (bpf_skb_store_bytes(skb, 0, &src_mac, ETH_ALEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	__u8 dst_mac[] = {0x00, 0x22, 0x33, 0x44, 0x55, 0x66};
+	if (bpf_skb_store_bytes(skb, ETH_ALEN, &dst_mac, ETH_ALEN, 0) != 0)
+		return TC_ACT_SHOT;
+
+	if (bpf_skb_store_bytes(skb, ETH_ALEN + ETH_ALEN, &proto, sizeof(__u16), 0) != 0)
+		return TC_ACT_SHOT;
+
+	return bpf_redirect_peer(get_dev_ifindex(dev_dst), 0);
+}
+
 char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tc_peer_user.c b/tools/testing/selftests/bpf/test_tc_peer_user.c
new file mode 100644
index 000000000000..bdecf2bd1cc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_tc_peer_user.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Networking across two network namespaces based on TUN/TAP.
+ * Like veth, but slow and L3. Used for testing BPF redirect_peer
+ * from L3 to L2 veth device.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+int tun_alloc(char *name) {
+	struct ifreq ifr;
+	int fd, err;
+	char cmd[512];
+
+	if ((fd = open("/dev/net/tun", O_RDWR)) < 0)
+		return -1;
+
+	memset(&ifr, 0, sizeof(ifr));
+
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	if (*name)
+		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+
+	if ((err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0) {
+		close(fd);
+		return err;
+	}
+
+	snprintf(cmd, sizeof(cmd), "ip link set dev %s up", name);
+	system(cmd);
+
+	return fd;
+}
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+enum {
+	SRC_TO_TARGET = 0,
+	TARGET_TO_SRC = 1,
+};
+
+void setns_by_name(char *name) {
+	int nsfd;
+	char nspath[PATH_MAX];
+
+        snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
+        nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
+        if (nsfd < 0) {
+		fprintf(stderr, "failed to open net namespace %s: %s\n", name, strerror(errno));
+		exit(1);
+        }
+	setns(nsfd, CLONE_NEWNET);
+	close(nsfd);
+}
+
+int main(int argc, char **argv) {
+	char *src_ns, *src_tun, *target_ns, *target_tun;
+	int srcfd, targetfd;
+
+	if (argc != 5) {
+		fprintf(stderr, "usage: %s <source namespace> <source tun device name> <target namespace> <target tun device name>\n", argv[0]);
+		return 1;
+	}
+
+	src_ns = argv[1];
+	src_tun = argv[2];
+	target_ns = argv[3];
+	target_tun = argv[4];
+
+	setns_by_name(src_ns);
+	srcfd = tun_alloc(src_tun);
+	if (srcfd < 0) {
+		fprintf(stderr, "failed to allocate tun device\n");
+		return 1;
+	}
+
+	setns_by_name(target_ns); 
+	targetfd = tun_alloc(target_tun);
+	if (srcfd < 0) {
+		fprintf(stderr, "failed to allocate tun device\n");
+		return 1;
+	}
+
+	fd_set rfds, wfds;
+	FD_ZERO(&rfds);
+	FD_ZERO(&wfds);
+
+	for (;;) {
+	        char buf[4096];
+	        int direction, nread, nwrite;
+		FD_SET(srcfd, &rfds);
+		FD_SET(targetfd, &rfds);
+
+		if (select(1 + MAX(srcfd, targetfd), &rfds, NULL, NULL, NULL) < 0) {
+		       fprintf(stderr, "select failed: %s\n", strerror(errno));
+		       return 1;
+	        }
+
+	        direction = FD_ISSET(srcfd, &rfds) ? SRC_TO_TARGET : TARGET_TO_SRC;
+
+	        nread = read(direction == SRC_TO_TARGET ? srcfd : targetfd, buf, sizeof(buf));
+	        if (nread < 0) {
+		       fprintf(stderr, "read failed: %s\n", strerror(errno));
+		       return 1;
+	        }
+
+	        nwrite = write(direction == SRC_TO_TARGET ? targetfd : srcfd, buf, nread);
+	        if (nwrite != nread) {
+		       fprintf(stderr, "write failed: %s\n", strerror(errno));
+		       return 1;
+	        }
+	}
+}
diff --git a/tools/testing/selftests/bpf/test_tc_redirect.sh b/tools/testing/selftests/bpf/test_tc_redirect.sh
index 8868aa1ca902..469e1dc13f03 100755
--- a/tools/testing/selftests/bpf/test_tc_redirect.sh
+++ b/tools/testing/selftests/bpf/test_tc_redirect.sh
@@ -50,15 +50,32 @@ readonly IP4_DST="172.16.2.100"
 readonly IP6_SRC="::1:dead:beef:cafe"
 readonly IP6_DST="::2:dead:beef:cafe"
 
+readonly IP4_TUN_SRC="172.17.1.100"
+readonly IP4_TUN_FWD="172.17.1.200"
+
+readonly IP6_TUN_SRC="1::dead:beef:0"
+readonly IP6_TUN_FWD="1::dead:beef:1"
+
 readonly IP4_SLL="169.254.0.1"
 readonly IP4_DLL="169.254.0.2"
 readonly IP4_NET="169.254.0.0"
 
+readonly MAC_DST_FWD="00:11:22:33:44:55"
+readonly MAC_DST="00:22:33:44:55:66"
+
+TEST_TC_PEER_USER_PID=""
+NC4_PID=""
+NC6_PID=""
+
 netns_cleanup()
 {
 	ip netns del ${NS_SRC}
 	ip netns del ${NS_FWD}
 	ip netns del ${NS_DST}
+
+	[ -n "$TEST_TC_PEER_USER_PID" ] && kill ${TEST_TC_PEER_USER_PID} || true
+	[ -n "${NC4_PID}" ] && kill ${NC4_PID} || true
+	[ -n "${NC6_PID}" ] && kill ${NC6_PID} || true
 }
 
 netns_setup()
@@ -70,6 +87,9 @@ netns_setup()
 	ip link add veth_src type veth peer name veth_src_fwd
 	ip link add veth_dst type veth peer name veth_dst_fwd
 
+	ip link set veth_dst_fwd address ${MAC_DST_FWD}
+	ip link set veth_dst address ${MAC_DST}
+
 	ip link set veth_src netns ${NS_SRC}
 	ip link set veth_src_fwd netns ${NS_FWD}
 
@@ -117,14 +137,20 @@ netns_setup()
 
 	ip -netns ${NS_SRC} neigh add ${IP6_DST} dev veth_src lladdr $fmac_src
 	ip -netns ${NS_DST} neigh add ${IP6_SRC} dev veth_dst lladdr $fmac_dst
+
+	ip -netns ${NS_DST} neigh add ${IP4_TUN_SRC} dev veth_dst lladdr $fmac_dst
+	ip -netns ${NS_DST} neigh add ${IP6_TUN_SRC} dev veth_dst lladdr $fmac_dst
+	ip -netns ${NS_DST} neigh add ${IP6_TUN_FWD} dev veth_dst lladdr $fmac_dst
 }
 
 netns_test_connectivity()
 {
 	set +e
 
-	ip netns exec ${NS_DST} bash -c "nc -4 -l -p 9004 &"
-	ip netns exec ${NS_DST} bash -c "nc -6 -l -p 9006 &"
+	ip netns exec ${NS_DST} nc -4 -l -p 9004 &
+	NC4_PID=$!
+	ip netns exec ${NS_DST} nc -6 -l -p 9006 &
+	NC6_PID=$!
 
 	TEST="TCPv4 connectivity test"
 	ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero bs=1000 count=100 > /dev/tcp/${IP4_DST}/9004"
@@ -170,14 +196,52 @@ netns_setup_bpf()
 {
 	local obj=$1
 	local use_forwarding=${2:-0}
+	local use_tuntap=${3:-0}
+
+	if [ "$use_tuntap" -eq "1" ]; then
+		# Set up tuntap based tunnel between src and fwd namespaces.
+		./test_tc_peer_user ${NS_SRC} tun_src ${NS_FWD} tun_fwd &
+		TEST_TC_PEER_USER_PID=$!
+
+		while ! ip -netns ${NS_SRC} link show tun_src; do echo "Waiting for tun_src to appear..."; sleep 0.5; done
+		while ! ip -netns ${NS_FWD} link show tun_fwd; do echo "Waiting for tun_fwd to appoar..."; sleep 0.5; done
+
+		ip -netns ${NS_SRC} addr add dev tun_src ${IP4_TUN_SRC}/24
+		ip -netns ${NS_FWD} addr add dev tun_fwd ${IP4_TUN_FWD}/24
 
-	ip netns exec ${NS_FWD} tc qdisc add dev veth_src_fwd clsact
-	ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd ingress bpf da obj $obj sec src_ingress
-	ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd egress  bpf da obj $obj sec chk_egress
+		ip -netns ${NS_SRC} addr add dev tun_src ${IP6_TUN_SRC}/64 nodad
+		ip -netns ${NS_FWD} addr add dev tun_fwd ${IP6_TUN_FWD}/64 nodad
 
-	ip netns exec ${NS_FWD} tc qdisc add dev veth_dst_fwd clsact
-	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd ingress bpf da obj $obj sec dst_ingress
-	ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd egress  bpf da obj $obj sec chk_egress
+		ip -netns ${NS_SRC} route del ${IP4_DST}/32 dev veth_src scope global
+		ip -netns ${NS_SRC} route add ${IP4_DST}/32 via ${IP4_TUN_FWD} dev tun_src scope global
+		ip -netns ${NS_DST} route add ${IP4_TUN_SRC}/32 dev veth_dst scope global
+
+		ip -netns ${NS_SRC} route del ${IP6_DST}/128 dev veth_src scope global
+		ip -netns ${NS_SRC} route add ${IP6_DST}/128 via ${IP6_TUN_FWD} dev tun_src scope global
+		ip -netns ${NS_DST} route add ${IP6_TUN_SRC}/128 dev veth_dst scope global
+		ip -netns ${NS_DST} route add ${IP6_TUN_FWD}/128 dev veth_dst scope global
+
+		ip netns exec ${NS_FWD} tc qdisc add dev tun_fwd clsact
+		ip netns exec ${NS_FWD} tc filter add dev tun_fwd ingress bpf da obj $obj sec src_ingress_l3
+
+		# Enable forwarding back towards src, but not for packets coming from the tunnel.
+		ip netns exec ${NS_FWD} sysctl -w net.ipv4.ip_forward=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.all.forwarding=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv4.conf.veth_dst_fwd.forwarding=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv4.conf.veth_src_fwd.forwarding=0
+		ip netns exec ${NS_FWD} sysctl -w net.ipv4.conf.tun_fwd.forwarding=0
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_src_fwd.forwarding=0
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.veth_dst_fwd.forwarding=1
+		ip netns exec ${NS_FWD} sysctl -w net.ipv6.conf.tun_fwd.forwarding=0
+	else
+		ip netns exec ${NS_FWD} tc qdisc add dev veth_src_fwd clsact
+		ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd ingress bpf da obj $obj sec src_ingress
+		ip netns exec ${NS_FWD} tc filter add dev veth_src_fwd egress  bpf da obj $obj sec chk_egress
+
+		ip netns exec ${NS_FWD} tc qdisc add dev veth_dst_fwd clsact
+		ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd ingress bpf da obj $obj sec dst_ingress
+		ip netns exec ${NS_FWD} tc filter add dev veth_dst_fwd egress  bpf da obj $obj sec chk_egress
+	fi
 
 	if [ "$use_forwarding" -eq "1" ]; then
 		# bpf_fib_lookup() checks if forwarding is enabled
@@ -190,13 +254,10 @@ netns_setup_bpf()
 	veth_src=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_src_fwd/ifindex)
 	veth_dst=$(ip netns exec ${NS_FWD} cat /sys/class/net/veth_dst_fwd/ifindex)
 
-	progs=$(ip netns exec ${NS_FWD} bpftool net --json | jq -r '.[] | .tc | map(.id) | .[]')
-	for prog in $progs; do
-		map=$(bpftool prog show id $prog --json | jq -r '.map_ids | .? | .[]')
-		if [ ! -z "$map" ]; then
-			bpftool map update id $map key hex $(hex_mem_str 0) value hex $(hex_mem_str $veth_src)
-			bpftool map update id $map key hex $(hex_mem_str 1) value hex $(hex_mem_str $veth_dst)
-		fi
+ 	maps=$(bpftool map list --json | jq -r '.[] | select(.name == "ifindex_map") | .id')
+	for map in $maps; do
+		bpftool map update id $map key hex $(hex_mem_str 0) value hex $(hex_mem_str $veth_src)
+		bpftool map update id $map key hex $(hex_mem_str 1) value hex $(hex_mem_str $veth_dst)
 	done
 }
 
@@ -214,3 +275,7 @@ netns_cleanup
 netns_setup
 netns_setup_bpf test_tc_peer.o
 netns_test_connectivity
+netns_cleanup
+netns_setup
+netns_setup_bpf test_tc_peer.o 0 1
+netns_test_connectivity
-- 
2.30.2

