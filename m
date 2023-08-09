Return-Path: <bpf+bounces-7345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE6775E0D
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D901C211B9
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECC17FFB;
	Wed,  9 Aug 2023 11:44:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0E17744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:44:09 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0D9B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:44:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so8525848a12.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581446; x=1692186246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2lNDuvhkm/BrRXLbYSnkEGTXFzIoZ+ukDW4N75Y24Y=;
        b=fnd5XPZVrT7qylun1Y3F3sT8DfNx9wTFPIZgQz4qnkBeUAjbN2A7e7Way6FwnnRxNl
         Hz64D8V+VL5jwYokt2SZCTIrT1WCkG01vtZCdirGRiWw1KTPogg7NAirhWrCx/N/8l9x
         C4B0Pxq4wpm2rUETQkkJU1ylK/6tV2sl2bKlAz+n/NJpkYBhXThbWnarSeNc4Hk40DkT
         gjncXcQXK+U/pQMoJtm780MJOciSFRYlrq+rxTtQ5tkqHcYVH0UyGLN2FTY0HKx0QfMG
         KgrB8om0Wee6e9p0JJUZHkdJBFZaROzmxPupCS1exmzb8UzxfPcL2ttdV4DE4RlZ52F+
         hn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581446; x=1692186246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2lNDuvhkm/BrRXLbYSnkEGTXFzIoZ+ukDW4N75Y24Y=;
        b=j3C3E996en/piCKDv0mX5Qi9F3oYVSp3IBSxpBcY28HK14vcMDbAR9LvBuVKClrx4L
         pMLONmaaUJ//2IRyEP5Ng+PUUU9uON37TE+kG7p5cyXV762/CdMjatAka/qz/OZ3R7kC
         KtkHX+uZJZwcCrkEBMz8GgOpZOqPMdyQxyeuTJxzLtzt54WO9Yxwpi3ohZ65SJIlTiVh
         +LrgLpaDcjWtjkGzppnlMbNr2Lugs8VAX6C6aU91RyOreCi5a1HYl+0/zU7FD6O7q//k
         eNwfQ5fvhhZsoF/Iejsm53N053BLxhN8N3ZV85ACVRCAuKwUFoezoYgAHVSP0AiwHLa9
         3f0w==
X-Gm-Message-State: AOJu0YyMvBGbHt9FboKoz5SwgqVRKs1/N+zq84d1+zC4IOnPo6bWWFuP
	yu2BdLMkFHTIvORWl6PySRe1hBw+DyZ5nVDWIoI=
X-Google-Smtp-Source: AGHT+IEUuWPnLtT1YBMS61CqO6XHgAEHAenAOfYlmgm1ZcXEE8kgoHEVqvQtQv02bA0EcaAiVvQGMA==
X-Received: by 2002:a05:6402:2050:b0:522:ca7c:df78 with SMTP id bc16-20020a056402205000b00522ca7cdf78mr2314003edb.0.1691581445892;
        Wed, 09 Aug 2023 04:44:05 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c04c000000b0052348d74865sm1978633edo.61.2023.08.09.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:44:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 12/14] libbpf: Add support for custom exception callbacks
Date: Wed,  9 Aug 2023 17:11:14 +0530
Message-ID: <20230809114116.3216687-13-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8764; i=memxor@gmail.com; h=from:subject; bh=2v+GgMkFFxB87Ltd7kGCtWMTzsuSjB6PC0H1kn78B6s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJcP2m5bxyGw0tnqRcf/ooCswdtKsXRtDVC 45kTDi8OSqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R yk/BEACcOsdK2FEQ1hGxWRjOXdUdp2KLRmWa9veVdiCAG1or2Z4JQPCgQOQXUWRsJ6gcVgkGKpC xWa/ZyqSDsCNAhvIqgBd/19dlk/IqupzVYEEBTNcjYwRy1F2AsxoEF/wB+Wza47JPIFvs4a80VP YvUHOUlgn9XjPtSdJiryYyVjbeZC+bj3TGbjjSPnb6mHD9YD5AKjnLwn1qgKUNhPRvNQtkvYIJl Jy1LiSW0ceD782SBxQedRgvh1/mvoULW/6C/PcrBnu1YdW+pXXO7LoFv/M2WkImD4PxXQql2iRN UscSCsDdzwHF8mcRSYP0x0PAvrSnejbD4DXDjEVwNIFUVQuAUOPcO9NycxqaSAYJCwSfD7x1aum a9pF1t9el2WAs23M9aeQ/lY4+AMKvsVY1fHZi3j8exEdGwANrWR/6/NUa53QEqpRqXZIoztJ9+v al6RszWlPEoJjeZmLPg4iYRpj4tM+wSxIMuL3QLUPMeueSYAkb+SChNvZBy/s1M2VHRoyUb5XJH bjuo/b4XFx8SKpBiDAZYHYFGxzoIGJFL5Y+C0ObAYZGExwBuY1fySX2gSoiaKKn674z3ljjtlcf Tjr4q2sRF2/w+VucYBcbYhUNZv8C1mGyiJ0YueHPZj3DjLBK1U79FVS1ErmPnrXoFbXZ6ZVmutl sAuO9QxO5d8z79Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to libbpf to append exception callbacks when loading a
program. The exception callback is found by discovering the declaration
tag 'exception_callback:<value>' and finding the callback in the value
of the tag.

The process is done in two steps. First, for each main program, the
bpf_object__sanitize_and_load_btf function finds and marks its
corresponding exception callback as defined by the declaration tag on
it. Second, bpf_object__reloc_code is modified to append the indicated
exception callback at the end of the instruction iteration (since
exception callback will never be appended in that loop, as it is not
directly referenced).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 166 +++++++++++++++++++++++++++++++++++------
 1 file changed, 142 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 17883f5a44b9..7c607bac8204 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -432,9 +432,11 @@ struct bpf_program {
 	int fd;
 	bool autoload;
 	bool autoattach;
+	bool sym_global;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
+	int exception_cb_idx;
 
 	int prog_ifindex;
 	__u32 attach_btf_obj_fd;
@@ -760,6 +762,7 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 
 	prog->type = BPF_PROG_TYPE_UNSPEC;
 	prog->fd = -1;
+	prog->exception_cb_idx = -1;
 
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
@@ -866,20 +869,28 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 		if (err)
 			return err;
 
+		if (ELF64_ST_BIND(sym->st_info) != STB_LOCAL)
+			prog->sym_global = true;
+
 		/* if function is a global/weak symbol, but has restricted
 		 * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BTF FUNC
 		 * as static to enable more permissive BPF verification mode
 		 * with more outside context available to BPF verifier
 		 */
-		if (ELF64_ST_BIND(sym->st_info) != STB_LOCAL
-		    && (ELF64_ST_VISIBILITY(sym->st_other) == STV_HIDDEN
-			|| ELF64_ST_VISIBILITY(sym->st_other) == STV_INTERNAL))
+		if (prog->sym_global && (ELF64_ST_VISIBILITY(sym->st_other) == STV_HIDDEN
+		    || ELF64_ST_VISIBILITY(sym->st_other) == STV_INTERNAL))
 			prog->mark_btf_static = true;
 
 		nr_progs++;
 		obj->nr_programs = nr_progs;
 	}
 
+	/* After adding all programs, now pair them with their exception
+	 * callbacks if specified.
+	 */
+	if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
+		goto out;
+out:
 	return 0;
 }
 
@@ -3137,6 +3148,80 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		}
 	}
 
+	if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
+		goto skip_exception_cb;
+	for (i = 0; i < obj->nr_programs; i++) {
+		struct bpf_program *prog = &obj->programs[i];
+		int j, k, n;
+
+		if (prog_is_subprog(obj, prog))
+			continue;
+		n = btf__type_cnt(obj->btf);
+		for (j = 1; j < n; j++) {
+			const char *str = "exception_callback:", *name;
+			size_t len = strlen(str);
+			struct btf_type *t;
+
+			t = btf_type_by_id(obj->btf, j);
+			if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1)
+				continue;
+
+			name = btf__str_by_offset(obj->btf, t->name_off);
+			if (strncmp(name, str, len))
+				continue;
+
+			t = btf_type_by_id(obj->btf, t->type);
+			if (!btf_is_func(t) || btf_func_linkage(t) != BTF_FUNC_GLOBAL) {
+				pr_warn("prog '%s': exception_callback:<value> decl tag not applied to the main program\n",
+					prog->name);
+				return -EINVAL;
+			}
+			if (strcmp(prog->name, btf__str_by_offset(obj->btf, t->name_off)))
+				continue;
+			/* Multiple callbacks are specified for the same prog,
+			 * the verifier will eventually return an error for this
+			 * case, hence simply skip appending a subprog.
+			 */
+			if (prog->exception_cb_idx >= 0) {
+				prog->exception_cb_idx = -1;
+				break;
+			}
+
+			name += len;
+			if (str_is_empty(name)) {
+				pr_warn("prog '%s': exception_callback:<value> decl tag contains empty value\n",
+					prog->name);
+				return -EINVAL;
+			}
+
+			for (k = 0; k < obj->nr_programs; k++) {
+				struct bpf_program *subprog = &obj->programs[k];
+
+				if (!prog_is_subprog(obj, subprog))
+					continue;
+				if (strcmp(name, subprog->name))
+					continue;
+				/* Enforce non-hidden, as from verifier point of
+				 * view it expects global functions, whereas the
+				 * mark_btf_static fixes up linkage as static.
+				 */
+				if (!subprog->sym_global || subprog->mark_btf_static) {
+					pr_warn("prog '%s': exception callback %s must be a global non-hidden function\n",
+						prog->name, subprog->name);
+					return -EINVAL;
+				}
+				prog->exception_cb_idx = k;
+				break;
+			}
+
+			if (prog->exception_cb_idx >= 0)
+				continue;
+			pr_warn("prog '%s': cannot find exception callback '%s'\n", prog->name, name);
+			return -ENOENT;
+		}
+	}
+skip_exception_cb:
+
 	sanitize = btf_needs_sanitization(obj);
 	if (sanitize) {
 		const void *raw_data;
@@ -6184,14 +6269,46 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int
+bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
+				struct bpf_program *subprog)
+{
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
+
+	subprog->sub_insn_off = main_prog->insns_cnt;
+
+	new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+	insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+	main_prog->insns = insns;
+	main_prog->insns_cnt = new_cnt;
+
+	memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+	       subprog->insns_cnt * sizeof(*insns));
+
+	pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+		 main_prog->name, subprog->insns_cnt, subprog->name);
+
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+	return 0;
+}
+
 static int
 bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		       struct bpf_program *prog)
 {
-	size_t sub_insn_idx, insn_idx, new_cnt;
+	size_t sub_insn_idx, insn_idx;
 	struct bpf_program *subprog;
-	struct bpf_insn *insns, *insn;
 	struct reloc_desc *relo;
+	struct bpf_insn *insn;
 	int err;
 
 	err = reloc_prog_func_and_line_info(obj, main_prog, prog);
@@ -6266,25 +6383,7 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		 *   and relocate.
 		 */
 		if (subprog->sub_insn_off == 0) {
-			subprog->sub_insn_off = main_prog->insns_cnt;
-
-			new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-			insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-			if (!insns) {
-				pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-				return -ENOMEM;
-			}
-			main_prog->insns = insns;
-			main_prog->insns_cnt = new_cnt;
-
-			memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-			       subprog->insns_cnt * sizeof(*insns));
-
-			pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-				 main_prog->name, subprog->insns_cnt, subprog->name);
-
-			/* The subprog insns are now appended. Append its relos too. */
-			err = append_subprog_relos(main_prog, subprog);
+			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
 			if (err)
 				return err;
 			err = bpf_object__reloc_code(obj, main_prog, subprog);
@@ -6308,6 +6407,25 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 			 prog->name, insn_idx, insn->imm, subprog->name, subprog->sub_insn_off);
 	}
 
+	/* Now, also append exception callback if it has not been done already. */
+	if (main_prog == prog && main_prog->exception_cb_idx >= 0) {
+		subprog = &obj->programs[main_prog->exception_cb_idx];
+
+		/* Calling exception callback directly is disallowed, which the
+		 * verifier will reject later. In case it was processed already,
+		 * we can skip this step, otherwise for all other valid cases we
+		 * have to append exception callback now.
+		 */
+		if (subprog->sub_insn_off == 0) {
+			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+			err = bpf_object__reloc_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.41.0


