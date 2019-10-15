Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E8D7F11
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfJOSbc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 14:31:32 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50501 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfJOSbb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 14:31:31 -0400
Received: by mail-qt1-f201.google.com with SMTP id o26so22105914qtj.17
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Z+7CoJL+YPFr0e8+5ZWKm53e69GUytl7IP8jHQynIk=;
        b=RD+kNAyRIpK+86pMLTBQqCHpw+kftM/0RppC0A7/dVE3PNTXvnNDiU8JxTyZCr/Dvz
         EfQDk2q7osXb50CVzjvbsK5F6jS4/rDJ/WU4LePfoR69Oe9VB57rrXT5OmwNqF7YpnDs
         K5mmwFzNrNsE55AZItwPdLIDD+vRjIm4llisXToqy+FCeU0S8IEw4NyQQzEjq5oudMSb
         QIaAhwW9ITORQdN9IR5qvvNPsyNhUJMEsAKdrx6imOGtnJXIdnGKHve61bLaZn9VU405
         1saaVaZrX2p2szEiDR6tS/2iKY2aI3ym7wzi7JjIIIPXzJs+Y0DHstw4VrtpPvV6kOZE
         T6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Z+7CoJL+YPFr0e8+5ZWKm53e69GUytl7IP8jHQynIk=;
        b=q2UX/pd8fRuvNkA6QkjXl1LlIqyQw3NjeZkvpdxQfjEeJEuQ9y5HAQWKa4WTTuDPDg
         RfV1SasaK922sjsIji/2hUzj22mSo5IuqDUV7crkTu4gMOF3EWEcGsFROFf/aod/NoNd
         EyqEntmu0yTL2dsQiE289n+3JpgiYtiQHa8+WX5VQvgwrSLHVduQpS6/XRxw5GMRN1wa
         4dBjvV6PDr35In0DXbbBQPdq6Cs9R5fROHU3VZn3DUqL6AL53EfWQj7srtoaiu+dqvdC
         liwonV6O0+fyFbh1IbqT6FLVz3KQ7XZtoaZA0jnvcSIIe50k6ZXomyPaoMAQVdKQxZb6
         SJeA==
X-Gm-Message-State: APjAAAWUz6Ls0qY2JWclh5q8n5Z9zINKU1y/QYUF6WUhE0QVzQPx75wN
        raT0iUfru4GKa1yEozg7/2p54oM=
X-Google-Smtp-Source: APXvYqz+AjZ2R7ieK5bJ+qtAoM3cco8Maw/jDnIhgEm7aPQb0iGvcp32O21zU90MEvEE+mu7n33fgLk=
X-Received: by 2002:a05:6214:304:: with SMTP id i4mr20746659qvu.147.1571164290878;
 Tue, 15 Oct 2019 11:31:30 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:31:25 -0700
In-Reply-To: <20191015183125.124413-1-sdf@google.com>
Message-Id: <20191015183125.124413-2-sdf@google.com>
Mime-Version: 1.0
References: <20191015183125.124413-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH bpf-next 2/2] selftests: bpf: add selftest for __sk_buff tstamp
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure BPF_PROG_TEST_RUN accepts tstamp and exports any
modifications that BPF program does.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 5 +++++
 tools/testing/selftests/bpf/progs/test_skb_ctx.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index e95baa32e277..a2eb8db8dafb 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -10,6 +10,7 @@ void test_skb_ctx(void)
 		.cb[3] = 4,
 		.cb[4] = 5,
 		.priority = 6,
+		.tstamp = 7,
 	};
 	struct bpf_prog_test_run_attr tattr = {
 		.data_in = &pkt_v4,
@@ -86,4 +87,8 @@ void test_skb_ctx(void)
 		   "ctx_out_priority",
 		   "skb->priority == %d, expected %d\n",
 		   skb.priority, 7);
+	CHECK_ATTR(skb.tstamp != 8,
+		   "ctx_out_tstamp",
+		   "skb->tstamp == %lld, expected %d\n",
+		   skb.tstamp, 8);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
index 7a80960d7df1..2a9f4c736ebc 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_ctx.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -16,6 +16,7 @@ int process(struct __sk_buff *skb)
 		skb->cb[i]++;
 	}
 	skb->priority++;
+	skb->tstamp++;
 
 	return 0;
 }
-- 
2.23.0.700.g56cf767bdb-goog

