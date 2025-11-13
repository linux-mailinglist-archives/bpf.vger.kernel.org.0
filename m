Return-Path: <bpf+bounces-74426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DFC595F9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723224F7D90
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184FB2FD665;
	Thu, 13 Nov 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo8Wgh48"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C6328604
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053920; cv=none; b=Vn6eRcv5d/l2lODVODepXns7h+ch2Gv0P2AWpXZjXMb2Vlc03tCTJSUvf5Ifvz99ofFeOC5c/wSU3JV/Csd15h7c90xmGfAxRXD+cdjAwCGgng/JwYpwyLw4sgjhajkDUSVA7xTM7qFlQCkTW/KJGFCA1Sge2x5mEA66vWnAWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053920; c=relaxed/simple;
	bh=A2yvD6N2Jk/m2YwKMP22cLRunU+AO8Pb+GA7lFeY9Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hU+g39YWzv/kh3Nw8PD4xbJUqd0hBtCsgwa5ur43ivbMv00IKUQBPPRyighrw1UJFInadwZEDcPmt3cxV7/pR7zH+a2YpOMAbBGXyz6nSQJm6nBrl7o0ANXvacrS6ilafMErS3Zy+N+tDy3SlRHjH9g5uDXDTH1RK1x0PAHtw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo8Wgh48; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29568d93e87so9709765ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763053918; x=1763658718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijEU4GEqOKNn00v0sia2ZeusZLe48+/8pscbpafCUPg=;
        b=Bo8Wgh48HJUEYN34hCqCDOMFGcRZQjlxOiNa6uTPnkb+sbFtxEp5nq6rAjv6+k7kqC
         ooZbAN2Vf995whny3mOnJQg8FsUT6j6y4XGDkMFK5O9bb8vpXX4d8QuyP6VcwNYYeCWo
         dXYpgWvgkyBIwyrlasCi1RtJIfoFxh6SaVfO5yZ5tiBMDO/n8VnW1erxF2pmk4WFYe0A
         BDW9ZxGeakowIigYOeAzWez81nm9oLipegmk5qDxnXwQiT+vjS5weZP/mYypWbwHK5bH
         Acqf5xmpjAfb/ZIaNPfeW/lDY2PGDqBn1GA1g4ocVJmrVb14fA9zw1+1Tb0StmRy/rHK
         iOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053918; x=1763658718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijEU4GEqOKNn00v0sia2ZeusZLe48+/8pscbpafCUPg=;
        b=DO0od4+brZ+gooTwyYpJMl6c+gAiAh/svhUhDxfWOnYIjUYHdow91l7NNlF0PkSdSD
         vmHCFyn3m4or+gQGfFuplSObbZeBMxCgR4IFuTGUexk2qhp4xV0HN74DM+Fug1q25ldL
         SYZMbRoZeTaQZtXHClOzBGYesqfPruBIiVFMDkKNhDeGfQWMjjx82y7JqnPFfqRJgLQL
         Nk5P3Gn0hZn4V0pDfXlZL0kAIAcO+2uFqLvsVxNHxG8hDvJtMYlSGC76qtP+hHb9xMt5
         +1GP9CItlBEoyRPcuGljEXr0/Plg70hU0fXn50sgPMesTFNA3Cj4m0PpQTjuPCjFWSPp
         q+dA==
X-Gm-Message-State: AOJu0Ywin+4Fmw7+9PmcB+49B+R+ziy02Ew9BjEYEDGEqt49wBsVWDt8
	3SpuLdUTcf70RebWPSD50tGHWYWvvO2Y+v6N9u6wT1NML13z+jBum2KAc1nt7A==
X-Gm-Gg: ASbGncvJqzSk4slVDZicTHz2Qf9Xsebp0dc++qTax2ky5bw5ZeZkXYVNwDO3vzNy6Pg
	c6V3cYN0I4cmJlkQmmgc87AUf6BrtiofhDwvxmsWFZoKe4UlnPIUHBXyl0+gduqPiypNfODcLp2
	wcqUFlxpeeKrIC4/MMLzOUDc20EnYvXMCRacdAPuXGG+NEn2ew6PHux0xI6LVHL0BlYqw2GW2NJ
	b3gg9H8xfPDnS+m7E+iKJKl1PDpFkiyqt2ZAqAGUlaMqUROUvOksqU/5NaeDALIeqWz1CTC57lm
	4/0E/85okaY1jROv5azCBLX2vWHODYMqeyoaGL0Je9Q6TVD0MKahjVKx+uBdZsb6ptDNEr0qwyK
	WcNtopWW7Qt+JFEw7a6CUrKdphMPoYxmCN3uH2EsEFO+OHbm4V3W0YMGiB6J4g4yRtvubiQmlMT
	25AXpjFRYuTk2QVgp7TuyZLflg8MTcgAseYjmK2eYR
X-Google-Smtp-Source: AGHT+IGrzWdbY4fjX2NHDLznFw/iN7GJVDQ4ZyeesWyKRZbPjKqwssQ4W5YR2leSBB1xfk/bancUDQ==
X-Received: by 2002:a17:902:e801:b0:295:5da6:6011 with SMTP id d9443c01a7336-2984ed79fbemr105158075ad.11.1763053918024;
        Thu, 13 Nov 2025 09:11:58 -0800 (PST)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::5:8872])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c234726sm31647045ad.8.2025.11.13.09.11.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Nov 2025 09:11:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [PATCH v2 bpf-next] selftests/bpf: Fix failure paths in send_signal test
Date: Thu, 13 Nov 2025 09:11:53 -0800
Message-Id: <20251113171153.2583-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
Other error paths have similar issue, so kill the child before waiting on it.

The bug was discovered while compiling all of selftests with -O1 instead of -O2
which caused progs/test_send_signal_kern.c to fail to load.

Fixes: ab8b7f0cb358 ("tools/bpf: Add self tests for bpf_send_signal_thread()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 1702aa592c2c..7ac4d5a488aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -206,6 +206,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 skel_open_load_failure:
 	close(pipe_c2p[0]);
 	close(pipe_p2c[1]);
+	/*
+	 * Child is either about to exit cleanly or stuck in case of errors.
+	 * Nudge it to exit.
+	 */
+	kill(pid, SIGKILL);
 	wait(NULL);
 }
 
-- 
2.47.3


