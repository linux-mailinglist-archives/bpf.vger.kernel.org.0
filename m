Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97B718B777
	for <lists+bpf@lfdr.de>; Thu, 19 Mar 2020 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgCSNdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 09:33:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55729 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729149AbgCSNNW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Mar 2020 09:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4dRrS/fWrSqKKRd6oOKfmva/Wbg7A8r+k8nfZOWXeY=;
        b=eh5cIG77J5yHmHTJkD0RW/oBXu75O/+JQGs3fjH7dCKvSvfZJK167nw8B3z5azGHxm4/fH
        kRzEHmEOhJ1JnkXrjegMlIJYeAn9DsFYjmkp6Dkg8U6om5PfTsvV8QA8kxepI5LRPi1QT5
        9HMlbbJlfI1Rf+ffdkMzuNvnJGJNkqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-0i-YLELENMiljJTgKle4ng-1; Thu, 19 Mar 2020 09:13:20 -0400
X-MC-Unique: 0i-YLELENMiljJTgKle4ng-1
Received: by mail-wr1-f70.google.com with SMTP id d17so975961wrw.19
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 06:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M4dRrS/fWrSqKKRd6oOKfmva/Wbg7A8r+k8nfZOWXeY=;
        b=Q2zQELhOaCDluXAyh6srzccGtW74mZyjGuHWMEF/e1f7t2sAAZMOifODJhz8/fAPyZ
         CWK5QdWrrSIa+IgPZiKQbSwyR9tuSAkahUSbvXn+2E5HS9qBHQ+N+h+oCFCxdRWCIBw0
         3por4h7Iew6RGdlCIcWGTlE/ReWPD+pp5wT73Xn9pTYqepF4v/A/WzXhIdM62dt7kHVU
         /goqR7nTl1l0sJLG7dqSc0ihq3YzLj2oO5MGLfUcGwm3pGnh6hcUVocWc8s6LyagNJSe
         FKTlP35Oqoi8s/7gJu38S2LZ5eW1aXHJ37RzHviZo/SdwQb8YZOngfiTy4TxBNOXwPfH
         nVvQ==
X-Gm-Message-State: ANhLgQ12G+awXCSwHWz0oskcribE38363OpGCME0nHxOYm7asYwIaq2h
        sJhFyhUmE7W16dZg2WUmWxK6NatTEQjTbF+EtMWh9xjUt2ZluH2RxD+QRQI5TvId2LcU4g73T6W
        6Fe99O2eR7WvY
X-Received: by 2002:a1c:a950:: with SMTP id s77mr3663120wme.176.1584623598881;
        Thu, 19 Mar 2020 06:13:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQGbZqPfcT159lnrEmvTWmj54va8IAqg8WwLw1ki+Kq5yPWHrr+ir5aCmBAe/AbeidmulhTw==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr3663084wme.176.1584623598665;
        Thu, 19 Mar 2020 06:13:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i1sm3293742wrq.89.2020.03.19.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 06:13:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6D2D7180371; Thu, 19 Mar 2020 14:13:16 +0100 (CET)
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for attaching XDP
 programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 19 Mar 2020 14:13:16 +0100
Message-ID: <158462359640.164779.1404778744339993026.stgit@toke.dk>
In-Reply-To: <158462359206.164779.15902346296781033076.stgit@toke.dk>
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds tests for the various replacement operations using
IFLA_XDP_EXPECTED_FD.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  |   55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
new file mode 100644
index 000000000000..ad974b677e74
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#define IFINDEX_LO 1
+
+void test_xdp_attach(void)
+{
+	struct bpf_object *obj1, *obj2, *obj3;
+	const char *file = "./test_xdp.o";
+	int err, fd1, fd2, fd3;
+        __u32 duration = 0;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj1, &fd1);
+	if (CHECK_FAIL(err))
+		return;
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj2, &fd2);
+	if (CHECK_FAIL(err))
+		goto out_1;
+	err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj3, &fd3);
+	if (CHECK_FAIL(err))
+		goto out_2;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, fd1, -1, 0);
+        if (CHECK(err, "load_ok", "initial load failed"))
+                goto out_close;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, fd2, -1, 0);
+        if (CHECK(!err, "load_fail", "load with expected fd didn't fail"))
+                goto out;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, fd2, fd1, 0);
+        if (CHECK(err, "replace_ok", "replace valid old_fd failed"))
+                goto out;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, fd3, fd1, 0);
+        if (CHECK(!err, "replace_fail", "replace invalid old_fd didn't fail"))
+                goto out;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, -1, fd1, 0);
+        if (CHECK(!err, "remove_fail", "remove invalid old_fd didn't fail"))
+                goto out;
+
+        err = bpf_set_link_xdp_fd_replace(IFINDEX_LO, -1, fd2, 0);
+        if (CHECK(err, "remove_ok", "remove valid old_fd failed"))
+                goto out;
+
+out:
+        bpf_set_link_xdp_fd(IFINDEX_LO, -1, 0);
+out_close:
+	bpf_object__close(obj3);
+out_2:
+	bpf_object__close(obj2);
+out_1:
+	bpf_object__close(obj1);
+}

