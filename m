Return-Path: <bpf+bounces-21305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECA884B584
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DC8B236EE
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B512E1E4;
	Tue,  6 Feb 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlHzucz9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0C12E1FB
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223591; cv=none; b=HBaLgMi5CyHTKR2ZMjuHwkY8FEDdfd/Nzl2uiDaqyOp08oIKis4+74iPZeI4iCYdHALZ6ZFizRg42qoJ2950LdyXLfl7m5z6YZu8yYRrXhzqZQCRI4NNP2HVtblzHUCQnNNPSDsd/Bxf1aaO38e0GzpP7VsbfmxFjLkNsbI8RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223591; c=relaxed/simple;
	bh=AJhsNy+Wr6DW638S3/Oj9BoElMobl3JIBLb1AkL/uNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRLFg/brpKP9Vkr0pvFTtY9vP2ixtnqp5IJnegSoLy/yPBdSQknLdKh1PNzoAIRAHeYwZKeywj1aSpRrhHD4G/Idz0IgUtDcgqgupj0P3kDd0USJyNO3s0PTBHJ5553+rhSqajwsNz/UzUu9Eu+rMC2rLwBME4ljHPExnPfP09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlHzucz9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707223588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVqRhVBJJSt7T9HBjp6nvIgWh4zUwyCEUnM42SQWhm8=;
	b=SlHzucz908h336TLzELJpjsT8vrewcziOBd8HS/ec2bTBl5Vx07n/fIYR/cbKDpva11m3T
	BVG4ez+JbCNyx76jpQXBvVVh+yfpwUMmO7t0plr2w2rfmGLY0LuiyAYgNshFHfxsrsjxqk
	bzNcInyAQaiavk4WXxpPPLTs40uU58E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-qFJAT6T7OmOogyd1TncvCQ-1; Tue,
 06 Feb 2024 07:46:25 -0500
X-MC-Unique: qFJAT6T7OmOogyd1TncvCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2265E1C07F2A;
	Tue,  6 Feb 2024 12:46:24 +0000 (UTC)
Received: from dhcph057.fit.vutbr.com (unknown [10.45.225.89])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B961121312;
	Tue,  6 Feb 2024 12:46:21 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next v4 2/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Tue,  6 Feb 2024 13:46:10 +0100
Message-ID: <7b6bff690919555574ce0f13d2a5996cacf7bf69.1707223196.git.vmalik@redhat.com>
In-Reply-To: <cover.1707223196.git.vmalik@redhat.com>
References: <cover.1707223196.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
build and afterwards patched by resolve_btfids with correct values.
Since resolve_btfids always writes in host-native endianness, it relies
on libelf to do the translation when the target ELF is cross-compiled to
a different endianness (this was introduced in commit 61e8aeda9398
("bpf: Fix libelf endian handling in resolv_btfids")).

Unfortunately, the translation will corrupt the flags fields of SET8
entries because these were written during vmlinux compilation and are in
the correct endianness already. This will lead to numerous selftests
failures such as:

    $ sudo ./test_verifier 502 502
    #502/p sleepable fentry accept FAIL
    Failed to load prog 'Invalid argument'!
    bpf_fentry_test1 is not sleepable
    verification time 34 usec
    stack depth 0
    processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
    Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

Since it's not possible to instruct libelf to translate just certain
values, let's manually bswap the flags (both global and entry flags) in
resolve_btfids when needed, so that libelf then translates everything
correctly.

Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 32634f00abba..d9520cb826b3 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -90,6 +90,14 @@
 
 #define ADDR_CNT	100
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+# define ELFDATANATIVE	ELFDATA2LSB
+#elif __BYTE_ORDER == __BIG_ENDIAN
+# define ELFDATANATIVE	ELFDATA2MSB
+#else
+# error "Unknown machine endianness!"
+#endif
+
 struct btf_id {
 	struct rb_node	 rb_node;
 	char		*name;
@@ -117,6 +125,7 @@ struct object {
 		int		 idlist_shndx;
 		size_t		 strtabidx;
 		unsigned long	 idlist_addr;
+		int		 encoding;
 	} efile;
 
 	struct rb_root	sets;
@@ -320,6 +329,7 @@ static int elf_collect(struct object *obj)
 {
 	Elf_Scn *scn = NULL;
 	size_t shdrstrndx;
+	GElf_Ehdr ehdr;
 	int idx = 0;
 	Elf *elf;
 	int fd;
@@ -351,6 +361,13 @@ static int elf_collect(struct object *obj)
 		return -1;
 	}
 
+	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
+		pr_err("FAILED cannot get ELF header: %s\n",
+			elf_errmsg(-1));
+		return -1;
+	}
+	obj->efile.encoding = ehdr.e_ident[EI_DATA];
+
 	/*
 	 * Scan all the elf sections and look for save data
 	 * from .BTF_ids section and symbols.
@@ -681,6 +698,24 @@ static int sets_patch(struct object *obj)
 			 */
 			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
 			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
+
+			/*
+			 * When ELF endianness does not match endianness of the
+			 * host, libelf will do the translation when updating
+			 * the ELF. This, however, corrupts SET8 flags which are
+			 * already in the target endianness. So, let's bswap
+			 * them to the host endianness and libelf will then
+			 * correctly translate everything.
+			 */
+			if (obj->efile.encoding != ELFDATANATIVE) {
+				int i;
+
+				set8->flags = bswap_32(set8->flags);
+				for (i = 0; i < set8->cnt; i++) {
+					set8->pairs[i].flags =
+						bswap_32(set8->pairs[i].flags);
+				}
+			}
 		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-- 
2.43.0


