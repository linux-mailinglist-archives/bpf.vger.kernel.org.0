Return-Path: <bpf+bounces-56670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9DA9BF66
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066133AAF57
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCA231A3B;
	Fri, 25 Apr 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyvfo3jk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896E230BF8;
	Fri, 25 Apr 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565114; cv=none; b=qEbkZHT60VOEYtG1Ps8V2BL9ssjvg3v3K6oQiBd7f/W2h6/Oh0FPyTPSd6v4gXu/ZrxDNl+o+OYe7BxouYExgMRgAYU4yCPP4EsFw4lrmnTrqspnhhrvK85SAd4Hdrl31S26zwpAaXAViHFLoq7YOYFPqNOhQd+wPxmqkTio3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565114; c=relaxed/simple;
	bh=mAFnFm9FlcZV4NvoQvjfbcmlE0Ubh8CcyejzVeGNsbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK7568Solv/Mo5loyldkEXRXaNOkFihqJmiqAwBwGI5QOYgkcxZvdd9D5dOtK7kIhgRdRnmPn5kMyFVXh8LZUEQWaMWwOa9wpKaVbCcptZfwOURIFGZ5U7NGasxChnRVlO76tMI+hqNTZT+xHTxi0io7emra843/X4U7FIIYu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyvfo3jk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240b4de12bso29699775ad.2;
        Fri, 25 Apr 2025 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565112; x=1746169912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JOGRgGKufTsNtNc5oEXqegFkT9LBJnCqXIPnSP+xEU=;
        b=Jyvfo3jkns6Wdgy+fKJr8zFyZ0RxXf7atdv9WCDaBntg1jXnwcbA5eRJmItSRhEnxG
         PH9M69vydG/5ls8tlsr8y0cp9qYnTbMYHo2mHTQdJ8/hMiMGAt1VXmcObUpe/0EIR99A
         tjHLyOWNNnHj1tCFeU288zTlA1oikK2gmJI3KS4DE24bEaZkwuUzubrP2YlxmDRaIPBp
         nqeoHg6q7XKIPwpPD/sTOoDDOThLMrjm7S3uQaBSoK7HoSaPrnMwYE4davHb427H4Vwb
         7HephE3gQ7LnF3M6XVQqUyJszLY5dAGlrp5CoiCYv1EGslnixcAMyGdSN4JhQz2ADTYE
         h4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565112; x=1746169912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JOGRgGKufTsNtNc5oEXqegFkT9LBJnCqXIPnSP+xEU=;
        b=L5TqnjcgRmcBYA3llWpndki/1IGBcTrF1MwRLldW/EFd5wHCDgt/kjm0wdIZ0tRCNS
         sy7vkMIukbeyzn0JPnYiLAxA3g4c/+V/sA3w/VucDbAPlAfGBQWrv2Trc61HcTQRx4ar
         XVdn4bMSAagUGLrP8/7n5inFZSFsBK7CnRaAr69JBNDr1UJEdW+dU8CIkUq5I6M2/ofB
         diFv6C03yVIVSvDsGoQzVGBjVn7wr5rtP1dqbAFLq+GkDTmi4UpkvF5E4nfFaCuibO9f
         G+KqPJY+yN+nxE8ZUOTgQ/bc9qaDtUKC+OcWNeyeKVD1B83GLtewIN+GqlrezCMK2Ylp
         20VA==
X-Forwarded-Encrypted: i=1; AJvYcCU56xzYoB9OdA8ayuB7Bo2onFvwcimXoGyPPJ83pNHtGMRAVxFQI1SZXN7wc9rqBZbE9XM=@vger.kernel.org, AJvYcCV8BvKuPdEsVFcbngySPm1juBDTUwrhQfPJUJGFjnnzyfcA/u2P3PhhghoYUeXCBVKZhUDAyJOm@vger.kernel.org, AJvYcCWWpVnYHCcaDQSZnXw4yCEEY6yXnMWxLSrUgJ5H8F1+ROkvkzq1n5GiArjK3PTWzdSQ6RLGvT7hH00s/Pfc@vger.kernel.org
X-Gm-Message-State: AOJu0YyObC9IpfyHcrQDxE2t/46h4Ss5h4CKpib4yGAS3GumLGhnF6l9
	5WQ7ISgL5w2kxiZhMsn/rhw146fOqf/k/55OTgHRKpsbD1snx4ED
X-Gm-Gg: ASbGnctHyIiODyfvwBzCK0hAzXZXSggjii9pMvrjQN3h2AgJmg+olgyrnvhSoou37fJ
	020nH5OWsLIiGjdK9lu6DIarFaDFgCxDp44/6AZviC+sEjvFO5UhobQ3BBaz7/7dT2/Yl4xzYXp
	7AHwZ02obe1TZ8AtrZMZ4iAedoGd45Xz80+I/ZmlX1RER3iarKk/Gv5mYjTrFR/3ArleCXAWEVT
	M+VEuF21zG4aW1ApuMnXTDSfpHp+as/47ul04Hf3pVCSnl/OknFTuGEKNCD2ZVew589bGUY/Nmx
	5cGg9cu5yMjT9h/3mJ9W8pYyDnLZIhF6DtWtFa5WGUOQRTRLIlm+Evyv
X-Google-Smtp-Source: AGHT+IElAol3//I0LM/LyoucdlPuB7fBU0sANzkXGvmGVaSDn+awApeht13o+Gsd2p3PLalBkVxYgw==
X-Received: by 2002:a17:902:d501:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22dbf6409eemr20756635ad.43.1745565111782;
        Fri, 25 Apr 2025 00:11:51 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:51 -0700 (PDT)
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
Subject: [PATCH v6 1/4] selftests: net: move xdp_helper to net/lib
Date: Fri, 25 Apr 2025 14:10:15 +0700
Message-ID: <20250425071018.36078-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
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
 tools/testing/selftests/drivers/net/.gitignore                | 1 -
 tools/testing/selftests/drivers/net/Makefile                  | 1 -
 tools/testing/selftests/drivers/net/napi_id_helper.c          | 2 +-
 tools/testing/selftests/drivers/net/queues.py                 | 4 ++--
 tools/testing/selftests/net/lib/.gitignore                    | 1 +
 tools/testing/selftests/net/lib/Makefile                      | 1 +
 tools/testing/selftests/{drivers/net => net/lib}/ksft.h       | 0
 tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c | 0
 8 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index 72d2124fd513..d634d8395d90 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 napi_id_helper
-xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 47247c2ef948..17db31aa58c9 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -8,7 +8,6 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_GEN_FILES := \
 	napi_id_helper \
-	xdp_helper \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index 7e8e7d373b61..eecd610c2109 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -8,7 +8,7 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 
-#include "ksft.h"
+#include "../../net/lib/ksft.h"
 
 int main(int argc, char *argv[])
 {
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
 
diff --git a/tools/testing/selftests/drivers/net/ksft.h b/tools/testing/selftests/net/lib/ksft.h
similarity index 100%
rename from tools/testing/selftests/drivers/net/ksft.h
rename to tools/testing/selftests/net/lib/ksft.h
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
similarity index 100%
rename from tools/testing/selftests/drivers/net/xdp_helper.c
rename to tools/testing/selftests/net/lib/xdp_helper.c
-- 
2.43.0


