Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC958F176
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiHJRTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiHJRTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:19:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 615B166108;
        Wed, 10 Aug 2022 10:19:10 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD3B5210C8B3;
        Wed, 10 Aug 2022 10:19:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD3B5210C8B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660151950;
        bh=I9tivlRZmScwBqrzns7/IP6T5HhyGbJqTY+zREu0RMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFll4N5NoZv1YGWF+Um4IKPdaf6s8oYssU0udmYz7UjNpEuq73LDcNdlvGxZncL1E
         sawqjXjcZ+PHk2XH/ynJzhKeoiqgZut2x+YtoPJTTRlvvlPjWBB9FPxCcedg1soDrD
         4949XW8tsSdTK48Mpo0WSU0zrlT0f6OeHxIHJqew=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH] for test purpose only: Add toy to play with BPF ring buffer.
Date:   Wed, 10 Aug 2022 19:16:55 +0200
Message-Id: <20220810171702.74932-5-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810171702.74932-1-flaniel@linux.microsoft.com>
References: <20220810171702.74932-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch should be applied on iovisor/bcc.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 libbpf-tools/Makefile  |  1 +
 libbpf-tools/toy.bpf.c | 32 ++++++++++++++++++++
 libbpf-tools/toy.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
 libbpf-tools/toy.h     |  4 +++
 4 files changed, 104 insertions(+)
 create mode 100644 libbpf-tools/toy.bpf.c
 create mode 100644 libbpf-tools/toy.c
 create mode 100644 libbpf-tools/toy.h

diff --git a/libbpf-tools/Makefile b/libbpf-tools/Makefile
index c3bbac27..904e7712 100644
--- a/libbpf-tools/Makefile
+++ b/libbpf-tools/Makefile
@@ -62,6 +62,7 @@ APPS = \
 	tcplife \
 	tcprtt \
 	tcpsynbl \
+	toy \
 	vfsstat \
 	#

diff --git a/libbpf-tools/toy.bpf.c b/libbpf-tools/toy.bpf.c
new file mode 100644
index 00000000..b6b8f92b
--- /dev/null
+++ b/libbpf-tools/toy.bpf.c
@@ -0,0 +1,32 @@
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <linux/bpf.h>
+#include "toy.h"
+
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+	__uint(map_flags, 1U << 13);
+} buffer SEC(".maps");
+
+static __u32 count = 0;
+
+SEC("tracepoint/syscalls/sys_enter_execve")
+int sys_enter_execve(void) {
+	count++;
+	struct event *event = bpf_ringbuf_reserve(&buffer, sizeof(struct event), 0);
+	if (!event) {
+		return 1;
+	}
+
+	event->count = count;
+	bpf_ringbuf_submit(event, 0);
+
+	bpf_printk("addr: %p; count: %u\n", event, count);
+	bpf_printk("available: %lu; cons pos: %lu; prod pos: %lu\n", bpf_ringbuf_query(&buffer, 0),  bpf_ringbuf_query(&buffer, BPF_RB_CONS_POS), bpf_ringbuf_query(&buffer, BPF_RB_PROD_POS));
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
\ No newline at end of file
diff --git a/libbpf-tools/toy.c b/libbpf-tools/toy.c
new file mode 100644
index 00000000..7e4f7fdf
--- /dev/null
+++ b/libbpf-tools/toy.c
@@ -0,0 +1,67 @@
+#include <bpf/libbpf.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "toy.h"
+#include "toy.skel.h"
+#include "btf_helpers.h"
+
+
+static int buf_process_sample(void *ctx, void *data, size_t len) {
+	struct event *evt = (struct event *)data;
+	printf("%d\n", evt->count);
+
+	return 0;
+}
+
+int main(void) {
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
+	int buffer_map_fd = -1;
+	struct toy_bpf *obj;
+	int err;
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	err = ensure_core_btf(&open_opts);
+	if (err) {
+		fprintf(stderr, "failed to fetch necessary BTF for CO-RE: %s\n", strerror(-err));
+		return 1;
+	}
+
+	obj = toy_bpf__open_opts(&open_opts);
+	if (!obj) {
+		fprintf(stderr, "failed to open BPF object\n");
+		return 1;
+	}
+
+	err = toy_bpf__load(obj);
+	if (err) {
+		fprintf(stderr, "failed to load BPF object: %d\n", err);
+		return 1;
+	}
+
+	struct ring_buffer *ring_buffer;
+
+	buffer_map_fd = bpf_object__find_map_fd_by_name(obj->obj, "buffer");
+	ring_buffer = ring_buffer__new(buffer_map_fd, buf_process_sample, NULL, NULL);
+
+	if(!ring_buffer) {
+		fprintf(stderr, "failed to create ring buffer\n");
+		return 1;
+	}
+
+	err = toy_bpf__attach(obj);
+	if (err) {
+		fprintf(stderr, "failed to attach BPF programs\n");
+		return 1;
+	}
+
+	puts("Press any key to begin consuming!");
+	getchar();
+
+	while(1) {
+		ring_buffer__consume(ring_buffer);
+		sleep(1);
+	}
+
+	return 0;
+}
diff --git a/libbpf-tools/toy.h b/libbpf-tools/toy.h
new file mode 100644
index 00000000..36998170
--- /dev/null
+++ b/libbpf-tools/toy.h
@@ -0,0 +1,4 @@
+struct event {
+	__u32 count;
+	char filler[4096 / 8 - sizeof(__u32)];
+};
\ No newline at end of file
--
2.25.1

