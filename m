Return-Path: <bpf+bounces-65728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C86EB27962
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4D01CE4A65
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00E2D0C93;
	Fri, 15 Aug 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeyLRzlH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C42D0C70;
	Fri, 15 Aug 2025 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240453; cv=none; b=aKRFmvBlkbL/Qa8TSiX/ie9i7+Xou38PmJIZS/RGQRDzS7X4ky8jw3YZX6uui5k0FmyFQHEEAJgJrySNZX2W6bseNdlIjuvKLzJWeKwCEZA1iU1NSzmO2bQ28g8S9kgpHwy3G9JS5ICLQe2ecKRuMybaN2/x3Am1C4M3KR772R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240453; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR3Q1C274PAGDvcQQvLdVVx8ONEndwm5MzLEW/VKbQ7MoYoYFewpKbBOmONrtt7ahLo7er6XkSlMqfbXjSjFPYMWZjGlsdA1pqtoz1BiCIAFbfdTbeDad33U5GgHpi6v0QreQgrOV6oF7G+ldLTXwk1JmuY/wa5/fItZebgg4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeyLRzlH; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b4716f92a0aso1124757a12.0;
        Thu, 14 Aug 2025 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240451; x=1755845251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=GeyLRzlHmXyJFYAjjz5pjNjZgNECS1BUYyIoUH2XvG7YUWWXU5tGM75l2Tsx2xR3Y9
         cR70ON0AP1HczkR31oqMWSMul2k+/qg7y6FzibY5UGbVRXCR5qz6gfUbi9Zf/GkLsgIr
         M/kWFbFObu0EAkB+bUZk9lrS5UysMM0KW+69pAg+91cC9vHVw4LEW/z9F1/jV2CvFWq2
         Lg64zAV3lglttEDMw2bpBBF1xSBAYT88Z+S/wixhYaNf5SxwE0TjEqTmIHq1uso5d1rf
         UlTnWjAurjrFyy3UJ7xnFhqSb1dtM+TVPbMKE05njXLaD9S42ILM6rLSq3twzSgusS1P
         dqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240451; x=1755845251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=eYHCanO+ID/RCqK2gfwGOvI0r2FpaM5LfPjI164p/YjPRGYziLS9pdiUJTUtlb549L
         6UO1bECGPFakIJo5HngMBGSx4c7mlhJUsIDf7zazBd2/dKxQ989F6TBFnFz1bzmaWBf0
         9cy7rnkR31HgpN9wOs/Kd7+c/loH4DICosStGr1IiwHhjpMWCPf6z4mhwddTX1TYm73v
         p9Pn9HIvOi62N0d7vuytRavnocnlpiELyedfogGHbIkMwtgoEBkLteMaaoPPwmtDrNd1
         MsJ/+bpPr3EEG8rzMpwsxikgpQMssPkqufwpHsB35YHPB6wqHfg8AlImkaG0to3YKZs0
         hgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdFvOsTs8At5aI5Ll5VcJxY6ffSTBuVP65BVE0g4LZcdDXLSLWc3DjhJ+hcJa/ehVOACUQHzpIBtSaDW5@vger.kernel.org, AJvYcCVgd1UKekr0NQ4VLQgKEp5HpGJgA08ZUgVqqjjplxFlo8c2nxM9a3tOvyt3N0YKElro+a4=@vger.kernel.org, AJvYcCXNR5SQCxpXzxLiO9HcUJiHdsCD2rgVb79ZFus3U75pi1SkV9m+5VymVdo8+kEBEdMqPb/nnY/3hEbH6NT/kMcaIywK@vger.kernel.org
X-Gm-Message-State: AOJu0YxhB9SZlJYsIjX3iFVWWLZL46GfZDL3lE5wGxjkip84dMpe0EXS
	2zH1Vv1XkZWVUC0YuV3P08Yui386DSOpYVFWShQXZ62yATJCZhWdhaYU
X-Gm-Gg: ASbGnct0QrQz0GWJXofirwEFVhPrR4KtrxkmtN4DMhj2Innia1x/DebPH19wOCH60Vz
	8lPOY/bTT5t4DGI/4k2h2nvTKf6SLyTOHRSBtZn9bsXkvUVZm4QGsOxSyFAF/qFfkpnF/8zo0DP
	tZy18EPR1Q6O8YaWWWs6cSpd8NC+rCmQCL2vdwXAxusSqDKPJZXW9AYjqEAS1a3w4NCd/cRTlCW
	/Abeji8CcUrySlReTRviQQi5MlWGRNd+uOKzSwaKPaD8Af/5+K4i5TSCa17/KqCTGcyd8sJzpHe
	ylbJETknj8Jlqpkt1bDH7rbjWNFxpLbfhR2qbPJ5mRc+9Y2vy6fLsUioL+FZ2LcvP9uaVLLa7hN
	s+dLtMFIwNPI97uobNh0=
X-Google-Smtp-Source: AGHT+IFAyNLSVXS6d3exkk6mi7mr/5YG0du4DL/Gkc9c4bnLuRQBKOR+eJMRYMJroan5QUUTtsK9rA==
X-Received: by 2002:a17:903:228a:b0:242:ff89:d724 with SMTP id d9443c01a7336-2446d9053f8mr16908975ad.47.1755240451083;
        Thu, 14 Aug 2025 23:47:31 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d539032sm7161665ad.109.2025.08.14.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:47:30 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: skip recursive functions for kprobe_multi
Date: Fri, 15 Aug 2025 14:47:09 +0800
Message-ID: <20250815064712.771089-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815064712.771089-1-dongml2@chinatelecom.cn>
References: <20250815064712.771089-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9da9da51b132 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,22 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


