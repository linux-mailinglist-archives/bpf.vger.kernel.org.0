Return-Path: <bpf+bounces-58423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F2ABA469
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 21:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432311BC768F
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC46278767;
	Fri, 16 May 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+N46YOh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E0EEBA
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425341; cv=none; b=CIer5l3IW1mNQh0d8sopx9wsyf1vI51EZ4Vwa1Zk7G0OCW5uytCWRzYSryPj8pBM84HCVMfw0cwkOAACjsOYuUGPeAvPvJlXQJad1zRI7LrnZVmqM/sK2/uyJHG67epa9Q14f7q2aAxvx8QzIedxdavG5XeSQgvFooC2Ky9TXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425341; c=relaxed/simple;
	bh=2h3aLV2g5qJa1pMEAopHRVT74auE328VWFMUj9pi4xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psRFLCTArF7Mg2tzF0tR4Sy8pqrttuPRC9LjWJL8Kr/8hJvjDgLn3ReNHVgVkRKZSMzTybteUJrkajqDuuQnpRBjMc0y3l8I1T+CbUj/ldmfDIBih8zzE9z4riNLazRdNvH6+HhKZEPp9COrsfyQkFkJGUrnouCR4idrxiwQZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+N46YOh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edb40f357so18730675e9.0
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425338; x=1748030138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fT2RGC6cyAMP7apl6FsyuD73yZQpqghkRchcVnOfpfQ=;
        b=g+N46YOhxgjakHpADDJcjC7IQFGk+CJukwJ3+U/xF50rUjCTIS6InD8781arkLjG2O
         e5YlqkkmcYtMbrXoj9f0Bg41iSEyUdD7Fq891FQ0d6h5EJOzhF8wmVny+nsicj75IwYs
         7yuR0aFYcGsh447KNLLjOg39UV5bSwDae0NQMM+S1c0txdYvIV5tHIfqdnrkuDmwHEMD
         vYBdU+MDzXfxuGmePOcOmGt+mAosWm3K4Rrv5DdsE/xuoEUPkp4tNnDnoSHXga7XwXbB
         +ABf+yJfD98K1KItphM9TkPA6ZkC4prL25EAhH5FM2X1gIYLVO/zBbxyHEE70fg/TVt+
         +5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425338; x=1748030138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fT2RGC6cyAMP7apl6FsyuD73yZQpqghkRchcVnOfpfQ=;
        b=wumvgUBnDkJmuSLQFRZP1s3MtjRIv9n9tUSXK1ZphChC/Cw+HrRnDzFI3xxBGT7zho
         TTuUPPX7fBgBg/yAN6do+zNXIe/ZlXmvFOiR+cGPjQ9VXVw7drNjTo2+gJMx6A3m1wyv
         OaeveiN3ouzwiVn9n5Y/l+5fK7j6ka/vMuOiAjqhQq6w0vEqKy4mG9ObWTvyrj6jNJm+
         e1N6U/hhkN4CrbJ55zwoBaaNnOx6j3MjGY98AmfJ+Zwfi92jCJiBIl1ZkoKd2+HqVAtg
         wrLGizmp8bN+xiu/e9RJFtWt4vVvm8JUEznsXEhTtzYicc00m51GzHDhBONDLgDR7ni9
         2lyw==
X-Gm-Message-State: AOJu0Yz8xh1uRBTXR2wwfuX9qI+SFub1dXx/jEr+Q930csBUXywKLUs7
	6QxhWJu9DgGV7pHyuzNYnt9xOX+8vxa2XtjSEuEU/5vH/pY1fB1IHhDL0OfOVg==
X-Gm-Gg: ASbGncslY1trHGBOLghNkiu8N8yvFyXy5ylyVEO0WO8bCL2e51QQJo4W5MPr/6YZjaK
	0W9kkAU11gnJs9l0knN1IuvWZdkmqyjxo33dwLzVWYRvqNe+OPqoaf46QUn8TVRuo+PGjYo1on8
	4lyzONhxoW9BjKoYoOYdIZkATVp0Ps7xFF6WhrBip4I3Ow2iLvt8zemIphfNLIljUROWSiQw5Tx
	2IbD7JrRkB00olkTUyxMEGhi+LabHrzPKYCP3JVqmGYwggkBWp9iXVJOS+1huOG+coxYu/QmQCb
	lJyLqSicCDXDn1MutXYrbuKItzYU0ticcbMP72pp8dKcORoFLlkakkgzIuj6dsHfpA7r2A==
X-Google-Smtp-Source: AGHT+IHHQFfn+SeIbqcqJZGSVlI0LBLPusPT8tHxjbkVlK26S1FfHWtQQLC0FLz3tBHm6gu7V8VlHg==
X-Received: by 2002:a05:600c:1c03:b0:442:c98e:79ab with SMTP id 5b1f17b1804b1-442fd626edcmr43165525e9.9.1747425338171;
        Fri, 16 May 2025 12:55:38 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3648baa6asm1199731f8f.91.2025.05.16.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:55:37 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: remove unnecessary link dependencies
Date: Fri, 16 May 2025 20:55:22 +0100
Message-ID: <20250516195522.311769-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove llvm dependencies from binaries that do not use llvm libraries.
Filter out libxml2 from llvm dependencies, as it seems that
it is not actually used. This patch reduced link dependencies
for BPF selftests.
The next line was adding llvm dependencies to every target in the
makefile, while the only targets that require those are test
runnners (test_progs, test_progs-no_alu32,...):
```
$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS += $$(LLVM_LDLIBS)
```

Before this change:
ldd linux/tools/testing/selftests/bpf/veristat
    linux-vdso.so.1 (0x00007ffd2c3fd000)
    libelf.so.1 => /lib64/libelf.so.1 (0x00007fe1dcf89000)
    libz.so.1 => /lib64/libz.so.1 (0x00007fe1dcf6f000)
    libm.so.6 => /lib64/libm.so.6 (0x00007fe1dce94000)
    libzstd.so.1 => /lib64/libzstd.so.1 (0x00007fe1dcddd000)
    libxml2.so.2 => /lib64/libxml2.so.2 (0x00007fe1dcc54000)
    libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fe1dca00000)
    libc.so.6 => /lib64/libc.so.6 (0x00007fe1dc600000)
    /lib64/ld-linux-x86-64.so.2 (0x00007fe1dcfb1000)
    liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fe1dc9d4000)
    libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fe1dcc38000)

After:
ldd linux/tools/testing/selftests/bpf/veristat
    linux-vdso.so.1 (0x00007ffc83370000)
    libelf.so.1 => /lib64/libelf.so.1 (0x00007f4b87515000)
    libz.so.1 => /lib64/libz.so.1 (0x00007f4b874fb000)
    libc.so.6 => /lib64/libc.so.6 (0x00007f4b87200000)
    libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f4b87444000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f4b8753d000)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0d04cf54068e..27db3bf20c21 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -180,7 +180,7 @@ ifeq ($(feature-llvm),1)
   # Prefer linking statically if it's available, otherwise fallback to shared
   ifeq ($(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && echo static),static)
     LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
-    LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
+    LLVM_LDLIBS  += $(filter-out -lxml2,$(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS)))
     LLVM_LDLIBS  += -lstdc++
   else
     LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM_CONFIG_LIB_COMPONENTS))
@@ -675,9 +675,6 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
 	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif
 
-$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS += $$(LLVM_LDLIBS)
-$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS += $$(LLVM_LDFLAGS)
-
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
@@ -688,7 +685,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(OUTPUT)/veristat				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
-- 
2.49.0


