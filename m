Return-Path: <bpf+bounces-45966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7859E0F63
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F6A1653F5
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE11DF988;
	Mon,  2 Dec 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8lf2kfy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6961FD7
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183279; cv=none; b=lbc6l1yM2yt/6Vq6s+7ckm7qSu1ej57HdXDvezla+J25agp5QeLjQjGVmwh58ME8nlzCqWlAwEV8yXpfrMCtj48m2lTv+93TtU3zv5fSIDB9GfrT5yoZnh3G1SGh56S0dGyVezDwNds1irDrGwT1aceqOABnFsHA2D/coukXmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183279; c=relaxed/simple;
	bh=4JkzxpxVfqo1s5Yn+5tMpq6g0tW/iFWTP/ocQw1bWBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOtww7cmtAiI1yDCgit+64tvBcAcKLutV9fsg7/ESiLyiYJT/sGaXhtmN0pyQ4ztKQdGXyt9tbGPUGz3lRKy0iTXwB0+pG9UqAKBEPIaC2QcFupV7+EVZ0IhBti9K/t8/JTGm+GBYmiz/bnEOI4ge2uwDeaCuxBRxT8YcYF6baU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8lf2kfy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7252b7326f4so4181087b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733183277; x=1733788077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVOCARIRMCSzq70Ikj0pF5UOZuvB0RdoBkFHsBdFKHA=;
        b=N8lf2kfyJLAh7tA3ESMQufyyKHyFzSbcqs6jrus2AjlCc3SEXCud3Xa+iyrXco31vv
         CpaJuW5yA7EbRR086bEH6flVzY2NogvC7JwGTf870fVkJ81vBNoepsPDxd3Q++zFkaxz
         3vdsHzokfOvxme4a6+UkRvZfVkx+/vRWYGhuZjwBv8Asdzorn7LoOL/oyskfF0lq5KWa
         l1uKiRAT8xPyL5YWnfcZwc4mnp+4vGQIG9DseFJbyIlp/wOWoFVp2Z9xI/o3XpEuSA/U
         gg0m8secSrvDkCBFjw2E1jWEoqDnBoDaUSQ1CMLf1n23pVOp8H3X1ycLIZ848mEthllx
         xYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733183277; x=1733788077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVOCARIRMCSzq70Ikj0pF5UOZuvB0RdoBkFHsBdFKHA=;
        b=YTb1D1IFnuDE2w9XcozxotXVgUXMN4rKDkId07N7+8/dhEPxpQ4JZ3qL7jqWOYIBqm
         7uuWJAB9hCwOCXjsNe3cvgSm5CaLmgRPm4iZDOH7AM1Hqq3JW+Fd2lgYdPNOAYjhVJZK
         jfDhXZmp0DaB1advg01yM/qj/chfouWkEyoePxxUZZ4TBUvDB4eGNscuM9/iv7q1yXt2
         CCyWUJ1yO/ML0zx+dhpcMt5ZqVcMA82gnSD8IJZ48ehwmm/xTFbSGuIu7jZIZY95FSCN
         ehn0ZnZjiORbc7IYV3x7OTo/QZe52+y8Ot8Gp1AOqMJ+lEQ+eHh0qh6ZedsRKuveaAfv
         V1tQ==
X-Gm-Message-State: AOJu0Yw+6cGLfW0J0W1LApcj8rzq3QmQzlUOZIC5EUuWPVTq6bAz1a7G
	Ho6lcP1N0nVXgGTMvCwvVqT5grQ/CYlOZMmjwEIWY+Xl+osoUhkg5SynUw==
X-Gm-Gg: ASbGncv13V54q3RsEqkflZYlCQ9OmHUhdxZGBNd2MroRhPBgZjq9uhDWuL4k5kM2nFm
	8O9S1UoR/R8hAM+BCx4xcIDuDjq9Rxn/BhMufZ/qzj5H09F+afIl39bDpNMuqczrf7wvQ9Vsvgl
	K89aV5IKNT01cGrDZJReD1yt+CG6/ojVziUhDWOO+PmqwEPZCoUoTGSz8qEojTIitzMabEZjGMG
	OXru0EtOYsj/rPDbQPFUNCgcoN6oQOSHFQ8yXCtSq2Lsw==
X-Google-Smtp-Source: AGHT+IEa6L/YudwrWBDbH2t6O1b/GbZR89DCZ+AS/0i9afAlbDeMgA1GP0d6h4YmWWXenJ9uiumsjQ==
X-Received: by 2002:a17:90b:52c4:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2ef0121357amr775801a91.17.1733183276146;
        Mon, 02 Dec 2024 15:47:56 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b2a2d05sm8803964a91.36.2024.12.02.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:47:55 -0800 (PST)
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
Subject: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
Date: Mon,  2 Dec 2024 15:47:41 -0800
Message-ID: <20241202234741.3492084-1-eddyz87@gmail.com>
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

Changes v1 [1] -> v2:
- dropped unnecessary replacement of KBUILD_OUTPUT with $(objtree)

[0] commit 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
[1] https://lore.kernel.org/bpf/20241202212154.3174402-1-eddyz87@gmail.com/

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 samples/bpf/Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index bcf103a4c14f..44f7e05973de 100644
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
-- 
2.47.0


