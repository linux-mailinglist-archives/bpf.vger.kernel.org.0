Return-Path: <bpf+bounces-20840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F884440C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D179CB22868
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5132712AAF2;
	Wed, 31 Jan 2024 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhrK+9xi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70B12AAFB
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718335; cv=none; b=ONTpB7MGWxpkFcwE+RNnkkiz0QtvXxTE25qfAu7hmIczZGG+mMhiZ65AjG2Z2M6uMj2DBaWV9nEwtis5+/NCiAPPNY5nfIv3OnOs0PNDuRmFHb1V9uzACqacSjhTFio+AEMVsiqhVpG0eiWUsd9ILawTrXqlqXFVsturx/FXCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718335; c=relaxed/simple;
	bh=B7HyS2Em0NNadiq6DHrVhWuNI8e/zBSXRvIoIkBLsks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEdMdFpRc60bQh61f9/4Ugt5eapyTFLqGpUzMdZ3ixiRJpxz3BcOTQyaZdyj8lyFAOMlWMvTE/2DFTNOUUm/lPZpLAi4319jG6EEDHIvhsrYi3amErIqnhwF+PYEC711pq9RMBDT4lbTaGDT6y9+zbLHpdqXr94W7NHKEmOqndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhrK+9xi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706718332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCkrrMHuTO/0Bw87QGp264wUdlQvK5SH6gvLfeWxNh4=;
	b=MhrK+9xiDnTgbkUr45Eq09a/U+aGvvXYE3/xJagj6HdsoPl37NvsyY+fO8uqLIEUsY0iLS
	SY28IWZLDKMJE5Q3rNXeYKoTsLbkypYK9cLezbeZTMp75eVCyGLGSMT6hAsfZQmC9HXYO4
	W8O4fEsJM/7AAt14X6NkNDuKGCLRr+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-0uPl6jBNN5iI1sfXikmkLw-1; Wed, 31 Jan 2024 11:24:50 -0500
X-MC-Unique: 0uPl6jBNN5iI1sfXikmkLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EEC8185A786;
	Wed, 31 Jan 2024 16:24:23 +0000 (UTC)
Received: from dhcpf210.fit.vutbr.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A57D81C060AF;
	Wed, 31 Jan 2024 16:24:20 +0000 (UTC)
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 2/2] tools/resolve_btfids: fix cross-compilation to non-host endianness
Date: Wed, 31 Jan 2024 17:24:09 +0100
Message-ID: <64f6372c75a44d5c8d00db5c5b7ca21aa3b8bd77.1706717857.git.vmalik@redhat.com>
In-Reply-To: <cover.1706717857.git.vmalik@redhat.com>
References: <cover.1706717857.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
 tools/bpf/resolve_btfids/main.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 7badf1557e5c..d01603ef6283 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -652,13 +652,23 @@ static int sets_patch(struct object *obj)
 	Elf_Data *data = obj->efile.idlist;
 	int *ptr = data->d_buf;
 	struct rb_node *next;
+	GElf_Ehdr ehdr;
+	int need_bswap;
+
+	if (gelf_getehdr(obj->efile.elf, &ehdr) == NULL) {
+		pr_err("FAILED cannot get ELF header: %s\n",
+			elf_errmsg(-1));
+		return -1;
+	}
+	need_bswap = (__BYTE_ORDER == __LITTLE_ENDIAN) !=
+		     (ehdr.e_ident[EI_DATA] == ELFDATA2LSB);
 
 	next = rb_first(&obj->sets);
 	while (next) {
 		unsigned long addr, idx;
 		struct btf_id *id;
 		void *base;
-		int cnt, size;
+		int cnt, size, i;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
@@ -686,6 +696,21 @@ static int sets_patch(struct object *obj)
 			base = set8->pairs;
 			cnt = set8->cnt;
 			size = sizeof(set8->pairs[0]);
+
+			/*
+			 * When ELF endianness does not match endianness of the
+			 * host, libelf will do the translation when updating
+			 * the ELF. This, however, corrupts SET8 flags which are
+			 * already in the target endianness. So, let's bswap
+			 * them to the host endianness and libelf will then
+			 * correctly translate everything.
+			 */
+			if (need_bswap) {
+				for (i = 0; i < cnt; i++) {
+					set8->pairs[i].flags =
+						bswap_32(set8->pairs[i].flags);
+				}
+			}
 		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-- 
2.43.0


