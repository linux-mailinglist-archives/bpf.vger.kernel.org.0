Return-Path: <bpf+bounces-55839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2350A8772A
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544B816E9B3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F11A2381;
	Mon, 14 Apr 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8mdm2Fo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5019CCF5;
	Mon, 14 Apr 2025 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607384; cv=none; b=p8VcnL/jnYQvq0I/cGhJlrzZOmLhjcLLLeKDhSR6zczTIcrxm871TbM9vNVtmoUidtnro4IbP6BvWscP0Ih49DNFxpFAJLBZf/GtJGC6aWGsYALQntfTdCurm32059pvFEhc1Y7yvkIN5cCZnF+KCSgfQmoydRR2ki3wo3q1h60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607384; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDwrvgigXYyFE3WocrHzg54mWzmgmD4UHgxic4ve53R8mjxFaHbavIJ9/yYM0gDE40Qte/egI7/lwR1vU47K6FQJx+LuR35bCqoBDu6zTRY5k3J76HLEGO78yYG3b3qiPLYCwnaD2acEwc9XzOO7OPMDcWs+Lq0FJNWdsHIr4RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8mdm2Fo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de12bso52473275ad.2;
        Sun, 13 Apr 2025 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607382; x=1745212182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=W8mdm2FoON46bEMBaY/L7RHoxF+CVWttLr1nsgwwkiyKO2FH9wl5OZkD9iotY3/qI6
         jXztN4mgl1xvPxXqakITe6AUyrDmBOl48ig/LKT3HpmumNyGTHN4qD0SYzpDMGFpEz5t
         8xy2ewLPV7/qJogHeR27niAfKMQWUdbi+WtDkmoFmgys7h/V0eZaAsTYWsxFqYDWGgai
         xmSW02qHmzngXKzJUXDnMvscqQMacazrpZT6gtuA8RaHN8mJsSKazioQd39R2y03V2QH
         a+SOpc34X++hhmSQTJUBQBuaZea2IlQeA4Y4GDbZjy+yKiYGNkSGndDaeKDpSCUxx9Od
         EbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607382; x=1745212182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=nDMGLenbWtCpbNfZmvOeGVGX4h8pkSNHdMwz09i+2urd+K7ePJqOq7QfR4duA80BCu
         Yvp4cnJO28kEH4/FRb/pJ9wC4Wu1WbaxX1WciTENaSA5tGKa6Mdo43NEiww7ohPADOhy
         pRSeFFBb0Z+zGj8HttQbV4JYe/0Se/5YIrA+c1skQl5NyFTFtkYpZ3q2aGpyv4myFNy1
         1sk/g0YwrOI+CyLtOSzgS5K9cBhgkZvARP39n4vZJlVnWq0rAmEBdv0W48iBW2yu1WHX
         e82TLVNRkCFW89aONdp4SycuJqcpVWyUTB57hzZoQ2LLgeIWNqo74vwxAPAp8zzNVIC1
         6+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCURTm3hN2AiFI/Ylt81bkM9Z5itib/vxGkywzza1GHZKxBQmd5aesqSt91D++iE102nmn0=@vger.kernel.org, AJvYcCVa8qyXTtuARl5Rya5Ta7zwvz82V8xsFO5Zyi/Q5ukxttA8XAf/zy3V4rSyGkeVamrU7zP2U88E8qpoX6NN@vger.kernel.org, AJvYcCWtLpo0L9uz0bPTEMTjqLrZ62Gtr6bfUOCbHtTSdbJBITamBh84j8B0Y/C+I3cxGV6FzBzxNhPt@vger.kernel.org
X-Gm-Message-State: AOJu0YypXAZV9+tcZLDLhHBH6f2ttl5BXKloZA5UZ/iF+oaw47RCF24u
	WtnOQGd3tgdroOHiei++k9OUftTUDTxpfr4rSGXJvJXhBywMI9Bk
X-Gm-Gg: ASbGnctGpBDRVnQ6dpbhIx71hR0e95ypRpGJG24cmE417xh7nGQ2sOMVFUQWybGP3iS
	+U55pT1iIk50jSUy73a6m+jVFp9fgmBFnfVa/RuRB6pxtxeT9Z09UV1N+nkphvfQVZt2q9UoKNJ
	r+dPsMHuDfPWLB37t6tT1jTcczo3gm07E7gE9gEy8R5abLxN8ZHjE3aFsqgPWfFX6ghCHGO6Wuj
	op5G0BwUemT8QfnVV0Mnp5xZkjRgUaZwMk1A+hDkw58qQ76xDOu/0hShJSjAEIaixcD2UHmJ12N
	vvr1Q18WWMPunbphaLkrhbbyk8fn4CmGhMCJf8V91Jb2QB0/Qd+RdtI=
X-Google-Smtp-Source: AGHT+IFRDdR+y7fnmSVY24vGxnYcOYF2oSqO5tUVnC8sp//HSH6HJAZuXejI1iqoNQq9MH59YuatVA==
X-Received: by 2002:a17:902:e5cc:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22bea4b5f93mr124668945ad.18.1744607381927;
        Sun, 13 Apr 2025 22:09:41 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:41 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
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
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v2 2/3] selftests: net: move xdp_helper to net/lib
Date: Mon, 14 Apr 2025 12:08:36 +0700
Message-ID: <20250414050837.31213-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414050837.31213-1-minhquangbui99@gmail.com>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move xdp_helper to net/lib to make it easier for other selftests to use
the helper.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile                  | 2 --
 tools/testing/selftests/drivers/net/queues.py                 | 4 ++--
 tools/testing/selftests/net/lib/.gitignore                    | 1 +
 tools/testing/selftests/net/lib/Makefile                      | 1 +
 tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0c95bd944d56..cd74f1eb3193 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,8 +6,6 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
-TEST_GEN_FILES := xdp_helper
-
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 06abd3f233e1..236005290a33 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -26,13 +26,13 @@ def nl_get_queues(cfg, nl, qtype='rx'):
 
 def check_xsk(cfg, nl, xdp_queue_id=0) -> None:
     # Probe for support
-    xdp = cmd(f'{cfg.test_dir / "xdp_helper"} - -', fail=False)
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
     if xdp.ret == 255:
         raise KsftSkipEx('AF_XDP unsupported')
     elif xdp.ret > 0:
         raise KsftFailEx('unable to create AF_XDP socket')
 
-    with bkg(f'{cfg.test_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
+    with bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
              ksft_wait=3):
 
         rx = tx = False
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index 1ebc6187f421..bbc97d6bf556 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 csum
+xdp_helper
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index c22623b9a2a5..88c4bc461459 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -10,6 +10,7 @@ TEST_FILES += ../../../../net/ynl
 
 TEST_GEN_FILES += csum
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
+TEST_GEN_FILES += xdp_helper
 
 TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
similarity index 100%
rename from tools/testing/selftests/drivers/net/xdp_helper.c
rename to tools/testing/selftests/net/lib/xdp_helper.c
-- 
2.43.0


