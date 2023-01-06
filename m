Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD36603A1
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAFPoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjAFPoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 10:44:04 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B995C41648
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 07:44:02 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4a2f8ad29d5so27464077b3.8
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YtDOALCm4j61oIDe5piCQL9JbkyPVTVUGZdht/Bzik=;
        b=GOrjdpE2ofeY7dSVxIvqIegvdqC/XSgn2KbTF+B24stkxJXTR3glZcrW239gFcX5QL
         cTUCdJsy7qKM3tCjVKdwAhSQZLrr54WeQ+aaFI3mWC5e1wGe9dA0sOjp/hGyuUVaKw0d
         1Z4ORXMIg1b7mQBM2xHzIfz9g9X2rHwqZbHa1AcizLoHCfUu+KBakhDtj3mWdLKy6GuL
         mOURkxKMef6w7YQDzUGb+BHwkti9MhSR+fOcSpPApLo+GjxctvRmNm0lZpdFYRacX8eo
         igWF0g2ngJFrBzNMDqEN+a1jIM2jQLmBihc1arV/7k4gzXtGO1jOUXuxpD9c1Z8CdSjA
         PLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YtDOALCm4j61oIDe5piCQL9JbkyPVTVUGZdht/Bzik=;
        b=IsevpGibzSU4Mp9W1Bj4PXKciqUFUuuVr3lvrjw3z6PE4oL5IGwte3b6ZkmcRVEz+i
         Vuqyz82y7gmXUJC3RiizaoEEU2P3zyyMcTs9nJG+WS+SFejFjpVdOj0CYwfvAYEZawiT
         kOwsSaZS9x5LWOAPOXIMq7Z0ufm8UJ4Ppzb2Kc6mA/x3bW8P4JAsQsNWwQahG6aic69o
         vZ8+ebwNU+7187AyKj23me7g3ARP4feEygFmjEJDbEYZllFRsGXyqj7dGw4MnJoDDf0b
         c1Gcr7KL54MJwAy0+T3xCWFikz+tdf8SSP0+iGRq5Iv9QBZgPzzhY2Kg0GQEnsN/YPTf
         /0kA==
X-Gm-Message-State: AFqh2ko8GIXGkNRtgyfAKiNTCEUilP2cEqqVqw2g6z1k3yRx5wjEykat
        6sUcMAKKVtIo4JBGeuitkGCu
X-Google-Smtp-Source: AMrXdXudGOJNnZV0xOrQj49/7/cL6W3q8iHq8Fpvr7yr6sQYlnvLQxoqwakTM93PjIK7EQjTCLQoXQ==
X-Received: by 2002:a05:7500:5708:b0:f0:2e10:4737 with SMTP id by8-20020a057500570800b000f02e104737mr521506gab.37.1673019841713;
        Fri, 06 Jan 2023 07:44:01 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z9-20020ac87ca9000000b003a7e2aea23esm633021qtv.86.2023.01.06.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:44:00 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Burn Alting <burn.alting@iinet.net.au>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 1/2] bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD
Date:   Fri,  6 Jan 2023 10:43:59 -0500
Message-Id: <20230106154400.74211-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When changing the ebpf program put() routines to support being called
from within IRQ context the program ID was reset to zero prior to
calling the perf event and audit UNLOAD record generators, which
resulted in problems as the ebpf program ID was bogus (always zero).
This patch addresses this problem by removing an unnecessary call to
bpf_prog_free_id() in __bpf_prog_offload_destroy() and adjusting
__bpf_prog_put() to only call bpf_prog_free_id() after audit and perf
have finished their bpf program unload tasks in
bpf_prog_put_deferred().  For the record, no one can determine, or
remember, why it was necessary to free the program ID, and remove it
from the IDR, prior to executing bpf_prog_put_deferred();
regardless, both Stanislav and Alexei agree that the approach in this
patch should be safe.

It is worth noting that when moving the bpf_prog_free_id() call, the
do_idr_lock parameter was forced to true as the ebpf devs determined
this was the correct as the do_idr_lock should always be true.  The
do_idr_lock parameter will be removed in a follow-up patch, but it
was kept here to keep the patch small in an effort to ease any stable
backports.

I also modified the bpf_audit_prog() logic used to associate the
AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
Instead of keying off the operation, it now keys off the execution
context, e.g. '!in_irg && !irqs_disabled()', which is much more
appropriate and should help better connect the UNLOAD operations with
the associated audit state (other audit records).

Cc: stable@vger.kernel.org
Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
Reported-by: Burn Alting <burn.alting@iinet.net.au>
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Suggested-by: Stanislav Fomichev <sdf@google.com>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

---
* v3
- abandon most of the changes in v2
- move bpf_prog_free_id() after the audit/perf unload hooks
- remove bpf_prog_free_id() from __bpf_prog_offload_destroy()
- added stable tag
* v2
- change subj
- add mention of the perf regression
- drop the dedicated program audit ID
- add the bpf_prog::valid_id flag, bpf_prog_get_id() getter
- convert prog ID users to new ID getter
* v1
- subj was: "bpf: restore the ebpf audit UNLOAD id field"
- initial draft
---
 kernel/bpf/offload.c | 3 ---
 kernel/bpf/syscall.c | 6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 13e4efc971e6..190d9f9dc987 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -216,9 +216,6 @@ static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
 	if (offload->dev_state)
 		offload->offdev->ops->destroy(prog);
 
-	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
-	bpf_prog_free_id(prog, true);
-
 	list_del_init(&offload->offloads);
 	kfree(offload);
 	prog->aux->offload = NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64131f88c553..61bb19e81b9c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1972,7 +1972,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 		return;
 	if (audit_enabled == AUDIT_OFF)
 		return;
-	if (op == BPF_AUDIT_LOAD)
+	if (!in_irq() && !irqs_disabled())
 		ctx = audit_context();
 	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
@@ -2067,6 +2067,7 @@ static void bpf_prog_put_deferred(struct work_struct *work)
 	prog = aux->prog;
 	perf_event_bpf_event(prog, PERF_BPF_EVENT_PROG_UNLOAD, 0);
 	bpf_audit_prog(prog, BPF_AUDIT_UNLOAD);
+	bpf_prog_free_id(prog, true);
 	__bpf_prog_put_noref(prog, true);
 }
 
@@ -2075,9 +2076,6 @@ static void __bpf_prog_put(struct bpf_prog *prog, bool do_idr_lock)
 	struct bpf_prog_aux *aux = prog->aux;
 
 	if (atomic64_dec_and_test(&aux->refcnt)) {
-		/* bpf_prog_free_id() must be called first */
-		bpf_prog_free_id(prog, do_idr_lock);
-
 		if (in_irq() || irqs_disabled()) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
 			schedule_work(&aux->work);
-- 
2.39.0

