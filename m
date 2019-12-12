Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA711CA8A
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfLLKXG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45697 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfLLKXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so1623345ljc.12
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzhSUH5AUy0iYhyYu73V2FHHItPCQequR4yd+QQrh3E=;
        b=NFicFjVnJNLS6sDAaQfuxkBxdzPfSi14jDUQqt/qiVVwo0juZosJY2r6oZKtjviCgN
         QRAJKXKFL7ASkqrGWUYSvs1ehPBGKwkmCok2yKlYdPTYrOk2ljeHV8LamR1u+tq+Q0se
         PM3u8ivKNqbZjnH3BC2ohU//0OxmG4cMygs74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzhSUH5AUy0iYhyYu73V2FHHItPCQequR4yd+QQrh3E=;
        b=GFlAkQwDCnAJrii2hJO3LONCYoJ6AIE3hbmIZeYREMgbfMnfNd30AwIPaHfEPVHFRA
         j0AaTBHldxOdM8l5jm1McpoA3k/TRlQA8JM/MPei5WoSqtfjv7DwnCcsztE7eO1JEWxa
         QXiuice5No1qTqX9oucj/EzhuI26i9vytIeez9U8cJZabFCBxN/zzePshWlbAuNidEUR
         +aAPaQKLHdyA/fGTtjVkBq8CBYf18+88QF3/7cCE7hw+h2iXs0Y6pNJVyv694PgsoFXV
         26cAggIsjvlUVDiSAVYrc0xMpUhPcps/O/HIcSAbb2hGE4RhvrPWmEQ/whonbJzdWV+e
         vHKg==
X-Gm-Message-State: APjAAAXkNcDu1lSgtlTwj/f7J//DJOxkWB5UZ/W7Ewbx56ZwtC9pf9U5
        m7QI931u0lKOkg18HQrBRuCpEn0WvHDtzw==
X-Google-Smtp-Source: APXvYqyLa5PIzI6j/6b+WqsQOqjFFXIq/Ps0uv/so8b/vqbRKjK6uJ5rfIlhTths40yjnM4D/aRmGw==
X-Received: by 2002:a2e:294e:: with SMTP id u75mr5363360lje.173.1576146184571;
        Thu, 12 Dec 2019 02:23:04 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n14sm2651052lfe.5.2019.12.12.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:04 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 03/10] selftests/bpf: Use sa_family_t everywhere in reuseport tests
Date:   Thu, 12 Dec 2019 11:22:52 +0100
Message-Id: <20191212102259.418536-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update the only function that is not using sa_family_t in this source file.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/test_select_reuseport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_select_reuseport.c b/tools/testing/selftests/bpf/test_select_reuseport.c
index 1e3cfe1cb28a..a295a087a026 100644
--- a/tools/testing/selftests/bpf/test_select_reuseport.c
+++ b/tools/testing/selftests/bpf/test_select_reuseport.c
@@ -643,7 +643,7 @@ static void prepare_sk_fds(int type, sa_family_t family, bool inany)
 	}
 }
 
-static void setup_per_test(int type, unsigned short family, bool inany)
+static void setup_per_test(int type, sa_family_t family, bool inany)
 {
 	int ovr = -1, err;
 
@@ -680,12 +680,12 @@ static void test_all(void)
 	const int types[] = { SOCK_STREAM, SOCK_DGRAM, SOCK_STREAM };
 	const char * const type_strings[] = { "TCP", "UDP", "TCP" };
 	const char * const family_strings[] = { "IPv6", "IPv4" };
-	const unsigned short families[] = { AF_INET6, AF_INET };
+	const sa_family_t families[] = { AF_INET6, AF_INET };
 	const bool bind_inany[] = { false, false, true };
 	int t, f, err;
 
 	for (f = 0; f < ARRAY_SIZE(families); f++) {
-		unsigned short family = families[f];
+		sa_family_t family = families[f];
 
 		for (t = 0; t < ARRAY_SIZE(types); t++) {
 			bool inany = bind_inany[t];
-- 
2.23.0

