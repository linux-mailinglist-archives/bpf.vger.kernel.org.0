Return-Path: <bpf+bounces-58708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A213AAC01CB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 03:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE11BA01F7
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 01:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A683B49625;
	Thu, 22 May 2025 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFGZ6rzg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B87464
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877903; cv=none; b=TzuloQW1+GoVcsHubQp8gQ4RRNrXunrGpNKrzHaIH6p2rU8KsF51WC8FTuyi6tP2cjxVP+EAxa8/5GMLTHl/aWM93N522Um/sVRbBWgO8+AV3KaGFKjY7OvBWO6TrMDfQAHhvtobyw5BNzt0bCrMRPMpaQ2yRLYmFN046NLj+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877903; c=relaxed/simple;
	bh=Pqz+gi5uCQji4FxW/zkW9ryaXb9M4Ti2yDQSz31TjSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mA5KSjDFyQvAlP1rZnYfTb8C7eCjwwDKiL4YMis9LxuqUmaExdLYyRyHxv/uq55svdWsSHbfWmT3molo16JmP8fruplqrA+MNytDdxkgm44zeHCFcxIH5AZBFDWFcd1K8DdJZXS+0dy/jxKq60AwfcrqFziTBGsxgMfy+qCSeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFGZ6rzg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso67419975e9.2
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 18:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747877900; x=1748482700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nu8uFNPkXhTvVbVWkq4SAjFV8yoxaN4uCkVfzuaqOQ=;
        b=IFGZ6rzgFG1fBS3UNuk3mVkoCDrSRZomHKCVQuSGpXL3mNOsmvQEskeyIwahSsnmn1
         nSo/65wZYhrwGYBEjz92i+3/HMkTKgSPTrXOfOCSUQLvfonpGDomYgxtWWbFO1095Woq
         II4ZTLZiftAyctYqF1X2pijxgnNMiWtUgwJGv61wttIulp+8SM5f7H51nac4cem5dnat
         IoUAIROwf4g5QONp+W9sqbSLWhoGztLVX/DakGj9NtVgWzv1M1SQh68jybAxCPlM8vk8
         b/b2MH3S2Slqju60Lqyg7gRBdFTop5EMrTpviDrRw1jxQvoTu1WQLf3Mp+jFtRs0OHgj
         SRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877900; x=1748482700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nu8uFNPkXhTvVbVWkq4SAjFV8yoxaN4uCkVfzuaqOQ=;
        b=UjJW9Z/F+mFtSfkPF8lq6D+9lZ7cgXMhgGtq8ujbW0LtbJiQsGBNcz2kI6fKN0JBo3
         My4T6XNSD4UHZGEjyc6kb4NDGmxjbPMgvMz6Bqh+fCzOKn9InKaH/1bZ9A8OsLLDWAms
         KsCMZ+7XjKU77iaA9WfGwR4RVYV2fzloDCfM10c2hN/T5nlWMjFlPiLtwhyLaw4J5xto
         04EaZ5jmsxqcwLI/MgeHtq2rmqH57PvA5X+G8EUQYZph8VAGZq8LE64ChgJ+4IAyXiY8
         PHBJYo3Yl6C3Kv6KJgW+yCF23amIcSgEj3QcItJdGDZ8gproErPLSSkpDQks9UP9AD5b
         4NgQ==
X-Gm-Message-State: AOJu0YxkO5y9DlUoNby3rgdywvGb2/NUmx3lpTnE2LkANLYy+/1MIlty
	3cCj/PujEoifkKFPVlNL4dlXokhkd9YBLju/jpjfFrrdmyjykDKJzmWqyHwYhg==
X-Gm-Gg: ASbGnctbbYJTw1QlIPlwSH9rg77W04muBi4uvYdNTH2eIPy6rNpQZuMSPP098Ke5c/G
	gzJbE4KGm3fKryN1/PzSdquyoKi9yqYV+skciV7ZG/N04SaZmjqdwHC3shRJOs/JxS61qlBaO7u
	D4S4zEGM4dt4Ei2R6p5T+38NBzVYMALm+mUdwywALHTqLNHrlFTdjBYqgRsFKtw++2OzwAz67Vw
	BfRnXurvqhiIT/jpT7JaPcA7MG8F0Eu9M1bnQKI3As2Imv8dydwtI8s2/h5QOpFBdjWBj6DHquD
	iy/XNkDcYKZKhjzdI+kF+Bjay1RAsSmI4fdBHJ/UghL59B6Efu96abLPy0MI/laRnOSsng==
X-Google-Smtp-Source: AGHT+IFltte/IRcgwcX0CkENlrczsgwTsFj8hlkWQyqV0sKcdJotaytlLl5ETtmS41GkS4NAX1is0g==
X-Received: by 2002:a05:600c:1e02:b0:442:f4d4:546 with SMTP id 5b1f17b1804b1-445e6f11da3mr133641245e9.1.1747877899431;
        Wed, 21 May 2025 18:38:19 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm91571855e9.6.2025.05.21.18.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:38:19 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: add SKIP_LLVM makefile variable
Date: Thu, 22 May 2025 02:38:13 +0100
Message-ID: <20250522013813.125428-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce SKIP_LLVM makefile variable that allows to avoid using llvm
dependencies when building BPF selftests. This is different from
existing feature-llvm, as the latter is a result of automatic detection
and should not be set by user explicitly.
Avoiding llvm dependencies could be useful for environments that do not
have them, given that as of now llvm dependencies are required only by
jit_disasm_helpers.c.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0d04cf54068e..ac2a8e4c8b6e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -34,6 +34,9 @@ OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
 LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
+SKIP_DOCS	?=
+SKIP_LLVM	?=
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -172,6 +175,7 @@ override OUTPUT := $(patsubst %/,%,$(OUTPUT))
 endif
 endif
 
+ifneq ($(SKIP_LLVM),1)
 ifeq ($(feature-llvm),1)
   LLVM_CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
@@ -187,6 +191,7 @@ ifeq ($(feature-llvm),1)
   endif
   LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 endif
+endif
 
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
-- 
2.49.0


