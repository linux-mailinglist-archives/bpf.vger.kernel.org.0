Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2213411CA8C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfLLKXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38669 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfLLKXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so1657893ljh.5
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFzr0fe5GqdjYGOl+Nl8QxjXg9bJHXwbfSVFD4cDlkY=;
        b=aynw71AUm075pgxS7/PldWMAVsxCa9rqaCox0eeqJE7lfEOfpzXdcKN4Emao1dFwBx
         LUWhpVRt1rCNh1fz5LRvVRv6Tb7cgFTewBhWDYtgQpfbqdwpEN2PsZIj2VWk3jnIgZHz
         k9U5AohwdyI6WkNSaWKgFaRpvcOQWGH+FLm00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFzr0fe5GqdjYGOl+Nl8QxjXg9bJHXwbfSVFD4cDlkY=;
        b=a48/x1UJPTa+SV0xJeafC2wQMVg6RdvLtTUG63jry85NSim+3f1mXRsHuMHUuQcrXb
         fnjCv9E3sigr4volFFygA4S2GwIwWp4YCk9OgV9uNucaCvYafYxKcmdXBpBrFzmbuXrd
         dZzVC4Z+0YqF87ZWtEejzGvh5ZNquk3LCnofCw2mZUcRxabdGNpXNENxVE6veKVrg1vs
         S4UzMQm1kxXLyCtTMpmQcTuJ+MdSfuq+SvWY47GI8JthLZDmCshquPTzPjU6f+0pAlOC
         e0D1hwwPAhQihhPJZBx9FIpEHyoxwMU6SYgS+UcKhRpY99kVYmVrFv1hE5Hr/t2Tm58A
         VYJw==
X-Gm-Message-State: APjAAAWrDuG4yN0kwgVXEG++Rv2ujuW97Lvx1d384TwPEQq7XePbfOGs
        WT0TmJ+NW5YfS5qHoU8qwGZOf4Us1ELGJw==
X-Google-Smtp-Source: APXvYqwenG73n8XWan6yWhEaaqSKlOE7J9eeq6bp5tDQ0Rh8Gm7BCbWko/dPaWhmiwKMpAyK7wpmqQ==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr5330450lji.158.1576146187011;
        Thu, 12 Dec 2019 02:23:07 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id 204sm1243075lfj.47.2019.12.12.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:06 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 05/10] selftests/bpf: Unroll the main loop in reuseport test
Date:   Thu, 12 Dec 2019 11:22:54 +0100
Message-Id: <20191212102259.418536-6-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for iterating over individual tests without introducing another
nested loop in the main test function.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/test_select_reuseport.c     | 73 +++++++++++--------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index ef98a7de6704..63ce2e75e758 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -698,47 +698,56 @@ static const char *sotype_str(int sotype)
 	}
 }
 
-static void test_all(void)
+static void test_config(int type, sa_family_t family, bool inany)
 {
-	/* Extra SOCK_STREAM to test bind_inany==true */
-	const int types[] = { SOCK_STREAM, SOCK_DGRAM, SOCK_STREAM };
-	const sa_family_t families[] = { AF_INET6, AF_INET };
-	const bool bind_inany[] = { false, false, true };
-	int t, f, err;
+	int err;
 
-	for (f = 0; f < ARRAY_SIZE(families); f++) {
-		sa_family_t family = families[f];
+	printf("######## %s/%s %s ########\n",
+	       family_str(family), sotype_str(type),
+	       inany ? " INANY  " : "LOOPBACK");
 
-		for (t = 0; t < ARRAY_SIZE(types); t++) {
-			bool inany = bind_inany[t];
-			int type = types[t];
+	setup_per_test(type, family, inany);
 
-			printf("######## %s/%s %s ########\n",
-			       family_str(family), sotype_str(type),
-				inany ? " INANY  " : "LOOPBACK");
+	test_err_inner_map(type, family);
 
-			setup_per_test(type, family, inany);
+	/* Install reuseport_array to the outer_map */
+	err = bpf_map_update_elem(outer_map, &index_zero,
+				  &reuseport_array, BPF_ANY);
+	CHECK(err == -1, "update_elem(outer_map)",
+	      "err:%d errno:%d\n", err, errno);
 
-			test_err_inner_map(type, family);
+	test_err_skb_data(type, family);
+	test_err_sk_select_port(type, family);
+	test_pass(type, family);
+	test_syncookie(type, family);
+	test_pass_on_err(type, family);
+	/* Must be the last test */
+	test_detach_bpf(type, family);
 
-			/* Install reuseport_array to the outer_map */
-			err = bpf_map_update_elem(outer_map, &index_zero,
-						  &reuseport_array, BPF_ANY);
-			CHECK(err == -1, "update_elem(outer_map)",
-			      "err:%d errno:%d\n", err, errno);
+	cleanup_per_test();
+	printf("\n");
+}
 
-			test_err_skb_data(type, family);
-			test_err_sk_select_port(type, family);
-			test_pass(type, family);
-			test_syncookie(type, family);
-			test_pass_on_err(type, family);
-			/* Must be the last test */
-			test_detach_bpf(type, family);
+#define BIND_INANY true
 
-			cleanup_per_test();
-			printf("\n");
-		}
-	}
+static void test_all(void)
+{
+	const struct config {
+		int sotype;
+		sa_family_t family;
+		bool inany;
+	} configs[] = {
+		{ SOCK_STREAM, AF_INET },
+		{ SOCK_STREAM, AF_INET, BIND_INANY },
+		{ SOCK_STREAM, AF_INET6 },
+		{ SOCK_STREAM, AF_INET6, BIND_INANY },
+		{ SOCK_DGRAM, AF_INET },
+		{ SOCK_DGRAM, AF_INET6 },
+	};
+	const struct config *c;
+
+	for (c = configs; c < configs + ARRAY_SIZE(configs); c++)
+		test_config(c->sotype, c->family, c->inany);
 }
 
 int main(int argc, const char **argv)
-- 
2.23.0

