Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5B2D43E1
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLIOFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 09:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732673AbgLIN7J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 08:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8DLLPviF9h72fPL9/Hm3sEntx53yIBaT2WZkb5ZEsg=;
        b=DimcBlsLCqQTA/wqmG9EGQAUmQEfCByCNBcrw5bz5gQgVtgnMAay9Nxr6PZyYayU/COF+7
        RN7NS8qR5IHL7kxTiu5WeUHrbG2TFhUZ+AQP36f6mNJY2PudGLkUMIfObiDZpCPYdt5ENf
        Uhfm3B8TvYRA4BXkNcpLxJaiIu/fl4k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-Wo-L2p37MOO93AbsYZquDg-1; Wed, 09 Dec 2020 08:57:41 -0500
X-MC-Unique: Wo-L2p37MOO93AbsYZquDg-1
Received: by mail-wr1-f72.google.com with SMTP id q18so683989wrc.20
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:57:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s8DLLPviF9h72fPL9/Hm3sEntx53yIBaT2WZkb5ZEsg=;
        b=TXWJoxRZwYLG9HLqg9/Np305tuRwGaXkIar+C48GR+AFzZOJrXvnN9yyqF/FaR9NW3
         ym548q6FkVFbq13qyI+wO848dH9Be8UyMdzEAz+MAVRk8sOYTg9UvKh7zOECb9WizjID
         WRUYmBgPP8YCMC7yH3US/UhdkAseVqZdsx8ADntc213mJ9zKwu518o/B+x8tg2RiwVT2
         LEAhr/hTFl7panwbmI2d/venVgs/lr+lKoexxXENzNXiE3/Ootrqk1G01HIclcNaG3l7
         hxLV3N8grl2T7IEH1YTeFpMF3mLWpEM81wTXrwQ4lP91y9U/fNuCucEO+EWIVrpG/jHS
         V9pA==
X-Gm-Message-State: AOAM532Ng/ItMOiTa6NHz/6kxnW3q47qwK1fvOP5EScgPwbDeOBrZfIv
        5EqCPDdFhZE4IsSbITNFT+FXROgYZ06fLLvJwRndIQxQDrxZMld/5Ds4+dzmV6He5AqHp/hIOKq
        PglfAIgLZqmq0
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr2882632wme.63.1607522260002;
        Wed, 09 Dec 2020 05:57:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO/G3tcWg1/kHoeIKINuHsxqIStR6nsk3t1JtFt454JispYcOkpfDWuj4fAFjTX94Eakgfng==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr2882599wme.63.1607522259585;
        Wed, 09 Dec 2020 05:57:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j2sm3756224wrt.35.2020.12.09.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:57:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D158180004; Wed,  9 Dec 2020 14:57:38 +0100 (CET)
Subject: [PATCH bpf v4 2/7] selftests/bpf/test_offload.py: Remove check for
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
Date:   Wed, 09 Dec 2020 14:57:38 +0100
Message-ID: <160752225858.110217.13036901876869496246.stgit@toke.dk>
In-Reply-To: <160752225643.110217.4104692937165406635.stgit@toke.dk>
References: <160752225643.110217.4104692937165406635.stgit@toke.dk>
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

