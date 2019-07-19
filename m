Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250F36EA38
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfGSRbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43740 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbfGSRbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id w17so31802042qto.10
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IzoJpvtjs5tq8ndn8zIpnqxVulmc9FUeDTH354o1sao=;
        b=GjxMHG/jt9KFErTzw4lJ9vsqjbekWWQcl+Djh52PgpYckTkSou07V4YYl3x7Z7crvH
         xmuKU7TxejZ4pSoRJs5k/dHoTH31a3i9a+xbq6hN5kOKXz3BPrpgZwHXWERULbedNsnI
         MjBUmIIJdV54CQtcgRtznbBbnt57rVmhN7Ct5KJP3B15RivhXq5NUQWal1PZySsJs4cJ
         zMc9Hy97dyVuWB+l/NCWW7fywupsiWMZG1/jOBNnZ5gnG4c5Rnw2zMlDGreeNJnlR5Dy
         pZvYDMAzMs6lMc51U+78jdmvnhO9EJwM55DGNSerTkAyFqBKDwCnKQo2ogisO7cAXwfy
         ADog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzoJpvtjs5tq8ndn8zIpnqxVulmc9FUeDTH354o1sao=;
        b=Jcj8/Qk48sVwOETSjKjiwVZ6RhQuzvIZIGLjdYz9/1SZD9NxlPm1mcstro8UVB/LUR
         qUPySQf1QKVS/Nxe0AcN2jv4yhi7rSYzB+AcZ7Hvej0LWVamUiY2OujANGwIwRjtNCUM
         NsJ1QUn54zvzMEA3NEl0FPDxPBdC4z35iKWdptv6IjYrC+pNxvbT5xVAbBU1PmIfbmmn
         jycy8z5DlQBpOS0kmodvBmq1EQWxu/0aXyiMIVgngB544N+HZ98q5E6v/P6r+JKI8p4l
         WciE9Lf/PbJzi+QFse/EYGZTQOuW5jsaQfQJpHdfm/cZQREFIfwel5Hd4V+MD8nsfgvP
         cLOQ==
X-Gm-Message-State: APjAAAUEUx1jkicf4qUKqef9TYXL2F0YVv7JAkmEq8NkyZb8QvTBDc5x
        tsG07NshloF3QT4BsizVSPHW1A==
X-Google-Smtp-Source: APXvYqwvvMvtaye37QgX+NTdBGm096qsTdImSyoiQeN7EJgdKupOD248huKcovyq6j5XORuXWZxjig==
X-Received: by 2002:a0c:9807:: with SMTP id c7mr38523434qvd.26.1563557465134;
        Fri, 19 Jul 2019 10:31:05 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:31:04 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Subject: [PATCH bpf v4 03/14] net/tls: remove close callback sock unlock/lock around TX work flush
Date:   Fri, 19 Jul 2019 10:29:16 -0700
Message-Id: <20190719172927.18181-4-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

The tls close() callback currently drops the sock lock, makes a
cancel_delayed_work_sync() call, and then relocks the sock.

By restructuring the code we can avoid droping lock and then
reclaiming it. To simplify this we do the following,

 tls_sk_proto_close
 set_bit(CLOSING)
 set_bit(SCHEDULE)
 cancel_delay_work_sync() <- cancel workqueue
 lock_sock(sk)
 ...
 release_sock(sk)
 strp_done()

Setting the CLOSING bit prevents the SCHEDULE bit from being
cleared by any workqueue items e.g. if one happens to be
scheduled and run between when we set SCHEDULE bit and cancel
work. Then because SCHEDULE bit is set now no new work will
be scheduled.

Tested with net selftests and bpf selftests.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
---
 include/net/tls.h  |  2 ++
 net/tls/tls_main.c |  3 +++
 net/tls/tls_sw.c   | 24 +++++++++++++++++-------
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 43f551cd508b..d4276cb6de53 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -162,6 +162,7 @@ struct tls_sw_context_tx {
 	int async_capable;
 
 #define BIT_TX_SCHEDULED	0
+#define BIT_TX_CLOSING		1
 	unsigned long tx_bitmask;
 };
 
@@ -360,6 +361,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tls_sw_sendpage(struct sock *sk, struct page *page,
 		    int offset, size_t size, int flags);
 void tls_sw_close(struct sock *sk, long timeout);
+void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_free_resources_tx(struct sock *sk);
 void tls_sw_free_resources_rx(struct sock *sk);
 void tls_sw_release_resources_rx(struct sock *sk);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7ab682ed99fa..5c29b410cf7d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -268,6 +268,9 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 	void (*sk_proto_close)(struct sock *sk, long timeout);
 	bool free_ctx = false;
 
+	if (ctx->tx_conf == TLS_SW)
+		tls_sw_cancel_work_tx(ctx);
+
 	lock_sock(sk);
 	sk_proto_close = ctx->sk_proto_close;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f58a8ffc2a9c..38c0e53c727d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2054,6 +2054,15 @@ static void tls_data_ready(struct sock *sk)
 	}
 }
 
+void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
+{
+	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
+
+	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
+	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
+	cancel_delayed_work_sync(&ctx->tx_work.work);
+}
+
 void tls_sw_free_resources_tx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2065,11 +2074,6 @@ void tls_sw_free_resources_tx(struct sock *sk)
 	if (atomic_read(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
 
-	release_sock(sk);
-	cancel_delayed_work_sync(&ctx->tx_work.work);
-	lock_sock(sk);
-
-	/* Tx whatever records we can transmit and abandon the rest */
 	tls_tx_records(sk, -1);
 
 	/* Free up un-sent records in tx_list. First, free
@@ -2137,11 +2141,17 @@ static void tx_work_handler(struct work_struct *work)
 					       struct tx_work, work);
 	struct sock *sk = tx_work->sk;
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
+	struct tls_sw_context_tx *ctx;
 
-	if (!test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
+	if (unlikely(!tls_ctx))
 		return;
 
+	ctx = tls_sw_ctx_tx(tls_ctx);
+	if (test_bit(BIT_TX_CLOSING, &ctx->tx_bitmask))
+		return;
+
+	if (!test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
+		return;
 	lock_sock(sk);
 	tls_tx_records(sk, -1);
 	release_sock(sk);
-- 
2.21.0

