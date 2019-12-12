Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84611CA8B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfLLKXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfLLKXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so1637029ljo.9
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2p9l/NhEyywONqWaOqv6gQFlxKFxX2B65VKx+bZRGLg=;
        b=bh+5njxSHzKC3/Md1BbrADp8F8kRAPjIZCRHnQl8TUAhdszbKQepHxpYQLlAxufdt3
         zAW8PiPstUAkEII6Yh3xq0EE0bSQGFG+ytV3Wqt81rxcm7XfJ3fbtaXFItlCJjOt2wez
         chMFz8IfEE+5qRhyw29/XUT6UzPf9ryoOYLKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2p9l/NhEyywONqWaOqv6gQFlxKFxX2B65VKx+bZRGLg=;
        b=Eyq/ZaK4Dn1soknjzSvMmjqLV08MqBqGVjUe0wBCb2e+pGyv7Rfjqeq0iQi5noDP/H
         kIs/vSThXpetj2NXUHmWULENurKTCQNLRDYCtcEF2uSjQu5w0dB5lgO+Ea52/fI6ng38
         uk5TKJVO8iPIVpAB50MQB18vdgECGRWV6MpasdbpHBmSAJKfzuh63b6cJyvAexzyHnfT
         VLaeQuBrP6VrOa8BmLZuDeUF/OoJVXq2iqQ2h1JZY5mrhYQYyYRLf3g7VGYklB57oQSA
         MAPjcAB7ZdiG2H9OWfX6szcMp3P+DSkefyY9UbsV8NyjHJ4afdSi1FzxwDtiEpMowbUG
         4LCg==
X-Gm-Message-State: APjAAAXwxxq7AB0xpstkU7rMT/nuyWly5PSzhmnRt9Oddb6Yg7TaKuJI
        jFUhhy8ZvfTWOadpyo1P7jkdP0Hpj7mj5g==
X-Google-Smtp-Source: APXvYqxKbvJFpm539WL25Y3CNhctmGGfUN4y/VGK8ZqpYOUGytJaZxTx1P+H2kVVgPQqS4IF4wCSYw==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr5416439ljj.190.1576146185766;
        Thu, 12 Dec 2019 02:23:05 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id h19sm2721080ljl.57.2019.12.12.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:05 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 04/10] selftests/bpf: Add helpers for getting socket family & type name
Date:   Thu, 12 Dec 2019 11:22:53 +0100
Message-Id: <20191212102259.418536-5-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Having string arrays to map socket family & type to a name prevents us from
unrolling the test runner loop in the subsequent patch. Introduce helpers
that do the same thing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../selftests/bpf/test_select_reuseport.c     | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index a295a087a026..ef98a7de6704 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -674,12 +674,34 @@ static void cleanup(void)
 	bpf_object__close(obj);
 }
 
+static const char *family_str(sa_family_t family)
+{
+	switch (family) {
+	case AF_INET:
+		return "IPv4";
+	case AF_INET6:
+		return "IPv6";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *sotype_str(int sotype)
+{
+	switch (sotype) {
+	case SOCK_STREAM:
+		return "TCP";
+	case SOCK_DGRAM:
+		return "UDP";
+	default:
+		return "unknown";
+	}
+}
+
 static void test_all(void)
 {
 	/* Extra SOCK_STREAM to test bind_inany==true */
 	const int types[] = { SOCK_STREAM, SOCK_DGRAM, SOCK_STREAM };
-	const char * const type_strings[] = { "TCP", "UDP", "TCP" };
-	const char * const family_strings[] = { "IPv6", "IPv4" };
 	const sa_family_t families[] = { AF_INET6, AF_INET };
 	const bool bind_inany[] = { false, false, true };
 	int t, f, err;
@@ -692,7 +714,7 @@ static void test_all(void)
 			int type = types[t];
 
 			printf("######## %s/%s %s ########\n",
-			       family_strings[f], type_strings[t],
+			       family_str(family), sotype_str(type),
 				inany ? " INANY  " : "LOOPBACK");
 
 			setup_per_test(type, family, inany);
-- 
2.23.0

