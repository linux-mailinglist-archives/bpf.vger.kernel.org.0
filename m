Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4261C13C5AB
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 15:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgAOOM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 09:12:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729276AbgAOOM6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=g0l5NcBL4robvC+8Ghw21Zaj6uU+qkMDuP5TnCrX67cIlAngys2KLNYqK0Ns0zyA6l4Xbo
        7mhEgA2xoIJ7Ttwr+08v8w0/kv9rRg4LCiekf2IxDEA09vKofk7czi2ftKh3aMDdTVnmDf
        fFrsxgZfcL6NQsXNa+R+nYjTSIcg1u0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-SLkzbiH3NraxkhzOdEFPnA-1; Wed, 15 Jan 2020 09:12:55 -0500
X-MC-Unique: SLkzbiH3NraxkhzOdEFPnA-1
Received: by mail-lj1-f198.google.com with SMTP id t11so4186088ljo.13
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 06:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B9j+W7gDIaDJz39H0dsQUAJSNrjtTec2FhMoAkHknrs=;
        b=b9P3aoNB6M83eURIJ351Ibd4zPr+0WwEcMzfdwYv9H8xY7Vslm6L/tyP8eCdgyfAIF
         dfHk8SsEMVdaexq5+CDx2yAqNkW+aFraGqMBzaG2RbauXyZvo7Vk2q998WzViRQuvRj+
         8UqUtvCzLMHJgxEQFvgZc4TneJCxRMoNQBUAebV6kFj4u782RpaCXX5kgX7hvAU4iUDd
         zd9+PHFZ5pPGyC8zj7pLZrO/rEH5EFFGKdg/vKBj/jvSuUCoh3HwUAVnHRQQPfemd68X
         TZNN3pKH2TtnfU61l/gBg8HbEACSLY++MG7mKx5p/SOT9WKm4m47tWunIfHFfCkolVgf
         bm3A==
X-Gm-Message-State: APjAAAX1SwptVnp61DRDugR4aeArwjnTPTPMlxG8M5BsplsqB4iN2KcF
        +Lz/5QptwCxbO5kiZcOa0qDuluU23uIgSxPal5w1yDuOCNahL06sLj1AxdRLdcSE2XW6jl10TVI
        Yuhg3LTTQQvWg
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772078ljn.118.1579097574010;
        Wed, 15 Jan 2020 06:12:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUW0Ep6uEXtLij//fHtTp+5adTa9pXL0f4oBHP8qleNZhf8ZN29IWsfrnAs2scQN/yNWVb2Q==
X-Received: by 2002:a2e:a37c:: with SMTP id i28mr1772066ljn.118.1579097573864;
        Wed, 15 Jan 2020 06:12:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p136sm9082048lfa.8.2020.01.15.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:12:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EE0AE1804D8; Wed, 15 Jan 2020 15:12:50 +0100 (CET)
Subject: [PATCH bpf-next v2 02/10] tools/bpf/runqslower: Fix override option
 for VMLINUX_BTF
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Wed, 15 Jan 2020 15:12:50 +0100
Message-ID: <157909757089.1192265.9038866294345740126.stgit@toke.dk>
In-Reply-To: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
References: <157909756858.1192265.6657542187065456112.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The runqslower tool refuses to build without a file to read vmlinux BTF
from. The build fails with an error message to override the location by
setting the VMLINUX_BTF variable if autodetection fails. However, the
Makefile doesn't actually work with that override - the error message is
still emitted.

Fix this by only doing auto-detection if no override is set. And while
we're at it, also look for a vmlinux file in the current kernel build dir
if none if found on the running kernel.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..fb93ce2bf2fe 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,12 +10,16 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+ifeq ("$(VMLINUX_BTF)","")
+  ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
+  VMLINUX_BTF := /sys/kernel/btf/vmlinux
+  else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
+  VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
+  else ifneq ("$(wildcard $(abspath ../../../vmlinux))","")
+  VMLINUX_BTF := $(abspath ../../../vmlinux)
+  else
+  $(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+  endif
 endif
 
 abs_out := $(abspath $(OUTPUT))

