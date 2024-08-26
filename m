Return-Path: <bpf+bounces-38110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B795FD76
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DB81F2364D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAD019EECA;
	Mon, 26 Aug 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y40wIvzK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA019DF81
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712515; cv=none; b=no7haI0aDo//+Ym5JhboScVs9/LsQVIIAMKsphAdtzfHbGLyAfK2RbpuPbAQsn4+PKJCeTKeHVi2SM6xH80VUE4kYFrTEkklrq7tUZ2GGnQciavmIlPJRTSK1fhOPNROOR2fsG66hYgxtiTdEVfR6h9XJIwq9GtVB0UOFVsOMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712515; c=relaxed/simple;
	bh=rX1t+CDnd92JRFsJRglXPpkgkNJY2l2tkRhLaG1kAqE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MeY7QP/X1LADuoJT9UPSP1RuV6yZckF1oYQBMtm5Xgyy84jJWeMvcVya9JcD+6FFOnDfqxQoEpmFpyoEJ6SCXGwsClsS9HyP3A0s3EBEBV/z975oyvVHuXhUAJZZGZjRkpqtzOCYxGcTbVUAto1wK/GyNkkx/e6RFqAKZ0mZcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y40wIvzK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20219a0fe4dso47347835ad.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724712513; x=1725317313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO+u0u4vu1+eldLD+0KHqqqMPQDOox8bqUkb8+VhpYA=;
        b=Y40wIvzKTGDsJ6bI5d6lSxfI8tLsQjWuKdB4apYyeXu5T8l4jpKHTle3ivom5gusHd
         /hMZbCKwfatE8PLWsi0+HAHvPdBxUoGlev2UwaTVi7NEdQ1xKiP6d31LdeWqrh2y1+gA
         6BK/mw5Uw9M943mWLrqfCxpS3Ttd7XMZ3THFEYY/EbNC6KOs0N/KSwhFmP2pdtysweh4
         MFa3I6CMKRC/iOcyawETyMQN6ub7cAK1SAQK3w0zWxCpoY9skjR80Dd7/p3OKaZHurxu
         y9+mxkNofPaEhlD/2aDsRCoBNfLOayyBI48SPJPev+O6psm/kOzGlffPtxICgq/hDtye
         8IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712513; x=1725317313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO+u0u4vu1+eldLD+0KHqqqMPQDOox8bqUkb8+VhpYA=;
        b=HdnZq3F/4oXKCtWfz7HPa0nhBOpJPmexHAZXYQfzusEdx07NPk8PKEJMhRjIPPmXEL
         3zVdhK+PnbG9j8C7FESJPr/AIROkBx56nQuTZkVOKiJ3xxPqboTRQDfnBmVqap1oenWe
         N85IfAzoI17ssQPlB13dZuM607ys1VLwsz03pEDfHvFO673TURBNLF/9BthwzD36IKht
         H5q7jAqUw1IntsyhveNBjXu0A66u5msyNAwbX2K0wNgdZi9qmUQZPjGpQnf/ryN4yweL
         EJ/ejzq9cueUDEF9mvEL2MVnMbrL8Lp1d8hIjfJkb8j2FL2nY/JvFzKETS6to7dg7Znv
         0wXA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/eCaLrB8wIDbnXEiDOOr0xoFDbg3LP5CWigyFNGRkVToVJenRwX6KOvqmVhN4N3+xjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhx0QohauX4WexpTWD1Ob+c3JlIGOLnNZ9YzrFrsFBLjMSse18
	J3OQF3il4Hzqb3EgHAqmIkL/Mg9wJCUIuRPjRfy1J978zQJzsIKr
X-Google-Smtp-Source: AGHT+IEeUTEcTTGKlPe1LyqSNoQLoi4sq78vVCrHj2bM3r9eg80zlbV/v416Phbad2l5c+5lS3m4Gw==
X-Received: by 2002:a17:902:ecc6:b0:202:671:e5bc with SMTP id d9443c01a7336-2039e4ef402mr127854025ad.42.1724712512964;
        Mon, 26 Aug 2024 15:48:32 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855808a7sm72128895ad.72.2024.08.26.15.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:48:32 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] allow cpumask kfuncs in tracepoint, kprobe, perf event
Date: Mon, 26 Aug 2024 15:48:11 -0700
Message-ID: <20240826224814.289034-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to call a cpumask kfunc within a raw tp_btf program but not
possible within tracepoint, kprobe, or perf event programs. Currently, the
verifier receives -EACCESS from fetch_kfunc_meta() as a result of not
finding any kfunc hook associated with these program types.

This patch series adds new kfunc hooks and maps them to program types
where needed. The additional registration of the three program types
mentioned is done for the cpumask kfuncs allowing them to be called within
these types of programs.

Pre-submission CI run: https://github.com/kernel-patches/bpf/pull/7600

v2:
	- create new kfunc hooks for tracepoint and perf event
	- map tracepoint, and perf event prog types to kfunc hooks
	- register cpumask kfuncs with prog types in focus
	- expand existing verifier tests for cpumask kfuncs
v1:
	- map tracepoint type progs to tracing kfunc hook
	- new selftests for calling cpumask kfuncs in tracepoint prog
---
JP Kobryn (3):
  bpf: new btf kfunc hooks for tracepoint and perf event
  bpf: register additional prog types with cpumask kfuncs
  bpf/selftests: coverage for new program types using cpumask kfuncs

 kernel/bpf/btf.c                              |  6 +++++
 kernel/bpf/cpumask.c                          |  3 +++
 .../bpf/progs/verifier_kfunc_prog_types.c     | 24 +++++++++++++++++++
 3 files changed, 33 insertions(+)

-- 
2.46.0


