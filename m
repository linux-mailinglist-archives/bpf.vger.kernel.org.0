Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5D95DBD
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfHTLr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 07:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfHTLr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 07:47:58 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A098772C8
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 11:47:57 +0000 (UTC)
Received: by mail-ed1-f71.google.com with SMTP id b12so3981141ede.23
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 04:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Q1qrlAdUBdtgFmvbsxp+7Weq0kJqK392jTB9uYB4xI=;
        b=cMGCrZBHvIAI7rWi+bFRqblf5VkBDp4hjBVSFODASnWc1SvajN2Z2f2yqC2x0n4U/Q
         pjjXW3uXm0cDHAo3SBixoK1JVWCXxkOT2e7ei0JI0HA/USVhVDfUZ9t6jFsHOLCIfios
         bcLC0PRYtcY7eThUQXF8tcIPXYqqKq9/jHd3LEo1q+7/9a/jzl+68dZsQ4ZAr9AX4yXF
         Kt2xQ/Air+DKLj7gnVjD4kzBXPPW6f2mxuMhNpAyifObbGcecCQrCWfDz/7QoZzmOHsj
         dNuovPBv8mfJPHfjQ6KXvNQmhpCH8b59oZDnz4BgRxQQR+Gh28+3nIUt49WZvr8AUo8n
         br7g==
X-Gm-Message-State: APjAAAVWKfzUrhO2bDjKzHGPixcCCGRQpalkdn6xxXYIYg0Hl3MjZD/5
        ubDZ79VdgWPqX4YgJRYTiUAWJGHv4aWintZ4DoXA6xM4ILgKzdQUno4cT6f+x08i0wHUbnXlWwZ
        uhyeTZdRHuOck
X-Received: by 2002:a17:907:208f:: with SMTP id pv15mr26044513ejb.103.1566301675809;
        Tue, 20 Aug 2019 04:47:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyb1PXS1EQ8E9/W1RIPAV1tDZhi4iClQtwls/l4LnIXXpYM0eoe6/Dm8uCP0u/xLRD5+lXTpg==
X-Received: by 2002:a17:907:208f:: with SMTP id pv15mr26044489ejb.103.1566301675592;
        Tue, 20 Aug 2019 04:47:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f22sm3394391edr.15.2019.08.20.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 04:47:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5EF8D181CE4; Tue, 20 Aug 2019 13:47:54 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC bpf-next 4/5] iproute2: Allow compiling against libbpf
Date:   Tue, 20 Aug 2019 13:47:05 +0200
Message-Id: <20190820114706.18546-5-toke@redhat.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190820114706.18546-1-toke@redhat.com>
References: <20190820114706.18546-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds a configure check for libbpf and renames functions to allow
lib/bpf.c to be compiled with it present. This makes it possible to
port functionality piecemeal to use libbpf.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 configure          | 16 ++++++++++++++++
 include/bpf_util.h |  6 +++---
 ip/ipvrf.c         |  4 ++--
 lib/bpf.c          | 33 +++++++++++++++++++--------------
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 45fcffb6..5a89ee9f 100755
--- a/configure
+++ b/configure
@@ -238,6 +238,19 @@ check_elf()
     fi
 }
 
+check_libbpf()
+{
+    if ${PKG_CONFIG} libbpf --exists; then
+	echo "HAVE_LIBBPF:=y" >>$CONFIG
+	echo "yes"
+
+	echo 'CFLAGS += -DHAVE_LIBBPF' `${PKG_CONFIG} libbpf --cflags` >> $CONFIG
+	echo 'LDLIBS += ' `${PKG_CONFIG} libbpf --libs` >>$CONFIG
+    else
+	echo "no"
+    fi
+}
+
 check_selinux()
 # SELinux is a compile time option in the ss utility
 {
@@ -386,6 +399,9 @@ check_selinux
 echo -n "ELF support: "
 check_elf
 
+echo -n "libbpf support: "
+check_libbpf
+
 echo -n "libmnl support: "
 check_mnl
 
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
index 43366f6e..1d1aae6f 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -256,8 +256,8 @@ static int prog_load(int idx)
 		BPF_EXIT_INSN(),
 	};
 
-	return bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
-			     "GPL", bpf_log_buf, sizeof(bpf_log_buf));
+	return bpf_prog_load_buf(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
+				 "GPL", bpf_log_buf, sizeof(bpf_log_buf));
 }
 
 static int vrf_configure_cgroup(const char *path, int ifindex)
diff --git a/lib/bpf.c b/lib/bpf.c
index 7d2a322f..c6e3bd0d 100644
--- a/lib/bpf.c
+++ b/lib/bpf.c
@@ -28,6 +28,11 @@
 #include <gelf.h>
 #endif
 
+#ifdef HAVE_LIBBPF
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#endif
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/un.h>
@@ -795,7 +800,7 @@ out:
 	return mnt;
 }
 
-static int bpf_obj_get(const char *pathname, enum bpf_prog_type type)
+static int bpf_obj_get_path(const char *pathname, enum bpf_prog_type type)
 {
 	union bpf_attr attr = {};
 	char tmp[PATH_MAX];
@@ -814,7 +819,7 @@ static int bpf_obj_get(const char *pathname, enum bpf_prog_type type)
 
 static int bpf_obj_pinned(const char *pathname, enum bpf_prog_type type)
 {
-	int prog_fd = bpf_obj_get(pathname, type);
+	int prog_fd = bpf_obj_get_path(pathname, type);
 
 	if (prog_fd < 0)
 		fprintf(stderr, "Couldn\'t retrieve pinned program \'%s\': %s\n",
@@ -1036,7 +1041,7 @@ int bpf_graft_map(const char *map_path, uint32_t *key, int argc, char **argv)
 		}
 	}
 
-	map_fd = bpf_obj_get(map_path, cfg.type);
+	map_fd = bpf_obj_get_path(map_path, cfg.type);
 	if (map_fd < 0) {
 		fprintf(stderr, "Couldn\'t retrieve pinned map \'%s\': %s\n",
 			map_path, strerror(errno));
@@ -1105,9 +1110,9 @@ static int bpf_prog_load_dev(enum bpf_prog_type type,
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
@@ -1284,7 +1289,7 @@ static int bpf_btf_load(void *btf, size_t size_btf,
 	return bpf(BPF_BTF_LOAD, &attr, sizeof(attr));
 }
 
-static int bpf_obj_pin(int fd, const char *pathname)
+static int bpf_obj_pin_fd(int fd, const char *pathname)
 {
 	union bpf_attr attr = {};
 
@@ -1433,7 +1438,7 @@ static int bpf_probe_pinned(const char *name, const struct bpf_elf_ctx *ctx,
 		return 0;
 
 	bpf_make_pathname(pathname, sizeof(pathname), name, ctx, pinning);
-	return bpf_obj_get(pathname, ctx->type);
+	return bpf_obj_get_path(pathname, ctx->type);
 }
 
 static int bpf_make_obj_path(const struct bpf_elf_ctx *ctx)
@@ -1501,7 +1506,7 @@ static int bpf_place_pinned(int fd, const char *name,
 		return ret;
 
 	bpf_make_pathname(pathname, sizeof(pathname), name, ctx, pinning);
-	return bpf_obj_pin(fd, pathname);
+	return bpf_obj_pin_fd(fd, pathname);
 }
 
 static void bpf_prog_report(int fd, const char *section,
@@ -1523,9 +1528,9 @@ static void bpf_prog_report(int fd, const char *section,
 	bpf_dump_error(ctx, "Verifier analysis:\n\n");
 }
 
-static int bpf_prog_attach(const char *section,
-			   const struct bpf_elf_prog *prog,
-			   struct bpf_elf_ctx *ctx)
+static int bpf_prog_attach_section(const char *section,
+				   const struct bpf_elf_prog *prog,
+				   struct bpf_elf_ctx *ctx)
 {
 	int tries = 0, fd;
 retry:
@@ -2347,7 +2352,7 @@ static int bpf_fetch_prog(struct bpf_elf_ctx *ctx, const char *section,
 		prog.insns_num = prog.size / sizeof(struct bpf_insn);
 		prog.insns     = data.sec_data->d_buf;
 
-		fd = bpf_prog_attach(section, &prog, ctx);
+		fd = bpf_prog_attach_section(section, &prog, ctx);
 		if (fd < 0)
 			return fd;
 
@@ -2513,7 +2518,7 @@ static int bpf_fetch_prog_relo(struct bpf_elf_ctx *ctx, const char *section,
 			goto out;
 		}
 
-		fd = bpf_prog_attach(section, prog, ctx);
+		fd = bpf_prog_attach_section(section, prog, ctx);
 		free(prog->insns);
 		if (fd < 0) {
 			*lderr = true;
-- 
2.22.1

