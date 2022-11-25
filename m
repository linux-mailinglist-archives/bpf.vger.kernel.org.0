Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5F639150
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 23:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYWRh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 17:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYWRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 17:17:36 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4F1166;
        Fri, 25 Nov 2022 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yZyXvExu71Hqa5dGSvd1ywIc0ZyDN4TWwyD8igr3IwE=; b=UIlyHdZpW9ykgjlsPaD6u+E7z0
        cipX/Zhm9CJiw7yfvSA+LXnDX2i/FD3brG4U2egQRFci7hVtL00hRvzg2kjsAkWpeNAwHDwkrEN0O
        U2XSluWqwqDuBq9Mh4K/Z7G4l4DdfZBPRrObd9DFDfA+lxv/4SpMlrnuOSSxRPBOjMhLYHWmLShCs
        9oqnthbSklcPZgIQA4fyO2xHyx9Skmmfb1s06lujTgsVxxj5hG0bvELdFleguAnWi9tyKgoWZTWqj
        sGa43Th/g/TYHcU72wz5gKEjCLQTPjBnH0w98W6JKO7fcbI3EtjIW0QPPOZBpl9NPvhXepgY3BwdV
        xT/VWjkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyh0i-006lQA-2S;
        Fri, 25 Nov 2022 22:17:28 +0000
Date:   Fri, 25 Nov 2022 22:17:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y4E++JERgUMoqfjG@ZenIV>
References: <20221016163855.8173-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016163855.8173-1-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 16, 2022 at 06:38:55PM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().

Umm...  I'm not sure it's the right way to handle that.  Look:


> -static inline void ufs_put_page(struct page *page)
> +inline void ufs_put_page(struct page *page, void *page_addr)
>  {
> -	kunmap(page);
> +	kunmap_local(page_addr);

Make that
	kunmap_local((void *)((unsigned long)page_addr & PAGE_MASK));
and things become much easier.

>  	put_page(page);
>  }
>  
> @@ -72,11 +72,12 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
>  	if (de) {
>  		res = fs32_to_cpu(dir->i_sb, de->d_ino);
> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);
		ufs_put_page(page, de);
and page_addr is not needed.

>  /* Releases the page */
>  void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
> -		  struct page *page, struct inode *inode,
> -		  bool update_times)
> +		  struct page *page, void *page_addr,
> +		  struct inode *inode, bool update_times)
>  {
>  	loff_t pos = page_offset(page) +
> -			(char *) de - (char *) page_address(page);
> +			(char *)de - (char *)page_addr;

  	loff_t pos = page_offset(page) + offset_in_page(de);

> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
	ufs_put_page(page, de);
and page_addr is unused, i.e. caller of ufs_set_link() don't need
any changes at all.

> +static struct page *ufs_get_page(struct inode *dir, unsigned long n, void **page_addr)

I suspect that
static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
would be better for callers.

> -struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> +/*
> + * Return the '..' directory entry and the page in which the entry was found
> + * (as a parameter - p).
> + *
> + * On Success ufs_put_page() should be called on *p.
> + *
> + * NOTE: Calls to ufs_get_page()/ufs_put_page() must be nested according to
> + * the rules documented in kmap_local_page()/kunmap_local().
> + *
> + * ufs_find_entry() and ufs_dotdot() act as calls to ufs_get_page() and
> + * must be treated accordingly for nesting purposes.
> + */
> +struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p, void **pa)
>  {
> -	struct page *page = ufs_get_page(dir, 0);
> +	void *page_addr;
> +	struct page *page = ufs_get_page(dir, 0, &page_addr);
>  	struct ufs_dir_entry *de = NULL;
>  
>  	if (!IS_ERR(page)) {
>  		de = ufs_next_entry(dir->i_sb,
> -				    (struct ufs_dir_entry *)page_address(page));
> +				    (struct ufs_dir_entry *)page_addr);
>  		*p = page;
> +		*pa = page_addr;

Callers can reconstruct page_addr by de.  The function itself becomes

struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **page)
{
	struct ufs_dir_entry *de = ufs_get_page(dir, 0, page);

	if (!IS_ERR(de))
		return ufs_next_entry(dir->i_sb, de);
	else
		return NULL;
}

and callers need no changes at all.

>  struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
> -				     struct page **res_page)
> +				     struct page **res_page, void **res_page_addr)

Same story; *res_page_addr is rounded return value.
> @@ -275,9 +306,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  	n = start;
>  	do {
>  		char *kaddr;
> -		page = ufs_get_page(dir, n);
> +
> +		page = ufs_get_page(dir, n, &page_addr);
>  		if (!IS_ERR(page)) {
> -			kaddr = page_address(page);
> +			kaddr = page_addr;

		char *kaddr = ufs_get_page(dir, n, &page);
		if (!IS_ERR(kaddr) {
>  			de = (struct ufs_dir_entry *) kaddr;
>  			kaddr += ufs_last_byte(dir, n) - reclen;
>  			while ((char *) de <= kaddr) {
> @@ -285,7 +317,7 @@ struct ufs_dir_entry *ufs_find_entry(struct inode *dir, const struct qstr *qstr,
>  					goto found;
>  				de = ufs_next_entry(sb, de);
>  			}
> -			ufs_put_page(page);
> +			ufs_put_page(page, page_addr);
			ufs_put_page(page, kaddr);
it's in the same page...

> @@ -312,6 +345,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	const unsigned int chunk_size = UFS_SB(sb)->s_uspi->s_dirblksize;
>  	unsigned short rec_len, name_len;
>  	struct page *page = NULL;
> +	void *page_addr = NULL;
>  	struct ufs_dir_entry *de;
>  	unsigned long npages = dir_pages(dir);
>  	unsigned long n;
> @@ -329,12 +363,12 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	for (n = 0; n <= npages; n++) {
>  		char *dir_end;
>  
> -		page = ufs_get_page(dir, n);
> +		page = ufs_get_page(dir, n, &page_addr);
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
>  			goto out;
>  		lock_page(page);
> -		kaddr = page_address(page);
> +		kaddr = page_addr;

		kaddr = ufs_get_page(dir, n, &page);
		err = PTR_ERR(kaddr);
  		if (IS_ERR(kaddr))
  			goto out;
 		lock_page(page);

>  		dir_end = kaddr + ufs_last_byte(dir, n);
>  		de = (struct ufs_dir_entry *)kaddr;
>  		kaddr += PAGE_SIZE - reclen;
> @@ -365,14 +399,14 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
>  		}
>  		unlock_page(page);
> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);
		ufs_put_page(page, kaddr);

>  	}
>  	BUG();
>  	return -EINVAL;
>  
>  got_it:
>  	pos = page_offset(page) +
> -			(char*)de - (char*)page_address(page);
> +			(char *)de - (char *)page_addr;

	pos = page_offset(page) + offset_in_page(de);

>  	err = ufs_prepare_chunk(page, pos, rec_len);
>  	if (err)
>  		goto out_unlock;
> @@ -396,7 +430,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
>  	mark_inode_dirty(dir);
>  	/* OFFSET_CACHE */
>  out_put:
> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
	ufs_put_page(page, kaddr);

>  out:
>  	return err;
>  out_unlock:
> @@ -441,7 +475,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
>  		char *kaddr, *limit;
>  		struct ufs_dir_entry *de;
>  
> -		struct page *page = ufs_get_page(inode, n);
> +		struct page *page = ufs_get_page(inode, n, (void **)&kaddr);

Yecch...
		kaddr = ufs_get_page(inode, n, &page);
with obvious change of error check below.  It definitely looks like
more convenient calling conventions - getting rid of casts like that...

>  int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
> -		     struct page * page)
> +		     struct page *page, char *kaddr)

Do we need it?  If not, ufs_delete_entry() calls need no changes...

>  {
>  	struct super_block *sb = inode->i_sb;
> -	char *kaddr = page_address(page);
>  	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
>  	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
>  	loff_t pos;

umm...
	kaddr = (char *)((unsigned long)dir & PAGE_MASK);
	unsigned from = offset_in_page(dir) & ....
	unsigned to = offset_in_page(dir) + ....

> @@ -522,7 +554,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
>  		de = ufs_next_entry(sb, de);
>  	}
>  	if (pde)
> -		from = (char*)pde - (char*)page_address(page);
> +		from = (char *)pde - kaddr;

Note that this is
		from = offset_in_page(pde);
>  out:
> -	ufs_put_page(page);
> +	ufs_put_page(page, kaddr);
>  	UFSD("EXIT\n");
>  	return err;
>  }

> @@ -592,17 +623,18 @@ int ufs_empty_dir(struct inode * inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct page *page = NULL;
> +	void *page_addr;
>  	unsigned long i, npages = dir_pages(inode);
>  
>  	for (i = 0; i < npages; i++) {
>  		char *kaddr;
>  		struct ufs_dir_entry *de;
> -		page = ufs_get_page(inode, i);
>  
> +		page = ufs_get_page(inode, i, &page_addr);
>  		if (IS_ERR(page))
>  			continue;
>  
> -		kaddr = page_address(page);
> +		kaddr = page_addr;
	
		kaddr = ufs_get_page(inode, i, &page);
		if (IS_ERR(kaddr))
			continue;

> -		ufs_put_page(page);
> +		ufs_put_page(page, page_addr);

		ufs_put_page(page, kaddr)
>  	}
>  	return 1;
>  
>  not_empty:
> -	ufs_put_page(page);
> +	ufs_put_page(page, page_addr);
	same here.

>  	return 0;
>  }
>  
> diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
> index 29d5a0e0c8f0..cdf3bcf9d02e 100644
> --- a/fs/ufs/namei.c
> +++ b/fs/ufs/namei.c
> @@ -210,13 +210,14 @@ static int ufs_unlink(struct inode *dir, struct dentry *dentry)
>  	struct inode * inode = d_inode(dentry);
>  	struct ufs_dir_entry *de;
>  	struct page *page;
> +	void *page_addr;
>  	int err = -ENOENT;
>  
> -	de = ufs_find_entry(dir, &dentry->d_name, &page);
> +	de = ufs_find_entry(dir, &dentry->d_name, &page, &page_addr);
>  	if (!de)
>  		goto out;
>  
> -	err = ufs_delete_entry(dir, de, page);
> +	err = ufs_delete_entry(dir, de, page, page_addr);
>  	if (err)
>  		goto out;

None of that is needed.

> @@ -250,27 +251,31 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	struct inode *old_inode = d_inode(old_dentry);
>  	struct inode *new_inode = d_inode(new_dentry);
>  	struct page *dir_page = NULL;
> +	void *dir_page_addr;
>  	struct ufs_dir_entry * dir_de = NULL;
>  	struct page *old_page;
> +	void *old_page_addr;
>  	struct ufs_dir_entry *old_de;
>  	int err = -ENOENT;
>  
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
>  
> -	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page);
> +	old_de = ufs_find_entry(old_dir, &old_dentry->d_name, &old_page,
> +				&old_page_addr);
>  	if (!old_de)
>  		goto out;
>  
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		err = -EIO;
> -		dir_de = ufs_dotdot(old_inode, &dir_page);
> +		dir_de = ufs_dotdot(old_inode, &dir_page, &dir_page_addr);
>  		if (!dir_de)
>  			goto out_old;
>  	}
>  
>  	if (new_inode) {
>  		struct page *new_page;
> +		void *new_page_addr;
>  		struct ufs_dir_entry *new_de;
>  
>  		err = -ENOTEMPTY;
> @@ -278,10 +283,11 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			goto out_dir;
>  
>  		err = -ENOENT;
> -		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page);
> +		new_de = ufs_find_entry(new_dir, &new_dentry->d_name, &new_page,
> +					&new_page_addr);
>  		if (!new_de)
>  			goto out_dir;
> -		ufs_set_link(new_dir, new_de, new_page, old_inode, 1);
> +		ufs_set_link(new_dir, new_de, new_page, new_page_addr, old_inode, 1);
>  		new_inode->i_ctime = current_time(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
> @@ -300,29 +306,25 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	 */
>  	old_inode->i_ctime = current_time(old_inode);
>  
> -	ufs_delete_entry(old_dir, old_de, old_page);
> +	ufs_delete_entry(old_dir, old_de, old_page, old_page_addr);
>  	mark_inode_dirty(old_inode);
>  
>  	if (dir_de) {
>  		if (old_dir != new_dir)
> -			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
> -		else {
> -			kunmap(dir_page);
> -			put_page(dir_page);
> -		}
> +			ufs_set_link(old_inode, dir_de, dir_page,
> +				     dir_page_addr, new_dir, 0);
> +		else
> +			ufs_put_page(dir_page, dir_page_addr);
>  		inode_dec_link_count(old_dir);
>  	}
>  	return 0;
>  
>  
>  out_dir:
> -	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> -	}
> +	if (dir_de)
> +		ufs_put_page(dir_page, dir_page_addr);
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	ufs_put_page(old_page, old_page_addr);

Just pass dir_de and old_de resp. in these two calls of ufs_put_page() - nothing
else is needed...


The bottom line:
	* teach your ufs_put_page() to accept any address within the page
	* flip the ways you return page and address in ufs_get_page()
	* use offset_in_page(addr) instead of these addr - page_address(page)
and you'll get a much smaller patch, with a lot less noise in it.
What's more, offset_in_page() part can be carved out into a separate
commit - it's valid on its own, and it makes both halves easier to
follow.

AFAICS, similar observations apply in your sysvfs patch; the point about
calling conventions for ufs_get_page() definitely applies there, and
stronger than for ufs - those casts are eye-watering...
