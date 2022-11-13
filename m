Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C60C6271EE
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 20:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiKMTHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 14:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiKMTHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 14:07:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D309101D2;
        Sun, 13 Nov 2022 11:07:06 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y13so9177470pfp.7;
        Sun, 13 Nov 2022 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nofCRpL3MvifHkw2V2hQLg22fSeqZVd0ZmEp5l62zAs=;
        b=po/BkfKbLzEs7eufSudB0ypgFSTUDk5q7mKyhSYPuzWw+QpGJZsd5wbnD/+6C35x4A
         DyU233AKkvfKZXc4/zr9oZFg5825lt7Ny4qKjNI26cb2FrJtpkKuHhloGLVCzOP5SGhz
         CLQMcx9gQ2X7XpPL/JMKR6nKZLQbwSZvMkEOSXGzPRnI9SAqXxwiNxMtTeRwH6RIOjEg
         pUwwrriDMrZVrDlqP8GjfZPDRr3gbjUS7N6hQfr/dz0L9jhHChcZnehN5bNu4YA/NUE5
         lrFr+Y+9qT4IKk97f/ku+ouBsqEtzhokbUHj/0TL0nl9Y+5vs/9uJ0myu+1vBrkKk2fh
         gEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nofCRpL3MvifHkw2V2hQLg22fSeqZVd0ZmEp5l62zAs=;
        b=K9q+sQ4Vk0RbBPO17hAmKQau29HuVY6ZDqNB+Z25On+Mfpd0PFVEIsPY/s/ZaSjaPc
         f0Nt8YimGiBgqw6i2h+Oy5x7D8D6fwaSqIyUV3mly6BVfifYTnfgaJyX/liRh+qhosd2
         M2MZPzi77amPEfgxvqulW1QGIWVulUI3gvCXp2uFiaiFOmrpTzGxG3bQf5S4Thmockie
         CWYDJn7/339s+wPoPTVEkTOoKShG7tOKN/uRcie98HSOJUJpZLCs4/liLcy47srRwW/K
         RDMIxWnsWfbVyG2tEVb20eA++0/JsG9MaAtv7Okpqx7loEIakHte0PXBVOBPyYS+Wt0z
         VAVA==
X-Gm-Message-State: ANoB5pnoWz4P7Gxk2/F3+DcMw1wjFM9O5suapduQlJC9XCdvLl+0naLO
        t9oFH1D5XAnJjEvZqSAmx4k=
X-Google-Smtp-Source: AA0mqf5YzL2eFSK0ukg1f5a6wC75i2U9F+cmE1OoHgWlPgcCHfrgzHXQ9bU3T4tavcw6KeiDhtkZRA==
X-Received: by 2002:a63:f53:0:b0:456:d859:2143 with SMTP id 19-20020a630f53000000b00456d8592143mr9353650pgp.396.1668366425414;
        Sun, 13 Nov 2022 11:07:05 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001869f2120a5sm5549604plh.34.2022.11.13.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:07:04 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 2/3] libbpf: Fixed various checkpatch issues in libbpf.c
Date:   Mon, 14 Nov 2022 04:06:47 +0900
Message-Id: <20221113190648.38556-3-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113190648.38556-1-tegongkang@gmail.com>
References: <20221113190648.38556-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixed following checkpatch issues:

WARNING: Block comments use a trailing */ on a separate line
+        * other BPF program's BTF object */

WARNING: Possible repeated word: 'be'
+        * name. This is important to be be able to find corresponding BTF

ERROR: switch and case should be at the same indent
+       switch (ext->kcfg.sz) {
+               case 1: *(__u8 *)ext_val = value; break;
+               case 2: *(__u16 *)ext_val = value; break;
+               case 4: *(__u32 *)ext_val = value; break;
+               case 8: *(__u64 *)ext_val = value; break;
+               default:

ERROR: trailing statements should be on next line
+               case 1: *(__u8 *)ext_val = value; break;

ERROR: trailing statements should be on next line
+               case 2: *(__u16 *)ext_val = value; break;

ERROR: trailing statements should be on next line
+               case 4: *(__u32 *)ext_val = value; break;

ERROR: trailing statements should be on next line
+               case 8: *(__u64 *)ext_val = value; break;

ERROR: code indent should use tabs where possible
+                }$

WARNING: please, no spaces at the start of a line
+                }$

WARNING: Block comments use a trailing */ on a separate line
+        * for faster search */

ERROR: code indent should use tabs where possible
+^I^I^I^I^I^I        &ext->kcfg.is_signed);$

WARNING: braces {} are not necessary for single statement blocks
+       if (err) {
+               return err;
+       }

ERROR: code indent should use tabs where possible
+^I^I^I^I        sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);$

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 tools/lib/bpf/libbpf.c | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1d263885d635..b5df6aca06ea 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -347,7 +347,8 @@ enum sec_def_flags {
 	SEC_ATTACHABLE = 2,
 	SEC_ATTACHABLE_OPT = SEC_ATTACHABLE | SEC_EXP_ATTACH_OPT,
 	/* attachment target is specified through BTF ID in either kernel or
-	 * other BPF program's BTF object */
+	 * other BPF program's BTF object
+	 */
 	SEC_ATTACH_BTF = 4,
 	/* BPF program type allows sleeping/blocking in kernel */
 	SEC_SLEEPABLE = 8,
@@ -488,7 +489,7 @@ struct bpf_map {
 	char *name;
 	/* real_name is defined for special internal maps (.rodata*,
 	 * .data*, .bss, .kconfig) and preserves their original ELF section
-	 * name. This is important to be be able to find corresponding BTF
+	 * name. This is important to be able to find corresponding BTF
 	 * DATASEC information.
 	 */
 	char *real_name;
@@ -1863,12 +1864,20 @@ static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
 		return -ERANGE;
 	}
 	switch (ext->kcfg.sz) {
-		case 1: *(__u8 *)ext_val = value; break;
-		case 2: *(__u16 *)ext_val = value; break;
-		case 4: *(__u32 *)ext_val = value; break;
-		case 8: *(__u64 *)ext_val = value; break;
-		default:
-			return -EINVAL;
+	case 1:
+		*(__u8 *)ext_val = value;
+		break;
+	case 2:
+		*(__u16 *)ext_val = value;
+		break;
+	case 4:
+		*(__u32 *)ext_val = value;
+		break;
+	case 8:
+		*(__u64 *)ext_val = value;
+		break;
+	default:
+		return -EINVAL;
 	}
 	ext->is_set = true;
 	return 0;
@@ -2770,7 +2779,7 @@ static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 				m->type = enum64_placeholder_id;
 				m->offset = 0;
 			}
-                }
+		}
 	}
 
 	return 0;
@@ -3518,7 +3527,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 	}
 
 	/* sort BPF programs by section name and in-section instruction offset
-	 * for faster search */
+	 * for faster search
+	 */
 	if (obj->nr_programs)
 		qsort(obj->programs, obj->nr_programs, sizeof(*obj->programs), cmp_progs);
 
@@ -3817,7 +3827,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 				return -EINVAL;
 			}
 			ext->kcfg.type = find_kcfg_type(obj->btf, t->type,
-						        &ext->kcfg.is_signed);
+							&ext->kcfg.is_signed);
 			if (ext->kcfg.type == KCFG_UNKNOWN) {
 				pr_warn("extern (kcfg) '%s': type is unsupported\n", ext_name);
 				return -ENOTSUP;
@@ -4965,9 +4975,9 @@ bpf_object__reuse_map(struct bpf_map *map)
 
 	err = bpf_map__reuse_fd(map, pin_fd);
 	close(pin_fd);
-	if (err) {
+	if (err)
 		return err;
-	}
+
 	map->pinned = true;
 	pr_debug("reused pinned map at '%s'\n", map->pin_path);
 
@@ -5485,7 +5495,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		}
 
 		err = libbpf_ensure_mem((void **)&obj->btf_modules, &obj->btf_module_cap,
-				        sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
+					sizeof(*obj->btf_modules), obj->btf_module_cnt + 1);
 		if (err)
 			goto err_out;
 
@@ -6237,7 +6247,8 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		 * prog; each main prog can have a different set of
 		 * subprograms appended (potentially in different order as
 		 * well), so position of any subprog can be different for
-		 * different main programs */
+		 * different main programs
+		 */
 		insn->imm = subprog->sub_insn_off - (prog->sub_insn_off + insn_idx) - 1;
 
 		pr_debug("prog '%s': insn #%zu relocated, imm %d points to subprog '%s' (now at %zu offset)\n",
@@ -10995,7 +11006,7 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 
 	usdt_cookie = OPTS_GET(opts, usdt_cookie, 0);
 	link = usdt_manager_attach_usdt(obj->usdt_man, prog, pid, binary_path,
-				        usdt_provider, usdt_name, usdt_cookie);
+					usdt_provider, usdt_name, usdt_cookie);
 	err = libbpf_get_error(link);
 	if (err)
 		return libbpf_err_ptr(err);
@@ -12304,7 +12315,7 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 	btf = bpf_object__btf(s->obj);
 	if (!btf) {
 		pr_warn("subskeletons require BTF at runtime (object %s)\n",
-		        bpf_object__name(s->obj));
+			bpf_object__name(s->obj));
 		return libbpf_err(-errno);
 	}
 
-- 
2.34.1

