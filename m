Return-Path: <bpf+bounces-9170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46779101A
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 04:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A32280D1A
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 02:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F9397;
	Mon,  4 Sep 2023 02:25:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CD62E
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 02:25:28 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8036BB
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 19:25:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26f6b2c8e80so699599a91.1
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 19:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693794325; x=1694399125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqVtV6R/rWVrHVBAD1bwGK9xImd/SxOCN/mOrTtWilY=;
        b=UzrYnBHGKYsoBWk1lAcnEhCXtm5fPGoWLeXrezOtR9cbeqUtK/Tvu5Qn8gwl3pYyVM
         9T67Fu+DFCiGhbDd4WT0F/sIC8Tj/ukGnPYfgsgXZIU9LE1K6qw814kJoj365TjL90KR
         6h3a1ZHVsuGTa1f9c/XcvpdWURKM2xThEXwzqbAAfRnmzNDnurLSXRE4wZF3ez9wByfc
         mpWqQY6e81RFU2wCJg/fFSFxj2eHcVpxXf4PUQ8XY5AeU3PeRYa1N9fFxhEr+c0OMnyQ
         vDjL+aLXjbV2WDmB6XR0f1zHGZeX2UvF1+vwf6cSi+iGN3xlO9xNshVppZ8jc9DhU+P/
         EVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794325; x=1694399125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqVtV6R/rWVrHVBAD1bwGK9xImd/SxOCN/mOrTtWilY=;
        b=gbuLVmiixq0IRFG6jd+GdQ8yHbvJy5s+Pc2GB/1TTHM/SLNGKAbEuq1/Sb/TS7GPXS
         tCO0tqCiXdgoU548Q/DnOplUKlncW7QNqL0Z5l7geBx0TVqQxZdpk/CjXCz4f8bucR/k
         Qlu2m9r/uv+8B/i/zlfVqnfU3zPqllIFFJypJBHml0T47JZBDmwusVGswn1eBa7/LugQ
         aK76UWdZ1+wV7uANjHV8pT+LGyxxZIfiDizVr3XRVMZ2sjlalsaD2qgjjAsk53UhZiHc
         0EkTWKBVtt4d1fWzus0nzFW1bVqQzq3LxtLcqhzW8nAAcDjjJdYnFahczevddHJMfuav
         Zdug==
X-Gm-Message-State: AOJu0Yw/8nLN209HY/i4e6E9f4u2dOLzz2li2xUW6ayskySIX80bcgUC
	9fRC2ghMSAgCU7T1xn0T29zkvg6aUWDp2CO5
X-Google-Smtp-Source: AGHT+IGap6NHCLFKIUZaRLCRp/x46+k+GrVZfrI/8F+kY5nhlIYtfQvdu7k5hmveoHM/C/EulkMh3g==
X-Received: by 2002:a17:90b:1e4a:b0:26d:5049:cf48 with SMTP id pi10-20020a17090b1e4a00b0026d5049cf48mr7793699pjb.40.1693794325109;
        Sun, 03 Sep 2023 19:25:25 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001c3267ae314sm3041636pll.156.2023.09.03.19.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 19:25:24 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] libbpf: Support symbol versioning for uprobe
Date: Mon,  4 Sep 2023 02:24:44 +0000
Message-Id: <20230904022444.1695820-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230904022444.1695820-1-hengqi.chen@gmail.com>
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, we allow users to specify symbol name for uprobe in a qualified
form, i.e. func@@LIB or func@@LIB_VERSION. For dynamic symbols, their version
info is actually stored in .gnu.version and .gnu.version_d sections of the ELF
objects. So dynamic symbols and the qualified name won't match. Add support for
symbol versioning ([0]) so that we can handle the above case.

  [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c | 98 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 5c9e588b17da..ed3d9880eaa4 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -9,6 +9,7 @@
 #include "str_error.h"

 #define STRERR_BUFSIZE  128
+#define HIDDEN_BIT	16

 int elf_open(const char *binary_path, struct elf_fd *elf_fd)
 {
@@ -64,11 +65,14 @@ struct elf_sym {
 	const char *name;
 	GElf_Sym sym;
 	GElf_Shdr sh;
+	int ver;
+	bool hidden;
 };

 struct elf_sym_iter {
 	Elf *elf;
 	Elf_Data *syms;
+	Elf_Data *versyms;
 	size_t nr_syms;
 	size_t strtabidx;
 	size_t next_sym_idx;
@@ -111,6 +115,18 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
 	iter->nr_syms = iter->syms->d_size / sh.sh_entsize;
 	iter->elf = elf;
 	iter->st_type = st_type;
+
+	/* Version symbol table only meaningful to dynsym only */
+	if (sh_type != SHT_DYNSYM)
+		return 0;
+
+	scn = elf_find_next_scn_by_type(elf, SHT_GNU_versym, NULL);
+	if (!scn)
+		return 0;
+	if (!gelf_getshdr(scn, &sh))
+		return -EINVAL;
+	iter->versyms = elf_getdata(scn, 0);
+
 	return 0;
 }

@@ -119,6 +135,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
 	struct elf_sym *ret = &iter->sym;
 	GElf_Sym *sym = &ret->sym;
 	const char *name = NULL;
+	GElf_Versym versym;
 	Elf_Scn *sym_scn;
 	size_t idx;

@@ -138,12 +155,57 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)

 		iter->next_sym_idx = idx + 1;
 		ret->name = name;
+		ret->ver = 0;
+		ret->hidden = false;
+
+		if (iter->versyms) {
+			if (!gelf_getversym(iter->versyms, idx, &versym))
+				continue;
+			ret->ver = versym & ~(1 << HIDDEN_BIT);
+			ret->hidden = versym & (1 << HIDDEN_BIT);
+		}
 		return ret;
 	}

 	return NULL;
 }

+static const char *elf_get_vername(Elf *elf, int ver)
+{
+	GElf_Verdaux verdaux;
+	GElf_Verdef verdef;
+	Elf_Data *verdefs;
+	size_t strtabidx;
+	GElf_Shdr sh;
+	Elf_Scn *scn;
+	int offset;
+
+	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
+	if (!scn)
+		return NULL;
+	if (!gelf_getshdr(scn, &sh))
+		return NULL;
+	strtabidx = sh.sh_link;
+	verdefs =  elf_getdata(scn, 0);
+
+	offset = 0;
+	while (gelf_getverdef(verdefs, offset, &verdef)) {
+		if (verdef.vd_ndx != ver) {
+			if (!verdef.vd_next)
+				break;
+
+			offset += verdef.vd_next;
+			continue;
+		}
+
+		if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &verdaux))
+			break;
+
+		return elf_strptr(elf, strtabidx, verdaux.vda_name);
+
+	}
+	return NULL;
+}

 /* Transform symbol's virtual address (absolute for binaries and relative
  * for shared libs) into file offset, which is what kernel is expecting
@@ -191,6 +253,9 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 	for (i = 0; i < ARRAY_SIZE(sh_types); i++) {
 		struct elf_sym_iter iter;
 		struct elf_sym *sym;
+		size_t sname_len;
+		char sname[256];
+		const char *ver;
 		int last_bind = -1;
 		int cur_bind;

@@ -201,14 +266,31 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
 			goto out;

 		while ((sym = elf_sym_iter_next(&iter))) {
-			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
-			if (strncmp(sym->name, name, name_len) != 0)
-				continue;
-			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
-			 * additional characters in sname should be of the form "@@LIB".
-			 */
-			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
-				continue;
+			if (sh_types[i] == SHT_DYNSYM && is_name_qualified) {
+				if (sym->hidden)
+					continue;
+
+				sname_len = strlen(sym->name);
+				if (strncmp(sym->name, name, sname_len) != 0)
+					continue;
+
+				ver = elf_get_vername(elf, sym->ver);
+				if (!ver)
+					continue;
+
+				snprintf(sname, sizeof(sname), "%s@@%s", sym->name, ver);
+				if (strncmp(sname, name, name_len) != 0)
+					continue;
+			} else {
+				/* User can specify func, func@@LIB or func@@LIB_VERSION. */
+				if (strncmp(sym->name, name, name_len) != 0)
+					continue;
+				/* ...but we don't want a search for "foo" to match 'foo2" also, so any
+				* additional characters in sname should be of the form "@@LIB".
+				*/
+				if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
+					continue;
+			}

 			cur_bind = GELF_ST_BIND(sym->sym.st_info);

--
2.39.3

