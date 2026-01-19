Return-Path: <bpf+bounces-79408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806BD39CD0
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 988E2300A34D
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746826A1A4;
	Mon, 19 Jan 2026 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VceJT5/t"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6E21FF2A
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793196; cv=none; b=U0LUGxxdHXzBruGBtFKv6Txaqpo7l/MsjVUW1UbbqYuB4PsCEb9UODcnhXg+1DZwBf7BTooyBGLdweLBjwKk9b5L+v4rghL3JTyQFdmxWaj66HsA21NxMEhWaa+ec54w/2tAoiq6n5e7LTpP2bp9UeaSfBT7MQ7JuUhKsCeXrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793196; c=relaxed/simple;
	bh=oDGl3auAeZXO4XYXRZ0gANgpXVRHzHt7SXKT39Am37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of4IO6kzFcD9QrwfARjhMbC/zOyk9EhYmchqgO5VowTTaln8vF2WyhQAa2wu2eCzoEMlT2hsqFoz0jpECTZWg1Z57BFwFmdw0dZRI1FegpIFQ7mERk0ybcqAQntZGw7DO8RyOwpE97sIIv8WJoQpuXVUHPGQ/UKmuc0nHg9R6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VceJT5/t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugTOtriRaWK2mGaURO2PPvf5ie8qlQnqTxshN8BJKDc=;
	b=VceJT5/tZdQesL3wsnCCfKChysHdoI6Du7NSUlLjBq9ce+b888pSspUN2156uF+ifxSSG+
	iR3rVE15w8KlSsrmK9UKk8i21OaCkcpUZbHiFoSNxFQgKvJbK7/5TgI9hlIYOsGbco/T8r
	qaPl/tQipXlTlqYg3Dy4MZXpSWYJ2ec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-nvbzhAXAPeSDtbFAM1V6uA-1; Sun,
 18 Jan 2026 22:26:29 -0500
X-MC-Unique: nvbzhAXAPeSDtbFAM1V6uA-1
X-Mimecast-MFC-AGG-ID: nvbzhAXAPeSDtbFAM1V6uA_1768793187
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6C71800342;
	Mon, 19 Jan 2026 03:26:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16FB71955F22;
	Mon, 19 Jan 2026 03:26:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 06/13] kexec_file: Implement decompress method for parser
Date: Mon, 19 Jan 2026 11:24:17 +0800
Message-ID: <20260119032424.10781-7-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On arm64, there is no boot-time decompression for the kernel image.
Therefore, when a compressed kernel image is loaded, it must be
decompressed.

It is impractical to implement the complex decompression methods in BPF
bytecode. However, decompression routines exist in the kernel.  This
patch bridges the compressed data with the kernel's decompression
methods.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Kconfig.kexec      |   2 +-
 kernel/kexec_bpf_loader.c | 203 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 0c5d619820bcd..dbfdf34a78aa0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -49,7 +49,7 @@ config KEXEC_FILE
 config KEXEC_BPF
 	bool "Enable bpf-prog to parse the kexec image"
 	depends on KEXEC_FILE
-	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL && KEEP_DECOMPRESSOR
 	help
 	  This is a feature to run bpf section inside a kexec image file, which
 	  parses the image properly and help kernel set up kexec boot protocol
diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index dc59e1389da94..bd6a47fc53ed3 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -20,6 +20,7 @@
 #include <asm/byteorder.h>
 #include <asm/image.h>
 #include <asm/memory.h>
+#include <linux/decompress/generic.h>
 #include "kexec_internal.h"
 
 /* Load a ELF */
@@ -80,8 +81,210 @@ static int __init kexec_bpf_prog_run_init(void)
 }
 late_initcall(kexec_bpf_prog_run_init);
 
+#define KEXEC_BPF_CMD_DECOMPRESS	0x1
+
+#define KEXEC_BPF_SUBCMD_KERNEL		0x1
+#define KEXEC_BPF_SUBCMD_INITRD		0x2
+#define KEXEC_BPF_SUBCMD_CMDLINE	0x3
+
+struct cmd_hdr {
+	uint16_t cmd;
+	uint16_t subcmd;
+	uint32_t payload_len;
+} __packed;
+
+
+/* Max decompressed size is capped at 512M */
+#define MAX_UNCOMPRESSED_BUF_SIZE	(1 << 29)
+#define CHUNK_SIZE	(1 << 23)
+
+struct decompress_mem_allocator {
+	void *chunk_start;
+	unsigned int chunk_size;
+	void *chunk_cur;
+	unsigned int next_idx;
+	char **chunk_base_addr;
+};
+
+/*
+ * This global allocator for decompression is protected by kexec lock.
+ */
+static struct decompress_mem_allocator dcmpr_allocator;
+
+/*
+ * Set up an active chunk to hold partial decompressed data.
+ */
+static char *allocate_chunk_memory(void)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	char *p;
+
+	if (unlikely((a->next_idx * a->chunk_size >= MAX_UNCOMPRESSED_BUF_SIZE)))
+		return NULL;
+
+	p = __vmalloc(a->chunk_size, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!p)
+		return NULL;
+	a->chunk_base_addr[a->next_idx++] = p;
+	a->chunk_start = a->chunk_cur = p;
+
+	return p;
+}
+
+static int merge_decompressed_data(struct decompress_mem_allocator *a,
+			char **out, unsigned int *size)
+{
+	unsigned int last_chunk_sz = a->chunk_cur - a->chunk_start;
+	unsigned long total_sz;
+	char *dst, *cur_dst;
+	int i;
+
+	total_sz = (a->next_idx - 1) * a->chunk_size + last_chunk_sz;
+	cur_dst = dst = __vmalloc(total_sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!dst)
+		return -ENOMEM;
+
+	for (i = 0; i < a->next_idx - 1; i++) {
+		memcpy(cur_dst, a->chunk_base_addr[i], a->chunk_size);
+		cur_dst += a->chunk_size;
+		vfree(a->chunk_base_addr[i]);
+	}
+
+	memcpy(cur_dst, a->chunk_base_addr[i], last_chunk_sz);
+	vfree(a->chunk_base_addr[i]);
+	*out = dst;
+	*size = total_sz;
+
+	return 0;
+}
+
+static int decompress_mem_allocator_init(
+	struct decompress_mem_allocator *a,
+	unsigned int chunk_size)
+{
+	unsigned long sz = (MAX_UNCOMPRESSED_BUF_SIZE / chunk_size) * sizeof(void *);
+	char *buf;
+
+	a->chunk_base_addr = __vmalloc(sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!a->chunk_base_addr)
+		return -ENOMEM;
+
+	/* Pre-allocate the memory for the first chunk */
+	buf = __vmalloc(chunk_size, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!buf) {
+		vfree(a->chunk_base_addr);
+		return -ENOMEM;
+	}
+	a->chunk_base_addr[0] = buf;
+	a->chunk_start = a->chunk_cur = buf;
+	a->chunk_size = chunk_size;
+	a->next_idx = 1;
+	return 0;
+}
+
+static void decompress_mem_allocator_fini(struct decompress_mem_allocator *a)
+{
+	vfree(a->chunk_base_addr);
+}
+
+/*
+ * This is a callback for decompress_fn.
+ *
+ * It copies the partial decompressed content in [buf, buf + len) to dst. If the
+ * active chunk is not large enough, retire it and activate a new chunk to hold
+ * the remaining data.
+ */
+static long flush(void *buf, unsigned long len)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	long free, copied = 0;
+
+	if (unlikely(len > a->chunk_size)) {
+		pr_info("Chunk size is too small to hold decompressed data\n");
+		return -1;
+	}
+	free = a->chunk_start + a->chunk_size - a->chunk_cur;
+	BUG_ON(free < 0);
+	if (free < len) {
+		memcpy(a->chunk_cur, buf, free);
+		copied += free;
+		a->chunk_cur += free;
+		buf += free;
+		len -= free;
+		a->chunk_start = a->chunk_cur = allocate_chunk_memory();
+		if (unlikely(!a->chunk_start)) {
+			pr_info("Decompression runs out of memory\n");
+			return -1;
+		}
+	}
+	memcpy(a->chunk_cur, buf, len);
+	copied += len;
+	a->chunk_cur += len;
+	return copied;
+}
+
+static int parser_cmd_decompress(char *compressed_data, int image_gz_sz,
+		char **out_buf, int *out_sz, struct kexec_context *ctx)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	decompress_fn decompressor;
+	const char *name;
+	int ret;
+
+	decompress_mem_allocator_init(a, CHUNK_SIZE);
+	decompressor = decompress_method(compressed_data, image_gz_sz, &name);
+	if (!decompressor) {
+		pr_err("Can not find decompress method\n");
+		return -1;
+	}
+	pr_debug("Find decompressing method: %s, compressed sz:0x%x\n",
+			name, image_gz_sz);
+	ret = decompressor(compressed_data, image_gz_sz, NULL, flush,
+				NULL, NULL, NULL);
+	if (!!ret)
+		goto err;
+	ret = merge_decompressed_data(a, out_buf, out_sz);
+
+err:
+	decompress_mem_allocator_fini(a);
+
+	return ret;
+}
+
 static int kexec_buff_parser(struct bpf_parser_context *parser)
 {
+	struct bpf_parser_buf *pbuf = parser->buf;
+	struct kexec_context *ctx = (struct kexec_context *)parser->data;
+	struct cmd_hdr *cmd = (struct cmd_hdr *)pbuf->buf;
+	char *decompressed_buf, *buf, *p;
+	int decompressed_sz, ret;
+
+	buf = pbuf->buf + sizeof(struct cmd_hdr);
+	if (cmd->payload_len + sizeof(struct cmd_hdr) > pbuf->size) {
+		pr_info("Invalid payload size:0x%x, while buffer size:0x%x\n",
+				cmd->payload_len, pbuf->size);
+		return -EINVAL;
+	}
+	switch (cmd->cmd) {
+	case KEXEC_BPF_CMD_DECOMPRESS:
+		ret = parser_cmd_decompress(buf, cmd->payload_len, &decompressed_buf,
+					&decompressed_sz, ctx);
+		if (!ret) {
+			switch (cmd->subcmd) {
+			case KEXEC_BPF_SUBCMD_KERNEL:
+				vfree(ctx->kernel);
+				ctx->kernel = decompressed_buf;
+				ctx->kernel_sz = decompressed_sz;
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.49.0


