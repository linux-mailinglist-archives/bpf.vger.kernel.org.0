Return-Path: <bpf+bounces-20137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC50839C5A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 23:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D055D1F26562
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1754663;
	Tue, 23 Jan 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQqQBXpZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A053E2A;
	Tue, 23 Jan 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049384; cv=none; b=KGS98o/PZ9XDp4iTZEoqqKPtbGGCe8o+nBqTIHhYyiuWUJsEFlkrIOzspaWM2EAxCQDQMvLZwMpMxCePlsZE86Dzs4sFoqIB2NeWLWUVHL7M7NUnn5M521xDqtlFj5mymhpHEnwp+CQJTlgC8bi1vNnopWnUBOZmYO3CQeJ4VUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049384; c=relaxed/simple;
	bh=FvTPq8r3psPA/b4XyP6dgSK1rKEQuJBwTYolAtZNHYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+CQnyoMk2ig7qRdhjQFC1MP1ZEnSV50UOGjPFOEs5xiQOyUJvtH7ejYREkLtUc99DO7VJlaMFfrO0SItGOVGWR0byvrrwRagN86h+j1NjreiKpXa1lvQrAvfMfE+gOVpSv0r6eaIAeilq0ke57dQSL1IC0STQU4Gq6hJ5kLoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQqQBXpZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d75c97ea6aso17189315ad.1;
        Tue, 23 Jan 2024 14:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049382; x=1706654182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXT9I2pywE63wO1/MqrFBdHXmKrk7hgom4ddV7IFy0o=;
        b=HQqQBXpZ6yWstOXTobkTiwgZKMzK9kqsp8GafLhi2nGbVQcUVANU/nMjKBTUAEsA+b
         nscZ8Egxxb4Jt6HuAehb1Nd7VFOBfShIWgyBm7+AaVrvxd/vm0/JX3lGcDQkNoCIZmNI
         ET2z7WI4jadSafycXonfMP5rZZqwI5SYESPqWPIdhN3s1d8Xr0Ro9ovVbmaw5MmIG3HB
         U4zuIuo8tE8aoHb7rdzVDF1HUzUIPjZPJtdgvv+LEQCyv0QgWGef0wvJfZgx0EsEMfaz
         BiYZoe6ydKEdKA24VqUqkGCk0c9gl+fDdYk/AwQnUPzSTJ/03SC4EgGPUVyn8uUhh6p4
         DacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049382; x=1706654182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXT9I2pywE63wO1/MqrFBdHXmKrk7hgom4ddV7IFy0o=;
        b=BBc14j0yPy5RwPrHRBDMT/lzfqWjCPFSvqs9lockET5196908VGvbgBcq+HInWRIe9
         2uFQFpTgVnP65ENR4JC4Auzuycl3HJX4NzGnRp/525Cfb3+B8eLIk95v8ixHfa88+x0V
         2UrT86TpXBuG1IXwiTbRLHM/Ttu6cnuML25JCnrbEhFzEbqubLedqaf81t9DinCQCkbw
         6goA8cdfHWO62wKFHziEFBGi8+rkM3/4LbsI17a6j3B5evHZn8ntWCHxnK/+Ky1fkH7B
         dBFSt2/bncVGiRYiEA1YzySNlwEUD/D4EYvwDDpzIVNL92XwRFUPHP5BD7/fCYT+xGzx
         D+Sw==
X-Gm-Message-State: AOJu0YxtTj5G1/3igqY/NKUNr4DpzM6TxQudPVMCAptdbKYhqssWfZlw
	CvsgA5fe5Gc+YQDerSNyHLcB6obmMbwl5fjqN9QtT6FxGMfUdT1yVEO73JiW
X-Google-Smtp-Source: AGHT+IHku+fSLL8hrCGp40sjLm/uwwPKwEk8IL+NuCflLaf7MPVPzkoQWcQU9fNcBiXB6iETUvPe7Q==
X-Received: by 2002:a17:902:64d0:b0:1d5:ecfe:4d69 with SMTP id y16-20020a17090264d000b001d5ecfe4d69mr292993pli.49.1706049381747;
        Tue, 23 Jan 2024 14:36:21 -0800 (PST)
Received: from john.. ([98.97.113.214])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm4875241plx.154.2024.01.23.14.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:36:20 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: sockmap, add a cork to force buffering of the scatterlist
Date: Tue, 23 Jan 2024 14:36:11 -0800
Message-Id: <20240123223612.1015788-4-john.fastabend@gmail.com>
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

By using cork we can force multiple sends into a single scatterlist
and test that first the cork gives us the correct number of bytes,
but then also test the pop over the corked data.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 81 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_helpers.c      |  3 +
 2 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
index 7eeba3a35242..a05000b07891 100644
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
+		goto close_sockets;
+
+	err = create_pair(s, AF_INET, SOCK_STREAM, &client, &server);
+	if (err < 0)
+		goto close_loopback;
+
+	err = add_to_sockmap(map, client, server);
+	if (err < 0)
+		FAIL("add to sockmap");
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


