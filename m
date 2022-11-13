Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEC627043
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 16:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiKMPnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 10:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiKMPnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 10:43:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604CDF64;
        Sun, 13 Nov 2022 07:43:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b21so8008946plc.9;
        Sun, 13 Nov 2022 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nofCRpL3MvifHkw2V2hQLg22fSeqZVd0ZmEp5l62zAs=;
        b=SiNH2eNDSGfZDBznMfV99Y2Zu1VuNo18ICEdsjWN0IwVK6VymjI3/5q/g88Xtewmy1
         MhgFJEWpSbEGNKdBYJ3Fx+rGBwst2b659QLi8UGjNJZ0GvGNC3OUMmTyxbH3P9n6U+4W
         jB6DG1eCniHzF8YddLAynuO1oDBwmFrkhfk0ihSTHmBdgXpO8WpBViE5EspCJ2Zt9j3D
         o2lc6ReTJN2F2hmF2ig9a8cfSxPGx/j2dL0t7cTOGnb4CaXvs1LIrMGLRRBUNmPu958H
         /Z531Mq3ByPGrQ7qy6SqZP7PulZf1CPiXf6isMvR7O+9wABKA1k9nxIfYzCG6fxQKa1e
         mc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nofCRpL3MvifHkw2V2hQLg22fSeqZVd0ZmEp5l62zAs=;
        b=RrzvxRNTpmnR9Eaze81kzruh6zVWbWW66CectRbG1MJYOKl2p9Yz4efFXeY6hJIoPK
         nQ/bb1NyjbjG87WvYYFquQVnOkPv30fkXnHoHmnHq99O+GtybVOH62Mw60KS7h4i5a0w
         AfnfbwUl0udvN4Vj1ssPppq1hx/+zd9JppLUq9iL4d3U8W3c+1+sJaIo/493j4+JLDHw
         tkukyZoy2omhmaoCRerkbAGoYgDt9xSsxMy4Wu+XZ2zN3eSMjPEWBkYoeEsFdFtISCgG
         fNt4750jbUuSs0oCAvXfaKAv+sV0/cLDfQsyaWIxLed7iLDRqOqNaddGxiPnCYjaF/M8
         i2DQ==
X-Gm-Message-State: ANoB5pl+XqL1FKaDN08wot8IkZ38od33bSPri1Z/XtCuboVQLrIhCt0K
        pLBlOxoqQIWeOkfv7rTvT1Y=
X-Google-Smtp-Source: AA0mqf5UWgCTwlRwRepw5tjOYfUeis9wdWHlysDUPGdQnDpNf0e6xoWEOqnDAKsg3aiWGeFo06OlIA==
X-Received: by 2002:a17:902:9348:b0:186:b46d:da5e with SMTP id g8-20020a170902934800b00186b46dda5emr9631825plp.92.1668354195250;
        Sun, 13 Nov 2022 07:43:15 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm5304550plk.238.2022.11.13.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:43:14 -0800 (PST)
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
Subject: [PATCH 2/3] libbpf: Fixed various checkpatch issues in libbpf.c
Date:   Mon, 14 Nov 2022 00:42:57 +0900
Message-Id: <20221113154258.36560-3-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113154258.36560-1-tegongkang@gmail.com>
References: <20221113154258.36560-1-tegongkang@gmail.com>
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

