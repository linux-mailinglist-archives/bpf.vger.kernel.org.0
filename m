Return-Path: <bpf+bounces-69854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DDBA4B07
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE91320970
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC63002AF;
	Fri, 26 Sep 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKuOSBgz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B02FFF9A
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904906; cv=none; b=D2JmcHl2Sn6uatG2SiYigQgGZNHLy9rz5/ZVzOx6X9DiUGkYDx3597PPwysKIwr4sSQpewAq/iYQULZTGW0zjac3bqI1PZ1oMDezgOWiXJSsIE8cXD5c7vQY3K7RuW/IHRGbbmdo1ZBlSD7JzURTHD1tjdZYEuirlVm6e8aSGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904906; c=relaxed/simple;
	bh=qyqX7t2D2AFwHTZ3eL7TWaKzkEfQ2PGisj1lvLkzWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nen/OZBIO3UJgq4x/k7Yv0Kgvt/POMLBKMOk4NMieqIyjGhE34hKw2gyaqQUV6vUTiqLEbApfY3AXSO6wzddP/atbtdjGNXnhViCmgj62JDTvDhvJ91ftpo3t6UdPnQAM5QB6pQQb3alJkVO3HM9dGpDy6YuOk4fYcLELedYSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKuOSBgz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78115430134so856909b3a.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904904; x=1759509704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNJOhq8VwuyFG50xZ7ZJPwq5CFAtDgJOVKFow8+S4rY=;
        b=fKuOSBgz42HeS5XEb3UdhDyMtDBqkKeiwrYp17fjpAVb36vVr3NZuwLdZWTceI/T6W
         KdQ7zIcdZxYgEe01gzLFjZwaxkZNifWo0Q3tWN/2Ec/B961PUJDm4IUEo2faDq12XmKN
         MWaN/wK0clrcpJghUvu7lq6tH0stpdj3UfnjZYlII8Pe/EbQoKqueaatNpcgLVhwz1zU
         qXTZmwJYreIUT9+iHKtULxL334/6FCvi6EGyYrWY38VQav+Nv0qQ71FZ+9TcUAAQoheP
         MXHH5nqtVHzhWx1QQXIxS4xeal1lbXNgrU0F96/M3H/8iz5Nf7HUAgjSPhX/n7WDaJBA
         dw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904904; x=1759509704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNJOhq8VwuyFG50xZ7ZJPwq5CFAtDgJOVKFow8+S4rY=;
        b=VGTB+OE0ciMLfte3KQsdDvZUyLy6p0/p7vCxc5ApqpmHiPCC88Vz2WuOZo1V286NWY
         sPWYV+0omWdkOZxl00cKA/Qha9g51UNttNiKygalvaxO9Guy6hxONp/gbQi0sQ9oATRk
         welh1JErebs9ePyqfBkf8HFIH53wziA5XDyZgXfydbla46gsy7Ng1ADaiqeZcIsW3ZoJ
         LgukQZ10DxCfz0GN9Ghqxa6CnMp1vrQMu9PX1ICpT3w+/AuRj70D3qKgnMozGZ1p5BHW
         g32WZlly7XjkVp4fuYd080aLek5P455Bbok7Dx4PGHyVIoZ9E6rdCV4A6wMlIQW/A8W0
         Yh2w==
X-Gm-Message-State: AOJu0YyZnSi+z51e3S8CwaekwNlfY1lRPPM5KDEyHqsLP6I2KHsS/Pfa
	gY/VALxMecY02zHcFRDqMeKwZ7ABhXTHQ23jl3c28kvUe3S5nZfISydxlNpOoQ==
X-Gm-Gg: ASbGncvKESGVX707LXOIZCYUQztJHoZXu2rsW8yTHXoRr2S846wAhPEXYSHN+bME36s
	mda+o0zA1LV4Rb23TRs/YPOzTvLn2ASx9KiZibjiVAxIB7ZQsOkEv5hAE7XEHIBrZkeKlVH2llr
	kn75Uy0ApjT3re+p1eGFaiLWKcQrExa4x8k48F6BhFPTSb5FBB4B3UC+sz0IYz/07xPTQi0ZnBF
	vuY1x9Yaz/QzBFEesaT/bYegLhyQLMjtcoeu9aafoDzyVzmRHoBpsrlqcvYYVP/YPKusmRazuEv
	Sye5bv8nyZ6xlBuBlj20he18GR2zbbxW+wU9pj01LF9DTqUa588pgy5q/XAmHoJaLd4XxNx9qQI
	kzS7IcwFRQxIpCc01OHvRh40ft4YmyWe7PdY=
X-Google-Smtp-Source: AGHT+IEww0vtp8h9B9Mv9EQJ9duDPa9TOq2QShBdNfIFoOYK4H3EiTt/JKWMlUxAzRagqBnQQC3NJA==
X-Received: by 2002:a05:6a00:218c:b0:781:1f6c:1c59 with SMTP id d2e1a72fcca58-7811f6c1e7cmr1889760b3a.26.1758904903796;
        Fri, 26 Sep 2025 09:41:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cab8sm4860221b3a.2.2025.09.26.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:41:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/1] selftests/bpf: Test changing packet data from kfunc
Date: Fri, 26 Sep 2025 09:41:42 -0700
Message-ID: <20250926164142.1850176-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() is the first kfunc that changes packet data. Make
sure the verifier clear all packet pointers after calling packet data
changing kfunc.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_sock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index b4d31f10a976..2b4610b53382 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1096,6 +1096,20 @@ int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
 	return XDP_PASS;
 }
 
+/* XDP packet changing kfunc calls invalidate packet pointers */
+SEC("xdp")
+__failure __msg("invalid mem access")
+int invalidate_xdp_pkt_pointers(struct xdp_md *x)
+{
+	int *p = (void *)(long)x->data;
+
+	if ((void *)(p + 1) > (void *)(long)x->data_end)
+		return XDP_DROP;
+	bpf_xdp_pull_data(x, 0);
+	*p = 42; /* this is unsafe */
+	return XDP_PASS;
+}
+
 __noinline
 int tail_call(struct __sk_buff *sk)
 {
-- 
2.47.3


