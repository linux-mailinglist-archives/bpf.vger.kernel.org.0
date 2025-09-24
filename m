Return-Path: <bpf+bounces-69637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E402B9C885
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740424E3306
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6C29CB3A;
	Wed, 24 Sep 2025 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQgRLCDI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030D28488A
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756286; cv=none; b=ava3G/LQ9zNIZlCxl54tUVftw951xYma4vRgUaUUaAgyw+tlsdLeRp2XlaqfxyMELzuXZDTxUTb6xTIHCNYwr0KCcQ19zJDvATHoAGNYW7VBN2w9F26px9Qd/d60wSQ6Wo+BJtAZHX7hX368M7Icn560AriuBUMucNU6B8hHvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756286; c=relaxed/simple;
	bh=Hwj4ckhb5DTcc8UE9wkW8Nw57797AjnMiK+e62cBtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6hBGJf/f4xI3sirxFxSqNE4z4LVcWgExjQtQLOIVQp/5PAR7ixyh1jAwA+98P3JkoYP2eJ52XOHTFUsvcvL0sfzAfvTzceivkyMZUMmpVujYK9KbUOYWnjqcDj+9cCUoP4XONWXpt8JOikp/pW7PBfgkKxlvJadXD1i5ETZz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQgRLCDI; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-84d8e2587d6so30443985a.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756283; x=1759361083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y6EMmIcmPN+na3Sl1GzqFT2rkaqC+6JSJKayEapinw=;
        b=MQgRLCDI4Leblks5s5JdkhcruDNrM8we3xTxNnpGub0PwkDkcsc4vaXMh36qhU3pft
         cKbCBEKp0svuACUodaj1tvZCXzxBCvNkqArJeumK8ZEauNSeLZZcvjqTT8Ybjzr+hCbs
         pIMyed3aaleVX9HMePpgw4xAxai9fRgTXRH21ToqANI3ZveKvGBsXos1QhmrofPaSXa7
         m05OyzSedRL8upGCaiPKxwl2q9oNz7OyBzfHtw0ne0QmUI7COk9Ut9vUpNDmZ9HkhTV9
         +7kUj1V1ajX6Xw6TFMsDOtXDppOwG+AUFN/gnIraqKh9KFWGsPGZQAzyKH0ZU24/eYE2
         j9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756283; x=1759361083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y6EMmIcmPN+na3Sl1GzqFT2rkaqC+6JSJKayEapinw=;
        b=Vx/73Rkm2T5kIGZB25gWV0oD2iWMe0MfTbHinWs0Vz5Qe5cbEDhBYomHg3souRVyWS
         aGcRBYaeB3h929u13RhmZ3qg3Edn+aP2O8pC+8CYY/RMSGvzOZDYKOiMn4H4yHN+l787
         qsYPg0R+FWEKkEDKVxnmvIeotjs7sYgeX6knWebY/mSac2pGh9RWVWiHBPJgOTQqx20i
         bfLmZlv0crCRpW1YJGZplEEnjB+mecSF51TTVBTnN2f2TXWlZcSZUpFwz39XtM+kMEB0
         X45avh4g6hpxoDl3sq7VFfOt1NitDewAhl9RaQijMD2jSx4W/U3hiNmyr6ADWt3I7SyM
         AeGg==
X-Gm-Message-State: AOJu0Yw+JuL98jxsjw+WObNElBR+nuzjASWAa3QORffqmu5orkGZnnRz
	J4RKmdSUWPKghxfwihfxQCLBZAQXe15UxttdV1vqnmD8u6TJanEmV8LPZdOm5MEm9d0=
X-Gm-Gg: ASbGnct5z8VsE2B4EM1ce1tlBdclXJvY+u57MtMsOVEzXzOXriWs9O+LyuloCwb57LX
	MaflEjD+TWN5JY3RFjgRryJQ2szGPoXxSNPlPhRJCHbkXYTktBZdktUSC/vp1/ZYhdbNbYZA9Rh
	L8BbYQ9xc9CnDQw79OgvDiVrJQu72UfvmFHgg1s4p02vDGJFN5x1r7xAQjR5+//NfDzcExuKhaJ
	EWkQzPVsX7JqSr0gZQNUEBdl9qUIxyOx1aYbhgCMEwbdPsfpXTb2V3qZa5DOdKseUt2WSgT6q91
	9z7ADYazNuwLuKQpFa4m96ynSIptRIg6ha2tpbkircCcSMLevZZJlSD6WgCgUmECjUe9TFEgayN
	+cnXmCY/16C8hEeFvijqHIoezFYQOI1oA02MrUXGJEMIrhALeF0aEiSUIPiu/1/O75zVDE6DGDq
	7O8BY4EWp1L16AxR6CrEUQ4gsaOZg=
X-Google-Smtp-Source: AGHT+IHDUMqGg8lGvUVV3/0K130ob6QpaUMxuL0wG0YcMB+sfiZMR0SDmArQInyj/I2Nfd9qxcCPug==
X-Received: by 2002:a05:620a:4051:b0:84b:3c5a:e449 with SMTP id af79cd13be357-85ae7cd4d89mr171227285a.60.1758756283424;
        Wed, 24 Sep 2025 16:24:43 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c336ad64bsm14213285a.59.2025.09.24.16.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	dwindsor@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
Date: Wed, 24 Sep 2025 19:24:33 -0400
Message-ID: <20250924232434.74761-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924232434.74761-1-dwindsor@gmail.com>
References: <20250924232434.74761-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add six new BPF kfuncs that enable BPF LSM programs to safely interact
with dentry objects:

- bpf_dget(): Acquire reference on dentry
- bpf_dput(): Release reference on dentry
- bpf_dget_parent(): Get referenced parent dentry
- bpf_d_find_alias(): Find referenced alias dentry for inode
- bpf_file_dentry(): Get dentry from file
- bpf_file_vfsmount(): Get vfsmount from file

All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 1e36a12b88f7..988e408fe7b3 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -169,6 +169,104 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
+/**
+ * bpf_dget - get a reference on a dentry
+ * @dentry: dentry to get a reference on
+ *
+ * Get a reference on the supplied *dentry*. The referenced dentry pointer
+ * acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_dget(struct dentry *dentry)
+{
+	return dget(dentry);
+}
+
+/**
+ * bpf_dput - put a reference on a dentry
+ * @dentry: dentry to put a reference on
+ *
+ * Put a reference on the supplied *dentry*.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ */
+__bpf_kfunc void bpf_dput(struct dentry *dentry)
+{
+	dput(dentry);
+}
+
+/**
+ * bpf_dget_parent - get a reference on the parent dentry
+ * @dentry: dentry to get the parent of
+ *
+ * Get a reference on the parent of the supplied *dentry*. The referenced
+ * dentry pointer acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced parent dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_dget_parent(struct dentry *dentry)
+{
+	return dget_parent(dentry);
+}
+
+/**
+ * bpf_d_find_alias - find an alias dentry for an inode
+ * @inode: inode to find an alias for
+ *
+ * Find an alias dentry for the supplied *inode*. The referenced dentry pointer
+ * acquired by this BPF kfunc must be released using bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A referenced alias dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_d_find_alias(struct inode *inode)
+{
+	return d_find_alias(inode);
+}
+
+/**
+ * bpf_file_dentry - get the dentry associated with a file
+ * @file: file to get the dentry from
+ *
+ * Get the dentry associated with the supplied *file*. This is a trusted
+ * accessor that allows BPF programs to safely obtain a dentry pointer
+ * from a file structure. The returned pointer is borrowed and does not
+ * require bpf_dput().
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A dentry pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct dentry *bpf_file_dentry(struct file *file)
+{
+	return file_dentry(file);
+}
+
+/**
+ * bpf_file_vfsmount - get the vfsmount associated with a file
+ * @file: file to get the vfsmount from
+ *
+ * Get the vfsmount associated with the supplied *file*. This is a trusted
+ * accessor that allows BPF programs to safely obtain a vfsmount pointer
+ * from a file structure. The returned pointer is borrowed and does not
+ * require any release function.
+ *
+ * This BPF kfunc may only be called from BPF LSM programs.
+ *
+ * Return: A vfsmount pointer. On error, NULL is returned.
+ */
+__bpf_kfunc struct vfsmount *bpf_file_vfsmount(struct file *file)
+{
+	return file->f_path.mnt;
+}
+
+
 __bpf_kfunc_end_defs();
 
 static int bpf_xattr_write_permission(const char *name, struct inode *inode)
@@ -367,6 +465,12 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_dget, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_dput, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dget_parent, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_d_find_alias, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_file_dentry, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_file_vfsmount, KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.43.0


