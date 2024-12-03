Return-Path: <bpf+bounces-46023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC29E2AB5
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 19:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4B1166ABF
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01801FCCE0;
	Tue,  3 Dec 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwvyDXcy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610661FA16E
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250165; cv=none; b=arKdgB/FHznVuEG560wLQBSQv0sr4ixkd+x85P5iP3fsNj0b8ReUZnFB7AlsqiArpmv3FikyDiWIVR8FOVgKkiqR8c3TK3Q+RKlWylFXLC/6xgHO5zn6CGSlMdldIgMDgTAfL9nwG/iUHGORxE12WK5lKYS6FwYmuJS5p1NvYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250165; c=relaxed/simple;
	bh=oPlfCwv7dFgg5nfzz3sCeEFTDYmqgtTKzCZhiUaPBUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmQWleTQLmR5aOp4prhj/WtCiY0tSEqHzwb4mbD62DenEm+bT+5qPL8/ladrX9wjqaw0Q79gjBhTtawvzsU/XZNXS+lnLc5AybOj4Nh9D4FMlrzWTvrGRVo1jp1tJ2yHUWv4mPdruglVnnKeoDm1/c3TbMfjlxW6LZvRh1TINUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwvyDXcy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso23179205ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 10:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733250162; x=1733854962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt7EgOueeZPP9i7HIXoMixPag6gc+rZDJdNn0ad5OtU=;
        b=AwvyDXcySILkOwt/gDYT4GH079bI7X5UPPEhlUCHhwGvG/5s+rUnt0pqIK5vQmBYwP
         QpN4L2I+Bzhx/tNDxITJNCon5lLRnvOP5Mnw0d/FAOxQa1pf/dcIBuatyM/UBEEmiQML
         rIooNj0KKDf2CSqZKni+DYbfbsCb0z3zi3qpmbp/KWfryHLmAKO3Lv2kxz7EfuOIl0CQ
         PoMSIjaPWam/Dl9m6wF+aGGfhWT/d1uY9quT72opyWeb7+4iyqfkvw+Jn6VinM8MptMf
         XsXB5sl5TuOPGWUII2G779NvycTuDwejg04o6mkYx+nyRP8wvEq6tgM5Fq2yL8J02kox
         PDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250162; x=1733854962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt7EgOueeZPP9i7HIXoMixPag6gc+rZDJdNn0ad5OtU=;
        b=nqnp6I60WTC3IaXO2s0WiapcILjbXxG5VmoiLyIbeWTEKoyukqIQuwrkkbQZYF+PzZ
         LJ7SiWHHzHY4HZCY8DfUHjmlxnf4AfYRApETsxqGL6oHncu3aHGRjMrDkEWFwpHwkZJ6
         t//c/0htyWWLOPqpvfY/OWF3oul7HlBFHM2jlECWaJL4+FanBUn8QQ7Dk0eMw438WLFx
         3mUB13LdiZW1COjYFup05NC+N9vGxlXLSG7mZFoLVqxZsRm7OhxeG8EWZXVCwVGOpaMZ
         bWAHqDIFBvBnolW0fqdlPkOmq37YSLLo3lMV86qZldEe+Koedar8R0ZmgTjr05Z00qVG
         kaXA==
X-Gm-Message-State: AOJu0YyEcE51eXFv6CbZpDZdAEw7EqgsFTZOV+TODmMy0Z+cgcaSaSAV
	E2jsP0PDvMhzirG1B8L+/nkFwRN9b9oppDeojJtYrrc5Vp5HuxmhLgp8Fw==
X-Gm-Gg: ASbGnctTrT5OiNOZ2inIHAVogVmpN/goDiQ3SA/r0krjPG9M30uQZxGS6dFN7qKx7yv
	be7+0TFhGVUnNbniw9HnoEWTDTPbw+4nIFyu9Oot8dq0EhslZjkG+tBflZq/z0YAGMIdTyKGCW0
	0QInwlaXHPpV1hsSbr6lP3z16UVGhxvZA8cBHC49RTwGifwoNpsHVIsPrN6vcWJqse7kCpuM5sE
	RnEQdW3KMrSPTi5M9G5pn+OicynCb2i3MC0XBp/JAc4Gg==
X-Google-Smtp-Source: AGHT+IEFF6mZDK0JiwE0zPEFuNnXNYM/7GqPcWW8zIAnjsJH2W/6lfeKovtvY1lEQwLt7fBSsD3vqA==
X-Received: by 2002:a17:902:ccd2:b0:215:8ca3:3bac with SMTP id d9443c01a7336-215bd0d7646mr49679015ad.16.1733250162348;
        Tue, 03 Dec 2024 10:22:42 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153bad2480sm83772285ad.75.2024.12.03.10.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 10:22:41 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	masahiroy@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf v3] samples/bpf: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
Date: Tue,  3 Dec 2024 10:22:22 -0800
Message-ID: <20241203182222.3915763-1-eddyz87@gmail.com>
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
  (Andrii)
Changes v2 [2] -> v3:
- make sure --sysroot option is set for libbpf's EXTRA_CFLAGS,
  if $(SYSROOT) is set (Stanislav)

[0] commit 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
[1] https://lore.kernel.org/bpf/20241202212154.3174402-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20241202234741.3492084-1-eddyz87@gmail.com/

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 samples/bpf/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index bcf103a4c14f..96a05e70ace3 100644
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
@@ -162,7 +163,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib
 TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
 
 ifdef SYSROOT
-TPROGS_CFLAGS += --sysroot=$(SYSROOT)
+COMMON_CFLAGS += --sysroot=$(SYSROOT)
 TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
 endif
 
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


