Return-Path: <bpf+bounces-74351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B283AC55FF2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56733B514B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210A3164B1;
	Thu, 13 Nov 2025 07:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ2S3dvm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276D30215A
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763017536; cv=none; b=f5dMwguKtpldSNJ0VQakqjMBzypG4q/QO4ngvEIwlYQmaHmx0Kd1mm/t0FUuDf5ezIk3kzhy9fAnAv+EQlwemx0iLle9b2bVEnsZLmWW2oTLPzKDhuAf+j+eqDadPzT8j0Qppsu9oDM0KrBYmzb6NXKriCR56ES0dVaRKhCRN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763017536; c=relaxed/simple;
	bh=keF8isQ7PRTzmhDOfQW0KDrfHfYD8nn+YCdoc88UXiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=js9XvfkDQqdr3LPBcUZ9W4InRBVt+j4y6AZ4TFUqOiil9vu7nVZjXLgl+ENlNZsaIXxcastH5j65oaeb4zMlTYMQo+4Vn5dazh2i7eLJ3hh/uPWJtL9vPbi0jLIcQ8hQCyGe/YXji+AmzdLeecqUdRIxVqeyKhNpqt0eRq2CYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ2S3dvm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3418ad69672so342348a91.3
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763017534; x=1763622334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKsr+UWxKO/5KqXRVEUoCYi9gM26aD+pS9NLx1OfR4Y=;
        b=dJ2S3dvmF9A4nPea5Qal+GMMTf08Zt1JigU7OEeaJMz1AESXyqeuprEpZQaCKch1pl
         e0NSTJwlJMASasn1TqlI3bh2dhcHPAV8ffzk+Az7j+uAYGkam5zIK+lqnNP+RqyAUB4S
         86DCB4TX2VnVZxoWTjulArj7RWhDTqNUCj87NFta8t8WdhIzzz4mKDbmKU5+4e8rQYs7
         NOj7e+019s/OM7Aw3MxWHRAsVWGyLQ5P7cX/KRgzjAzQ2xo7XXp7QgdEz3SwnNBsS2iF
         SOLwVcy16zb9Gdb2jrzBDrDJfiCwfaMDZxbbjWNC+sl55YvfoFzvRQAJ6K6bPlKXni3Q
         FzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763017534; x=1763622334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKsr+UWxKO/5KqXRVEUoCYi9gM26aD+pS9NLx1OfR4Y=;
        b=T+wHf4OUAaLYgITyN80iPHvwV6+Gs4SVcdOHtkcRj0UfiuTNYKdVjUqaFTjHAgSOLs
         5uU6Z+RuTK/gHEWJrBKHS4mGiqGL1N0XpGImtEyO9VLKoiZ0O0T7RqFO4WEN1xY2iz3F
         Pw1noCToq94B+0Vyf+TczF1XwwASvyyapBy1/fKF6yIirfiAaeh7la0hA0jJGI9hN7WT
         LqWB/cdZtYJkRxUrSV9op1D0R+x9fd8HdxbSz6/KyslDFP5wMnEYA0z0QzYe5pbXMj0Q
         0kSQ5cToxHyAS4LvUbc2wrJcW77qHwi0RvBP+0ePsN4jYftch/2xivEmCn7xw769KxhU
         cjbg==
X-Gm-Message-State: AOJu0YygpQMAqrTcDamVCcHou4esO1nhJ/DlSuBvlqI7acGtzWbs8ccg
	J35ZmUCVH7tKfYiSxJtR1Dn+F1UyHTosbsCkG3mbbMGu3r9wyqKi1M3Y2XrGiA==
X-Gm-Gg: ASbGncuQzFunEXfDYxoBDWFJ2HMAZYnpxmxcF997c4hHa39Cik2GuOpbvBDQ9Z37eXO
	Bz4Fjihla97nKDQHspfepyY1SDpPDhJdk2rZvvnHKPebLs/wTbJS/isDurIk6EqNFtsEXc2FCAa
	GRXdYIeWkp75+XG6kPX2OrdOD3ErZMzV5jiZfUoC45XmJuHMP7h8KrNNiHAYMnUZDkLTr3BoyVk
	IwGOlWkuYuvQeUXAskh5lgnb1gBTRLwRctxaDmmiPoM55TLbWD2eILOPv2c8tvfC5fofqmddT1j
	S33lfXRa4cMxGswnbDkJ0LHhcjGX69ZMVDAOo9ojvDi+8UWymFEPCnbdHlCqM3HDYXml72IddJJ
	cslcuJ9peW+R6fD2eAwSK0Rn87UkVlejnkx7djvb4maoa75QJy1b2fz9Zak2omCf8fv893x0unq
	1uZQ5vrQg9UTWpVTE2sZ4z2D7Z9pSj/IfaTsWFypwXRFMi
X-Google-Smtp-Source: AGHT+IFPXMAHaAkwk2P/QuQ7KTdUBD1s1HCIZ8XewRcT0n/CD0wIp/OETrFlAcrD3Ei1pjP5f1UMSw==
X-Received: by 2002:a17:90b:2742:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-343dded0719mr6475067a91.34.1763017533701;
        Wed, 12 Nov 2025 23:05:33 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c944bsm1332911a91.5.2025.11.12.23.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Nov 2025 23:05:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix failure path in send_signal test
Date: Wed, 12 Nov 2025 23:05:31 -0800
Message-ID: <20251113070531.46573-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When test_send_signal_kern__open_and_load() fails parent closes the
pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
continues and enters infinite loop, while parent is stuck in wait(NULL).

Fix the issue by killing the child before jumping to skel_open_load_failure.

The bug was discovered while compiling all of selftests with -O1 instead of -O2
which caused progs/test_send_signal_kern.c to fail to load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1702aa592c2c..61521dc76c3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -110,8 +110,10 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	close(pipe_p2c[0]); /* close read */
 
 	skel = test_send_signal_kern__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load")) {
+		kill(pid, SIGKILL);
 		goto skel_open_load_failure;
+	}
 
 	/* boost with a high priority so we got a higher chance
 	 * that if an interrupt happens, the underlying task
-- 
2.47.3


