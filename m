Return-Path: <bpf+bounces-72823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39277C1B9DD
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3BC4349FAD
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7E320A0F;
	Wed, 29 Oct 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFhgaMIj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE76301485
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751353; cv=none; b=PNW9ZyGHfqNRxcZn9A9AykHflueTYiHzUL5cRbPhB7Yn2HIK5jE7f+ZmeEA86ShYabPFDsJ7Y6e+HfsfimYhQnk+appS2KZ+90mBt9+0cgnfdztzKT/vyqKl2iDy+Pr/rvgcQ6EckNY8aIhSjmB2rDaptkXksGfEDn2+OWyEvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751353; c=relaxed/simple;
	bh=nJ/T6RNOXP8zlvuyaqoHWAnoI6NRt39753V1I7zGdLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc+cGFt8SWRVe+veFVzKyQ1s/ARf9bvciszs0DDnOfO2YS6Tf0Om/M/Ev03l1K8DSlk8kmNLvvQwwAVCKQgz46U0jLNGDZOzm4pMlMzDUqkAEErgv6xz5BVKNERtClsrGUtsEHjpUUCWtQ/ld75JhW9rV1KcSNaQrRj59EA1TJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFhgaMIj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso28835a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761751350; x=1762356150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uEf7AWHW2EFfq5FisNeu+6YzxFXhNgGD2IsXcF2IXA=;
        b=PFhgaMIjNmp1GKvVVwSXU1NCvv3hWzh0zMrkjUAcgUPviaShoDBQuBMbpTUYEgiD1R
         IEzx3K6xxEoZEphnc2HJDFyXWc+FVHvfO51V6xfMn4LX6tcx8+QxjixEfZtpu2APO6AT
         cYQTPOo/dHlBARzFGdbmqg8HNZA6O1FHlTqfknFGLSG45h0hCuY7nVVYS4uF6gkxaPEt
         oxXDd7C9EEa2/Sid7r9HZ3rqMFJEWWmiVasdYKsD4t2zXLVXA0LzPPL3/CYPQhqx45aB
         olhS6z4/3Gt/NtaXrfvxkEXAICJWEQtB6Mgxcy7JEgv5QoWarUTjItjXdOL80o14ZrJg
         xdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751350; x=1762356150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uEf7AWHW2EFfq5FisNeu+6YzxFXhNgGD2IsXcF2IXA=;
        b=jMwK64douWn7JedZHR4Fzfv9AQBjGJxFor5+QHiWGWnu373MzTghgC5Y3gZf3/y8PP
         y/cliPS1bNsUecM+y8o0m5UiArTFrhnZRuB2TGfiQ2ZU7QFU346ikdEAUau8VCSrLgD2
         lUW/RBsCSaerUJOhXPN/+PE2G6+47S1HqutJhxHnDMvAHh0MpjJ+MDj5ibFbOq63OGYI
         kAY/5xOJ7c+WQF8MHg9hDyzwaEnLV9CZUajs9aeuF/Lfd7shTDp4OfVHOva/r9wbC88j
         10T0lvXh1ZYFo9aRX6LJayZNUKIOko/vqkMzBJrBOf9HOy0r9a1kpWcpww0gXEYUCCn4
         8yUw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Wa1Wh2sRlydUe9smGToUm+7xuYcavSsJJMGdoZvnmEPnbVpqoQWDHBJCywkKwvWjjr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIpyVU1m97NUgeFf0QSDKV8b3a7W4opKCTAs+V5XohtIT+nfn
	p1BT6xgV6hyRKl5FU0duoCMnQgA2Z0EVQMX6dr5GOww2q+JXqR4X/Q89UuhGa6SmVqD6XNSLBqF
	KASXWmTZX5ntng/s7r7rcHm6Pghg8vUo=
X-Gm-Gg: ASbGncvfJvqGO2AN+TQr3MsNzXVYCb6yTWTnYTEkyNBv+KOLKyNkes2BVow/waeipVE
	XmCUMRcO1l5mvc06c+xb9eYS0YC/Ye4JtTl7Z6tnLsEzPAofFiFq3mSKm9SarQG6JEqHuU3b8hF
	rZqvg/PYGXBVaWqz4vYUvy5nm/n3hleZaXH5lVvQjzgMPTVL38KxoEy8wZ4/dbNCbxr+bt3qq6h
	YP5eXBuK7QjO3YI/3zF+IYOhC+lQZvRPwm33QPr5lTxpgei+SdIkXqvDLg2azWmAl5o8Og=
X-Google-Smtp-Source: AGHT+IHauJsAd7JkZgiXBb1QwsQmdX1F9k4bjlfRe5Ruq2nxIy/MOGpvFoFrg1ywX5/XWt4Wu3tgzcE+Da4joovTwjA=
X-Received: by 2002:a17:90b:3ec4:b0:33b:b020:5968 with SMTP id
 98e67ed59e1d1-3403a2a2304mr4383659a91.21.1761751349618; Wed, 29 Oct 2025
 08:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-35-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-35-viro@zeniv.linux.org.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Oct 2025 11:22:18 -0400
X-Gm-Features: AWmQ_bmyeQMYjDS06AWxBfYb9-0R5GZ19KU4TCXUFH7N6Zg4orJWZ7Jju9hX1JU
Message-ID: <CAEjxPJ6nF1fooxn4XaW1_OcAT46Uh+p4dD5-+uKjWv3EbfvoOg@mail.gmail.com>
Subject: Re: [PATCH v2 34/50] selinuxfs: new helper for attaching files to tree
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:56=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> allocating dentry after the inode has been set up reduces the amount
> of boilerplate - "attach this inode under that name and this parent
> or drop inode in case of failure" simplifies quite a few places.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/selinuxfs.c | 160 +++++++++++++++--------------------
>  1 file changed, 66 insertions(+), 94 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index b39e919c27b1..f088776dbbd3 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1197,6 +1197,25 @@ static struct inode *sel_make_inode(struct super_b=
lock *sb, umode_t mode)
>         return ret;
>  }
>
> +static struct dentry *sel_attach(struct dentry *parent, const char *name=
,
> +                                struct inode *inode)
> +{
> +       struct dentry *dentry =3D d_alloc_name(parent, name);
> +       if (unlikely(!dentry)) {
> +               iput(inode);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       d_add(dentry, inode);
> +       return dentry;
> +}
> +
> +static int sel_attach_file(struct dentry *parent, const char *name,
> +                          struct inode *inode)
> +{
> +       struct dentry *dentry =3D sel_attach(parent, name, inode);
> +       return PTR_ERR_OR_ZERO(dentry);
> +}
> +
>  static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>                              size_t count, loff_t *ppos)
>  {
> @@ -1356,8 +1375,7 @@ static int sel_make_bools(struct selinux_policy *ne=
wpolicy, struct dentry *bool_
>         *bool_num =3D num;
>         *bool_pending_names =3D names;
>
> -       for (i =3D 0; i < num; i++) {
> -               struct dentry *dentry;
> +       for (i =3D 0; !ret && i < num; i++) {
>                 struct inode *inode;
>                 struct inode_security_struct *isec;
>                 ssize_t len;
> @@ -1368,15 +1386,9 @@ static int sel_make_bools(struct selinux_policy *n=
ewpolicy, struct dentry *bool_
>                         ret =3D -ENAMETOOLONG;
>                         break;
>                 }
> -               dentry =3D d_alloc_name(bool_dir, names[i]);
> -               if (!dentry) {
> -                       ret =3D -ENOMEM;
> -                       break;
> -               }
>
>                 inode =3D sel_make_inode(bool_dir->d_sb, S_IFREG | S_IRUG=
O | S_IWUSR);
>                 if (!inode) {
> -                       dput(dentry);
>                         ret =3D -ENOMEM;
>                         break;
>                 }
> @@ -1394,7 +1406,8 @@ static int sel_make_bools(struct selinux_policy *ne=
wpolicy, struct dentry *bool_
>                 isec->initialized =3D LABEL_INITIALIZED;
>                 inode->i_fop =3D &sel_bool_ops;
>                 inode->i_ino =3D i|SEL_BOOL_INO_OFFSET;
> -               d_add(dentry, inode);
> +
> +               ret =3D sel_attach_file(bool_dir, names[i], inode);
>         }
>  out:
>         free_page((unsigned long)page);
> @@ -1579,6 +1592,7 @@ static int sel_make_avc_files(struct dentry *dir)
>         struct super_block *sb =3D dir->d_sb;
>         struct selinux_fs_info *fsi =3D sb->s_fs_info;
>         unsigned int i;
> +       int err =3D 0;
>         static const struct tree_descr files[] =3D {
>                 { "cache_threshold",
>                   &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
> @@ -1588,26 +1602,20 @@ static int sel_make_avc_files(struct dentry *dir)
>  #endif
>         };
>
> -       for (i =3D 0; i < ARRAY_SIZE(files); i++) {
> +       for (i =3D 0; !err && i < ARRAY_SIZE(files); i++) {
>                 struct inode *inode;
> -               struct dentry *dentry;
> -
> -               dentry =3D d_alloc_name(dir, files[i].name);
> -               if (!dentry)
> -                       return -ENOMEM;
>
>                 inode =3D sel_make_inode(dir->d_sb, S_IFREG|files[i].mode=
);
> -               if (!inode) {
> -                       dput(dentry);
> +               if (!inode)
>                         return -ENOMEM;
> -               }
>
>                 inode->i_fop =3D files[i].ops;
>                 inode->i_ino =3D ++fsi->last_ino;
> -               d_add(dentry, inode);
> +
> +               err =3D sel_attach_file(dir, files[i].name, inode);
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static int sel_make_ss_files(struct dentry *dir)
> @@ -1615,30 +1623,25 @@ static int sel_make_ss_files(struct dentry *dir)
>         struct super_block *sb =3D dir->d_sb;
>         struct selinux_fs_info *fsi =3D sb->s_fs_info;
>         unsigned int i;
> +       int err =3D 0;
>         static const struct tree_descr files[] =3D {
>                 { "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUG=
O },
>         };
>
> -       for (i =3D 0; i < ARRAY_SIZE(files); i++) {
> +       for (i =3D 0; !err && i < ARRAY_SIZE(files); i++) {
>                 struct inode *inode;
> -               struct dentry *dentry;
> -
> -               dentry =3D d_alloc_name(dir, files[i].name);
> -               if (!dentry)
> -                       return -ENOMEM;
>
>                 inode =3D sel_make_inode(dir->d_sb, S_IFREG|files[i].mode=
);
> -               if (!inode) {
> -                       dput(dentry);
> +               if (!inode)
>                         return -ENOMEM;
> -               }
>
>                 inode->i_fop =3D files[i].ops;
>                 inode->i_ino =3D ++fsi->last_ino;
> -               d_add(dentry, inode);
> +
> +               err =3D sel_attach_file(dir, files[i].name, inode);
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static ssize_t sel_read_initcon(struct file *file, char __user *buf,
> @@ -1666,30 +1669,25 @@ static const struct file_operations sel_initcon_o=
ps =3D {
>  static int sel_make_initcon_files(struct dentry *dir)
>  {
>         unsigned int i;
> +       int err =3D 0;
>
> -       for (i =3D 1; i <=3D SECINITSID_NUM; i++) {
> -               struct inode *inode;
> -               struct dentry *dentry;
> +       for (i =3D 1; !err && i <=3D SECINITSID_NUM; i++) {
>                 const char *s =3D security_get_initial_sid_context(i);
> +               struct inode *inode;
>
>                 if (!s)
>                         continue;
> -               dentry =3D d_alloc_name(dir, s);
> -               if (!dentry)
> -                       return -ENOMEM;
>
>                 inode =3D sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -               if (!inode) {
> -                       dput(dentry);
> +               if (!inode)
>                         return -ENOMEM;
> -               }
>
>                 inode->i_fop =3D &sel_initcon_ops;
>                 inode->i_ino =3D i|SEL_INITCON_INO_OFFSET;
> -               d_add(dentry, inode);
> +               err =3D sel_attach_file(dir, s, inode);
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static inline unsigned long sel_class_to_ino(u16 class)
> @@ -1771,29 +1769,21 @@ static int sel_make_perm_files(struct selinux_pol=
icy *newpolicy,
>         if (rc)
>                 return rc;
>
> -       for (i =3D 0; i < nperms; i++) {
> +       for (i =3D 0; !rc && i < nperms; i++) {
>                 struct inode *inode;
> -               struct dentry *dentry;
>
> -               rc =3D -ENOMEM;
> -               dentry =3D d_alloc_name(dir, perms[i]);
> -               if (!dentry)
> -                       goto out;
> -
> -               rc =3D -ENOMEM;
>                 inode =3D sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
>                 if (!inode) {
> -                       dput(dentry);
> -                       goto out;
> +                       rc =3D -ENOMEM;
> +                       break;
>                 }
>
>                 inode->i_fop =3D &sel_perm_ops;
>                 /* i+1 since perm values are 1-indexed */
>                 inode->i_ino =3D sel_perm_to_ino(classvalue, i + 1);
> -               d_add(dentry, inode);
> +
> +               rc =3D sel_attach_file(dir, perms[i], inode);
>         }
> -       rc =3D 0;
> -out:
>         for (i =3D 0; i < nperms; i++)
>                 kfree(perms[i]);
>         kfree(perms);
> @@ -1808,20 +1798,18 @@ static int sel_make_class_dir_entries(struct seli=
nux_policy *newpolicy,
>         struct selinux_fs_info *fsi =3D sb->s_fs_info;
>         struct dentry *dentry =3D NULL;
>         struct inode *inode =3D NULL;
> -
> -       dentry =3D d_alloc_name(dir, "index");
> -       if (!dentry)
> -               return -ENOMEM;
> +       int err;
>
>         inode =3D sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> -       if (!inode) {
> -               dput(dentry);
> +       if (!inode)
>                 return -ENOMEM;
> -       }
>
>         inode->i_fop =3D &sel_class_ops;
>         inode->i_ino =3D sel_class_to_ino(index);
> -       d_add(dentry, inode);
> +
> +       err =3D sel_attach_file(dir, "index", inode);
> +       if (err)
> +               return err;
>
>         dentry =3D sel_make_dir(dir, "perms", &fsi->last_class_ino);
>         if (IS_ERR(dentry))
> @@ -1873,58 +1861,47 @@ static int sel_make_policycap(struct dentry *dir)
>  {
>         struct super_block *sb =3D dir->d_sb;
>         unsigned int iter;
> -       struct dentry *dentry =3D NULL;
>         struct inode *inode =3D NULL;
> +       int err =3D 0;
> +
> +       for (iter =3D 0; !err && iter <=3D POLICYDB_CAP_MAX; iter++) {
> +               const char *name;
>
> -       for (iter =3D 0; iter <=3D POLICYDB_CAP_MAX; iter++) {
>                 if (iter < ARRAY_SIZE(selinux_policycap_names))
> -                       dentry =3D d_alloc_name(dir,
> -                                             selinux_policycap_names[ite=
r]);
> +                       name =3D selinux_policycap_names[iter];
>                 else
> -                       dentry =3D d_alloc_name(dir, "unknown");
> -
> -               if (dentry =3D=3D NULL)
> -                       return -ENOMEM;
> +                       name =3D "unknown";
>
>                 inode =3D sel_make_inode(sb, S_IFREG | 0444);
> -               if (inode =3D=3D NULL) {
> -                       dput(dentry);
> +               if (!inode)
>                         return -ENOMEM;
> -               }
>
>                 inode->i_fop =3D &sel_policycap_ops;
>                 inode->i_ino =3D iter | SEL_POLICYCAP_INO_OFFSET;
> -               d_add(dentry, inode);
> +               err =3D sel_attach_file(dir, name, inode);
>         }
>
> -       return 0;
> +       return err;
>  }
>
>  static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>                         unsigned long *ino)
>  {
> -       struct dentry *dentry =3D d_alloc_name(dir, name);
>         struct inode *inode;
>
> -       if (!dentry)
> -               return ERR_PTR(-ENOMEM);
> -
>         inode =3D sel_make_inode(dir->d_sb, S_IFDIR | S_IRUGO | S_IXUGO);
> -       if (!inode) {
> -               dput(dentry);
> +       if (!inode)
>                 return ERR_PTR(-ENOMEM);
> -       }
>
>         inode->i_op =3D &simple_dir_inode_operations;
>         inode->i_fop =3D &simple_dir_operations;
>         inode->i_ino =3D ++(*ino);
>         /* directory inodes start off with i_nlink =3D=3D 2 (for "." entr=
y) */
>         inc_nlink(inode);
> -       d_add(dentry, inode);
>         /* bump link count on parent directory, too */
>         inc_nlink(d_inode(dir));
>
> -       return dentry;
> +       return sel_attach(dir, name, inode);
>  }
>
>  static int reject_all(struct mnt_idmap *idmap, struct inode *inode, int =
mask)
> @@ -2012,17 +1989,10 @@ static int sel_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>                 goto err;
>         }
>
> -       ret =3D -ENOMEM;
> -       dentry =3D d_alloc_name(sb->s_root, NULL_FILE_NAME);
> -       if (!dentry)
> -               goto err;
> -
>         ret =3D -ENOMEM;
>         inode =3D sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
> -       if (!inode) {
> -               dput(dentry);
> +       if (!inode)
>                 goto err;
> -       }
>
>         inode->i_ino =3D ++fsi->last_ino;
>         isec =3D selinux_inode(inode);
> @@ -2031,7 +2001,9 @@ static int sel_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         isec->initialized =3D LABEL_INITIALIZED;
>
>         init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_=
MAJOR, 3));
> -       d_add(dentry, inode);
> +       ret =3D sel_attach_file(sb->s_root, NULL_FILE_NAME, inode);
> +       if (ret)
> +               goto err;
>
>         dentry =3D sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
>         if (IS_ERR(dentry)) {
> --
> 2.47.3
>
>

