Return-Path: <bpf+bounces-74622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C475C5FE34
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0924B3490E7
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB521EB1A4;
	Sat, 15 Nov 2025 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIvxGSt8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5919F127
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173577; cv=none; b=h+B5oTm07J/8DqQxItaUBtyIHwSjbxH2+z4akHnUO5KhvZLjM32uPAIENWaxDvJ0XawR6ylJANgd+JkyRwdhj5C/X2ZqMobNmAM00wepoB7KujsEDWEECnqoJjmL3UevvyuaRNELNGIJ8j+rcrVWBmdvUsSn0CmqBNmql/qz4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173577; c=relaxed/simple;
	bh=kjsVQMv2kezBfRv3h3+xc3Sj7SDt7Kiv46yOSb0D5XY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSteSRtjlqy/KA5FMSOo8CWzB173Ylz2RxvrA7B7TmAsz1dLptGAFlQtW2a2H7ZAM2/JP+x0/hFI7HFuQiWi5hzeQawEXyB1ja0nD4jDsU6POYJrtO36xS/XNDXOvtu+kvrc3VCZj7izet/pYB6ZZOS/xgzjB+Ks3PFr0eYvMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIvxGSt8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343d73d08faso2574505a91.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173574; x=1763778374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dryvNWn3KpcIE6B4WAPPjPQpviYokz+5p8sglmYinvo=;
        b=WIvxGSt88W0imIKcrg/DpveAemNBUj20tvXvW1ZUikKaiFQqAsbfGXPb2EMuPiP/gT
         9lxzP49xL049qgElXjotEB28KeR3lfJdaQa9FOvw7WVl6DOwsvZbetqPHskrx1vAWWWu
         BpcUFT3ArojUxmF13NWtmB5PAMQ08sy/5qIEufyS4pj0RamvefhoqDLK4dXB2iuG1aVo
         NOT3sQ/xdqKh5i4nBxmZ2sP+df3swVmpKQUV+nwU1QuCXZoiGtzzO7GpCIy38ByZUnWe
         3nL2VYSwYLHBvaUOG/aQA17FIMkQ2X0nQylS0E2pG+ZOkt5rXwZVwAIWIbXbHdqfrUH7
         ODBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173574; x=1763778374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dryvNWn3KpcIE6B4WAPPjPQpviYokz+5p8sglmYinvo=;
        b=IoaYyxkgDW1nxYUzOdUbc5fMeOJ+Okhmbkfwo9Tg9VDuiPS/R9dPGm3F7IoZwtzcTw
         tIx2GyknQANikN9mcb3qSphhAJPedWPQHAgSpjGJVDt0yJaOFfFHZ56/HU44wEOVy1my
         JhSP2xVkl+qG9z3fxjorJJrP8tTfJbjFYT9wvMLgbwu7+15ZlV3i1PD04oWoZZfKG/uO
         MWOW+bHnhlVwWmdqNGjpuYk/CZ8i3p8WV8/lukRBJ8wQvWYS8ijnxuMpEuXuJ61tjK3K
         +H6ZdpHznGoo+qyUkUw0UK52scRdOj17lLKryb91Nqdm/mn2PR65D4DzoBj5/Zi//0Ds
         lilQ==
X-Gm-Message-State: AOJu0YzNgdIW461C+rN5S+lhPJJcJC+Rrwz7yGnaFiMPhjZNI3OtcMSH
	3qCfcmXgCsu8VKW687rzImWVBDHS9a86VIKx4f7KZO1DIb/WW8+ewtuezzacFw==
X-Gm-Gg: ASbGnctbKEDwnKs8RFUkwFdiriOu62LOFBSZA80LMLBwNcQADeP8pmZqZSbwvPdijCQ
	oXgdpMIy3YyjbfZbN8gHmnJDVzpwSVj6as3fwqIE73vM21bbOSATDrGiNDUVeTkqYPeuX0acYee
	TgkoflLejDHL6Y5KQJ0grTq1HDNc7p/9P5sVV7VsGEIPdAgAPQr11s5JIAoW//+OxJ6aUeYEbAn
	UJduEwh1zBM8rxBFH1Emum9y4AZ/siELJ/4KSqdIKq+UWyLdo1yeeE3zW43RwaHZnqm9Ao43EFR
	6U/HcYf6bV662ySQ9pcqhPYqT5+7zXuQvN3E294/eyFwhvTDSIrTN3zKeG+3fuyc1v1bEx8okZW
	CgaWnybAKSCLqDdozm1q3dhCGYYVEmFQLrQzgnbNXdZ5NF4vffSmxNdFgMgu7Y2cqEo19F71iy2
	/bUAc6CmEOHXHsWC5m9ec3yp2P7DZg6dZO/5KOQ+J2Rnm9KaySz7EXVrZhMpVV5CZ1RA==
X-Google-Smtp-Source: AGHT+IHxSF0hpDuQqW/z3/kmVRLUD4IYNYMpMoJJt0RVQ1s7p4KYlIj4jzhMfPhccKQ/EpE6tIUAng==
X-Received: by 2002:a17:90b:1f8e:b0:343:cfa1:c458 with SMTP id 98e67ed59e1d1-343f91c13e7mr6136994a91.18.1763173574588;
        Fri, 14 Nov 2025 18:26:14 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456518a1a7sm1894898a91.15.2025.11.14.18.26.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 18:26:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sunhao.th@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 0/2] bpf: Recognize special arithmetic shift in the verifier
Date: Fri, 14 Nov 2025 18:26:09 -0800
Message-ID: <20251115022611.64898-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1->v2:
Use __mark_reg32_known() or __mark_reg_known() for zero too.
Add comment to selftest.

v1:
https://lore.kernel.org/bpf/20251114031039.63852-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (2):
  bpf: Recognize special arithmetic shift in the verifier
  selftests/bpf: Add tests for s>>=31 and s>>=63

 kernel/bpf/verifier.c                         | 32 ++++++++++++++
 .../selftests/bpf/progs/verifier_subreg.c     | 43 +++++++++++++++++++
 2 files changed, 75 insertions(+)

-- 
2.47.3


