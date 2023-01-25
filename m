Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC867B80F
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 18:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjAYRKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 12:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAYRKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 12:10:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5559740
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:09:24 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A40DD3F2D3
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674666558;
        bh=1pZvzv+KflAf7vIEa8jpMx+2B8SROeL8aqXFHfenOiI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vFI/KKjqYsuAs63k+4BfD4iZOHsp1ueoiEY4Okr3exXgQG9ZXas3U6jfsyPHfqC+v
         FONpujZbkrX9DfVaXUpWUdPu7mkz+VQTnvFZYyAFRnn9iWyOok6AHkeWd10XAFNDUG
         fd40OyqK7ErgBjzKxRiasD6kR2jNEzpe7DwGCUNyaMr07ZL32XtSVWUarAPuDU48Yo
         d4htGFNqdzr2hI0GeDNHAsng7FHXn4C0dQ80pyyzyGXUuwf6h9OfJ1cEXwI/YyC3r2
         iLfrT6G+T4t05bfm6nPL9IFsg3Rv3wkAFTztN0Zbuqj+Q8ESaKSsvxHP1fmoh/zsJ7
         YPUHPRkzuzZnA==
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003da1f6a7b2dso1399956wmb.1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 09:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pZvzv+KflAf7vIEa8jpMx+2B8SROeL8aqXFHfenOiI=;
        b=xIkPpN8Ef9LyNpGx5suACra+rQDfC4CiUfPdBKThMuCDGw5nYjzTTqycte23OVlpQg
         bir2+3PTPa9EumpCA8SOcXPRStypBbJlgtWahgSjypZ7qOTZMgjbJmGgOWNcCGr5w6l8
         vSVZUtHOUKeIa86ouNVJ+xRiV3QZtDOmFc2eULBxwmbas+0SCAKpubR40V7mUNXN8f9X
         PRNdlQTWAqTzxu1Fikl2gAtBkgMbOvbq/x3SKThm2YrdWs+FYcmZXUZlgt3b+FNlhuaH
         NmmcYzpvT6QpJXe4k/BTBmabAgPjFgkPtN3tV5vlRzW7x/oHlrK1PLcHBK8XsTIeuX1g
         lECQ==
X-Gm-Message-State: AO0yUKUV68VB+uEzS7UqOARKrwiv9/htCd8AyDrmCe5eIEMlymJfgORG
        tLyt9UUvpVngIRH6R+XyTdt90NmF0QAk9sUqxqohLiiYsiYyG0WYFncTxAHtBjA2IOrAKbc2IZI
        M2vV8ryn9PvbGUFTtjdj6FC5Zxn2A2g==
X-Received: by 2002:adf:eb12:0:b0:2bf:b1f6:7db7 with SMTP id s18-20020adfeb12000000b002bfb1f67db7mr4974002wrn.27.1674666558389;
        Wed, 25 Jan 2023 09:09:18 -0800 (PST)
X-Google-Smtp-Source: AK7set9Yau3RcyKrwSYnXVLJqxfF8rJF5bNvRjqoqFOjcS5MQWnt1HjAo3+zYU12Y7dMZhpvZJf3yg==
X-Received: by 2002:adf:eb12:0:b0:2bf:b1f6:7db7 with SMTP id s18-20020adfeb12000000b002bfb1f67db7mr4973985wrn.27.1674666558143;
        Wed, 25 Jan 2023 09:09:18 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id a3-20020adff7c3000000b002bdc3f5945dsm4793280wrq.89.2023.01.25.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:09:17 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei <andrei.gherzan@canonical.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 1/2] selftests: net: Fix missing nat6to4.o when running udpgro_frglist.sh
Date:   Wed, 25 Jan 2023 17:08:44 +0000
Message-Id: <20230125170845.85237-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrei <andrei.gherzan@canonical.com>

The udpgro_frglist.sh uses nat6to4.o which is tested for existence in
bpf/nat6to4.o (relative to the script). This is where the object is
compiled. Even so, the script attempts to use it as part of tc with a
different path (../bpf/nat6to4.o). As a consequence, this fails the script:

Error opening object ../bpf/nat6to4.o: No such file or directory
Cannot initialize ELF context!
Unable to load program

This change refactors these references to use a variable for consistency
and also reformats two long lines.

Signed-off-by: Andrei <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/udpgro_frglist.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index c9c4b9d65839..1fdf2d53944d 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -6,6 +6,7 @@
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_NAT6TO4_FILE="./bpf/nat6to4.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -40,8 +41,12 @@ run_one() {
 
 	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
 	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
-	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file ../bpf/nat6to4.o section schedcls/ingress6/nat_6  direct-action
-	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file ../bpf/nat6to4.o section schedcls/egress4/snat4 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol \
+		ipv6 bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/ingress6/nat_6 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol \
+		ip bpf object-file "$BPF_NAT6TO4_FILE" section \
+		schedcls/egress4/snat4 direct-action
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
@@ -88,7 +93,7 @@ if [ ! -f ${BPF_FILE} ]; then
 	exit -1
 fi
 
-if [ ! -f bpf/nat6to4.o ]; then
+if [ ! -f "$BPF_NAT6TO4_FILE" ]; then
 	echo "Missing nat6to4 helper. Build bpfnat6to4.o selftest first"
 	exit -1
 fi
-- 
2.34.1

