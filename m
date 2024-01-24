Return-Path: <bpf+bounces-20257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5083B18F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA64285494
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C0132C02;
	Wed, 24 Jan 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3I6p56J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE2131E4A;
	Wed, 24 Jan 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122453; cv=none; b=GbfKuVn1qcEWDFP2+ba2IBj2mPmud45MZEHiuBx+AAhv8gnH5BT8olN22Y7x/Co3F699+/Uz7wg0yMWdFst+j1P53KE0tRcxwVb5p0HqkTRyKJgiQZuMPQ3qs+QXnCe9+kdCuSYKawMjlJrnKSqX/0F2dSDJzMoJYY3wqphpDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122453; c=relaxed/simple;
	bh=Jq3Or8NJ0GJ9VdEOqtczXgyaZGRJ1hVkHCU1N/bpPNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNP2UVJLjZgHoHZejTXlhijwhYA+r0O+XmABn6DFvIkimkz5mit45vB37y+JXl1olnRUyLP2XNn71MjNzlts/jVDUO0w8w6pwiQ2fvAa+EnHKt8lLgsqoR/HcA3xtl5g8nxP/o6LVAI8qXGfJs9hsojev4M6CCxa2HwTL51yXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3I6p56J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dd7a44d51bso1932272b3a.3;
        Wed, 24 Jan 2024 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122451; x=1706727251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLfrQKp0BI/MS/C+9kJL3wZUi8/Fej4YlyCO2sBCq+o=;
        b=S3I6p56JassA9zl7AvhsNvllFNHF0jUco4x2nnOe8kbYvxAZf1zLmxO0HCf0fGyabP
         Tj71na7hhvjUCSYswL06gHYGoHC21EzXY2lcIliH1CAp8fnTUo0progZ7B5rEMgVpEnU
         0JtY2t8Z3JYqaao2KR3eC5vYUanJWZXF9dDsOck7MSH7HGrSHeYsLWIYP6RuLBP4gVjI
         CtmaPR0uARvqRzhsZhuR8ur63oqoj7DYZWTwGhCj6sQkKhjZUdU8DoARs7wTIEGlVJ4Q
         PvWZmmloLE2cmAgjmYDC5uozTJUJVk6/bVZKQMVBtxOV/wQIQzrvn65jPcwVN5sYsG1L
         apRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122451; x=1706727251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLfrQKp0BI/MS/C+9kJL3wZUi8/Fej4YlyCO2sBCq+o=;
        b=twkKHmN2/OrRGrPVwfxksS3m2jlnIPjo3Zbg5AvrEWE/G1CYdQDrVFPH0wMJns9hj1
         h3qE1MgHD0HwA9oD4FU8U/0G/ewpZ5Ju/Qmd8T3GEj2nIUcw94amopwlCbAZnDxA7JCd
         USzouH1LR0ZVcYwlAuLjymrngqGj/asEaboZO89Cj8euc7gveKKJl2DgxVudbdsd7xHR
         M364afnWwS7X8A2DR8Z5ulSBCTc8/z72LBx3CqwNDbMwZv741VdsrkU9vY/RnJFWRA9d
         TWyWlo83/59cNw1xD/mXJBdWOXzlUbEqChTH0Raa41KY0qaeJQmeAmpJzfQ7Fjw1QjKA
         BcFw==
X-Gm-Message-State: AOJu0YwZi89D+mQd+O7c1Lp365bMXEPP1IjsY6WX2oEOftCCJoBgztAG
	V/fgygVlztkpGh/i5LnVBd3h2EmlsyIMnvdH0OkgzAFcE6uQ7IDn
X-Google-Smtp-Source: AGHT+IGTC7RqOQ1STyMt0AUcPhq8Q4hfexFYFkK6H5MvhUmuVspZe05sQOnQ2pWtiGZFuiT3lRtdmQ==
X-Received: by 2002:a05:6a00:a26:b0:6d9:bf50:1c71 with SMTP id p38-20020a056a000a2600b006d9bf501c71mr6562643pfh.48.1706122451622;
        Wed, 24 Jan 2024 10:54:11 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm14113696pfb.214.2024.01.24.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:54:10 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v2 3/4] bpf: sockmap, add a cork to force buffering of the scatterlist
Date: Wed, 24 Jan 2024 10:54:02 -0800
Message-Id: <20240124185403.1104141-4-john.fastabend@gmail.com>
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

By using cork we can force multiple sends into a single scatterlist
and test that first the cork gives us the correct number of bytes,
but then also test the pop over the corked data.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 81 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_helpers.c      |  3 +
 2 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
index e5e618e84950..8ced54fe1a0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
@@ -21,6 +21,85 @@ struct msg_test_opts {
 
 #define POP_END -1
 
+static void cork_send(struct msg_test_opts *opts, int cork)
+{
+	struct test_sockmap_msg_helpers *skel = opts->skel;
+	char buf[] = "abcdefghijklmnopqrstuvwxyz";
+	size_t sent, total = 0, recv;
+	char *recvbuf;
+	int i;
+
+	skel->bss->pop = false;
+	skel->bss->cork = cork;
+
+	/* Send N bytes in 27B chunks */
+	for (i = 0; i < cork / sizeof(buf); i++) {
+		sent = xsend(opts->client, buf, sizeof(buf), 0);
+		if (sent < sizeof(buf))
+			FAIL("xsend failed");
+		total += sent;
+	}
+
+	recvbuf = malloc(total);
+	if (!recvbuf)
+		FAIL("cork send malloc failure\n");
+
+	ASSERT_OK(skel->bss->err, "cork error");
+	ASSERT_EQ(skel->bss->size, cork, "cork did not receive all bytes");
+
+	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
+	if (recv != total)
+		FAIL("Received incorrect number of bytes");
+
+	free(recvbuf);
+}
+
+static void test_sockmap_cork()
+{
+	struct test_sockmap_msg_helpers *skel;
+	struct msg_test_opts opts;
+	int s, client, server;
+	int err, map, prog;
+
+	skel = test_sockmap_msg_helpers__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map);
+	prog = bpf_program__fd(skel->progs.msg_helpers);
+	err = bpf_prog_attach(prog, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	s = socket_loopback(AF_INET, SOCK_STREAM);
+	if (s < 0)
+		goto out;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		goto close_sockets;
+
+	opts.client = client;
+	opts.server = server;
+	opts.skel = skel;
+
+	/* Small cork */
+	cork_send(&opts, 54);
+	/* Full cork */
+	cork_send(&opts, 270);
+close_sockets:
+	close(client);
+	close(server);
+close_loopback:
+	close(s);
+out:
+	test_sockmap_msg_helpers__destroy(skel);
+}
+
 static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
 {
 	struct test_sockmap_msg_helpers *skel = opts->skel;
@@ -260,4 +339,6 @@ void test_sockmap_msg_helpers(void)
 		test_sockmap_pop();
 	if (test__start_subtest("sockmap pop errors"))
 		test_sockmap_pop_errors();
+	if (test__start_subtest("sockmap cork"))
+		test_sockmap_cork();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
index c721a00b6001..9622f154d016 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
@@ -30,10 +30,13 @@ int pop_start = 0;
 int pop_len = 0;
 
 int err;
+int size;
 
 SEC("sk_msg")
 int msg_helpers(struct sk_msg_md *msg)
 {
+	size = msg->size;
+
 	if (cork)
 		err = bpf_msg_cork_bytes(msg, cork);
 
-- 
2.33.0


