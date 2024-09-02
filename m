Return-Path: <bpf+bounces-38693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF5967FD5
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10311F222FC
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E415FA92;
	Mon,  2 Sep 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1yraSfq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C615688E
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260307; cv=none; b=p5fgwFLnOjvuhutci4PdZ4WL6aiSg3xYtC3hzzawRXYefjfnimUY3si6hZhROoQnHK9C1zDIVTdftSMNrIJDkO5JwQF6ZCfwuxWVNL3Q2cQOhgMXFfyYBoxJ4wlY1CzmNRd/w24LOArDOnzObKKHNke+Ijo6ZwaMWmtBHDjlwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260307; c=relaxed/simple;
	bh=I6l3pTB0xuYZaIp3pzq3X6tlwepFRLK+C7LUqzvqLuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea58fRsmW3sPOcEj0FCJdEW04MyHUeGETfRhSBZ9LlayZUYDAP5+FvUcdNXvU7xwNy2fsTvRQKYylC+ktSQZqQn9aJB8GQ1fjBAIJGgMbjgfWq1kNYFqL3K+Kauf27ZeZPJu5iDVZyNNFfz+KGf849DjpY6WDTav9tMhd8CbZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1yraSfq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725260304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5r15w4xESAPeLKzc6LJNAB2Znmgl8v0yRC0d6ROn+Os=;
	b=A1yraSfq5JqU3LnwuRA+6hQWM8JZ5XlPnBVrPY/ryeUDlPoIUeSRpQLfciHbZJZSPgtl9L
	4PvVoorSdhoGi/aZDUJD2dnaggYDn2YlWSO5C/PnII7KoX0Sjo1R9Tbei0QXHD2+QHcZMm
	PNGkO00glOFFsb1WqOXFT/dkl+6hehA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-l6KoKixiMVmtlsJf9uVhNA-1; Mon,
 02 Sep 2024 02:58:23 -0400
X-MC-Unique: l6KoKixiMVmtlsJf9uVhNA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E6B418EA893;
	Mon,  2 Sep 2024 06:58:21 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDB7C19560AE;
	Mon,  2 Sep 2024 06:58:15 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 1/3] libbpf: Support aliased symbols in linker
Date: Mon,  2 Sep 2024 08:58:01 +0200
Message-ID: <87e9970b63dede4a19ec62ec572e224eecc26fa3.1725016029.git.vmalik@redhat.com>
In-Reply-To: <cover.1725016029.git.vmalik@redhat.com>
References: <cover.1725016029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It is possible to create multiple BPF programs sharing the same
instructions using the compiler `__attribute__((alias("...")))`:

    int BPF_PROG(prog)
    {
        [...]
    }
    int prog_alias() __attribute__((alias("prog")));

This may be convenient when creating multiple programs with the same
instruction set attached to different events (such as bpftrace does).

One problem in this situation is that Clang doesn't generate a BTF entry
for `prog_alias` which makes libbpf linker fail when processing such a
BPF object.

This commits adds support for that by finding another symbol at the same
address for which a BTF entry exists and using that entry in the linker.
This allows to use the linker (e.g. via `bpftool gen object ...`) on BPF
objects containing aliases.

Note that this won't be sufficient for most programs as we also need to
add support for handling relocations in the aliased programs. This will
be added by the following commit.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/linker.c | 68 +++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 9cd3d4109788..5ebc9ff1246e 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -1688,6 +1688,34 @@ static bool btf_is_non_static(const struct btf_type *t)
 	       || (btf_is_func(t) && btf_func_linkage(t) != BTF_FUNC_STATIC);
 }
 
+static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
+				   int sym_type, const char *sym_name)
+{
+	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
+	Elf64_Sym *sym = symtab->data->d_buf;
+	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
+	int str_sec_idx = symtab->shdr->sh_link;
+	const char *name;
+
+	for (i = 0; i < n; i++, sym++) {
+		if (sym->st_shndx != sec_idx)
+			continue;
+		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
+			continue;
+
+		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
+		if (!name)
+			return NULL;
+
+		if (strcmp(sym_name, name) != 0)
+			continue;
+
+		return sym;
+	}
+
+	return NULL;
+}
+
 static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sym_name,
 			     int *out_btf_sec_id, int *out_btf_id)
 {
@@ -1695,6 +1723,7 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
 	const struct btf_type *t;
 	const struct btf_var_secinfo *vi;
 	const char *name;
+	Elf64_Sym *s;
 
 	if (!obj->btf) {
 		pr_warn("failed to find BTF info for object '%s'\n", obj->filename);
@@ -1710,8 +1739,15 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
 		 */
 		if (btf_is_non_static(t)) {
 			name = btf__str_by_offset(obj->btf, t->name_off);
-			if (strcmp(name, sym_name) != 0)
-				continue;
+			if (strcmp(name, sym_name) != 0) {
+				/* the symbol that we look for may not have BTF as it may
+				 * be an alias of another symbol; we check if this is
+				 * the original symbol and if so, we use its BTF id
+				 */
+				s = find_sym_by_name(obj, sym->st_shndx, STT_FUNC, name);
+				if (!s || s->st_value != sym->st_value)
+					continue;
+			}
 
 			/* remember and still try to find DATASEC */
 			btf_id = i;
@@ -2132,34 +2168,6 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 	return 0;
 }
 
-static Elf64_Sym *find_sym_by_name(struct src_obj *obj, size_t sec_idx,
-				   int sym_type, const char *sym_name)
-{
-	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
-	Elf64_Sym *sym = symtab->data->d_buf;
-	int i, n = symtab->shdr->sh_size / symtab->shdr->sh_entsize;
-	int str_sec_idx = symtab->shdr->sh_link;
-	const char *name;
-
-	for (i = 0; i < n; i++, sym++) {
-		if (sym->st_shndx != sec_idx)
-			continue;
-		if (ELF64_ST_TYPE(sym->st_info) != sym_type)
-			continue;
-
-		name = elf_strptr(obj->elf, str_sec_idx, sym->st_name);
-		if (!name)
-			return NULL;
-
-		if (strcmp(sym_name, name) != 0)
-			continue;
-
-		return sym;
-	}
-
-	return NULL;
-}
-
 static int linker_fixup_btf(struct src_obj *obj)
 {
 	const char *sec_name;
-- 
2.46.0


