Return-Path: <bpf+bounces-20138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC194839C5C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04051C26BDF
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69754BD1;
	Tue, 23 Jan 2024 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mARSm+/X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245A54673;
	Tue, 23 Jan 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049387; cv=none; b=RuA++h0MF/ogokt1BtWhbXaO2IFipG6hwz4g/Ctoqkk0RlyGJ8ytDBv/OmNfEg/7/Hk5PHTQX5YSCDFqW1Xjk+aQHghLHLVBvzR8BTmvbQnXSBIJxtb7bXlDhQh0XSHekqwqNCiLfZQdv5H4//sgr0ocKQVbg4JME3DmiGNZcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049387; c=relaxed/simple;
	bh=On0QlHaF09Uyj7/AoUsVsIOpy1PzAJx4etnXBVkU+oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0zSt5Vx/xoMoiEbJ8gvzGQ8FdrBU0mr5D4IPd3k0mJ92LWvcjZhsfLTGDIPvHHF6oc5NpH8IBfFuYXObRL8XjBqj1+zlMBhI9lxDZ5HMeMFJjynmQpEUvDU1/4AR/U6aVn90i1xVobj9h1BgL8s5UF/0hMxCZWifDeNC3EqnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mARSm+/X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d6ff29293dso32426785ad.0;
        Tue, 23 Jan 2024 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049384; x=1706654184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/Yjct9w9OwNW7EA63W+TU6+iZOg/M5pr/hq6Il+TEo=;
        b=mARSm+/X7uZ2sdKdj2UajPqrY8i2pfmn2EOq/RZAOEESsPiprUkWe3kJuZIctBvGLy
         0wCMVmINkvkO/HQ9Tub0sG1dkahabneVfKGzHP4ACLrGAhPGM0HiSvMZ4XUTLdRMvNCl
         XNrpYF1kFn6F4IR/B9ruWYAeXZKAGjEVegYYjECcbwUAV6aDbfecro0vf7PvJ65Q39iO
         3hs6KUT9KlFV6tJchOtBBF8NtzjSmzNTHCOMK7PLRg/5TCZ3AB5ZsOllK1UflMGkO2eY
         ySs99/GjqAoxz+sCREyP11wbl9ed21Mi8NRxNgtGXs3JMxkxiqXyOxCeI/TrpFfepNGW
         kQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049384; x=1706654184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/Yjct9w9OwNW7EA63W+TU6+iZOg/M5pr/hq6Il+TEo=;
        b=Q01zZ55CtDfabfTxXp8dxcptIwhwpGIH4iESNGC68giTec7SBGIqoIo3J397W1HznZ
         Vw0AlSd4UJFWdM2QlKqhDOb3Jw5G25TVHnF0K1vIn7Ev+2+Sa0sEzZIjxwEZQl2gOHeJ
         3jTUVjPPtcLMtv7ObYBEt+lEov3Own63LeRp2INGRD4mzNrWw6bJBwTjWiUtPV4o9kxN
         tCmm9Ucg4wBclxjxTyAzI4mBp3AETf0x6KAHEQcX9d4iA189CwK23SvqMFmUYV+gQbcK
         WacupESWNjEblB9sibrWGULfvONKkgpA24Ep+CLWHJyd/u8FDzN3YGrXjavzk9yOiUtm
         +DtQ==
X-Gm-Message-State: AOJu0Ywqj/zrODSf5MMQz8ncod/QdUwIi0Dy82TZc2Yu5nGUeSCP/GRO
	ARwa8wkF9P1VrgczMVh4VKMa5pnQaExod+9Fhkbz8QWZXB++Kr9xCun++dut
X-Google-Smtp-Source: AGHT+IFM/1ZZ032mmP+pOj9N4TP8cIEGf04lpwTBJwL0JUQZ9XlYtgTCPSkhRRy6cXANuW7R+ORXFg==
X-Received: by 2002:a17:902:b58c:b0:1d7:a2:3332 with SMTP id a12-20020a170902b58c00b001d700a23332mr3600780pls.114.1706049383849;
        Tue, 23 Jan 2024 14:36:23 -0800 (PST)
Received: from john.. ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm4875241plx.154.2024.01.23.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:36:22 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: sockmap test cork and pop combined
Date: Tue, 23 Jan 2024 14:36:12 -0800
Message-Id: <20240123223612.1015788-5-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240123223612.1015788-1-john.fastabend@gmail.com>
References: <20240123223612.1015788-1-john.fastabend@gmail.com>
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
index a05000b07891..cf38d6bb3f94 100644
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


