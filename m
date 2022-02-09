Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F104B0120
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiBIXUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 18:20:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiBIXUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:20:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFBE06A61C
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:20:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so6720952pja.3
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8BOEr8wa8HNl4JcR5+50xbTStTvRUimpj9cEX22Jfk=;
        b=OB4boc1DAVETseDK/ORgs9O6MBmr+TcaqJ1gzC2WDB5MlXf2C7rQYobjEZ2vaBW+mO
         dm6J8O2j0vtzbVcARJqNkWWT9Nmou69Oerm0M/Yxr3+56dTdmpbhGfgFN/1zaIHsKdZY
         6veK7hmsvVfklV0AsD3Pd60TLLN9u7zZC/OGn/1zqbUUpEy5PMXhI+BhbBgDWPEUy6UV
         7q+qUzdU1perEDbW2wXbzpC5bfPa7TAzRRs3IMZbdQS4N4LClQKWm+d5gj8QtAG2NOw2
         jB7gdWhUfFNDBQ+0X2TkS09jtoxtBfitlkx4K8KJ9oK32nudkHELaWDz3c05z4H23f8X
         c/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8BOEr8wa8HNl4JcR5+50xbTStTvRUimpj9cEX22Jfk=;
        b=34Dc7ctJlL1dU5NIQBUh87FUB0Y+FvTEqoot2D10wrtvWbWc+G44u2A9jJliavHVsG
         AHarJOQG/ETc8QLEIxDq3VC9FHxsoRL77R5hBWNrX1vARGtCziZ7hoFcRqkadHlQanY4
         GL367mum+66Ilt+xE28lnI577X6yz2nC0lR9P1kt6bHgi2ssHeW3uUsFrlyLibRUxfAI
         /GPa1bcSNgL//1FbHmtyXaA88QIHOWe0UL5zpv8DW7QFincbpzKZmKC15SZj4bdV7vh+
         y32I5hHly5erUZeQqGx/SaGAeU/7wfj4MrtzyrbiU7ZE3NRv6bhjf4cnx6H1zitNeXtQ
         Q2RA==
X-Gm-Message-State: AOAM532L7Gvi+gC/7yuXxBw1Q3+lWSET1QBsUaYHpGUCCGgN19yhlRsn
        djANhtPBVmsXpKW5dtlrw+3K5xXVOcM=
X-Google-Smtp-Source: ABdhPJwCFQ9uTo7p+uOPNfRcXQlsqNltzdbQbAtMsOo8j41FRImWfqY30RvJ0m2E62n3R0ROuPWdaQ==
X-Received: by 2002:a17:902:eac4:: with SMTP id p4mr4837844pld.90.1644448815399;
        Wed, 09 Feb 2022 15:20:15 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:9eba])
        by smtp.gmail.com with ESMTPSA id 13sm20425689pfm.161.2022.02.09.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:20:15 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 4/5] bpf: Update iterators.lskel.h.
Date:   Wed,  9 Feb 2022 15:20:00 -0800
Message-Id: <20220209232001.27490-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
References: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Light skeleton and skel_internal.h have changed.
Update iterators.lskel.h.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/preload/iterators/iterators.lskel.h   | 141 +++++++++---------
 1 file changed, 69 insertions(+), 72 deletions(-)

diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
index d90562d672d2..70f236a82fe1 100644
--- a/kernel/bpf/preload/iterators/iterators.lskel.h
+++ b/kernel/bpf/preload/iterators/iterators.lskel.h
@@ -3,8 +3,6 @@
 #ifndef __ITERATORS_BPF_SKEL_H__
 #define __ITERATORS_BPF_SKEL_H__
 
-#include <stdlib.h>
-#include <bpf/bpf.h>
 #include <bpf/skel_internal.h>
 
 struct iterators_bpf {
@@ -70,31 +68,28 @@ iterators_bpf__destroy(struct iterators_bpf *skel)
 	iterators_bpf__detach(skel);
 	skel_closenz(skel->progs.dump_bpf_map.prog_fd);
 	skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
-	munmap(skel->rodata, 4096);
+	skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
 	skel_closenz(skel->maps.rodata.map_fd);
-	free(skel);
+	skel_free(skel);
 }
 static inline struct iterators_bpf *
 iterators_bpf__open(void)
 {
 	struct iterators_bpf *skel;
 
-	skel = calloc(sizeof(*skel), 1);
+	skel = skel_alloc(sizeof(*skel));
 	if (!skel)
 		goto cleanup;
 	skel->ctx.sz = (void *)&skel->links - (void *)skel;
-	skel->rodata =
-		mmap(NULL, 4096, PROT_READ | PROT_WRITE,
-		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	if (skel->rodata == (void *) -1)
-		goto cleanup;
-	memcpy(skel->rodata, (void *)"\
+	skel->rodata = skel_prep_map_data((void *)"\
 \x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\
 \x20\x20\x20\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\x0a\0\x25\x34\x75\x20\
 \x25\x2d\x31\x36\x73\x25\x36\x64\x0a\0\x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\
 \x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x61\x74\x74\x61\x63\x68\x65\
-\x64\x0a\0\x25\x34\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x0a\0", 98);
-	skel->maps.rodata.initial_value = (__u64)(long)skel->rodata;
+\x64\x0a\0\x25\x34\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x0a\0", 4096, 98);
+	if (!skel->rodata)
+		goto cleanup;
+	skel->maps.rodata.initial_value = (__u64) (long) skel->rodata;
 	return skel;
 cleanup:
 	iterators_bpf__destroy(skel);
@@ -326,7 +321,7 @@ iterators_bpf__load(struct iterators_bpf *skel)
 \0\0\x01\0\0\0\0\0\0\0\x13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\
 \0\0\x62\x70\x66\x5f\x69\x74\x65\x72\x5f\x62\x70\x66\x5f\x70\x72\x6f\x67\0\0\0\
 \0\0\0\0";
-	opts.insns_sz = 2184;
+	opts.insns_sz = 2216;
 	opts.insns = (void *)"\
 \xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
 \0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x14\0\0\0\0\0\x61\
@@ -343,70 +338,72 @@ iterators_bpf__load(struct iterators_bpf *skel)
 \0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\
 \xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd4\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\
 \x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x63\x01\0\0\0\
-\0\0\0\x61\x60\x20\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
 \x5c\x0e\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\
 \0\x50\x0e\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
 \xc5\x07\xc3\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\
-\0\x79\x63\x18\0\0\0\0\0\x15\x03\x04\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
-\x0e\0\0\xb7\x02\0\0\x62\0\0\0\x85\0\0\0\x94\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x63\x01\0\
-\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x10\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x98\x0e\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x18\x0f\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\xa6\0\
-\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xa3\xff\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\x63\x01\0\0\
-\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\xb7\x03\
-\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x96\xff\0\0\0\0\
-\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x11\0\
-\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x38\x0f\0\0\x18\x61\0\0\0\0\
-\0\0\0\0\0\0\x70\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x40\
-\x10\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\
-\0\0\0\0\0\0\0\0\0\x48\x10\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x11\0\0\x7b\x01\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x10\0\0\x18\x61\0\0\0\0\0\0\0\0\0\
-\0\xe8\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\
-\0\0\0\0\0\0\0\0\0\0\xe0\x11\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x80\x11\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\x84\x11\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x88\x11\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\
-\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb0\x11\0\0\x63\x01\0\0\0\0\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\xf8\x11\0\0\xb7\x02\0\0\x11\0\0\0\xb7\x03\0\0\x0c\0\0\
-\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x60\xff\
-\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x68\x11\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\
-\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\
-\0\0\0\0\x68\x11\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x11\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\
-\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x4e\xff\0\0\0\0\x63\
-\x7a\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x12\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\x10\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x18\x12\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
-\0\0\0\0\0\0\0\x28\x14\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\x17\0\0\x7b\x01\0\0\
-\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x14\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
-\x60\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x15\0\0\x18\
-\x61\0\0\0\0\0\0\0\0\0\0\x80\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x17\0\0\x7b\x01\0\0\0\0\0\0\x61\
-\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x17\0\0\x63\x01\0\0\0\0\0\0\
-\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\x17\0\0\x63\x01\0\0\0\0\
-\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x17\0\0\x7b\x01\0\0\
-\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x17\0\0\x63\
-\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x17\0\0\xb7\x02\0\0\x12\0\0\0\
-\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\
-\0\0\xc5\x07\x17\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x17\0\0\x63\x70\x6c\
-\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\
-\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x17\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\
-\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x17\0\0\x61\x01\0\0\0\0\
-\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x05\
-\xff\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\
-\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\
-\x28\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x2c\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\0\0\0\0\
-\x95\0\0\0\0\0\0\0";
+\0\x79\x63\x20\0\0\0\0\0\x15\x03\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
+\x0e\0\0\xb7\x02\0\0\x62\0\0\0\x61\x60\x04\0\0\0\0\0\x45\0\x02\0\x01\0\0\0\x85\
+\0\0\0\x94\0\0\0\x05\0\x01\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x18\x62\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x63\
+\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\
+\0\0\x10\x0f\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x98\x0e\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x0f\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x02\0\
+\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\xb7\x03\0\0\x20\0\0\0\x85\0\0\0\
+\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x9f\xff\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\x63\
+\x01\0\0\0\0\0\0\xb7\x01\0\0\x16\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x28\x0f\0\0\
+\xb7\x03\0\0\x04\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x92\xff\
+\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x78\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x38\x0f\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x70\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
+\0\0\0\x40\x10\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb8\x11\0\0\x7b\x01\0\0\0\0\0\0\
+\x18\x60\0\0\0\0\0\0\0\0\0\0\x48\x10\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x11\0\
+\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xe8\x10\0\0\x18\x61\0\0\0\0\
+\0\0\0\0\0\0\xe8\x11\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x11\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\
+\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x11\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\
+\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x84\x11\0\0\x63\x01\0\0\0\0\0\0\x79\x60\
+\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x88\x11\0\0\x7b\x01\0\0\0\0\0\0\x61\
+\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xb0\x11\0\0\x63\x01\0\0\0\0\0\
+\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\x11\0\0\xb7\x02\0\0\x11\0\0\0\xb7\x03\0\0\
+\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
+\x5c\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x68\x11\0\0\x63\x70\x6c\0\0\0\0\0\
+\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\
+\0\0\0\0\0\0\0\0\x68\x11\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
+\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x11\0\0\x61\x01\0\0\0\0\0\0\xd5\
+\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x4a\xff\0\0\
+\0\0\x63\x7a\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x12\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x10\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
+\x18\x12\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\x28\x14\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x50\x17\0\0\
+\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x30\x14\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\x60\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x15\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x17\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x78\x17\0\0\x7b\x01\0\0\0\0\
+\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x18\x17\0\0\x63\x01\0\0\
+\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x1c\x17\0\0\x63\x01\
+\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x20\x17\0\0\x7b\
+\x01\0\0\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x48\x17\0\
+\0\x63\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x17\0\0\xb7\x02\0\0\x12\
+\0\0\0\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\
+\0\0\0\0\0\xc5\x07\x13\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x17\0\0\x63\
+\x70\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\
+\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\0\x17\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\
+\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x17\0\0\x61\x01\
+\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\
+\x07\x01\xff\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\
+\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\
+\x63\x06\x28\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x2c\0\0\0\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\
+\0\0\0\0\x95\0\0\0\0\0\0\0";
 	err = bpf_load_and_run(&opts);
 	if (err < 0)
 		return err;
-	skel->rodata =
-		mmap(skel->rodata, 4096, PROT_READ, MAP_SHARED | MAP_FIXED,
-			skel->maps.rodata.map_fd, 0);
+	skel->rodata = skel_finalize_map_data(&skel->maps.rodata.initial_value,
+					4096, PROT_READ, skel->maps.rodata.map_fd);
+	if (!skel->rodata)
+		return -ENOMEM;
 	return 0;
 }
 
-- 
2.30.2

