Return-Path: <bpf+bounces-75404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94FC82DB1
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 526784E18E4
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887A2F7ADC;
	Mon, 24 Nov 2025 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPL86y/i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F32C0286
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028103; cv=none; b=qQYkU+H9na09Y9Wi5GxkVN9Xo+7Z7YqeikFgozW+eaVo/04LRD81l9rq9qVKdZ0ay1qyfU6Z7tgktST+i/KXde4dbpw1BbT1d5Tw2qNCIQEj+ymJyb0EQauO8vtHg4hYtJk6NNrhXHXLlY89rCpwiGl3L4UdM/MPH+LmR/2uKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028103; c=relaxed/simple;
	bh=0HZiUPVVqiDv8ZEl67pEJba49nGpbGLpzJLHrHVWkJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHaWa/35A6msEPs1Lp2SgKn4V9aA0jdJz4bgQY12ZQq56zQvToMO8HsDRJuYBq7Csr9woK8FXIOKpXv4ovvhiISCPxXIcAgxQkQjgFmESdovFoQvU1abviiS3LWh8mrRHa91q2U+y6uQFmjUluYPFE45DBhieqIEl4UFVE71CeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPL86y/i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298456bb53aso61333265ad.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028101; x=1764632901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8zwVcuAssRnEQZ8e7ewIMIsPfvOXMAA4RWGmHyZ+Rs=;
        b=bPL86y/iBZjOidhBAl6VEV+QifNIHQrW4C3Ep/nwnKCbwUYO59IpTBFsDTtTEXt8yx
         FJpoB8nln2MJ0VffyNsLuxsbAfCrlFlqVQdFMMBONxF0RNtxGWy73OnTLTVzfvdxyT/l
         1a5MQ5SILc0M6AkSTMRTtkdDAAw9Lhar88tFes+HRhPfsfPrH0YQpWIRbMdqpN8JxpT5
         pn89jOdNkpwNkPjwlZ7wuYN9CfRt97F+rlWz4bReRFYlh2UbtSsd3m2VD8CYzxEdUPwJ
         1hrdyU71mzSM4j22YMWsrdkPTHruHM0KynglrtZuDsfqrhVEhrIXc/umLfuVoTM6pkLZ
         4c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028101; x=1764632901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8zwVcuAssRnEQZ8e7ewIMIsPfvOXMAA4RWGmHyZ+Rs=;
        b=HlI8gNjRvRe5xAFrFtsJEku2DSKxDMk40xGhDz4pyd58IHJB/J4pBwghAi5zvMNM9N
         gYO7f6DhhYTc7XPb0OzruNqVJH+bkwELcYHUvFyYwAH++3N8KhwhZuVQNnRAg6zXi5uC
         hVlRWVqbJWru4SSl4yqGO3MA2j9NYeZdbcEiuBSJULUegJFnE1t3x+CFaYpWo7ONcJwK
         UaYE3efFBQ2Gdqm0+mWQ0zK2+QgKMFCYdpZomLGXUvRU61XCb9izvAVyBBo6Q/gAQU7j
         /G9gE+2J0fIwBJbHKD5YabizztezlZ8ofxk5LfZQ/xbOx0mi/WTCDcXO4E5njpOxttJj
         JsEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXRKZVcx5pBDhrEkntIY2swzTlTC0htUNz601tPABL5MOIOTV4r5SR7EmotI+GJG60xzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wyujqX8z2XkP5q4ooU7iDdPeYSYEnVDO3dgtKlkeU5aY3l65
	ckRVHld++viwki6vBYC5p4Y3Cj6HgGiJ+sOLiSYkhFfU7Ik6jpWvalAk
X-Gm-Gg: ASbGnctqQgXMtM8hIx9TDx4uQmb1u3Tb4NexVL1ixeOlUI2h+he4x22xskBV+DnsJL4
	E/CIf2qCZTO7DHDs1m/40xELjFLpPKskB7f34aUc1HzNfno16HllMknFlM+z7EoIp7RMzOu1+Dv
	OiCrI/aYthDsW+FYGVf7ybevV7aEd2pfLpT0Ki04je8yUzdeV2kil+ypVRWNQNVIdYD4qOo7w6p
	K56JGrX6ap9FoPKKtiIqNgbiL429ZB/HgmClOShbK02wCYgpR2Xcm0/R7hia2hGr/oRjv3Vc0ql
	DDy6+u8ag+BitEJno+hn8bf91u2Ja8sjqvCtwBRMJmQCha4wtk3827pI/pBYfbap+GJvZhxq/FU
	hQho506aEyEugiiVaRbEE6Ogo+55o37glnvZ2LmhwxUpsE8NWg4qWjHP0GJETBKcdEMFVB7wPGL
	XxVfgpBBD4+X4MSRuXNFU500KOYD8PQrgzyQPrUO84AHmxozs=
X-Google-Smtp-Source: AGHT+IEWVgvs7HfQh1Jftv0/sg1EMetPp1p1pbe1p7lp0IBRgw/xws/S7S4QHSHoK5/x2kKFyy9WJQ==
X-Received: by 2002:a05:7022:1093:b0:11a:2ec0:dd02 with SMTP id a92af1059eb24-11c9d85fed4mr7996088c88.33.1764028101157;
        Mon, 24 Nov 2025 15:48:21 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm74670928c88.1.2025.11.24.15.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:20 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH V3 0/6] block: ignore __blkdev_issue_discard() ret value
Date: Mon, 24 Nov 2025 15:48:00 -0800
Message-Id: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

__blkdev_issue_discard() only returns value 0, that makes post call
error checking code dead. This patch series revmoes this dead code at
all the call sites and adjust the callers.

Please note that it doesn't change the return type of the function from
int to void in this series, it will be done once this series gets merged
smoothly.

For f2fs and xfs I've ran following test which includes discard
they produce same PASS and FAIL output with and without this patch
series.

  for-next (lblk-fnext)    discard-ret (lblk-discard)
  ---------------------    --------------------------
  FAIL f2fs/008            FAIL f2fs/008
  FAIL f2fs/014            FAIL f2fs/014
  FAIL f2fs/015            FAIL f2fs/015
  PASS f2fs/017            PASS f2fs/017
  PASS xfs/016             PASS xfs/016
  PASS xfs/288             PASS xfs/288
  PASS xfs/432             PASS xfs/432
  PASS xfs/449             PASS xfs/449
  PASS xfs/513             PASS xfs/513
  PASS generic/033         PASS generic/033
  PASS generic/038         PASS generic/038
  PASS generic/098         PASS generic/098
  PASS generic/224         PASS generic/224
  PASS generic/251         PASS generic/251
  PASS generic/260         PASS generic/260
  PASS generic/288         PASS generic/288
  PASS generic/351         PASS generic/351
  PASS generic/455         PASS generic/455
  PASS generic/457         PASS generic/457
  PASS generic/470         PASS generic/470
  PASS generic/482         PASS generic/482
  PASS generic/500         PASS generic/500
  PASS generic/537         PASS generic/537
  PASS generic/608         PASS generic/608
  PASS generic/619         PASS generic/619
  PASS generic/746         PASS generic/746
  PASS generic/757         PASS generic/757
 
For NVMeOF taret I've testing blktest with nvme_trtype=nvme_loop
and all the testcases are passing.

 -ck

Changes from V2:-

1. Add Reviewed-by: tags.
2. Split patch 2 into two separate patches dm and md.
3. Condense __blkdev_issue_discard() parameters for in nvmet patch.
4. Condense __blkdev_issue_discard() parameters for in f2fs patch.

Chaitanya Kulkarni (6):
  block: ignore discard return value
  md: ignore discard return value
  dm: ignore discard return value
  nvmet: ignore discard return value
  f2fs: ignore discard return value
  xfs: ignore discard return value

 block/blk-lib.c                   |  6 +++---
 drivers/md/dm-thin.c              | 12 +++++-------
 drivers/md/md.c                   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
 fs/f2fs/segment.c                 | 10 +++-------
 fs/xfs/xfs_discard.c              | 27 +++++----------------------
 fs/xfs/xfs_discard.h              |  2 +-
 7 files changed, 26 insertions(+), 63 deletions(-)

-- 
2.40.0


