Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1920E2D4116
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 12:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgLIL2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 06:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730654AbgLIL2c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 06:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607513225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MU7CQgT+A+S9BhvCz6Q80+yj2qZjKz+oqKrOC0MV6ss=;
        b=Rsgik8NyiOdJ+bU1wHPrYt17GP69RQYhSR1gWklejo/zJWhEZf42c54dxhdzoZvArwth1x
        a7S2L1QzBv8AlrR5UhzXUioZO1g3In8LtarAt01S/qnNDpyXyimLLORjBaaCwgttWuFewz
        skJHZd3zCyzh9x14bwgD6u6O7VuKvYc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-1_CpuUmQMByFH43_RgSPSQ-1; Wed, 09 Dec 2020 06:27:03 -0500
X-MC-Unique: 1_CpuUmQMByFH43_RgSPSQ-1
Received: by mail-wm1-f69.google.com with SMTP id k23so447631wmj.1
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 03:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MU7CQgT+A+S9BhvCz6Q80+yj2qZjKz+oqKrOC0MV6ss=;
        b=mbP3GtNJk8Ge3uRil1b61Ay8lgOVvEh3TiHLHFXhrHLwZ7gyMVBpF44YtFYeIydf5E
         U5m54TJ7FCsudat0zn7DIKzLRnDSg9RTHQawPJDvPrtyq/BNth2gqqL+UB2tWOJPuqpG
         t2F1GDxd3zF4CRXbuUaVETVuFCo3uPFstJhsTNO1n1aDbxR9xsNJc4kLcpi58tMtwyrk
         B9I2/V67BPXjjgth8F7/rToi/lB5ENdZU1qNTRWRtH//wP0O6wuyLK6FARSicVRQSYMY
         zsUqHf8aqHKC+p9KDAXOtuvVzYqVMj30uZgWreiJ5ldEauu+Zh58mnbuKblZtTF/mL1n
         Q1WQ==
X-Gm-Message-State: AOAM532bScKCuabps7wmrC3CDCuYGnxb8A0AzWgvgX9CQ1d+wQRrFCTg
        /NTiUqUPpEn22ze0okSgGhwnFrHrryXQgWXcm9UU3q0SU8JNCGW7M7wcQGPOjl7O40KPIHyK7AW
        4HmPIWZ8Syptt
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr2205360wrx.16.1607513222224;
        Wed, 09 Dec 2020 03:27:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4kEQwZHME/Wlz6Nd9XqGg5QzCY9JlMn7Oho4DCv+zv0U6Ck0N79UYtSLkLkEsPaoBsptJ/g==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr2205334wrx.16.1607513222022;
        Wed, 09 Dec 2020 03:27:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m21sm2751701wml.13.2020.12.09.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:27:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 82C04180068; Wed,  9 Dec 2020 12:18:43 +0100 (CET)
Subject: [PATCH bpf v3 5/7] selftests/bpf/test_offload.py: fix expected case
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
Date:   Wed, 09 Dec 2020 12:18:43 +0100
Message-ID: <160751272344.104774.16243874919103350259.stgit@toke.dk>
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
 

