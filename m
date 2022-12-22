Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AFE653A03
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLVANt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 19:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVANs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 19:13:48 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B57E01F
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:13:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j16so284464qtv.4
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 16:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPzh2dbi9FRQxXaS+QFT/IvLSNioUpOLK0ga4/GiNMM=;
        b=Xu/SLYOMU7MF3QWuwd+MtAim+OUAEh91ceKVKnX6WHubwdQe9ciea27Gk3f4B0I+Uq
         NmBc1I67JmsdaV5tLShxYGi6j546GTh5TLt0VakXnxw7V5rIzLrhquO2InL3r4gzeiwZ
         wJqm7fq45+IOmhY9ZmRaAPS4OTuSJ9pQ5dTPBYbsLiVaVEl4z/s4poZ38rcLO9WPfD0v
         t/kcmZsfCmzPHrpt1fop/R2l6JQGaK48r0TKOibtDOkBf6NU0RZods9yVZ0Fq7iyFLQ+
         Dgvp/rEwmN6Ffd3ewwa7bLRceN4Ec4R37azK3fLr/sp2U5uAC31pNqZ6pRG5E+B3TPy4
         UIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPzh2dbi9FRQxXaS+QFT/IvLSNioUpOLK0ga4/GiNMM=;
        b=Q2OwOzYB+pg5G/WFoSJ/YWzzmaPhJt971CIK7G8Uc8pmhEmCpHNZAF8UvnWHc/g0Gt
         VHQ/oO6gA2HVawh9ljofqj8MxTyIjkdG2wEZtgtwB9lZZ+XsB59DjqRQSqNlM0zWdNFi
         FsCU+k0uL3RKGE2cuwktqO5DjmhCu8rfNZW4rpgSzqHjd26QNJuhU+PVa+NfXd6xI5mC
         posm77IWX2kV2wDjQaHXLBraL1ZgJul3aMuy5PCqHQgTt6BOQ3WX3WRSX8F9kSIgGa+9
         UUMLfgAMa8DAcUqG7D6xfJZZk6gQNqjaWrbK6IqIp8QBDsZp1WsRP5rG6bWiEfgIlAas
         Q5jA==
X-Gm-Message-State: AFqh2kqJGfCjlIvMVautGFFrqER6SlBWrHjzhEJLJc/CgIWcBNqVB8cr
        1inimVO8frGMqNLDxyjilfsmaYqflRUqwHM=
X-Google-Smtp-Source: AMrXdXtusb1TB1KZjoCKCo/VF/OzLXSSem8vfyVqgYxAlWc4hMDJeejvKL/XVKnVip6GovUHBocaNw==
X-Received: by 2002:ac8:749a:0:b0:3a8:2a89:d57d with SMTP id v26-20020ac8749a000000b003a82a89d57dmr4732033qtq.67.1671668024957;
        Wed, 21 Dec 2022 16:13:44 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id c3-20020ac80543000000b003a6a7a20575sm9962621qth.73.2022.12.21.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:13:44 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Burn Alting <burn.alting@iinet.net.au>
Subject: [PATCH] bpf: restore the ebpf audit UNLOAD id field
Date:   Wed, 21 Dec 2022 19:13:43 -0500
Message-Id: <20221222001343.489117-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When changing the ebpf program put() routines to support being called
from within IRQ context the program ID was reset to zero prior to
generating the audit UNLOAD record, which obviously rendered the ID
field bogus (always zero).  This patch resolves this by adding a new
field, bpf_prog_aux::id_audit, which is set when the ebpf program is
allocated an ID and never reset, ensuring a valid ID field,
regardless of the state of the original ID field, bpf_prox_aud::id.

I also modified the bpf_audit_prog() logic used to associate the
AUDIT_BPF record with other associated records, e.g. @ctx != NULL.
Instead of keying off the operation, it now keys off the execution
context, e.g. '!in_irg && !irqs_disabled()', which is much more
appropriate and should help better connect the UNLOAD operations with
the associated audit state (other audit records).

As an note to future bug hunters, I did briefly consider removing the
ID reset in bpf_prog_free_id(), as it would seem that once the
program is removed from the idr pool it can no longer be found by its
ID value, but commit ad8ad79f4f60 ("bpf: offload: free program id
when device disappears") seems to imply that it is beneficial to
reset the ID value.  Perhaps as a secondary indicator that the ebpf
program is unbound/orphaned.

Fixes: d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
Reported-by: Burn Alting <burn.alting@iinet.net.au>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/syscall.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..a22001ceb2c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1103,6 +1103,7 @@ struct bpf_prog_aux {
 	u32 max_tp_access;
 	u32 stack_depth;
 	u32 id;
+	u32 id_audit; /* preserves the id for use by audit */
 	u32 func_cnt; /* used by non-func prog as the number of func progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..3ec09f4dba18 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1958,13 +1958,13 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 		return;
 	if (audit_enabled == AUDIT_OFF)
 		return;
-	if (op == BPF_AUDIT_LOAD)
+	if (!in_irq() && !irqs_disabled())
 		ctx = audit_context();
 	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
 		return;
 	audit_log_format(ab, "prog-id=%u op=%s",
-			 prog->aux->id, bpf_audit_str[op]);
+			 prog->aux->id_audit, bpf_audit_str[op]);
 	audit_log_end(ab);
 }
 
@@ -1975,8 +1975,10 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
 	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&prog_idr_lock);
 	id = idr_alloc_cyclic(&prog_idr, prog, 1, INT_MAX, GFP_ATOMIC);
-	if (id > 0)
+	if (id > 0) {
 		prog->aux->id = id;
+		prog->aux->id_audit = id;
+	}
 	spin_unlock_bh(&prog_idr_lock);
 	idr_preload_end();
 
-- 
2.39.0

