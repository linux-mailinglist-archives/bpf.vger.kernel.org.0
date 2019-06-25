Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7F5202A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfFYAzq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 20:55:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46405 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfFYAzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 20:55:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so7821154pls.13;
        Mon, 24 Jun 2019 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UJhsSqHcceCqCB359AT1rVmU3aCew4ZtEJVvX9H5JdA=;
        b=UHoCEmjtvXfhagFILtE7T7kMxCBpXajlUXMH11bhvLDFesf6JbTIrxu7Vwr8yzmYAK
         5t/CcCZ92TDUzKHU76eP1Jft1R4BRqD+OI+hcPRbNOf9rZ31qxYnWo/ZlJeyLBNJQRuu
         hsVtYRwCyBdGvKPpVhOcddgbThD3yNQkcx12zxh3qE96e4IgF98EShxwaVupCCKvXU2D
         shtJdB2cnoz2G1bMlixftnfXoW9jLF5K6sK2uR6+G8vHybfhIOSVdIOvdktJcQ4DZEM/
         mQnImTMllteRv6gXHDWGFruaLs0ptUEqqEb7ZXknyjPEa3w9VTTu/7WLQvj210G3eJ9K
         mjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UJhsSqHcceCqCB359AT1rVmU3aCew4ZtEJVvX9H5JdA=;
        b=NQ6tEFPrBW9Gf1UDe/+APwsj5yB/P6xtLLo2z/OGdUIAegYHsVoBZmBTF4Kr8LC5YK
         11TasdpqS0NwBYGS4qISn5BhU2MVmPt56gd99ViJ+6yYtiZzhs2YkefOayLO09D22erd
         vNj4XYn4UPXUv94t110Po+rCAFY9FpB7Awb/OTv0oFgylvSKNH2IU7nl/T00W0cJff7s
         CblmDE4q634l+noyzVa+RoZPiwmiidMlVWMEvv6rGTbMtXM0OOruyzraNuS/EkQMGIPp
         s8h39yWQ65pkvejEVy+bOQOu9axRhRs7qvFetYMFK+vvkQH013E2oCh+QujXcnq2r53w
         elTg==
X-Gm-Message-State: APjAAAXgJ5nxJ8DeY4Muc41sbooLVzeKyfgc88VLHn3Fs+OPXs6kiewA
        KVFgVW7kNCsEGFTh1lCwTg==
X-Google-Smtp-Source: APXvYqy+Y7UUBlt0xdXcvivBGGoDqd0Xei/yORUjSG5cODir9GwWRbMBOKv4SSfysdXHsQgb/ooqqg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr27662642plz.191.1561424145169;
        Mon, 24 Jun 2019 17:55:45 -0700 (PDT)
Received: from localhost.localdomain ([58.76.163.19])
        by smtp.gmail.com with ESMTPSA id u2sm600978pjv.9.2019.06.24.17.55.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 17:55:44 -0700 (PDT)
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2] samples: bpf: make the use of xdp samples consistent
Date:   Tue, 25 Jun 2019 09:55:36 +0900
Message-Id: <20190625005536.2516-1-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, each xdp samples are inconsistent in the use.
Most of the samples fetch the interface with it's name.
(ex. xdp1, xdp2skb, xdp_redirect_cpu, xdp_sample_pkts, etc.)

But some of the xdp samples are fetching the interface with
ifindex by command argument.

This commit enables xdp samples to fetch interface with it's name
without changing the original index interface fetching.
(<ifname|ifindex> fetching in the same way as xdp_sample_pkts_user.c does.)

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
Changes in v2:
  - added xdp_redirect_user.c, xdp_redirect_map_user.c 

 samples/bpf/xdp_adjust_tail_user.c  | 12 ++++++++++--
 samples/bpf/xdp_redirect_map_user.c | 15 +++++++++++----
 samples/bpf/xdp_redirect_user.c     | 15 +++++++++++----
 samples/bpf/xdp_tx_iptunnel_user.c  | 12 ++++++++++--
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/xdp_adjust_tail_user.c b/samples/bpf/xdp_adjust_tail_user.c
index 586ff751aba9..a3596b617c4c 100644
--- a/samples/bpf/xdp_adjust_tail_user.c
+++ b/samples/bpf/xdp_adjust_tail_user.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <net/if.h>
 #include <sys/resource.h>
 #include <arpa/inet.h>
 #include <netinet/ether.h>
@@ -69,7 +70,7 @@ static void usage(const char *cmd)
 	printf("Start a XDP prog which send ICMP \"packet too big\" \n"
 		"messages if ingress packet is bigger then MAX_SIZE bytes\n");
 	printf("Usage: %s [...]\n", cmd);
-	printf("    -i <ifindex> Interface Index\n");
+	printf("    -i <ifname|ifindex> Interface\n");
 	printf("    -T <stop-after-X-seconds> Default: 0 (forever)\n");
 	printf("    -S use skb-mode\n");
 	printf("    -N enforce native mode\n");
@@ -102,7 +103,9 @@ int main(int argc, char **argv)
 
 		switch (opt) {
 		case 'i':
-			ifindex = atoi(optarg);
+			ifindex = if_nametoindex(optarg);
+			if (!ifindex)
+				ifindex = atoi(optarg);
 			break;
 		case 'T':
 			kill_after_s = atoi(optarg);
@@ -136,6 +139,11 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (!ifindex) {
+		fprintf(stderr, "Invalid ifname\n");
+		return 1;
+	}
+
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 	prog_load_attr.file = filename;
 
diff --git a/samples/bpf/xdp_redirect_map_user.c b/samples/bpf/xdp_redirect_map_user.c
index 15bb6f67f9c3..f70ee33907fd 100644
--- a/samples/bpf/xdp_redirect_map_user.c
+++ b/samples/bpf/xdp_redirect_map_user.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <net/if.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <sys/resource.h>
@@ -85,7 +86,7 @@ static void poll_stats(int interval, int ifindex)
 static void usage(const char *prog)
 {
 	fprintf(stderr,
-		"usage: %s [OPTS] IFINDEX_IN IFINDEX_OUT\n\n"
+		"usage: %s [OPTS] <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n\n"
 		"OPTS:\n"
 		"    -S    use skb-mode\n"
 		"    -N    enforce native mode\n"
@@ -127,7 +128,7 @@ int main(int argc, char **argv)
 	}
 
 	if (optind == argc) {
-		printf("usage: %s IFINDEX_IN IFINDEX_OUT\n", argv[0]);
+		printf("usage: %s <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n", argv[0]);
 		return 1;
 	}
 
@@ -136,8 +137,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	ifindex_in = strtoul(argv[optind], NULL, 0);
-	ifindex_out = strtoul(argv[optind + 1], NULL, 0);
+	ifindex_in = if_nametoindex(argv[optind]);
+	if (!ifindex_in)
+		ifindex_in = strtoul(argv[optind], NULL, 0);
+
+	ifindex_out = if_nametoindex(argv[optind + 1]);
+	if (!ifindex_out)
+		ifindex_out = strtoul(argv[optind + 1], NULL, 0);
+
 	printf("input: %d output: %d\n", ifindex_in, ifindex_out);
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
diff --git a/samples/bpf/xdp_redirect_user.c b/samples/bpf/xdp_redirect_user.c
index ce71be187205..39de06f3ec25 100644
--- a/samples/bpf/xdp_redirect_user.c
+++ b/samples/bpf/xdp_redirect_user.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <net/if.h>
 #include <unistd.h>
 #include <libgen.h>
 #include <sys/resource.h>
@@ -85,7 +86,7 @@ static void poll_stats(int interval, int ifindex)
 static void usage(const char *prog)
 {
 	fprintf(stderr,
-		"usage: %s [OPTS] IFINDEX_IN IFINDEX_OUT\n\n"
+		"usage: %s [OPTS] <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n\n"
 		"OPTS:\n"
 		"    -S    use skb-mode\n"
 		"    -N    enforce native mode\n"
@@ -128,7 +129,7 @@ int main(int argc, char **argv)
 	}
 
 	if (optind == argc) {
-		printf("usage: %s IFINDEX_IN IFINDEX_OUT\n", argv[0]);
+		printf("usage: %s <IFNAME|IFINDEX>_IN <IFNAME|IFINDEX>_OUT\n", argv[0]);
 		return 1;
 	}
 
@@ -137,8 +138,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	ifindex_in = strtoul(argv[optind], NULL, 0);
-	ifindex_out = strtoul(argv[optind + 1], NULL, 0);
+	ifindex_in = if_nametoindex(argv[optind]);
+	if (!ifindex_in)
+		ifindex_in = strtoul(argv[optind], NULL, 0);
+
+	ifindex_out = if_nametoindex(argv[optind + 1]);
+	if (!ifindex_out)
+		ifindex_out = strtoul(argv[optind + 1], NULL, 0);
+
 	printf("input: %d output: %d\n", ifindex_in, ifindex_out);
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 394896430712..dfb68582e243 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <net/if.h>
 #include <sys/resource.h>
 #include <arpa/inet.h>
 #include <netinet/ether.h>
@@ -83,7 +84,7 @@ static void usage(const char *cmd)
 	       "in an IPv4/v6 header and XDP_TX it out.  The dst <VIP:PORT>\n"
 	       "is used to select packets to encapsulate\n\n");
 	printf("Usage: %s [...]\n", cmd);
-	printf("    -i <ifindex> Interface Index\n");
+	printf("    -i <ifname|ifindex> Interface\n");
 	printf("    -a <vip-service-address> IPv4 or IPv6\n");
 	printf("    -p <vip-service-port> A port range (e.g. 433-444) is also allowed\n");
 	printf("    -s <source-ip> Used in the IPTunnel header\n");
@@ -181,7 +182,9 @@ int main(int argc, char **argv)
 
 		switch (opt) {
 		case 'i':
-			ifindex = atoi(optarg);
+			ifindex = if_nametoindex(optarg);
+			if (!ifindex)
+				ifindex = atoi(optarg);
 			break;
 		case 'a':
 			vip.family = parse_ipstr(optarg, vip.daddr.v6);
@@ -253,6 +256,11 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (!ifindex) {
+		fprintf(stderr, "Invalid ifname\n");
+		return 1;
+	}
+
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 	prog_load_attr.file = filename;
 
-- 
2.17.1

