Return-Path: <bpf+bounces-63553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83992B0836A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710723AC962
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353011F09A5;
	Thu, 17 Jul 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G3O6dMgK"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141441DB127;
	Thu, 17 Jul 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722961; cv=none; b=PVqW3KbYkuc0aPgCFJYRWsDTpCwY0iu8wz1o437rBIpp//XJsSlHJoUOJ0GDR6MCaLTGkdo4jm4R2XjpDNjnSK4QysfQObUDMfWOA9l4r+JNtGWu64wFAe40Wj1tcs6o8iQxHADIjo2vgtgQWrIAg3HtTVcpJtWKpleyqx2r/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722961; c=relaxed/simple;
	bh=5R3dfz2lj3mf0WbiZnGJuNepSOPHnC4JgNW5LbpZEMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mT/Phfwp+f77DtxyPet/XmcFhSp5tnncErIIp5iH6Wbtltz2l2hHlk+b6+A0jm2kkab5Gg/YrAbUujw9axavXMM+NwXjXksoKT6bTkR/5YEvGbUYspAy0fv8w2mRMAMrikuYuGVg7XHTs7t1YYMbwdgXGhg45gH21yZ/TKq1tV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G3O6dMgK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wg
	QB8DttVT6yjXgZ8qnbtAL+MSpdleuQeSvriQZD2ns=; b=G3O6dMgK9D0+isBxx2
	tTKmt6vQZcNaUKVPfanyiC8egj7dTseHRhu99ixZKsOXtaIkMJAD5pAQDfrlnft5
	ma4iwQ5a5sbjvTurdAJqc1BTUE809BaMbdbKOymZtd4Ekur4qN4uzqPpyYD45Iie
	X4KfCsB/u1/EG7a5+yHfGIIn4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_4bdbXhoJsULFQ--.2953S2;
	Thu, 17 Jul 2025 11:28:31 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/2] Fix macro redefined and delete
Date: Thu, 17 Jul 2025 11:28:26 +0800
Message-Id: <20250717032828.500146-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4bdbXhoJsULFQ--.2953S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF47GF1kAF4UAry3tr1rXrb_yoW3Krg_WF
	y5tF95WrnxCF15Kr1UKr13GrZ8t3y0qrn7JF47trWjqrnxXa1UXr4kuFW8uas8WFsxCFW7
	tFn8JryDZrsrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8o7K3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipQONeGh4ajB0vwAAsS

From: Feng Yang <yangfeng@kylinos.cn>

Fix macro redefined and delete map_in_map test
---
Changes in v2:
- directly use bpf_stream_stage_printk
- delete map_in_map test, thanks, Yonghong Song.
- Link to v1: https://lore.kernel.org/all/20250716080616.1357793-1-yangfeng59949@163.com/

Feng Yang (2):
  bpf: Fix macro redefined
  samples/bpf: Delete map_in_map test

 include/linux/bpf.h                |   1 -
 kernel/bpf/core.c                  |   2 +-
 kernel/bpf/rqspinlock.c            |   8 +-
 samples/bpf/Makefile               |   3 -
 samples/bpf/test_map_in_map.bpf.c  | 172 -----------------------------
 samples/bpf/test_map_in_map_user.c | 168 ----------------------------
 6 files changed, 5 insertions(+), 349 deletions(-)
 delete mode 100644 samples/bpf/test_map_in_map.bpf.c
 delete mode 100644 samples/bpf/test_map_in_map_user.c

-- 
2.43.0


