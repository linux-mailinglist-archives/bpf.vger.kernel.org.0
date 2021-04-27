Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795CD36CA83
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhD0RoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbhD0RoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 13:44:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A95C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:43:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so6166612wrs.6
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2iyahBHzOh1s1/2DDrTt76XfDUplpwYz1B02Q5JMG8=;
        b=mysCojt0MioxpHafBfv/sMcLsXkCwbfT4eQGXLjI4fkKnt3alpXOsl3fpJWZaB7v35
         SPug/nlN+xo+bArG6bmxLociAxaq5KAqumSFLT8BeAfsaWbn8epBnbqp704IauQy6Q+B
         JoJKMBOyGYdGk2DBA15lwFMDX/P7rOnIe6wMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2iyahBHzOh1s1/2DDrTt76XfDUplpwYz1B02Q5JMG8=;
        b=in2GvdwRqdu13+UOiuk9H+VrcE22pG8IoxcUGEfT2jzOpU3zn+eMiPp/59DwSi/csW
         nZeFWfjf0XjuX2HdiiV5a9nfVH8OFCnWQtUkMG08el4N3grmTvVikVh0oB/cuVhnohax
         rKAqC6kfanQkmHFZapAU/HT5uVQjwbGxvph5Pn2Zvyom+nbzvizfNZlEL2UWIhGJw93k
         c9/wZgCUrAhWUFwOHLVrBwMQFniV0tWddlZ4itjGHclmmLIlMxL/28iIb8xfSP9hdIWQ
         +GauWMY6xH4+GSZEzqRGc9+lNNBKwDvEMebjr9wFC0/tOI6lm9gNieR9J9SSs10jTsmY
         k6gQ==
X-Gm-Message-State: AOAM531P67joJW3EZKmtAdzpxEpUhSD7ru17rfoV4dfBgNhrwMJy/N4z
        KCXGC4Q6/UNeMqYLBdYPsCdzqX0lie1gPg==
X-Google-Smtp-Source: ABdhPJxk7Y7PPiLmiNLUe+eXN6jgNarEJ2pfaNG2m38VN3A0mtQZXdMxmgrDDrsHZJdTf+iy+JjUQw==
X-Received: by 2002:adf:e901:: with SMTP id f1mr29454653wrm.44.1619545399844;
        Tue, 27 Apr 2021 10:43:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:14c3:1569:da7a:4763])
        by smtp.gmail.com with ESMTPSA id h8sm647302wmq.19.2021.04.27.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:43:19 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 1/2] seq_file: Add a seq_bprintf function
Date:   Tue, 27 Apr 2021 19:43:12 +0200
Message-Id: <20210427174313.860948-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427174313.860948-1-revest@chromium.org>
References: <20210427174313.860948-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to seq_buf_bprintf in lib/seq_buf.c, this function writes a
printf formatted string with arguments provided in a "binary
representation" built by functions such as vbin_printf.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 fs/seq_file.c            | 18 ++++++++++++++++++
 include/linux/seq_file.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..5059248f2d64 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -412,6 +412,24 @@ void seq_printf(struct seq_file *m, const char *f, ...)
 }
 EXPORT_SYMBOL(seq_printf);
 
+#ifdef CONFIG_BINARY_PRINTF
+void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary)
+{
+	int len;
+
+	if (m->count < m->size) {
+		len = bstr_printf(m->buf + m->count, m->size - m->count, f,
+				  binary);
+		if (m->count + len < m->size) {
+			m->count += len;
+			return;
+		}
+	}
+	seq_set_overflow(m);
+}
+EXPORT_SYMBOL(seq_bprintf);
+#endif /* CONFIG_BINARY_PRINTF */
+
 /**
  *	mangle_path -	mangle and copy path to buffer beginning
  *	@s: buffer start
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..723b1fa1177e 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -146,6 +146,10 @@ void *__seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_open_private(struct file *, const struct seq_operations *, int);
 int seq_release_private(struct inode *, struct file *);
 
+#ifdef CONFIG_BINARY_PRINTF
+void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
+#endif
+
 #define DEFINE_SEQ_ATTRIBUTE(__name)					\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-- 
2.31.1.498.g6c1eba8ee3d-goog

