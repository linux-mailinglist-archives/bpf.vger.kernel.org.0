Return-Path: <bpf+bounces-72940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 369CAC1DDA1
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B00A64E38E0
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BC3A1C9;
	Thu, 30 Oct 2025 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RArflTXl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145811CFBA
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782816; cv=none; b=GWB1k3N0pDLbA27XX3E91TFISdxjuSkP86pjxECKbfy6UwRufYl7myEyg04NrzttYPz0l6w+l3gaXukN1Fd3ugORa32wNcAlr0HCRB7EfKKcQEavnMJZHOHW4AhgCgccu/ZbocRgd8RPTv8xNh3I/Rji/6gUEd+sblDj7r6YjvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782816; c=relaxed/simple;
	bh=SCfiGPiies82z9ioXueR/N43iveSe0WK/6Zp/t3WuJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fwjcqbw1KitRCq7HiBfcOHG4KyCcFJ5VsyC1HHasO6rhTJfniQtIXuiClE5e2Rbaee5PDAUW3M4rONihvNQFsi9vH8B6OiyWm4BiEJ8AMd6f/hAdrbNy8b5CV9JCvXRUOqWl3uzEP1kULnZ9XOknlsFekcQ+PhGpi/RqUMjF368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RArflTXl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1146195a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782814; x=1762387614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1hNkDtSx9btv+ppu5ID3Ac1b4Cfy+TXF5aN1lbNAbM=;
        b=RArflTXldx+BCchY47tZpx3SEKLsamNWujxbyI9akTbo/dVPquTJYrsQbUiDwXU05H
         vk2cP56+YXSmUTRgSlxt9Ay0oyf49vyxHptfR1jLBrkxalFZfkDitjL7Z430vrKHlxAx
         fMpZ+ibiqsbqC0uKB23y/dJqdkNl2/6hE+LM54dZDWD1KLczLrH8p2qjD7KGrvCJMyOB
         VTjlhQ/IbNaGjjyVtnpE7/EAsAtnZq9hFQrnnJwtU2kPnQBmTCNYFInCrikamCmYRyZj
         /qsK3BkEJaAMMPtqgL3WNSLNm7XfNT4KfvbaqTPry0/nbltiXFdZsOF5sZtlyQMnY0hm
         JOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782814; x=1762387614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1hNkDtSx9btv+ppu5ID3Ac1b4Cfy+TXF5aN1lbNAbM=;
        b=DmN1mGNgQIglqSqLuBK4cWpCtMqwsvPqaQqcd92NgtkDpTkXzcL2++X0iVnkYzlzIw
         drKLGVqSyFfNuU1zI4O2qKhGmHm4VloeWJ7vvXjH1E2/a/gZUIP2BK0pwtFlRmnkfezg
         GY3Aa2hxzZ1JJqAPdOIiqRmmxaGlGekCpSrSdxUUtpWJlPqBBkbKlgatj1UaxsGNGH35
         PW4p+2Jvb0oZIzUa+sHS+n8tv2lkfcP07kFvi40y1mzE/0TdR8ANFJKLnyUQf/Ob4cXs
         78QGv54pIvOA3B4/ddkT/5dofLI0D65+sdu4vErzHZhBdglyomJNRKn4FxkZ19aAi4sw
         Sy2Q==
X-Gm-Message-State: AOJu0YwpGuX0CJmuGlMDKTE/CmuUP67a2fZ4jG0S88RdGFMsOBI00yqF
	3kx8hlfFymccqOsv/0qpTy4q7KvcN+5Ze/u8xdr4vXowyli5FGt7Swqk
X-Gm-Gg: ASbGnctoG4NPeh67mb/o+JKODmwJUfeto5XVlnwv959CECvrjSIxKa2vS1jtFn4m+gN
	5/8K59NE3liSGVgNFG814gJgXe5rJ5jp9T0hoNp3nQTAzaQ0FjJRQiRXOau3At640bqGZ4A4kqL
	6WG08UQYMaU2KcC5ePAuG2VwDlL9AN5ZhjadhJfIAn8uupQ+ELT5Pv6lm58FzcCrX7jeZdrpTPU
	aKKP+tl31D1MSkmpqE0Ul4y2kKNkQNY51816KToHZkNdi5g5C/mXOwSs4RoMXC4x9VXeAAR5pTG
	NZ7UKVFMrHbLQCTE+fiIagaRz3qWeRxktXuc3NZ+NP3WDiy5CEZVTSb+0NWGzjz0DE6ZXW57Jru
	BLCHUtmO0ztZeT5b275a/5pZ5FoCxEpbhWpRiCR3LeMNTuw6Jpt5GhkhvV8yxq1+29oWb15RNcU
	v2r1aXNBOKcSveIxJNtKHjoCq3C67Y8gPXpn83uw==
X-Google-Smtp-Source: AGHT+IHKfChxSwIqjz2zTw55zM4v/EfZMYy1z92r/U9l+CG4n+pE324MshyKfd1xIDlI+/dsB4MahQ==
X-Received: by 2002:a17:902:ea0e:b0:265:62b6:c51a with SMTP id d9443c01a7336-294ed2a1377mr12476935ad.23.1761782814185;
        Wed, 29 Oct 2025 17:06:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4117esm162900155ad.93.2025.10.29.17.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:06:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/2] xsk: minor optimizations around locks
Date: Thu, 30 Oct 2025 08:06:44 +0800
Message-Id: <20251030000646.18859-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Two optimizations regarding xsk_tx_list_lock and cq_lock can yield a
performance increase because of avoiding disabling and enabling
interrupts frequently.

---
V2
Link: https://lore.kernel.org/all/20251025065310.5676-1-kerneljasonxing@gmail.com/
1. abandon applying lockless idea around cached_prod because the case as
Jakub pointed out can cause the pool messy.
2. add a new patch to handle xsk_tx_list_lock.

Jason Xing (2):
  xsk: do not enable/disable irq when grabbing/releasing
    xsk_tx_list_lock
  xsk: use a smaller new lock for shared pool case

 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 15 ++++++---------
 net/xdp/xsk_buff_pool.c     | 15 ++++++---------
 3 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.41.3


