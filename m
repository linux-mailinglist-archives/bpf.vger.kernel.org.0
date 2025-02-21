Return-Path: <bpf+bounces-52220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D088A402BC
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE7D8631AC
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCC204698;
	Fri, 21 Feb 2025 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4c0JHLl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6321D5166
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177187; cv=none; b=AH8Wj3zz2aEnQQWZIBjnLUpNwg4g+/yewmMx1k4eX/xoksXlLohgrMubP6BUqItWx58BAIvF0fPhR3/+WhK1+7j3htnuaDVVVODPv6txfLvMcJTmnyqYx3JOTF2pv9vdknqGwM9FwAIomm7QeINFnzrHUq+8NyhA67HV/JJRcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177187; c=relaxed/simple;
	bh=56GdDBWhM0hgcnLQ4aJpscw+7/94YjrWlYHN4UFC6Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4RLplHSNTIaF8o13K34/2DgFBuNfk1eK5IqKPH8FUB2NTeheBe7SOaZq2blGkmOCMmAtHcl6kYlve4TXRDAsKdRMxbwWHtDMVYDqXHVIB4NEVTfBi87iznI7YKGebWSlIDCK1+z0l0Du6XVza+EwkdKC3YtS2nzkiPIHXNKJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4c0JHLl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f70170005so1087456f8f.3
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740177184; x=1740781984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBnTNBOHMtMWmRQxTvtvMEjJbEkWl3187MP93TX+eOs=;
        b=i4c0JHLlejoMrpKBAPCFmT/HGDMplXqVg9jVMSOCZMcKacTe2QkiMXCFNo8p0p45az
         15mmhl3NPlY8WiwDYA8NX25vu/0p2lfp8oR1t+1ZtuEHiS3bfRJ4XR2xmyWRSVbXI+2/
         rW1jWBP2S0px9xWvb5taYsBkRFfL4PdgD6b7rXZX7NPCXh4REF7QA9NerammitSxhtfV
         AeXeW6qQju7RSPtsb337RktE30LpjYYTTNUDpDSzNjmtvb5LnL2LD11ngFt71nhuzCi/
         tYFeE3ghfMTw7/pK1fKcZEmU5se34e10Qlw6u1rr00EIfYAQgRVap3JitrzK2KNUEMIU
         hMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177184; x=1740781984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBnTNBOHMtMWmRQxTvtvMEjJbEkWl3187MP93TX+eOs=;
        b=TdX57rgdrcbyLk4xDv6vugw19p6SbMCPVaBf9fzKQhm2XTqQN7UITd+k0HyFeC046c
         xWlOHMaqv1iejURIizOSjNaePk6y/MhBkEtnjoes5G7r/TNPVmewVNYsXtr5vmt4P4Bv
         1/2nOoL3fab/4l1xNcULdRbGf33MLegXxfJY/RAXFmPraee5YW9vuZhi4eEdVUkWG+jZ
         sBKt6LTMB2B5zzUnupaDTsYYB3H/IMDOYvkfz3ojGv/E+lpNY2SY8iQRFIVyOk6yQOW4
         yIh7HBMPdaEs9mqdNv+lc8sC/e0W9FlX7eKspcRwbj7kEspRYNDzD4nIztOo3O6zikWB
         EKKw==
X-Gm-Message-State: AOJu0Yx3Xj9GRuuSGaTK91lFEf2GYUIeDE2dZuuzWoi67e+/hJ10gUcu
	0Svu7MhCAmmuXbrO2mSIbG5RzsRRoaSPZ9iakcrCms0sG6tmuEn3oZpVlg==
X-Gm-Gg: ASbGncusAHfZBzoR4rd/HBEQcSQFwzLzmXaZyD2/VRtB06se6KwrkjcdZDYTdz2kgJ7
	nz56rK8+nK5f2acdmQqe6d7+OzzZNv19CoYlxb5i/L29rL9/W3xlX+osTPmWb0dBO53xn7Awcap
	yrbfEXKJ3T7oCH5o+a0tLEwou0ntpAhh5ZeVMu70guOPft1fkb4pEgIWbGfft6Lf4Ev4ySfol9R
	hTpr1x4CjTTDjsrd+YvCdn7VYiRRqLhpFseHb9IfT+3xoKDnNw74FFP9TOdbbWROm83v82wyv9w
	HM3Ukcxa/0YEOQxNJmgXvjT0Mk/XDW5296ODysQ0k/ER4q5EAYTAkt0JN0zHg0uxO95h6+dvQcp
	Ewz59fCYbEY9n9glXDLha4RyMQZa4F4s=
X-Google-Smtp-Source: AGHT+IGu8TWOAZHjc05FjU9O7pIBEv0776CFJnkunmtwdoY0NL4h1xsP6CoJ4ekHXm8u0aKtfvS4qQ==
X-Received: by 2002:a5d:59a3:0:b0:38f:470c:932e with SMTP id ffacd0b85a97d-38f6f03e319mr4312908f8f.29.1740177183509;
        Fri, 21 Feb 2025 14:33:03 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm24880003f8f.79.2025.02.21.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:33:03 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 0/2] selftests/bpf: implement setting global variables in veristat
Date: Fri, 21 Feb 2025 22:32:57 +0000
Message-ID: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To better verify some complex BPF programs by veristat, it would be useful
to preset global variables. This patch set implements this functionality
and introduces tests for veristat.

v3->v4:
  * Fixing bug in set_global_var introduced by refactoring in previous patch set.
  * Addressed nits from Eduard

v2->v3:
  * Reworked parsing of the presets, using sscanf to split into variable and value, but
still use strtoll/strtoull to support range checks when parsing integers
  * Fix test failures for no_alu32 & cpuv4 by checking if veristat binary is in parent folder
  * Introduce __CHECK_STR macro for simplifying checks in test
  * Modify tests into sub-tests

Mykyta Yatsenko (2):
  selftests/bpf: implement setting global variables in veristat
  selftests/bpf: introduce veristat test

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/test_veristat.c  | 139 +++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 +++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 tools/testing/selftests/bpf/veristat.c        | 290 +++++++++++++++++-
 5 files changed, 484 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

-- 
2.48.1


