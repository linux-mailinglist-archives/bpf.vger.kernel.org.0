Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312DA2CE0E6
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbgLCVg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:36:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389399AbgLCVg6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 16:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607031331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DI29VqJzS72LXaEV13zDjLKn6lqs69y45EkLgkg/Hr4=;
        b=FM/HHnmRx9JERGtKBdgRlHXPOAw81NsNpJfdR0MpxwzWy6+pTmrld67W6QqW710EsToGj+
        fEtXZiyJe+AKauJfUCDdhC5XOBHrA8MKjG+HcQjo/G2+xLJqAVW6MxM0ztCxK/I0/bhjum
        ccMbOK6yArsbmK8rjb1H320/p4kJhwE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-uLJxfj76MMiz5Eanh1ubaA-1; Thu, 03 Dec 2020 16:35:30 -0500
X-MC-Unique: uLJxfj76MMiz5Eanh1ubaA-1
Received: by mail-qk1-f197.google.com with SMTP id s128so3193802qke.0
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DI29VqJzS72LXaEV13zDjLKn6lqs69y45EkLgkg/Hr4=;
        b=XUnB7dNLJxRBW7Qr+H37SthwN+0FYVU/eFY65P4xFnsB1jbdZnwlfWwuAHe4Y7roZG
         jJb9KpTclstfjfp+OimHB5ltd48dr1O7smezu7oR66+gDyra9OuQlr1B31Gpo2YJ2Gvv
         oqllBzRKRz5QjIIsZzqryi7PqqchFGOtZQq0ed1TL8xJkYgv4IUvGxQei7B89Abba+kK
         QwT2enrZ7BxzALdgUFSoU2vova2woPvBF2ZCyMKOjdtAj7in0A0aowFpGnVF5RBq7rpW
         1W9a5qU0psQvdVXWmTuHo65LpzEOxqEx9mPBouY2tWxfgrsW2YZbqTN8rYoDM6KBBh6y
         Rd/g==
X-Gm-Message-State: AOAM530sMhWGoberyDikCaADll77T7za+EBuWpXUpWXhZlSC6BdOrZVx
        5YBmr0Qp29pKgP69nzwV0H6cufnYt/Esclabr0Q6qn7xvwGyYjJzuFeqs1EjmIL1rwHJ1tB2Vux
        pPUo32UsDy6B4
X-Received: by 2002:a05:620a:55b:: with SMTP id o27mr5033790qko.226.1607031329434;
        Thu, 03 Dec 2020 13:35:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfRbExoNkCbGd9OYQ3RciN25NTK0UbfbhfIQFCsxLV947DkzuxS3TC6F6RTtAe0QwlSNHrmg==
X-Received: by 2002:a05:620a:55b:: with SMTP id o27mr5033743qko.226.1607031329039;
        Thu, 03 Dec 2020 13:35:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j124sm2913011qkf.113.2020.12.03.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:35:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B23311843F0; Thu,  3 Dec 2020 22:35:23 +0100 (CET)
Subject: [PATCH bpf 6/7] selftests/bpf/test_offload.py: reset ethtool features
 after failed setting
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
Date:   Thu, 03 Dec 2020 22:35:23 +0100
Message-ID: <160703132365.162669.12565799511526821110.stgit@toke.dk>
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

When setting the ethtool feature flag fails (as expected for the test), the
kernel now tracks that the feature was requested to be 'off' and refuses to
subsequently disable it again. So reset it back to 'on' so a subsequent
disable (that's not supposed to fail) can succeed.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 5b0fe8e0b2d2..f861503433c9 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -940,6 +940,7 @@ try:
     start_test("Test disabling TC offloads is rejected while filters installed...")
     ret, _ = sim.set_ethtool_tc_offloads(False, fail=False)
     fail(ret == 0, "Driver should refuse to disable TC offloads with filters installed...")
+    sim.set_ethtool_tc_offloads(True)
 
     start_test("Test qdisc removal frees things...")
     sim.tc_flush_filters()

