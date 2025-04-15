Return-Path: <bpf+bounces-55927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D9A8957D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787393B58CB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1A27A135;
	Tue, 15 Apr 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8Zm+FLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFF27A926;
	Tue, 15 Apr 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703102; cv=none; b=N0/AckDZV/O2STCgBHeYXCAfKInQi98CylW+hB2sjep+2mCh+MkGeymTcdCoj9WDWLFqI5xb9VtfxeTIDyRxyXWjHY2BB6bnKnXZEsHv4HJNriao3iHIsPZWKOzWqkP8p5zJ3T8AggorokCsEMvAqETFLu885hDlXQHJMTcznD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703102; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWsI8t8YT/5Q3FZ/O4uJ4EJJcLyfBQNCd28JaWDvcmq+/E3ZMgMXlV0Aj2ghGxdSULIF1Ky5pEuLwD8u/v/1zgtZMvPPY+4LltnklrvkF7Jpmggd3rKgK23ZnqyacscXQuhPqldtjgHq5mowlgivdP3P8D6CcAWeOgpCOKkFuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8Zm+FLG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so4286906a12.1;
        Tue, 15 Apr 2025 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703100; x=1745307900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=l8Zm+FLGaC21oIwXJTOa31vpx6q3t/hDk41oCGzZDFzHVRJlQwfP57++nfd7RyKGo8
         CwLR6WSJ4uLnUKbzj55H9v3g2/TbqCCMPF4vs8DBt0VZLaMnEP1Vaf3Iu4liSXJjiLLz
         eP/JenyukfdS1AdEZqi5WJxo7P2lQVv9i+DKh5huBh2weT8Pxs2GzvCgzKSXYXBD2FOh
         OjKKvh4oj1ZnkuuXoJT2lcv26+bFGOqBGXTh7fPIyEk59VzMSPrfUFUpTwPo66MKQ4Pw
         ZC69b32wn2vTsAnYgwmjGk07Ksw9A3pl9RTE5HkK2yN4PWwUE6VTR4CT1mgi+YdKtFTZ
         mwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703100; x=1745307900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=gCaofrTRoL3REYd42uN4mV8wnnT386kUCpTFpJOTREaun6brUc2/gbxHhwqE5CrfaD
         j71eWKjHCB2UKWnERTkLXQJNinuZ0hAXMRpjQRCRXNt0Ez43Zp8TdTFMOO1aFEEvNvcu
         GJJVgiZKU1b4j1ZTLpzhMl5PxENTKN415K+GzudmfeJU2HLMY/HdGeYYtlq6JNPQCEyM
         h1abtks+jlkTRDwufsDVkIx7BIuTgib0bGHDqcSixVX267zQbX+yVy539O6jO2bCumUj
         qlegW83aCevlw/IbZtqStLVPOnP/WcF7y1gGIdjaahCG/CoRPBQQP0qeaikjjc5qsZPt
         vqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcLBX2I6bPETu+FYzCm8QnU+hUo9p8KfYhWKa02ZgwQLpICwqZ0qqTcd8CQrhJX1PuTd8E2le60HAcga30@vger.kernel.org, AJvYcCUgVvyAcZXDoKi6wblgZLRfodQsq8WaM4/eONOB6Bix+SaT8vnHZGBwQ/rF1cvhdFDtDpYG7DGk@vger.kernel.org, AJvYcCVd6u2bCg7jI9v3CU1NUDhHrDsFTlsfbZcZrL0TB+gihSTCE8sjEZacD0QVLs69xnHh094=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWqFCcsa+c7RZMMZQj/PIJ0mFt1fqqPzLl23gpqGnG2n//xZO
	jIksd2B2Ew7S0bToC1biFpQpMmjAZomdvZwE+GamG2tFEYjINeWt
X-Gm-Gg: ASbGncuxP5xYOwLrIm+DCu1bVPEkM7JiA35FbSxhRFO2vVhEefKC+OSvVscAIJdtqYf
	kV349anMQh8lMWPsVGRMtbtkKqGV50kpiJMwrpX1n2lKxfcATMw8aN1z8CUQnXTaIUv7Q4XULp5
	mu74qouHANrvnvRMQocxtR2fvLY/xvCX+YUG8yh6CkFU15psJ3AZ1ybaoiW/nJBdeq855x3HSqS
	fWjX2G3CVGCEe9H/X3R/TxtFETCv95L65CL83srHv0Eynei59PWEFtwQiz45mGnY21YSuFUvfRs
	VGrm63AbejAzghn3y1qpFCD1KpKguryna2LK7dyQ5qEtRlNvrfkrY8Z8
X-Google-Smtp-Source: AGHT+IHE5AgDxSwyyov8xJNfUO5lrXFsO91K7n/gdu3YFirq9QCYmY1aQyWqJKPh15l+AnvruQPQBA==
X-Received: by 2002:a17:90b:3cc6:b0:2ff:7c2d:6ff3 with SMTP id 98e67ed59e1d1-3082367fc07mr21477127a91.35.1744703100354;
        Tue, 15 Apr 2025 00:45:00 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:44:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] selftests: net: move xdp_helper to net/lib
Date: Tue, 15 Apr 2025 14:43:40 +0700
Message-ID: <20250415074341.12461-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
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


