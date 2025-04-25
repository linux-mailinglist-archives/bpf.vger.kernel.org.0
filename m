Return-Path: <bpf+bounces-56669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAD1A9BF5E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FB146486D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823E22F778;
	Fri, 25 Apr 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnbQwrdA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2E22D78E;
	Fri, 25 Apr 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565108; cv=none; b=qn9i95OBka/hzJC08sOEIXwXzHbK2gfLxDDkdRqSWhqJ5nMmMH4KgxE9K8A1M6u8SLhcPMtrGwUtf5lc4f29+qkgbr627/KIpHLGFOEibMvYWYYuwiCkee9B7fXCCDURCRwNU4hDY0hj4ZS8ruRCW9bFKJm67G2uTXNpR41cwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565108; c=relaxed/simple;
	bh=0Ze69pOVYWCyP97tOm2XndYB5S6jNW2pRESISwXWI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/AikElsumgN1jWUQ4aqh5s5+QOo/uIBSPMkHsc/GWR8eeKA8NCplBd61JxPDGo75uj5a4wJOxx7lezouK4PBp+hnhjsjv73cu2iIN7kJ4wHrsnynLGUlRgicmVN36mWlfXGZS72i3PmGROnEPl0NayXg+5Q5aY1bIVaDzGk89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnbQwrdA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so22393445ad.1;
        Fri, 25 Apr 2025 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565106; x=1746169906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtMjqZ/Ns16pRT8iEFKMxWMmeC23SEmlGerRJL9o71w=;
        b=MnbQwrdA+Moir3XKQS4N44NIcn9AZCusm7SVxLQoQUZe03ftdgNgssR0OTlOKhTDqd
         8k5ySkWyAOLOmKRlFc0+9gE2nE3Lk+VBr287C+5bULn3fFE/X5kC4u52sJ1sYo1DMCgO
         06rLUEVX1chG8kOPA363CkTPJm7GLFXT1c+3PD18/UX4WlZFIeeEGOVzP9dWP4swsvjD
         o0lSP5A9MwwXZKPjNLTQcdLS/3p6tx2os6f0RMwicuqcs0tf54D2gq93/Rz50Qk8GQ72
         31alYF9rWemhLtOtEMSQAS5jxdwAszUoDLaadXU6ySLUo9ynnq4N2gHO4eLqTR3yBG74
         aJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565106; x=1746169906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtMjqZ/Ns16pRT8iEFKMxWMmeC23SEmlGerRJL9o71w=;
        b=ayOmzZxZAizXGRnHCRNyxNwd8KD5vh0ao9G6h72kbOl/WHR8/hoj33lvFnK2AuXaSM
         TgJXnJkwYrcgiSSTCTBbNKmSGtBt07VyRiZoUdN9KJAD9iMHOrPhA3quTxC6t/2ZQRi6
         i51ZAqDynh8FLfNuSJZNNB3HBX8fj0SAa3CorhUKZRN5Fm+CIZBM/sqozaTwwp3VXoOy
         03xGALQwJ2qF8XvGiayVlrbUu1tvyyyp0qcq8wyDDhGjyZVG6TZvLskQGZqFnkszu9hz
         0egu04WkfKE/5GbTPb93g8hHU+WjArp/tM7NZwVwDoWUT9EzDEM9e3lHY5zpzPhIHLBp
         PaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjwJ/vy/5MclavzLY1Iv90vP1zcifY02jy7PB48moyOYHsjym+U/Gp87mcrWP88lYuYktEre1Q@vger.kernel.org, AJvYcCVoa3rAEXVzHRF5TKwZsMyYJdMgoQcwriaf7abb4/duPAWpTNlX8FwLOWpvodiXum+147VEvyx0I36rlHcG@vger.kernel.org, AJvYcCWMnR+xfRssR6dxvyZ3yGRkwTYJljBEgAO6jtoCAuIFkb4qSIOQwJtMUMt1WUUlh5euJ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6MMpUqTwcb25mez7CIZk+Y4GB+UronUgDoEtMPdC1lmKwTT8
	TCaTLEeVskEtYa7tXQZ3PSqOtU68x9ehtI0AwTJ7BcSnQhRR1ur5Pa0eJDpgvog=
X-Gm-Gg: ASbGncvxpSt6fup6mg560Z+UL5Vdvl8K3ZSFYN+iQoRdGRkU0Xw2oveqOOctUMIj7i+
	RQTaVa9+0A/VnJsqy5UMjLWXiEsx7z0Mf1BnuhMhXgq7C1H7DDzYW8nT7otxaPYjeE94SeKG7d6
	eOgrFbhOfj5Xeu0Ms5trl3VZRWK+gzu8skHdm7Dl3NfhFgzJinbEHZIuwLSCXXQQWqguxe1RVsq
	5PvbpHjCmptNb7ih55Gdxbux7/C6J4r1TID4ex3WOd03BZ9jHnX0Jr6CBoQ5Oge9eQl+5ZBakA7
	Ahnt9xhi+pNvPPEGXpULKRihAiCyvl/2sEnAampHby71lezvpsestmuk
X-Google-Smtp-Source: AGHT+IHQBCORaP5MawLRFbQfek2IOmsMsFyZUNMLFw+FlPP4B+F/1Z2uUqZZUzD+g/PLxtZRDST5rQ==
X-Received: by 2002:a17:902:fc50:b0:224:1781:a950 with SMTP id d9443c01a7336-22dbf5ebe7amr20344645ad.14.1745565105709;
        Fri, 25 Apr 2025 00:11:45 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:45 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
Date: Fri, 25 Apr 2025 14:10:14 +0700
Message-ID: <20250425071018.36078-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This only includes the selftest for virtio-net deadlock bug. The fix
commit has been applied already.

Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Version 6 changes:
- Rebase on net-next and resolve conflicts
- Move the retry logic to xdp_helper

Version 5 changes:
- Refactor the selftest

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (4):
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: retry when bind returns EBUSY in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 .../testing/selftests/drivers/net/.gitignore  |  1 -
 tools/testing/selftests/drivers/net/Makefile  |  1 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
 .../selftests/drivers/net/napi_id_helper.c    |  2 +-
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../selftests/{drivers/net => net/lib}/ksft.h |  0
 .../{drivers/net => net/lib}/xdp_helper.c     | 39 +++++++++---
 10 files changed, 98 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
 rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (78%)

-- 
2.43.0


