Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072B5F59F2
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfKHVdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 16:33:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbfKHVdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:12 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A757F59445
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 21:33:11 +0000 (UTC)
Received: by mail-lj1-f197.google.com with SMTP id d16so1551767ljo.11
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 13:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hPfHFcv37CDnOMOC+xTSrHQZULPPVPLWMXuGoJtoK4c=;
        b=oAgdfuEL+JKiZe5lLH16IODVzjHBQ/rCH+tQLe2KESYtrydjW2UgFG7EcsRSqqQoG6
         +7VpJtPpNSGh6ViZd/Y7MyZEepzokV0Nms0y4sLrPEwOHFcupkecLoutjOYcaOgqVAfM
         /9LQe45wFprQ3wScaIh+tC+8OYq5P02WWlok1kokaTKIin+qlGp5UTKhjD8soDIW+2qf
         eTl22X9Dv7FdcaZUBUPgnrcwZdWXWmR6blsSynR4av+71RyrR0aV5T/KFI0uRxQ5CcrZ
         M3HWBtC7ibLHHCGfkzzX9+DDMUFLa5o/Qr7SP01bYxDX6ElkMKWwkL3Rs7REflqxT3k5
         GNzg==
X-Gm-Message-State: APjAAAUIRzfS+hitT1woqlQAEFw1pfGAL63Oi6SR0ZxBiwZjLVt7bt8i
        E+63j7HcL4Jb1PbaWMUJAoN32VM8OpMXeeD/pEzAgcb1TUpgjzQawv96/Ul7aLYxVD2PsTFGB3c
        zRWL6R1gcTCyE
X-Received: by 2002:a2e:575c:: with SMTP id r28mr8131058ljd.245.1573248790228;
        Fri, 08 Nov 2019 13:33:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAi43npY0faZsZZ6teo9y2V3AZS6Vj9mcY+7NfpUkkq1/GvTFroNpp36SBngBr+vb+HXn5ig==
X-Received: by 2002:a2e:575c:: with SMTP id r28mr8131051ljd.245.1573248789967;
        Fri, 08 Nov 2019 13:33:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id r22sm2970828ljk.31.2019.11.08.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:33:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8925A1800CB; Fri,  8 Nov 2019 22:33:08 +0100 (CET)
Subject: [PATCH bpf-next v2 3/6] libbpf: Propagate EPERM to caller on program
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
Date:   Fri, 08 Nov 2019 22:33:08 +0100
Message-ID: <157324878850.910124.10106029353677591175.stgit@toke.dk>
In-Reply-To: <157324878503.910124.12936814523952521484.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
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

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cea61b2ec9d3..582c0fd16697 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3721,7 +3721,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		free(log_buf);
 		goto retry_load;
 	}
-	ret = -LIBBPF_ERRNO__LOAD;
+	ret = (errno == EPERM) ? -errno : -LIBBPF_ERRNO__LOAD;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("load bpf program failed: %s\n", cp);
 
@@ -3749,7 +3749,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 			}
 		}
 
-		if (log_buf)
+		if (log_buf && ret != -EPERM)
 			ret = -LIBBPF_ERRNO__KVER;
 	}
 

