Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE782E4C85
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504865AbfJYNmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 09:42:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46581 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504860AbfJYNmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 09:42:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so2367908wrw.13
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OsxlGx4dpojTzUak80H04gkaR1TDJmd4W+iyvcK8C0=;
        b=DCTyf7cVC3ZlsaT0xU4JJZNVB5j2W+8BRagzbQFGHC1N74b1Jgxs8GU3H2aiAGCGKG
         GEfUbqHkqiJ3XtOUbHhZQGP1MS8lpSTh4DEtcdHQvULR1GKN8jjYB1doQxiF1Tnk5DZx
         0QyONEv1h+r+Dcj8DO/+M60EhzbXWp+bUBFwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OsxlGx4dpojTzUak80H04gkaR1TDJmd4W+iyvcK8C0=;
        b=gyRZUgYwVyGn/QpHxPTYSZV2xVWJmUK1FKr89g0OPgO3buCrGHHJshxdOCCGdSs82B
         pR8M0oIOnhKeuxvQxlOBSht19nMxu02v1T0KQDNY5MbWwfybea1Mmw6n+BQrPLjdns0K
         Nq4vFI4a28hUiaEhQqD07ZrWFB5nLMwSXWFztM72hleYz6GS2gct9+CfxcxSJicRLjdo
         5DMgfWKPVYaZ8akn7GdTwwGudy3aSDRLjv6iIai2kv/1TJBbnQyNM2UmwWvAn5u2Rke8
         N1BHDy7Koc9cPByo2wgLraWDRifshEAtDa/oIr+QMf8NKjheadHQaOc/FfKUTN2HzQDQ
         S0qA==
X-Gm-Message-State: APjAAAU9ZewRqCvH0C2RLWimFihPMXN0HdwbsDIQ9V66ZkVJOOsxrahs
        nSUimps8l1h7d3oIYE0wyabN2w==
X-Google-Smtp-Source: APXvYqw9u7FIiY+/mm0Eou36Py5qQCsmqyinqQ4wF6cZc02EYCfLvNR7pc4IxcvUI7Wz5Heu9lKAQQ==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr3050469wrx.124.1572010963665;
        Fri, 25 Oct 2019 06:42:43 -0700 (PDT)
Received: from localhost.localdomain ([94.230.83.169])
        by smtp.gmail.com with ESMTPSA id v11sm2194730wrw.97.2019.10.25.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 06:42:43 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 1/2] test_bpf: Refactor test_skb_segment() to allow testing skb_segment() on numerous different skbs
Date:   Fri, 25 Oct 2019 16:42:22 +0300
Message-Id: <20191025134223.2761-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025134223.2761-1-shmulik.ladkani@gmail.com>
References: <20191025134223.2761-1-shmulik.ladkani@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, test_skb_segment() builds a single test skb and runs
skb_segment() on it.

Extend test_skb_segment() so it processes an array of numerous
skb/feature pairs to test.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
 lib/test_bpf.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 5ef3eccee27c..c952df82b515 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6859,34 +6859,65 @@ static __init struct sk_buff *build_test_skb(void)
 	return NULL;
 }
 
-static __init int test_skb_segment(void)
-{
+struct skb_segment_test {
+	const char *descr;
+	struct sk_buff *(*build_skb)(void);
 	netdev_features_t features;
+};
+
+static struct skb_segment_test skb_segment_tests[] __initconst = {
+	{
+		.descr = "gso_with_rx_frags",
+		.build_skb = build_test_skb,
+		.features = NETIF_F_SG | NETIF_F_GSO_PARTIAL | NETIF_F_IP_CSUM |
+			    NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM
+	}
+};
+
+static __init int test_skb_segment_single(const struct skb_segment_test *test)
+{
 	struct sk_buff *skb, *segs;
 	int ret = -1;
 
-	features = NETIF_F_SG | NETIF_F_GSO_PARTIAL | NETIF_F_IP_CSUM |
-		   NETIF_F_IPV6_CSUM;
-	features |= NETIF_F_RXCSUM;
-	skb = build_test_skb();
+	skb = test->build_skb();
 	if (!skb) {
 		pr_info("%s: failed to build_test_skb", __func__);
 		goto done;
 	}
 
-	segs = skb_segment(skb, features);
+	segs = skb_segment(skb, test->features);
 	if (!IS_ERR(segs)) {
 		kfree_skb_list(segs);
 		ret = 0;
-		pr_info("%s: success in skb_segment!", __func__);
-	} else {
-		pr_info("%s: failed in skb_segment!", __func__);
 	}
 	kfree_skb(skb);
 done:
 	return ret;
 }
 
+static __init int test_skb_segment(void)
+{
+	int i, err_cnt = 0, pass_cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(skb_segment_tests); i++) {
+		const struct skb_segment_test *test = &skb_segment_tests[i];
+
+		pr_info("#%d %s ", i, test->descr);
+
+		if (test_skb_segment_single(test)) {
+			pr_cont("FAIL\n");
+			err_cnt++;
+		} else {
+			pr_cont("PASS\n");
+			pass_cnt++;
+		}
+	}
+
+	pr_info("%s: Summary: %d PASSED, %d FAILED\n", __func__,
+		pass_cnt, err_cnt);
+	return err_cnt ? -EINVAL : 0;
+}
+
 static __init int test_bpf(void)
 {
 	int i, err_cnt = 0, pass_cnt = 0;
-- 
2.17.1

