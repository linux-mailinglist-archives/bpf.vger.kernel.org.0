Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B112EF5C24
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 01:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfKIABL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 19:01:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfKIABC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 19:01:02 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FE4851146
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 00:01:01 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id c27so1608415lfj.19
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 16:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L3fzVLzeN6KFGe91Y6bIKoJNlhwlBaMnwS94UGwm964=;
        b=HwOxtR3g2/q0yO9fJZ7h9IyOggPMSsN90T8BOHePK3kaMGEtxLAvq06ijvrJXhY9Nx
         1Ab0Rb/iud6xLAF95oUJTdFUNvsutl6WDlETB7YRwjykC758rvOlipmvGhbC2Rr4WhkD
         jTK4Haycb9UOiGma2R3jImOjAKJpiOKaBNbvco0FWPchKTMhjPXO9ng/zthm+F+0LRE3
         kidA65QQmuf0BV8DZjJT3VV1pYyqsASvoZt/677M/aesxhlK7BIZO6L079QakJdoPY8w
         0XzVAHWzG2JCjtO9bTtPO2g9r0oAFWqgLQ9hDfC47Srj/4OVsRKR6d955h1fCiAHCEne
         9N1A==
X-Gm-Message-State: APjAAAWzEOkDSoxzZNDsi7X0kj7AFW9T50itPb2Z52lHJxvj2ymOlDWK
        5ZDYzh88Ag4j5z4bm6StUhggIfn8LYLcv3ah+0OfhOhw5fkarWwL71yTnSzNE7TiIGneyKANhN3
        OX8Dk440FGxmM
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr8466685ljj.145.1573257659598;
        Fri, 08 Nov 2019 16:00:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqygWKvy+Oti3Lbq08pPu90GaVpEinwByo5YhB5glyFGtEzDwWsQNVywdNIdkQ08Bp5g3N4lDg==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr8466676ljj.145.1573257659447;
        Fri, 08 Nov 2019 16:00:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n19sm3224900lfl.85.2019.11.08.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:00:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08EE21800CE; Sat,  9 Nov 2019 01:00:58 +0100 (CET)
Subject: [PATCH bpf-next v3 3/6] libbpf: Propagate EPERM to caller on program
 load
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 01:00:58 +0100
Message-ID: <157325765795.27401.949901357190446266.stgit@toke.dk>
In-Reply-To: <157325765467.27401.1930972466188738545.stgit@toke.dk>
References: <157325765467.27401.1930972466188738545.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

When loading an eBPF program, libbpf overrides the return code for EPERM
errors instead of returning it to the caller. This makes it hard to figure
out what went wrong on load.

In particular, EPERM is returned when the system rlimit is too low to lock
the memory required for the BPF program. Previously, this was somewhat
obscured because the rlimit error would be hit on map creation (which does
return it correctly). However, since maps can now be reused, object load
can proceed all the way to loading programs without hitting the error;
propagating it even in this case makes it possible for the caller to react
appropriately (and, e.g., attempt to raise the rlimit before retrying).

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a70ade546a73..094f5c64611a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3721,7 +3721,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		free(log_buf);
 		goto retry_load;
 	}
-	ret = -LIBBPF_ERRNO__LOAD;
+	ret = -errno;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
 
@@ -3734,23 +3734,18 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		pr_warn("Program too large (%zu insns), at most %d insns\n",
 			load_attr.insns_cnt, BPF_MAXINSNS);
 		ret = -LIBBPF_ERRNO__PROG2BIG;
-	} else {
+	} else if (load_attr.prog_type != BPF_PROG_TYPE_KPROBE) {
 		/* Wrong program type? */
-		if (load_attr.prog_type != BPF_PROG_TYPE_KPROBE) {
-			int fd;
-
-			load_attr.prog_type = BPF_PROG_TYPE_KPROBE;
-			load_attr.expected_attach_type = 0;
-			fd = bpf_load_program_xattr(&load_attr, NULL, 0);
-			if (fd >= 0) {
-				close(fd);
-				ret = -LIBBPF_ERRNO__PROGTYPE;
-				goto out;
-			}
-		}
+		int fd;
 
-		if (log_buf)
-			ret = -LIBBPF_ERRNO__KVER;
+		load_attr.prog_type = BPF_PROG_TYPE_KPROBE;
+		load_attr.expected_attach_type = 0;
+		fd = bpf_load_program_xattr(&load_attr, NULL, 0);
+		if (fd >= 0) {
+			close(fd);
+			ret = -LIBBPF_ERRNO__PROGTYPE;
+			goto out;
+		}
 	}
 
 out:

