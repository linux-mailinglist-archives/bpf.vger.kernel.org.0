Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B567BFF7
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAYWcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 17:32:10 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA385A826
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 14:32:08 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 38-20020a630b26000000b004773803dda1so8883861pgl.17
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcqx6z1kcd3e6viB+aHhZ5+sc79wOe1YQpj1kQy5xVs=;
        b=itYia700YeqbC4zyrO5oy8suQixVgZWGmNi4fvUTaSPsZ92LH/U3gQzKiOxMXjcH+3
         Dv74xc7WYVDvx5iZwQOL4yHXVZXW94d2ipYbQXX8n4oMU3/WcRI6V8Z1ZsjQfwTo7QKQ
         pB37L43Uiw1I//fyizPMpZpiGZHV3OV9O5lZHS25JdyMXqpMomFSXtKxWB042NGAcEmI
         VqPi2iRIuxIoBCBXbv7SrmLMkSDlEbANZS0X4zhjiDLgQdwFWTLGTP0DISYY2MMsp4Ak
         aiCj8dVvpDdAzTCQZpFD/aJGLK0F3EGKcGM80QrmCdyhcMe0QeCCTEK4N2fYNJePVRU6
         8esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcqx6z1kcd3e6viB+aHhZ5+sc79wOe1YQpj1kQy5xVs=;
        b=mt6Y13B6hGKOgbeIdjQqSR0vIxWVeFJ8QR/HLhGxku/RQ9Qy1kka+vJ5E3AdFUbbPR
         Oi7hSvEgenK3zD0gphVn/9GhcIg7DkFX8CLC1s1Tk3Bc6yGGam5+eQowCgmh5mFzAl9R
         N9OzRpFUV67tduhaxebX9OWPAFHVbsnIjJzkl3COYanbnV7v8PCImH1Ioip/Bj+OzE/S
         Sh/M68X4dLYUzIfKJIJammy3zw6Z2CRDyI2J5tCVjljeG3ClA7cymP00FOcPgfHQF7az
         /ZOoXGp3NkNqvCRiDGf9jrY8/mjt4jHzpBx57OhtgJME2ra3Fg5Md5wPjr4I18ikCBtO
         g93w==
X-Gm-Message-State: AFqh2krvP1c5znGRyIUqyoSfvDO1qNch2C+SYgcH3n7uD4bw4zm/9apf
        1VUkeV4e/Sp2bVI7YWJLH7KjvL++wH7om/83vC4jQyLRe3HoHVUts5OnOrYLLx7RpezzmlY1dJ2
        BkCH1n12O3AOIkHxrHnz++OCNw+Wkmmf4DsvzSOQtuTQHdEokFA==
X-Google-Smtp-Source: AMrXdXv7PspxhpsCu8qz4hek5n1U9/yedDTmXRRsw+xTKXzJOPfuY1G3l++cTRXgBx+M9KcrNwbsIEw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:b96:b0:58d:b8f6:6f6d with SMTP id
 g22-20020a056a000b9600b0058db8f66f6dmr3507366pfj.32.1674685927905; Wed, 25
 Jan 2023 14:32:07 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:32:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125223205.3933482-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Properly enable hwtstamp in xdp_hw_metadata
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

Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 0008f0f239e8..dc899c53db5e 100644
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
@@ -278,13 +279,36 @@ static int rxq_num(const char *ifname)
 
 	ret = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (ret < 0)
-		error(-1, errno, "socket");
+		error(-1, errno, "ioctl(SIOCETHTOOL)");
 
 	close(fd);
 
 	return ch.rx_count + ch.combined_count;
 }
 
+static void hwtstamp_enable(const char *ifname)
+{
+	struct hwtstamp_config cfg = {
+		.rx_filter = HWTSTAMP_FILTER_ALL,
+	};
+
+	struct ifreq ifr = {
+		.ifr_data = (void *)&cfg,
+	};
+	strcpy(ifr.ifr_name, ifname);
+	int fd, ret;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd < 0)
+		error(-1, errno, "socket");
+
+	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
+	if (ret < 0)
+		error(-1, errno, "ioctl(SIOCSHWTSTAMP)");
+
+	close(fd);
+}
+
 static void cleanup(void)
 {
 	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
@@ -341,6 +365,8 @@ int main(int argc, char *argv[])
 
 	printf("rxq: %d\n", rxq);
 
+	hwtstamp_enable(ifname);
+
 	rx_xsk = malloc(sizeof(struct xsk) * rxq);
 	if (!rx_xsk)
 		error(-1, ENOMEM, "malloc");
-- 
2.39.1.456.gfc5497dd1b-goog

