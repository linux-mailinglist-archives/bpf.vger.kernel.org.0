Return-Path: <bpf+bounces-20256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9E83B18D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B97B26B0D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59F131E4E;
	Wed, 24 Jan 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2HnZ3n1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D2131E3B;
	Wed, 24 Jan 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122452; cv=none; b=MZMAZLyLch0ivpw70UICp3dtKOUtUjHpxt0R3fH5Non65aoK+kdjQQ2BeAlBkBZHjaLJeEFqshxdfDjzyKpojoHPfB1LNnAPL7yOgbyKv6NZhoUzahTD5PL+ay414k09WsGyECRe5i3OIIwOi3puh+pSTcnocim+T1FCqu9U+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122452; c=relaxed/simple;
	bh=Uu/SwqAnEEfj6bz3iaYVr9X49+WecBYMiwA+zR/KRas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOrnU8nQslIIWMyEnW166uXkS+yIpQF4devetzeK886Fbc+RwRIa/ETXhH0xCV4AZD0HHCnC3elYI1zgIfx2teakwf4m5kf5dsWquKzqum+7aHFTVfQ9sHfbtRybOXhup5pjOdhClWe411W9IEAgnyuhzUNcXyx6/WRkfJ/guLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2HnZ3n1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cfb81124ecso4241915a12.2;
        Wed, 24 Jan 2024 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122450; x=1706727250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0NtAqbHyngCcUSOczUVS6y+pvGJR3Y9mdYKUB6jL1U=;
        b=e2HnZ3n1CxEGhjHs8LsuXMlHjqzeJ+j1ceaA6spzVEVPt2ElfMax+9NgmwfaXBfbH3
         Df1ZZoRpabToEJXN04vW3cADZJojmOp+tuXTljc5VaUcA/pdnZBjfU3b/OeZZPzduysK
         Uw99cWga5/5jYMo7E1HoSRj8BQ2YoXUF/zdKikpDIX5X+qtVXXwWwvVUPVfId4uxk9gn
         2AMyoEPQ402D1HSbGlbUxT9v0oyBDHnXwYernjnQubsyjkWvErxeEJBDcqCWv5Y1Ix1W
         EylCPRQrk5FXl+xdHQHGTngqpmo9V0H94FPUZB6ahKBXmqBQU0vLJ38GZUioVyrFi7JV
         ReDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122450; x=1706727250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0NtAqbHyngCcUSOczUVS6y+pvGJR3Y9mdYKUB6jL1U=;
        b=PRDMioN2nDsLKbDzkC7bgg6+3iczhXylv7a6wp+Bqjaq1JXQn7olmn/33mO+OqlnKl
         CAc/dGHx3Q3LeyuTmsUOwD9tfES+COVFtXi61Hd9OuZs6wOiXcLia9mG70h+1oThVsx0
         rXNQeFUvsVDp1mYbP7oHbEPOh+8aOFhGu2qxJZMeayfylky0DXqBh6n9janSr1jy2rpF
         1yZrlpbGIMw0Vsc0kVCM+24rTIGZsMwYNnxxgcZGdqoca4dDwLQ3g/YBqQ5CEGKyOgYC
         P+wEsbJ77p1Bfngdh6fMdXiQhsF3EzIEfpw4/xMuTPs+cwYfwMGSx5XQnFjPfm7rJ2ny
         vWow==
X-Gm-Message-State: AOJu0YzJ457y8uYi9YbXGN4vY5BEpJWw0I/DAu072FeaDbOSr2cs15Sp
	tXM5ENZ3SZb1gLyomYt3uDHaAsHHkXBWeHsYd55Lv5hERz+DpjSy
X-Google-Smtp-Source: AGHT+IHjuj+RLVRB1tMQnZIX6HZYdS4KBcxKAkpgH24vbv399tyOzUNXgw8p7QTTPer4QIBh1aZNmw==
X-Received: by 2002:a05:6a20:6043:b0:19a:39a1:f05b with SMTP id s3-20020a056a20604300b0019a39a1f05bmr1349720pza.37.1706122450105;
        Wed, 24 Jan 2024 10:54:10 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm14113696pfb.214.2024.01.24.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:54:08 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: jakub@cloudflare.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: sockmap, add a sendmsg test so we can check that path
Date: Wed, 24 Jan 2024 10:54:01 -0800
Message-Id: <20240124185403.1104141-3-john.fastabend@gmail.com>
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

Sendmsg path with multiple buffers is slightly different from a single
send in how we have to handle and walk the sg when doing pops. Lets
ensure this walk is correct.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../bpf/prog_tests/sockmap_helpers.h          |  8 +++
 .../bpf/prog_tests/sockmap_msg_helpers.c      | 53 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 781cbdf01d7b..4d8d24482032 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -103,6 +103,14 @@
 		__ret;                                                         \
 	})
 
+#define xsendmsg(fd, msg, flags)                                               \
+	({                                                                     \
+		ssize_t __ret = sendmsg((fd), (msg), (flags));                 \
+		if (__ret == -1)                                               \
+			FAIL_ERRNO("sendmsg");                                 \
+		__ret;                                                         \
+	})
+
 #define xrecv_nonblock(fd, buf, len, flags)                                    \
 	({                                                                     \
 		ssize_t __ret = recv_timeout((fd), (buf), (len), (flags),      \
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
index 9ffe02f45808..e5e618e84950 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
@@ -52,6 +52,50 @@ static void pop_simple_send(struct msg_test_opts *opts, int start, int len)
 	ASSERT_OK(cmp, "pop cmp end bytes failed");
 }
 
+static void pop_complex_send(struct msg_test_opts *opts, int start, int len)
+{
+	struct test_sockmap_msg_helpers *skel = opts->skel;
+	char buf[] = "abcdefghijklmnopqrstuvwxyz";
+	size_t sent, recv, total = 0;
+	struct msghdr msg = {0};
+	struct iovec iov[15];
+	char *recvbuf;
+	int i;
+
+	for (i = 0; i < 15; i++) {
+		iov[i].iov_base = buf;
+		iov[i].iov_len = sizeof(buf);
+		total += sizeof(buf);
+	}
+
+	recvbuf = malloc(total);
+	if (!recvbuf)
+		FAIL("pop complex send malloc failure\n");
+
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 15;
+
+	skel->bss->pop = true;
+
+	if (start == -1)
+		start = sizeof(buf) - len - 1;
+
+	skel->bss->pop_start = start;
+	skel->bss->pop_len = len;
+
+	sent = xsendmsg(opts->client, &msg, 0);
+	if (sent != total)
+		FAIL("xsend failed");
+
+	ASSERT_OK(skel->bss->err, "pop error");
+
+	recv = xrecv_nonblock(opts->server, recvbuf, total, 0);
+	if (recv != sent - skel->bss->pop_len)
+		FAIL("Received incorrect number number of bytes after pop");
+
+	free(recvbuf);
+}
+
 static void test_sockmap_pop(void)
 {
 	struct msg_test_opts opts;
@@ -92,6 +136,15 @@ static void test_sockmap_pop(void)
 	/* Pop from end */
 	pop_simple_send(&opts, POP_END, 5);
 
+	/* Empty pop from start of sendmsg */
+	pop_complex_send(&opts, 0, 0);
+	/* Pop from start of sendmsg */
+	pop_complex_send(&opts, 0, 10);
+	/* Pop from middle of sendmsg */
+	pop_complex_send(&opts, 100, 10);
+	/* Pop from end of sendmsg */
+	pop_complex_send(&opts, 394, 10);
+
 close_sockets:
 	close(client);
 	close(server);
-- 
2.33.0


