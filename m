Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB402CE0EB
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbgLCVgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387867AbgLCVgx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 16:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607031326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Bq9B1pIhYYZLlciYIdpPVKZPo9SS6y4k1LZd1EeU0w=;
        b=Kl6Uc3SLlD+fYn9wL0Ur2Kp2pV94UsphYSQK9mrLAr4eX9YVWxz1/mfY7T83I4AFD0zc+T
        83kzyW7fT9NLduXdUrR5Xf8L3xnwqQYwSNCZNGYU89HtXRAOHA9ILndJ7fZcjcJtA6emeW
        6HqY1ynZFzEMFrmP9FrkhtcYdITZ5Zs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-g2enxigsMByZmEN6myIIyQ-1; Thu, 03 Dec 2020 16:35:25 -0500
X-MC-Unique: g2enxigsMByZmEN6myIIyQ-1
Received: by mail-qt1-f198.google.com with SMTP id f33so2715646qtb.1
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=6Bq9B1pIhYYZLlciYIdpPVKZPo9SS6y4k1LZd1EeU0w=;
        b=XyJLknb2OFLr1fjERziHInwgweJ0MqfyFjJocnN1CwWK3Gv8Wv2Q9kTjsTsZEVuqpr
         GLmxt10qax0dVIajOjsnqqBojqYf8SHP4ef7R/diayMfyY2fingAJCgCcjAogcEYVVLg
         1hhyZ48jzhQSeJJcbp82d79vzAZ+DWKxlTOde35DDmE1tttPWqzuU25RHv85BZJdePKm
         qmIwdd65YfvWjNdRcxtO3P1YrBm3wlcgD9oO+prpCixHrRYiR5xP6/7TfylTUupwstiF
         s1UoN0rb3+HSU7WY/6/qs/swH1RIQeBRPmtJXFQdXz64GD63eoxcu05n+Bm70dNy/w9A
         L/ug==
X-Gm-Message-State: AOAM533gnHYlWfFsWRpV/bZ25XOheYsqiU9kloa9uzFEJlyja8BetbcH
        UiCxUY5tx0886k7yd7kNBLityH6irQ1N4pWZ5tTPDpMwOFwVnWPX50nwQMF+6z0tu+aig6Duiex
        EjUPx6aJIM1WM
X-Received: by 2002:ac8:4998:: with SMTP id f24mr5574523qtq.30.1607031324220;
        Thu, 03 Dec 2020 13:35:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3x4fFB+vOzBIHHzH7WpznYoXedCpBDcNWaY/1TcEuwaAipgK4HGjehaqTvmfAcgpZIMeerw==
X-Received: by 2002:ac8:4998:: with SMTP id f24mr5574494qtq.30.1607031323844;
        Thu, 03 Dec 2020 13:35:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c68sm2888642qkb.17.2020.12.03.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:35:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 58A981843EC; Thu,  3 Dec 2020 22:35:19 +0100 (CET)
Subject: [PATCH bpf 2/7] selftests/bpf/test_offload.py: Remove check for
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
Date:   Thu, 03 Dec 2020 22:35:19 +0100
Message-ID: <160703131928.162669.17738060161862930826.stgit@toke.dk>
In-Reply-To: <160703131710.162669.9632344967082582016.stgit@toke.dk>
References: <160703131710.162669.9632344967082582016.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since we just removed the xdp_attachment_flags_ok() callback, also remove
the check for it in test_offload.py

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 43c9cda199b8..7afe259c785f 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -716,14 +716,6 @@ def test_multi_prog(simdev, sim, obj, modename, modeid):
     fail(ret == 0, "Replaced one of programs without -force")
     check_extack(err, "XDP program already attached.", args)
 
-    if modename == "" or modename == "drv":
-        othermode = "" if modename == "drv" else "drv"
-        start_test("Test multi-attachment XDP - detach...")
-        ret, _, err = sim.unset_xdp(othermode, force=True,
-                                    fail=False, include_stderr=True)
-        fail(ret == 0, "Removed program with a bad mode")
-        check_extack(err, "program loaded with different flags.", args)
-
     sim.unset_xdp("offload")
     xdp = sim.ip_link_show(xdp=True)["xdp"]
     offloaded = sim.dfs_read("bpf_offloaded_id")
@@ -1001,16 +993,6 @@ try:
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

