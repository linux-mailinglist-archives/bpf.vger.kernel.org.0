Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02629EF5E
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 16:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgJ2PMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 11:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbgJ2PMX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 11:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603984341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7X83YXQrTBsbNhEbcdOm/nIWlpTd9yUgaPY4aMl/O4=;
        b=e85CgdFHuLa2jVuVU4bP6SytsAvsBnnA/QZsk9Y0MAwOgm4qEYeS8kURB/us7f5MQ8WXjb
        pftfv4VGuZmFVNFGS2zbirAXvTNFB1AvI5a8SDSN8umcFa7eky3iyIXe2CQYCCHgZn4tz7
        2+GvPjT3svyMLPcYKcn3BHmMS6LuGy0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-sHrk7YwFNS2gSO5vbZQN2w-1; Thu, 29 Oct 2020 11:12:19 -0400
X-MC-Unique: sHrk7YwFNS2gSO5vbZQN2w-1
Received: by mail-pg1-f200.google.com with SMTP id t12so2330531pgv.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 08:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7X83YXQrTBsbNhEbcdOm/nIWlpTd9yUgaPY4aMl/O4=;
        b=Rkar2kPCBWu8Eo3GUYpfGChL26uhzEEGTKgB2aCnzYIeIY2hQy2/zUns/QMQPF8GFf
         v5skEXVV4+45WXs/hkthCglYpeTyqnR2cxKc4nsr3EiGpbmGcNSkMc2LDypbxkzkvKeq
         B7tXncyJ/nVrlm40l8iQlzUXLtUl5S8Zyq4lTNIdHCgyrGfRAioOLMeZRTomtTz/ssdI
         Wn239GJ198DwZVAhYsuL0JlSljEPvylHor4+g93+CI9Q1GoOds2w4iWzwjdEKsIdB6+D
         U5D58qh4WbTN7iec/yRirUWvtqldz7RW+gOsq2aSwJWG2piSKV6pBn539UqvrWbkNgmt
         zSIg==
X-Gm-Message-State: AOAM533jPdLM8O9vouv7Rh+EepKpieKdLVnNA6OSak3u3sxrk4G3M8lq
        9JEuu7L2nLMGWppDCiAApUDp9G4dj0YbqY3CfL4jDD+LiREyHp+448NIn+XW3PNCXTKJlQPrz78
        syYIjo68KzpE=
X-Received: by 2002:a17:902:7d90:b029:d6:3192:2bd3 with SMTP id a16-20020a1709027d90b02900d631922bd3mr4361140plm.72.1603984338618;
        Thu, 29 Oct 2020 08:12:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1E6maO/HYwqFo9TKa1dLEn4n2I5o7JBwIdJdnisPK7QLxK5DW63G0UNQJ649W4ge3LtIpZg==
X-Received: by 2002:a17:902:7d90:b029:d6:3192:2bd3 with SMTP id a16-20020a1709027d90b02900d631922bd3mr4361117plm.72.1603984338404;
        Thu, 29 Oct 2020 08:12:18 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 3sm3305435pfv.92.2020.10.29.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:12:17 -0700 (PDT)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv3 iproute2-next 2/5] lib: rename bpf.c to bpf_legacy.c
Date:   Thu, 29 Oct 2020 23:11:43 +0800
Message-Id: <20201029151146.3810859-3-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201029151146.3810859-1-haliu@redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a preparation for later libbpf support in iproute2. Function
bpf_prog_load() is also renamed to bpf_prog_load_buf() as there is a
conflict with libbpf.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 include/bpf_util.h          | 6 +++---
 ip/ipvrf.c                  | 4 ++--
 lib/Makefile                | 2 +-
 lib/{bpf.c => bpf_legacy.c} | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename lib/{bpf.c => bpf_legacy.c} (99%)

diff --git a/include/bpf_util.h b/include/bpf_util.h
index 63db07ca..72d3a32c 100644
--- a/include/bpf_util.h
+++ b/include/bpf_util.h
@@ -274,9 +274,9 @@ int bpf_trace_pipe(void);
 
 void bpf_print_ops(struct rtattr *bpf_ops, __u16 len);
 
-int bpf_prog_load(enum bpf_prog_type type, const struct bpf_insn *insns,
-		  size_t size_insns, const char *license, char *log,
-		  size_t size_log);
+int bpf_prog_load_buf(enum bpf_prog_type type, const struct bpf_insn *insns,
+		      size_t size_insns, const char *license, char *log,
+		      size_t size_log);
 
 int bpf_prog_attach_fd(int prog_fd, int target_fd, enum bpf_attach_type type);
 int bpf_prog_detach_fd(int target_fd, enum bpf_attach_type type);
diff --git a/ip/ipvrf.c b/ip/ipvrf.c
index 28dd8e25..33150ac2 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -256,8 +256,8 @@ static int prog_load(int idx)
 		BPF_EXIT_INSN(),
 	};
 
-	return bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
-			     "GPL", bpf_log_buf, sizeof(bpf_log_buf));
+	return bpf_prog_load_buf(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
+			         "GPL", bpf_log_buf, sizeof(bpf_log_buf));
 }
 
 static int vrf_configure_cgroup(const char *path, int ifindex)
diff --git a/lib/Makefile b/lib/Makefile
index 7cba1857..a326fb9f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@ CFLAGS += -fPIC
 
 UTILOBJ = utils.o rt_names.o ll_map.o ll_types.o ll_proto.o ll_addr.o \
 	inet_proto.o namespace.o json_writer.o json_print.o \
-	names.o color.o bpf.o exec.o fs.o cg_map.o
+	names.o color.o bpf_legacy.o exec.o fs.o cg_map.o
 
 NLOBJ=libgenl.o libnetlink.o
 
diff --git a/lib/bpf.c b/lib/bpf_legacy.c
similarity index 99%
rename from lib/bpf.c
rename to lib/bpf_legacy.c
index c7d45077..2e6e0602 100644
--- a/lib/bpf.c
+++ b/lib/bpf_legacy.c
@@ -1109,9 +1109,9 @@ static int bpf_prog_load_dev(enum bpf_prog_type type,
 	return bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
 }
 
-int bpf_prog_load(enum bpf_prog_type type, const struct bpf_insn *insns,
-		  size_t size_insns, const char *license, char *log,
-		  size_t size_log)
+int bpf_prog_load_buf(enum bpf_prog_type type, const struct bpf_insn *insns,
+		      size_t size_insns, const char *license, char *log,
+		      size_t size_log)
 {
 	return bpf_prog_load_dev(type, insns, size_insns, license, 0,
 				 log, size_log);
-- 
2.25.4

