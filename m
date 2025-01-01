Return-Path: <bpf+bounces-47738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238739FF4DD
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 21:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF28B1616A1
	for <lists+bpf@lfdr.de>; Wed,  1 Jan 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01431E2844;
	Wed,  1 Jan 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fLudzdeJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1B2A1D8
	for <bpf@vger.kernel.org>; Wed,  1 Jan 2025 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735763856; cv=none; b=a/zCfF4oQzo3tUTfxcq4XR6uIho7i5hKsVOTFms3zVw/2n+M476PCiGbTZs1eyNDOk3JnkmCx347c6lIiRfVUmY1ODHaGniYHzWTAnrUzlit3fXIJtYCQi29LpLyuW9+OJOLBEpcoVEWR9a8mcJmDqbtwXdCUzUADE7yDxwTnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735763856; c=relaxed/simple;
	bh=mafagfzhEP12oo2FlLNSj74xkQf3q9qe2L1TXsQ3U2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9tMbS2Sv3XhwywwTrud0q17QUNfkEtFBTHo2V4wQ2de55GouZQRMaKOZPHwkzDTtrO9rvhSiInaSwNQ77YrPAwO4djNKhcWg2U+T/dW8T16070bEJWuq1Re0jkSQLxwcQGwyrXvseZ7shbXGiaSvV45myRCtZ+QKpNZmB7zVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fLudzdeJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b9c6c2c44eso656994085a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jan 2025 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1735763853; x=1736368653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip6u4H6Qm+AOB0ufX6FO514o+Zbxgltkn9qiW74ogXY=;
        b=fLudzdeJZxj2ZPwwspkqgDFzW5XlxKKHTwDPBfh4GtBiAVgjrI9GImnNnl9EUyYqsw
         pElCGr330HHSR2s4QjR+t4eI8ZQbm7XPWmOJaUORBg/S7rodg3eNFBnGVMlgi6pHDk7X
         +VL+uI5wC91QCWpREtMuJXTTePaddEndOsruzUE60f2uH1TLgrNwwLjBb3DzDQCHcVlq
         hhEkLD0xSxbubAa81j8g/iRYIPsL99l7CwobDkoVBN+iH1isYffnYEpB4P2weitcWHz5
         CqCWQqYGaYwdB4CtRvHT1BR1O60muZRYlfxtWfg01JAoopMXQgojZIRNrBHKtvEfPrH9
         +lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735763853; x=1736368653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ip6u4H6Qm+AOB0ufX6FO514o+Zbxgltkn9qiW74ogXY=;
        b=wSaRcN4m6A49v30O0FpT1/QzCrSRKXerqNB06l/VYzSEyUNHPgQjkaCdpU6b4v7Cxq
         fjAahvDVD3nZNqBUMpLTvtc78vaP8ZHSe76jzY4JOBqeF0tJEtwyXdeQIwxdiIQj+cgI
         m04pzpyIFsFfmtWDvTgQ+sxVRHDE+cA6o61ropJLW/tQwiaFpb+wUYSkkzrgLLTB+4lr
         /0FMUGZ6Yvb1ulUq8oj4h8DBM71fYS1WesX9BxH2BwQY3F4Wqyci7x66VVIuROUG5Rf7
         XVErbP6MOQgHza3JEfY488d4s6RtBMxHhN/90VW49FmUwoQkrd83v7XMZaOcHjygYLbc
         2JkA==
X-Gm-Message-State: AOJu0Yxv6ISQnF1BtHFnybjgxFCfpm4qrp4AGTR4QX5SGoEyRV5dVcgM
	EBwUp6MJjSKccU19aLUMGg+ezLd6+RYI/g+j2YTCW3TfGbLnQsn/BQuYWHxon6uygbCqlm3oJEw
	YDahF2g==
X-Gm-Gg: ASbGncuYxxMYv/bBckLZT8MF69n6ztcM8MQ/RrUlI5KnOPK+HT54ygXkSZviRkcR4lq
	aCjtUygq3zsu5lMTWaVgqVV6vFpGepdVBihIYU+YqYHtYc1M3NDLNUsl5T08lBVAYiK6LMqRy1m
	UdNT3HNv4uvnCvrC0kMd+PLvQrNHivY0chCOMpv7aBUl6F758FfjjCu94t/cdHVBxHt8IRZW6L2
	DtqqfPtulXGr367Gz9pwejqqeJD8a9z1lY2R9noW/S36r873ig=
X-Google-Smtp-Source: AGHT+IFSuISZ4Sin47xrgRG1iLl/PNpU/ZE4vceflapbUGu5xz/G4iWTAkGJYzu+wwI1HAjxuSAFfQ==
X-Received: by 2002:a05:620a:2986:b0:7b6:efd0:3d1e with SMTP id af79cd13be357-7b9ba810fc1mr6389283685a.53.1735763853116;
        Wed, 01 Jan 2025 12:37:33 -0800 (PST)
Received: from boreas.. ([38.98.88.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb30dc4sm128358131cf.76.2025.01.01.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 12:37:32 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/2] bpf: Allow bpf_for/bpf_repeat while holding spin
Date: Wed,  1 Jan 2025 15:37:29 -0500
Message-ID: <20250101203731.1651981-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

In BPF programs, kfunc calls while holding a lock are not allowed
because kfuncs may sleep by default. The exception to this rule are the
functions in special_kfunc_list, which are guaranteed to not sleep. The
bpf_iter_num_* functions used by the bpf_for and bpf_repeat macros make
no function calls themselves, and as such are guaranteed to not sleep.
Add them to special_kfunc_list to allow them within BPF spinlock
critical sections.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf: Allow bpf_for/bpf_repeat calls while holding a spinlock
  selftests/bpf: test bpf_for within spin lock section

 kernel/bpf/verifier.c                         | 20 +++++++++++++-
 .../selftests/bpf/progs/verifier_spin_lock.c  | 26 +++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

-- 
2.47.1


