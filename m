Return-Path: <bpf+bounces-53576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A98A569DB
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C97B1741EC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BB21ABA2;
	Fri,  7 Mar 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw5D8C20"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F879383A5
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356111; cv=none; b=cPhEh/wQwhXMs6fURSwwsAoDBgdg0Wy67H1RMUqUZgrUHMQw6KUT8p2NhShEkbfkgOxEVySPA7pbGhpy0ugLsXnOgn5eJSRQzqly8Ru0CkAfbRyNJL7iov32Eq8crnOn/1LnraM8U3up9NQ7HS+F8ZqhmOPITIpaISopxG0bNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356111; c=relaxed/simple;
	bh=X2XtffBR3fYBiit2nTQdY9l2e2B0+tzK/MFIPQ8x//U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4oMV9t7ZchFxLLbKDHwQp9V6fwrJJSQ03oTHVd4e6SWUNKyT80A1E3g6x2yNehe1KZ0HPKLmW2lIJEmaI85B/ngh/R3KHiPyRKfCOY24ALPagLb4WBtcYry2rN7iJac3KhYgbd4/3QbN5cTzT3ftrXIpKRaaG/t8cJhM2brFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw5D8C20; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso3300857a91.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 06:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741356108; x=1741960908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXm/6+W0yUjiuNb4l21C7SD1BgIuNtvWeDi+LnnFyC0=;
        b=Mw5D8C20NZK/2YTNNS30wU9B8B3Ydj32M+Cd/vUBxCliAdiUFoX9dDYd/cijw1aLHw
         ox36XdjN96N1JlxOSwsxQpNOLnMUJy3wsYSvysztg23O8uhWQO3x6SJlpTAKf2NF3Ygh
         i8xtyMaBpHWJmVAhNb0V3IzfobuQFylS8tV9W3salFlsQeTDqOBQwcgN/qkc+GY/FHKP
         GsYNVGspsNpe72WGMcEF0zZqDQotgQQwQYDuVtuzhedgfA41YVHyHLv/vZ3HGjq8hQtF
         NBe+SvX6ezpq8yABDHhjWiTP6ZjyrgYt9HEJuLjFynUvK7XUw4UbkfNul1pdWC8dp3bE
         j8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356108; x=1741960908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXm/6+W0yUjiuNb4l21C7SD1BgIuNtvWeDi+LnnFyC0=;
        b=h+56BHRdAZj2P30DKPRg4aXn/6p8w3eNXUqa/yX1fzt/VkZGdvAqbQbQeRhMvDCB8r
         ZQW/dd160C28ZTYlwM+dm8kbT2eTNv6UsXjmFmAAleMTgUogxXTb7Xz2NFjk5LDQEcia
         Ya46PPuPszUibI4FWuN4u5EfEDhaYR5SjrAXjacx5ARweHscm3qps9VT4Qj0UjriADVn
         Ad30h8wG3LGqhtwpWCL853SNPYMtqV3psD4aqU0dltijzSu73Yt2tly5YgT3PX3M61HQ
         fjJAlHRB2I6jDFsYzwyH3ix90qe5pS9jn8bjP3mv3miN7UyGiaNWGHO5zhIVJlCnylZL
         fQ+w==
X-Gm-Message-State: AOJu0Yxl67WgyJ66fzCQSlRYRsMYU4IbRVttMtKQvZV+R3rjUSscQhiK
	N4EI8HpzkA6B0l+7EfjNzTYtZND5WjcwbZup6Qk9tMabh9aFH2fvF+/LVwOl
X-Gm-Gg: ASbGnct1eJhBLjK4mntXN9ADS3gG5NqPo9uWO6JSG6+DGINmFqPnAJ0ES7iC7L6VNsm
	nc4ViSyD4nXrlxIH2HkDspJRVtWZRkW1u6Reemh9RaagWPkOifwTyO/GKxs6GFgJBlfHH1euAgx
	0BZI4091QfrUK9bUQUxJqyNeLOd1dofTHxUfjlT6dVQ/6j8N7XfkJrW/dHGXzuur9yHU5mlePIg
	lyRRIhNlDOF8E57bT57HGiMJcIj43HlMU6T+qdZknYOH4YxEQpwB+yD3KEgAoJko52G/YVXaogT
	O7ujhRu8UyfV7Btox98hVJrcoRaZGE2tDMbjwpW42vX3V+PTNKfuSfoZeGW8Gnqi8kHV2npUWHv
	2QZH6xg==
X-Google-Smtp-Source: AGHT+IF1R03DqdNISnyNWATEGA8nAAPmf6Us5Y7e45X3OfHROoQiGKjj7WsZVzdVXR0uJG2KjF7d6w==
X-Received: by 2002:a17:90b:4c8a:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-2ff7b59dec9mr5841465a91.4.1741356107266;
        Fri, 07 Mar 2025 06:01:47 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22410aa8282sm30082385ad.238.2025.03.07.06.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:01:46 -0800 (PST)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	deso@posteo.net
Cc: hengqi.chen@gmail.com
Subject: [PATCH] libbpf: Fix uprobe offset calculation
Date: Fri,  7 Mar 2025 14:01:20 +0000
Message-ID: <20250307140120.1261890-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported on libbpf-rs issue([0]), the current implementation
may resolve symbol to a wrong offset and thus missing uprobe
event. Calculate the symbol offset from program header instead.
See the BCC implementation (which in turn used by bpftrace) and
the spec ([1]) for references.

  [0]: https://github.com/libbpf/libbpf-rs/issues/1110
  [1]: https://refspecs.linuxfoundation.org/elf/

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 823f83ad819c..9b561c8d1eec 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -260,13 +260,29 @@ static bool symbol_match(struct elf_sym_iter *iter, int sh_type, struct elf_sym
  * for shared libs) into file offset, which is what kernel is expecting
  * for uprobe/uretprobe attachment.
  * See Documentation/trace/uprobetracer.rst for more details. This is done
- * by looking up symbol's containing section's header and using iter's virtual
- * address (sh_addr) and corresponding file offset (sh_offset) to transform
+ * by looking up symbol's containing program header and using its virtual
+ * address (p_vaddr) and corresponding file offset (p_offset) to transform
  * sym.st_value (virtual address) into desired final file offset.
  */
-static unsigned long elf_sym_offset(struct elf_sym *sym)
+static unsigned long elf_sym_offset(Elf *elf, struct elf_sym *sym)
 {
-	return sym->sym.st_value - sym->sh.sh_addr + sym->sh.sh_offset;
+	size_t nhdrs, i;
+	GElf_Phdr phdr;
+
+	if (elf_getphdrnum(elf, &nhdrs))
+		return -1;
+
+	for (i = 0; i < nhdrs; i++) {
+		if (!gelf_getphdr(elf, (int)i, &phdr))
+			continue;
+		if (phdr.p_type != PT_LOAD || !(phdr.p_flags & PF_X))
+			continue;
+		if (sym->sym.st_value >= phdr.p_vaddr &&
+		    sym->sym.st_value < (phdr.p_vaddr + phdr.p_memsz))
+			return sym->sym.st_value - phdr.p_vaddr + phdr.p_offset;
+	}
+
+	return -1;
 }
 
 /* Find offset of function name in the provided ELF object. "binary_path" is
@@ -329,7 +345,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 
 			if (ret > 0) {
 				/* handle multiple matches */
-				if (elf_sym_offset(sym) == ret) {
+				if (elf_sym_offset(elf, sym) == ret) {
 					/* same offset, no problem */
 					continue;
 				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
@@ -346,7 +362,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 				}
 			}
 
-			ret = elf_sym_offset(sym);
+			ret = elf_sym_offset(elf, sym);
 			last_bind = cur_bind;
 		}
 		if (ret > 0)
@@ -445,7 +461,7 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 			goto out;
 
 		while ((sym = elf_sym_iter_next(&iter))) {
-			unsigned long sym_offset = elf_sym_offset(sym);
+			unsigned long sym_offset = elf_sym_offset(elf_fd.elf, sym);
 			int bind = GELF_ST_BIND(sym->sym.st_info);
 			struct symbol *found, tmp = {
 				.name = sym->name,
@@ -534,7 +550,7 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
 			if (err)
 				goto out;
 
-			offsets[cnt++] = elf_sym_offset(sym);
+			offsets[cnt++] = elf_sym_offset(elf_fd.elf, sym);
 		}
 
 		/* If we found anything in the first symbol section,
-- 
2.43.5


