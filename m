Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541814F10C
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2019 01:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfFUXRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jun 2019 19:17:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50725 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfFUXRJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jun 2019 19:17:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so5238270pfq.17
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2019 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=DhzVRaw/a+PX549RD/zQ/RusOh9Ia49qub/l/pnZrEhqQGiPlzKllJpEzqw+3uVoXa
         ywXJ9vt4USsbkQBlFgwqS/r5rhJfMyLQ5wHHVTEY+5Kj0K57G9FimOYfbKwmduG1GSpW
         xi6YbMgICMq/Z7BY+dpaAkskT/UlXrw+PjXwq3+JyI38sr4zdJ6v4iGpgCw9hKt+jj0M
         uXAeHX9TGBBS4R0x4vhkvUYWnLNhHQqOY5pEC3RKL8Nt40MuQMsM2j1yC7/xzSN5+QV4
         358XGiHUurDsBt5sV6SUgctvplQO+bWr6Z1uw/psVzhFcavo1IwkXKwMmlboFKstHjHm
         qtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=CZ6x5z2bJs/Vi052NjlTebF/+HNs+Qi0ko5Ea2DuUbSKH6YaMsKWug1fxkIItOF5jQ
         0TwflcL9BEx8/rhjGk7nO0dx0dHyzJliaWQbBRKT31pUWCwwUiGVtGv3GICAH7GEG7RA
         6BGXZdcAJxy4RSs/dcPelfgIAc3ga0dhAg9i3e4FGD8SHqYXnA/Md8bRydrqgjTxHAaP
         FSd1WHzHjXmDg5llwKuq+KGHh5DWOEopCMISi1tIgPZ7Dd5k5jxy8ZxVbbrf8p5Zrdf5
         J2Gri82gxlQxvkcQPVJfLJtFvugk2dHBV5AFacfxTCK6gRO+JXw2YNEWes0Mh8HX5H/q
         kXHw==
X-Gm-Message-State: APjAAAU+6KrlH42HJMS5UAZcbmSwa1tbbP9cLxOO9tEy2EQxfP3xKeM5
        ENe5pnZBBP8x/Utgnk3llW70Y0EFE8Wj
X-Google-Smtp-Source: APXvYqwBDycFPyFN0T8MCGb/sKVNHt/1aFdgx2n/iYTCOgaUyebUrA1N6KIKDW/4Y7ivFfTXH74qdWJlHS3o
X-Received: by 2002:a63:fc61:: with SMTP id r33mr20911884pgk.294.1561159028021;
 Fri, 21 Jun 2019 16:17:08 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:16:48 -0700
In-Reply-To: <20190621231650.32073-1-brianvv@google.com>
Message-Id: <20190621231650.32073-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190621231650.32073-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 4/6] libbpf: support BPF_MAP_DUMP command
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of new BPF_MAP_DUMP command and add bpf_map_dump and
bpf_map_dump_flags to use them from the library.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/lib/bpf/bpf.c      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |  4 ++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb0..c1139b7db756a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -368,6 +368,34 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_dump(int fd, const void *prev_key, void *buf, void *buf_len)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
+int bpf_map_dump_flags(int fd, const void *prev_key, void *buf, void *buf_len,
+		       __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+	attr.dump.flags = flags;
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ff42ca043dc8f..86496443440e9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -112,6 +112,10 @@ LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
+LIBBPF_API int bpf_map_dump(int fd, const void *prev_key, void *buf,
+				void *buf_len);
+LIBBPF_API int bpf_map_dump_flags(int fd, const void *prev_key, void *buf,
+				void *buf_len, __u64 flags);
 LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
 LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d25..e7641773cfb0f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -173,4 +173,6 @@ LIBBPF_0.0.4 {
 		btf__parse_elf;
 		bpf_object__load_xattr;
 		libbpf_num_possible_cpus;
+		bpf_map_dump;
+		bpf_map_dump_flags;
 } LIBBPF_0.0.3;
-- 
2.22.0.410.gd8fdbe21b5-goog

