Return-Path: <bpf+bounces-79411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A02D39CD9
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 04:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F2C30141D6
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE1258CE7;
	Mon, 19 Jan 2026 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXScxaDx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637142135B8
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793229; cv=none; b=jlLf6Stk5gLlmE9t9aDz7VI+WPtwrCjkla6GIaBSgMEbYSHUbut0dUuEk7HNk/UijsTEiqKexiiZ993q5R0Xuvzqb+OALzCrwkYerIWyBM9A9CKraAi+eqv95n7y5qGC6pikH9/JFjaNNrAmpuqTGHQ2esRI0OJ8U33Jk+nLdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793229; c=relaxed/simple;
	bh=uW+F2QtSidWZpv+WLcnvnCho2KgCi3lEi0l2DCvw9Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhgosDmYkzLgRHRoGJnjuTdCLqZKrZzDfYwUrJ2v1jFW70FqYVTm3a7Pk9qVrA1l6Q/c1BWOH+03x6ZbN3SszOUQW6lFiHeP6eyW2IztNiXv4UZBvqJvB6eJvezIgdS4AvNA8yXqNBEmDDzZbihT6naJfd2D05CjpcnYq7yrluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXScxaDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/X41VcnHuOXqT84jMlB3N9HZaOq9CdFFA8bWA8RbTY=;
	b=PXScxaDxn80/My/roQS7NntM4hua3JiQ5uDC9OISdA7KYJupTVgTjGDyofL8W0oEIOVrMj
	OhLPx90OPQdABs0gTN0w3yvWN0w68ta9x3vCYuoUjBNi773w3sql+i+cdV4kfx+lHHUaD9
	EFhJ1xLW0BiTSt+0WyXQenygA9RWcys=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-c3b4zj0LNDC0uhWE-SElyQ-1; Sun,
 18 Jan 2026 22:27:03 -0500
X-MC-Unique: c3b4zj0LNDC0uhWE-SElyQ-1
X-Mimecast-MFC-AGG-ID: c3b4zj0LNDC0uhWE-SElyQ_1768793221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6197B1955F34;
	Mon, 19 Jan 2026 03:27:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C90D11955F22;
	Mon, 19 Jan 2026 03:26:50 +0000 (UTC)
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
Subject: [PATCHv6 09/13] kexec_file: Factor out routine to find a symbol in ELF
Date: Mon, 19 Jan 2026 11:24:20 +0800
Message-ID: <20260119032424.10781-10-piliu@redhat.com>
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

The routine to search a symbol in ELF can be shared, so split it out.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_file.c     | 86 ++++++++++++++++++++++-------------------
 kernel/kexec_internal.h |  1 +
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9674bb5bd8db..9731019ba2a1a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -889,6 +889,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
+#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_BPF)
+const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
+{
+	const Elf_Shdr *sechdrs;
+	const Elf_Sym *syms;
+	const char *strtab;
+	int i, k;
+
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		if (sechdrs[i].sh_link >= ehdr->e_shnum)
+			/* Invalid strtab section number */
+			continue;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
+
+		/* Go through symbols for a match */
+		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+				continue;
+
+			if (strcmp(strtab + syms[k].st_name, name) != 0)
+				continue;
+
+			if (syms[k].st_shndx == SHN_UNDEF ||
+			    syms[k].st_shndx >= ehdr->e_shnum) {
+				pr_debug("Symbol: %s has bad section index %d.\n",
+						name, syms[k].st_shndx);
+				return NULL;
+			}
+
+			/* Found the symbol we are looking for */
+			return &syms[k];
+		}
+	}
+
+	return NULL;
+}
+
+#endif
+
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
@@ -1146,49 +1191,10 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 						  const char *name)
 {
-	const Elf_Shdr *sechdrs;
-	const Elf_Ehdr *ehdr;
-	const Elf_Sym *syms;
-	const char *strtab;
-	int i, k;
-
 	if (!pi->ehdr)
 		return NULL;
 
-	ehdr = pi->ehdr;
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-
-	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type != SHT_SYMTAB)
-			continue;
-
-		if (sechdrs[i].sh_link >= ehdr->e_shnum)
-			/* Invalid strtab section number */
-			continue;
-		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (void *)ehdr + sechdrs[i].sh_offset;
-
-		/* Go through symbols for a match */
-		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
-				continue;
-
-			if (strcmp(strtab + syms[k].st_name, name) != 0)
-				continue;
-
-			if (syms[k].st_shndx == SHN_UNDEF ||
-			    syms[k].st_shndx >= ehdr->e_shnum) {
-				pr_debug("Symbol: %s has bad section index %d.\n",
-						name, syms[k].st_shndx);
-				return NULL;
-			}
-
-			/* Found the symbol we are looking for */
-			return &syms[k];
-		}
-	}
-
-	return NULL;
+	return elf_find_symbol(pi->ehdr, name);
 }
 
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index ee01d0c8bb377..2e8e0fedbe2a9 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -40,6 +40,7 @@ extern bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
 extern int pe_get_section(const char *file_buf, const char *sect_name,
 		char **sect_start, unsigned long *sect_sz);
 extern int decompose_kexec_image(struct kimage *image, int extended_fd);
+extern const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
-- 
2.49.0


