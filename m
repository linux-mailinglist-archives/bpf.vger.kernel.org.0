Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8867461E
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjASWdQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjASWcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:16 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952AAA5EB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:49 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m7-20020a170902db0700b00194bd3c810aso2062981plx.23
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVmBv6n1yWhw6xb7kdgIkQjazkcMJ0jEx+B+OPrm+s=;
        b=Ksz0kEMcH940hdwk/Ayvr3beOSD13KPAZuFiwab9mSkUUfoYDEQtzZ2LzAWZsU4Z/v
         UK3zUnyqTf+GfEUDwLP7h7Sg5WsWJH3QOZguFgOLqHAWLHFoFL945LU2RxQ7nij3yiCw
         gC4ZGjyVp06xNd2n4mXY8BaCpupr/b5U30gKqHR4aJTwuWrHSVb7Q/Utt789EJZgswFb
         bW8J8hhSHF03x9kcDuNi+jiCLsnIYTrRAr4+RZ2kwvEyQqwsTtxxgbLdk5fl+pbSPksq
         BAB7k4SKUgTMOaI/km53xAQSWMdmHxCf3w4QHD3N/r0fcYuEQ47Nl09cfU7o8dO6auDW
         MOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVmBv6n1yWhw6xb7kdgIkQjazkcMJ0jEx+B+OPrm+s=;
        b=6kcwFKBreipdGzYwQdhGErBvC//ALLjiu5D4CpDTKDLWWf0kS1/jEMOjdrJBFpuJtO
         pb+jI/sYh0wgzXuEazkiBSVbPceK78+ao0S/FHUvCYheCdfnKU3cXX/Mm19V/tEWVtuk
         bcOEp5RRcJ9D2uk8Gm7G4+2oBXZ0tb39NTw4ndl9UUBPkUyQyFYpxWW0T8pKxHhcqSsg
         iM4mXjZUZQDZrkC8SATdbeTR55qbQkMQ7oO7x+t2HEOv719BNkfkQE56U2MaKo0hQeop
         kpnFva/3HSkAfQFE+WEZ1iD/6SE2HvbUNoYYZoElKQoYeaViZ1xa7flpgCRLm4YIVJcL
         Sapw==
X-Gm-Message-State: AFqh2krkY6YJAbEfwzXl5oKt0nSEM47cqWekjKnCGZM7jwSn2do5umCH
        0XUjzf0vqNSMBSP/ErxM9UW1x60xyJgeGWOF5KqoLixAKy9VpT8/7iD77WVTkbWIwI0k1NmF0u9
        yAdCNBvNho705lfuo5EujLHh/029KIgQgzuqmP9Smbsqs8NSHPQ==
X-Google-Smtp-Source: AMrXdXtYG6XYudga/1qUvayFl3zZELMUnbf9QFMDzEfZUKXolfRrcqc9wXwoWaJ0lM7SXkO9RZwcut8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2350:b0:192:b09c:e066 with SMTP id
 c16-20020a170903235000b00192b09ce066mr1219079plh.2.1674166548372; Thu, 19 Jan
 2023 14:15:48 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:15:25 -0800
In-Reply-To: <20230119221536.3349901-1-sdf@google.com>
Mime-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119221536.3349901-7-sdf@google.com>
Subject: [PATCH bpf-next v8 06/17] selftests/bpf: Update expected
 test_offload.py messages
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
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

Generic check has a different error message, update the selftest.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_offload.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 7cb1bc05e5cf..40cba8d368d9 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -1039,7 +1039,7 @@ netns = []
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
     fail(ret == 0, "attached offloaded XDP program to drv")
-    check_extack(err, "Using device-bound program without HW_MODE flag is not supported.", args)
+    check_extack(err, "Using offloaded program without HW_MODE flag is not supported.", args)
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 
@@ -1088,12 +1088,12 @@ netns = []
     ret, _, err = sim.set_xdp(pinned, "offload",
                               fail=False, include_stderr=True)
     fail(ret == 0, "Pinned program loaded for a different device accepted")
-    check_extack_nsim(err, "program bound to different dev.", args)
+    check_extack(err, "Program bound to different device.", args)
     simdev2.remove()
     ret, _, err = sim.set_xdp(pinned, "offload",
                               fail=False, include_stderr=True)
     fail(ret == 0, "Pinned program loaded for a removed device accepted")
-    check_extack_nsim(err, "xdpoffload of non-bound program.", args)
+    check_extack(err, "Program bound to different device.", args)
     rm(pin_file)
     bpftool_prog_list_wait(expected=0)
 
@@ -1334,12 +1334,12 @@ netns = []
     ret, _, err = simA.set_xdp(progB, "offload", force=True, JSON=False,
                                fail=False, include_stderr=True)
     fail(ret == 0, "cross-ASIC program allowed")
-    check_extack_nsim(err, "program bound to different dev.", args)
+    check_extack(err, "Program bound to different device.", args)
     for d in simdevB.nsims:
         ret, _, err = d.set_xdp(progA, "offload", force=True, JSON=False,
                                 fail=False, include_stderr=True)
         fail(ret == 0, "cross-ASIC program allowed")
-        check_extack_nsim(err, "program bound to different dev.", args)
+        check_extack(err, "Program bound to different device.", args)
 
     start_test("Test multi-dev ASIC cross-dev map reuse...")
 
-- 
2.39.0.246.g2a6d74b583-goog

