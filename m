Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA720E1D4
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390068AbgF2VAE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbgF2TM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F4C008646
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so7842547wrs.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBJRsvVTUiGmv6/ZJRxPqGbzGixW3g1ZE5HXPoq3wyI=;
        b=FkBPfD4mAmsMvJl7mjxF8FtRdtVvYMa20erL11DPLmPxsTFrH6iB79P/sOeI7q/xRV
         etPGMlDmJVlgkDG/y1MSQpwBef4KOjVe7qym5+9hYYiqt6qrkvZMjSb6WtKOInhY182w
         /7KxxZgjQavl8+AYlHV2LEL0JZmiwbUyInvSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBJRsvVTUiGmv6/ZJRxPqGbzGixW3g1ZE5HXPoq3wyI=;
        b=FkBP66f10w1GtwlqE79/5oO8C+v29UA0S3tG3VxjQS+TVFvSokZNBUgPyJTuKcCkvG
         2ertRxvKfPpWRhaCwzkwIzF1Tb9s6vXC+NkCCRH6WyTbfeZPXBcxLwM80TDrqZwFi5Hi
         ZCRh+ExrI4gzrelUTxdnNC9Tdk4n2i7u/bUTWJ+4eDB+gaKj4cavY4zqfFBJSOSj4ykh
         T0N1SlVh8rKMJfHAlUfSyXWadNBTAZq0PUmw5AbZtbrGewyGhWacreybvg0SVxKhrjYY
         mU8TS2sqM05oARHElqqtYZqSr/yVP1WYjT0IM0qD7f2XUazXpY4cw//hRpZpjt1YNAc8
         xNVA==
X-Gm-Message-State: AOAM53112B3J+lLY4BfuQSLEb2Oy/w/mJVHRr/LP9FYj72YIMF/rs077
        9I4vcJa7xAZuUYE31zdBfmS0Dg==
X-Google-Smtp-Source: ABdhPJwiHmthZ0xMbofeDm5s326m63W9e8QePVT0/QfNrWycW/gzkGa5feDzHArvpBWCHGPO2RahLQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr16222903wrj.298.1593424790962;
        Mon, 29 Jun 2020 02:59:50 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:50 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 6/6] selftests: bpf: pass program to bpf_prog_detach in flow_dissector
Date:   Mon, 29 Jun 2020 10:56:30 +0100
Message-Id: <20200629095630.7933-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling bpf_prog_detach is incorrect, since it takes target_fd as
its argument. The intention here is to pass it as attach_bpf_fd,
so use bpf_prog_detach2 and pass zero for target_fd.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 06716e04a043 ("selftests/bpf: Extend test_flow_dissector to cover link creation")
---
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index ea14e3ece812..f11f187990e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -527,8 +527,8 @@ static void test_skb_less_prog_attach(struct bpf_flow *skel, int tap_fd)
 
 	run_tests_skb_less(tap_fd, skel->maps.last_dissection);
 
-	err = bpf_prog_detach(prog_fd, BPF_FLOW_DISSECTOR);
-	CHECK(err, "bpf_prog_detach", "err %d errno %d\n", err, errno);
+	err = bpf_prog_detach2(prog_fd, 0, BPF_FLOW_DISSECTOR);
+	CHECK(err, "bpf_prog_detach2", "err %d errno %d\n", err, errno);
 }
 
 static void test_skb_less_link_create(struct bpf_flow *skel, int tap_fd)
-- 
2.25.1

