Return-Path: <bpf+bounces-34369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D66292CDCB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F47A1C209E7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530717D34F;
	Wed, 10 Jul 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhUdn1nd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A717836C;
	Wed, 10 Jul 2024 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602004; cv=none; b=q+3YKx58EaW3sYs3eWzDXQsFgK/XmkIiPk57iYH5y5cDEq+PA+uza2qUvQ32orePPV1gv8PYuOdToNbN7o+GLCCc1Utw7h44laO7P9dp+HI6xvfBjG364U+KWTj2rkhXH6TD4SCtIOF6FRGlyK5+5uaGv8Y7X1l5zy8ZkTmemHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602004; c=relaxed/simple;
	bh=rI4emRMTI36UV2uznkSdc4z/SSDEK/mpaZIb93O596o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u/ta49vVW341Lh8WhMF9HYaJxrg3kH1kUTf1+2uHYmpJZmzFjonBQ8/oc7DCJtrO5qM7perOpVlpmNwQidHDGBD3x4Fru2Bavh6QyWXlYAjWLAonxfLSxmgJtZdPDRtIsE30WWUMPFL2S5oBjJ7PJBvOM9iavPLaOXDERQrQiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhUdn1nd; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-38b1ce72526so5519455ab.0;
        Wed, 10 Jul 2024 02:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720602001; x=1721206801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxYvFXWDS6rYr4mBF26COM5Q4SvhFcKuutaGTTwwarA=;
        b=QhUdn1nd9NTk3ssLQDBNz5jIkBIADfVNlovg/MCXIC9tPOcsZvZ0/vHssfgKYP4Whg
         Wh4nrLOikiBtmkAYDgJTb9Pixr/i0r2D0+1IaECSUZHjy9n3n8ZfO744UB3Gr1DHqFZm
         H29FHvB5wSPVRlzDomuen6pDyVeXoq3/kI/3MviBX1fnDsFawlAfcDfSBUaQjXjsdmsQ
         EDE7Vd04pZOiMOJ8ln2FrFlm2BDWyYbukvlmLsvkSnMiH1N1mucqgRWNhBMz2Qanwypo
         GwUa+G3uymhXQhX11sVpIkOId4HQdIzv313ObZ4PxYAhKMFXzJi+Vxvx0aB2+kvn1Th3
         2kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602001; x=1721206801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxYvFXWDS6rYr4mBF26COM5Q4SvhFcKuutaGTTwwarA=;
        b=XZqV9Vav6HAlGoBnCRVM5HkwIDT2rvIovlKM97RNBIE/izj0Q7/MXu+xk/8OcXK9wn
         SX55MNgVz5FnMKYs4jwNYFH3i1naxny3UijLvdTlRo8UApnCrOoDEb0nlBkKDhl6m6Im
         azB7zx78RLRYyEegY7pKLOnfnawD3/vKFrEnSC3uTG3/7rKk8f0SC7L5ES1Ri/lRQHpT
         rp++/LHA0g4HsmNPtSSqZwJ9tZda4ZNKlOfUyVU0BHAdD9zQtiLlkKiVKXsHjnE5/jkO
         1T7PtAQB9nTWyLgUO6o4pSkE4L5O3Sq5EZUc5kQuJ4/txmMA5rgdDL7Ho/e7vzaxTPOW
         geuA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/FyV64fnwtebc8Yk9B8f+3FP72Q0XMrzlfu2s7cQXoWxcMQoxsnUbQGPtGzyDgIqhOZn1wB2R0M+6e/J5AE7utA3mSVpw0vCh4jRx3Q3lKQg0nnJVasDJ0PkXL0p/d6cceP0qzA5S1GF3mNe9Ivqe8Vcsa5ZutZIAz/s6s5i+3CsSE7B
X-Gm-Message-State: AOJu0Yzu3XHuw4jP5AJBabnssuduqkpjwASOMqpZFpU474JEyDeFS2tk
	jivU87z8jc/DFUA48oKBwX98gfJ/SEaxf4H2M48GKNCyTBSCeGvhXhEcrxUn
X-Google-Smtp-Source: AGHT+IFyKkjEbWfPpt0EWoNM5+CbHhaTh+m9pQG9L5aZhJOLuywBhuPVhceQAqOKndZHHEJZ/FtPUw==
X-Received: by 2002:a05:6e02:1a49:b0:375:ae17:a2cd with SMTP id e9e14a558f8ab-38a5a35bdcamr52822395ab.27.1720602000758;
        Wed, 10 Jul 2024 02:00:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43969b41sm3235527b3a.138.2024.07.10.01.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:00:00 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next] bpf: kprobe: remove unused declaring of bpf_kprobe_override
Date: Wed, 10 Jul 2024 16:59:39 +0800
Message-Id: <20240710085939.11520-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
pointer with original one"), "bpf_kprobe_override" is not used anywhere
anymore, and we can remove it now.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/trace_events.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9df3e2973626..9435185c10ef 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -880,7 +880,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
-- 
2.39.2


