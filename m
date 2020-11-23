Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3DB2C09E3
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgKWNNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 08:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731730AbgKWNNo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 08:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606137222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNpTnhqVT/lkkDzOBStmitBv9qqoRpOHiUUiZ8tRN8I=;
        b=h2/ua5nF5dsGOZXkx1eQvZTzpL1KUtXtO3+tR4VTvI5rKutJmcMLajsUBS1ttRP6LQQ6Fb
        5bplkaahqzQtz7SKG2KXD7+UN9FKMiDIgL6GC1tGFXs4DDVgG9bjX0BjtowElb6lZwW3cL
        m14H2VQfA8ZjwwSzbVyM9YCBxDBi/O4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-7Tml3It8OCiElPBWMxf4gQ-1; Mon, 23 Nov 2020 08:13:40 -0500
X-MC-Unique: 7Tml3It8OCiElPBWMxf4gQ-1
Received: by mail-pg1-f200.google.com with SMTP id a20so12434702pgb.21
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 05:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNpTnhqVT/lkkDzOBStmitBv9qqoRpOHiUUiZ8tRN8I=;
        b=AhyZv/rxrnG/5Bx+XqAJSDbVMFpRmKeFSWv9bI5bsqsp7xPuMb4vwQCeNmu3EmggJp
         XWEoOYHVyvyoMmWJ6xRrheAmj/5Q/uyQ/2ldiPwjMo+1VvqXq/tOGkCpruLFWbKXL82l
         8Tez2Sci8EzLhGmGdGpbmOpMrB+iZi0W+o+SspCVebGb8gaMkqOGWXocn1YlKrRxNVc0
         BMr3WuK8DTnWKVdx6KCOk7myYPGCITh4uHBP5Pl+jDDOB8ZrLPeVfCPoLrhN68T38gA3
         EBnlbY/xdRf/fwoZkFqgsPFb8gCykIk0LTRTqxfAa26i0fv3sYiPq5Ivu7+vuN+yrLQB
         vreQ==
X-Gm-Message-State: AOAM530u73r700ROgjsW7PQ4P5r7YhHCW3N+1KS/eN7xs+TwEll7sylX
        kt3BPIWqQZFGjM+UasS9Syj0/sLs9KylXf4fT8u+9AMeCJiguzGM2EBfQbrpHvvHzvkpBqlNBPj
        0TZjH02P7488=
X-Received: by 2002:a17:90b:b15:: with SMTP id bf21mr19755400pjb.21.1606137219442;
        Mon, 23 Nov 2020 05:13:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBOG0l/Zu18yg12VyJ5W4oaN/nbRzZ/hwb8daUy6SRR3YTXPEHc0TkzVBcKsFuBUiomdjA+Q==
X-Received: by 2002:a17:90b:b15:: with SMTP id bf21mr19755375pjb.21.1606137219218;
        Mon, 23 Nov 2020 05:13:39 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 84sm12075505pfu.53.2020.11.23.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 05:13:38 -0800 (PST)
From:   Hangbin Liu <haliu@redhat.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hangbin Liu <haliu@redhat.com>
Subject: [PATCHv6 iproute2-next 5/5] examples/bpf: add bpf examples with BTF defined maps
Date:   Mon, 23 Nov 2020 21:12:01 +0800
Message-Id: <20201123131201.4108483-6-haliu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201123131201.4108483-1-haliu@redhat.com>
References: <20201116065305.1010651-1-haliu@redhat.com>
 <20201123131201.4108483-1-haliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Users should try use the new BTF defined maps instead of struct
bpf_elf_map defined maps. The tail call examples are not added yet
as libbpf doesn't currently support declaratively populating tail call
maps.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 examples/bpf/README           |  6 ++++
 examples/bpf/bpf_graft.c      | 66 +++++++++++++++++++++++++++++++++++
 examples/bpf/bpf_map_in_map.c | 55 +++++++++++++++++++++++++++++
 examples/bpf/bpf_shared.c     | 53 ++++++++++++++++++++++++++++
 include/bpf_api.h             | 13 +++++++
 5 files changed, 193 insertions(+)
 create mode 100644 examples/bpf/bpf_graft.c
 create mode 100644 examples/bpf/bpf_map_in_map.c
 create mode 100644 examples/bpf/bpf_shared.c

diff --git a/examples/bpf/README b/examples/bpf/README
index 732bcc83..b7261191 100644
--- a/examples/bpf/README
+++ b/examples/bpf/README
@@ -1,6 +1,12 @@
 eBPF toy code examples (running in kernel) to familiarize yourself
 with syntax and features:
 
+- BTF defined map examples
+ - bpf_graft.c		-> Demo on altering runtime behaviour
+ - bpf_shared.c 	-> Ingress/egress map sharing example
+ - bpf_map_in_map.c	-> Using map in map example
+
+- legacy struct bpf_elf_map defined map examples
  - legacy/bpf_shared.c		-> Ingress/egress map sharing example
  - legacy/bpf_tailcall.c	-> Using tail call chains
  - legacy/bpf_cyclic.c		-> Simple cycle as tail calls
diff --git a/examples/bpf/bpf_graft.c b/examples/bpf/bpf_graft.c
new file mode 100644
index 00000000..8066dcce
--- /dev/null
+++ b/examples/bpf/bpf_graft.c
@@ -0,0 +1,66 @@
+#include "../../include/bpf_api.h"
+
+/* This example demonstrates how classifier run-time behaviour
+ * can be altered with tail calls. We start out with an empty
+ * jmp_tc array, then add section aaa to the array slot 0, and
+ * later on atomically replace it with section bbb. Note that
+ * as shown in other examples, the tc loader can prepopulate
+ * tail called sections, here we start out with an empty one
+ * on purpose to show it can also be done this way.
+ *
+ * tc filter add dev foo parent ffff: bpf obj graft.o
+ * tc exec bpf dbg
+ *   [...]
+ *   Socket Thread-20229 [001] ..s. 138993.003923: : fallthrough
+ *   <idle>-0            [001] ..s. 138993.202265: : fallthrough
+ *   Socket Thread-20229 [001] ..s. 138994.004149: : fallthrough
+ *   [...]
+ *
+ * tc exec bpf graft m:globals/jmp_tc key 0 obj graft.o sec aaa
+ * tc exec bpf dbg
+ *   [...]
+ *   Socket Thread-19818 [002] ..s. 139012.053587: : aaa
+ *   <idle>-0            [002] ..s. 139012.172359: : aaa
+ *   Socket Thread-19818 [001] ..s. 139012.173556: : aaa
+ *   [...]
+ *
+ * tc exec bpf graft m:globals/jmp_tc key 0 obj graft.o sec bbb
+ * tc exec bpf dbg
+ *   [...]
+ *   Socket Thread-19818 [002] ..s. 139022.102967: : bbb
+ *   <idle>-0            [002] ..s. 139022.155640: : bbb
+ *   Socket Thread-19818 [001] ..s. 139022.156730: : bbb
+ *   [...]
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint32_t));
+	__uint(max_entries, 1);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} jmp_tc __section(".maps");
+
+__section("aaa")
+int cls_aaa(struct __sk_buff *skb)
+{
+	printt("aaa\n");
+	return TC_H_MAKE(1, 42);
+}
+
+__section("bbb")
+int cls_bbb(struct __sk_buff *skb)
+{
+	printt("bbb\n");
+	return TC_H_MAKE(1, 43);
+}
+
+__section_cls_entry
+int cls_entry(struct __sk_buff *skb)
+{
+	tail_call(skb, &jmp_tc, 0);
+	printt("fallthrough\n");
+	return BPF_H_DEFAULT;
+}
+
+BPF_LICENSE("GPL");
diff --git a/examples/bpf/bpf_map_in_map.c b/examples/bpf/bpf_map_in_map.c
new file mode 100644
index 00000000..39c86268
--- /dev/null
+++ b/examples/bpf/bpf_map_in_map.c
@@ -0,0 +1,55 @@
+#include "../../include/bpf_api.h"
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint32_t));
+	__uint(max_entries, 1);
+} map_inner __section(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint32_t));
+	__uint(max_entries, 1);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__array(values, struct inner_map);
+} map_outer __section(".maps") = {
+	.values = {
+		[0] = &map_inner,
+	},
+};
+
+__section("egress")
+int emain(struct __sk_buff *skb)
+{
+	struct bpf_elf_map *map_inner;
+	int key = 0, *val;
+
+	map_inner = map_lookup_elem(&map_outer, &key);
+	if (map_inner) {
+		val = map_lookup_elem(map_inner, &key);
+		if (val)
+			lock_xadd(val, 1);
+	}
+
+	return BPF_H_DEFAULT;
+}
+
+__section("ingress")
+int imain(struct __sk_buff *skb)
+{
+	struct bpf_elf_map *map_inner;
+	int key = 0, *val;
+
+	map_inner = map_lookup_elem(&map_outer, &key);
+	if (map_inner) {
+		val = map_lookup_elem(map_inner, &key);
+		if (val)
+			printt("map val: %d\n", *val);
+	}
+
+	return BPF_H_DEFAULT;
+}
+
+BPF_LICENSE("GPL");
diff --git a/examples/bpf/bpf_shared.c b/examples/bpf/bpf_shared.c
new file mode 100644
index 00000000..99a332f4
--- /dev/null
+++ b/examples/bpf/bpf_shared.c
@@ -0,0 +1,53 @@
+#include "../../include/bpf_api.h"
+
+/* Minimal, stand-alone toy map pinning example:
+ *
+ * clang -target bpf -O2 [...] -o bpf_shared.o -c bpf_shared.c
+ * tc filter add dev foo parent 1: bpf obj bpf_shared.o sec egress
+ * tc filter add dev foo parent ffff: bpf obj bpf_shared.o sec ingress
+ *
+ * Both classifier will share the very same map instance in this example,
+ * so map content can be accessed from ingress *and* egress side!
+ *
+ * This example has a pinning of PIN_OBJECT_NS, so it's private and
+ * thus shared among various program sections within the object.
+ *
+ * A setting of PIN_GLOBAL_NS would place it into a global namespace,
+ * so that it can be shared among different object files. A setting
+ * of PIN_NONE (= 0) means no sharing, so each tc invocation a new map
+ * instance is being created.
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(uint32_t));
+	__uint(value_size, sizeof(uint32_t));
+	__uint(max_entries, 1);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);	/* or LIBBPF_PIN_NONE */
+} map_sh __section(".maps");
+
+__section("egress")
+int emain(struct __sk_buff *skb)
+{
+	int key = 0, *val;
+
+	val = map_lookup_elem(&map_sh, &key);
+	if (val)
+		lock_xadd(val, 1);
+
+	return BPF_H_DEFAULT;
+}
+
+__section("ingress")
+int imain(struct __sk_buff *skb)
+{
+	int key = 0, *val;
+
+	val = map_lookup_elem(&map_sh, &key);
+	if (val)
+		printt("map val: %d\n", *val);
+
+	return BPF_H_DEFAULT;
+}
+
+BPF_LICENSE("GPL");
diff --git a/include/bpf_api.h b/include/bpf_api.h
index 89d3488d..82c47089 100644
--- a/include/bpf_api.h
+++ b/include/bpf_api.h
@@ -19,6 +19,19 @@
 
 #include "bpf_elf.h"
 
+/** libbpf pin type. */
+enum libbpf_pin_type {
+	LIBBPF_PIN_NONE,
+	/* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
+	LIBBPF_PIN_BY_NAME,
+};
+
+/** Type helper macros. */
+
+#define __uint(name, val) int (*name)[val]
+#define __type(name, val) typeof(val) *name
+#define __array(name, val) typeof(val) *name[]
+
 /** Misc macros. */
 
 #ifndef __stringify
-- 
2.25.4

