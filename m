Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4566213DB9B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPNXV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 08:23:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgAPNWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 08:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzqQE7mWfqS9gbpZpl6m88cnGx3MlkQu/XGO40kZXJg=;
        b=hjIiv/NEGtOQzkxuzUnOFJ+y9lZYIiSgMYufe4/BLirwTe8zVVjeV6n/ZGIhZnNWZzx/rS
        VaZKBY/3HyNzD2ckVyWJlcYaLeMy7V8WnXWs2bYIQB20NUzEWt2IHl4CNA7pTKPVLZ9AdX
        8+CzjK/gpf/6DQ+ftqfcvV0Kcd3mFsw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-saHxcR4SPjuBts4EI43wSQ-1; Thu, 16 Jan 2020 08:22:17 -0500
X-MC-Unique: saHxcR4SPjuBts4EI43wSQ-1
Received: by mail-lj1-f198.google.com with SMTP id f15so5151757ljj.11
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 05:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gzqQE7mWfqS9gbpZpl6m88cnGx3MlkQu/XGO40kZXJg=;
        b=iLz6XJDL3wnGXKCg4EbvIa1VTnjkdIeKthsDHvJ13D+Yqew6gSdt4v7yXTQpnEC958
         65QY8Mkx64NQXuriniSGjogGQ2uCFC0TeTSijiUe2kwHFWruC9qcU3bNh8/ZmVagtjbY
         ol5HW+ByC/nie+LTv7HsUov9VFCiGI+Wzt3UUk2ENUzlSQaacBqCtidt9BYMRCG/5skz
         2gDv9HY2JpmpTdiUkrBDNWEOO3u9sDUczEIrSCFWEn4L8JcahUXTpBqU3k6HUc3IkDsb
         AbeKxYlqnkAUwNy5d5jjgFaGM5/ACaeJs45IaV3w0hFAnH//EHCyxb05whU74pLzfOWB
         TXIQ==
X-Gm-Message-State: APjAAAWRc6fMMIzLp4SK7LdXI/opXm2IqIWtyMDFzOUxKcakRl1Q9/zb
        vpebFPhs83AHkQf9s/DWuolZG2lKCy+QupxuCwmm4a1UF3ylOIMhakg6pZdmdkRMAB+bUtE0xnQ
        D0SlZ0RFzFz8t
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr2305753ljs.248.1579180936042;
        Thu, 16 Jan 2020 05:22:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFm8TdvoRQDWtY2lKrbQQl1O6xAPqlYnDABHlUDuyNgLz95SjjEtdQljJ8ty7d3yotxnb3Rg==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr2305732ljs.248.1579180935891;
        Thu, 16 Jan 2020 05:22:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n3sm10612990lfk.61.2020.01.16.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:22:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 03CC51804D8; Thu, 16 Jan 2020 14:22:14 +0100 (CET)
Subject: [PATCH bpf-next v3 02/11] tools/bpf/runqslower: Fix override option
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
        Jakub Kicinski <kuba@kernel.org>,
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
Date:   Thu, 16 Jan 2020 14:22:13 +0100
Message-ID: <157918093389.1357254.10041649215380772130.stgit@toke.dk>
In-Reply-To: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk>
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

Fix this by including the value of VMLINUX_BTF in the expansion, and only
emitting the error message if the *result* is empty. Also permit running
'make clean' even though no VMLINUX_BTF is set.

Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index cff2fbcd29a8..89fb7cd30f1a 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -10,12 +10,14 @@ CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source
 KERNEL_REL := $(shell uname -r)
-ifneq ("$(wildcard /sys/kernel/btf/vmlinux)","")
-VMLINUX_BTF := /sys/kernel/btf/vmlinux
-else ifneq ("$(wildcard /boot/vmlinux-$(KERNEL_REL))","")
-VMLINUX_BTF := /boot/vmlinux-$(KERNEL_REL)
-else
-$(error "Can't detect kernel BTF, use VMLINUX_BTF to specify it explicitly")
+VMLINUX_BTF_PATHS := $(VMLINUX_BTF) /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
+VMLINUX_BTF_PATH := $(firstword $(wildcard $(VMLINUX_BTF_PATHS)))
+
+ifeq ("$(VMLINUX_BTF_PATH)","")
+ifneq ($(MAKECMDGOALS),clean)
+$(error Could not find kernel BTF file (tried: $(VMLINUX_BTF_PATHS)). \
+	Try setting $$VMLINUX_BTF)
+endif
 endif
 
 abs_out := $(abspath $(OUTPUT))
@@ -67,9 +69,9 @@ $(OUTPUT):
 	$(call msg,MKDIR,$@)
 	$(Q)mkdir -p $(OUTPUT)
 
-$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF) | $(OUTPUT) $(BPFTOOL)
+$(OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(OUTPUT) $(BPFTOOL)
 	$(call msg,GEN,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
 
 $(OUTPUT)/libbpf.a: | $(OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \

