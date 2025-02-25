Return-Path: <bpf+bounces-52470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13450A431ED
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B353B1924
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032F2571AE;
	Tue, 25 Feb 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq+kEDFm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AA23AD
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443942; cv=none; b=RNTy02MNmBG73qIjd9ayTlY1qqrf2YKsPGAYD3cVZ34jXIPVEplWRgMLin44eQ0qgR7SEsufpFt2xLxq+NqNi0XcK5tfMIqX6U3iaj1Lyfk2gw/FjHWe43joPVK3crl/nV0zBO+INwHeZW1ddgGY30wTuay9Ihr9d+IJ1Ddd5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443942; c=relaxed/simple;
	bh=LO1TeCKl7P0QVfwNRPlqP87j+EBZKjaw+fTLe45kVic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXnowvsWKvyqFSWUpR9pBcjyCUCoFvAEMgSE6EXeo8wwtDER1VAiMLf1F1qk9Sk9bWxLkqyuxqHFDfFMWSsWe3cwH+YLmmjz+rerroqEtG+fzYt2Ajr8G5w43JZ8J1isnI/ZpKVru3pMefeKnrjmtZWsmdpejsaSWkEgShwLACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq+kEDFm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso85696325ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740443940; x=1741048740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RIsgIlZ1ZLbXsvqQx6woCPvjywNjcDN1nfG2SzFGwE=;
        b=nq+kEDFmnheOLQJkVOKOqfZ+fIwHiE7h4SIIJWTWoFyePqWutHaDALuW/ZHa0MEzsu
         ASlYhFt40Yjlis7qcwPnRFUb0+RkZ0PbO6VpYykq0IzatwY/h5QDtkw+lQNB8curd5gc
         Q/EZouWetOu9/EtZgEfIklpoHi/70t3WrFW3wEj+RUie2DxLBfqvexuC/J0nQlPvaCFU
         GvdyNxJsRumeB6eQLaCpMRIlQ+YWoT5mMPfoTFg7TJWkJE6RjFH7Ooxpg1CfDyniOkAW
         kBKk/3VZBrCxcm2YN35GbMSaNp1dLzqv37trpYEf57JvVItJ32E6CoMbFpF9nxVrnIMx
         N24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443940; x=1741048740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RIsgIlZ1ZLbXsvqQx6woCPvjywNjcDN1nfG2SzFGwE=;
        b=B13V5L8j1zztyjUqLxqmeOoYHnTOnpYTjco9qvt4rfo/niyrO+O7ZvRs+sTxqUPF7s
         XWhvgLlDo4LP05wJICm8dzi+lBP4ANk+DcZ1J4SXNGW/DKIbg2E9O9MYf9Y/WKIYAN0Z
         HtyMMVT/YM4bi9GmYoomtvLRCzWwKS+PIqAmLU7XtKXs2mjzy8J4i/c3N2W8f7tZB69o
         hGuKgj8hoXERafGVezVlTEYLnCjaqLEGGScde/h/6yDlIaFR1MdoEm+4MywG8SmItZQH
         NqCYyOBNcvFQgwzspteB8KtxY5Zl5mTwC05YcM4oH2hcEUe6WslU4MfcNN4ifWdq3lgN
         F1qg==
X-Gm-Message-State: AOJu0YykkMWWfaaSPuB9PU1EZ2VBlGCvTTu/c8dXj0uDox1GsTZMqGhH
	aE1WjEZGh9JIe3G0OqGT6L8UMAcSoE4vl8tYmSNdSH8GD2X+dXJEoEZfzQ==
X-Gm-Gg: ASbGncsZja9zEjZTnM9qpEF9V0u5ArVssRIS7cy6CsxUmqhXk0W7v33nXyAfD9ipV4S
	99fXCPWxRVHV9XqSIIinldUrgABghHvHSo4JSZw9yWnLnxWf6iLX8JnEEZpH4eI1OfxnLdaYKdV
	WlH+xbNnqB23Hp5hChiZ9KPPZWLHlTXuM3YSYaTnePZOZWzdJJabsLzvuxnixj8ay5JJDgEODgo
	XnlmQjTL7r7+hCJKpw6q/WgPeqla8bxmPyJG4li0dEi0LywmMAHhFTXamnWrkAdqY/mQ1Wkj4eL
	bDFIU+nKdwEDre1LElc1zA==
X-Google-Smtp-Source: AGHT+IH6dx36ooqV2NGu0S8faZwA04falmrxn7IEyuRGQEwwiIIc55Ob/6HsTRARhmyZjBajvtJC0Q==
X-Received: by 2002:a17:903:2446:b0:215:58be:334e with SMTP id d9443c01a7336-2219ff89cafmr236325495ad.10.1740443940433;
        Mon, 24 Feb 2025 16:39:00 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fc47sm2180975ad.93.2025.02.24.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:39:00 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v1] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Mon, 24 Feb 2025 16:38:38 -0800
Message-ID: <20250225003838.135319-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to warning abort verification with -EFAULT.
If env->cur_state->loop_entry != NULL something is irrecoverably
buggy.

Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry' field")
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c9b7464ec2c..942c0d2df258 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19340,8 +19340,10 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry))
-						env->cur_state->loop_entry = NULL;
+					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
+						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+						return -EFAULT;
+					}
 					do_print_state = true;
 					continue;
 				}
-- 
2.48.1


