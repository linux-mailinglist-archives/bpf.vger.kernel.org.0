Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61C1205F9
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 13:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLPMky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 07:40:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727512AbfLPMkx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 07:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576500053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ga25dRd639NpZwMHra87nl2NBkSSmC+ikkph5ObqM3A=;
        b=XpgeaWBwA8yahR10pKZoVp7Rfk2Nw0AEkZ1hPvMC0MEtp8AXT4d/YofPRoAD17IXVnHWF5
        qghwCFN9kE0CTzK6rUAW5pn3H6EnIXSprMK2ydFt5XUBbZ3ZYxHqxkqg5ze6bpxA7EjQHB
        UcdW8DYC31hgMW5CQM464zZpF3dQoY4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-phdIVp1TOMO3EM1T88xO_w-1; Mon, 16 Dec 2019 07:40:49 -0500
X-MC-Unique: phdIVp1TOMO3EM1T88xO_w-1
Received: by mail-lj1-f200.google.com with SMTP id r14so2086774ljc.18
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 04:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ga25dRd639NpZwMHra87nl2NBkSSmC+ikkph5ObqM3A=;
        b=hCCyqViYBzpRGtu1A/n28slK5fb+mIeHAA+2WYd68bcpszFFtYASAJFl4UdnK5SWJG
         597/v8Oxqr/n2t/+IgkwjUHwv0AUTyuXwfgJRwlW3mTl+3NNS0PsKP8mnmNi6GhxVqtU
         paqlJurTsTgCBKZRkYFahFqneAyz+MO8B8SCMjFLrEkHnr5pLn38qm0QpjGhqHmEnedc
         I5Cd1NCQiCpafBSdDiTyF72zBTvTeUFiAQWQTZbUSemfMRLODk8oO3hzw9wLe5T3S4Id
         SaXLr+kPdAN/EvNvJCqz0iP/C+dwVZfMvqevk5ZgN6mMq81XW01/xJiv6h36Ux78j1FZ
         XrxQ==
X-Gm-Message-State: APjAAAVn3tHBXs/tec65MmspRlcCU3eOM6cAIWIdYsIknlm0eeB4PZ+w
        8tV9HVmyABHyBtQ5l05RZUTu+bl7bQxNanOy9Jbkay1rtaVca0uiIUVb/ELo2yFeqWiLMEmUchM
        C2SkSD1WgBR4B
X-Received: by 2002:a19:4208:: with SMTP id p8mr16045223lfa.160.1576500048036;
        Mon, 16 Dec 2019 04:40:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRG7zZhx/Z8Qe2lgFK3QowY1/YYgxsIUndMH11wegrireBYpr4pLUe9RKZYXJOgXBEjJEi5w==
X-Received: by 2002:a19:4208:: with SMTP id p8mr16045214lfa.160.1576500047842;
        Mon, 16 Dec 2019 04:40:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u13sm8839046lfq.19.2019.12.16.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:40:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2436D1819EB; Mon, 16 Dec 2019 13:40:46 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next] libbpf: Print hint about ulimit when getting permission denied error
Date:   Mon, 16 Dec 2019 13:40:31 +0100
Message-Id: <20191216124031.371482-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Probably the single most common error newcomers to XDP are stumped by is
the 'permission denied' error they get when trying to load their program
and 'ulimit -r' is set too low. For examples, see [0], [1].

Since the error code is UAPI, we can't change that. Instead, this patch
adds a few heuristics in libbpf and outputs an additional hint if they are
met: If an EPERM is returned on map create or program load, and geteuid()
shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
output a hint about raising 'ulimit -r' as an additional log line.

[0] https://marc.info/?l=xdp-newbies&m=157043612505624&w=2
[1] https://github.com/xdp-project/xdp-tutorial/issues/86

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a2cc7313763a..aec7995674d2 100644
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
@@ -100,6 +101,24 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 	va_end(args);
 }
 
+static void pr_perm_msg(int err)
+{
+	struct rlimit limit;
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
+	pr_warn("permission error while running as root; try raising 'ulimit -r'? current value: %lu\n",
+		limit.rlim_cur);
+}
+
 #define STRERR_BUFSIZE  128
 
 /* Copied from tools/perf/util/util.h */
@@ -2983,6 +3002,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warn("failed to create map (name: '%s'): %s(%d)\n",
 				map->name, cp, err);
+			pr_perm_msg(err);
 			for (j = 0; j < i; j++)
 				zclose(obj->maps[j].fd);
 			return err;
@@ -4381,6 +4401,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	ret = -errno;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
+	pr_perm_msg(ret);
 
 	if (log_buf && log_buf[0] != '\0') {
 		ret = -LIBBPF_ERRNO__VERIFY;
-- 
2.24.0

