Return-Path: <bpf+bounces-12289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920CB7CA8CA
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D082815F5
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213627720;
	Mon, 16 Oct 2023 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kLXTxWk3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0D273F0
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:03:23 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F405A2
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:03:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1939431b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697461401; x=1698066201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSkHq/2/rbn0aIK0PQDHbOiabGTDeAbAiWm0vNQhn7I=;
        b=kLXTxWk3hwZf78rpZREJjVKGvK5QisHTUCep66kdeEAX2/P+a5jp+W5hotp62Na78o
         aU4Xc+CPI3llJWSfEMrlaAaKF6ep8P2MzEH1XLeEr7HV9u8YZE6OgQUcrxuzQQwwGx1n
         bfSdb+9nRKfOHuroIAc+yLCwD4lvLeH91KNq8Jic5DXk+AagqpNkeRe8WMYjLLInTisY
         AFD+V08g1JHU7U17AESIrdLhWrcwcxfMlQyM6HzD/w+u5YsKMb8/NutkcN23eWZZJ8An
         YoZO4LJ2XFSYCnRVZZqmdSlq1OtfnLLQFN6RT/nCYdjEMUE5fcSbnM5jc7lwLtVe7090
         u+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461401; x=1698066201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSkHq/2/rbn0aIK0PQDHbOiabGTDeAbAiWm0vNQhn7I=;
        b=osqxDrRrts7Y8oIp6Mb7p+4830uWZRY2AmrLCbAUah8daN5QOm06CXAqqYm6pmd4Tp
         dndeBvPAopEH3y6dQSKYs9Ojc5f6rf8J0Ve03REQmD+7ceJGsd5dDrDpel7ijA5s4Mc1
         B9DcL7wNunmgCudFknM3UmZlb/mv36MSVbVGib9MwegoL1HOrvozAvWxbQtsuWoKFjSA
         J+r+hSv0GCLWsn9viDOhRgG2i0mDrYH9K8BIS2DGaZRqY8qx/jDhW+ftyO2cOBvZpeBx
         v7oK2Uz+xBYaaj1KgzfxCK6GuDz2yQkYPWRpgnQtZwb/Pb1IX3xeEss5QL4goPebCtOu
         7gfA==
X-Gm-Message-State: AOJu0YzlvXwSy3D14I11BEUvX4M97tEONAyEeGqutyHn8Ew04jOgqY6k
	qfFuozfudD0egszeNv+2TAJM0A==
X-Google-Smtp-Source: AGHT+IHvKs3HuKF12+ygnM8OAY5E9Dq0KRh1fsHfQhI7dmkk7nXLkT03F0R+hk7PdvVa6WkQ/SSRtQ==
X-Received: by 2002:a05:6a00:2d83:b0:6bd:3157:2dfe with SMTP id fb3-20020a056a002d8300b006bd31572dfemr3491264pfb.7.1697461401326;
        Mon, 16 Oct 2023 06:03:21 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id z8-20020a6553c8000000b005b1bf3a200fsm3505583pgr.1.2023.10.16.06.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:03:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v4] selftests/bpf: Use pkg-config to determine ld flags
Date: Mon, 16 Oct 2023 22:03:05 +0900
Message-ID: <20231016130307.35104-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V3 -> V4: Added "2> /dev/null".
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

 tools/testing/selftests/bpf/Makefile   | 4 +++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..009e907a8abe 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -31,7 +32,8 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib 2> /dev/null || echo -lelf -lz)	\
+	  -lrt -lpthread
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index cb9b95702ac6..9af79c7a9b58 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
 
 .. code-block:: console
 
-  $ LDLIBS=-static vmtest.sh
+  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
 .. note:: Some distros may not support static linking.
 
-- 
2.42.0


