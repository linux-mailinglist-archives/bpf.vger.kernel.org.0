Return-Path: <bpf+bounces-65971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F0B2BADC
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31799586352
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E381BD4F7;
	Tue, 19 Aug 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsLBl/k9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C9304962;
	Tue, 19 Aug 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588845; cv=none; b=OJPDATdueEk2/1wTGR2DQIynQ9lsES2HRWXxzzgTxcPIFsI2vq4Z3gzNEXLV/4HRHbg1+JlGQPkVZha7Z9j+jpYJSvDlej1X1wudADUqpCCVdw4fgukEdbsJF6ObS3zOClXju2BCxh3WfEHrDbp0SPP+uB44w+0DtbAWkT3jkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588845; c=relaxed/simple;
	bh=mvDAEEjcSvS2J/xJnibH61hnns2SV+N5KFudF0ycESY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHqgMjFPJtLiqTp/o7s5TfQbleJgPOs889wFBefDCs6/VABJ9CJ401ZebN3ayMmaiYUPD7oPQ6Sf6O5Uu+1Nwu9jNZBfJJQAEN+QsxfEyjX0s+/YRWKYiCByrbYT331OGcebdxXk6jSvRqWmBgro+6vuHjOR/sNVK4vz26I7cL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsLBl/k9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e8aff06so3898493b3a.1;
        Tue, 19 Aug 2025 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755588843; x=1756193643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRFb3rdAexBW6O6UzAWea93nghFYugX6Crj6XcdDSIU=;
        b=HsLBl/k9mVghgubriLcDbDWHCR2BZzsbB0xTKgh89xTZlNg15lDYOdDSa5YdDVxACG
         4KBgyJGzjsJEMGM3588To+2/JTgw6j4apptmpKzZnWyFy6vVaLdh2fZpSaoxHb0u2LsV
         RgRgFgzPwsjPKo29TXkv4HMPn6rnAUvXZZrK6ujbH9nGN9jZ1G1V4/tlYxVuRkHn5B1w
         Weo1f0P8hDWuAnohLTgOyHXhf4HVGYM9henz93AH5DtRaasbisLG6oPZIcb3/+q/gqEX
         FlO8ZY0F79afAguQceQ84vR0a/FKgzlJr/Cs+z8d66bxgkzzA/xz9DudyO7x8ery46Vo
         /Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588843; x=1756193643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRFb3rdAexBW6O6UzAWea93nghFYugX6Crj6XcdDSIU=;
        b=eLvxnSE/S/VBR9SC3bV82LUdITtorn7h3Q5TP+g3Ab1DGCWoker5O621NLr1hJfEV0
         6ePBtRpc+eOULWYoysMzeoOebe/y6d3AM8K0vv6AfH7IS50KpJc1wtKrpFoyojf5ktzY
         8f0GULAOv9n6g8wiJAS/Dg1I5IW+DqaODGzAxrnUk+l+RQL6lqY1OhM4k1FgK4LDPHoF
         US/726bAVXwY5NqqZYvkHTtDdo7HvKY9Kmypyx0CCXG4epvxyCpOfqSpit3itOsmtcY5
         qPFxT0V8+C7uQS6yNmzbxttd0CcFogAGXQb7egU7BMkZxjqVI9WBi57fT5xWirQQ1oF2
         A5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUJjR7KBqPx3RQBlT6dbsOhtcHBJq9V33mMhtub0UnPYjBqu8THCGNpNlirTUpkg7wz+O2vswjkoh63Bs1J@vger.kernel.org, AJvYcCVyHo2SO/a19zjI0upGUmKG2HcD8ytl7ZibZMiM6tIdHsm4Q1AzvgNzLdjC5doooOxSMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nfgZFYv14liKYOUv6fbvW9usv8eExSE6OutDobaK80JCMTNy
	izUhUSIFXLWXGRqlDrVSqKvoeNAliiDDSwgmyyjwS8TvYVOpkOGvqWD4y9uzvh8c
X-Gm-Gg: ASbGnctCqUsl+7A4I/W3afm4YkkIf2KeyzRMBMAQoJPMsNysKFQi/hNh2nERSZ+Nuyx
	CbeQwW1+GOdO1nndt/SKteF0Isb3Oq/7fAXL6iS0U0Wsb2fM8AAcvqZmf6BzS8piCjNTVmfJTWz
	CPZDrhK2yo0kGdhrR9adExKO1urzWbPVq0Z631EJZdqzlLegX3i9dNLLP73slPamOq64lfV4/xy
	EgzOrtFlZCPn/ujQ1l6uzzgzH2e8aPEqoq2lgILsXvcu53k4ZmNi+9sPrYxiLEKpz9mjE+2D2eu
	S15N8WSNvRXtwLPqGpN8DUOL5P6ruoURpQHCL3LkI6gO62xkwrt8qahh7vN6AjZdxhCFX62Psnj
	lHV7t+BBTs9fVUCP7y+REIyRUSe/AO0s8Rx5KSJ55Gg==
X-Google-Smtp-Source: AGHT+IHcmc5grlTNGzTr7aqz/F4U91EfGnFVj4SxTvYD/NNIEV06PV+BHBlDGl+wvKyqtQFcUQAxOQ==
X-Received: by 2002:a17:903:2446:b0:240:8f4:b35c with SMTP id d9443c01a7336-245e02baa97mr18549795ad.10.1755588843009;
        Tue, 19 Aug 2025 00:34:03 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d547c0esm99742715ad.123.2025.08.19.00.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:34:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: net: bpf_offload: print loaded programs on mismatch
Date: Tue, 19 Aug 2025 07:33:48 +0000
Message-ID: <20250819073348.387972-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test sometimes fails due to an unexpected number of loaded programs. e.g

  FAIL: 2 BPF programs loaded, expected 1
    File "/usr/libexec/kselftests/net/./bpf_offload.py", line 940, in <module>
      progs = bpftool_prog_list(expected=1)
    File "/usr/libexec/kselftests/net/./bpf_offload.py", line 187, in bpftool_prog_list
      fail(True, "%d BPF programs loaded, expected %d" %
    File "/usr/libexec/kselftests/net/./bpf_offload.py", line 89, in fail
      tb = "".join(traceback.extract_stack().format())

However, the logs do not show which programs were actually loaded, making it
difficult to debug the failure.

Add printing of the loaded programs when a mismatch is detected to help
troubleshoot such errors. The list is printed on a new line to avoid breaking
the current log format.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/bpf_offload.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index b2c271b79240..c856d266c8f3 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -184,8 +184,8 @@ def bpftool_prog_list(expected=None, ns="", exclude_orphaned=True):
         progs = [ p for p in progs if not p['orphaned'] ]
     if expected is not None:
         if len(progs) != expected:
-            fail(True, "%d BPF programs loaded, expected %d" %
-                 (len(progs), expected))
+            fail(True, "%d BPF programs loaded, expected %d\nLoaded Progs:\n%s" %
+                 (len(progs), expected, pp.pformat(progs)))
     return progs
 
 def bpftool_map_list(expected=None, ns=""):
-- 
2.50.1


