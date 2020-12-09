Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346172D43B5
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgLIN7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 08:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732682AbgLIN7O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 08:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MU7CQgT+A+S9BhvCz6Q80+yj2qZjKz+oqKrOC0MV6ss=;
        b=Xt56fOmUNxsnxzP22bTAZq666xnyBd1FKVlX+CWEyVM12V3QBC8JTtqPqMRlOF1ZhdEThP
        7tyslRw3M/cfyq/A8UdJugTr2Izf2kzvvRwP/Sw0QPbporDUTF9fSOXhegTukq0XDikqQz
        QYIT4Z0n2D2ZoJeKU8JtZRVvwLZv6Wg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-e-q0hz9qMu6Ts8KIcbLbUA-1; Wed, 09 Dec 2020 08:57:44 -0500
X-MC-Unique: e-q0hz9qMu6Ts8KIcbLbUA-1
Received: by mail-wr1-f69.google.com with SMTP id v5so703791wrr.0
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MU7CQgT+A+S9BhvCz6Q80+yj2qZjKz+oqKrOC0MV6ss=;
        b=FFDW6vi7c5pU6n1Dbmw2dA+5LBpgRVne9ovcCCq3x3b7HibbjV2XBNM0tNxJrheGg5
         dUVnnE7/r0cz8NzyRiWJPTOQKwaOvbfmzaDO9QrFp2DpTsmBS/fkGmMAnDh4mAWzO92h
         qu+WuB+FxwFyGnyA3P0b0dMtGkxU9uCRICOJ/+DQ2FQs+GAKjSQ+NqcCRYmPVEEFCJ+9
         7vKpuFsJN5/gN5IE0JLZ3/OLxwhlCniBspnZqUs1vkAjVN+ivRCJDs51UMKMRpmsW7sV
         z+JtjutqRywEo50f1rMRe2BbaSKRfJwLIjyMP8CHUqYOJxww94JRrxnHv59iz607h+6d
         sjow==
X-Gm-Message-State: AOAM530juz8HgyMf2Jn/2L796EOJdgrhLZjRGAcIwSZ9hbzosvHpERA2
        mcsPXQjaiGlzGSTLOM945Nc2va5otOlqN1S+WQEnnwulLrLUX7lk9k0yRrODW6ukQE1Xk4CStuC
        pp+/ka/kwpqSk
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr2907518wra.252.1607522262873;
        Wed, 09 Dec 2020 05:57:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEdQcGyzmkPOb0WiJgxV3ltkO/5FZhc3UVm9wXnk0V2hSLZwg/ifKKfI1NBVNaOt6phydLHQ==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr2907473wra.252.1607522262599;
        Wed, 09 Dec 2020 05:57:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a21sm3422827wmb.38.2020.12.09.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:57:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C48CD180003; Wed,  9 Dec 2020 14:57:41 +0100 (CET)
Subject: [PATCH bpf v4 5/7] selftests/bpf/test_offload.py: fix expected case
 of extack messages
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
Date:   Wed, 09 Dec 2020 14:57:41 +0100
Message-ID: <160752226175.110217.11214100824416344952.stgit@toke.dk>
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

Commit 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs
in net_device") changed the case of some of the extack messages being
returned when attaching of XDP programs failed. This broke test_offload.py,
so let's fix the test to reflect this.

Fixes: 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs in net_device")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 61527b43f067..51a5e4d939cc 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -1004,7 +1004,7 @@ try:
                               fail=False, include_stderr=True)
     fail(ret == 0, "Replaced XDP program with a program in different mode")
     check_extack(err,
-                 "native and generic XDP can't be active at the same time.",
+                 "Native and generic XDP can't be active at the same time.",
                  args)
 
     start_test("Test MTU restrictions...")
@@ -1035,7 +1035,7 @@ try:
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
     fail(ret == 0, "attached offloaded XDP program to drv")
-    check_extack(err, "using device-bound program without HW_MODE flag is not supported.", args)
+    check_extack(err, "Using device-bound program without HW_MODE flag is not supported.", args)
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 

