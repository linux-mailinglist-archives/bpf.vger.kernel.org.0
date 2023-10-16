Return-Path: <bpf+bounces-12284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9E7CA846
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011901C20B14
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB9220B22;
	Mon, 16 Oct 2023 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QuygNWtE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB701CA84
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 12:43:23 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9DF1
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1074319b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697460201; x=1698065001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JipE9whaUpQHHx7Hfz3apWysXcawzThQ/KfBXZfjFOY=;
        b=QuygNWtEEqSjM6S4JIcBdEpsT2cEk88ms5w2LnkqjO+EmaIl+6uTrtyHmKEi/imfbA
         L9xIo8xBg9ossubCrFHVAtHEew+9aVAwaZUxOvnwj2QWosCe5CrEhWP/I7cxf7vEwRCK
         3ZrKCXod1VAKIE7Dl/QEU3ZHHQNd2H1EQUMSQiwbKSH4kYU97Nd3hHeYWtet3BqQ+pdN
         3HpFLIa+XnUpz3mfzCHc1GJNf34yM9u8DS/6bMSy1K3uKSbvaehSVIbembQ50IVda6Td
         qj60RJrlnWg4+FxUGN4+Q+Mo3zrNvmUGeBAvzZrlqiEHwQE3ScxCyAi5sOMNjSIrdPj6
         t3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697460201; x=1698065001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JipE9whaUpQHHx7Hfz3apWysXcawzThQ/KfBXZfjFOY=;
        b=JAsnrCYkMDNC9EgcRh7wZt7CMj05emJecwThOWzu8hri++AnZfTscsUaYQean45tSw
         avoutYmSksIznfeqTU2EL8phPYpugE1IRef2wqCpNm7KB4+wGjx6ggt8jYL5JXqwdiC7
         h2BcYqxvr1tWD7aYj6W97WLx+qC1MDupyq3oYl9Sn0wGJDll9kcIugfDi20TLFtgrEFX
         DIkjfHwzB0cVIcs3eX2F9lzTrZcIg561ey82Jh3b8xIFsie5nl0lgHnTiKqwWFCHVYIW
         YBKme5b9tMe74FydIxSeS68mUPdK1oe/v9UjgkjRd46IEO5E4FzpaNqx63Yjp70jG6gI
         TdhQ==
X-Gm-Message-State: AOJu0YxwcVYLqYzoIczZSSl9Zh+yCtqg459DP3Ct1nxx+7Ofk211tlbE
	K9J8zjNkZoCtM9P0bVgr88ryMA==
X-Google-Smtp-Source: AGHT+IFeq6Akf/V4v3w1mbuCkqoYrYeZ0+bp+1svHzm84NBLFinKNR6+SVrALJNs/7AMHkZJPWYJsw==
X-Received: by 2002:a05:6a00:855:b0:6b4:c21c:8b56 with SMTP id q21-20020a056a00085500b006b4c21c8b56mr6606933pfk.23.1697460201060;
        Mon, 16 Oct 2023 05:43:21 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id a18-20020aa78e92000000b006be5af77f06sm77763pfr.2.2023.10.16.05.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:43:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] selftests/bpf: Use pkg-config to determine ld flags
Date: Mon, 16 Oct 2023 21:43:12 +0900
Message-ID: <20231016124313.60220-1-akihiko.odaki@daynix.com>
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
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

 tools/testing/selftests/bpf/Makefile   | 4 +++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..0b4ce6266bfc 100644
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
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib || echo -lelf -lz)	\
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


