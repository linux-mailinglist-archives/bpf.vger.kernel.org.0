Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16B121698
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfLPSaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 13:30:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731011AbfLPSMw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 13:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576519970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gG9VGGPZ6c4OJ26G78LddjiW5k2zffvrFpUIDfVi4Vk=;
        b=Px/lX10TfCWwZ/WYWXUxqE9S9sYQH8FJ3zjcGYfN431OwjODWtxAqQYXnr6EQeE+4i4N6W
        ixWjT1wpnIdzKWH9I5oVD6fx417QevFJlwd3JRHIMOMBVzegE4eZXYYS/JgTXwLtluolQB
        ZzcqHh6w2WtpSp8MKSpSCMJjjFi2Yds=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-RPQyEhq4M1C6JYqzK4ZbUw-1; Mon, 16 Dec 2019 13:12:49 -0500
X-MC-Unique: RPQyEhq4M1C6JYqzK4ZbUw-1
Received: by mail-lj1-f197.google.com with SMTP id q191so2355894ljb.8
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 10:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gG9VGGPZ6c4OJ26G78LddjiW5k2zffvrFpUIDfVi4Vk=;
        b=ASc1ODsIgzv2FfRhNsYsXpDgXxs+h/AYKaXf32WoovVTb91gPXP0eMd0iWTkWoMhkL
         LUyDxwoCNUuuyFedZD5tM4HyOfkIbNFnWHnvOaym2hAKvuwwMWAfGrQwo5dv5OROH7pk
         8OCdn9Pc/DYAW0ImJKVY39LtzxGijz3NGpvNiwn55lDQXNO2snWXC0B9/J6E/ZtP/UHc
         jszq8CmrE2SM856bPRWIU0vLTV5tDQioHLFBidiHXHtXB/FXJKIjuafB92Jmer9bbbov
         sn+n9rytAjIoWHB5XaBhPOJFJugwxBX9HshNBHWfLAOEv2nyVIg0uGAkzEQ6TPcLUR7S
         gZ1w==
X-Gm-Message-State: APjAAAVyrHzDOxjxH38idtXoOHSeryrOyJ6FipfwTs6RJYdHKOcehe8U
        RoHQdM+IO/UHILurgq1rAcRRKBwMQ8Y8mlD9s77cV1B3QJpw9i1y9pHkdBnV4SgseTKsVLke4P8
        MM+HQ4X5SuIvk
X-Received: by 2002:a2e:8797:: with SMTP id n23mr298319lji.176.1576519967825;
        Mon, 16 Dec 2019 10:12:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzib2wPbukcLs24+rc6P5JH52a4OsCYyY8YkGjR2Epph9CQfUt9aPxH1qqr+PIhM8j16xM9cw==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr298286lji.176.1576519967369;
        Mon, 16 Dec 2019 10:12:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q25sm11160992lji.7.2019.12.16.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 10:12:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CDDF7180960; Mon, 16 Dec 2019 19:12:45 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2] libbpf: Print hint about ulimit when getting permission denied error
Date:   Mon, 16 Dec 2019 19:12:04 +0100
Message-Id: <20191216181204.724953-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Probably the single most common error newcomers to XDP are stumped by is
the 'permission denied' error they get when trying to load their program
and 'ulimit -l' is set too low. For examples, see [0], [1].

Since the error code is UAPI, we can't change that. Instead, this patch
adds a few heuristics in libbpf and outputs an additional hint if they are
met: If an EPERM is returned on map create or program load, and geteuid()
shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
output a hint about raising 'ulimit -l' as an additional log line.

[0] https://marc.info/?l=xdp-newbies&m=157043612505624&w=2
[1] https://github.com/xdp-project/xdp-tutorial/issues/86

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Format current output as KiB/MiB
  - It's ulimit -l, not ulimit -r
  
 tools/lib/bpf/libbpf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a2cc7313763a..3fe42d6b0c2f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -41,6 +41,7 @@
 #include <sys/types.h>
 #include <sys/vfs.h>
 #include <sys/utsname.h>
+#include <sys/resource.h>
 #include <tools/libc_compat.h>
 #include <libelf.h>
 #include <gelf.h>
@@ -100,6 +101,32 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 	va_end(args);
 }
 
+static void pr_perm_msg(int err)
+{
+	struct rlimit limit;
+	char buf[100];
+
+	if (err != -EPERM || geteuid() != 0)
+		return;
+
+	err = getrlimit(RLIMIT_MEMLOCK, &limit);
+	if (err)
+		return;
+
+	if (limit.rlim_cur == RLIM_INFINITY)
+		return;
+
+	if (limit.rlim_cur < 1024)
+		snprintf(buf, sizeof(buf), "%lu bytes", limit.rlim_cur);
+	else if (limit.rlim_cur < 1024*1024)
+		snprintf(buf, sizeof(buf), "%.1f KiB", (double)limit.rlim_cur / 1024);
+	else
+		snprintf(buf, sizeof(buf), "%.1f MiB", (double)limit.rlim_cur / (1024*1024));
+
+	pr_warn("permission error while running as root; try raising 'ulimit -l'? current value: %s\n",
+		buf);
+}
+
 #define STRERR_BUFSIZE  128
 
 /* Copied from tools/perf/util/util.h */
@@ -2983,6 +3010,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warn("failed to create map (name: '%s'): %s(%d)\n",
 				map->name, cp, err);
+			pr_perm_msg(err);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
@@ -4381,6 +4409,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	ret = -errno;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
+	pr_perm_msg(ret);
 
 	if (log_buf && log_buf[0] != '\0') {
 		ret = -LIBBPF_ERRNO__VERIFY;
-- 
2.24.1

