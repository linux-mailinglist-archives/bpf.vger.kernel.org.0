Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13E2D40DD
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgLILUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 06:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729887AbgLILUL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 06:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607512724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8DLLPviF9h72fPL9/Hm3sEntx53yIBaT2WZkb5ZEsg=;
        b=jKoOkqandHWLIxwUNUHx7uBwbWKXF5lcVO6GBtYbgaNZgOARf+St3NtvjSJjX6AXwztAdW
        Isj8naeoY5suk+dccVjjiMpCceiM46zoRkJteTeo8nRJXX2309q1tI0amRa+Ua2cv/iO+m
        PfiY9+x2pX+fohuEPXvvl+HWPwRa4yg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-HFOXPRntP3WOLpdV2Ns1OQ-1; Wed, 09 Dec 2020 06:18:42 -0500
X-MC-Unique: HFOXPRntP3WOLpdV2Ns1OQ-1
Received: by mail-wm1-f71.google.com with SMTP id k23so439238wmj.1
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 03:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s8DLLPviF9h72fPL9/Hm3sEntx53yIBaT2WZkb5ZEsg=;
        b=BNDYIiBSsQNEC9AqtkztHG+zXrtObFgDbA6Df99gjfYx8oYq9fL3CJ/QMJ+JOLcaj7
         V/Cz7LLouQnljQgFPWGYofTjpmax8vjWtMmbQBQgNaKMy/yaYni6E3sScCL1VvT00ofZ
         evOX1PakIHR2YkFYe15RVX1nQLGLmU1JfSXfLTtIWI5naoKgiZ7nGK+Em9kyqokdJDtO
         X+2oEzrVROlzaDkWWmya/YnM6I52QOnJMoAcUuYKJA6S9n4r/Be4nEBv661bhT7W5dwA
         OTunVTvpR2qv2LU8iS1ysvkL3xubhe80KN/lRhNu2fKyLodA8xiEwiww3mTiCGuvNlzX
         VOTA==
X-Gm-Message-State: AOAM532Mnp2OnrCl0YiEuRtJMxnEamzNrASumy2u8qWhtadLvpoIF4or
        is21C/ibowDvN9w27CpswuV4JELBWjtHaksAyKsnKXQM37jzkt1xR2Ri2Bo3seq55CAAl3WZ18S
        maHd95n5k7NRH
X-Received: by 2002:adf:f08a:: with SMTP id n10mr2125750wro.142.1607512721744;
        Wed, 09 Dec 2020 03:18:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0+3pof9UTo3XYyH121XixbuW1FBW+oG2DWZ/KmUgwij6v8Q7tM4hPPFxpP2i3YuHZGgj9yQ==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr2125719wro.142.1607512721573;
        Wed, 09 Dec 2020 03:18:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l7sm2721839wme.4.2020.12.09.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:18:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4074A180068; Wed,  9 Dec 2020 12:18:40 +0100 (CET)
Subject: [PATCH bpf v3 2/7] selftests/bpf/test_offload.py: Remove check for
 program load flags match
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:18:40 +0100
Message-ID: <160751272018.104774.8600625429164016287.stgit@toke.dk>
In-Reply-To: <160751271801.104774.5575431902172553440.stgit@toke.dk>
References: <160751271801.104774.5575431902172553440.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since we just removed the xdp_attachment_flags_ok() callback, also remove
the check for it in test_offload.py, and replace it with a test for the new
ambiguity-avoid check when multiple programs are loaded.

Fixes: 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs in net_device")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |   22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 43c9cda199b8..becd27b2f4ba 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -716,13 +716,11 @@ def test_multi_prog(simdev, sim, obj, modename, modeid):
     fail(ret == 0, "Replaced one of programs without -force")
     check_extack(err, "XDP program already attached.", args)
 
-    if modename == "" or modename == "drv":
-        othermode = "" if modename == "drv" else "drv"
-        start_test("Test multi-attachment XDP - detach...")
-        ret, _, err = sim.unset_xdp(othermode, force=True,
-                                    fail=False, include_stderr=True)
-        fail(ret == 0, "Removed program with a bad mode")
-        check_extack(err, "program loaded with different flags.", args)
+    start_test("Test multi-attachment XDP - remove without mode...")
+    ret, _, err = sim.unset_xdp("", force=True,
+                                fail=False, include_stderr=True)
+    fail(ret == 0, "Removed program without a mode flag")
+    check_extack(err, "More than one program loaded, unset mode is ambiguous.", args)
 
     sim.unset_xdp("offload")
     xdp = sim.ip_link_show(xdp=True)["xdp"]
@@ -1001,16 +999,6 @@ try:
     check_extack(err,
                  "native and generic XDP can't be active at the same time.",
                  args)
-    ret, _, err = sim.set_xdp(obj, "", force=True,
-                              fail=False, include_stderr=True)
-    fail(ret == 0, "Replaced XDP program with a program in different mode")
-    check_extack(err, "program loaded with different flags.", args)
-
-    start_test("Test XDP prog remove with bad flags...")
-    ret, _, err = sim.unset_xdp("", force=True,
-                                fail=False, include_stderr=True)
-    fail(ret == 0, "Removed program with a bad mode")
-    check_extack(err, "program loaded with different flags.", args)
 
     start_test("Test MTU restrictions...")
     ret, _ = sim.set_mtu(9000, fail=False)

