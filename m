Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC72A638E06
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYQCU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 11:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiKYQCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 11:02:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63F74C246;
        Fri, 25 Nov 2022 08:02:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x5so7425309wrt.7;
        Fri, 25 Nov 2022 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKCIyGYe2B04hHRAA+9pCehsp638foIx0kXyLI5UAfQ=;
        b=NTffmuAfj2QPMOPrHbxTDZVfsJIrmH2LL9ZiWrQ//0iPQo/wrYCyt+eT1wDA+L6M+c
         gE1OHmXoFYgpODSz7+10gXr0DLUqYtN4gs+vYTMzlHe1ZtWZdpb8bUFSY0ZKBbXMOFHB
         hRLZLrmuj7UJ1K8Ey8Hkr17xR9L0SZVIB4gzE9a76j/Tuthf5JjrdsAZC++/b44vFbQw
         aVoiC6+UI01bZCktun8t1JeH8WGl7qZJ7U2WYXC0r6X3v5wl2fJBAQvhjPxdcFwyCVEy
         FZeOA9i1h2IvnLqT72m8sl49Jpc41N15W8UJ94bqicOVU/GxtPfxmdlvLoPyl8faPj0a
         G0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKCIyGYe2B04hHRAA+9pCehsp638foIx0kXyLI5UAfQ=;
        b=Ia7gaaJ7RiAse1frccbY5QBLd5VvyD2qI7OryBT6FmaDKjmaUOKjGIgz1yFgqD5PlQ
         SMamgIgljZDLXExZyEbH6PqBb04rvWU7FZFs26wHqaoxS2iKGcGDWliMp38esMPO9X9O
         gblucKAhIxfLaWTj+vwmMnvaMBeQptY2FgDovmcnugLX2NNGCMaScOt+Gzprx+q822xz
         eYqboye7RcbFrShbiMluGydEl7GHmAfbGIc6hyYuv2hdn+9s5sB5dz/UD6pImbp29EsA
         V5aPCX6L2ebsMgDlE8IjPjDOzE99Y9hM5Rs7WoL6EchuF93kXV7T+WuFR/YjiEAHF+o+
         SRcg==
X-Gm-Message-State: ANoB5pk46QNhVBXu05pTIAnyFxv61DNRikFdUXST54p6YUmYKXpo5LjG
        IN0LVHeY+BFam4ug9d+kDZI=
X-Google-Smtp-Source: AA0mqf4alMEKuBqPz8nkcT7Lg+E5iQzvCKlEuOJnILKNzFNN81kLJBQiE9KvCl6HVaSGVb8f//MynQ==
X-Received: by 2002:a5d:680f:0:b0:241:e593:443f with SMTP id w15-20020a5d680f000000b00241e593443fmr11614024wru.294.1669392133683;
        Fri, 25 Nov 2022 08:02:13 -0800 (PST)
Received: from suse.localnet (host-79-55-110-244.retail.telecomitalia.it. [79.55.110.244])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003c6b70a4d69sm5241020wmf.42.2022.11.25.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:02:07 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Fri, 25 Nov 2022 17:02:06 +0100
Message-ID: <4105108.1IzOArtZ34@suse>
In-Reply-To: <20221016164636.8696-1-fmdefrancesco@gmail.com>
References: <20221016164636.8696-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On domenica 16 ottobre 2022 18:46:36 CET Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in fs/sysv is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local=
()
> requires the mapping address, so return that address from dir_get_page()
> to be used in dir_put_page().
>=20
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> I'm resending this patch adding a review tag from Ira. No changes to the
> code. It's also a friendly ping, since first submission was on Aug 26th.
>=20
> This code is not tested. I have no means to create an SysV filesystem.
> Despite nothing here seems to break the strict rules about the use of
> kmap_local_page(), any help with testing will be much appreciated :-)
>=20
>  fs/sysv/dir.c   | 83 ++++++++++++++++++++++---------------------------
>  fs/sysv/namei.c | 26 +++++++++-------
>  fs/sysv/sysv.h  | 19 ++++++++---
>  3 files changed, 65 insertions(+), 63 deletions(-)

Cristoph, Christian,

I'm again here to gently ping and remind this patch to both of you. I have =
no=20
idea about why it didn't yet deserve any reply. Is there anything I'm still=
=20
missing?

I'm looking forward to hear from you.

Thanks,

=46abio

> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> index 88e38cd8f5c9..130350fde106 100644
> --- a/fs/sysv/dir.c
> +++ b/fs/sysv/dir.c
> @@ -28,12 +28,6 @@ const struct file_operations sysv_dir_operations =3D {
>  	.fsync		=3D generic_file_fsync,
>  };
>=20
> -static inline void dir_put_page(struct page *page)
> -{
> -	kunmap(page);
> -	put_page(page);
> -}
> -
>  static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  {
>  	struct address_space *mapping =3D page->mapping;
> @@ -52,12 +46,12 @@ static int dir_commit_chunk(struct page *page, loff_t=
=20
pos,
> unsigned len) return err;
>  }
>=20
> -static struct page * dir_get_page(struct inode *dir, unsigned long n)
> +static struct page *dir_get_page(struct inode *dir, unsigned long n, void
> **page_addr) {
>  	struct address_space *mapping =3D dir->i_mapping;
>  	struct page *page =3D read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page))
> -		kmap(page);
> +		*page_addr =3D kmap_local_page(page);
>  	return page;
>  }
>=20
> @@ -80,11 +74,10 @@ static int sysv_readdir(struct file *file, struct
> dir_context *ctx) for ( ; n < npages; n++, offset =3D 0) {
>  		char *kaddr, *limit;
>  		struct sysv_dir_entry *de;
> -		struct page *page =3D dir_get_page(inode, n);
> +		struct page *page =3D dir_get_page(inode, n, (void=20
**)&kaddr);
>=20
>  		if (IS_ERR(page))
>  			continue;
> -		kaddr =3D (char *)page_address(page);
>  		de =3D (struct sysv_dir_entry *)(kaddr+offset);
>  		limit =3D kaddr + PAGE_SIZE - SYSV_DIRSIZE;
>  		for ( ;(char*)de <=3D limit; de++, ctx->pos +=3D sizeof(*de))=20
{
> @@ -96,11 +89,11 @@ static int sysv_readdir(struct file *file, struct
> dir_context *ctx) if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
>  					fs16_to_cpu(SYSV_SB(sb), de-
>inode),
>  					DT_UNKNOWN)) {
> -				dir_put_page(page);
> +				dir_put_page(page, kaddr);
>  				return 0;
>  			}
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -124,7 +117,8 @@ static inline int namecompare(int len, int maxlen,
>   * itself (as a parameter - res_dir). It does NOT read the inode of the
>   * entry - you'll have to do that yourself if you want to.
>   */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page
> **res_page) +struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry,
> +				       struct page **res_page, void=20
**res_page_addr)
>  {
>  	const char * name =3D dentry->d_name.name;
>  	int namelen =3D dentry->d_name.len;
> @@ -133,8 +127,10 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry
> *dentry, struct page **res_ unsigned long npages =3D dir_pages(dir);
>  	struct page *page =3D NULL;
>  	struct sysv_dir_entry *de;
> +	char *kaddr;
>=20
>  	*res_page =3D NULL;
> +	*res_page_addr =3D NULL;
>=20
>  	start =3D SYSV_I(dir)->i_dir_start_lookup;
>  	if (start >=3D npages)
> @@ -142,10 +138,8 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry
> *dentry, struct page **res_ n =3D start;
>=20
>  	do {
> -		char *kaddr;
> -		page =3D dir_get_page(dir, n);
> +		page =3D dir_get_page(dir, n, (void **)&kaddr);
>  		if (!IS_ERR(page)) {
> -			kaddr =3D (char*)page_address(page);
>  			de =3D (struct sysv_dir_entry *) kaddr;
>  			kaddr +=3D PAGE_SIZE - SYSV_DIRSIZE;
>  			for ( ; (char *) de <=3D kaddr ; de++) {
> @@ -155,7 +149,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry
> *dentry, struct page **res_ name, de->name))
>  					goto found;
>  			}
> -			dir_put_page(page);
> +			dir_put_page(page, kaddr);
>  		}
>=20
>  		if (++n >=3D npages)
> @@ -167,6 +161,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry
> *dentry, struct page **res_ found:
>  	SYSV_I(dir)->i_dir_start_lookup =3D n;
>  	*res_page =3D page;
> +	*res_page_addr =3D kaddr;
>  	return de;
>  }
>=20
> @@ -176,6 +171,7 @@ int sysv_add_link(struct dentry *dentry, struct inode
> *inode) const char * name =3D dentry->d_name.name;
>  	int namelen =3D dentry->d_name.len;
>  	struct page *page =3D NULL;
> +	void *page_addr =3D NULL;
>  	struct sysv_dir_entry * de;
>  	unsigned long npages =3D dir_pages(dir);
>  	unsigned long n;
> @@ -185,11 +181,11 @@ int sysv_add_link(struct dentry *dentry, struct ino=
de
> *inode)
>=20
>  	/* We take care of directory expansion in the same loop */
>  	for (n =3D 0; n <=3D npages; n++) {
> -		page =3D dir_get_page(dir, n);
> +		page =3D dir_get_page(dir, n, &page_addr);
>  		err =3D PTR_ERR(page);
>  		if (IS_ERR(page))
>  			goto out;
> -		kaddr =3D (char*)page_address(page);
> +		kaddr =3D page_addr;
>  		de =3D (struct sysv_dir_entry *)kaddr;
>  		kaddr +=3D PAGE_SIZE - SYSV_DIRSIZE;
>  		while ((char *)de <=3D kaddr) {
> @@ -200,14 +196,13 @@ int sysv_add_link(struct dentry *dentry, struct ino=
de
> *inode) goto out_page;
>  			de++;
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, page_addr);
>  	}
>  	BUG();
>  	return -EINVAL;
>=20
>  got_it:
> -	pos =3D page_offset(page) +
> -			(char*)de - (char*)page_address(page);
> +	pos =3D page_offset(page) + (char *)de - (char *)page_addr;
>  	lock_page(page);
>  	err =3D sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
>  	if (err)
> @@ -219,7 +214,7 @@ int sysv_add_link(struct dentry *dentry, struct inode
> *inode) dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
>  	mark_inode_dirty(dir);
>  out_page:
> -	dir_put_page(page);
> +	dir_put_page(page, page_addr);
>  out:
>  	return err;
>  out_unlock:
> @@ -227,10 +222,9 @@ int sysv_add_link(struct dentry *dentry, struct inode
> *inode) goto out_page;
>  }
>=20
> -int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
> +int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page, char
> *kaddr) {
>  	struct inode *inode =3D page->mapping->host;
> -	char *kaddr =3D (char*)page_address(page);
>  	loff_t pos =3D page_offset(page) + (char *)de - kaddr;
>  	int err;
>=20
> @@ -239,7 +233,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, stru=
ct
> page *page) BUG_ON(err);
>  	de->inode =3D 0;
>  	err =3D dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir_put_page(page);
> +	dir_put_page(page, kaddr);
>  	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
>  	mark_inode_dirty(inode);
>  	return err;
> @@ -259,19 +253,15 @@ int sysv_make_empty(struct inode *inode, struct ino=
de
> *dir) unlock_page(page);
>  		goto fail;
>  	}
> -	kmap(page);
> -
> -	base =3D (char*)page_address(page);
> +	base =3D kmap_local_page(page);
>  	memset(base, 0, PAGE_SIZE);
> -
>  	de =3D (struct sysv_dir_entry *) base;
>  	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	strcpy(de->name,".");
>  	de++;
>  	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
>  	strcpy(de->name,"..");
> -
> -	kunmap(page);
> +	kunmap_local(base);
>  	err =3D dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
>  fail:
>  	put_page(page);
> @@ -286,16 +276,15 @@ int sysv_empty_dir(struct inode * inode)
>  	struct super_block *sb =3D inode->i_sb;
>  	struct page *page =3D NULL;
>  	unsigned long i, npages =3D dir_pages(inode);
> +	char *kaddr;
>=20
>  	for (i =3D 0; i < npages; i++) {
> -		char *kaddr;
>  		struct sysv_dir_entry * de;
> -		page =3D dir_get_page(inode, i);
> +		page =3D dir_get_page(inode, i, (void **)&kaddr);
>=20
>  		if (IS_ERR(page))
>  			continue;
>=20
> -		kaddr =3D (char *)page_address(page);
>  		de =3D (struct sysv_dir_entry *)kaddr;
>  		kaddr +=3D PAGE_SIZE-SYSV_DIRSIZE;
>=20
> @@ -314,22 +303,21 @@ int sysv_empty_dir(struct inode * inode)
>  			if (de->name[1] !=3D '.' || de->name[2])
>  				goto not_empty;
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, kaddr);
>  	}
>  	return 1;
>=20
>  not_empty:
> -	dir_put_page(page);
> +	dir_put_page(page, kaddr);
>  	return 0;
>  }
>=20
>  /* Releases the page */
>  void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
> -	struct inode *inode)
> +		   void *page_addr, struct inode *inode)
>  {
>  	struct inode *dir =3D page->mapping->host;
> -	loff_t pos =3D page_offset(page) +
> -			(char *)de-(char*)page_address(page);
> +	loff_t pos =3D page_offset(page) + (char *)de - (char *)page_addr;
>  	int err;
>=20
>  	lock_page(page);
> @@ -337,19 +325,21 @@ void sysv_set_link(struct sysv_dir_entry *de, struct
> page *page, BUG_ON(err);
>  	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	err =3D dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir_put_page(page);
> +	dir_put_page(page, page_addr);
>  	dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>=20
> -struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
> +struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p, v=
oid
> **pa) {
> -	struct page *page =3D dir_get_page(dir, 0);
> +	void *page_addr;
> +	struct page *page =3D dir_get_page(dir, 0, &page_addr);
>  	struct sysv_dir_entry *de =3D NULL;
>=20
>  	if (!IS_ERR(page)) {
> -		de =3D (struct sysv_dir_entry*) page_address(page) + 1;
> +		de =3D (struct sysv_dir_entry *)page_addr + 1;
>  		*p =3D page;
> +		*pa =3D page_addr;
>  	}
>  	return de;
>  }
> @@ -357,12 +347,13 @@ struct sysv_dir_entry * sysv_dotdot (struct inode=20
*dir,
> struct page **p) ino_t sysv_inode_by_name(struct dentry *dentry)
>  {
>  	struct page *page;
> -	struct sysv_dir_entry *de =3D sysv_find_entry (dentry, &page);
> +	void *page_addr;
> +	struct sysv_dir_entry *de =3D sysv_find_entry(dentry, &page,=20
&page_addr);
>  	ino_t res =3D 0;
>=20
>  	if (de) {
>  		res =3D fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
> -		dir_put_page(page);
> +		dir_put_page(page, page_addr);
>  	}
>  	return res;
>  }
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> index b2e6abc06a2d..1371980ec5fb 100644
> --- a/fs/sysv/namei.c
> +++ b/fs/sysv/namei.c
> @@ -152,14 +152,15 @@ static int sysv_unlink(struct inode * dir, struct=20
dentry
> * dentry) {
>  	struct inode * inode =3D d_inode(dentry);
>  	struct page * page;
> +	void *page_addr;
>  	struct sysv_dir_entry * de;
>  	int err =3D -ENOENT;
>=20
> -	de =3D sysv_find_entry(dentry, &page);
> +	de =3D sysv_find_entry(dentry, &page, &page_addr);
>  	if (!de)
>  		goto out;
>=20
> -	err =3D sysv_delete_entry (de, page);
> +	err =3D sysv_delete_entry(de, page, page_addr);
>  	if (err)
>  		goto out;
>=20
> @@ -196,26 +197,29 @@ static int sysv_rename(struct user_namespace
> *mnt_userns, struct inode *old_dir, struct inode * old_inode =3D
> d_inode(old_dentry);
>  	struct inode * new_inode =3D d_inode(new_dentry);
>  	struct page * dir_page =3D NULL;
> +	void *dir_page_addr;
>  	struct sysv_dir_entry * dir_de =3D NULL;
>  	struct page * old_page;
> +	void *old_page_addr;
>  	struct sysv_dir_entry * old_de;
>  	int err =3D -ENOENT;
>=20
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
>=20
> -	old_de =3D sysv_find_entry(old_dentry, &old_page);
> +	old_de =3D sysv_find_entry(old_dentry, &old_page, &old_page_addr);
>  	if (!old_de)
>  		goto out;
>=20
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		err =3D -EIO;
> -		dir_de =3D sysv_dotdot(old_inode, &dir_page);
> +		dir_de =3D sysv_dotdot(old_inode, &dir_page,=20
&dir_page_addr);
>  		if (!dir_de)
>  			goto out_old;
>  	}
>=20
>  	if (new_inode) {
> +		void *new_page_addr;
>  		struct page * new_page;
>  		struct sysv_dir_entry * new_de;
>=20
> @@ -224,10 +228,10 @@ static int sysv_rename(struct user_namespace
> *mnt_userns, struct inode *old_dir, goto out_dir;
>=20
>  		err =3D -ENOENT;
> -		new_de =3D sysv_find_entry(new_dentry, &new_page);
> +		new_de =3D sysv_find_entry(new_dentry, &new_page,=20
&new_page_addr);
>  		if (!new_de)
>  			goto out_dir;
> -		sysv_set_link(new_de, new_page, old_inode);
> +		sysv_set_link(new_de, new_page, new_page_addr, old_inode);
>  		new_inode->i_ctime =3D current_time(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
> @@ -240,23 +244,21 @@ static int sysv_rename(struct user_namespace
> *mnt_userns, struct inode *old_dir, inode_inc_link_count(new_dir);
>  	}
>=20
> -	sysv_delete_entry(old_de, old_page);
> +	sysv_delete_entry(old_de, old_page, old_page_addr);
>  	mark_inode_dirty(old_inode);
>=20
>  	if (dir_de) {
> -		sysv_set_link(dir_de, dir_page, new_dir);
> +		sysv_set_link(dir_de, dir_page, dir_page_addr, new_dir);
>  		inode_dec_link_count(old_dir);
>  	}
>  	return 0;
>=20
>  out_dir:
>  	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> +		dir_put_page(dir_page, dir_page_addr);
>  	}
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	dir_put_page(old_page, old_page_addr);
>  out:
>  	return err;
>  }
> diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
> index 99ddf033da4f..b0631ea6b506 100644
> --- a/fs/sysv/sysv.h
> +++ b/fs/sysv/sysv.h
> @@ -119,6 +119,11 @@ static inline void dirty_sb(struct super_block *sb)
>  		mark_buffer_dirty(sbi->s_bh2);
>  }
>=20
> +static inline void dir_put_page(struct page *page, void *page_addr)
> +{
> +	kunmap_local(page_addr);
> +	put_page(page);
> +}
>=20
>  /* ialloc.c */
>  extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
> @@ -148,14 +153,18 @@ extern void sysv_destroy_icache(void);
>=20
>=20
>  /* dir.c */
> -extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct pa=
ge
> **); +extern struct sysv_dir_entry *sysv_find_entry(struct dentry *dir,
> +					      struct page=20
**res_page,
> +					      void **res_page_addr);
>  extern int sysv_add_link(struct dentry *, struct inode *);
> -extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
> +extern int sysv_delete_entry(struct sysv_dir_entry *dir, struct page *pa=
ge,
> +			     char *kaddr);
>  extern int sysv_make_empty(struct inode *, struct inode *);
>  extern int sysv_empty_dir(struct inode *);
> -extern void sysv_set_link(struct sysv_dir_entry *, struct page *,
> -			struct inode *);
> -extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **=
);
> +extern void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
> +			  void *page_addr, struct inode *inode);
> +extern struct sysv_dir_entry *sysv_dotdot(struct inode *inode,
> +					  struct page **page, void=20
**page_addr);
>  extern ino_t sysv_inode_by_name(struct dentry *);
>=20
>=20
> --
> 2.37.2




