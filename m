Return-Path: <bpf+bounces-60199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2DAD3E99
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C717C4AF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB723D281;
	Tue, 10 Jun 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbQGTgCq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527423E32D
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571986; cv=none; b=sZoKPfu+CXiQeBONXtzs7b68FulRjjCd1c+L/d6YGDqFdQ4bpgoVIknykgYLJWoHF6myqxlrUGZQpmptWepR9IXtUMYgLKk0eMq9LDPpcxdOfRWvddSViD/6bAEFCbyhOB8wANJJOz8uENgSbDsSQPi0Cl4cpWeEGc+iaXG5nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571986; c=relaxed/simple;
	bh=l829k7XzS6iDnpxrIMWX4harOvdnqpW0NquxrSx666s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vFFjLZViz9xYeVd1xeMBKF/KG5zCZgRR+hwHmtWdylT3B8aSPOsNDZzB1pFXGQi4f44qBFLLSkJL2xJFTxrmujS4jkGt3mkRl/OJtwT9zu1kRF7lDl0guLYFKYaedwnuo4ubcVAmnc4pHO9FA8e8qotJVoeO5E9wT+5FFCXKdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbQGTgCq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5532f9ac219so6539456e87.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749571983; x=1750176783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yjP14xiySCigtoXkYxI9D6w/0ZXK/jAYpsxsJzs2VVY=;
        b=DbQGTgCqCASNUOgVbQPw3+YGegFaMKV+tHuU5Yzl60F5FXnnOKB33o5PZ5SfUfFXLp
         uTxtp7G2TiOh2/Hs9qeJuDBbFGQXtHMFAGaVaT+uvCn4m+eHcaA1u8WC/G1RmwXPPmdL
         mbNNsneHxyLBnESbzK6bzUS43XxETnX6m3s6nM7dKlv72omdoil27jL55T/S3bfGGMd8
         YIKzzrv2+CdJ5zLuzTwChPbE26UlgBiC9AzN0eJxaam3ymSbXPDkuR49CUHjD1BA2Da8
         bH/Yxh0o+Kx6Amk+prd0OxJC0KyRhntyJhHJAySjvgQxdjMJUfnoNZ4Ny/KlPplWhfzr
         aXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571983; x=1750176783;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjP14xiySCigtoXkYxI9D6w/0ZXK/jAYpsxsJzs2VVY=;
        b=oJbRa9RSTPvnLGSyLC58d9REUUmnyJRC5OuC8goesYNI+j+Ir0ZEGEQU7vTKz43W1w
         n4Sm98SbVf/yB08NH5n91I4JFd0y+bDOR8YTml6qIYkSUVTHmFmQcDLntK2VSYEiCiVR
         UrACZvjZgBN+1ZfVfQBQGHDrxgES1Gr6pZ7KLKnN5nKu0bODCC1RQFtMYpKO1gejSyPm
         FfOg6kAcX8lNSzqSq+O/lG0kMJRQ45IzXsyfOVs4lXRMutTvegKMfnEbQCe4zzrIDV+u
         RzEbFPPXCMGLvV+llIMniLTkmt/mIAQGB6wfynL/8E8eGRuvLgzCX9EdTgGfo4PMBu9U
         CNJw==
X-Gm-Message-State: AOJu0Yzs5mYE6iXLHrs5KdcbAq5ou1IXqASDEGD6NGf4j+ls5rIPKGNm
	/biQSmckX7SLde+4OfNKuaf/v5a1StsQcOi9RvU5Q7EPzt1XCP8xL/6lhG8Eipr1bf/z5F1gcZY
	G8YD+xsWbEGmyMAJSTBR2wzL85wsjjGQtW5qRF+c=
X-Gm-Gg: ASbGncsgreZuv4m3/CAt/H0WkQ8vmoqDIeKsD6NYmClbG2h2yIsfsyFvd912+Is12nS
	BTfhOFSSXsOcMk8diqM2Hcj3MdkhNJ0dRxcsHIJM1k89oo+qyTmkN2AFw8L+MyJMb1gCIlO1Qgd
	T7hpBIQZvvOta3M3tMAkeqTdHLMuGvCCh6sCaFUNtD23g=
X-Google-Smtp-Source: AGHT+IGSVZv4S9c/Y4NIJ7ByO5HV2ZsfsJmRxw1hDQRgoh5h/+8dKVqJdezpHcwhi00Kbz85cFoMnSUhyyLIL8HJTlM=
X-Received: by 2002:a05:6512:2301:b0:553:2ed1:ab1e with SMTP id
 2adb3069b0e04-5539c1d8362mr64411e87.46.1749571982544; Tue, 10 Jun 2025
 09:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0KDRg9GB0LvQsNC9INCh0LXQvNGH0LXQvdC60L4=?= <uncleruc2075@gmail.com>
Date: Tue, 10 Jun 2025 19:12:47 +0300
X-Gm-Features: AX0GCFucLPJkEKIlYVLhtMWkqeYtp9n4QQSv_7wRxJdfkxoTZm9O4u4-5jXniZI
Message-ID: <CAMxyDH3hfsN47sXqg1ZpRib=LpxV2ym32bnYj8gxi8eDGFtMLg@mail.gmail.com>
Subject: [PATCH] tools/bpf/bpf_jit_disasm.c: fix potential negative index
 dereference after readlink failure
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From d1adf16aa1c43b44b536532a8053521d119f2f11 Mon Sep 17 00:00:00 2001
From: RuslanSemchenko <uncleruc2075@gmail.com>
Date: Tue, 10 Jun 2025 15:24:10 +0000
Subject: [PATCH] tools/bpf/bpf_jit_disasm.c: fix potential negative index
 dereference after readlink failure

If readlink() fails, len is -1, which could cause tpath[-1]=0 out-of-bounds
write. Set len=0 if readlink fails, to avoid this.

Signed-off-by: RuslanSemchenko <uncleruc2075@gmail.com>
---
 tools/bpf/bpf_jit_disasm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index 1baee9e2aba9..5ab8f80e2834 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -45,6 +45,8 @@ static void get_exec_path(char *tpath, size_t size)
        assert(path);

        len = readlink(path, tpath, size);
+       if (len < 0)
+               len = 0;
        tpath[len] = 0;

        free(path);
--

