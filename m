Return-Path: <bpf+bounces-37045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC79508C1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88051C22172
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F41A08B2;
	Tue, 13 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gGkepzjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03319EEB7
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562270; cv=none; b=Wjp6GWGUCRkXVsiwfgMFi6dVB5ahOp+uPPDyAIWkdBTc9o5lEhau0P9qDZ+pYsZPvGn3JF31dP5pqp1q7mAMIkO9VxNJUQfhDWlzW9zecODm+0t6DJcSEEl+226oiT2y9PBx7fB2d5wabsVqLIxkt4T5I0CjneA9Ta/MurQM2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562270; c=relaxed/simple;
	bh=9Chp8Kdbu6SYoSV/XqRtuBNB0Ulomj1BCqRJZlB19WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raYeI4g0HbVWHGHVV5cGHV98ATZlXOgU0Qj5YK+KSt8ew7C/oKsiJsHljgW5O9mD6ylXgtqz41i2LWJkHJn+DritK4rUvoo3wKrjFMRErmFuc64nOwSxR501xWtFdV5EoatT/VW2HHVrV1ae/1kc5rC7tmyDHrpj4c4Fsls34To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gGkepzjd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d396fde759so634630a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723562268; x=1724167068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=gGkepzjdZ1ZhClkJZH45b5IBGm3WJbOVMk8F3+VHG3eNrsgYgQEK2LN8xqwVnk6Ppn
         srCICIYNNeyjcpVT2gcXQOuJGY+NWQX1QMfgaee0Bzj/C2utB8OO3jc7ZAAUfelV09dT
         xVTbFr7zQ8EMoG1BAWk1fRUitpewQXiKnM1Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562268; x=1724167068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=vsCJV07BJUgY9co9Y20EYAF3hCVfcnxldYv1sInbNc7fC9rRYt028YOkLxBrrNc3Kp
         2+p9qzPpfB7iCpTCNQ5oTSV0lmwNmtQAuiAMvNpBTVfRZRMPl2fKWrHSHIFt1LbEEfy+
         xGj+nUlFfZGUnzZWspDq29bGoz73FsDP/mczdsDI79V7wPB4qF6awANo5DTNItypMYFL
         U9P/DJEzhLTSzoWETIOTxDSm5AfqT8J2+qwUByY/S+Qsr/Ft6QYWz4tf3IYVBCz/XNwg
         UuaszALF0vIFwjjOrcbeDrlSnkIv/+Y8NSBUzFuAoOWKxjedpzCjwGAh6v/L3Sewwwdw
         EEFw==
X-Forwarded-Encrypted: i=1; AJvYcCWHLpVf2dAkOb8xKDPLUM+xGBppF+1UFz1A0hooJ3CFu/paIAC+TsR6xvLVP+BkrEu2WVmQKOf7mKPf5aBK11fZYn05
X-Gm-Message-State: AOJu0YzioKJajgyG61ItLa3Ur+W/NnYL47jUQATJv0vU2EKxcPxLDKVc
	pb+8od8rvqaBc0+hdE8i98YFc0Pv+CQEPPTPJTvrcjqmyCti6zWt6WvG04V5xqY=
X-Google-Smtp-Source: AGHT+IHXm0x6rVFLg4sEMfOVNl/u+rp1s8fKEkxeX/qIQGEqM6BLnURVvMM4eI5C7/juC0jCPJ61ww==
X-Received: by 2002:a17:90a:cf08:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2d3924d8178mr4202148a91.6.1723562268440;
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm7409649a91.6.2024.08.13.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: peterz@infradead.org,
	andrii@kernel.org,
	mhiramat@kernel.org,
	olsajiri@gmail.com,
	me@kylehuey.com,
	Kyle Huey <khuey@kylehuey.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/bpf: Don't call bpf_overflow_handler() for tracing events
Date: Tue, 13 Aug 2024 15:17:27 +0000
Message-Id: <20240813151727.28797-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Huey <me@kylehuey.com>

The regressing commit is new in 6.10. It assumed that anytime event->prog
is set bpf_overflow_handler() should be invoked to execute the attached bpf
program. This assumption is false for tracing events, and as a result the
regressing commit broke bpftrace by invoking the bpf handler with garbage
inputs on overflow.

Prior to the regression the overflow handlers formed a chain (of length 0,
1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
(the tracing case) did not. Both set event->prog. The chain of overflow
handlers was replaced by a single overflow handler slot and a fixed call to
bpf_overflow_handler() when appropriate. This modifies the condition there
to check event->prog->type == BPF_PROG_TYPE_PERF_EVENT, restoring the
previous behavior and fixing bpftrace.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reported-by: Joe Damato <jdamato@fastly.com>
Closes: https://lore.kernel.org/lkml/ZpFfocvyF3KHaSzF@LQ3V64L9R2/
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Cc: stable@vger.kernel.org
Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
---
v2:
  - Update patch based on Andrii's suggestion
  - Update commit message

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..c973e3c11e03 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9706,7 +9706,8 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
-- 
2.25.1


