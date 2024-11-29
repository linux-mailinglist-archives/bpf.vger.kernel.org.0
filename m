Return-Path: <bpf+bounces-45854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB49DBE5D
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 02:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E5D282484
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAFB168DA;
	Fri, 29 Nov 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRAfjc/1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B117C69;
	Fri, 29 Nov 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843356; cv=none; b=ISIco7Km8RzN1Nh1XApl4MFNSQxuxXwccGWbW+q1Q1AS4yKrXoXhwOYdavSyJBH0o7KGVYGNRbtRvway1/TqQRkGoi/IAsDZtK4Utp4W5JJNhPEhi1vwTD235hYo84Cp7AjyLyUtnGsQrADsMtzdwYdmJRMJJkaib2I/JzrfQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843356; c=relaxed/simple;
	bh=ku0TcMbKv4FpUT2iFVlGDk7q+Mvm7FdRUhJy3mXMCJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t5kKkHc1hwVnbRqCSXAQRk3y+EMgtH7gtp0ARW2XDySYFb8CNUjezUKvzCixdvTMkD8EbWJJ2HuG8tRYN5iPbomVnJmdLS83t5O+hZBt9kuU5pH1LFSEqITToQWW/cOPrO7003rWJeQ5UnzGLxjA7EfkX97Y1W/KTXP3QgXNWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRAfjc/1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212581a0b33so10833175ad.0;
        Thu, 28 Nov 2024 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732843354; x=1733448154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOM7mo05xMT3m4k+Q+ep9u+QSSlwZ80ja21NRlm2Jo0=;
        b=JRAfjc/1N/Dk6bPCo5AQSSs15OZLIySGFqYuxtSbiKA5052qMvhP7nyj2wyPVKUG8F
         smksOGouiGfYdGxCdF4pOGwSpluz0bUgS3a1kqZiJW4XkW08VaKOHIGwLJ/idEIfVE/J
         m2Ufc4u+jHetN8zaBh4EUyp/TuzKa4c4jZO10mz2WClFZfrmA2TuhPMdJwrLuYJborKq
         SbWx69EoHCCpRthE7mXiWtEifh/ibWxxiv+s/4gU6UKzsHl8c20Gi5aJx3BDC/cdaIZP
         DJfmZPX/4c+21byj67pHC3sHl5ET9MCmm/0RqNPB7taeOp/gkTbozWNmCMazd5CMajXh
         dJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732843354; x=1733448154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOM7mo05xMT3m4k+Q+ep9u+QSSlwZ80ja21NRlm2Jo0=;
        b=r6kTE6UKBimxQmw1kmcxjoiUtI7e+QP32BtNj3tBVJTh34fn84/G/WMQv3JIEnw2Vl
         7pEKWkjnwVsvLI8IUjLu8Pm4o4rudYNDexayEyGgBx4WgyzuYDlM9uJvZ1YvZB5ewNvi
         4KjL0AEo+Ha03Y6SmnzLabuBxyHri63p6CLIDEhYmkqokB5euE9j9ID0zDzjz11NaLHS
         XcwgUQlqzO577wa52jbHIluUT+0okGiHmde/2GEhrVT7xtCo//8fT1qrGBk+c21us531
         9rIw/OcTOv0qMO0LTZb+mMKEyva7KdAHGolipFJC22VB6MLgG3BJlWR3feBZRMDOB2zg
         MA6g==
X-Gm-Message-State: AOJu0Yxd2ASOJ0O4T/SSGEMVvwBAS3Wo8zoOtF7VZbDSs3lsMuvrhhMj
	Lnd7oy3fE6B0Rv4dZUVDx60+CIj+2fg7GPRo09A8R0spmsOAa6DV1CdDcA==
X-Gm-Gg: ASbGncsqyQV+70VZzIQS3JMWiTwFsagBFI9BtsTYAGChmH7dX1cO+b/WgAHtC3CrvNf
	Ew9PnjsZMCvcZHTanl5dmDqOxPCWLq9qv98bl8KPk3wbNOKoBRtst43nr1NoFll9I38cJG6zMAU
	Bu4/EbidtzQytNrtNdFmzulpBqxs9cRgcqLO/LenIsVD8J4Yc2dXOB+yHe+/8X1KlmU7zPp5z8p
	yZlXPw7qCZN/bidBwiy4TLXKI9S4UZA0HhAwPjzwdCwf5Glxkzq0l599jJySB1gz40evmYEjw2w
	5vo=
X-Google-Smtp-Source: AGHT+IFUiDBCWZiSUK1OGkOK5wZWj05vUZDqXC2vV1bSGcFASLr5822wscQVNcx3TfE0TIqIoKQQLQ==
X-Received: by 2002:a17:903:244a:b0:20c:9ec9:9a77 with SMTP id d9443c01a7336-21501c5ff2cmr103371205ad.37.1732843353574;
        Thu, 28 Nov 2024 17:22:33 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:7990:ba58:c520:e7e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905120sm20010215ad.80.2024.11.28.17.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 17:22:33 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf v2 0/4] bpf: a bug fix and test cases for bpf_skb_change_tail()
Date: Thu, 28 Nov 2024 17:22:17 -0800
Message-Id: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patchset fixes a bug in bpf_skb_change_tail() helper and adds test
cases for it, as requested by Daniel and John.

---
v2: added a test case for TC where offsets are positive
    fixed a typo in 1/4 patch description
    reduced buffer size in the sockmap test case

Cong Wang (4):
  bpf: Check negative offsets in __bpf_skb_min_len()
  selftests/bpf: Add a BPF selftest for bpf_skb_change_tail()
  selftests/bpf: Introduce socket_helpers.h for TC tests
  selftests/bpf: Test bpf_skb_change_tail() in TC ingress

 net/core/filter.c                             |  21 +-
 .../selftests/bpf/prog_tests/socket_helpers.h | 394 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c  |  51 +++
 .../bpf/prog_tests/sockmap_helpers.h          | 385 +----------------
 .../selftests/bpf/prog_tests/tc_change_tail.c |  78 ++++
 .../bpf/progs/test_sockmap_change_tail.c      |  40 ++
 .../selftests/bpf/progs/test_tc_change_tail.c | 114 +++++
 7 files changed, 693 insertions(+), 390 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_change_tail.c

-- 
2.34.1


