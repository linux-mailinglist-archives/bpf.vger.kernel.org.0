Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D571B136E
	for <lists+bpf@lfdr.de>; Mon, 20 Apr 2020 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTRqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Apr 2020 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDTRqP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Apr 2020 13:46:15 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6907C061A0C
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2020 10:46:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j16so10409903pgg.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2020 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3iXQxKcuXaH8vzSpbGGcKpQZHWkV+5aV8X0i1N4Bpxk=;
        b=B6W1ZkQ9tWFz7CTJtZRpZ1kDQ+Ot2Nwvx39cPSbTt4Q6iafsvUXna2HfYYp2DFLaVM
         87sz6sjlUTMACC0ojyCtRsLjqNm1yZKQs7nH78xehNSZPhihvfN0PD7B85scIkEYU+Tg
         2pXoyDNzuzEFOTu83wNgBoC70N8Gqj8l5YF1qNEiN1H2l7BnZamTLBgKiq9uzPGCmQGB
         2mfLxL1PxLor7ufpXBgdHcIxXiVijW/kVHQHPKkh3MV0A1i9vNooWyw7y49uAvVbfje6
         t7SXbRH0CRinxRDcvmUTQzbnEkB78FyMVNn6fu+pCIe0Af9COJVSvBQknPkjrcZAtOlW
         ytzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3iXQxKcuXaH8vzSpbGGcKpQZHWkV+5aV8X0i1N4Bpxk=;
        b=WHtq8seVNBNocCbpDUisMWsTnRA7K/IXgpW2DTQNzOE1uZXu+eZfOS/wtQJS9kGeFU
         K5TZ6ZORBzkKpcK1UqdTSI7gPdehHgstk4mi/Xqwn2zpJstNz6vvWjvf5hVTmjXIPJhU
         NGSv8/tBEg8R0bgYqik08Gca72RgcXM2oWbj2xWd5Y5XimUCxQ2upxUl/ORXDA/tNNcc
         VHRvXLFbF9G+/uXeW/RhzFPkSlcrC6HQHPat3NiVthu92Ovs2CcYSrlFNhMUwORzrNrj
         4fQSFW0rINTQzx7otpDKz6JTVy0XAKxXKbSklLxCw5efKywUPYI1tyyeXHhfpxhMWOIp
         9xzA==
X-Gm-Message-State: AGi0PubGB3vZPXX98IrNwX5TZTFYGyWnWjBkmHQBT19eSQYlvhnUUrYs
        1lsazBHrmTu3mh2xqLmjt0Vgi7I=
X-Google-Smtp-Source: APiQypJZPGdilOYNFpUob02zkWIVVcrQoPOcD71XeBNOpymxoDCLA+wFgJWr7K1tYMXQZzq8J3zO6Dw=
X-Received: by 2002:a63:4f0a:: with SMTP id d10mr12344458pgb.146.1587404773093;
 Mon, 20 Apr 2020 10:46:13 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:46:10 -0700
Message-Id: <20200420174610.77494-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH bpf-next] bpf: enable more helpers for BPF_PROG_TYPE_CGROUP_{DEVICE,SYSCTL,SOCKOPT}
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the following prog types don't fall back to bpf_base_func_proto()
(instead they have cgroup_base_func_proto which has a limited set of
helpers from bpf_base_func_proto):
* BPF_PROG_TYPE_CGROUP_DEVICE
* BPF_PROG_TYPE_CGROUP_SYSCTL
* BPF_PROG_TYPE_CGROUP_SOCKOPT

I don't see any specific reason why we shouldn't use bpf_base_func_proto(),
every other type of program (except bpf-lirc and, understandably, tracing)
use it, so let's fall back to bpf_base_func_proto for those prog types
as well.

This basically boils down to adding access to the following helpers:
* BPF_FUNC_get_prandom_u32
* BPF_FUNC_get_smp_processor_id
* BPF_FUNC_get_numa_node_id
* BPF_FUNC_tail_call
* BPF_FUNC_ktime_get_ns
* BPF_FUNC_spin_lock (CAP_SYS_ADMIN)
* BPF_FUNC_spin_unlock (CAP_SYS_ADMIN)
* BPF_FUNC_jiffies64 (CAP_SYS_ADMIN)

I've also added bpf_perf_event_output() because it's really handy for
logging and debugging.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h                           |  1 +
 kernel/bpf/cgroup.c                           | 20 +++-------------
 net/core/filter.c                             |  2 +-
 .../selftests/bpf/verifier/event_output.c     | 24 +++++++++++++++++++
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fd2b2322412d..25da6ff2a880 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,6 +1523,7 @@ extern const struct bpf_func_proto bpf_strtoul_proto;
 extern const struct bpf_func_proto bpf_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
+extern const struct bpf_func_proto bpf_event_output_data_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index cb305e71e7de..4d748c5785bc 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1060,30 +1060,16 @@ static const struct bpf_func_proto *
 cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
-	case BPF_FUNC_map_lookup_elem:
-		return &bpf_map_lookup_elem_proto;
-	case BPF_FUNC_map_update_elem:
-		return &bpf_map_update_elem_proto;
-	case BPF_FUNC_map_delete_elem:
-		return &bpf_map_delete_elem_proto;
-	case BPF_FUNC_map_push_elem:
-		return &bpf_map_push_elem_proto;
-	case BPF_FUNC_map_pop_elem:
-		return &bpf_map_pop_elem_proto;
-	case BPF_FUNC_map_peek_elem:
-		return &bpf_map_peek_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_local_storage:
 		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_get_current_cgroup_id:
 		return &bpf_get_current_cgroup_id_proto;
-	case BPF_FUNC_trace_printk:
-		if (capable(CAP_SYS_ADMIN))
-			return bpf_get_trace_printk_proto();
-		/* fall through */
+	case BPF_FUNC_perf_event_output:
+		return &bpf_event_output_data_proto;
 	default:
-		return NULL;
+		return bpf_base_func_proto(func_id);
 	}
 }
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 7d6ceaa54d21..a943df3ad8b0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4214,7 +4214,7 @@ BPF_CALL_5(bpf_event_output_data, void *, ctx, struct bpf_map *, map, u64, flags
 	return bpf_event_output(map, flags, data, size, NULL, 0, NULL);
 }
 
-static const struct bpf_func_proto bpf_event_output_data_proto =  {
+const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.func		= bpf_event_output_data,
 	.gpl_only       = true,
 	.ret_type       = RET_INTEGER,
diff --git a/tools/testing/selftests/bpf/verifier/event_output.c b/tools/testing/selftests/bpf/verifier/event_output.c
index 130553e19eca..99f8f582c02b 100644
--- a/tools/testing/selftests/bpf/verifier/event_output.c
+++ b/tools/testing/selftests/bpf/verifier/event_output.c
@@ -92,3 +92,27 @@
 	.result = ACCEPT,
 	.retval = 1,
 },
+{
+	"perfevent for cgroup dev",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_CGROUP_DEVICE,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for cgroup sysctl",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for cgroup sockopt",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
-- 
2.26.1.301.g55bc3eb7cb9-goog

