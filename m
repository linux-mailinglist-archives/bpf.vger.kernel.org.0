Return-Path: <bpf+bounces-28967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD33F8BEF18
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9300F283183
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53115E7FD;
	Tue,  7 May 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbCt4CZ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CE78C76
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118380; cv=none; b=nVew2HuLAs68ZSk0gB0JoYbr8cWuu2GHaPyuzwDXk6yyAVEpiqL+jMaXfXol5qZA2Y2y2/zFNZDX6wICoyAH4lzoucnVxov2MwMhDQ3wXAlxxjmJyXFBD+RviA5LNqSX9yI0O3nKSSh40v3QYMQHjyZsh4Z9VoI4i8HYZ2+5RFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118380; c=relaxed/simple;
	bh=GVSC37q+WVUBvHotgiC9ngmMYaMRXiMQyXyyILui2QY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXJL9oocXAhXveM1txosH30GkbDvuo4F9VTVuzqcJ/jgzGDymUfCyme8e6U/oLTUbn2gshVnE18ROVr3IZdFttySuyt1z+lGDf65O8r4n3n4rt16bqy2cQXmMz0KvLqqWzxlygNMTjaY667sIZFHZUx+RAacP8Scgu/M/08XlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbCt4CZ+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b432dfdcf6so3036474a91.3
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715118377; x=1715723177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DviObgEc5the5KsTWi1wuA8Jrbq5crnmfaITqe27r7c=;
        b=qbCt4CZ+bklyFSSW9hAZzEVD2hb+vUYovoFB6mo9TyF0prG9XbU9PPK5EhkJkasbra
         mYel77QzyGlU5cP+fICfhmbZ0eZ1b2mAFWOjxJyiv+cGqMoJ9Zjgqd3l6wUsfbVtxSjm
         SMRu6XHE2DIcc65kRWrRKaNRHK/V0ySJvCP7Mux2gcnpg+Lie7ckHLVZaO5cMU2oHDLr
         uFh6VIstiCfI/MwNref+XdABr0ZP69AFzsvI2A3rk0+E+QjVRMgEOFDCS9vI/fxFkoqk
         Tsh3Zs6tHNtCH+2ejoIrStJx722szFv09p4JIyryIzZyy9xbJJEAVR/SM7Cv+itpwoZm
         nFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118377; x=1715723177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DviObgEc5the5KsTWi1wuA8Jrbq5crnmfaITqe27r7c=;
        b=Ur68KOXKwoEKxxmaRZUkbtawRPZ2jbg07YVjB7oWsNLDRKfo+pdpldEGLFgJIxLqD5
         pSf+1No8D5CQxzttJb6RdgMkjZVjB4C0Nhrc5pgv7cDDaYgQUuWV+n4uJ64XkwSkJJVm
         1oKdHbSmU2G0UOLjfGGddiNumgUDhusX1G2oprS0P2jErj6vAG70ltjVM5DTiYXh6DST
         yhXu2XKKaKfypuyz6EsYzYG7vYpcb5aHiDLqComuEFgn+LzzsoDWmxGsD/dvkxqABVoe
         AdkJjncu/SjJeAUD4tq7WBsdvVWCUTircCu8WLac4V3L2KrB03wXz7cfhlBAibzjUkhx
         hfww==
X-Forwarded-Encrypted: i=1; AJvYcCWoNImkC8M+flD8gRG3a8n0AFcbPs6oGNkwFCqdMYchLsybb9kUzOfLSkRIh2253dGXznxE0SCAh54uny0CFUR/O5cV
X-Gm-Message-State: AOJu0YyAVqdSr8x06xYKeUd+oZgn31f4kSmgBkfsoHqCrDC0jaohImHA
	bEgwQ+SOjY0Dl9ukgtXnIhILmQgsqcIatv5hNeFX5kxa0/u5xc1Z3s1iza0VCqjZPT82zpMUy1r
	Zfg==
X-Google-Smtp-Source: AGHT+IEulH29x3uOVFbknFwsLl4WcM9naThMz9i2Ajy3QsMZqnbNUGap0hB8s9HU3OrwMNMNVbdGuRXxZUs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:5913:b0:29b:c2b7:7d29 with SMTP id
 98e67ed59e1d1-2b616ad9f91mr3776a91.9.1715118376985; Tue, 07 May 2024 14:46:16
 -0700 (PDT)
Date: Tue,  7 May 2024 21:38:28 +0000
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507214254.2787305-4-edliaw@google.com>
Subject: [PATCH v2 3/5] selftests: Include KHDR_INCLUDES in Makefile
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, 
	Bongsu Jeon <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add KHDR_INCLUDES to CFLAGS to pull in the kselftest harness
dependencies (-D_GNU_SOURCE).

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/alsa/Makefile                  | 2 +-
 tools/testing/selftests/arm64/signal/Makefile          | 2 +-
 tools/testing/selftests/exec/Makefile                  | 2 +-
 tools/testing/selftests/filesystems/overlayfs/Makefile | 2 +-
 tools/testing/selftests/hid/Makefile                   | 2 +-
 tools/testing/selftests/nci/Makefile                   | 2 +-
 tools/testing/selftests/prctl/Makefile                 | 2 ++
 tools/testing/selftests/proc/Makefile                  | 2 +-
 tools/testing/selftests/riscv/mm/Makefile              | 2 +-
 tools/testing/selftests/rtc/Makefile                   | 2 +-
 tools/testing/selftests/tmpfs/Makefile                 | 2 +-
 11 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 5af9ba8a4645..9a0ef194522c 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -6,7 +6,7 @@ LDLIBS += $(shell pkg-config --libs alsa)
 ifeq ($(LDLIBS),)
 LDLIBS += -lasound
 endif
-CFLAGS += -L$(OUTPUT) -Wl,-rpath=./
+CFLAGS += $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./
 
 LDLIBS+=-lpthread
 
diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..ae682ade615d 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..15e78ec7c55e 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index 56b2b48a765b..6c29c963c7a8 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -2,6 +2,6 @@
 
 TEST_GEN_PROGS := dev_in_maps
 
-CFLAGS := -Wall -Werror
+CFLAGS := -Wall -Werror $(KHDR_INCLUDES)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2b5ea18bde38..0661b34488ef 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -21,7 +21,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
 
-CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -g -O0 -rdynamic -Wall -Werror $(KHDR_INCLUDES) -I$(OUTPUT)
 CFLAGS += -I$(OUTPUT)/tools/include
 
 LDLIBS += -lelf -lz -lrt -lpthread
diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selftests/nci/Makefile
index 47669a1d6a59..bbc5b8ec3b17 100644
--- a/tools/testing/selftests/nci/Makefile
+++ b/tools/testing/selftests/nci/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDFLAGS += -lpthread
 
 TEST_GEN_PROGS := nci_dev
diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index 01dc90fbb509..1a0aefec9d6f 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -6,6 +6,8 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
 		disable-tsc-test set-anon-vma-name-test set-process-name
+
+CFLAGS += $(KHDR_INCLUDES)
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..9596014c10a0 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
+CFLAGS += $(KHDR_INCLUDES)
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..715a21241113 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += $(KHDR_INCLUDES) -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 55198ecc04db..654f9d58da3c 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
 LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = rtctest
diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..bcdc1bb6d2e6 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


