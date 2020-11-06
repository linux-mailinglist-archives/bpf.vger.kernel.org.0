Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBC2AA0AF
	for <lists+bpf@lfdr.de>; Sat,  7 Nov 2020 00:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKFXFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 18:05:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729023AbgKFXFL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 18:05:11 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6N4F7e025633
        for <bpf@vger.kernel.org>; Fri, 6 Nov 2020 15:05:10 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34mx9pd4jd-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 15:05:09 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 15:05:08 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 95E932EC8FA6; Fri,  6 Nov 2020 15:02:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <jeyu@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 bpf-next 4/5] bpf: load and verify kernel module BTFs
Date:   Fri, 6 Nov 2020 15:02:27 -0800
Message-ID: <20201106230228.2202-5-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106230228.2202-1-andrii@kernel.org>
References: <20201106230228.2202-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=29 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add kernel module listener that will load/validate and unload module BTF.
Module BTFs gets ID generated for them, which makes it possible to iterate
them with existing BTF iteration API. They are given their respective module's
names, which will get reported through GET_OBJ_INFO API. They are also marked
as in-kernel BTFs for tooling to distinguish them from user-provided BTFs.

Also, similarly to vmlinux BTF, kernel module BTFs are exposed through
sysfs as /sys/kernel/btf/<module-name>. This is convenient for user-space
tools to inspect module BTF contents and dump their types with existing tools:

[vmuser@archvm bpf]$ ls -la /sys/kernel/btf
total 0
drwxr-xr-x  2 root root       0 Nov  4 19:46 .
drwxr-xr-x 13 root root       0 Nov  4 19:46 ..

...

-r--r--r--  1 root root     888 Nov  4 19:46 irqbypass
-r--r--r--  1 root root  100225 Nov  4 19:46 kvm
-r--r--r--  1 root root   35401 Nov  4 19:46 kvm_intel
-r--r--r--  1 root root     120 Nov  4 19:46 pcspkr
-r--r--r--  1 root root     399 Nov  4 19:46 serio_raw
-r--r--r--  1 root root 4094095 Nov  4 19:46 vmlinux

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-btf |   8 +
 include/linux/bpf.h                        |   2 +
 include/linux/module.h                     |   4 +
 kernel/bpf/btf.c                           | 194 +++++++++++++++++++++
 kernel/bpf/sysfs_btf.c                     |   2 +-
 kernel/module.c                            |  32 ++++
 6 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-btf b/Documentation/ABI/testing/sysfs-kernel-btf
index 2c9744b2cd59..fe96efdc9b6c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-btf
+++ b/Documentation/ABI/testing/sysfs-kernel-btf
@@ -15,3 +15,11 @@ Description:
 		information with description of all internal kernel types. See
 		Documentation/bpf/btf.rst for detailed description of format
 		itself.
+
+What:		/sys/kernel/btf/<module-name>
+Date:		Nov 2020
+KernelVersion:	5.11
+Contact:	bpf@vger.kernel.org
+Description:
+		Read-only binary attribute exposing kernel module's BTF type
+		information as an add-on to the kernel's BTF (/sys/kernel/btf/vmlinux).
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73d5381a5d5c..581b2a2e78eb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -36,9 +36,11 @@ struct seq_operations;
 struct bpf_iter_aux_info;
 struct bpf_local_storage;
 struct bpf_local_storage_map;
+struct kobject;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
+extern struct kobject *btf_kobj;
 
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
 					struct bpf_iter_aux_info *aux);
diff --git a/include/linux/module.h b/include/linux/module.h
index a29187f7c360..20fce258ffba 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -475,6 +475,10 @@ struct module {
 	unsigned int num_bpf_raw_events;
 	struct bpf_raw_event_map *bpf_raw_events;
 #endif
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	unsigned int btf_data_size;
+	void *btf_data;
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	struct jump_entry *jump_entries;
 	unsigned int num_jump_entries;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09f1483934d2..c53b213811a7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -23,6 +23,8 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include <net/sock.h>
 
 /* BTF (BPF Type Format) is the meta data format which describes
@@ -4488,6 +4490,75 @@ struct btf *btf_parse_vmlinux(void)
 	return ERR_PTR(err);
 }
 
+static struct btf *btf_parse_module(const char *module_name, const void *data, unsigned int data_size)
+{
+	struct btf_verifier_env *env = NULL;
+	struct bpf_verifier_log *log;
+	struct btf *btf = NULL, *base_btf;
+	int err;
+
+	base_btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(base_btf))
+		return base_btf;
+	if (!base_btf)
+		return ERR_PTR(-EINVAL);
+
+	env = kzalloc(sizeof(*env), GFP_KERNEL | __GFP_NOWARN);
+	if (!env)
+		return ERR_PTR(-ENOMEM);
+
+	log = &env->log;
+	log->level = BPF_LOG_KERNEL;
+
+	btf = kzalloc(sizeof(*btf), GFP_KERNEL | __GFP_NOWARN);
+	if (!btf) {
+		err = -ENOMEM;
+		goto errout;
+	}
+	env->btf = btf;
+
+	btf->base_btf = base_btf;
+	btf->start_id = base_btf->nr_types;
+	btf->start_str_off = base_btf->hdr.str_len;
+	btf->kernel_btf = true;
+	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
+
+	btf->data = kvmalloc(data_size, GFP_KERNEL | __GFP_NOWARN);
+	if (!btf->data) {
+		err = -ENOMEM;
+		goto errout;
+	}
+	memcpy(btf->data, data, data_size);
+	btf->data_size = data_size;
+
+	err = btf_parse_hdr(env);
+	if (err)
+		goto errout;
+
+	btf->nohdr_data = btf->data + btf->hdr.hdr_len;
+
+	err = btf_parse_str_sec(env);
+	if (err)
+		goto errout;
+
+	err = btf_check_all_metas(env);
+	if (err)
+		goto errout;
+
+	btf_verifier_env_free(env);
+	refcount_set(&btf->refcnt, 1);
+	return btf;
+
+errout:
+	btf_verifier_env_free(env);
+	if (btf) {
+		kvfree(btf->data);
+		kvfree(btf->types);
+		kfree(btf);
+	}
+	return ERR_PTR(err);
+}
+
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 {
 	struct bpf_prog *tgt_prog = prog->aux->dst_prog;
@@ -5661,3 +5732,126 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
+
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+struct btf_module {
+	struct list_head list;
+	struct module *module;
+	struct btf *btf;
+	struct bin_attribute *sysfs_attr;
+};
+
+static LIST_HEAD(btf_modules);
+static DEFINE_MUTEX(btf_module_mutex);
+
+static ssize_t
+btf_module_read(struct file *file, struct kobject *kobj,
+		struct bin_attribute *bin_attr,
+		char *buf, loff_t off, size_t len)
+{
+	const struct btf *btf = bin_attr->private;
+
+	memcpy(buf, btf->data + off, len);
+	return len;
+}
+
+static int btf_module_notify(struct notifier_block *nb, unsigned long op,
+			     void *module)
+{
+	struct btf_module *btf_mod, *tmp;
+	struct module *mod = module;
+	struct btf *btf;
+	int err = 0;
+
+	if (mod->btf_data_size == 0 ||
+	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
+		goto out;
+
+	switch (op) {
+	case MODULE_STATE_COMING:
+		btf_mod = kzalloc(sizeof(*btf_mod), GFP_KERNEL);
+		if (!btf_mod) {
+			err = -ENOMEM;
+			goto out;
+		}
+		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
+		if (IS_ERR(btf)) {
+			pr_warn("failed to validate module [%s] BTF: %ld\n",
+				mod->name, PTR_ERR(btf));
+			kfree(btf_mod);
+			err = PTR_ERR(btf);
+			goto out;
+		}
+		err = btf_alloc_id(btf);
+		if (err) {
+			btf_free(btf);
+			kfree(btf_mod);
+			goto out;
+		}
+
+		mutex_lock(&btf_module_mutex);
+		btf_mod->module = module;
+		btf_mod->btf = btf;
+		list_add(&btf_mod->list, &btf_modules);
+		mutex_unlock(&btf_module_mutex);
+
+		if (IS_ENABLED(CONFIG_SYSFS)) {
+			struct bin_attribute *attr;
+
+			attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+			if (!attr)
+				goto out;
+
+			sysfs_bin_attr_init(attr);
+			attr->attr.name = btf->name;
+			attr->attr.mode = 0444;
+			attr->size = btf->data_size;
+			attr->private = btf;
+			attr->read = btf_module_read;
+
+			err = sysfs_create_bin_file(btf_kobj, attr);
+			if (err) {
+				pr_warn("failed to register module [%s] BTF in sysfs: %d\n",
+					mod->name, err);
+				kfree(attr);
+				err = 0;
+				goto out;
+			}
+
+			btf_mod->sysfs_attr = attr;
+		}
+
+		break;
+	case MODULE_STATE_GOING:
+		mutex_lock(&btf_module_mutex);
+		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+			if (btf_mod->module != module)
+				continue;
+
+			list_del(&btf_mod->list);
+			if (btf_mod->sysfs_attr)
+				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
+			btf_put(btf_mod->btf);
+			kfree(btf_mod->sysfs_attr);
+			kfree(btf_mod);
+			break;
+		}
+		mutex_unlock(&btf_module_mutex);
+		break;
+	}
+out:
+	return notifier_from_errno(err);
+}
+
+static struct notifier_block btf_module_nb = {
+	.notifier_call = btf_module_notify,
+};
+
+static int __init btf_module_init(void)
+{
+	register_module_notifier(&btf_module_nb);
+	return 0;
+}
+
+fs_initcall(btf_module_init);
+#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 11b3380887fa..ef6911aee3bb 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -26,7 +26,7 @@ static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.read = btf_vmlinux_read,
 };
 
-static struct kobject *btf_kobj;
+struct kobject *btf_kobj;
 
 static int __init btf_vmlinux_init(void)
 {
diff --git a/kernel/module.c b/kernel/module.c
index a4fa44a652a7..f2996b02ab2e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -380,6 +380,35 @@ static void *section_objs(const struct load_info *info,
 	return (void *)info->sechdrs[sec].sh_addr;
 }
 
+/* Find a module section: 0 means not found. Ignores SHF_ALLOC flag. */
+static unsigned int find_any_sec(const struct load_info *info, const char *name)
+{
+	unsigned int i;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		if (strcmp(info->secstrings + shdr->sh_name, name) == 0)
+			return i;
+	}
+	return 0;
+}
+
+/*
+ * Find a module section, or NULL. Fill in number of "objects" in section.
+ * Ignores SHF_ALLOC flag.
+ */
+static __maybe_unused void *any_section_objs(const struct load_info *info,
+					     const char *name,
+					     size_t object_size,
+					     unsigned int *num)
+{
+	unsigned int sec = find_any_sec(info, name);
+
+	/* Section 0 has sh_addr 0 and sh_size 0. */
+	*num = info->sechdrs[sec].sh_size / object_size;
+	return (void *)info->sechdrs[sec].sh_addr;
+}
+
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
@@ -3250,6 +3279,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					   sizeof(*mod->bpf_raw_events),
 					   &mod->num_bpf_raw_events);
 #endif
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	mod->btf_data = any_section_objs(info, ".BTF", 1, &mod->btf_data_size);
+#endif
 #ifdef CONFIG_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
-- 
2.24.1

