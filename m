Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD728483DB5
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiADIKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 03:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233852AbiADIJ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 03:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wC25vJidXOSulDOMTh98GoQfpZN9ZJGJe/vhERr1/WY=;
        b=EE05GDFr+C+XzLeJEPOStvJs2gtdMByWDDZd2qJ0RlRoXk2NZvjU2Kq4WlQThiwi3VY2Iy
        prsFSuyPXupEqxOeZoPenTyfSHG2Hp5xq9TzDMbCsEAA1u9bWFlv1AfQFoUlehxTWIGGNl
        Q7RWK4ly68OnMOrh5acp8CojLb7QtWA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-zqRBsE06Pg2ivVJS4aVj1Q-1; Tue, 04 Jan 2022 03:09:58 -0500
X-MC-Unique: zqRBsE06Pg2ivVJS4aVj1Q-1
Received: by mail-ed1-f70.google.com with SMTP id h6-20020a056402280600b003f9967993aeso3841484ede.10
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 00:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wC25vJidXOSulDOMTh98GoQfpZN9ZJGJe/vhERr1/WY=;
        b=GkKX73ho1ncPZtcKhwngsBLXHSrpWcN15UZ4doEJ5K5hSmBf4lZgIJpLg1+F10mC6x
         X/seAU6bcX5ET5bbsPXvsafIxoqg/FoDzqI+Y4MRr+w/LY5pgBlGoAEDojBElAo211iI
         xwDiA+s2NSBYqDvlv20agQTnxuMfMOsdPal3gV2Rh5VI9A6BAPvW3VA8J/B1sQTlMTW1
         c04RtOM0U4rIV+xBaAWAt0lnI0CwA5+EC3ItVL1xXygO19BGytIDb41ea8tjC7zHqpON
         mkjr3w/A1Sb3dthy0dzWI/CLp0AAPl9TzOFxhDghcG9i8bywCmaLdB6xSJlAdZf9vGCV
         5DEA==
X-Gm-Message-State: AOAM533iiqwgMjd54Ye/EQpUT1uJJd6DUrj8X3gJcF8tFb0VzhLwP7al
        sUszlNpwHDCwI9nob6xmg/GY2J9/Z4LY7kpmvU1wwVvs9QxGrOGtBxBcPJvDIJQwOBXQs6tlrdK
        fC/YvWWIGzu2i
X-Received: by 2002:a17:907:82a6:: with SMTP id mr38mr37035520ejc.744.1641283796931;
        Tue, 04 Jan 2022 00:09:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsV54Czj67uFIcbN98S4rvhYvKQh3lGyoyRpY5hJVl008UQ+Cuw2N++aiqMvvkhk7MQ3Geww==
X-Received: by 2002:a17:907:82a6:: with SMTP id mr38mr37035499ejc.744.1641283796706;
        Tue, 04 Jan 2022 00:09:56 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 19sm8284197ejv.207.2022.01.04.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:09:56 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 02/13] kprobe: Keep traced function address
Date:   Tue,  4 Jan 2022 09:09:32 +0100
Message-Id: <20220104080943.113249-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_get_func_ip_kprobe helper should return traced function
address, but it's doing so only for kprobes that are placed on
the function entry.

If kprobe is placed within the function, bpf_get_func_ip_kprobe
returns that address instead of function entry.

Storing the function entry directly in kprobe object, so it could
be used in bpf_get_func_ip_kprobe helper.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/kprobes.h                              |  3 +++
 kernel/kprobes.c                                     | 12 ++++++++++++
 kernel/trace/bpf_trace.c                             |  2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c |  4 ++--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c8f7a4d93af..a204df4fef96 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -74,6 +74,9 @@ struct kprobe {
 	/* Offset into the symbol */
 	unsigned int offset;
 
+	/* traced function address */
+	unsigned long func_addr;
+
 	/* Called before addr is executed. */
 	kprobe_pre_handler_t pre_handler;
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d20ae8232835..c4060a8da050 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1310,6 +1310,7 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 	copy_kprobe(p, ap);
 	flush_insn_slot(ap);
 	ap->addr = p->addr;
+	ap->func_addr = p->func_addr;
 	ap->flags = p->flags & ~KPROBE_FLAG_OPTIMIZED;
 	ap->pre_handler = aggr_pre_handler;
 	/* We don't care the kprobe which has gone. */
@@ -1588,6 +1589,16 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	return ret;
 }
 
+static unsigned long resolve_func_addr(kprobe_opcode_t *addr)
+{
+	char str[KSYM_SYMBOL_LEN];
+	unsigned long offset;
+
+	if (kallsyms_lookup((unsigned long) addr, NULL, &offset, NULL, str))
+		return (unsigned long) addr - offset;
+	return 0;
+}
+
 int register_kprobe(struct kprobe *p)
 {
 	int ret;
@@ -1600,6 +1611,7 @@ int register_kprobe(struct kprobe *p)
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 	p->addr = addr;
+	p->func_addr = resolve_func_addr(addr);
 
 	ret = warn_kprobe_rereg(p);
 	if (ret)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..25631253084a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1026,7 +1026,7 @@ BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct kprobe *kp = kprobe_running();
 
-	return kp ? (uintptr_t)kp->addr : 0;
+	return kp ? (uintptr_t)kp->func_addr : 0;
 }
 
 static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index a587aeca5ae0..e988aefa567e 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -69,7 +69,7 @@ int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test6_result = (const void *) addr == &bpf_fentry_test6 + 5;
+	test6_result = (const void *) addr == &bpf_fentry_test6;
 	return 0;
 }
 
@@ -79,6 +79,6 @@ int test7(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
 
-	test7_result = (const void *) addr == &bpf_fentry_test7 + 5;
+	test7_result = (const void *) addr == &bpf_fentry_test7;
 	return 0;
 }
-- 
2.33.1

