Return-Path: <bpf+bounces-29410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF588C1BB4
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1011C233DF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417A4E1D1;
	Fri, 10 May 2024 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BymfKGwF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD554E1CF
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300691; cv=none; b=YiQ0HIzHPxD4t7mFCP37MqfziUiu3e21GfH+IENu7jTKsEv3CDyhjwyYQrd2r9v3RN8urBYKPCHtO/Yb3ICfroRGlM0uRByIywYS8/+OkgDSnKwWXGzaD1KSyeZeUzKMVTwl9Sxeap7UkL+fYQfD+cl5XFqoTAddjyd71DtUs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300691; c=relaxed/simple;
	bh=xySRyI8fWJdGd1hvqSCkes+7dSi689oW4NVcWrWQsMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=An6fgl0bINk7DXDiNYEaFj/Z2p26P2NtWj8Fjfb+i8A8pds1wu3K4s+B67CtlUGJ3Kyohaqtb3qxiRqHLdgouNDiALXRpUKWaDk+az/90va0t5wmAVXCnyFldXlbDgYVQPARrVAtDgnS5c+U0oHYTi19wdycg3DGVKcvuLcbsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BymfKGwF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6207c483342so24678527b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715300689; x=1715905489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=BymfKGwFbC1BrDHa5dWfHA2ArKzw2sM9A/hITwqL6MGAExRIVzDFf8BWWw08pSCDUO
         RvZJ6Fz+1DLNKaV/pusm+iqoCfqzlTnhJd8vRIqdxuuFCjizQsz8Sfis3PIqiSzByBEn
         7L26JpIBYiv0oWBsAQJG6Fw5rA6/gi3kx1pnPS0WSXXld1yQU565C8NfZnrsPZGUmjYt
         VcjKcIdEpx8BgXl3W5V/8atC97MSctnsTHVwngTf8vlLbKcXfAlixwPrHGQR1IwWw1WK
         rmf7sBdtLGJ/6JMWqmmqF1bR5cNhtTMs9hpG85fjlfattOpuLjl6AU46qQxnP3eR+joK
         Ea7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300689; x=1715905489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9grz5MJy3ZdpaUQrWKUMUhoIXt+TwKDu1fmP3H2Mh8=;
        b=sNiyFfNbOzEVkgRpXgXEBTb8u0mVeoJD0rpOLy/zAr0lf4azNQrL8CmshFN/ZXZ5Nz
         O5MUjRXm3cBsv/+84GM4kwYkUNdZC+6kIIR/KOkWotxC3XUn1+BNxqLKxgucBZJuhBwj
         aynJnivRRA6yqkrfx6V9UlJqKP/mClJifmCEiotH47p61E5cpGusyWUJx+lCQR8dw7ef
         GQRH8I24VS9egpYfYQOyKZ/hbpxEQ3zNagQ3IcSaNTShcV1qxaRHm5pmNPPxo36S6llN
         FcmAWIfKHm+ckZyC1Vs2FEgd0N/MrkV4rkRshmMDFST+i3QMIwu/+GqNN/h9uC8Xw2JI
         WKdw==
X-Forwarded-Encrypted: i=1; AJvYcCVNx4O/DFfX37JMWH7ISGeY/8DMzWbYo9grCcNhbaiFyEx7ASmyWW3C++ZHvEPrLdpLvisPZOm/MD3SnfgGWzEKCUdR
X-Gm-Message-State: AOJu0YzY11WHCgBNbg53awcj8j6eQKw9ahY1j41AHO/BIPYSIPJzE33N
	YfSdf+joB97y1wORDreh4ZjsLtiKDB52wHq1epil7SllrnEeatrCJXjGatzX6IUFfEiCgfRQH9B
	R
X-Google-Smtp-Source: AGHT+IGCjAYEdtX2PjUjsteAeEyyldAln9sCGY44jxFAaAfnM+VcjksYoiNVv9hJlyfSG58JppgPM7UVvv0=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:6902:a8b:b0:dc7:7ce9:fb4d with SMTP id
 3f1490d57ef6-dee4f322140mr265064276.12.1715300688967; Thu, 09 May 2024
 17:24:48 -0700 (PDT)
Date: Thu,  9 May 2024 17:24:23 -0700
In-Reply-To: <20240510002424.1277314-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510002424.1277314-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510002424.1277314-3-yabinc@google.com>
Subject: [PATCH v3 2/3] perf: core: Check sample_type in perf_sample_save_callchain
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_callchain() to prevent
saving callchain data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/ibs.c  | 3 +--
 arch/x86/events/intel/ds.c | 6 ++----
 include/linux/perf_event.h | 3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c3a2f6f57770..f02939655b2a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1129,8 +1129,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	 * recorded as part of interrupt regs. Thus we need to use rip from
 	 * interrupt regs while unwinding call stack.
 	 */
-	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(&data, event, iregs);
+	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
 out:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfed8417..c2b5585aa6d1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1655,8 +1655,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
@@ -1823,8 +1822,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	 * previous PMI context or an (I)RET happened between the record and
 	 * PMI.
 	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	perf_sample_save_callchain(data, event, iregs);
 
 	*regs = *iregs;
 	/* The ip in basic is EventingIP */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9fc55193ff99..8617815456b0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1232,6 +1232,9 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
+		return;
+
 	data->callchain = perf_callchain(event, regs);
 	size += data->callchain->nr;
 
-- 
2.45.0.118.g7fe29c98d7-goog


