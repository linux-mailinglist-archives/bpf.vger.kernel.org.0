Return-Path: <bpf+bounces-20083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86C838E28
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B45DB21E39
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DB5D91A;
	Tue, 23 Jan 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLo32G1C"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B114A96
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011691; cv=none; b=KOoobEbiOKzFSnqp6UpiKixn0GiEdfNcvukfE2AV9SHTRfqbFBrTLZfttp134WWILQGjoWZyX9YYgpSJfk64DOkVW6xDNUiLKkWY+Fmy4c0M4z8BYTgg02JyCtz7rKSLFvWao9jcl8q4o8rChjEtpW82PW8SUbJPvnxxhUULM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011691; c=relaxed/simple;
	bh=qvx5DR1gIOoWwHlELzA6AuAKRxJCm45tUv43ko/em3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUVqApLicSC1gL4W0qvOwhmLyXfhJY6X/MYQEhb6CiN72CvuENSuTs1TAJQ2ahNLZKpmX4BGwUJW2k7b9Id1Q/JQpjh0+iHJxsHqBUqv7Vbas0hvSkTnHFH3TvyPrsXwYCx4WJF9QcA5azSOqEiQz7GJvksRqwAnYJhKJz/LIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLo32G1C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706011689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YHLQIQqLV5TO5BCt8/mmmzMIG7ygOOBAOoLbOZmzcNc=;
	b=aLo32G1CZ4a5S1V+a5J/j3o93c0Bk3pqEarZbJvPjw1lTpJ/ATORxh81fAAFJRv+mib9qN
	ivB6/1hVQdTblt/fyg1YV1Kxrl2pGBwKrbrW0CfjuZzqJgdlczSzJDxe0Q51qJZJGv5Qsu
	6HE3DWGuNua9tvoQ2tpI7FfEEs+Sw+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-MNJeEAktMIayWPLxDZxAwQ-1; Tue, 23 Jan 2024 07:08:05 -0500
X-MC-Unique: MNJeEAktMIayWPLxDZxAwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D67A86F129;
	Tue, 23 Jan 2024 12:08:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 109FB40C106C;
	Tue, 23 Jan 2024 12:08:01 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Viktor Malik <vmalik@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Tue, 23 Jan 2024 13:07:59 +0100
Message-ID: <20240123120759.1865189-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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
values, let's manually bswap the flags in resolve_btfids when needed, so
that libelf then translates everything correctly.

Fixes: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/bpf/resolve_btfids/main.c | 35 +++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 27a23196d58e..440d3d066ce4 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -646,18 +646,31 @@ static int cmp_id(const void *pa, const void *pb)
 	return *a - *b;
 }
 
+static int need_bswap(int elf_byte_order)
+{
+	return __BYTE_ORDER == __LITTLE_ENDIAN && elf_byte_order != ELFDATA2LSB ||
+	       __BYTE_ORDER == __BIG_ENDIAN && elf_byte_order != ELFDATA2MSB;
+}
+
 static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
 	int *ptr = data->d_buf;
 	struct rb_node *next;
+	GElf_Ehdr ehdr;
+
+	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
+		pr_err("FAILED cannot get ELF header: %s\n",
+			elf_errmsg(-1));
+		return -1;
+	}
 
 	next = rb_first(&obj->sets);
 	while (next) {
-		unsigned long addr, idx;
+		unsigned long addr, idx, flags;
 		struct btf_id *id;
 		int *base;
-		int cnt;
+		int cnt, i;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
@@ -679,6 +692,24 @@ static int sets_patch(struct object *obj)
 
 		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
 
+		/*
+		 * When ELF endianness does not match endianness of the host,
+		 * libelf will do the translation when updating the ELF. This,
+		 * however, corrupts SET8 flags which are already in the target
+		 * endianness. So, let's bswap them to the host endianness and
+		 * libelf will then correctly translate everything.
+		 */
+		if (id->is_set8 && need_bswap(ehdr.e_ident[EI_DATA])) {
+			for (i = 0; i < cnt; i++) {
+				/*
+				 * header and entries are 8-byte, flags is the
+				 * second half of an entry
+				 */
+				flags = idx + (i + 1) * 2 + 1;
+				ptr[flags] = bswap_32(ptr[flags]);
+			}
+		}
+
 		next = rb_next(next);
 	}
 	return 0;
-- 
2.43.0


