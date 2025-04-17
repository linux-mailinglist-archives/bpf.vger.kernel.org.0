Return-Path: <bpf+bounces-56107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE475A91535
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0044659A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C22222B8;
	Thu, 17 Apr 2025 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Cogwvb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90292192FE;
	Thu, 17 Apr 2025 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874975; cv=none; b=g/xaghPeAEn9rPSjA1SyHpr4TxJ/uPmhk1c+sfHzgGW1kvKSg98leMWQVeuabaQj7eY/XNfI8c+am/8HQ4ZWbj8L4hJUVhqI6RkvGKl5MbUxrQCPObvZIAAiWjgyYjnnyc3znWMjNJBXEtaXgEDiBVAHgbE5Osy7fxyrWtQEJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874975; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVzWQk9LsSWGzpIZO5BhjgCf+9Y8cxKFuktRc17Ky/ep1Amqz8VEDeQd3YfROaLVjbiAkR/rHWp6Sdjc92UthAhsKL+rBnQkIHQ0KINuABOn60x0MPiwDYdp1A86ZVbWihxFGLyb+t08bKF6aW0dRyD2X0W2+4OfV5r1WxRnLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Cogwvb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399838db7fso458896b3a.0;
        Thu, 17 Apr 2025 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874973; x=1745479773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=b6CogwvbQqOCLdum32WeISTqERuoNWe6jjrdmHeTedh4mJkmYvALlxQMp/lyK7XzbH
         fNG4UUXLJu/Bclv8YKUSU6MoxYf8MtRYE3M7N6CqkVlKXPU8Zp5JzJQI2rm04BNl1o19
         B+/Fn/8RIq+lyq/VBwIWScUl1une7QL78yb0ZO2/R2PJHwKCGdLdTyQwmHqN9xxUVgNg
         4++y1k3fib4j084dBNxeI+dO7gHVsBsP7n/qDLLF05ybqS41AUOoA3JQ9C8tVjdQLCSm
         kPMw3v3m3NM0WK13FnVKc3NVntVThf2ychdYvKP9YPdT625qd3gVkl13n3+MlToXE5a2
         vVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874973; x=1745479773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=YmpkQuUfXa95kvUBO0KVf64Eb2ib8/43yu22MyJSHF00x+HqFMJ9quMioerWzRHEah
         GSRr6vclASu7o7fSkra54TZriy7FFwt+V85DFuR7NUXRT/d3842DzjqWrJJTiLZ2t7SR
         YEWuXhhZLp/Fkvp0X5/Uf+umDP534aZEQ5beRB5LKbnB3x78qWTNUL6YXUlATwzoLz1A
         HCJm5HsldC1T5g2V22x/cI3Sx88hzTDp+AGaksLkh38goKC/u3iSjlwmrXl+XKVwYzD3
         sEt95hm4PJRIpQXO+3ANgiNXUNAt2WWpoZ2oKVWh2uZBYLz27kDzPqwS6xZ5gCJTLBfW
         tpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzMGdAlmOgheDY4xpoSO/0SH4yEFGw4zv6ByERsvkA26celPwJWh3sAKACf7uHak2tg6d+CJ15@vger.kernel.org, AJvYcCWztpZoID1HyNVq3zTWPYK9m2buUrRG4IndvAk0eVPlAzA4P5HpS2OMiWhkjPXOlR3Hk7bsInYjKI50k0Ai@vger.kernel.org, AJvYcCXeP+As3S3+iwlEVln5gjnjPz0FKHwCHZE9gc2X+cRHWT6BdSwr0+966c/q+JF6h33ai/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ni6v5c/OZd14NpllkH+EYLSYD5+drSdols5tqcCS4bCBxkPU
	IhLA/5rRbylK4Ihc8BnoZRUO1rmIayP7b+wBHcxH/mjTj6lzLds1
X-Gm-Gg: ASbGncuwcDhWCKLEjMJNZETn5924JRrZssRvDURjyy1s2mtCjla2ccb9M8wSsfOcAKz
	1W9olDAx2D64CHMlx4YVMajQK/mO8Nq3adw8ig/JF4YFi30WbUkRsl+FOIjzl7cDqeFZ7Z6n+Gh
	AHBxKCk7vVXP+0ifW7paLk14QGWa5XqliHG1B7nZSf80LgCDgklblg2U/9m95prkhxieAvNJaMN
	hK1e9TJC3WM9oTW2jpy63NImJQrZm6IPSzzm4O1WbjYl/htN/W8X+C5hWENWVx27UsjvP+OipKX
	4WRM6AD8lJ/tamZlmVUEPIDuMTiMtpQx10QMoMrUVcMVTDombGjfmPY3C1B4m/N+iNw=
X-Google-Smtp-Source: AGHT+IEPUyy0fzYHOBy5qcKeDGEAL1lZs+bWSz+cNnQwUcKvh5PbOd1OY9+pCbu7+dik767iIp715Q==
X-Received: by 2002:a05:6a00:1141:b0:736:b400:b58f with SMTP id d2e1a72fcca58-73cd000d338mr3662142b3a.0.1744874972941;
        Thu, 17 Apr 2025 00:29:32 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:32 -0700 (PDT)
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
Subject: [PATCH v4 2/4] selftests: net: move xdp_helper to net/lib
Date: Thu, 17 Apr 2025 14:28:04 +0700
Message-ID: <20250417072806.18660-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
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


