Return-Path: <bpf+bounces-78933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD4D20318
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CDAC30EDFF4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFA3A35C9;
	Wed, 14 Jan 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbbSPpIE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6663A35A8
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407483; cv=none; b=XncOOET8IqEGHbK4AXelRLdj2YFJh6yn0gwCSPZg4+iYVqnIq5KjMURVr9xa3wGI4/ArP2hs69O++gGvYivFXUCiXF+oFwJIkCHkt6gWHVxjpxn5NPVOB/amicyJca0VmIWDFgU3VOC08Y9I75mPix1+44Yj+e1+nEMBzjuJI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407483; c=relaxed/simple;
	bh=iHj+uGw2OqqWF6pCKT43SSZ/SlLsMq0AvvCK6hWuWIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnGjgceIcZDPUUzKblsZcB9C+vYNplwLEocoKPnNXPkg58sYwWSZJyTelAyc86yt6PAFgU0R37Il6rbFGkdiGQnzGDOj2gx75r40L0x/rEmITyXiCBDI8siN7lj8trsM+NekV29BC/JB5CBURIKn3I3gw6beXz7v9CSkGKNEh2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbbSPpIE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8718187eb6so541366b.2
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768407480; x=1769012280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d08heOFOUzNeQjBF+Gvdp+IUmUWcWmX6OFjAO8r15qU=;
        b=hbbSPpIEQPTwxz9kJwcPn0UN4Joa5IzEwzR1x/S0yMITHDvWbuNmDpqOAWXOmTROr3
         FyBAFNBfdyCuypiawoE18akFyWtJEz5l5xg94srPf3s2MHZ9TFk0W8NhWTLUl29HUZus
         Ce7thN+Cn/pryVUDSFrlef1FK9ucB3W9QrQhI7dod9EsxmUpbMZLROciY5l3PWBShone
         BHYI1OFZSy0wilGpIuHI4bavhAU/OdjJfKOUoPbUdQwu7qlndw1nLhXErM4KKNgt0K6H
         +IgnV6d7PqijLiwhoGHIWry3ssQ2sQyNtzr1Rt6nXzG+KUhmfuIUzVzwyW76v/hSAlDt
         yNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768407480; x=1769012280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d08heOFOUzNeQjBF+Gvdp+IUmUWcWmX6OFjAO8r15qU=;
        b=fD9kxmwtNM2xc5hPtACytaRW+128/u2zGPj1uNSkFckrCPpMovRuLtXnUALEegFa2L
         ZLRkxZKBInJu28JKro2TuP2Dd+UlknFoCAxbpODeZ0cjVf1O/ytXaCAMH+2CY2w3HOaf
         NOpdQ7iLtG+cvLOuFLnOGARVb0Gn83RoU+vMkvv0dH+60i643KveDMrFal+vb9pAeXke
         VLphY1X8AzBanW4KOCLKvwIysG1GIDJ6Yhlz648ytFEf1M6ILiQ1/cDt64hzuIypsYRg
         YK8egRxPcjIT1O9cueY1CV6YqR/8SooQNvgJDP5mHT6+k362fA88a0VuNoYlbbjvG+Pk
         Ch5w==
X-Gm-Message-State: AOJu0Yym6p8dpi9Az7sd3sLJGLHXRXJ0oyy3zHk6Hp4asWh47gCmRDbj
	2jA9jI9hBObbm9XGCzP+/xaghUeGS6Y3VO1fi/ly1KU+D9WTkf0L6EmBqfr0Iw==
X-Gm-Gg: AY/fxX7WBveusdPKfcthACFPlEh0RxMLefAOLbTcX1KtdMtW8ZK4iC4TX9f5l5/LsbJ
	L4ksxDEoL7U7QOMqrj+BMTA6rb9DptLCDLbXSv8AFB6KxCGqyfCEc7k/5rmGF1knGy53F3QUjVU
	dE5xZlmV64QGW+zGWL39OZru0vbNS2ryOB86hpJqpplI4vqjk/2VutB6NhVduKz8dNUXExO37Xs
	IWvDw3B0n6RKXXQvXpZsx4Nu0hJI5UeZ7HlpfaY0hERc6ho5m8rOfdauvXBHkp4Cpv2EZ5jLJCm
	VvygLqCi4ASfbHmMhpERZc79BCnudt0iLOaGOpEqMnVQZnpqDxaTy85/QpKb4deORSNdaFylhcB
	1ooMSphMbUMryJNlDUutvBWXlyccVMoGutGPjg2bl/eAAREqk7xCOErgr5CzC/bgyQnTzFIIEvd
	X5evBBny9B38j83BAcvZkhel/24FkECA==
X-Received: by 2002:a17:907:25cb:b0:b87:1a26:3672 with SMTP id a640c23a62f3a-b87613e012amr307458666b.57.1768407480091;
        Wed, 14 Jan 2026 08:18:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8713416418sm1055553866b.49.2026.01.14.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:17:59 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] bpf: Live registers computation with gotox
Date: Wed, 14 Jan 2026 16:25:42 +0000
Message-Id: <20260114162544.83253-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While adding a selftest for live registers computation with gotox,
I've noticed that the code is actually incomplete. Namely, the
destination register rX in `gotox rX` wasn't actually considered
as used. Fix this and add a selftest.

v1 -> v2:
  * only enable the new selftest on x86 and arm64

v1: https://lore.kernel.org/bpf/20260114113314.32649-1-a.s.protopopov@gmail.com/T/#t

Anton Protopopov (2):
  bpf: Properly mark live registers for indirect jumps
  selftests/bpf: Extend live regs tests with a test for gotox

 kernel/bpf/verifier.c                         |  6 +++
 .../bpf/progs/compute_live_registers.c        | 41 +++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.34.1


