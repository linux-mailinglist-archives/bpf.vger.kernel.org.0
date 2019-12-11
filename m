Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B982311BAB1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 18:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfLKRxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 12:53:54 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52776 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbfLKRxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 12:53:54 -0500
Received: by mail-pf1-f202.google.com with SMTP id j7so1220869pfa.19
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 09:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xGVgxOXTDXZxUPv4l2tA8nMoXXfaum0oAoDgnC1FUSI=;
        b=eWRaE/hq64Ql2QJIK5Nv6aT5CnjIDZ/2O+nTyRxw9IqO/NM8PxoLlD0SrDZrpLYDP9
         k86fA8wZft6Ac7PHWm4Bymto/yDiJDuFtdDQApeVXVtUhSEnSs8zEnCJlW+rOhQiydmI
         cva8Y01MUfylLuG3sCWswhxeYfcr5UYrx2xQAmwgQbwpt6/treALtp9d0YiCPNl7zcA9
         pY9KOAlesrJCAjDl52ula36oBuT2qpXD8KuuyWUBbxtpD7joNr7w+IPdoMcGp23pP5Gx
         CcNZ+3UL2xljPfwq94GKIl1KSrwA6E5xjfpSnWOPwUzlfXkFMehnXFefwHoZOS3WO2nH
         IlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xGVgxOXTDXZxUPv4l2tA8nMoXXfaum0oAoDgnC1FUSI=;
        b=K0Bj6v9qMw+07v3f4PHPUvr3iJKBIdrFFspZa5XD/0X4gIx23QDGEBZywR4DWU3t2y
         4jt6Yaut1/t8U8VzaxpgQpv8LHIUsc1gXFIkBVhS1mAW/WBGuIHz6zSw+IOT1z9czf3/
         9MHyaV1NJxAgXApu4EXIYzu6gCg+gK7sQSuYFsCW8h9ErxrkSRYZ0bEuLaT7rcmJ4B6i
         1ncfVULmUaE76qYPFUzxIQeA+LM6Jv5yJEZZfMSTethdeWNZELfaj+upZEI6vbsBpMJk
         a3Z4nemx2eqg8hODacVamVAY+8FBswR/5zZrJFPLQizThhV8VI8WvjQZJdNRj8DGydFV
         83yA==
X-Gm-Message-State: APjAAAUjJH7PCV0+KJJXkUhJCot59D7xVb9RhwYHVTEY9NqdrA0Qxqoa
        s0J9jiJRQQ4JtpetOW1ohl4gcwk=
X-Google-Smtp-Source: APXvYqxWrwynamCuA/Qel0vqHsKVYW/kI7Ae8n8iSx5lCUuuVvonXNsAcllXE5LfmeWYq1vGWKb5FUg=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr5417663pgk.74.1576086833863;
 Wed, 11 Dec 2019 09:53:53 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:53:49 -0800
In-Reply-To: <20191211175349.245622-1-sdf@google.com>
Message-Id: <20191211175349.245622-2-sdf@google.com>
Mime-Version: 1.0
References: <20191211175349.245622-1-sdf@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: test wire_len/gso_segs in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure we can pass arbitrary data in wire_len/gso_segs.

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
2.24.0.525.g8f36a354ae-goog

