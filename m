Return-Path: <bpf+bounces-75254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2AC7BB1D
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547833A7351
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 20:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFF3009E2;
	Fri, 21 Nov 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iilT4xm/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E82EB86C
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758650; cv=none; b=WpS4o/2lTNUqwntkj/ic6I2UesJ1DOxtHJTy+i92oYI965NU82V/swauX+OgOQ/PRLho3O8mq2RP2v4pIuJh1oQoUZlvZkUlCFZppVp0NfgCp51/eN9daxNau61Vcp0zkWHiy04zVGKSY7PH3ezdesF6pSWqP9sm2nynmcJ9KKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758650; c=relaxed/simple;
	bh=UPlzbUhG0sUdnlQKJ3marB1iLd6icHWptIoTFxih6EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWyaqopv6uZHdiqItw17+nfhHaJg5d6p3tTFQWfwrDxsG0J/WcQqSAuYc0TqC16j0vPlSkUiuRDGSPZo9GpDL/k3oU1ELqHlJb6+CUq07f1zxTU448fh5VgTy29D0nCeVai1yhZEdZz3HQ6GT15rVz5wnzp4c0fPad0sBXFG1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iilT4xm/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba92341f83so3406717b3a.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758646; x=1764363446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Poo6Sa9lcHdpaFK5k4oi0jUxnFCHoqA8HD7iXMrSA+c=;
        b=iilT4xm/dFSHkuU070N5Hiuo1qJEmhP88GUDeqxsYfL14RiPtOeZy+npqERG3ZiFAb
         shb0r63YXY4JhdYA7DaLr/8MovdVEGl0rP/ZsRJAet2xhBJNcrQ3vKSjzPjrbyzzYplN
         xR5n3inkeMOyfSVzJ48dpM+H740T/Xm8ERlNvWgDpSqlrHxjkWFkG6XaPS+skolDvNO6
         tQ62RRIS2VXovon2ABSzVcXmRtRLppMq/8BAgwTPyXSTjvveE4bjqxX6bg9+O/OE27xY
         /42VTubNt95MQtEBykDcPYucmORzKvt+Jm7DOmcU3b1AcY/9pK3ecjS+6+GkyvpodE5E
         CqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758646; x=1764363446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Poo6Sa9lcHdpaFK5k4oi0jUxnFCHoqA8HD7iXMrSA+c=;
        b=eWEzE4/O5xy1e31GV/o9gbXyN9+IOfVHNn7eg7due39nrRvBpamIPxkhLFgbRNPZMc
         VFJpPAXyPg6QjjfReUhLfKxWMtuqOT1xsqEYSyZJB9c8XgEqciOT8Km3eTWs2U9m+l03
         lxsqiJFJuPyUsFDnFLQtfAbt28bnuY1jp2T6iFhrUrITELHWci1zUWZgtZ4Y6k9eb9Vn
         XZoOE/adHC8gBafGQCRwsLSdMsC4Jc7+WqM/WlFiGItgnhgo4Gcu0r4frmYKGVB4ZBhB
         9WROd/L8LfcTlOBKn+rS42uL8YntF8Hkj26wRRxbUhQlOPz2Hq7Ew00bSbvKc7nn9NqM
         9PYQ==
X-Gm-Message-State: AOJu0YxCIuX2zYo5obMeRyV07ciSn3R6bHXI02y9nJYh84uDoLxxNlBh
	QVCnY24wejwhs1zew+I49+HjyLsftoMnXWXualXEdyUM1x20apmN5vEZEGDsjA==
X-Gm-Gg: ASbGnctqaRz5+iX6YclQTZbEGZ26GsGFcVyjDYoyrgdF4VD1wyQ5JihpkckJhu6GHhj
	OsKBk+0iJCkmaCA4ZG0s7ECIeO2yZ1K7cpcCJx2BXnBS2uWPizKUbD9jX/U1p0HqQGksT7D+KSx
	hbM/V3tONVrp1ingzPLvlF4SOJLUHNSVkIbt8EuiTSPN2s+2KmAeawM7b39/Gjppr1Dln0gakYS
	MYFteuwTd/IM75SjzdhxvabyjteJfuJfPhPwBMXvdREqwdFMq+jFHdwMRrgCqE995UHO7ckSbI5
	7EUbpwwawZYVixUB1Rb9TVAF4AdCGFCIxvL/oOoYDltMr5gbKx7aOuL4+X+os8qU55cNc9IixGO
	820W+677K/hzh7iAq/CgNwt+GEkohXYiTFmglUWAUX2WhmCPF3mqJIb7JrdKm6H48zlAse+QkWK
	vQf1bh3ZO0/ObKuQ==
X-Google-Smtp-Source: AGHT+IH//nlQhpFNWJFSpf0HqRxnQnhkjJv8FVJoHkSE0cLFRtULz+JaCnsHASmQaZHVZX45TQt2fQ==
X-Received: by 2002:a05:6a00:4b12:b0:7b9:420:cc0f with SMTP id d2e1a72fcca58-7c58cb8e698mr4659490b3a.14.1763758646352;
        Fri, 21 Nov 2025 12:57:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f145845csm6956086b3a.61.2025.11.21.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:57:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	david.laight.linux@gmail.com,
	dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] rqspinlock: Handle return of raw_res_spin_lock{_irqsave} in locktorture
Date: Fri, 21 Nov 2025 12:57:24 -0800
Message-ID: <20251121205724.2934650-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121205724.2934650-1-ameryhung@gmail.com>
References: <20251121205724.2934650-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return errors from raw_res_spin_lock{_irqsave}() to writelock(). This is
simply to silence the unused result warning. lock_torture_writer()
currently does not handle errors returned from writelock(). This aligns
with the existing torture test for ww_mutex.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/locking/locktorture.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ce0362f0a871..2b3686b96907 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -369,8 +369,7 @@ static rqspinlock_t rqspinlock;
 
 static int torture_raw_res_spin_write_lock(int tid __maybe_unused)
 {
-	raw_res_spin_lock(&rqspinlock);
-	return 0;
+	return raw_res_spin_lock(&rqspinlock);
 }
 
 static void torture_raw_res_spin_write_unlock(int tid __maybe_unused)
@@ -392,8 +391,12 @@ static struct lock_torture_ops raw_res_spin_lock_ops = {
 static int torture_raw_res_spin_write_lock_irq(int tid __maybe_unused)
 {
 	unsigned long flags;
+	int err;
+
+	err = raw_res_spin_lock_irqsave(&rqspinlock, flags);
+	if (err)
+		return err;
 
-	raw_res_spin_lock_irqsave(&rqspinlock, flags);
 	cxt.cur_ops->flags = flags;
 	return 0;
 }
-- 
2.47.3


