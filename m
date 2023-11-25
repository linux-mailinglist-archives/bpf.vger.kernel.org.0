Return-Path: <bpf+bounces-15839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BAF7F8960
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 09:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D33D281738
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7A8F6B;
	Sat, 25 Nov 2023 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gZiEqYa8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3924F1990
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 00:43:22 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfae5ca719so6125015ad.0
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901801; x=1701506601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0MgZk1wjA7oN6wh0F/2QVcx7Di6tJCC9+3i36KMM74=;
        b=gZiEqYa8bHmIGeqQ8gKc1wQ9NjI0djpJqRsXlwIaF3uWwfg2r8MeSqg0OdbPCGO4tf
         pZL8KZoi7rgYvozNxXwCu/jDz6YJDzKFmxBOKjkRKDTpCbp/a2TglEWl5N1ifU7j8ZP+
         vDfTaUBL56IfarFBUrvcieiDKqzyt5nJk7uk47fGthCx3hcTCRHOQOLvs+xAvLly5WUe
         ZBJT0/OhcReVmNR/7/GpFloS8RcI6mKUD+D+QoPbNGFfHKP1QiLe7dFXqNi9uVHJPNcw
         5w+ZrxR1w4px3DUl7jM1dSaCN25q5vonmpEXU9PDXDfFnc4wCMEGZo3OymngIv+R2vgn
         UIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901801; x=1701506601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0MgZk1wjA7oN6wh0F/2QVcx7Di6tJCC9+3i36KMM74=;
        b=DeWjpb/ySO2X8np2oqOo1aPNG3+Z+hlpjjqFX7KX//YBTUw+nwVUtWGuD0A1GHga6B
         px6Q2EFs1siHlUBngGjOIOLGgIk9qylr+M+g8bqNkEMLitvkxkAvXKNWg/p6oAayWusO
         dUwxCUiFGBrwJee2IyJV2vbOvgPUzGQ9uVgJxeCQLS0J1z1+PZeAu2Ysikx2G8aOFBWE
         nwM2ohF7V9uoT3yp5s68B4iTBaNvuPmULECqpluVQYxYkq/7i//bb8N+9jixiWxW7Bul
         EKUYd1g0CXo8cntaDii/f31LaOROiQQ7u/spMXUvRo0mOFppHCaUiJQSlPuXxpG4hHfu
         9oGA==
X-Gm-Message-State: AOJu0YyGVqtezb6kDTOIRw4gx+n9TjXKs3P5SVixXLBTrPdZ3mB4f3Xb
	wmtiH9A4iHVkHagfDx1Dhotvsg==
X-Google-Smtp-Source: AGHT+IHaALqakfp4Ql5TcXmGo6Ln+y2ernCX4AymHrvtStelwdd1wSXPTd6Nn3zAPPadG0W0MisnBg==
X-Received: by 2002:a17:902:cec3:b0:1cf:7cfc:c3b7 with SMTP id d3-20020a170902cec300b001cf7cfcc3b7mr5703205plg.10.1700901801375;
        Sat, 25 Nov 2023 00:43:21 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id a3-20020a170902ecc300b001cfba46e407sm260609plh.129.2023.11.25.00.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:21 -0800 (PST)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Use pkg-config for libelf
Date: Sat, 25 Nov 2023 17:42:52 +0900
Message-ID: <20231125084253.85025-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231125084253.85025-1-akihiko.odaki@daynix.com>
References: <20231125084253.85025-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 94825ef813d5..617ae55c3bb5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -29,13 +29,17 @@ SAN_CFLAGS	?=
 SAN_LDFLAGS	?= $(SAN_CFLAGS)
 RELEASE		?=
 OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
+
+LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
 CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror 						\
-	  $(GENFLAGS) $(SAN_CFLAGS)					\
+	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.43.0


