Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8B6EA33
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfGSRbW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44490 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbfGSRbW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so23771073qke.11
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9pxN+7gjk03qL7CRFdYVls1HBWJfJg+h1DcC3IAeAU=;
        b=yZizlLNjHZQx7cxD3ZD23WidJVkLZeFgm0V07gDv4kc92hRjqL+bmFlD6oGpmbanoi
         X5RLb6sV2NxH0unvhOv+RuT6utcRH2ZpT5YUAOFOqxdGu6oOUR8H5+4v7WQG+hcg3+Tj
         z3+aWhiDQr4ginPjBb2Q78T8juj/VdaatufRKrdJhu3OCxgbyG7+WpG8yV7cQVkfWwYP
         zZiGDEoWRETBR7OCFhf3xba985jcR3RLbgo1EyDXC3/7wGkzo7/kEenPWQ8MF0lx8Tpn
         DPOPrQW7ArWHWkLwMnoOYlrvna/o84Mrkr2+hoKbkzkKUvJPtric/5GNVev0WcOi3WGO
         zeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9pxN+7gjk03qL7CRFdYVls1HBWJfJg+h1DcC3IAeAU=;
        b=bkbJ+5QYsBNz51QQNT7F2md/eGZ+4UsC59+rpg5DBRiQnfkPAxu31SfrVVl9Fpze82
         qOd858KEa6UZxjCV4sOP3BRiuLgjPNSX8/ICMZc7WQDwZu2z61RwfIdsy2bIdh/GO5gl
         KYGsjiH8w5prAXTs5sJpJ4thDKFF3a8kUVdZuIlDPFDEjNnMXVQtsPbXTF5y9aRYPJSx
         G7O1zsJRaHhOT3cOWlqKsSERMSKJTNBR22LQKQomhmhYhC6XXPF2tN3nl0mds/fD2yGu
         IekUZiRkJuQ4EekOwlfTEEn9J5BEvuhiyTT6aXNWAHXVZ4izjkXsoXycluymnu12sZXZ
         W6iQ==
X-Gm-Message-State: APjAAAV8Uvkiq3v7BZ3w6uBZM/JccsIDAZYKn8NkYC5KZYdliz0r9Vtd
        ah5yxzNzF3+SYoBFdPd881++SQ==
X-Google-Smtp-Source: APXvYqyBlhieHfpS6Q2xbEu766mRiGMUiwe57hv3Icv1K7dkvMBJVMZKN96DwD0SSyqb2inPBgBORg==
X-Received: by 2002:a37:404b:: with SMTP id n72mr35536907qka.109.1563557481142;
        Fri, 19 Jul 2019 10:31:21 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:31:20 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Subject: [PATCH bpf v4 14/14] selftests/tls: add shutdown tests
Date:   Fri, 19 Jul 2019 10:29:27 -0700
Message-Id: <20190719172927.18181-15-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test for killing the connection via shutdown.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
---
 tools/testing/selftests/net/tls.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 94a86ca882de..630c5b884d43 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -952,6 +952,33 @@ TEST_F(tls, control_msg)
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
+TEST_F(tls, shutdown)
+{
+	char const *test_str = "test_read";
+	int send_len = 10;
+	char buf[10];
+
+	ASSERT_EQ(strlen(test_str) + 1, send_len);
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+	EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+
+	shutdown(self->fd, SHUT_RDWR);
+	shutdown(self->cfd, SHUT_RDWR);
+}
+
+TEST_F(tls, shutdown_unsent)
+{
+	char const *test_str = "test_read";
+	int send_len = 10;
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, MSG_MORE), send_len);
+
+	shutdown(self->fd, SHUT_RDWR);
+	shutdown(self->cfd, SHUT_RDWR);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.21.0

