Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982FC6528D9
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 23:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiLTWVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 17:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiLTWU6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 17:20:58 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E301DF88
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:20:57 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p6-20020a170902e74600b001896ba6837bso9961848plf.17
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 14:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Du1KYnr7Moi/U3hIPL9DDDUf7OPxblLIVYbFH0ndSJg=;
        b=ri7Xb+bkAJiHp1jBXuVSlRN0tKijGZS0LBTjxxHNyyqWaIFfqYPv0Q/SCl2ZRFwMPm
         gTwi9I65ZEOL5vKNKiitNZqqSbSihgju5/32OCCEMYL3dHyOzX2pSTZKfui0qWY+Y2VU
         ar7Dn3jObHP52hTDUqkPFOhmBW2nRjgh7SBI5Hum03apTGjArCA2drk1Oc3PhLN+pZ1Y
         zclvLUU3mAV3+1CS4ZxFWDmbs5HnrWH+pGUy9iK2iU1uzoWprBJVcoyh+te4jTVd/RYo
         fZJaF9rzWPkLADvRkSKWrXev0tc+mfY1DspAXfslUVttJ8dSuoXNDsAHoA1ZcZJyzwdc
         6MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Du1KYnr7Moi/U3hIPL9DDDUf7OPxblLIVYbFH0ndSJg=;
        b=qE8uq9e0QxgBaYF6yqmpJ3Izp3uhyyJCeq9NfQCoKm+sDEWmqX6vsdTOCym8QQ9l8M
         rj40Q6I3W+pwHnFSjZJeljoFMGwqryZXq4FueQLM1/SaiRETsZolPadku5IJ1kAevDPg
         ZL1jMUvqrM5bVdKMbi4NlT8cIrNhJZcQkorANzuJUbxBGG5//UlyJtB3OyskSQRhxCyP
         sXt5IaOMDXIvDoF/Enj8WTDAAm1mMDmLkIHjuKYOItJ8SOUgt8h7+dju/6bLvYsLlGt7
         cUpYyF5XxIjqHpPA5BBu6pKYnOGcEJDD5k5HehRIWNEkW3SOJ0H4pzGqmesdlh25oBPW
         APFQ==
X-Gm-Message-State: ANoB5pm6pYbtCCEjinlrKLJjIMhTZ/xDsU4WJ2JBZl9k2zDcU0Ca5Krd
        uh23wpMDEM9qynbZX5gtYOaPNOniO2Q+zkBp1OqJYem3X1VPwELmJaHJfRRVuOclz9YqnhnG4Xl
        K4W6sqpa9d6KISUmSf5gpTObnb0lGGBmtMhNt8AwOhmS3QFyGPg==
X-Google-Smtp-Source: AA0mqf6iolMgejfctGTDoe16hwGrPgzedqIHe0lF7Vr8NyGoVA6+J6CkoRb0x4Jf/BOAW1ZpkSuAhOQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:1812:0:b0:56c:afe:e8bf with SMTP id
 18-20020a621812000000b0056c0afee8bfmr82017566pfy.51.1671574856441; Tue, 20
 Dec 2022 14:20:56 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:20:32 -0800
In-Reply-To: <20221220222043.3348718-1-sdf@google.com>
Mime-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220222043.3348718-7-sdf@google.com>
Subject: [PATCH bpf-next v5 06/17] selftests/bpf: Update expected
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
2.39.0.314.g84b9a713c41-goog

