Return-Path: <bpf+bounces-12229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7607C992E
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFFD281824
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DB6FC7;
	Sun, 15 Oct 2023 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="07gmkEyY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5D63B1
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 13:39:26 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D47C1
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 06:39:25 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c7ce16ddfaso2583803a34.3
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697377164; x=1697981964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzrY7VrqbAXMDQ/An7uucXcUyYeK5QX4Iy/EeDSFw9Q=;
        b=07gmkEyYlTje7KG4Pz5zn2csjnguffsHbs6sjyxvUXef52O04NwLi36J6q96N/nNCz
         4lZgjiityXknQhYcWWuiVh2Rq30roM/XevjSLRfylPmjpmeYThXqXQvvjKYmUApX6cov
         7gW5sjN1zTtBM9Eomqq2VAEq935rjGlT/LMNJvjK7nKA2roxhZ0RTUsgwEQ25qvlODgS
         /kl/x1FF/gg7rRSI3fC+rxaSWCAOGcU4zpR9ddBiKHYtI4hrn5OJ1mtukZo+X6ko+4+O
         oXjTLXFYQCySrFAHX19yeA6RwV575NJEEcACZHZZSEN8KvgUiOM0NjTHHmTvVFeTr27w
         +XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697377164; x=1697981964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzrY7VrqbAXMDQ/An7uucXcUyYeK5QX4Iy/EeDSFw9Q=;
        b=tYqqS3rsNYS1L9Kgdr72r+3dgo4Ru40aq5guvpkF0642u/zSgOG5PdAyjw6BDJ8Tpw
         N6i0MrJNGLM78W3hI0KgtXAmP/f2cyHEP1HSxiEpniRIYvUYCqp21kwQjkqWDbt1qQvh
         fUGV6rhdsCy2WucBK1us5T16bISSzaQgpMvyJwpuROWSgN1NMa/uPS4Mn7+TqjkZvEY7
         C4m+Nsm3h9L5o1QUKsbUPJZGLDiUb2fhEONd5iSAKr1kPD8p5xRpNwYUQ+wJyxYAa5+C
         /Y1tSAPUZaYssUISGaS1DKP2oeQ9kndSiaKcFo4xEFBFoQMEgrq/8Xbt2FUxBLD74w3x
         dToQ==
X-Gm-Message-State: AOJu0Yy2vtiasO5Ulla2vNYcpc04fpmOfQHtmPORMDwDKkiJQ8DTSV8o
	KSngK9sPD3+S2WAgcIf6pNrFQQ==
X-Google-Smtp-Source: AGHT+IHMn+MWkXPiN2PFxj8eGoPs4OSA1Ena1/nrJQ5EuTY6OU4nQm29Q9sWZwur4SV4dUon/ktE5w==
X-Received: by 2002:a9d:7751:0:b0:6b9:ba85:a5fa with SMTP id t17-20020a9d7751000000b006b9ba85a5famr37027847otl.5.1697377164515;
        Sun, 15 Oct 2023 06:39:24 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id h9-20020a654689000000b005af08f65227sm2518837pgr.80.2023.10.15.06.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 06:39:24 -0700 (PDT)
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
Subject: [PATCH bpf-next] selftests/bpf: Use pkg-config to determine ld flags
Date: Sun, 15 Oct 2023 22:39:14 +0900
Message-ID: <20231015133916.257197-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/Makefile   | 3 ++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..833134aa2eda 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -31,7 +32,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib) -lrt -lpthread
 
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


