Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27F6667AC
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjALAcw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjALAcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:32:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F613C0D1
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:42 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id d10-20020a631d4a000000b00491da16dc44so7384718pgm.16
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Du1KYnr7Moi/U3hIPL9DDDUf7OPxblLIVYbFH0ndSJg=;
        b=g6cIEfFmuECFhSbwVASVdyFGZETDXVuxSRk5ijS3UT3nPJuEuldPQo/11j1GwkQ5AQ
         GpLqXm3ZhEA2sK5+OXuPMb05VTLxB/A2rjeT7YPBKaRdMZqxW2Fx/rbRfzVksm2beFea
         QuMXprtlPnBdEItdKDlccxebvyftXQbHyInCRuBCSUDmfkYy7rCGZXZ/IlVPvOGq87NE
         9H7tz78W59FEBoI7ieNxbHA0tJqPHhOF3U7MSL+ggRRTPoC8PtzTAOoOCf8m5rLxait1
         KSC3864dCUHYa14Cq13FSOs/LPguObSVPreTK1EsRpiany7tWTNrt9y4yiREh5wQ0guj
         EjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Du1KYnr7Moi/U3hIPL9DDDUf7OPxblLIVYbFH0ndSJg=;
        b=PtFG90TZ0jhlcdl5TxJtcz/OvA0Op5wU/NZ6m8vZ4p0Pd2V9cl5a6db5TotbzOLHXH
         VJ6cDvtQlZ/CoHZa7qSKqnOvkVlTP0NgjbaxwROgQP8xugi7NrQNUmvSXjnHzYDE783h
         8FPJfxBkW3bh8lI4S+kVnINuTDZ2bMUbRjzA5ayhE9Bb1hF3DB6mpbW5xCfNaR5r/IEi
         ERmLdWJ0nmcuR204gRSp5jFWqhl1TFhV/J/bClJoQXjnBiPS9k8FvMzWqJDJ6oABa8VV
         DfmqS9nqc0sekMO14QbGRukNU9sGyep2vofequJYRBwcSCZNPeRgV4Toh8qZPX+jZJwk
         Ql7g==
X-Gm-Message-State: AFqh2krTkdHaqTnfYna1mKt6qSTUKtGs9XTLda/iR9xgWwt++wPV05WE
        P6dK8jBu3YLha6bWxWvIB/smhT2afFeJ5AObntVvPsd2jjUvNSXNoCUvW6itIFJXfhgbcXrFAur
        225ufSOPfzCeprXyIxRAzV1wqLV9ntdNMg0oaJecoPejC1jX1mA==
X-Google-Smtp-Source: AMrXdXtbtblYvitHKbSMydRgTE88wuU4Iyi992EAwR6ukld9satlK9+Cww6r9T5rkbmDsACbEupOY+I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:8218:b0:192:c6aa:b039 with SMTP id
 x24-20020a170902821800b00192c6aab039mr3071633pln.123.1673483561755; Wed, 11
 Jan 2023 16:32:41 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:32:19 -0800
In-Reply-To: <20230112003230.3779451-1-sdf@google.com>
Mime-Version: 1.0
References: <20230112003230.3779451-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112003230.3779451-7-sdf@google.com>
Subject: [PATCH bpf-next v7 06/17] selftests/bpf: Update expected
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

