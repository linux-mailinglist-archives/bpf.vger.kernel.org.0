Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48025CD9B
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgICWdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 18:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgICWdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 18:33:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E1CC061251
        for <bpf@vger.kernel.org>; Thu,  3 Sep 2020 15:33:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w1so3159331qto.4
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XDM1OhuX3TLQpzqxRlLR5VVQ3tUt6GSeykQfLg51+H8=;
        b=jK/PKpzxGHZ47H23t4exek9Nw1koW4AIm1uvnHG5RB9gO2CmUG8C6EYw3I+9JcchLP
         X/IqMQP8EkKkUV8iLZnKiUNnPVrJvkT0iVFG+5ISzglDaAiolBxdI20OVQ+fkOYIzFE4
         smgyW8N55saZG3+oHeh7XqTuyhcjL5JWs7iyxMRol/9/sf4cbZonDJbEKfAfL4CyTSIB
         w9um+Me1S7Lf5JL8FQSacXKi4VEUmzKGaKhwYWwbfGw+fYWYq5PQg1PmD8fopBh7ifTD
         Par7AIQFn4xr+VJbe4qeuglfq5Z3cOvWTUApkIrxXKOY3C6Bw0enQfubmV3GNllrgQqA
         8wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XDM1OhuX3TLQpzqxRlLR5VVQ3tUt6GSeykQfLg51+H8=;
        b=XAQYATcPz7USJe5D9qDHnw+t3jV1nmkn7x/flV86BlMu+felCLH2V4d4+i8V8ZLrKD
         lMsaCTo71leftukp5KE1dUr9OkhGezsIYpanpAVlGzc+lfZ0rh8o+HAyX3qur4FPf2MD
         Tmk0mUclEOkhRrOxzdbrevI4LQAbJRpP3DAJsC0w6g4GBkB/J4aJsZv78ebhV6o9go/F
         tKijc8FeWeHPpZC0jSro1f7HzkhYXpNwG1qhs8xB8SKvB4dMJmfI4o2x84Ihi8yG8OFk
         xiuLNfUW7dw89aRiB4QAgTq88+wQV27DYXjEWbm1fZqJiowkeHqwb5WtSTKJHiEXysKA
         u6Tg==
X-Gm-Message-State: AOAM531RiFocora/rpzOOhWUZNK6a+xRA+bOL5jxHNrPtkstBM3JxKjb
        s8cobDvVckwdSVsP++PUEDkIMJFGCHs=
X-Google-Smtp-Source: ABdhPJxzitrzFma4gOCFnUIKGFV8IGlR9DohDGBkBru2fjjJ598mh2bQr3Sx+oYjTj3Ks+w63XlG3yZoaxw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:f704:: with SMTP id w4mr5094197qvn.79.1599172419477;
 Thu, 03 Sep 2020 15:33:39 -0700 (PDT)
Date:   Thu,  3 Sep 2020 15:33:28 -0700
In-Reply-To: <20200903223332.881541-1-haoluo@google.com>
Message-Id: <20200903223332.881541-3-haoluo@google.com>
Mime-Version: 1.0
References: <20200903223332.881541-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH bpf-next v2 2/6] bpf/libbpf: BTF support for typed ksyms
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If a ksym is defined with a type, libbpf will try to find the ksym's btf
information from kernel btf. If a valid btf entry for the ksym is found,
libbpf can pass in the found btf id to the verifier, which validates the
ksym's type and value.

Typeless ksyms (i.e. those defined as 'void') will not have such btf_id,
but it has the symbol's address (read from kallsyms) and its value is
treated as a raw pointer.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 116 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b688aadf09c5..c7a8d7d72b46 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -361,6 +361,12 @@ struct extern_desc {
 		} kcfg;
 		struct {
 			unsigned long long addr;
+
+			/* target btf_id of the corresponding kernel var. */
+			int vmlinux_btf_id;
+
+			/* local btf_id of the ksym extern's type. */
+			__u32 type_id;
 		} ksym;
 	};
 };
@@ -2479,12 +2485,23 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
 {
 	bool need_vmlinux_btf = false;
 	struct bpf_program *prog;
-	int err;
+	int i, err;
 
 	/* CO-RE relocations need kernel BTF */
 	if (obj->btf_ext && obj->btf_ext->core_relo_info.len)
 		need_vmlinux_btf = true;
 
+	/* Support for typed ksyms needs kernel BTF */
+	for (i = 0; i < obj->nr_extern; i++) {
+		const struct extern_desc *ext;
+
+		ext = &obj->externs[i];
+		if (ext->type == EXT_KSYM && ext->ksym.type_id) {
+			need_vmlinux_btf = true;
+			break;
+		}
+	}
+
 	bpf_object__for_each_program(prog, obj) {
 		if (!prog->load)
 			continue;
@@ -3060,16 +3077,10 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 				return -ENOTSUP;
 			}
 		} else if (strcmp(sec_name, KSYMS_SEC) == 0) {
-			const struct btf_type *vt;
-
 			ksym_sec = sec;
 			ext->type = EXT_KSYM;
-
-			vt = skip_mods_and_typedefs(obj->btf, t->type, NULL);
-			if (!btf_is_void(vt)) {
-				pr_warn("extern (ksym) '%s' is not typeless (void)\n", ext_name);
-				return -ENOTSUP;
-			}
+			skip_mods_and_typedefs(obj->btf, t->type,
+					       &ext->ksym.type_id);
 		} else {
 			pr_warn("unrecognized extern section '%s'\n", sec_name);
 			return -ENOTSUP;
@@ -3119,6 +3130,8 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 			vt->type = int_btf_id;
 			vs->offset = off;
 			vs->size = sizeof(int);
+			pr_debug("ksym var_secinfo: var '%s', type #%d, size %d, offset %d\n",
+				 ext->name, vt->type, vs->size, vs->offset);
 		}
 		sec->size = off;
 	}
@@ -5724,8 +5737,13 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
 				insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
 				insn[1].imm = ext->kcfg.data_off;
 			} else /* EXT_KSYM */ {
-				insn[0].imm = (__u32)ext->ksym.addr;
-				insn[1].imm = ext->ksym.addr >> 32;
+				if (ext->ksym.type_id) { /* typed ksyms */
+					insn[0].src_reg = BPF_PSEUDO_BTF_ID;
+					insn[0].imm = ext->ksym.vmlinux_btf_id;
+				} else { /* typeless ksyms */
+					insn[0].imm = (__u32)ext->ksym.addr;
+					insn[1].imm = ext->ksym.addr >> 32;
+				}
 			}
 			break;
 		case RELO_CALL:
@@ -6462,10 +6480,72 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 	return err;
 }
 
+static int bpf_object__resolve_ksyms_btf_id(struct bpf_object *obj)
+{
+	struct extern_desc *ext;
+	int i, id;
+
+	if (!obj->btf_vmlinux) {
+		pr_warn("support of typed ksyms needs kernel btf.\n");
+		return -ENOENT;
+	}
+
+	for (i = 0; i < obj->nr_extern; i++) {
+		const struct btf_type *targ_var, *targ_type;
+		__u32 targ_type_id, local_type_id;
+		int ret;
+
+		ext = &obj->externs[i];
+		if (ext->type != EXT_KSYM || !ext->ksym.type_id)
+			continue;
+
+		id = btf__find_by_name_kind(obj->btf_vmlinux, ext->name,
+					    BTF_KIND_VAR);
+		if (id <= 0) {
+			pr_warn("no btf entry for ksym '%s' in vmlinux.\n",
+				ext->name);
+			return -ESRCH;
+		}
+
+		/* find target type_id */
+		targ_var = btf__type_by_id(obj->btf_vmlinux, id);
+		targ_type = skip_mods_and_typedefs(obj->btf_vmlinux,
+						   targ_var->type,
+						   &targ_type_id);
+
+		/* find local type_id */
+		local_type_id = ext->ksym.type_id;
+
+		ret = bpf_core_types_are_compat(obj->btf_vmlinux, targ_type_id,
+						obj->btf, local_type_id);
+		if (ret <= 0) {
+			const struct btf_type *local_type;
+			const char *targ_name, *local_name;
+
+			local_type = btf__type_by_id(obj->btf, local_type_id);
+			targ_name = btf__name_by_offset(obj->btf_vmlinux,
+							targ_type->name_off);
+			local_name = btf__name_by_offset(obj->btf,
+							 local_type->name_off);
+
+			pr_warn("ksym '%s' expects type '%s' (vmlinux_btf_id: #%d), "
+				"but got '%s' (btf_id: #%d)\n", ext->name,
+				targ_name, targ_type_id, local_name, local_type_id);
+			return -EINVAL;
+		}
+
+		ext->is_set = true;
+		ext->ksym.vmlinux_btf_id = id;
+		pr_debug("extern (ksym) %s=vmlinux_btf_id(#%d)\n", ext->name, id);
+	}
+	return 0;
+}
+
 static int bpf_object__resolve_externs(struct bpf_object *obj,
 				       const char *extra_kconfig)
 {
-	bool need_config = false, need_kallsyms = false;
+	bool need_kallsyms = false, need_vmlinux_btf = false;
+	bool need_config = false;
 	struct extern_desc *ext;
 	void *kcfg_data = NULL;
 	int err, i;
@@ -6496,7 +6576,10 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 			   strncmp(ext->name, "CONFIG_", 7) == 0) {
 			need_config = true;
 		} else if (ext->type == EXT_KSYM) {
-			need_kallsyms = true;
+			if (ext->ksym.type_id)
+				need_vmlinux_btf = true;
+			else
+				need_kallsyms = true;
 		} else {
 			pr_warn("unrecognized extern '%s'\n", ext->name);
 			return -EINVAL;
@@ -6525,6 +6608,11 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 		if (err)
 			return -EINVAL;
 	}
+	if (need_vmlinux_btf) {
+		err = bpf_object__resolve_ksyms_btf_id(obj);
+		if (err)
+			return -EINVAL;
+	}
 	for (i = 0; i < obj->nr_extern; i++) {
 		ext = &obj->externs[i];
 
@@ -6557,10 +6645,10 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	}
 
 	err = bpf_object__probe_loading(obj);
+	err = err ? : bpf_object__load_vmlinux_btf(obj);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
-	err = err ? : bpf_object__load_vmlinux_btf(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
 	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
-- 
2.28.0.526.ge36021eeef-goog

