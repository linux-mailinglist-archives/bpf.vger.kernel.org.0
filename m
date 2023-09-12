Return-Path: <bpf+bounces-9839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352D79DCB9
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B319E2815F9
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC015AE9;
	Tue, 12 Sep 2023 23:32:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC311CAD
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:30 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF7E10FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2b962535808so106247011fa.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561548; x=1695166348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7pmoitH+AiMJiFKg+FFb7MBDaxehp8zsVFc9eCNZDA=;
        b=C2EH5NFazHo6EfeH4g1nta0ofcOIFuasJ3+Z6tmMEVnQABci4Mt0lNKdNOOCgP6T9g
         fqfU5s7nJ1QfKYEoioUGG1xC4pJ8GOUukwKprN1S+DEfZm2VkkaTJcD6jwUc0GFntvvu
         YJvKHbXZZiSrlm6GdSygivVcTOH1jCxp4QBOkPpCdiXn1/t96q9CIeuu81oeFTSApfDD
         6Z2nr9VP5cWBbRiC7IKSPlOwy3ulNixad2kAkYHcWJDroVJDI2cPK4hIYKM1x/ANrzEp
         HneD1gd2nANegNWLtF4jMpIx/5tGxu7OMafMcMBMccOwkPa8xlrj5kYXv+dq88ErSljd
         8wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561548; x=1695166348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7pmoitH+AiMJiFKg+FFb7MBDaxehp8zsVFc9eCNZDA=;
        b=eXu+bVwnMHR78q4hIPfWJfbi9vDIwcizP+zFflKDPABDS9JQkA4UA+0iDjmGHnGGY+
         DU//C+Cl3a2NoJfVdVpTvpuWy13iWAvAjKVjaCFy1rB+I3H4b0orm3ZHeYuWqif1HsAM
         L2MbdfWHyhVR6fG0JPn2tcI0ZL/tGf5z6gIALhx52P1obrVNfv5CD+SPdAS4gxt1eNtL
         UupuBZseKHmZwvHrGl7QTS5tnvKGMCF9bePT6iSfwHZWXXCjARmWkcCEuJL2EXB9aoaa
         Enxk7xc/K9LPEDfvgvfhCP0e8Gv91WRAfbvqJJyutsF74qRLHJ1swRka5+O/f2StU2hx
         sSzw==
X-Gm-Message-State: AOJu0YwhkuPh/QdbA/b+1RboEy+g4GwWG92ZRp9iqk59+GiED3DzETEI
	VSljaLMMuGgGQjFWUKBiyU1x6+DO2V/lWQ==
X-Google-Smtp-Source: AGHT+IFThpaJAygVmnfCDVgda1dXZidiOaH65Th8g12rqEYx1oUdFluGvTZLZWQP6XzhTK8+bYOJwQ==
X-Received: by 2002:a2e:96cf:0:b0:2bc:d38e:65ab with SMTP id d15-20020a2e96cf000000b002bcd38e65abmr1012816ljj.37.1694561547933;
        Tue, 12 Sep 2023 16:32:27 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id lj16-20020a170906f9d000b00992d0de8762sm7432326ejb.216.2023.09.12.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 15/17] libbpf: Add support for custom exception callbacks
Date: Wed, 13 Sep 2023 01:32:12 +0200
Message-ID: <20230912233214.1518551-16-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6677; i=memxor@gmail.com; h=from:subject; bh=r36Y41HKrfmjdJkM3HT2I8pc/IZkGUAxlE7zci8mNdQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSu0C6fe+4yTY8XuEaBJ5uEBlL58uJdCvbmD +T1r8WYnv2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rgAKCRBM4MiGSL8R yjtzD/0dUtfvOd5m45kXvglJ2KQWeQbZBFgYDEYldNPOCG/YLYwvc/6r1bw5Qxe+S28crS7j7Ja lmBqcS3s91s0bk7eka5uTs7aRGtG95XHADAuMm1UjD/Z8ZeAAtDErMBMjCUYpDOUF6RymAFPNan Zmxsv6yiggqP0TjPxom6mpLrzNTRD25+CKQC6SvakbZ2RMAjprZLQI5WRzOHgHAY9FuFHwy2ODS v9RgEYhgJTUF+ngoHqgsdRrQ6vRlMXf3NljhYyFWZOeBpeKY9Nj2xRWwdy6bF+fFM3v6jfXx25t KJR8//s09/OeM1aJcKgpbXZWOxsx917mDY5vy43Glh9379AcK1T+czJIcbOCbQbxm5XLo1KyTvZ LAWhZ9VYPfH5TkYytjD7jwB7Wsy5z+Y+8guJjBFe1n9gu33w+cq3ddOV7Jw5+KH19cq7jf52+X2 zPPsJDVZpFOzpA7D1XaLfjf139KwTDuopsMQgFhuxhYGsyUvvevPVnm93irX6xxqjAz/txZ61qn 4ig+V5jhEOOtIhKcA7ZPB+ide5YRnwmn9Z3s57bnWwR2kyBIJPUN0kgCIZF0dZ9liQqU2Vb6dH0 bl1s4AGo/f2hXjxJv41JqYQ4QA5WNwIUt1MEIgh6gFZ+7jqJaiGUm6S+nYbOqBoxC6jtPtyatXC RP/9BLoGnp4mEFA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

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
 tools/lib/bpf/libbpf.c | 114 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index afc07a8f7dc7..3a6108e3238b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -436,9 +436,11 @@ struct bpf_program {
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
@@ -765,6 +767,7 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 
 	prog->type = BPF_PROG_TYPE_UNSPEC;
 	prog->fd = -1;
+	prog->exception_cb_idx = -1;
 
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
@@ -871,14 +874,16 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
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
@@ -3142,6 +3147,86 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
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
+				/* Let's see if we already saw a static exception callback with the same name */
+				if (prog->exception_cb_idx >= 0) {
+					pr_warn("prog '%s': multiple subprogs with same name as exception callback '%s'\n",
+					        prog->name, subprog->name);
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
@@ -6270,10 +6355,10 @@ static int
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
@@ -6582,6 +6667,25 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 				prog->name, err);
 			return err;
 		}
+
+		/* Now, also append exception callback if it has not been done already. */
+		if (prog->exception_cb_idx >= 0) {
+			struct bpf_program *subprog = &obj->programs[prog->exception_cb_idx];
+
+			/* Calling exception callback directly is disallowed, which the
+			 * verifier will reject later. In case it was processed already,
+			 * we can skip this step, otherwise for all other valid cases we
+			 * have to append exception callback now.
+			 */
+			if (subprog->sub_insn_off == 0) {
+				err = bpf_object__append_subprog_code(obj, prog, subprog);
+				if (err)
+					return err;
+				err = bpf_object__reloc_code(obj, prog, subprog);
+				if (err)
+					return err;
+			}
+		}
 	}
 	/* Process data relos for main programs */
 	for (i = 0; i < obj->nr_programs; i++) {
-- 
2.41.0


