Return-Path: <bpf+bounces-79030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A86D242EB
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 111B43040AAA
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C54379989;
	Thu, 15 Jan 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQqSOEUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B50378D97
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476296; cv=none; b=KRguCI3iqw2cujiE2RqulENOz2cECVRnBsO7TffruMutvZwRmMMOtsbu2JVPVN+6+2tURHPPdD7+J38w8tyAjuzPxfyrePJtpY8KQdWx3yCRBvhr2aQon0V4dcSHmMdIftlhOfdIMGLmW5E96mKWI8XMcn65E0SAeCIWdFThgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476296; c=relaxed/simple;
	bh=cL25nkDUzKZag4J9iucviG36ODRXZz/OJhTfJnS3kJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Swca1qyAMDYqA9uvwnIyZUKMRC1fyDGTUv6j3xTnuqOxFM7Hp/gHXCqc3BEj19B3dZ6ZHaY17ppkniwt13S9B1IN05yuuIVNWG2kiTr4m9aeEbAPN4X4hKjrTzN7I2kz35W3f2LcbPIoU40GVwLExCg1fF2YtWeunjwH3Can4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQqSOEUo; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0f3f74587so5569715ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476294; x=1769081094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYfLimlEod4L01lx+XYB7h0VUHpcPwya1tLXiZjahd0=;
        b=nQqSOEUo0UOxJiaWM/FLncotJa7v4vghPCNnDfKBxm7lEHJ5TSn+lziDLPsQWBuW8k
         pDY1h2XMHr6k5ozA1ICuc8bMARufuOP00v0jAZnenwlkXkfxpcIMezmvh2RPFH3BGzg2
         FmfhmxvjJeU9idfz0QIcmz/Gn61sKKBQWq5Xpk/mb1Zd6DN4/l5qFtw7Udi4YMVJBN6R
         9E92O3G+9+3puzzt1Y/PTh/GK07INuJ5K+BzhIqKK377Hq6WjWAHY6+LU0egOuwu3kfP
         bIC8L7eMAYxNJUvSIPmv7fi9XEJSt3Jh6SsqBG6BQSeG8Qa/lBkH+7ydWPUsIYNo+jWb
         mqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476295; x=1769081095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XYfLimlEod4L01lx+XYB7h0VUHpcPwya1tLXiZjahd0=;
        b=MFC3+YhA7a/wETJI++dN5pcqlEYiCCGXpvZAoW0gkSB52OIsBXOZtBTWuo442oyypy
         qLVZfj/y5px1FPYebuA7AbMbUXYvYl1wmBwpXOLyKjYKC6gMZDbqPrmkgggJhd0AxfeA
         dnYpFsOLHRCE1byht3IhfBdwR3iYf95UVJpmus0R7kYL+KObnMW+Cl0Pa+ra+etw6Gnj
         aVk/gVu7iI6SUK1bWdTDt+Ug14rO9VWAWN/hQ37PJOSC44SbcFBAO1pBj2LCMAjR6LZY
         S+BJ3Fa3W5rW6qZaXqytA5bNf5hTKcSnBPxhAgJCl71gHqMqWJSCDofrcEkF8zEER0yV
         inAw==
X-Forwarded-Encrypted: i=1; AJvYcCUkToYJTaDHVq5TaBS/dzJU41yIwJby0WDQbwIpYfep/2L3lh1d2Qq0gCQiHXw7I4o8R1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuD8VPfbizxAeuHhitXOVQ2UTMo7FTyAzFWJhE4J2ZLzwbzZl
	ug8NS8Qd/mBvyzbBYyFtwPJFlv54KR8j1Eeoznz6Db9KoCYx7uqI3wL0
X-Gm-Gg: AY/fxX75NK/Xb/ccYvpbehb7W6CZyQMqIodAnBoGPISIHK3AGJ+Wl0RPt0iXAZg5eLB
	3GzgAT55bi1+htBVA98Z3/Q7PeodV7HWFkS5qHSGPAoGPF5Tr4ljPQm74/sEZ5qhP1YQxcb2ueC
	ao+TbOFtPssYlJcvn3keB0we99dKL3UBzHI9vAnJ46mJfmBtB6i18iNiAqvItYEWvAifE3oNOxb
	uDppCnxlYYV4VSY3u/PDPs1szFOtAKV/T9e3ADLx05HMpo9yl93e02tqgLtW08RRtNGDcCnnpL6
	7gaE+vkSxcd0T/H0FfUnajnr2TYwgc1G5QDa1Avtm6OLfN20MuEnf6le9h23UW4mCCdfymnyIiv
	mleakyqEvJE4RcNKePj+Flr3FfWBt4HWYPeI/4Odu0JKhVhsPcx97yz+NwZnG4m65u13LNs4Mx6
	NdBvBQX8E=
X-Received: by 2002:a17:903:2a90:b0:2a0:9970:13fd with SMTP id d9443c01a7336-2a599e493b5mr54268265ad.43.1768476294546;
        Thu, 15 Jan 2026 03:24:54 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:54 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 12/12] selftests/bpf: test fsession mixed with fentry and fexit
Date: Thu, 15 Jan 2026 19:22:46 +0800
Message-ID: <20260115112246.221082-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 4e55ca67db46..7f640ddc8905 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -161,3 +161,19 @@ int BPF_PROG(test9, int a, int ret)
 	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
 	return 0;
 }
+
+__u64 test10_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	test10_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test11, int a)
+{
+	test11_result = a == 1;
+	return 0;
+}
-- 
2.52.0


