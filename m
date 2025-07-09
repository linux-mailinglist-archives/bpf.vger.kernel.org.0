Return-Path: <bpf+bounces-62820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33412AFEFF2
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C05A71B6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8E21FF2C;
	Wed,  9 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFU1Wq8j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559F2253AB;
	Wed,  9 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082664; cv=none; b=CyTM3XYqlVhKa2draFO0HaRg0eYMqb8AKFF1ZVzgZo42a/sQETkjJr03SfQ3EF4vkHqOM/BGca0/Ge7zxDzJVzek6JE/OULvZ6ljFAJ2N85tOPKVLH71yYtGm1uOyn8ubMUsOaiS5EK9nGPdzVntUGn4lhYDahTH2EMWDTQ0gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082664; c=relaxed/simple;
	bh=VRKDvJ7Mx3EusPY3SGg5iLlDEDOQSoOskwCppCcPexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kspklGA3VUCnKi6dF2hl+22RiNZCzUsA3KNgMelrSyrJxKEVRQKa2V2zMyaolDqvgbSMT0OPuiu29SDJVyprxtN8r9O/csCN8f7w+G0zbb5shv1hXO+qFucT+TDF6vNDvrfGW2ubRyyGh3vjUx5j6B9+BKKArbjFP7+veUa5SaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFU1Wq8j; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54690d369so225879f8f.3;
        Wed, 09 Jul 2025 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082660; x=1752687460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTfCB8DZJRMBFAh3WBwFD09RAhdpo34c+dwDgOtiWP4=;
        b=UFU1Wq8j3z9zCGPEKY0xc8D/rjneRgwjHC6NTk+pOYkxabROpsxu8StP54DhsxfkZ3
         Esh97QtWYFi0fbPDPnKjRCzUhwvr+Laz688Wvt6xCpAktLRcrEOI3ZI2t0JI3bTYFkM8
         v7ibwWywu5rc1W91ipHi3CMdFL27FGRUFbmcqS5SCf+7C01Jbo0wQTUj0LWalrJxkmiw
         Vzv8//J4eFYk2X6inABzUnh++S/W4foX4FvA0pkuECrNczgdVru+P7K7Fs+0m6X1XyMz
         p0ovv8uIaz2QfOT8q+2unYCRM+h9atAJWD7/bt1onfNtt69+wmVZ5XoZ3VLne+Sr5lBf
         UUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082660; x=1752687460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTfCB8DZJRMBFAh3WBwFD09RAhdpo34c+dwDgOtiWP4=;
        b=fuzA894je4gYVyXU6QUb/OZWPz2NnLxcNq2voK4Q6kMiitTwsRe2oqB+Wa7PsytQez
         S2aJzy4fgF6RWHuv95/8iWaAfwaAgoDQ+WYdTm/QKtCqbt1QWvU5me/3fy4RDvN8+rdH
         R5oFONccgCh/7QD0VOMrLykJaubsre3OnhkWjOPLRpaJh6CV8HT7zLwWRVHK+I6ysGaa
         fv/ZEaOogYwqLqaV6S2EGkBFskx5jzVneHCxMpsmkkeclTcVoFGm7miorpjJYLVXYHIP
         O9lHFjd3aadZjLHSVDc3asdOkPPYq1KxaHvuVTq6r9+mYuKRE/yeMOaJ/hHK6hrF98ch
         t1Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXuUdQAxmBJEQXdWf7UHe0XlU4Ku/K9G39DSggBLyVROgsfA6dPwlldceFcGe9bZ/f8w18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09ektsgtITRoo3mTdU9zlpKBjDcLifN7KS8NG3iy0znca/3zJ
	gAG6atAvJyJlrAEiLOu2VH/cjHjmGimEI7T7ibXByCb8peuFId2z8lxfi3tWM2ju
X-Gm-Gg: ASbGncuH+9qKagbL49q11Q1jM/5EiHheM5FNOtp/Ib5iIQHH88ZIiStnzLiSOJ0Cbct
	bd06gY+ZgZGMP77BfsbfBv93h9v1p8mfdZ3JB0iCoqDFazFdYLDUbpBU9lvod7AQhV9/cAHdpPi
	M1GVl3MXq9KBo4DNPOrp/6YqbcJyhHII0DG9p6AOFvxLthppoBIlU73I+BUwDp8+Ue6x1wuMlNV
	gLRPBQ0/9kFcaGYc3/e5G4gIN5sy1p6oCRm6PQK11Q1jePPb369qMiTGAL1CB29ifyuBp+KcCst
	OsyZ7DLU6dm0dn1hKSx58mGcNW+OI9FdquuARRYGFDyIkg+2c7QfgFgjiB0=
X-Google-Smtp-Source: AGHT+IFT7eD5fxL4jsTLzyqeGFLTf64Kf4BHqJEcZzQcCkBuwd0ANbl9LUtxhoGI2SV0SE3pdFSYzw==
X-Received: by 2002:a05:6000:200f:b0:3b3:a6c2:1d1b with SMTP id ffacd0b85a97d-3b5e4521e89mr2665075f8f.28.1752082660208;
        Wed, 09 Jul 2025 10:37:40 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4f398csm39972195e9.2.2025.07.09.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:37:39 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/5] selftests: drv-net: Test XDP native support
Date: Wed,  9 Jul 2025 10:37:02 -0700
Message-ID: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add tests to validate XDP native support for PASS,
DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
For adjustment tests, validate support for both the extension and
shrinking cases across various packet sizes and offset values.

The pass criteria for head/tail adjustment tests require that at-least
one adjustment value works for at-least one packet size. This ensure
that the variability in maximum supported head/tail adjustment offset
across different drivers is being incorporated.

The results reported in this series are based on fbnic. However, the
series is tested against multiple other drivers including netdevism.

Note: The XDP support for fbnic will be added later.

Mohsin Bashir (5):
  selftests: drv-net: Add bpftool util
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/drivers/net/xdp.py    | 663 ++++++++++++++++++
 tools/testing/selftests/net/lib/py/utils.py   |   4 +
 .../selftests/net/lib/xdp_native.bpf.c        | 528 ++++++++++++++
 5 files changed, 1197 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


