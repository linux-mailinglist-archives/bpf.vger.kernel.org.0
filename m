Return-Path: <bpf+bounces-52829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C7A48D75
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEBB188738A
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C5BA45;
	Fri, 28 Feb 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="hV57Cfm9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450A9460
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702826; cv=none; b=et4C8QYi70Ri7407N671Xs6jAhGRyVcNn5Q8Ma8iLXCUXT/JHIzCvg2hkutlygMBqJE/VAsMRhpQTj/D0TkmoxsXG/4gfoggqLVUS2FUtuJspPjSMtly8BlbWTDQW8OU0w356TguIT1kWgGFgzIzFb3zrwe966gRCeC3rkvpK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702826; c=relaxed/simple;
	bh=v8UXISOpH4QYYjcEfXhSuMcvwplUFU2z4jz+kxU0W5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMl50e3mVslBI0fxmDd6RvGIs3ak+9oyH0M01V2ZVUjk3DeO5LTiFJKJCmzk6hycd+Bs80g7CQ9oxB580+x8y0XiH7V7cRFpBNKeMu4V6bpom/z3wRpM8k68WXeT+YI2wiwmixrkFVRHw1z8k5WIjEU3X/q5CFtNI7C+dVXkUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=hV57Cfm9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e897847086so10200026d6.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1740702822; x=1741307622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PG99W7/RkwGJQ8fVB6VmmaS/Xph0Sguzb1wRFExTYpw=;
        b=hV57Cfm9sW7l3fAweGfSnoJfy8+ZrKOjNh524TrWduNlX/smJy25VdlsXKo6KMkwtg
         RheR2xgGpLsh2NSSWAadil3IPx/cL4Rj9mirwIqm0FlWQFDVP/rtIl+ZJO6nsNxRC7F0
         9YmWrhDLNTJKIB96Vp/FoU4YtMTGzsDBuU+4MYC4sf8/JCxFNrapRbQfYnaz7fuGuRMD
         EyqU+ybNOug6wWG0bGcbpxjaFOLf2Y4cUKKZ8TyuFR21Ew832WYZoN+hMSW3LrHPOGXo
         n7I9WyyMNHXtkjEg23XIc5Cheyf1kOU8OjJaUGjzOVHv/Tros0sByQh4k//NFvJk01ce
         dJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702822; x=1741307622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PG99W7/RkwGJQ8fVB6VmmaS/Xph0Sguzb1wRFExTYpw=;
        b=DjABQfmNOKqNAtayGMSF1RFvAI5Rnt89tT2rAslEQ+1m+rP0aiqVlTwqBwX9wwX/97
         xHGVat5HHlamF2u+HY5iGXTLPGTMBiyRFuAVA37iQj8451EOWjgtjapZkSdlD13qJ8X1
         67v3iJBlrLv8CrDYjPdgDc02sjJWlCH7mUlOL4RbIIwEpGpob8A5qyxmkpuwPwTgS/a3
         DcJvfrDxMSUxr7+grca+ojafW1TILYI031Bo6TSGGnXtL7QmdMjTOvI94/2b8i8LMV7/
         Pv+KHA+SAW7Xzp1Lgm6ckY4LkOUkZqe9XkEiKPiaSNEzDhnz+MkfI5h/AP+XD0yy8P+x
         26AQ==
X-Gm-Message-State: AOJu0Yxc6mDv5i2eYBTeHOwydFDoQB1yedU01JGBYV7B3RryJxfhkuNQ
	K40TPqlLw3M05mhSruThpnR+LnKw1K95X6jOzwAd4J4JNkzLY/2i+eiAu3WaNpu3L3Iv1Nl0JHs
	9gFNoxQ==
X-Gm-Gg: ASbGncsrbawDqEHzDVlbUyXMn+XNeZBeTnu2oDrJlNkNzLkNVwGsIJXu8mPO4452/5m
	aFOoUkRiRgNPv7ltTmGRHrdwUmYCT5txeY4Vvmzn9m5VsWaWONjzebCnytHPIP+c3orUpcy2yDq
	Gv4+9fet7cpPM40gQ7hc1Pg8Rym+Bw0/j3ir7VRi6AcK6D6nsRX77jea+DD0WtjbaWvfNaAy8AP
	Y4JM/jgEWXiXMsxPecGVrwmI8IN2IUuJSWAJR9Bu17tVQyVNzWuetGGbFsBLDr2Qh/1V55nmrJ6
	cQeVqK4EfB3GFL7mZ8qOSD0=
X-Google-Smtp-Source: AGHT+IHCA3HAZTApkM20IO1GiD9MxIkltE09Qisi2tIcLx/Bn87Ey9Txlxzf0VJEeP8wW9D46XeCkA==
X-Received: by 2002:a05:6214:2aad:b0:6e8:9ac9:55ad with SMTP id 6a1803df08f44-6e8a0d94f85mr26913736d6.37.1740702821960;
        Thu, 27 Feb 2025 16:33:41 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef5beesm174769085a.32.2025.02.27.16.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:33:41 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.de,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/2] bpf: introduce helper for populating bpf_cpumask
Date: Thu, 27 Feb 2025 19:33:19 -0500
Message-ID: <20250228003321.1409285-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_fill selftests

 kernel/bpf/cpumask.c                          | 21 +++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/cpumask_success.c     | 23 ++++++
 .../selftests/bpf/progs/verifier_cpumask.c    | 77 +++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpumask.c

-- 
2.47.1


