Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7156EA2F
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfGSRbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36955 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731555AbfGSRbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so23794867qkl.4
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VrBXI+Na9+8mcq/nWA7YVHUWoLagxU6hdpQa6o/wPA=;
        b=PYjGAaaW3+58knGCgQKQHmx0SnNmALUi7xHBvgDHnjxVX/+pwmmlDt9ymYdrDMLIs0
         CCFD/KtwlxSm4h9aNjnL+knY+aUzz+a+ddxaU2PeKGiKEHvfGKOG/pVLUkDbEcbe7LAJ
         fWW2fJfpYGGbxvbGrWkJ0DkT6s7pq5eqrtQcu5mIWY9fb5yoyfkzJyYMJi1cx1fwvnLu
         cs1czdw0FaHpgUXIEkwrZMwXpviiQ6T4J/oszK3Jy2J7HI+4YNvYQK6kZhLH4oclu+WK
         kElwIYGLbnqGT0c/j8mK/GsqdbLNMbREWvyguvGkejFsycy7QXUvmXFnwnh0FQKX4m0W
         jsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VrBXI+Na9+8mcq/nWA7YVHUWoLagxU6hdpQa6o/wPA=;
        b=PDvOaz2UK8NTW6zJq5gis2OMSKwzsFXKmP/ep3SGzTO4bPZxqEUHrMmsF04tJwxE1S
         vxb9Ip5bwDmDF1q7gDdVzzoR9ai+4rQUeWwSMmKAE8Voq+yla/FXCkWmSvbHZtDSEcPQ
         ThttTmuzWKgVDP/47jvJWo3VK7l6swnAjlrRES06PkFSYxHl4DbrkWMZRYbUdS2aDPrv
         HjWXPRZLzFqVztIZ1lm8WV7meI5TsSANLy7XEJlPznnwELK0yAWWYUGx7NNy9V6eON3D
         nbD+lQwpFkemc7K8QhfBW4n+dkdcb5jZhNB8Ep5hKnUsQo5zmEQ/Za9vQt59t+T5uRvc
         x9Xg==
X-Gm-Message-State: APjAAAUlmPTh9ezs0/35wy8pncTEuuOYu/OZP5vsSPz+318LfvzBQ9sA
        K7WA0Wt58cf/h1bmnvu6WFd3qKKYIe4=
X-Google-Smtp-Source: APXvYqxCSj6v2Z9PjNSmGnFGfJ+CVoAgNgS4p3Lb5IIIaxTvwvnLJt2rdbBovTmwXemZKwPAUZA/UQ==
X-Received: by 2002:ae9:df81:: with SMTP id t123mr35799519qkf.372.1563557478036;
        Fri, 19 Jul 2019 10:31:18 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:31:17 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Subject: [PATCH bpf v4 12/14] selftests/tls: add a bidirectional test
Date:   Fri, 19 Jul 2019 10:29:25 -0700
Message-Id: <20190719172927.18181-13-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a simple test which installs the TLS state for both directions,
sends and receives data on both sockets.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
---
 tools/testing/selftests/net/tls.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 10df77326d34..6d78bd050813 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -684,6 +684,37 @@ TEST_F(tls, recv_lowat)
 	EXPECT_EQ(memcmp(send_mem, recv_mem + 10, 5), 0);
 }
 
+TEST_F(tls, bidir)
+{
+	struct tls12_crypto_info_aes_gcm_128 tls12;
+	char const *test_str = "test_read";
+	int send_len = 10;
+	char buf[10];
+	int ret;
+
+	memset(&tls12, 0, sizeof(tls12));
+	tls12.info.version = TLS_1_3_VERSION;
+	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12, sizeof(tls12));
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_TX, &tls12, sizeof(tls12));
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_EQ(strlen(test_str) + 1, send_len);
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+	EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+
+	memset(buf, 0, sizeof(buf));
+
+	EXPECT_EQ(send(self->cfd, test_str, send_len, 0), send_len);
+	EXPECT_NE(recv(self->fd, buf, send_len, 0), -1);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+};
+
 TEST_F(tls, pollin)
 {
 	char const *test_str = "test_poll";
-- 
2.21.0

