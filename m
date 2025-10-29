Return-Path: <bpf+bounces-72821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB664C1BCF7
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DC86649D9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C73358AE;
	Wed, 29 Oct 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPXLDd17"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCF330303
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750433; cv=none; b=YDccqNHOraY78X33gZeKqasXcMnwUiAxK/xdvGoPDmGPOAPrJ0kHNWGxp/2QhcMcbGpdK08c62xjd9xFoZoAlAgxDtdKGBYFW3mFE7YmdbYQdwOOVUqAXirdR6yLbhcHDDuWf2nM3FQnm9cbeIu3PTuOkxBocn45KugmCdfyzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750433; c=relaxed/simple;
	bh=f8Fhr45tAG7sziLg9U37nK1+JBvIXcz4AelF+jGe5oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsGm7j2CgvIPppU+wqMNSB3FiF3QqN/4r8JgLmRcmJKxpZrPCYuU/mIiuih6VrwVeISn+MhUkWFTRdWTxx7SIMt8JG5Hqj0nMXBZf/A71S4BBZIt3BmUc13cLSck2JEp3bfJAKqtraESkBr5xuhJfVhjoVGjXN1zXVe/ZIAS620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPXLDd17; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so12643a91.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750431; x=1762355231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=jPXLDd173Mmm/1ZA8/62Litwf1jppoXunEBdw455/oB0ucPgz/zgb5S9Ig21/R9A83
         zDl/M5gysr9P+fkQwOLRn8Nc93ZomVRC0bmPuHLPjeGepoBI06SWq1YE484MytHwSLlb
         4dwkHgWXlShtqjfBEVZS0uTM5g1kp4llTyzLktE6VRZ+86UnW8Fk08ywhJzo+o670TEd
         fBtgMsa0FYuUeroCTBX6EiOYZ8iHQnELdjSyCiUzabXF6mX8GH0xfMj1C18t6ZPdfKAf
         Y7WcPyRl4QKv5WXCIattR6fCUu2UoNrxf2YFU7G6nQc1uSb0v9TebfZWQzUa9NtSTICl
         hxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750431; x=1762355231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IfYIDKxJGGNldyfSmZN9xBlg4Ge86/H8w7OAL6l3zA=;
        b=M6J8Qq2zDXsgJKtXn532wHkWP7cDB4nUkZA/3lcEyxe1iYqH2fwPFE0pWq2nV0DYL5
         bxlcjOizfItIXokCKIubJgL0uDxFQOKJHxCEyEwva8oiiFDZ8TdkAUVJLDP1pCOuFXup
         2zIg2SDdmkFimkHLdtKdETvTvLhI+P3Uu8pMuRxi1l0L9nNhE7GbFD+7xTjic9QuU/6D
         nJ0zkviCTHJwNECPlItA5tUMMMc61/4YHNXdB+ZSo34T8ePzi38/l5nc+zBNc74wLfsm
         9FxjT/NgOH8WqNQ8ODV96rjQ5gmnpnxxHeGHByRCrLhIwER9rLAByRIYn14ZpWISV4Tq
         2JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMFfnQrEHa0jlbV4U4pD0baFTMBWfCRQk7q+wwMxIzgc6/0HZh/BoLJh0uLHgmczxGys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sblD9T33KyQMgrrhUN44EuYvW3He7bmsE8DP9/9S8ZkQc6X3
	C0F7uvd64UiAOU2QyhqcG3/I83LtK7FebVuIkcg1MI5WdMdYC2nTzJ6l4yt16K2wAfRO2/cHVzW
	YSGpDTPV9RF3BXqWm0oAFAyTLhJBHfnI=
X-Gm-Gg: ASbGncsKOHb0cqgKBICYH9n0f9Hfdh3dblckX1U9P9D8Tr8YDUFDta19PfvK1BQ+NYj
	I2fWLKgxH8rzG6zUShRTZ7YHg3syzKbAN9kVneo38lOKQcOt1RV+9PryCbMqSwqR9azBd3tGzBn
	GaJcxcnJGuBLET/wJuQMzrYnsx0i7nMokAq6sMeM+bf6HbH1PK4/F29yOoI47o+M4fXl8+s7BAR
	WGM5yOmjqq0MTXEk3DaDbEZg6B3KNB65CerXT9kzDVCNDgJiLGRZq90b7EWs4D70kNynds=
X-Google-Smtp-Source: AGHT+IFVqO8ewpIAf0wvRQFGIOOwuq6fD8Gg5dHkMSFcg7AR9XFXs/odOiaOENp+NesUqtIMC2BHNrgVUxHGzL0/CTY=
X-Received: by 2002:a17:90b:134b:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-3403a28efb0mr3676582a91.27.1761750430698; Wed, 29 Oct 2025
 08:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-36-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-36-viro@zeniv.linux.org.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Oct 2025 11:06:58 -0400
X-Gm-Features: AWmQ_blCWCRSlgnSUoNEZRYW0rUX4EVkF7hJCMWu9E3EunP63rWoSyVWbO7_enY
Message-ID: <CAEjxPJ53wJEK4bzt0VMbY=G9gkzuZZA_XtrT+acwPys3p0byBA@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
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

On Tue, Oct 28, 2025 at 2:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Tree has invariant part + two subtrees that get replaced upon each
> policy load.  Invariant parts stay for the lifetime of filesystem,
> these two subdirs - from policy load to policy load (serialized
> on lock_rename(root, ...)).
>
> All object creations are via d_alloc_name()+d_add() inside selinuxfs,
> all removals are via simple_recursive_removal().
>
> Turn those d_add() into d_make_persistent()+dput() and that's mostly it.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I took this series for a spin and didn't see any problems with the
selinux-testsuite.
Also re-based my WIP selinux namespaces patch series [1] on top, which
introduces multiple selinuxfs instances (one per selinux namespace),
and didn't see any problems.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

[1] https://lore.kernel.org/selinux/20250814132637.1659-1-stephen.smalley.w=
ork@gmail.com/

> ---
>  security/selinux/selinuxfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f088776dbbd3..eae565358db4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1205,7 +1205,8 @@ static struct dentry *sel_attach(struct dentry *par=
ent, const char *name,
>                 iput(inode);
>                 return ERR_PTR(-ENOMEM);
>         }
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
> +       dput(dentry);
>         return dentry;
>  }
>
> @@ -1934,10 +1935,11 @@ static struct dentry *sel_make_swapover_dir(struc=
t super_block *sb,
>         /* directory inodes start off with i_nlink =3D=3D 2 (for "." entr=
y) */
>         inc_nlink(inode);
>         inode_lock(sb->s_root->d_inode);
> -       d_add(dentry, inode);
> +       d_make_persistent(dentry, inode);
>         inc_nlink(sb->s_root->d_inode);
>         inode_unlock(sb->s_root->d_inode);
> -       return dentry;
> +       dput(dentry);
> +       return dentry;  // borrowed
>  }
>
>  #define NULL_FILE_NAME "null"
> @@ -2080,7 +2082,7 @@ static int sel_init_fs_context(struct fs_context *f=
c)
>  static void sel_kill_sb(struct super_block *sb)
>  {
>         selinux_fs_info_free(sb);
> -       kill_litter_super(sb);
> +       kill_anon_super(sb);
>  }
>
>  static struct file_system_type sel_fs_type =3D {
> --
> 2.47.3
>
>

