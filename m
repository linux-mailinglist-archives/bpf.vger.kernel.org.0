Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A8638E2E
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKYQUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKYQUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 11:20:17 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD54B747;
        Fri, 25 Nov 2022 08:20:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t10so5741634ljj.0;
        Fri, 25 Nov 2022 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUxQi1ob9KmrmATMFpidaP/LyuseRthUstJuGmZg86k=;
        b=RKBf6M4I/QtN3TS9NEO2gUhIockJKbdKi8/9ELyEBtNyXrbfvSmhNm6QpBuLq/3E1J
         1kYI4FlY6WBTb3VYK8TEqQ3tzB7CKdPhTypyrqv/vRkS8uwVg3uqUd50Hrpve8yYXtMJ
         p4jnU4j0nv59/Vbis2454swOAE6qtxYAHc3MEPmS/CdUffAs9cfNfDof6KCskL3AqafC
         OjF97qn0c9LeY9XcpPR8te8Es9IpIi3YW68J62Io/IZW/19W6KO9K2kULsgsT9QJQ+NW
         JuDTCP38kdtuxwGYa4JSdbTRHiRYcXmg/HTL/w7jFlBsSORe+9KnMeibIdBrJjDKMBFs
         zKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUxQi1ob9KmrmATMFpidaP/LyuseRthUstJuGmZg86k=;
        b=WhZtMQutM58zVQ8YWnHFziJ1x4SFAz8O51pRJZnyFUROZs3GZCv6iprNYeSMaQwfDd
         55Yxm7ihOpQqsuhkIt+T6Kjz6HAlOTY8t5DkAQkw6MWtEOqcnUV6Y2uExyz9WLUFz2ZH
         yfqh44Gho1OtjeB4UKlDAt3ryu1Ol32kQ7PKp5groOFgj/uV23zoLWnmqLSzI6lXln8+
         xY/AcvAyUmm69Hk8gsVDQaJ1ISbqy5p6yCsZ32g7myS8CcBqvlZh66+IpHUjhmUaq0hp
         l6W5QMDUc7NmoxhH5yF578SEnu/IJJeO7pMayA/EHccY9mu1LOVGIXE/3m2FgSHQ2PDa
         0gkQ==
X-Gm-Message-State: ANoB5pl+EinNqc6AHdQW6qx0ISltTdxUVWLZqgjz1PR+JlIhu8LnXT9S
        8KYFSsqmc+aLSfisVfFpjQsk6HLyVQVdk6QX6Wo=
X-Google-Smtp-Source: AA0mqf5QC4/wLZL+DwNkEGr2gxSxHXO7VzTWOeIw/+KdUoHCVTnXr2/0b908X2im7q9jkutYOPoPSARXGeZFV8egBVk=
X-Received: by 2002:a2e:7306:0:b0:279:9104:d60c with SMTP id
 o6-20020a2e7306000000b002799104d60cmr1443224ljc.163.1669393213347; Fri, 25
 Nov 2022 08:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20221016163855.8173-1-fmdefrancesco@gmail.com>
In-Reply-To: <20221016163855.8173-1-fmdefrancesco@gmail.com>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Fri, 25 Nov 2022 17:19:56 +0100
Message-ID: <CAPj211vpoVt4si6Mi3kvrF4SW3NqfLJkQQm09NXz0BRHMWKTCQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On domenica 16 ottobre 2022 18:38:55 CET Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>
> Since its use in fs/ufs is safe everywhere, it should be preferred.
>
> Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local(=
)
> requires the mapping address, so return that address from ufs_get_page()
> to be used in ufs_put_page(). Where suited, use the standard helper
> memzero_page() instead of open coding kmap_local_page() plus memset().
>
> These changes are essentially ported from fs/ext2 and are largely based o=
n
> commit 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()").
>
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> This code is not tested. I have no means to create an UFS filesystem.
> Despite nothing here seems to break the strict rules about the use of
> kmap_local_page(), any help with testing will be much appreciated :-)
>
> v3 -> v4: Convert another kmap() which was overlooked. Since the code
>         changed, remove the "Reviewed-by" tag from Ira.
>
> v2 -> v3: Rename a variable for consistency (Ira Weiny). Add a
>         "Reviewed-by" tag.
>
> v1 -> v2: Correct some style's issues reported by checkpatch.pl.
>           Remove an "inline" compiler directive from fs/ufs/ufs.h,
>           Reported-by: kernel test robot <lkp@intel.com>
>
>  fs/ufs/dir.c   | 116 +++++++++++++++++++++++++++++++------------------
>  fs/ufs/namei.c |  38 ++++++++--------
>  fs/ufs/ufs.h   |  12 +++--
>  3 files changed, 102 insertions(+), 64 deletions(-)

Evgeniy, Christian,

I'm again here to gently ping and remind this patch to both of you. I have =
no
idea about why it didn't yet deserve any reply. Is there anything I'm still
missing?

I'm looking forward to hear from you.

Thanks,

Fabio


> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 391efaf1d528..db7564852391 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -61,9 +61,9 @@ static int ufs_commit_chunk(struct page *page, loff_t p=
os,
> unsigned len) return err;
>  }
>
> -static inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -     kunmap(page);
> +     kunmap_local(page_addr);
>       put_page(page);
>  }
>
> @@ -72,11 +72,12 @@ ino_t ufs_inode_by_name(struct inode *dir, const stru=
ct
> qstr *qstr) ino_t res =3D 0;
>       struct ufs_dir_entry *de;
>       struct page *page;
> -
> -     de =3D ufs_find_entry(dir, qstr, &page);
> +     void *page_addr;
> +
> +     de =3D ufs_find_entry(dir, qstr, &page, &page_addr);
>       if (de) {
>               res =3D fs32_to_cpu(dir->i_sb, de->d_ino);
> -             ufs_put_page(page);
> +             ufs_put_page(page, page_addr);
>       }
>       return res;
>  }
> @@ -84,11 +85,11 @@ ino_t ufs_inode_by_name(struct inode *dir, const stru=
ct
> qstr *qstr)
>
>  /* Releases the page */
>  void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
> -               struct page *page, struct inode *inode,
> -               bool update_times)
> +               struct page *page, void *page_addr,
> +               struct inode *inode, bool update_times)
>  {
>       loff_t pos =3D page_offset(page) +
> -                     (char *) de - (char *) page_address(page);
> +                     (char *)de - (char *)page_addr;
>       unsigned len =3D fs16_to_cpu(dir->i_sb, de->d_reclen);
>       int err;
>
> @@ -100,18 +101,17 @@ void ufs_set_link(struct inode *dir, struct
> ufs_dir_entry *de, ufs_set_de_type(dir->i_sb, de, inode->i_mode);
>
>       err =3D ufs_commit_chunk(page, pos, len);
> -     ufs_put_page(page);
> +     ufs_put_page(page, page_addr);
>       if (update_times)
>               dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
>       mark_inode_dirty(dir);
>  }
>
>
> -static bool ufs_check_page(struct page *page)
> +static bool ufs_check_page(struct page *page, char *kaddr)
>  {
>       struct inode *dir =3D page->mapping->host;
>       struct super_block *sb =3D dir->i_sb;
> -     char *kaddr =3D page_address(page);
>       unsigned offs, rec_len;
>       unsigned limit =3D PAGE_SIZE;
>       const unsigned chunk_mask =3D UFS_SB(sb)->s_uspi->s_dirblksize - 1;
> @@ -186,21 +186,28 @@ static bool ufs_check_page(struct page *page)
>       return false;
>  }
>
> -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> +/*
> + * Calls to ufs_get_page()/ufs_put_page() must be nested according to th=
e
> + * rules documented in kmap_local_page()/kunmap_local().
> + *
> + * NOTE: ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page(=
)
> + * and must be treated accordingly for nesting purposes.
> + */
> +static struct page *ufs_get_page(struct inode *dir, unsigned long n, voi=
d
> **page_addr) {
>       struct address_space *mapping =3D dir->i_mapping;
>       struct page *page =3D read_mapping_page(mapping, n, NULL);
>       if (!IS_ERR(page)) {
> -             kmap(page);
> +             *page_addr =3D kmap_local_page(page);
>               if (unlikely(!PageChecked(page))) {
> -                     if (!ufs_check_page(page))
> +                     if (!ufs_check_page(page, *page_addr))
>                               goto fail;
>               }
>       }
>       return page;
>
>  fail:
> -     ufs_put_page(page);
> +     ufs_put_page(page, *page_addr);
>       return ERR_PTR(-EIO);
>  }
>
> @@ -226,15 +233,29 @@ ufs_next_entry(struct super_block *sb, struct
> ufs_dir_entry *p) fs16_to_cpu(sb, p->d_reclen));
>  }
>
> -struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> +/*
> + * Return the '..' directory entry and the page in which the entry was
found
> + * (as a parameter - p).
> + *
> + * On Success ufs_put_page() should be called on *p.
> + *
> + * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according=
 to
> + * the rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
> + * must be treated accordingly for nesting purposes.
> + */
> +struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, voi=
d
> **pa) {
> -     struct page *page =3D ufs_get_page(dir, 0);
> +     void *page_addr;
> +     struct page *page =3D ufs_get_page(dir, 0, &page_addr);
>       struct ufs_dir_entry *de =3D NULL;
>
>       if (!IS_ERR(page)) {
>               de =3D ufs_next_entry(dir->i_sb,
> -                                 (struct ufs_dir_entry
*)page_address(page));
> +                                 (struct ufs_dir_entry
*)page_addr);
>               *p =3D page;
> +             *pa =3D page_addr;
>       }
>       return de;
>  }
> @@ -246,9 +267,17 @@ struct ufs_dir_entry *ufs_dotdot(struct inode *dir,
> struct page **p) * returns the page in which the entry was found, and the
> entry itself * (as a parameter - res_dir). Page is returned mapped and
> unlocked. * Entry is guaranteed to be valid.
> + *
> + * On Success ufs_put_page() should be called on *res_page.
> + *
> + * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according=
 to
> + * the rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
> + * must be treated accordingly for nesting purposes.
>   */
>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qst=
r
> *qstr, -                                   struct page **res_page)
> +                                  struct page **res_page, void
**res_page_addr)
>  {
>       struct super_block *sb =3D dir->i_sb;
>       const unsigned char *name =3D qstr->name;
> @@ -259,6 +288,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *di=
r,
> const struct qstr *qstr, struct page *page =3D NULL;
>       struct ufs_inode_info *ui =3D UFS_I(dir);
>       struct ufs_dir_entry *de;
> +     void *page_addr;
>
>       UFSD("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name,
namelen);
>
> @@ -267,6 +297,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *di=
r,
> const struct qstr *qstr,
>
>       /* OFFSET_CACHE */
>       *res_page =3D NULL;
> +     *res_page_addr =3D NULL;
>
>       start =3D ui->i_dir_start_lookup;
>
> @@ -275,9 +306,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *d=
ir,
> const struct qstr *qstr, n =3D start;
>       do {
>               char *kaddr;
> -             page =3D ufs_get_page(dir, n);
> +
> +             page =3D ufs_get_page(dir, n, &page_addr);
>               if (!IS_ERR(page)) {
> -                     kaddr =3D page_address(page);
> +                     kaddr =3D page_addr;
>                       de =3D (struct ufs_dir_entry *) kaddr;
>                       kaddr +=3D ufs_last_byte(dir, n) - reclen;
>                       while ((char *) de <=3D kaddr) {
> @@ -285,7 +317,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *di=
r,
> const struct qstr *qstr, goto found;
>                               de =3D ufs_next_entry(sb, de);
>                       }
> -                     ufs_put_page(page);
> +                     ufs_put_page(page, page_addr);
>               }
>               if (++n >=3D npages)
>                       n =3D 0;
> @@ -295,6 +327,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *di=
r,
> const struct qstr *qstr,
>
>  found:
>       *res_page =3D page;
> +     *res_page_addr =3D page_addr;
>       ui->i_dir_start_lookup =3D n;
>       return de;
>  }
> @@ -312,6 +345,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> *inode) const unsigned int chunk_size =3D UFS_SB(sb)->s_uspi->s_dirblksiz=
e;
>       unsigned short rec_len, name_len;
>       struct page *page =3D NULL;
> +     void *page_addr =3D NULL;
>       struct ufs_dir_entry *de;
>       unsigned long npages =3D dir_pages(dir);
>       unsigned long n;
> @@ -329,12 +363,12 @@ int ufs_add_link(struct dentry *dentry, struct inod=
e
> *inode) for (n =3D 0; n <=3D npages; n++) {
>               char *dir_end;
>
> -             page =3D ufs_get_page(dir, n);
> +             page =3D ufs_get_page(dir, n, &page_addr);
>               err =3D PTR_ERR(page);
>               if (IS_ERR(page))
>                       goto out;
>               lock_page(page);
> -             kaddr =3D page_address(page);
> +             kaddr =3D page_addr;
>               dir_end =3D kaddr + ufs_last_byte(dir, n);
>               de =3D (struct ufs_dir_entry *)kaddr;
>               kaddr +=3D PAGE_SIZE - reclen;
> @@ -365,14 +399,14 @@ int ufs_add_link(struct dentry *dentry, struct inod=
e
> *inode) de =3D (struct ufs_dir_entry *) ((char *) de + rec_len);
>               }
>               unlock_page(page);
> -             ufs_put_page(page);
> +             ufs_put_page(page, page_addr);
>       }
>       BUG();
>       return -EINVAL;
>
>  got_it:
>       pos =3D page_offset(page) +
> -                     (char*)de - (char*)page_address(page);
> +                     (char *)de - (char *)page_addr;
>       err =3D ufs_prepare_chunk(page, pos, rec_len);
>       if (err)
>               goto out_unlock;
> @@ -396,7 +430,7 @@ int ufs_add_link(struct dentry *dentry, struct inode
> *inode) mark_inode_dirty(dir);
>       /* OFFSET_CACHE */
>  out_put:
> -     ufs_put_page(page);
> +     ufs_put_page(page, page_addr);
>  out:
>       return err;
>  out_unlock:
> @@ -441,7 +475,7 @@ ufs_readdir(struct file *file, struct dir_context *ct=
x)
>               char *kaddr, *limit;
>               struct ufs_dir_entry *de;
>
> -             struct page *page =3D ufs_get_page(inode, n);
> +             struct page *page =3D ufs_get_page(inode, n, (void
**)&kaddr);
>
>               if (IS_ERR(page)) {
>                       ufs_error(sb, __func__,
> @@ -450,7 +484,6 @@ ufs_readdir(struct file *file, struct dir_context *ct=
x)
>                       ctx->pos +=3D PAGE_SIZE - offset;
>                       return -EIO;
>               }
> -             kaddr =3D page_address(page);
>               if (unlikely(need_revalidate)) {
>                       if (offset) {
>                               offset =3D ufs_validate_entry(sb, kaddr,
offset, chunk_mask);
> @@ -476,13 +509,13 @@ ufs_readdir(struct file *file, struct dir_context
*ctx)
>                                              ufs_get_de_namlen(sb,
de),
>                                              fs32_to_cpu(sb, de-
>d_ino),
>                                              d_type)) {
> -                                     ufs_put_page(page);
> +                                     ufs_put_page(page, kaddr);
>                                       return 0;
>                               }
>                       }
>                       ctx->pos +=3D fs16_to_cpu(sb, de->d_reclen);
>               }
> -             ufs_put_page(page);
> +             ufs_put_page(page, kaddr);
>       }
>       return 0;
>  }
> @@ -493,10 +526,9 @@ ufs_readdir(struct file *file, struct dir_context *c=
tx)
>   * previous entry.
>   */
>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -                  struct page * page)
> +                  struct page *page, char *kaddr)
>  {
>       struct super_block *sb =3D inode->i_sb;
> -     char *kaddr =3D page_address(page);
>       unsigned from =3D ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi-
>s_dirblksize -
> 1); unsigned to =3D ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen)=
;
> loff_t pos;
> @@ -522,7 +554,7 @@ int ufs_delete_entry(struct inode *inode, struct
> ufs_dir_entry *dir, de =3D ufs_next_entry(sb, de);
>       }
>       if (pde)
> -             from =3D (char*)pde - (char*)page_address(page);
> +             from =3D (char *)pde - kaddr;
>
>       pos =3D page_offset(page) + from;
>       lock_page(page);
> @@ -535,7 +567,7 @@ int ufs_delete_entry(struct inode *inode, struct
> ufs_dir_entry *dir, inode->i_ctime =3D inode->i_mtime =3D current_time(in=
ode);
>       mark_inode_dirty(inode);
>  out:
> -     ufs_put_page(page);
> +     ufs_put_page(page, kaddr);
>       UFSD("EXIT\n");
>       return err;
>  }
> @@ -559,8 +591,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> *dir) goto fail;
>       }
>
> -     kmap(page);
> -     base =3D (char*)page_address(page);
> +     base =3D kmap_local_page(page);
>       memset(base, 0, PAGE_SIZE);
>
>       de =3D (struct ufs_dir_entry *) base;
> @@ -577,7 +608,7 @@ int ufs_make_empty(struct inode * inode, struct inode
> *dir) de->d_reclen =3D cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>       ufs_set_de_namlen(sb, de, 2);
>       strcpy (de->d_name, "..");
> -     kunmap(page);
> +     kunmap_local(base);
>
>       err =3D ufs_commit_chunk(page, 0, chunk_size);
>  fail:
> @@ -592,17 +623,18 @@ int ufs_empty_dir(struct inode * inode)
>  {
>       struct super_block *sb =3D inode->i_sb;
>       struct page *page =3D NULL;
> +     void *page_addr;
>       unsigned long i, npages =3D dir_pages(inode);
>
>       for (i =3D 0; i < npages; i++) {
>               char *kaddr;
>               struct ufs_dir_entry *de;
> -             page =3D ufs_get_page(inode, i);
>
> +             page =3D ufs_get_page(inode, i, &page_addr);
>               if (IS_ERR(page))
>                       continue;
>
> -             kaddr =3D page_address(page);
> +             kaddr =3D page_addr;
>               de =3D (struct ufs_dir_entry *)kaddr;
>               kaddr +=3D ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
>
> @@ -629,12 +661,12 @@ int ufs_empty_dir(struct inode * inode)
>                       }
>                       de =3D ufs_next_entry(sb, de);
>               }
> -             ufs_put_page(page);
> +             ufs_put_page(page, page_addr);
>       }
>       return 1;
>
>  not_empty:
> -     ufs_put_page(page);
> +     ufs_put_page(page, page_addr);
>       return 0;
>  }
>
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 29d5a0e0c8f0..cdf3bcf9d02e 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -210,13 +210,14 @@ static int ufs_unlink(struct inode *dir, struct den=
try
> *dentry) struct inode * inode =3D d_inode(dentry);
>       struct ufs_dir_entry *de;
>       struct page *page;
> +     void *page_addr;
>       int err =3D -ENOENT;
>
> -     de =3D ufs_find_entry(dir, &dentry->d_name, &page);
> +     de =3D ufs_find_entry(dir, &dentry->d_name, &page, &page_addr);
>       if (!de)
>               goto out;
>
> -     err =3D ufs_delete_entry(dir, de, page);
> +     err =3D ufs_delete_entry(dir, de, page, page_addr);
>       if (err)
>               goto out;
>
> @@ -250,27 +251,31 @@ static int ufs_rename(struct user_namespace
*mnt_userns,
> struct inode *old_dir, struct inode *old_inode =3D d_inode(old_dentry);
>       struct inode *new_inode =3D d_inode(new_dentry);
>       struct page *dir_page =3D NULL;
> +     void *dir_page_addr;
>       struct ufs_dir_entry * dir_de =3D NULL;
>       struct page *old_page;
> +     void *old_page_addr;
>       struct ufs_dir_entry *old_de;
>       int err =3D -ENOENT;
>
>       if (flags & ~RENAME_NOREPLACE)
>               return -EINVAL;
>
> -     old_de =3D ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> +     old_de =3D ufs_find_entry(old_dir, &old_dentry->d_name, &old_page,
> +                             &old_page_addr);
>       if (!old_de)
>               goto out;
>
>       if (S_ISDIR(old_inode->i_mode)) {
>               err =3D -EIO;
> -             dir_de =3D ufs_dotdot(old_inode, &dir_page);
> +             dir_de =3D ufs_dotdot(old_inode, &dir_page, &dir_page_addr)=
;
>               if (!dir_de)
>                       goto out_old;
>       }
>
>       if (new_inode) {
>               struct page *new_page;
> +             void *new_page_addr;
>               struct ufs_dir_entry *new_de;
>
>               err =3D -ENOTEMPTY;
> @@ -278,10 +283,11 @@ static int ufs_rename(struct user_namespace
*mnt_userns,
> struct inode *old_dir, goto out_dir;
>
>               err =3D -ENOENT;
> -             new_de =3D ufs_find_entry(new_dir, &new_dentry->d_name,
&new_page);
> +             new_de =3D ufs_find_entry(new_dir, &new_dentry->d_name,
&new_page,
> +                                     &new_page_addr);
>               if (!new_de)
>                       goto out_dir;
> -             ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
> +             ufs_set_link(new_dir, new_de, new_page, new_page_addr,
old_inode, 1);
>               new_inode->i_ctime =3D current_time(new_inode);
>               if (dir_de)
>                       drop_nlink(new_inode);
> @@ -300,29 +306,25 @@ static int ufs_rename(struct user_namespace
*mnt_userns,
> struct inode *old_dir, */
>       old_inode->i_ctime =3D current_time(old_inode);
>
> -     ufs_delete_entry(old_dir, old_de, old_page);
> +     ufs_delete_entry(old_dir, old_de, old_page, old_page_addr);
>       mark_inode_dirty(old_inode);
>
>       if (dir_de) {
>               if (old_dir !=3D new_dir)
> -                     ufs_set_link(old_inode, dir_de, dir_page,
new_dir, 0);
> -             else {
> -                     kunmap(dir_page);
> -                     put_page(dir_page);
> -             }
> +                     ufs_set_link(old_inode, dir_de, dir_page,
> +                                  dir_page_addr, new_dir, 0);
> +             else
> +                     ufs_put_page(dir_page, dir_page_addr);
>               inode_dec_link_count(old_dir);
>       }
>       return 0;
>
>
>  out_dir:
> -     if (dir_de) {
> -             kunmap(dir_page);
> -             put_page(dir_page);
> -     }
> +     if (dir_de)
> +             ufs_put_page(dir_page, dir_page_addr);
>  out_old:
> -     kunmap(old_page);
> -     put_page(old_page);
> +     ufs_put_page(old_page, old_page_addr);
>  out:
>       return err;
>  }
> diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
> index 550f7c5a3636..20d224c163ab 100644
> --- a/fs/ufs/ufs.h
> +++ b/fs/ufs/ufs.h
> @@ -102,12 +102,16 @@ extern const struct inode_operations
> ufs_dir_inode_operations; extern int ufs_add_link (struct dentry *, struc=
t
> inode *);
>  extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
>  extern int ufs_make_empty(struct inode *, struct inode *);
> -extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct
qstr
> *, struct page **); -extern int ufs_delete_entry(struct inode *, struct
> ufs_dir_entry *, struct page *); +extern struct ufs_dir_entry
> *ufs_find_entry(struct inode *dir, const struct qstr *qstr, +
                            struct
> page **res_page, void **res_page_addr);
> +extern int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *d=
ir,
> +                         struct page *page, char *kaddr);
>  extern int ufs_empty_dir (struct inode *);
> -extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
> +extern struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page *=
*p,
> void **pa); extern void ufs_set_link(struct inode *dir, struct ufs_dir_en=
try
> *de, -                         struct page *page, struct inode *inode, bo=
ol
update_times);
> +                      struct page *page, void *page_addr,
> +                      struct inode *inode, bool update_times);
> +extern void ufs_put_page(struct page *page, void *page_addr);
>
>  /* file.c */
>  extern const struct inode_operations ufs_file_inode_operations;
> --
> 2.37.1
