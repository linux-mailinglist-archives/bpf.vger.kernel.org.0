Return-Path: <bpf+bounces-9455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3EB797D5E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 22:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BAE281789
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9C14275;
	Thu,  7 Sep 2023 20:27:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886614013
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 20:27:05 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B351A1
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 13:27:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso1204357276.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694118422; x=1694723222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5gdAdvLkmlQuaA04rOpb0XCRj0v4HnanxheNXg/cN8=;
        b=kN61LPfE9f9I1qId0tNt7nyVCTRd6VKA3JYWyXKPA20A6wghBcx6o1ZXgDcundnUWb
         thVACuHKHlbJGX/C0OeR3pBbu+uo6/cizTKx+gZEUurPaFZft095aIeAm2UcWYl6GwjQ
         6YNy1QxKqYcAC9v7JCJq/WuuuAh3vDuCg2lMJnyK/ClOk7FdCcChOZyvLocy4jFDQCiV
         6Wx76SZFjH+HWyCtu1K/iVpc2fG7Qmmg4/qQHY1i6Kn0g1uzY73ojjj4L1hFI54dwB5A
         xznAfalluCWMF6tEjCcdECK+MqSm/89vH42hGH9i680KedS/6bn5FilnQ9HSvTbKgbne
         jMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118422; x=1694723222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5gdAdvLkmlQuaA04rOpb0XCRj0v4HnanxheNXg/cN8=;
        b=iswACZbsTxMJ0ZDd2tGOH3DsHKUNrdyg+VnoPeShogVIzeQiHo2woT7ZS4dXNzV8FO
         cqsNmJeYph+sHlmO5EHzjsULCtdXttHfSjmuRnQp+Vt/E5XSUZaDUvQoKENOivViPP1F
         sWlMk6ye1EUafLjDDNIXSRYHApiSdvPThtQRMznTBGfGfZjnc+MWVH4aEoOppiRLXREz
         Ax4AY28WIPL24zfpRH/AQ+OREih8WWKtzOOSY/KVT6r8uYlR4myzJzQ/MTxvMLbWEnpf
         sH/1o8dhfFiPU1ZDiPGX02fBnHYv6TQfgMDNDTwcod6K9BAGrN1U/7T8mRbDmSwPcaG5
         +kTQ==
X-Gm-Message-State: AOJu0YyvE5Jpgjb5pOHz11O6qSEp1OD4fls+HCCF6nMQ3Etj/eN+dv+l
	c6e0YoPMeXYBk3FFhEu2AQsIQGTSUo4=
X-Google-Smtp-Source: AGHT+IFWy4e8F1EodvJJT+1BoOqlGkVuuX30SgTArltZtU88awh9x6C38OZvhMA2QbKzG7NSxhQigg==
X-Received: by 2002:a5b:191:0:b0:d08:5a25:e6b4 with SMTP id r17-20020a5b0191000000b00d085a25e6b4mr453196ybl.28.1694118421897;
        Thu, 07 Sep 2023 13:27:01 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fe6d:cbb9:9c9f:13ce])
        by smtp.gmail.com with ESMTPSA id m15-20020a056902004f00b00d7497467d36sm44601ybh.45.2023.09.07.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 13:27:01 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next] Registering struct_ops types from modules.
Date: Thu,  7 Sep 2023 13:26:05 -0700
Message-Id: <20230907202605.90150-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Given the current constraints of the current implementation, struct_ops
cannot be registered dynamically. This presents a significant limitation
for modules like fuse-bpf, which seeks to implement a new struct_ops
type. To address this issue, here it proposes the introduction of a new
API. This API will enable the registering of new struct_ops types from
modules.

The following code is an example of how to implement a new struct_ops type
in a module with the proposed API. It adds a new type bpf_testmod_ops in
the bpf_testmod module. And, call register_bpf_struct_ops() and
unregister_bpf_struct_ops() when init and exit the module.

A module may forget or be unable to call unregister_bpf_struct_ops(). That
may cause tragedies. So, the bpf_struct_ops subsystem should handle it
automatically, as a fallback, when the module registered a struct_ops type
is unloaded.

---
 kernel/bpf/btf.c                              |  4 ++
 kernel/bpf/sysfs_btf.c                        |  1 +
 kernel/module/main.c                          |  7 +++
 tools/lib/bpf/btf.c                           |  2 +
 tools/lib/bpf/libbpf.c                        | 17 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 58 +++++++++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 49 ++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 27 +++++++++
 9 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ad8c2bbff47d..59a5372dec69 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7362,6 +7362,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	     op != MODULE_STATE_GOING))
 		goto out;
 
+	printk(KERN_CRIT "btf_module: %s %d\n", mod->name,
+	       op);
 	switch (op) {
 	case MODULE_STATE_COMING:
 		btf_mod = kzalloc(sizeof(*btf_mod), GFP_KERNEL);
@@ -7410,6 +7412,8 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			attr->read = btf_module_read;
 
 			err = sysfs_create_bin_file(btf_kobj, attr);
+			printk(KERN_CRIT "sysfs btf_module: %s %d %d\n", mod->name,
+			       op, err);
 			if (err) {
 				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
 					mod->name, err);
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index ef6911aee3bb..7224b58e92b2 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -17,6 +17,7 @@ btf_vmlinux_read(struct file *file, struct kobject *kobj,
 		 struct bin_attribute *bin_attr,
 		 char *buf, loff_t off, size_t len)
 {
+	printk(KERN_CRIT "BTF: vmlinux BTF name %s off %d len %d\n", bin_attr->attr.name, (int)off, (int)len);
 	memcpy(buf, __start_BTF + off, len);
 	return len;
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 59b1d067e528..e398036835d7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -348,6 +348,7 @@ struct module *find_module_all(const char *name, size_t len,
 {
 	struct module *mod;
 
+	printk(KERN_CRIT "find_module_all %s\n", name);
 	module_assert_mutex_or_preempt();
 
 	list_for_each_entry_rcu(mod, &modules, list,
@@ -2403,6 +2404,8 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	if (err)
 		return ERR_PTR(err);
 
+	printk(KERN_CRIT "Module %s.\n",
+	       info->name);
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
 	kmemleak_load_module(mod, info);
@@ -3136,6 +3139,7 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 		info.hdr = buf;
 		info.len = len;
 	}
+	printk(KERN_CRIT "init_module: %s\n", info.name);
 
 	return load_module(&info, uargs, flags);
 }
@@ -3163,6 +3167,8 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	int err;
 	struct fd f;
 
+	printk(KERN_CRIT "finit_module: fd=%d, uargs=%p, flags=%d\n",
+	       fd, uargs, flags);
 	err = may_init_module();
 	if (err)
 		return err;
@@ -3177,6 +3183,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	f = fdget(fd);
 	err = idempotent_init_module(f.file, uargs, flags);
 	fdput(f);
+	printk(KERN_CRIT "finit_module: finished err %d\n", err);
 	return err;
 }
 
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8484b563b53d..cc892d7f3262 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4794,6 +4794,7 @@ struct btf *btf__load_vmlinux_btf(void)
 		btf = btf__parse(path, NULL);
 		err = libbpf_get_error(btf);
 		pr_debug("loading kernel BTF '%s': %d\n", path, err);
+		printf("loading kernel BTF '%s': %d\n", path, err);
 		if (err)
 			continue;
 
@@ -4811,6 +4812,7 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
 	char path[80];
 
 	snprintf(path, sizeof(path), "/sys/kernel/btf/%s", module_name);
+	printf("loading module BTF '%s'\n", path);
 	return btf__parse_split(path, vmlinux_btf);
 }
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96ff1aa4bf6a..37d2f45280d0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7910,6 +7910,8 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	return 0;
 }
 
+int turnon_kk = false;
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
 	int err, i;
@@ -7926,13 +7928,25 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
 
 	err = bpf_object__probe_loading(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__create_maps(obj);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
+	if (turnon_kk)
+		printf("bpf_object__probe_loading err=%d\n", err);
 	err = err ? : bpf_object__load_progs(obj, extra_log_level);
 	err = err ? : bpf_object_init_prog_arrays(obj);
 	err = err ? : bpf_object_prepare_struct_ops(obj);
@@ -13105,7 +13119,9 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 {
 	int i, err;
 
+	printf("Loading BPF skeleton '%s'...\n", s->name);
 	err = bpf_object__load(*s->obj);
+	printf("bpf_object__load\n");
 	if (err) {
 		pr_warn("failed to load BPF skeleton '%s': %d\n", s->name, err);
 		return libbpf_err(err);
@@ -13150,6 +13166,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 		}
 	}
 
+	printf("BPF skeleton '%s' loaded successfully\n", s->name);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..5687ad53a093 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
+#include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/error-injection.h>
@@ -517,11 +518,62 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+
+static int bpf_testmod_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static bool bpf_testmod_ops_is_valid_access(int off, int size,
+					    enum bpf_access_type type,
+					    const struct bpf_prog *prog,
+					    struct bpf_insn_access_aux *info)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops_init_member(const struct btf_type *t,
+				       const struct btf_member *member,
+				       void *kdata, const void *udata)
+{
+	return 0;
+}
+
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_testmod_check_kfunc_ids,
 };
 
+static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
+	.is_valid_access = bpf_testmod_ops_is_valid_access,
+};
+
+static int bpf_dummy_reg(void *kdata)
+{
+	return 0;
+}
+
+static void bpf_dummy_unreg(void *kdata)
+{
+}
+
+struct bpf_struct_ops bpf_bpf_testmod_ops = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg,
+	.unreg = bpf_dummy_unreg,
+	.name = "bpf_testmod_ops",
+};
+
+static struct bpf_struct_ops_mod bpf_testmod_struct_ops = {
+	.owner = THIS_MODULE,
+	.st_ops = &bpf_bpf_testmod_ops,
+};
+
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -532,6 +584,9 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_struct_ops);
+#endif
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
@@ -541,6 +596,9 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	unregister_bpf_struct_ops(&bpf_testmod_struct_ops);
+#endif
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index f32793efe095..ca5435751c79 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -28,4 +28,9 @@ struct bpf_iter_testmod_seq {
 	int cnt;
 };
 
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+	int (*test_2)(int a, int b);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
new file mode 100644
index 000000000000..a6dee4b6dd68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_module.skel.h"
+#include "testing_helpers.h"
+
+static void test_regular_load()
+{
+	struct struct_ops_module *skel;
+	struct bpf_link *link;
+	extern int turnon_kk;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
+	int err;
+
+	turnon_kk = true;
+	opts.btf_custom_path = "/sys/kernel/btf/bpf_testmod",
+
+#if 0
+	unload_bpf_testmod(true);
+	if (!ASSERT_OK(load_bpf_testmod(true), "load_bpf_testmod"))
+		return;
+#endif
+
+	printf("test_regular_load\n");
+	skel = struct_ops_module__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
+		return;
+	err = struct_ops_module__load(skel);
+	if (!ASSERT_OK(err, "struct_ops_module_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	ASSERT_OK_PTR(link, "attach_test_mod_1");
+	bpf_link__destroy(link);
+
+	struct_ops_module__destroy(skel);
+
+#if 0
+	unload_bpf_testmod(false);
+#endif
+}
+
+void serial_test_struct_ops_module(void)
+{
+	if (test__start_subtest("regular_load"))
+		test_regular_load();
+}
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
new file mode 100644
index 000000000000..e77d29ae29a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	return 0xdeadbeef;
+}
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2, int a, int b)
+{
+	return a + b;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+};
+
-- 
2.34.1


