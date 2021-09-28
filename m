Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2D41ABED
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbhI1JdB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbhI1Jcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED99C061775
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 02:31:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i23so56930620wrb.2
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOQcHnRA4OzmDMrO4dM1TAmtC+v9d8Z05czXaJ/Qyps=;
        b=j5i1ZfzTSkWC0KpfTPAm/d98mJ95ltf3LgMoqfjaiA9utXdmH1QA0a8v416ZV5yVsj
         jmrW70W41xqy93PI0cMh95LsGCbEf1Ve2mqgcAEnOKlxhSvZv5Tok7fiyIbRjj1G5b/y
         mR2T6ue+VFHxt9gk5aloFDAeBtrrCwW/KDazY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOQcHnRA4OzmDMrO4dM1TAmtC+v9d8Z05czXaJ/Qyps=;
        b=i8Rp6b8JTbotnRkqXlVEC6BwgxnpZoo/641V1+E4i0j9R5n/+yPABidjoXHbwS9/nN
         2IowlIgMxzYletjOGeIgZQmG5PVT5cE6mAAMR1Pj/+eNGf94pAUklUpdWfhmGHat0hCF
         PCOfXYGtJF6nE+mPYKCU/AA7zUh1KSu7pB+UOmzwBvLbWcKFpZRgEmsoXGew58/r9wAH
         8vTQhsHKSLnFtvY/Nn9KnMtdzSuvPJ0C2qtzo9yeRM0wis0uUex35qamYDo3hfNa9B5a
         3djw0UA9qyiFd2217Ykf4t/ZY/a+Rs/KJwrIFmGJNm43e+iWTU/uYBRkpwsPu4S+GPmf
         ZVMg==
X-Gm-Message-State: AOAM5300PUtI+aofAeEv+ONoHKHCO7+P8gJg8xwvLuPjk+po6c7gbK97
        M3d1V60XD4Z81OmU4b4f0Hv57Q==
X-Google-Smtp-Source: ABdhPJy2hW+MI4TO2xRyKlBg3FCAUNVxkc/LlMhgUA1ST4mFFFWUVCwLNNK41Meu19K4TI9a6Cf0aA==
X-Received: by 2002:a5d:4eca:: with SMTP id s10mr5240117wrv.255.1632821473526;
        Tue, 28 Sep 2021 02:31:13 -0700 (PDT)
Received: from antares.. (7.2.8.5.7.4.1.5.9.1.3.d.e.b.3.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:53be:d319:5147:5827])
        by smtp.gmail.com with ESMTPSA id h15sm18716206wrc.19.2021.09.28.02.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:31:13 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     bjorn@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: do not invoke the XDP dispatcher for PROG_RUN with single repeat
Date:   Tue, 28 Sep 2021 10:30:59 +0100
Message-Id: <20210928093100.27124-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have a unit test that invokes an XDP program with 1m different
inputs, aka 1m BPF_PROG_RUN syscalls. We run this test concurrently
with slight variations in how we generated the input.

Since commit f23c4b3924d2 ("bpf: Start using the BPF dispatcher in BPF_TEST_RUN")
the unit test has slowed down significantly. Digging deeper reveals that
the concurrent tests are serialised in the kernel on the XDP dispatcher.
This is a global resource that is protected by a mutex, on which we contend.

Fix this by not calling into the XDP dispatcher if we only want to perform
a single run of the BPF program.

See: https://lore.kernel.org/bpf/CACAyw9_y4QumOW35qpgTbLsJ532uGq-kVW-VESJzGyiZkypnvw@mail.gmail.com/

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/bpf/test_run.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fcb2f493f710..6593a71dba5f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -803,7 +803,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (ret)
 		goto free_data;
 
-	bpf_prog_change_xdp(NULL, prog);
+	if (repeat > 1)
+		bpf_prog_change_xdp(NULL, prog);
 	ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
 	/* We convert the xdp_buff back to an xdp_md before checking the return
 	 * code so the reference count of any held netdevice will be decremented
@@ -824,7 +825,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 				     sizeof(struct xdp_md));
 
 out:
-	bpf_prog_change_xdp(prog, NULL);
+	if (repeat > 1)
+		bpf_prog_change_xdp(prog, NULL);
 free_data:
 	kfree(data);
 free_ctx:
-- 
2.30.2

