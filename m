Return-Path: <bpf+bounces-32834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A991386E
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 09:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566B71F23457
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E33374D3;
	Sun, 23 Jun 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y2dBhkS6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB054D10A
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126217; cv=none; b=Y6RVRrWEjD6RfRTFOidjkZIzhFoa41/V69xrLCLmThL/MmzjoOtKame2MmTBOIZS8mFSSufGaAg0Ju9pckhy2pyrvfCnhRT/BVz+4lBFbC9b4BzurHb0IPfiU5tLmskKX8LWcNBTxwtrDUXy/PXab/1pcVh/fY7Izs339HVCCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126217; c=relaxed/simple;
	bh=Cv5eLqelbyK/A/JKi3jF5xqN51OCej0n9R4bVySD04s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFQZCJVaxgm/887e7Pg/+nG7eLUmW8qTwyAk4BR9kbvb0yzNWDPYR8vXSXp3WMnd5QuZQi4pTaVjFUOsim3IGlROHzAG+6yAoRPqeZU/mujWqBzhkBwsbQP2Y7FLCXcGCf3WpYeNfBMNMHETU/rDayRWjrCPr7l2ttz/Uu5l6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y2dBhkS6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so36914641fa.3
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719126212; x=1719731012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEjSruDdYDYOYOhleEpOzfV0EaYG9YBIqRmdrx9QJrQ=;
        b=Y2dBhkS6JmfFyxOGEV+k2d1X+NrSDp8Og2ZJ5YlfHI8kAPWO0k0dLaSwPWbcgrROjr
         q+6JAYc0xXqE74MEswEqubXQl42F7hsYRcgJUeEwQ1+PCfDsdW5lHCPgdtaQB9XWlTxB
         tBFd90w25HRS6y6T8PJ9bgBxrjuHy+VAvWIEiIn6LSmUVKimG+X1NXyEkN2oizvKM3El
         JvkIS37FH526J4EbUVibqHWsa3y1B9OjfaWc3IfBos+0qKWca1JjB0Fm5NvZ9E20k5/O
         OYpvBIKyPh1Y3I0Cm10sswCr0Hk7eD07NEywwBqsSuYsomYDAOEqh8C/wXWviAY3beFk
         CoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126212; x=1719731012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEjSruDdYDYOYOhleEpOzfV0EaYG9YBIqRmdrx9QJrQ=;
        b=QWcAAAm7MlBv+yfRBXz9zAbbu6kZL0Hf04bIxy53p1RFm38POl6RmxBH2/m/yQXv14
         bmG3dE0cmMwykKVPqiAcZPk5UCwu7WD8mLambFOMyfJudqTqeeLerCiK3zhJsGSMSiaC
         nF0Gi33VRHJ3nQIbuB8F6LEAUPifhvvbnrj/LESNvBsyCdI129o8xy8vPEBsdGzEQO69
         W3GjWki8Gftd1ekOK8ELt9jTZaNyvGUfmxrBSjYWOcZ0n9YjrgtkuuPEY1RR+Xj3gGlA
         7U83P4nmUY3XNPsWxusAUu0oWNcA0i+DKtX2ubv6qdv//pn+dap9Ct36FfSxXUa+krEG
         CwUA==
X-Gm-Message-State: AOJu0YwRh9JSgnto1X0PyrgY6iA1rBvJK4T6dNzqbxIFigH0ukcoI4l7
	17akzfnet/GQbuVnxiwbM1mcgRD99l7NX8nlHCPZP6hA42o1QK80BJZLwA85GPQ1/bLIoAMsdoc
	O
X-Google-Smtp-Source: AGHT+IFmwlTqEJMbzgXNk3v/GB58zcTTgs3NUmsqVgznq55KC1ifi1ApTZML2YEyCmCoABSKfWw1AA==
X-Received: by 2002:a2e:95c8:0:b0:2ec:4d48:75ec with SMTP id 38308e7fff4ca-2ec5b3394d2mr9523681fa.22.1719126212208;
        Sun, 23 Jun 2024 00:03:32 -0700 (PDT)
Received: from localhost ([2401:e180:8842:4fc6:d5d2:edb0:d14c:4782])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a62398sm4375116a91.12.2024.06.23.00.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:03:31 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 0/2] Use overflow.h helpers to check for overflows
Date: Sun, 23 Jun 2024 15:03:18 +0800
Message-ID: <20240623070324.12634-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set refactors kernel/bpf/verifier.c to use type-agnostic,
generic overflow-check helpers defined in include/linux/overflow.h to
check for addition and subtraction overflow, and drop the
signed_*_overflows() helpers we currently have in kernel/bpf/verifier.c.
There should be no functional change in how the verifier works.

The main motivation is to make future refactoring[1] easier.

While check_mul_overflow() also exists and could potentially replace what
we have in scalar*_min_max_mul(), it does not help with refactoring and
would either change how the verifier works (e.g. lifting restriction on
umax<=U32_MAX and u32_max<=U16_MAX) or make the code slightly harder to
read, so it is left for future endeavour.

1: https://github.com/kernel-patches/bpf/pull/7205/commits

Shung-Hsi Yu (2):
  bpf: use check_add_overflow() to check for addition overflows
  bpf: use check_sub_overflow() to check for subtraction overflows

 kernel/bpf/verifier.c | 120 ++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 76 deletions(-)

-- 
2.45.2


