Return-Path: <bpf+bounces-43095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74D9AF3A6
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F403B1F236D3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2C21643A;
	Thu, 24 Oct 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K4SgISXo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8816E89B
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801783; cv=none; b=hzLPEmnVYmYXl/NOuju4O/y7mv3sXLTIp6fFG8Zaz1WWMmMmg9Cyze/5SjBL1bgzIEYdFkuAUXMrZmig9OpstKZvsXSxe6dMJwYkvL7JEWqJ/PGWzfTEeO11z1PczkVRWIstfaC7PtLg2pQ0TKeoqlBFOD07s/8NDoz/5352RWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801783; c=relaxed/simple;
	bh=y5xG5PZaDIdA5ZRhc0eCzfqeojjrLwjp1ZGtaVGyGM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQOBTJ4OYdcQTC4rJkURQlFLKjBDKSa2P2Vl62joKBkQyOKRJAL/oQeWbsEjm8Stj+LmRy6F8LvFl62jVr6IbooxCWncDDqT1Bu/LSF5UMlLExSnpjtAANaVjZGUOt7QSSKp9QgqHn7OLl5a73tJbjSCyMvDtsHYyvD+Qud7JS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K4SgISXo; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460af1a1154so8233951cf.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729801779; x=1730406579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEFUQiY7ce/KeA/4yaA7IZEeCrfS6Isv4u/QJ5N6wws=;
        b=K4SgISXo5AePFZERnIbVcij+FUChLnKnX37QfUQ6LVNBuWCZxJvVLADJCVUkoNNLtE
         NUiTobgwekL2H+w8TbyxZQtCUa5DwisHP5nCvtpd+lTrHS0fHCBMXMkD0DJRKCidqOfr
         pLGU83encz4/TqDNEgG4d2LZ8mc4MhgFoq2sJoB2oHJpd8FF/wgu1V6DDDkdgktTtn20
         56qs8fI4bpluPfZYU7K0IrylnBRwfIR+mJeOCHh1cnbg3A7Mk0VVrQCeIBrPW8Up6Por
         I4OxENAjGuApmZfQwECgqnwUohqPavm6x+iGwFXXYT0hg66NgcGNCO6tioVngop3keB0
         T43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801779; x=1730406579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEFUQiY7ce/KeA/4yaA7IZEeCrfS6Isv4u/QJ5N6wws=;
        b=XoyhlK45NrAHJw3h5u+CVhH1qrt//6ZwstAo6cCx/+KnB9z7Onhye5i7fmiAA5X2vW
         crAxTNT4KvqVgdgn242KTKZMdSacpJv2E8OX+tN/8EdFKeI24yx9xcVe6QAyKsbxz5Gv
         Ab0tMdZ3n0zt/8V+++uj+kjC3OjFmob/7d+WQIxubXli4jfWtN0bepoD/iUN4dq1phqv
         z3s6PO7wBG46A3mxVlSCLhq7rxTWZnqMj8pK28XU1zJo0ITHGbxQhc+6SNnrcUaFaNmq
         jrSNUPzBruTGJtmLGzUHSsNQGNg4/bdzXWqLNR1YRs5OLCmAFFloHs4ESbl9R5KZ3BPI
         lRYw==
X-Gm-Message-State: AOJu0YyxVSFDAQqF6R2ssK6bVw3Bh51FSru+2toN4wzNvhdKlsaYdZ9q
	Dt7nxn2No9fHU2Ue7YouCetOPQlZyZgL1SPFbK6yvyYL9eBS51jFv4X30SrkM2IC+xHfaYrhl7m
	A
X-Google-Smtp-Source: AGHT+IGMcvzQmOYWk0hn7PvIzRn5w7ky84jbLhm/dTeW7m37PTCJ5nmtoorUaX5hC5TlrdF3CniASg==
X-Received: by 2002:a05:622a:89:b0:460:dd3a:8f68 with SMTP id d75a77b69052e-461145b351cmr80794681cf.3.1729801778817;
        Thu, 24 Oct 2024 13:29:38 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.215.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm55486081cf.52.2024.10.24.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:29:38 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH v2 bpf-next 3/8] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Thu, 24 Oct 2024 20:29:12 +0000
Message-Id: <20241024202917.3443231-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241024202917.3443231-1-zijianzhang@bytedance.com>
References: <20241024202917.3443231-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop into account, so we don't need
to subtract some bytes from iov_buf in sendmsg_test. The additional
subtraction may make total_bytes a negative number, and msg_loop_rx will
just end without checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 1d59bed90d80..5f4558f1f004 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -606,8 +606,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		clock_gettime(CLOCK_MONOTONIC, &s->end);
 	} else {
+		float total_bytes, txmsg_pop_total, txmsg_push_total;
 		int slct, recvp = 0, recv, max_fd = fd;
-		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
 		unsigned char k = 0;
@@ -628,10 +628,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		total_bytes = (float)iov_length * (float)cnt;
 		if (!opt->sendpage)
 			total_bytes *= (float)iov_count;
-		if (txmsg_apply)
+		if (txmsg_apply) {
+			txmsg_push_total = txmsg_end_push * (total_bytes / txmsg_apply);
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
-		else
+		} else {
+			txmsg_push_total = txmsg_end_push * cnt;
 			txmsg_pop_total = txmsg_pop * cnt;
+		}
+		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
@@ -800,8 +804,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (txmsg_pop || txmsg_start_pop)
-			iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
 		if (opt->drop_expected || txmsg_ktls_skb_drop)
 			_exit(0);
 
-- 
2.20.1


