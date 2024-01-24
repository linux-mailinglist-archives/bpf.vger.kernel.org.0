Return-Path: <bpf+bounces-20258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B083B191
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA674B27DEE
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BA132C12;
	Wed, 24 Jan 2024 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzANqe5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4E132C06;
	Wed, 24 Jan 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122456; cv=none; b=d5QX4Sb8KuLtBFfqZ1bjlfr/ZGQoYQfzoiVAsjEfgZjYIfbG2j19o+F11XGxgW/UJ63aFDTq0dwOx+K2HOwgd43kWvqnZ5lXMM/osJu6mAzuFHA2CjfHfhQe9tX218J0E2mkQP5WQFVtdkJfpYvK6DUKj9kM9sDJlB4uufayMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122456; c=relaxed/simple;
	bh=/iI4CuBcskIT5fz8Z3/ta8Kdw8odzS46OI8RUnpyst4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfoSADr6r/mCzLPbHOrsXh0eDTnG3LfmANrwVFNHOdz0Mo2o/js+Wgsuw47fRRl9YM5YpggLRQZLolhu1Z5FqIGD7/QrJlXTrDAiKmM0AVouVhqsgVpqV/7Vvqs0377Ugaly+0brXJ/gLM/u4lxkn3G3xYVDM0JFHUSDVWdE50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzANqe5X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so1577928b3a.0;
        Wed, 24 Jan 2024 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122454; x=1706727254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkrNgdmMknR9/DA9BuNR/VhwDO3Guj9g1A1NTv+VIf0=;
        b=JzANqe5X5lTsxyXMKKOcJmP/b6J/qmouOjlSzhLVHXds/DWE6y0SDLe6Q23o+YC2XQ
         x4pdf9KGDIsvhhID9c5/lKKU88SX9CheiP4oiLXe4c/LGTak2LK0Yhwjq0aub5w4qL8S
         a4vaN2FUqvel0M9nU9g3KjDvYgC+7zDXCwyBW0YQ9IuBIY9reDNE0k+LZB2P/0YscYeT
         SaZkZDTmN31FDjTVfTbsCv+JyJ17cYJliizEJ0kjgCqRJ7mk/15UzVuoro81JlqeoqGX
         mr9mZ9JsHcinHQ3qtORL61Qtz/C25sxM9XNtWOOAsaNApo6cQpn1TiexwqnQxGTPDqKg
         IHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122454; x=1706727254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkrNgdmMknR9/DA9BuNR/VhwDO3Guj9g1A1NTv+VIf0=;
        b=Qjsnnb9Ae+d1m5iAsNYO7keiPSsfpH5L3LyXpmFBgG1eB0T3GEvQyqj4dpZsSNPyen
         IvCQCQwrEzgEgwZqid7i8yjoNM7FVk9UmBqgcslHzAmdpkuDr254NYTdSa72x+JEie/V
         pAYElDrJKWYerkl838aFo7fdwM+TPcQJFTofJ652LsE8n78XvxeUEbmyshBVPeF9l8Ry
         YNAPULLM038dcERl9uKKfOuc2WzEcg1MBrmNg2Rb+Fj5Pv1y3lTH61I/VVC913fem1lq
         1tIEeCfMSiMJFsatfdi1XiYjz2Z1gCPbgFYPwme9qqoYEjAlCjAUcibF3WOcyESWsHs1
         UQfA==
X-Gm-Message-State: AOJu0Yw/DnNfoCmJcchNjGVB4XTYiBGdSkCx43vz3PKErLFhfeqLNlB9
	yGc9BfX/Zp/Tmyvo+lh+5gRTTCdmtXcvtMbDysuqRX+oG8QAGwYmY3p0v7/t
X-Google-Smtp-Source: AGHT+IHPfWW121AaVvKLP7rcHI+7Wlqt/jJ8THFP0dtYQ4QzzblEMRJpRciE6ykQJGNqgTeU4L1iQA==
X-Received: by 2002:a62:d14a:0:b0:6da:bcea:4cd4 with SMTP id t10-20020a62d14a000000b006dabcea4cd4mr99088pfl.16.1706122453772;
        Wed, 24 Jan 2024 10:54:13 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm14113696pfb.214.2024.01.24.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:54:12 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v2 4/4] bpf: sockmap test cork and pop combined
Date: Wed, 24 Jan 2024 10:54:03 -0800
Message-Id: <20240124185403.1104141-5-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240124185403.1104141-1-john.fastabend@gmail.com>
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Its possible to cork data for some N bytes and then pop
a some bytes off that scatterlist. Test combining cork
and pop here.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 19 ++++++++++++++-----
 .../bpf/progs/test_sockmap_msg_helpers.c      | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
index 8ced54fe1a0b..cfb965f6832f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
@@ -21,7 +21,7 @@ struct msg_test_opts {
 
 #define POP_END -1
 
-static void cork_send(struct msg_test_opts *opts, int cork)
+static void cork_send(struct msg_test_opts *opts, int cork, int start, int len)
 {
 	struct test_sockmap_msg_helpers *skel = opts->skel;
 	char buf[] = "abcdefghijklmnopqrstuvwxyz";
@@ -29,9 +29,12 @@ static void cork_send(struct msg_test_opts *opts, int cork)
 	char *recvbuf;
 	int i;
 
-	skel->bss->pop = false;
+	skel->bss->pop = !!len;
 	skel->bss->cork = cork;
 
+	skel->bss->pop_start = start;
+	skel->bss->pop_len = len;
+
 	/* Send N bytes in 27B chunks */
 	for (i = 0; i < cork / sizeof(buf); i++) {
 		sent = xsend(opts->client, buf, sizeof(buf), 0);
@@ -48,7 +51,7 @@ static void cork_send(struct msg_test_opts *opts, int cork)
 	ASSERT_EQ(skel->bss->size, cork, "cork did not receive all bytes");
 
 	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
-	if (recv != total)
+	if (recv != total - len)
 		FAIL("Received incorrect number of bytes");
 
 	free(recvbuf);
@@ -88,9 +91,15 @@ static void test_sockmap_cork()
 	opts.skel = skel;
 
 	/* Small cork */
-	cork_send(&opts, 54);
+	cork_send(&opts, 54, 0, 0);
 	/* Full cork */
-	cork_send(&opts, 270);
+	cork_send(&opts, 270, 0, 0);
+
+	/* Combine cork and pop small */
+	cork_send(&opts, 54, 0, 10);
+	/* Full cork and pop */
+	cork_send(&opts, 270, 200, 50);
+
 close_sockets:
 	close(client);
 	close(server);
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
index 9622f154d016..4c7e70367e35 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
@@ -37,8 +37,19 @@ int msg_helpers(struct sk_msg_md *msg)
 {
 	size = msg->size;
 
-	if (cork)
+	/* If message is not yet fully cork'ed skip push, pull, pop */
+	if (cork && cork > msg->size) {
 		err = bpf_msg_cork_bytes(msg, cork);
+		goto out;
+	} else if (cork) {
+	/* If we previously corked the msg we need to clear the cork
+	 * otherwise next pop would cause datapath to wait for the
+	 * popped bytes to actually do the send.
+	 */
+		err = bpf_msg_cork_bytes(msg, 0);
+		if (err)
+			goto out;
+	}
 
 	if (pull)
 		err = bpf_msg_pull_data(msg, pull_start, pull_end, 0);
@@ -49,6 +60,7 @@ int msg_helpers(struct sk_msg_md *msg)
 	if (pop)
 		err = bpf_msg_pop_data(msg, pop_start, pop_len, 0);
 
+out:
 	return SK_PASS;
 }
 
-- 
2.33.0


