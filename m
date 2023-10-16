Return-Path: <bpf+bounces-12258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2C7CA72F
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2B41C20AF0
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9E262AA;
	Mon, 16 Oct 2023 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GQF/6n2t"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367C2374B
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:55:00 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6B11B
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 04:54:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c67060fdfbso3206312a34.2
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697457287; x=1698062087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOYlO/MfeXwd+3dB86Cjskxh6wnG7K6s71k0LD+6Qk8=;
        b=GQF/6n2tZ0iHsCQoi1uqpf+rKXH8ufHt5kfOV0kCictxL8zmBs/E86EdXphMyEABii
         hzZqkqemlELnEKh/1ozn8uoyhVBoZNYd2SmNUv3u3gN85ASm/0hF1SGEwvxD+aRV0OFe
         vWQurR0EY4giaqiWunjhg04wBmv+5G2QqfQDVukzAG8aFHYG3cV6bd+pFmXZfzOtXsnn
         tbPMHoYIOOaTv8BRTvjQs9b6S7dp4TIr2/pR06T75o/lXQQnN+QxgGkTlVCCo1qO0MR1
         qPl7nw0eCvjH7zmBbfzDF1a0r8Js8yfx1JFPrJKCrq1O3MnmXFUGve7ttzDvYQGfvOq3
         rK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457287; x=1698062087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOYlO/MfeXwd+3dB86Cjskxh6wnG7K6s71k0LD+6Qk8=;
        b=Y2UnCl7RPaTZMCSBoEh8AMXz8yOiL+lZHsqtjm03eXtH9rFp65VTG3RzYmHoPHfd3J
         Qt37J2izntp+DvrsJBHjzt5ojxnAQdQb0HrLWggGfzugc/Pb/Zb6Acl47zJ/YjfFOgOp
         c0Gk2tnGbtDO7NAEdwSqqt3vNmKV5nyZfCfkrK8t6qoxCVabeoJyPxU5QR8LRXJkDtS2
         GctOEFVfJ5Z3va4dLZ9TQN78twJ/zfvdSAqQFVK6tmMS9OnsuN+hYiw0QC4sE+ZnNnbO
         eeVnKqmVAp8lS7vrb+p8xBfy1Kg5exwHYs/2Tn/mgs6eTUkzJX9QdoJ33Fn2Ky4cd8SY
         LwPw==
X-Gm-Message-State: AOJu0YzK8vUhR1UxVz2ksDFoBcHxbeBSLcelLnWqYaSIWY1jyN1sqnLG
	N7zgPZyxR8nCjNlLM/6aw0rNGQ==
X-Google-Smtp-Source: AGHT+IHBQ4h7ouw5FAzOKR7F2qP+qzg01nvvlkiVieBZbDTEXE2Rq+xTl22Xj+T4OkfHnCQZmiNy1A==
X-Received: by 2002:a9d:6194:0:b0:6b5:ee8f:73af with SMTP id g20-20020a9d6194000000b006b5ee8f73afmr39028878otk.5.1697457287664;
        Mon, 16 Oct 2023 04:54:47 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id u12-20020aa7848c000000b0068883728c16sm18666931pfn.144.2023.10.16.04.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:54:47 -0700 (PDT)
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
Subject: [PATCH v2] selftests/bpf: Use pkg-config to determine ld flags
Date: Mon, 16 Oct 2023 20:54:37 +0900
Message-ID: <20231016115438.21451-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

 tools/testing/selftests/bpf/Makefile   | 3 ++-
 tools/testing/selftests/bpf/README.rst | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb..4b947040d6d4 100644
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
+LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib || -lelf -lz) -lrt -lpthread
 
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


