Return-Path: <bpf+bounces-29538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F88C2A9F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A57E281AE2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF478287E;
	Fri, 10 May 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4oGExQT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22167502AE;
	Fri, 10 May 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369069; cv=none; b=b3ju361kKz8EiwoQk0cLAN/XximVnUnR5OG3fdch2RSdA7eUFfrqdNMa+/iOMleSPkSkxvNs0WeJHPxlKnI7PoV9F3+DXkv1vMU66/WmWufYIyqi1NKFkyL/CRkYJ5Q/gFNfae4Ia33DRCLJXtPE739nwIMiLKdn/97cPyEpLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369069; c=relaxed/simple;
	bh=Fs1kE8T0Hjn3Bl3AxSlYEf44BYhAIFciOjWKpPT6NG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwkZIRSuUb4REX7CYR6uB91V95JfZ4uHUtMEy8hndoNw8TAQTxmtK4pCwxYVMlqYkk0VQlt8A2CjGsA3JlDKInKFFp6maXivrpFopQSfZR1swEiD3dhB9sIcrz8pttT7/JrDA76pzDmwH5GDQ3kHfLRxA1X4NTfZys23nc6rme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4oGExQT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43d2277d7e1so11544181cf.1;
        Fri, 10 May 2024 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369067; x=1715973867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgS7VqnllBlrll6Bn1u4GTToL8zBqJUYSEmej4G9S7c=;
        b=I4oGExQTvwbe0LDZgmaUvxgXoYkg0iMC7czug719QfUadG+VW0d6wnbnbWQPmDGOCd
         shO3IxtetDsf+tyARNdUwlS2JMjzIQzf5qiejagQPdMbTsWWmCco1obVUM2Xrg4rB1lX
         Ik38MVDykeVPll7jALIOZCK6RVswoomAIGzSKgKZKzumXplRZ7DF7vFa0dc3QqVkHO8/
         EBYtgTG33lcITVf30oDcnMrGaCeGDEujsOP5FUXN1qkAfn12JBCxRu7oI6d0JY1o09lE
         ypC6KMGdoWk0oPjOxGXKODNeED/ADJFSULWy3YCIjPiFInXsNCdwOfPdGKhmnmG/aAF9
         uQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369067; x=1715973867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgS7VqnllBlrll6Bn1u4GTToL8zBqJUYSEmej4G9S7c=;
        b=Ylj6Bs3BxBmAtMoqYm/98AuZRRk17t8hvN+dDqR5yjVp+VwZg5f99Oq2TYfwemKyXY
         sJvuCgokwRiuyRX8kqhC7UuTyQM0sP1ve5icUb4iKbplWLR63deBIzpRXar0h7phF0TP
         +s+jBcFIk2Qu4KEjNhw9xiUtJVFQtSYczf/OdR7Bqaq5mvy/5Yxd70+7kSTpdxMHh6Rs
         zu82LWj7zxOcVHobmPb1znaR5hFgkOzGDREUAYIYKCqQuiuQDYTAeTazdA7FREOvfNJO
         7Vm6gmLIBr76CSLjS3XdZfv912koGy+UsuHu/hTFiJqcCq8/VFZcR2IY293/+gqa+H9S
         hndw==
X-Gm-Message-State: AOJu0YwIWLIk236m4gPLNkNjCmgua9mDHp2wBAvFIfb+62bQJUlmBWoj
	QHJ6ito8ZPGMP0tk645HGzLQ9qxW/pyS3Ycrv3JzDRn9hwqVpQjbOqmR2Q==
X-Google-Smtp-Source: AGHT+IFFrkTO44IZwACSfZWIPVWCj+enc1xe9b2thGeTuz7H6z6Ys5Kbrji6PLrX0zCCooXSXKODpw==
X-Received: by 2002:a05:622a:5c15:b0:43d:f232:dfb3 with SMTP id d75a77b69052e-43dfdb69357mr55894671cf.47.1715369067082;
        Fri, 10 May 2024 12:24:27 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 20/20] selftests: Add a prio bpf qdisc
Date: Fri, 10 May 2024 19:24:12 +0000
Message-Id: <20240510192412.3297104-21-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test implements a classful qdisc using bpf. The prio qdisc, like
its native counterpart, has 16 bands. An skb is classified into a band
based on its priority. During dequeue, the band with the lowest priority
value are tried first. The bpf prio qdisc populates the classes during
initialization with pfifo qdisc, and we later change them to be fq qdiscs.
A direct queue using bpf list is provided to make sure the traffic will
be always flowing even if qdiscs in all bands are removed.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  52 +++++++-
 .../selftests/bpf/progs/bpf_qdisc_prio.c      | 112 ++++++++++++++++++
 2 files changed, 160 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_prio.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index ec9c0d166e89..e1e80fb3c52d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -2,9 +2,11 @@
 #include <linux/rtnetlink.h>
 #include <test_progs.h>
 
+#include "netlink_helpers.h"
 #include "network_helpers.h"
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
+#include "bpf_qdisc_prio.skel.h"
 
 struct crndstate {
 	u32 last;
@@ -65,7 +67,7 @@ static void *server(void *arg)
 	return NULL;
 }
 
-static void do_test(char *qdisc)
+static void do_test(char *qdisc, int (*setup)(void))
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
 			    .attach_point = BPF_TC_QDISC,
@@ -87,6 +89,12 @@ static void do_test(char *qdisc)
 	if (!ASSERT_OK(err, "attach qdisc"))
 		return;
 
+	if (setup) {
+		err = setup();
+		if (!ASSERT_OK(err, "setup qdisc"))
+			return;
+	}
+
 	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (!ASSERT_NEQ(lfd, -1, "socket")) {
 		bpf_tc_hook_destroy(&hook);
@@ -156,7 +164,7 @@ static void test_fifo(void)
 		return;
 	}
 
-	do_test("bpf_fifo");
+	do_test("bpf_fifo", NULL);
 
 	bpf_link__destroy(link);
 	bpf_qdisc_fifo__destroy(fifo_skel);
@@ -177,7 +185,7 @@ static void test_fq(void)
 		return;
 	}
 
-	do_test("bpf_fq");
+	do_test("bpf_fq", NULL);
 
 	bpf_link__destroy(link);
 	bpf_qdisc_fq__destroy(fq_skel);
@@ -198,12 +206,46 @@ static void test_netem(void)
 		return;
 	}
 
-	do_test("bpf_netem");
+	do_test("bpf_netem", NULL);
 
 	bpf_link__destroy(link);
 	bpf_qdisc_netem__destroy(netem_skel);
 }
 
+static int setup_prio_bands(void)
+{
+	char cmd[128];
+	int i;
+
+	for (i = 1; i <= 16; i++) {
+		snprintf(cmd, sizeof(cmd), "tc qdisc add dev lo parent 800:%x handle %x0: fq", i, i);
+		if (!ASSERT_OK(system(cmd), cmd))
+			return -1;
+	}
+	return 0;
+}
+
+static void test_prio_qdisc(void)
+{
+	struct bpf_qdisc_prio *prio_skel;
+	struct bpf_link *link;
+
+	prio_skel = bpf_qdisc_prio__open_and_load();
+	if (!ASSERT_OK_PTR(prio_skel, "bpf_qdisc_prio__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(prio_skel->maps.prio);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_prio__destroy(prio_skel);
+		return;
+	}
+
+	do_test("bpf_prio", &setup_prio_bands);
+
+	bpf_link__destroy(link);
+	bpf_qdisc_prio__destroy(prio_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	if (test__start_subtest("fifo"))
@@ -212,4 +254,6 @@ void test_bpf_qdisc(void)
 		test_fq();
 	if (test__start_subtest("netem"))
 		test_netem();
+	if (test__start_subtest("prio"))
+		test_prio_qdisc();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_prio.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_prio.c
new file mode 100644
index 000000000000..9a7797a7ed9d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_prio.c
@@ -0,0 +1,112 @@
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(B) struct bpf_spin_lock direct_queue_lock;
+private(B) struct bpf_list_head direct_queue __contains_kptr(sk_buff, bpf_list);
+
+unsigned int q_limit = 1000;
+unsigned int q_qlen = 0;
+
+SEC("struct_ops/bpf_prio_enqueue")
+int BPF_PROG(bpf_prio_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	u32 classid = sch->handle | (skb->priority & TC_PRIO_MAX);
+
+	if (bpf_qdisc_find_class(sch, classid))
+		return bpf_qdisc_enqueue(skb, sch, classid, to_free);
+
+	q_qlen++;
+	if (q_qlen > q_limit) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_spin_lock(&direct_queue_lock);
+	bpf_list_excl_push_back(&direct_queue, &skb->bpf_list);
+	bpf_spin_unlock(&direct_queue_lock);
+
+	return NET_XMIT_SUCCESS;
+}
+
+SEC("struct_ops/bpf_prio_dequeue")
+struct sk_buff *BPF_PROG(bpf_prio_dequeue, struct Qdisc *sch)
+{
+	struct bpf_list_excl_node *node;
+	struct sk_buff *skb;
+	u32 i, classid;
+
+	bpf_spin_lock(&direct_queue_lock);
+	node = bpf_list_excl_pop_front(&direct_queue);
+	bpf_spin_unlock(&direct_queue_lock);
+	if (!node) {
+		for (i = 0; i <= TC_PRIO_MAX; i++) {
+			classid = sch->handle | i;
+			skb = bpf_qdisc_dequeue(sch, classid);
+			if (skb)
+				return skb;
+		}
+		return NULL;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_list);
+	bpf_skb_set_dev(skb, sch);
+	q_qlen--;
+
+	return skb;
+}
+
+SEC("struct_ops/bpf_prio_init")
+int BPF_PROG(bpf_prio_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	int i, err;
+
+	for (i = 1; i <= TC_PRIO_MAX + 1; i++) {
+		err = bpf_qdisc_create_child(sch, i, extack);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int reset_direct_queue(u32 index, void *ctx)
+{
+	struct bpf_list_excl_node *node;
+	struct sk_buff *skb;
+
+	bpf_spin_lock(&direct_queue_lock);
+	node = bpf_list_excl_pop_front(&direct_queue);
+	bpf_spin_unlock(&direct_queue_lock);
+
+	if (!node) {
+		return 1;
+	}
+
+	skb = container_of(node, struct sk_buff, bpf_list);
+	bpf_skb_release(skb);
+	return 0;
+}
+
+SEC("struct_ops/bpf_prio_reset")
+void BPF_PROG(bpf_prio_reset, struct Qdisc *sch)
+{
+	bpf_loop(q_qlen, reset_direct_queue, NULL, 0);
+	q_qlen = 0;
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops prio = {
+	.enqueue   = (void *)bpf_prio_enqueue,
+	.dequeue   = (void *)bpf_prio_dequeue,
+	.init      = (void *)bpf_prio_init,
+	.reset     = (void *)bpf_prio_reset,
+	.id        = "bpf_prio",
+};
+
-- 
2.20.1


