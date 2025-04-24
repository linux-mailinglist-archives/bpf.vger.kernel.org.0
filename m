Return-Path: <bpf+bounces-56581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F1A9AAFA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F21188B967
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C622489F;
	Thu, 24 Apr 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7nhxhND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B331E5B6A;
	Thu, 24 Apr 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491797; cv=none; b=lTg1NZufpFWmM4ejHFhJaz9+pPF8Eh2ijpUdj/vAdVo6W5Z10d3/1C0+NbssTnJUV4Y4nqCyN+X4188G8wN4Zs22LsiSdzy+eI2T6fUBhAnHQmWsQlUfLOAixtcG/wO0QqQ0aQkM8cXjx8IAETN6dxo3HfNb0QOlK+Z4pgkypjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491797; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJOB/kayNjmMapIc1FAV7aqEwAIZkurAestWmEYGc4lIGyGDrQGv/0NSiSYRaiw6lsU15rqWJX/ThGcvzgWTvG2uEwrz7vZfPTXz6KNYjHvCCXzocFn4nxCmhGQRPWaTU9jG+TjkNJ66KUAlw8hCNgJyzTJG+8UOI1VsyTdjFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7nhxhND; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736b350a22cso622629b3a.1;
        Thu, 24 Apr 2025 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491794; x=1746096594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=f7nhxhNDglAs37ZqEliaHQ3DQ/xgTgkVuB97kHTBy7g2CeGbiMD9iTYNFDFgS7i985
         +9pJkyyogQqejml75kzYhhAjRCiq/N1WGPuDCWNaAjcJws//X/VrP1P4A5Cfrreynk7e
         oYlhGG5SOqlNBYQIFS2cHKgZrsZX+Rh/BL1trOo34LCQjGfvZ04IIqrbB6jRs671ANaE
         ohx09CuveM0tXKvaV4UMb+1F8cGjmonvApijkVJDknH34NppBoIKjfisCHEi1mVSZ3d4
         9lkaF9iS130p7LckHIlsn4PeF5/FRb09OFKgFm3sg7XZpnBPeliwWDGC21jfNQm6yYtY
         Te9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491795; x=1746096595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=TWZpuYvJuSbqeFf20kjkQ5niGLuxAlGC7XlxmYuvHrpHApBCksdjFYn/xaAT3n3PRT
         HTk/N1I8IFT6idAlFRD9nICJ+unMDyvcQVKcHT6J1o0DFtdqEGnsY/tQlRgZag4fp+WS
         g9gWf9hieyKgyV72OwySAS9KQgHgQEC36ckxXRDIY6OAtSdN770PV6yiq4nghoMDdq8d
         ksoXbNuM8PvNe+iXmgRBHLdV1F0V/OJAkSOjNF/DUFC5p2QXrFBBdTgS2doDM34LzPyt
         Ox1Q5mCjgjxN2Vq3Zgh+UpcBkAMamzUuRLKT6ZaGDePDdWe1xy1AXunc9Uot9HrUiBHk
         JnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbUWmcLGQlCILadWjMidJw64WdUcIKX0btEwWsw8Xk8ZwUNx4PDhKE4Cf99hxBjy1gBNYd1V+Y@vger.kernel.org, AJvYcCVdb2w44dIUO6NlKGhn8psP7ZE1WvuwQlozCXfDba+JGY7KZX9kmbNjr2dNXZf3KvOEMMcgeIPRlqDy9sJC@vger.kernel.org, AJvYcCXfbUj+nKCPb/VXTnz+Vk83JJCGqcZ6Wk+qBlbPJiTMtqA1pNc5ifl0mwSfYLyePic/cws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl254z2PHUbZ6RyMeTJjA+TnZOjSQ1DbmigSfocElekn+0X9pF
	Lsa4DUKsI/nO/9BP4icDWjiHv8Vn/vhyZlghTKPdLkvrHbs4UJS1
X-Gm-Gg: ASbGncstHXYA7R7uVEKwvM7hTnzvPvF+5GS2IqKRi7WeFn9Z14HB8IXIInw79BdfOU1
	sIvLrecXvC7L5XKrPP4ZhRuFV9b066a50hmdjzk6mNMVyiT32I+I0zKmQNmiOBwZU68AomRc7CT
	t4v6bfBzZxmuAQhme37yaqUlHlA2ZK/qObB2V//bMMSp8msac1N4g7s0XgfzHS4Yyiz+oWaC8Zt
	6lzzktRL8wfFYR11RlhAwY82tMIeqJJ6EKtl8t7nK1Dv02O0xsFHASF2JT/bigpNegNTDbl/Q7W
	d+MDvEAW5cpn3OMBf5BC7ijZV/lMEyvOzKy52J46iQVWoJ95zBykWIqI8F+TRasesoM=
X-Google-Smtp-Source: AGHT+IGs1NWG02trRr5fLXhr7umLQzDhYVTGMHaf9AQpRz+KF7MH5lJcU6z/o7zq0i7To22znOcydQ==
X-Received: by 2002:a05:6a20:ce44:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-20444e70080mr3316057637.8.1745491794602;
        Thu, 24 Apr 2025 03:49:54 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:49:54 -0700 (PDT)
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
Subject: [PATCH v5 1/3] selftests: net: move xdp_helper to net/lib
Date: Thu, 24 Apr 2025 17:47:14 +0700
Message-ID: <20250424104716.40453-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
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


