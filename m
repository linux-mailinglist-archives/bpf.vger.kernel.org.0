Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E24AE200
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385647AbiBHTNY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385892AbiBHTNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:13:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049AC0612C3
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:13:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id on2so66390pjb.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENmm2RIFAUVug724BIM6PFSnweNoJNbJmLqC9jMYHHM=;
        b=mdm+DE9VTPEO6c/lf6AdDArz6A12vLDARiW4EDr7ozJCy1mZctrRZJcy7qbR9gwQQZ
         H7bcRekC3QyLxRM85kDeEz1JBmMpD95vbkCVxYsYg/lPZzM5fcjiMs6mJUqWGgONv8Fx
         ACXtVjVXJVlZa2emHrj9G+lk30uYpGrED4aWYFtcfDOH6ZOZSnZ1o8oHEGBZ6BzPUIVh
         aWcMXUriZcrLrBjgrhzjU0/8kVUN2i2QIdGBczrds33rUVxGB1MDhEhlZBnwzvy+WbAc
         90HgI83HoVpiVR2qOPHZoqbuWFF9T4c/67ZKcdmWMRQTWDlhjWd3UchEBPN+FMmSFV0X
         Ts0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENmm2RIFAUVug724BIM6PFSnweNoJNbJmLqC9jMYHHM=;
        b=b0/Xv27S/b3J3XIPOmvDABv6gL4ykEQphyl9cowmvr4WIhLOxgwaH86IY0DnZItgIt
         av3/A6I+Ku2Dm8AltiiUBzi9rWq16ho9Hi2tAmUXGwD0EGJzZFpejHvJ5HytBp6vGkyR
         jwbkHzBvOFxUCZnOgjGiDij0FLLUpg7Mt1FA87UrYPzy6Sl9iPQk/CfZRSL/XbdbCrFg
         zsBFJ4OmCKVUVQlM1wbnAcxkS7uy47jZbTkHnxpEHGfbnWm2EoYSWqZeECEzYurkseU3
         SIY8W8ybpfTgM3P2yKgtdpb8gjZl8iLWZntRTfEiKdlIjImpyXd3J6IgOFLrpwwRfn0Z
         1H/w==
X-Gm-Message-State: AOAM533TzdrpXf0ZZBX7DG5JZ2sewjkQAKMK8CbgdXW4iBZAkpHXKfIg
        emJPUUZOb1AarPZPxtdRwlc=
X-Google-Smtp-Source: ABdhPJxVjCBbiZGeUe/BGUYteSlEXY0WCLfzEmmSnorUeO1ouAow+QjYu+/T4PIk2cbWQQguDTycRA==
X-Received: by 2002:a17:90b:4f46:: with SMTP id pj6mr2965975pjb.43.1644347599749;
        Tue, 08 Feb 2022 11:13:19 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id f8sm17044822pfe.204.2022.02.08.11.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:13:19 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 4/5] bpf: Update iterators.lskel.h.
Date:   Tue,  8 Feb 2022 11:13:05 -0800
Message-Id: <20220208191306.6136-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/preload/iterators/iterators.lskel.h   | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
index d90562d672d2..3e45237f59f4 100644
--- a/kernel/bpf/preload/iterators/iterators.lskel.h
+++ b/kernel/bpf/preload/iterators/iterators.lskel.h
@@ -3,8 +3,6 @@
 #ifndef __ITERATORS_BPF_SKEL_H__
 #define __ITERATORS_BPF_SKEL_H__
 
-#include <stdlib.h>
-#include <bpf/bpf.h>
 #include <bpf/skel_internal.h>
 
 struct iterators_bpf {
@@ -70,31 +68,25 @@ iterators_bpf__destroy(struct iterators_bpf *skel)
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
 	return skel;
 cleanup:
 	iterators_bpf__destroy(skel);
@@ -343,11 +335,11 @@ iterators_bpf__load(struct iterators_bpf *skel)
 \0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\
 \xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd4\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\
 \x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x63\x01\0\0\0\
-\0\0\0\x61\x60\x20\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
 \x5c\x0e\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\
 \0\x50\x0e\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
 \xc5\x07\xc3\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\
-\0\x79\x63\x18\0\0\0\0\0\x15\x03\x04\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
+\0\x79\x63\x20\0\0\0\0\0\x15\x03\x04\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
 \x0e\0\0\xb7\x02\0\0\x62\0\0\0\x85\0\0\0\x94\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
 \0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x63\x01\0\
 \0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
@@ -401,12 +393,12 @@ iterators_bpf__load(struct iterators_bpf *skel)
 \x28\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x2c\0\0\0\0\0\x18\x61\0\0\0\0\0\
 \0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\0\0\0\0\
 \x95\0\0\0\0\0\0\0";
+	skel->maps.rodata.initial_value = skel_prep_init_value((void **)&skel->rodata, 4096, 98);
 	err = bpf_load_and_run(&opts);
 	if (err < 0)
 		return err;
-	skel->rodata =
-		mmap(skel->rodata, 4096, PROT_READ, MAP_SHARED | MAP_FIXED,
-			skel->maps.rodata.map_fd, 0);
+	skel->rodata = skel_finalize_map_data(&skel->maps.rodata.initial_value,
+			4096, PROT_READ, skel->maps.rodata.map_fd);
 	return 0;
 }
 
-- 
2.30.2

