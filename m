Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD93867D8CB
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjAZWui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 17:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZWue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 17:50:34 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170438E99
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 14:50:33 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m13-20020a62f20d000000b005906b270133so1557240pfh.20
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 14:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tq3oKm2ZNiCqSD+4cGqm6lOYyg99eiR+eCWU8TDk5uU=;
        b=bl9p9CNP1MKzDtdoat2jk5k5dYP2CnohphL+SBw4+MibCEE8P+xRyqAMsA881bbsKb
         lNzJntWdH80qUyKKmytDaZdKRR4A9CgaP5VK4ECTc5E7u36KoOSMXyzYMt+oYWk4Mf4r
         N20DXOuGyY4APV3fFDC5pkIebV02eaGw5rZiIN3z4xz3119sTmuIeZnXG/+CMTouSW/K
         ofofjJ6QgIdgVEwmPG9OPEnrM0s3978GCZF7Fyk9KUBILxpx+8u9IBgMSyFSiwz+BiD6
         N5TGAVv0/38ewtFPkHfgUWqm/t9LFgM7nPIt+p8AHeN2aOLmAe3ypGTb/lViQ9cYBB7y
         AxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tq3oKm2ZNiCqSD+4cGqm6lOYyg99eiR+eCWU8TDk5uU=;
        b=mp42LLzIebT+D93YV6oqr2ucsfwumr18q39GaZ3RCy/1jcxsrkNZ7/1dJwiABxahlP
         GZ7D+wzzWPIQTgJFwuA3CoGBJGHuHe57RJEfb2VDHuJGR9XjtUKTrufzjZMNdcTACT33
         umnhSmNY6Is6eov7ilyJydi34kdupD6IdR66RjfabkiRKHK4MkRgI6k6lm3pu+e5EHTn
         Wiop65qIDQ7SHP0jhgYEa8W6ORzvX84QzNDJTPMqdYoGNcVar56zIRGfwrXLApYKcYZv
         SbL1aO29t7IhCrkpNzsH9Ktc4Vt+Po1sQq/x/QYRw4NP9x0xgsmwo/fcEmlbhDS5EKel
         3Fbw==
X-Gm-Message-State: AO0yUKVf+IznQFZQeYhxm673UyQUGRt6R3OHv5pNaALr8bKO87HIN2Ll
        zmgvyDDLFHCxpFcXZHl6c8KTf7/a7Y2oN96wG1dmAfyqGhn3U7NqbfgBWfAJbNGyfUE3zSdCGPb
        CQ+eoWfWjqchGp+vN8uhrqOvf4T3+jacl4g47X1Y2f0wnzQN2UQ==
X-Google-Smtp-Source: AK7set8+PJDqOEh6uet18ucbyc11s63tqvf2ExbnrFaIVc1D9jsyWL8GcwVxWGey6xzLFHah5DX8+mo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:8b8d:b0:225:eaa2:3f5d with SMTP id
 z13-20020a17090a8b8d00b00225eaa23f5dmr10275pjn.2.1674773432064; Thu, 26 Jan
 2023 14:50:32 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:50:30 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126225030.510629-1-sdf@google.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Properly enable hwtstamp in xdp_hw_metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The existing timestamping_enable() is a no-op because it applies
to the socket-related path that we are not verifying here
anymore. (but still leaving the code around hoping we can
have xdp->skb path verified here as well)

  poll: 1 (0)
  xsk_ring_cons__peek: 1
  0xf64788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
  rx_hash: 3697961069
  rx_timestamp:  1674657672142214773 (sec:1674657672.1422)
  XDP RX-time:   1674657709561774876 (sec:1674657709.5618) delta sec:37.4196
  AF_XDP time:   1674657709561871034 (sec:1674657709.5619) delta
sec:0.0001 (96.158 usec)
  0xf64788: complete idx=8 addr=8000

Also, maybe something to archive here, see [0] for Jesper's note
about NIC vs host clock delta.

0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/

v2:
- Restore original value (Martin)

Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 0008f0f239e8..3823b1c499cc 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -24,6 +24,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/udp.h>
 #include <linux/sockios.h>
+#include <linux/net_tstamp.h>
 #include <sys/mman.h>
 #include <net/if.h>
 #include <poll.h>
@@ -278,13 +279,53 @@ static int rxq_num(const char *ifname)
 
 	ret = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (ret < 0)
-		error(-1, errno, "socket");
+		error(-1, errno, "ioctl(SIOCETHTOOL)");
 
 	close(fd);
 
 	return ch.rx_count + ch.combined_count;
 }
 
+static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *cfg)
+{
+	struct ifreq ifr = {
+		.ifr_data = (void *)cfg,
+	};
+	strcpy(ifr.ifr_name, ifname);
+	int fd, ret;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd < 0)
+		error(-1, errno, "socket");
+
+	ret = ioctl(fd, op, &ifr);
+	if (ret < 0)
+		error(-1, errno, "ioctl(%d)", op);
+
+	close(fd);
+}
+
+static struct hwtstamp_config saved_hwtstamp_cfg;
+static const char *saved_hwtstamp_ifname;
+
+static void hwtstamp_restore(void)
+{
+	hwtstamp_ioctl(SIOCSHWTSTAMP, saved_hwtstamp_ifname, &saved_hwtstamp_cfg);
+}
+
+static void hwtstamp_enable(const char *ifname)
+{
+	struct hwtstamp_config cfg = {
+		.rx_filter = HWTSTAMP_FILTER_ALL,
+	};
+
+	hwtstamp_ioctl(SIOCGHWTSTAMP, ifname, &saved_hwtstamp_cfg);
+	saved_hwtstamp_ifname = strdup(ifname);
+	atexit(hwtstamp_restore);
+
+	hwtstamp_ioctl(SIOCSHWTSTAMP, ifname, &cfg);
+}
+
 static void cleanup(void)
 {
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
@@ -341,6 +382,8 @@ int main(int argc, char *argv[])
 
 	printf("rxq: %d\n", rxq);
 
+	hwtstamp_enable(ifname);
+
 	rx_xsk = malloc(sizeof(struct xsk) * rxq);
 	if (!rx_xsk)
 		error(-1, ENOMEM, "malloc");
-- 
2.39.1.456.gfc5497dd1b-goog

