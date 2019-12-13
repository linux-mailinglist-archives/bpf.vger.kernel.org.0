Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAE11EDC3
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMWaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 17:30:35 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:47709 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLMWae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 17:30:34 -0500
Received: by mail-pj1-f74.google.com with SMTP id m14so493638pjr.14
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 14:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PH7hh3/m0UNb9tTUeqSI8d2JGzJtPRYZDKVy+TJVMiw=;
        b=m22/J67DPQtxDitrFR42MDXsGkj1aIokLMmLjjfUfhA0zEN3zIl8wPmfKHBfa7ZN0H
         3uBj2g+Evgk9J0Nw84s5b2QS4zanZqKccFk8YpFI2ukxeEMnJUd1eXuV7yJqJY8xs+SP
         e4/2YNpTZ6bCGfyKBjpaorFXE8PSefYUVxuW7llfsb1jss8yiDZISMCEEmyuidpi3OYX
         sBN/QVXxLiDrIfI4JRyOZYJl7CJoQJfrk02+CVBBy8npEOb7vTmOs9WKq/wSzVhfs8M8
         cS08eAQjI4QxmTg3YvQD6vuS2HGVBKlA4ZTY4SPQg7Fp9VAsjcGPkRDCjTXgB7OGQhZQ
         /t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PH7hh3/m0UNb9tTUeqSI8d2JGzJtPRYZDKVy+TJVMiw=;
        b=jQTGsLe9WUI+PB/D2RlSRvMZRKtb95h7tkLp91LbduND9iuu2HA8gdubjgW3CpM+D/
         lWqpSLL1z11lp0vw8omW51fESRIQPykwBfTpNJppoZu7NNMhtSFea1ZpEJRJmO5xBCf7
         08vGIvZlLTPqvAXy0hnBb8wDJMeX2Peh6iVQvrfJCx3LLAfrs2WZPlTEy2bMWlnizBus
         w5yqOiXz3kFaCbHPeefNRiX2qJr2yHazDYiq0/1x2SE4yMVKEHEatypEgoURPf5l0vL0
         Rvka2xluP1aGdCZ9Lmuskg4W+DIPVUIj5SMZykdVdkIFpfXdYzG6pLqIP7WWDt6OOaxp
         h3ZA==
X-Gm-Message-State: APjAAAXiDyI55En3WVSYsaqIOk+qc4MsTo4Ym8x0O8MheTZVIb/jMYak
        FXnxDvXDCWq7pOIYQTyqvemGnSs=
X-Google-Smtp-Source: APXvYqwW9NQi22RWKiztkGnwks4xq/+ocowppkWlVnWoDwxLRBOE/rilUyi0DxnRkne1znjk7VkC9bc=
X-Received: by 2002:a63:6b8a:: with SMTP id g132mr2035382pgc.127.1576276233764;
 Fri, 13 Dec 2019 14:30:33 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:30:28 -0800
In-Reply-To: <20191213223028.161282-1-sdf@google.com>
Message-Id: <20191213223028.161282-2-sdf@google.com>
Mime-Version: 1.0
References: <20191213223028.161282-1-sdf@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test wire_len/gso_segs in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure we can pass arbitrary data in wire_len/gso_segs.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 2 ++
 tools/testing/selftests/bpf/progs/test_skb_ctx.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index a2eb8db8dafb..edf5e8c7d400 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -11,6 +11,8 @@ void test_skb_ctx(void)
 		.cb[4] = 5,
 		.priority = 6,
 		.tstamp = 7,
+		.wire_len = 100,
+		.gso_segs = 8,
 	};
 	struct bpf_prog_test_run_attr tattr = {
 		.data_in = &pkt_v4,
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index 2a9f4c736ebc..534fbf9a7344 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -18,5 +18,10 @@ int process(struct __sk_buff *skb)
 	skb->priority++;
 	skb->tstamp++;
 
+	if (skb->wire_len != 100)
+		return 1;
+	if (skb->gso_segs != 8)
+		return 1;
+
 	return 0;
 }
-- 
2.24.1.735.g03f4e72817-goog

