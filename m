Return-Path: <bpf+bounces-48469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AECBA08267
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548323A83C9
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD6203717;
	Thu,  9 Jan 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iX+BlgSA"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC823C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459271; cv=none; b=BXkNVzAPGwM2waM6XHZ4eQI3SfNXidUg+MTFAl8OAnvuJgpxMZFqv94uIxZftyld6pWSrUPMRyrquSRor0VIT5QVr3gc8kcO/gPoiyZz1vYqkc9s7Xyq8Q1EmIJZjBoluOb2DRtIcMe6kqdZe3HvSpUkVz0Oa3kDK9WvH017RHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459271; c=relaxed/simple;
	bh=xVbL8b/ZXQiBz5fMW+p+hIRVNAplAdZeCeERS1JKPeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2ejGHHVGfzgg0HGiwOONgGrEOdPgvKiViMQMdDqekMIqIoR7Pfe60YlH8cqYsR1fwIfKlqNWpzqLoThBGU1pL3UEAkCPUcpE/GzJJJtfwNDd2pTWZKg7cn3R2QNrTgyC4ZJ7b50cKbii+oVl3mKzt61bzZHdyJ9+/LjyhtyBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iX+BlgSA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3F8D203E3BC;
	Thu,  9 Jan 2025 13:47:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3F8D203E3BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459269;
	bh=pady67ct9spSujyAY4ybOosq2BSNmAUBdvFJJr0yDWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iX+BlgSA3mFgWAT/JyLXxGbN3qjDIbBUNYm9L5gzHt34i/Hc7d5MGgt+57M/8LCYu
	 /tE8IP2f731wm1MLFvwJ2sXDMiWUj7MhFuQVhTI3mymt3kFjTcHxVTpXdQ2rF2ukYI
	 3SvFOzkhnH7FNKDKsDfHOwEiGv8T0AwAwefex2P8=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 07/14] bpf: Implement BPF_LOAD_FD subcommand handler
Date: Thu,  9 Jan 2025 13:43:49 -0800
Message-ID: <20250109214617.485144-8-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new LOAD_FD subcommand keys off of a sysfs entry file descriptor
and a file descriptor pointing to a raw elf object file.

After performing some sysfs bookkeeping, the object file is copied
into the kernel, and with map and module metadata arrays.  Userspace
is expected to provide an array of file descriptors that correspond to
maps, along with module information, and offsets into the map array
that correspond with the arena allocator and the kconfig map if
applicable.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 242 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 37e45145e113b..3cfb497e1b236 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6074,6 +6074,245 @@ skip_mods_and_typedefs(const struct btf *btf, u32 id, u32 *res_id)
 	return t;
 }
 
+static void free_bpf_obj(struct bpf_obj *obj)
+{
+	int i;
+
+	if (!obj)
+		return;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		kfree(obj->progs[i].insn);
+		kfree(obj->progs[i].reloc_desc);
+	}
+
+	kfree(obj->progs);
+	vfree(obj->hdr);
+
+	btf_put(obj->btf);
+	btf_put(obj->btf_vmlinux);
+	btf_ext__free(obj->btf_ext);
+
+	for (i = 0; i < obj->btf_modules_cnt; i++)
+		btf_put(obj->btf_modules[i].btf);
+
+	kfree(obj->btf_modules);
+	kfree(obj->externs);
+	kfree(obj->maps);
+}
+
+#define BPF_LOADER_INODE_NAME "bpf-loader"
+
+static const struct inode_operations bpf_loader_iops = { };
+
+static int bpf_loader_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_obj *obj = filp->private_data;
+
+	free_bpf_obj(obj);
+	return 0;
+}
+
+static void bpf_loader_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	int i;
+	struct bpf_obj *obj = filp->private_data;
+
+	for (i = 0; i < obj->nr_programs; i++)
+		seq_printf(m, "program: %s\n", obj->progs[i].name);
+}
+
+static const struct file_operations bpf_loader_fops = {
+	.release	= bpf_loader_release,
+	.show_fdinfo	= bpf_loader_show_fdinfo,
+};
+
+static int loader_create(unsigned int bpffs_fd)
+{
+	struct inode *inode;
+	struct bpf_obj *obj = NULL;
+	struct file *file;
+	struct path path;
+	struct fd f;
+	umode_t mode;
+	int err, fd;
+
+	f = fdget(bpffs_fd);
+	if (!fd_file(f))
+		return -EBADF;
+
+	path = fd_file(f)->f_path;
+	path_get(&path);
+	fdput(f);
+
+	if (path.dentry != path.mnt->mnt_sb->s_root) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	if (path.mnt->mnt_sb->s_op != &bpf_super_ops) {
+		err = -EINVAL;
+		goto out_path;
+	}
+	err = path_permission(&path, MAY_ACCESS);
+	if (err)
+		goto out_path;
+
+	mode = S_IFREG | (0600 & ~current_umask());
+	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto out_path;
+	}
+
+	inode->i_op = &bpf_loader_iops;
+	inode->i_fop = &bpf_loader_fops;
+	clear_nlink(inode);
+
+	file = alloc_file_pseudo(inode, path.mnt, BPF_LOADER_INODE_NAME, O_RDWR, &bpf_loader_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto out_inode;
+	}
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj) {
+		err = -ENOMEM;
+		goto out_inode;
+	}
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		kfree(obj);
+		goto out_inode;
+	}
+
+	file->private_data = obj;
+	fd_install(fd, file);
+	path_put(&path);
+	return fd;
+
+out_inode:
+	iput(inode);
+	fput(file);
+out_path:
+	path_put(&path);
+	return err;
+}
+
+static int load_fd(union bpf_attr *attr)
+{
+	void *buf = NULL;
+	int len;
+	int i;
+	int obj_f;
+	struct fd obj_fd;
+	struct bpf_module_obj *modules;
+	struct bpf_obj *obj;
+	int err;
+
+	struct fd f;
+	struct fd bpffs_fd;
+
+	f = fdget(attr->load_fd.obj_fd);
+	if (!fd_file(f)) {
+		err = -EBADF;
+		goto out;
+	}
+
+	bpffs_fd = fdget(attr->load_fd.bpffs_fd);
+	if (!fd_file(bpffs_fd)) {
+		fdput(f);
+		err = -EBADF;
+		goto out;
+	}
+
+	obj_f = loader_create(attr->load_fd.bpffs_fd);
+	if (obj_f < 0) {
+		err = obj_f;
+		fdput(f);
+		fdput(bpffs_fd);
+		goto out;
+	}
+
+	obj_fd = fdget(obj_f);
+	obj = fd_file(obj_fd)->private_data;
+
+	len = kernel_read_file(fd_file(f), 0, &buf, INT_MAX, NULL, READING_EBPF);
+	if (len < 0) {
+		fdput(obj_fd);
+		err = len;
+		goto out;
+	}
+
+	obj->hdr = buf;
+	obj->len = len;
+	obj->nr_maps = attr->load_fd.map_cnt;
+	obj->maps = kmalloc_array(attr->load_fd.map_cnt, sizeof(struct bpf_map_obj), GFP_KERNEL);
+
+	if (!obj->maps) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	if (attr->load_fd.map_cnt) {
+		if (copy_from_user(obj->maps, (const void *)attr->load_fd.maps,
+				   sizeof(struct bpf_map_obj) * attr->load_fd.map_cnt) != 0) {
+			err = -EFAULT;
+			goto free;
+		}
+	}
+
+	obj->kconfig_map_idx = attr->load_fd.kconfig_map_idx;
+	obj->arena_map_idx = attr->load_fd.arena_map_idx;
+	obj->btf_vmlinux = bpf_get_btf_vmlinux();
+	modules = kmalloc_array(attr->load_fd.module_cnt,
+				sizeof(struct bpf_module_obj), GFP_KERNEL);
+
+	if (!modules) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+
+	if (attr->load_fd.module_cnt) {
+		if (copy_from_user(modules, (const void *)attr->load_fd.modules,
+				   sizeof(struct bpf_module_obj) * attr->load_fd.module_cnt) != 0) {
+			err = -EFAULT;
+			goto free;
+		}
+	}
+
+	obj->btf_modules_cnt = attr->load_fd.module_cnt;
+	obj->btf_modules = kmalloc_array(attr->load_fd.module_cnt,
+					 sizeof(struct bpf_module_btf), GFP_KERNEL);
+
+	if (!obj->btf_modules) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	for (i = 0; i < obj->btf_modules_cnt; i++) {
+		obj->btf_modules[i].fd = modules[i].fd;
+		obj->btf_modules[i].id = modules[i].id;
+		obj->btf_modules[i].fd_array_idx = modules[i].fd_array_idx;
+		obj->btf_modules[i].btf = btf_get_by_fd(obj->btf_modules[i].fd);
+		if (IS_ERR(obj->btf_modules[i].btf)) {
+			err = PTR_ERR(obj->btf_modules[i].btf);
+			kfree(modules);
+			goto free;
+		}
+	}
+	kfree(modules);
+
+	return obj_f;
+free:
+	free_bpf_obj(obj);
+	fd_file(obj_fd)->private_data = NULL;
+out:
+	return err;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6210,6 +6449,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_LOAD_FD:
+		err = load_fd(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.47.1


