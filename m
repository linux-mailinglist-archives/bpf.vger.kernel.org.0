Return-Path: <bpf+bounces-76141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B8CA8940
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B24B31496E9
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C29034A797;
	Fri,  5 Dec 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJcc/leu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E2346FBC
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954750; cv=none; b=As9bUCpH3Y46/bOLcB17393mW3POOh9CSl1dZUU/8MhJdagErpy6kU8TABaB8zbNy/1vIJVan5hU9StY508M84+tn/mkp7LwDTWSk2zaL6AFAO9K8hTnds3lxhu8k7VEV8oMi4KhRwJaMT9yJSDaVul++X8fDHyveUnK4sv1lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954750; c=relaxed/simple;
	bh=do1Bg/NFLX33ofPgfO966WaBXgkhnoSqIQc8ImWQeBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pupNge/zSVQ7xDeIqZXUMpdlxxc8vfNsFQauN3fsHMiYwJpSaBY18gNePc1t1s1BfgjaL8Bc3ZF1nlT6NuYqp+Q6Ho/ktevAufqEXgtbKUqZHpLHfosHbv5HX6XAOd3QJuCk9Eqnolw3BqR2a2WuThnev/0EArNGA3RFk+fjR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJcc/leu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so1855193b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954741; x=1765559541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=JJcc/leubWpbR6RaFOVl0RXLRBCSczZylWdedplWoRQG8mdVWZ+zJQjfODMK291mvj
         t3pUpRf5u9YyPcJFXg2udcz7N/H5mfJ1h9/mMDnJN5VdKXV+E6dWEp5oIh4n8cvkmxdw
         tAKxsG9OdWEsRZAgjfhQCnAg3i0e6iit9eFbVTzOSkplGDEpNwbwCGSyrAjuFesV65Th
         HLFfOChvCg4B7wUs/2uq009bbRBd+Y61OW4F/q5uOXROne/qYlj3uwxTQYxLSPxa7MS+
         JCSeQCffGWKsEA9leDcJ89AtI9JpHWpxWELnyAwV6L8J9GuvftacqM8bTC0UoAtvardk
         UXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954741; x=1765559541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4SfGUccxqrR4if1UC28rI8dysNOUR1N9MIrnXXKvTU=;
        b=S1cJ+oiAwL+bnhxajMdsGI9Vk3ZBM9KQ/t/HrXa/zE3Z818855ZtLjBmopOKRDSgNd
         QcXpBWxgtbiZbTMtsYrahDZc7bFTwbKnCgLtgepATcM3yRH7liHnag6AmiICOZS8yF1d
         0G+eeELzwvWtkNhBMyf41Ibb52zdZAMdgcE/qel//8SMntvvSiO2cijkNIXgSpkP4akH
         LpKAf0Em4rbsv5xwcU1Nt7YiHVGi5TO/n2SQw+cZFRgVGmIvCB1sTNzG7RqvuiJG8iEh
         c4oJb/6reHH4HhrX2LoioszdDBtE332HZqx1FTKJ/7UlwoEZtsoq6kFjmx9TZ6rY0Ks4
         peeA==
X-Forwarded-Encrypted: i=1; AJvYcCVC3jxrCR1/vcTCmNPCx+omrnC8u8dWxmcJX6qsuxcHQN3AYTD3Bt0vOCJ6H/cgZHJAkzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS40DMehuLqD4MpD/knT35p0+qTl0IUy2nNqZEj5UNpjoIPTH2
	16rt+BMSW3k6dNNRfgVTKffAhk3DLpweO1Ze8XU10Cgi+7ncKye9Et0Q
X-Gm-Gg: ASbGnctDfsCtKvBwckNKUGaxGgHYfz4fYtPS94yhjXNdpbCayZLYhv4bhUFCa3Z54i2
	0dRMWwVYFM8M98ETLk6BfJQ1gjkeYNbF53UK/0SOb6EP2Z04FosxzmE45jMHhZzFSOCmIouva/T
	Qs99GWQ/8dEzk+f1WcCouFMHyZersmHLUXeDB3Ak/gS6iATdwW8G926n/gBspKrZ7rvEiNqftpg
	C9d+tZv/Pt/L4aKGqwfHHtBvt1jSQYUtu+o/LMWuKEv+nfYh6G2hpK8r5+6z0STvcF3dl5mqLf3
	s/LrVwFLVPmk3vJphDRBItfWXG4hYdM5vakWfzO1gy3yqMmPPzVQP0OhR4uxhZ2B8BLoSw3FfzX
	71rWpb34q7QnHv4NvkNTCmWu0zo2bfxc9UsVwyru2sKJLnKUm7tGDONn5fWXSaCerjK+gbzZ6pU
	QFBF2P0r2MfkA4vNkTa4JJMK0=
X-Google-Smtp-Source: AGHT+IFUqGTh0jfpOherdnSNnGlDOOKwq7w7579tMDelh6u7LEtZVG3BYcM84jhxsPCvqwA1KoLyZQ==
X-Received: by 2002:a05:7022:ed08:b0:119:e56b:98a4 with SMTP id a92af1059eb24-11df6463bf3mr4137737c88.11.1764954740834;
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20699034c88.9.2025.12.05.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid uninitialized variable warning
Date: Fri,  5 Dec 2025 09:10:02 -0800
Message-ID: <20251205171010.515236-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following warning is seen when building netlink-dumps.

netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized

Problem is that the loop which initializes 'ret' may exit early without
initializing the variable if recv() returns an error. Always initialize
'ret' to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 679b6c77ace7..67bf3fc2d66b 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = FOUND_ERR;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.45.2


