Return-Path: <bpf+bounces-45954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AE9E0DB0
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B910D28283E
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C81DF26D;
	Mon,  2 Dec 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOdUxjTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523691632E6
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174531; cv=none; b=JbdeILO27ORI72nYaGH6emRBWwoBePLLmbgaM4tzNJzwzQmaD7eVsqtwJcN3vbOHw74rr2Sdc5ud5rpBd9yy3/mm7BPNTZlUCVhzDR5iXiZRhA/dwdB2ABKxIaXvxkuvqhitkcbe+UWagg9GC8OMPNl/gntbW0xqDzeB4O1Dqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174531; c=relaxed/simple;
	bh=seqFRE9F0US+jXU21JwkoDvUPyV7SgmOqSk6lf7AcKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIgG88q9xjT3/ool9cif9AoWF2CN9IKM/oiRx8mEf+qF7780vULbLcOAygEY2CAPFtXfFuwon+QAouL+djTpztnxXnZs5nM/wPC9UlZfssGbwiIanDFcDr4bGG0etC9aOlvsSQ73eiPzeuq730SSQayS+w6GVFFBcSZ7Mm1hbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOdUxjTQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215348d1977so37587705ad.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174529; x=1733779329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VqImhnldQSP/pWdoPgR8o/s0E2cYjxhFdcW7Ss76Mo=;
        b=fOdUxjTQWbBemoOTMSFlLdw8KCOd2qcJQ8lJs1yseglrrTcTz5UbBybsvAL/NdZMXc
         DtTcGRAMCyE2oQNMSsnrT2IpgoKTIKoLNx3jWhAFXRDxQ8PXqg4QuczGJX1I8gsPt9+U
         iLmlp6L3k7UmwJ4+HnHW5DdaNfm7lWNeqNwGAlFLMeTtwvJ2p52VeMffPZUeT1bHPiO1
         UI9fiMKdwPMkGazFOB8XZzFA3YJj0OZq/5BLbjoKotftpZeRtKA+isMVSHR3eTpYCnMG
         ocbbeK0mh51n1dH13OnJYhjETaJv1Qq/isODe3b3ZOTAJfihenTQi2nVulJNxMSvToZx
         x9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174529; x=1733779329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VqImhnldQSP/pWdoPgR8o/s0E2cYjxhFdcW7Ss76Mo=;
        b=n95mg9ADyHRcENzLZkFB2tMWP33smpjI6L2IenIiFtzTYq/bZaD9wcoy2c/0Q6wTOU
         nOTx9tVKpIfZBnWViGWnHhy+kdcEt77pgdSIZP9bHf/P4Qtdu7ThTXIozPTHqg9tApuX
         Db96s++bC4CrCi9fzroMldStRzIPpW0/oCGPCICnoPm4+ZVgHaMOEPplBTfu0XV0kF8w
         1r+HdiBWqVf7bGYo/P6mCxBExvS6q2x1aue/jWOMkWLyJM4lXLNtp+vOqsoJeAt5RWJ1
         6IQ0WElgQHUG7sUsacpEpuiI7n4tT8ohcxFePUALuq20pCdTOXn4bMsuYvc3YhpjUGl/
         2JGg==
X-Gm-Message-State: AOJu0YyIGUjoNvPc2HONYitW8NlaSks0Z1WgiffiOHBkqhzz/aZh4d2+
	Gc88c4Qg7C9BNPvu5YymhteqMxeVzJa+YE7Ht6e9M+R5uMThvlC/yeoXIQ==
X-Gm-Gg: ASbGncu4fg3Zk3Gw7aKDHemnq6IcOcN1smzJDndKGlhibjE7aOdF8GXKly/C9JYzSPo
	JSKa5qltK1oBzIS+pmpBOx8VgnNMdWyubb4ErBumW1RrvWJ6d0z5PmkVntleeDtSnClwP12c52H
	sWMHoSsk15M89cRXaiF7Wrfp9oNgiKrqJ98l6STqIFK44U+EDuAV+gHfz2P27hHLnD3FAAu1Etv
	aJJqd9dlveIyB+CN34fagRmRIQ7FuRotuyBkMieGHUOYw==
X-Google-Smtp-Source: AGHT+IFCI/SHguixz5n85SROFGiHsExZgaTxGERkJqARYDTCXUYXs04XbTZnzOPusQnBK9pQd/tiPw==
X-Received: by 2002:a17:902:f64e:b0:215:aece:ed63 with SMTP id d9443c01a7336-215bd169072mr370235ad.44.1733174529107;
        Mon, 02 Dec 2024 13:22:09 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215413d3408sm64395145ad.159.2024.12.02.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:22:08 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	masahiroy@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] samples/bpf: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
Date: Mon,  2 Dec 2024 13:21:54 -0800
Message-ID: <20241202212154.3174402-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit [0] breaks samples/bpf build:

    $ make M=samples/bpf
    ...
    make -C /path/to/kernel/samples/bpf/../../tools/lib/bpf \
     ...
     EXTRA_CFLAGS=" \
     ...
     -fsanitize=bounds \
     -I/path/to/kernel/usr/include \
     ...
    	/path/to/kernel/samples/bpf/libbpf/libbpf.a install_headers
      CC      /path/to/kernel/samples/bpf/libbpf/staticobjs/libbpf.o
    In file included from libbpf.c:29:
    /path/to/kernel/tools/include/linux/err.h:35:8: error: 'inline' can only appear on functions
       35 | static inline void * __must_check ERR_PTR(long error_)
          |        ^

The error is caused by `objtree` variable changing definition from `.`
(dot) to an absolute path:
- The variable TPROGS_CFLAGS is constructed as follows:
  ...
  TPROGS_CFLAGS += -I$(objtree)/usr/include
- It is passed as EXTRA_CFLAGS for libbpf compilation:
  $(LIBBPF): ...
    ...
	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)"
- Before commit [0], the line passed to libbpf makefile was
  '-I./usr/include', where '.' referred to LIBBPF_SRC due to -C flag.
  The directory $(LIBBPF_SRC)/usr/include does not exist and thus
  was never resolved by C compiler.
- After commit [0], the line passed to libbpf makefile became:
  '<output-dir>/usr/include', this directory exists and is resolved by
  C compiler.
- Both 'tools/include' and 'usr/include' define files err.h and types.h.
- libbpf expects headers like 'linux/err.h' and 'linux/types.h'
  defined in 'tools/include', not 'usr/include', hence the compilation
  error.

This commit removes unnecessary -I flags from libbpf compilation.
(libbpf sets up the necessary includes at lib/bpf/Makefile:63).

[0] commit 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 samples/bpf/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index bcf103a4c14f..ee10dbf1b471 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -146,13 +146,14 @@ ifeq ($(ARCH), x86)
 BPF_EXTRA_CFLAGS += -fcf-protection
 endif
 
-TPROGS_CFLAGS += -Wall -O2
-TPROGS_CFLAGS += -Wmissing-prototypes
-TPROGS_CFLAGS += -Wstrict-prototypes
-TPROGS_CFLAGS += $(call try-run,\
+COMMON_CFLAGS += -Wall -O2
+COMMON_CFLAGS += -Wmissing-prototypes
+COMMON_CFLAGS += -Wstrict-prototypes
+COMMON_CFLAGS += $(call try-run,\
 	printf "int main() { return 0; }" |\
 	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
 
+TPROGS_CFLAGS += $(COMMON_CFLAGS)
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
@@ -229,7 +230,7 @@ clean:
 
 $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
 		LDFLAGS="$(TPROGS_LDFLAGS)" srctree=$(BPF_SAMPLES_PATH)/../../ \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
 		$@ install_headers
@@ -305,7 +306,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
-		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
+		     $(abspath $(if $(objtree),$(objtree)/vmlinux))		\
 		     $(abspath ./vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
-- 
2.47.0


