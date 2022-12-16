Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BD64E722
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 06:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiLPFyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 00:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPFyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 00:54:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DBE36D64;
        Thu, 15 Dec 2022 21:54:43 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s196so1105497pgs.3;
        Thu, 15 Dec 2022 21:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nHmBQYF3nBNqyNj2PFzrUNwBMnuzgTKWyjZljTDo88=;
        b=QzFwd1MmmPpBd2ezWngjf7PUFaMaB52m8IiN67Yqc8i91g+Tdth/SezAJD12ThbR/2
         9Ub0A414NsZr4WUwBcNy9zE/3cxR2w3aGJgdpIpW5WbBa/qLCV8JUsrEVzqQ0Uw0GVrx
         JKBmdQGNgn1SZhPLZt3chZrVrc0VQAJCwHpP9zoIYeJ8evCSbQEE80OMuAz0WUYALvJL
         yao3BPSdY77o4M6fbi34ZJsJTb2MaBAVi/O8xIj+79XOZ3dpNIG6S8xR4p3uH2b/qU5K
         VbbYUtBI/A1Ofpa586Yi57dNxnPtuc/vnAnlC5eFRwc+X3eng66MA+z5zgxVCezaQPPG
         qTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nHmBQYF3nBNqyNj2PFzrUNwBMnuzgTKWyjZljTDo88=;
        b=gfaGuEh9n04XpvV6THBxVGxave1GiHl7D8NJaeikBx+14XJaI2d/bKdIJ8IxdDZtb3
         poEs3Y9k8qqmbwKS1Z325wCs1PfWn8XHxdJIpuUVPRCawuP15CcCrhmw8dgrWCdYDdUt
         v5buzuZ9HhVmzLgSAUJrRX2q6998WqofRSIpy6mQAQLljnSnkx5uUzpmLlSctOwTDqb0
         fooaK3ouHq7gL/7uA04ebDGPlNIKmR1QD6oXzOJ61GVr21uEsmuB19hZR34vqw6yUXbY
         BqiXwj9/4qOaXMo21DEnm82CCFheid0S983/kbaahMyTNhVjBjQgls21OJ8pAK+8bdxA
         GW9g==
X-Gm-Message-State: ANoB5pmulxP6WTlk7eyoOXqMNjM6HODjJkbttMLcKgN6IT9SILMudbR2
        br7ChmTBga18A+XDGgfq3FcQ26CmhA==
X-Google-Smtp-Source: AA0mqf4PSVQIxjakaMhGlrWMkqj/LWjNW94XGL+5lPErpFVoJ77ZONGaLRQYV88tY0n0LWCsJ6F0JQ==
X-Received: by 2002:a62:870d:0:b0:576:f02e:d0ef with SMTP id i13-20020a62870d000000b00576f02ed0efmr31320268pfe.4.1671170082306;
        Thu, 15 Dec 2022 21:54:42 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id g15-20020aa79f0f000000b0056b2e70c2f5sm593246pfr.25.2022.12.15.21.54.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Dec 2022 21:54:41 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next] bpf: dup xlated insns with kvmalloc+memcpy
Date:   Fri, 16 Dec 2022 13:54:35 +0800
Message-Id: <20221216055436.4698-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, kmemdup() is used for allocating and copying xlated insns
in bpf_insn_prepare_dump(). The following warning can be triggered
when dup large amount of insns (roughly BPF_COMPLEXITY_LIMIT_INSNS/2)
because kmemdup() uses kmalloc() which would fail when allocing size
is too big, leading to failure in dump xlated insns:

WARNING: CPU: 2 PID: 7060 at mm/page_alloc.c:5534
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x81/0x160 mm/slab_common.c:1096
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc_node_track_caller.cold+0x5/0x5d mm/slab_common.c:975
 kmemdup+0x29/0x60 mm/util.c:129
 kmemdup include/linux/fortify-string.h:585 [inline]
 bpf_insn_prepare_dump kernel/bpf/syscall.c:3820 [inline]
 bpf_prog_get_info_by_fd+0x9a3/0x2cb0 kernel/bpf/syscall.c:3975
 bpf_obj_get_info_by_fd kernel/bpf/syscall.c:4297 [inline]
 __sys_bpf+0x3928/0x56f0 kernel/bpf/syscall.c:5004
 __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
 ...

So use kvmalloc()+memcpy() to fix this, for small size of insns,
this is same as kmemdup(), but this also support dup large amount
of xlated insns.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35972afb6850..06229fddac0d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3831,10 +3831,10 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 	u8 code;
 	int i;
 
-	insns = kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
-			GFP_USER);
-	if (!insns)
+	insns = kvmalloc(bpf_prog_insn_size(prog), GFP_USER | __GFP_NOWARN);
+	if (unlikely(!insns))
 		return insns;
+	memcpy(insns, prog->insnsi, bpf_prog_insn_size(prog));
 
 	for (i = 0; i < prog->len; i++) {
 		code = insns[i].code;
@@ -3992,7 +3992,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		uinsns = u64_to_user_ptr(info.xlated_prog_insns);
 		ulen = min_t(u32, info.xlated_prog_len, ulen);
 		fault = copy_to_user(uinsns, insns_sanitized, ulen);
-		kfree(insns_sanitized);
+		kvfree(insns_sanitized);
 		if (fault)
 			return -EFAULT;
 	}

base-commit: 0e43662e61f2569500ab83b8188c065603530785
-- 
2.39.0

