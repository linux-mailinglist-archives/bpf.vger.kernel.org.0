Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B342A600175
	for <lists+bpf@lfdr.de>; Sun, 16 Oct 2022 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJPQqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Oct 2022 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJPQqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Oct 2022 12:46:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650EB2CC9B;
        Sun, 16 Oct 2022 09:46:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so14942495wrp.10;
        Sun, 16 Oct 2022 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7z0EGIou8mzFY/eykkKq+/9Pr9xrAM74qGCOxO+Afvg=;
        b=EwcyxmuMGYtQeVP4V2wH+ymysOOrFKlQOCAE+a0G4k+xoARu2cYYwG/SNHTE+WGvir
         qHrp659VcxYVnKX/Iho8nVCi4A9ChskVI8ZDpmzX0jzhitrBa3KCGNqluMja3kjpntij
         OLnfhf7xQAC/J9FLTdvADbz+Q4eUWfPvAmKDwSupcaWvC8qZMZs//NMmY7HxuFrLE2h2
         D35hYjpaQ0CXE00h3FSvUFx/v2X18m5tUvW7WeHC3IQLirfOuBltgHsqxLfBHy2aEZH2
         diCM0/ocB8MWEXZNo+h8pC6ql8YrACgBqv4Rdm80iwbQbWlUvxq46ZUYWBBMmWea7kbF
         M9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z0EGIou8mzFY/eykkKq+/9Pr9xrAM74qGCOxO+Afvg=;
        b=wsha57nFQqS2Xv6k4VFHk2LQsRseJ8ugtIxT49+ga4BDHmFqtOvRT4MRTiJDbU92hS
         6DTcLHN9B88b67BM01XDRwoVXlYPdvw99t1eil7U3Ku2LvHjy0ot9Qo6CctmIPrqT72R
         5cwnl2j8352WEqOBVDdiXrbgXpy13s6s3rFVhpCT8wpvK9LAB6oEOeq2oY8KRooJuqIJ
         Sr1ZRF0oT+eOvscd4ar6I/5xKYLEn499TzqGq31xx1LSoQ+wkROD7hDfaclPP2HPcjAW
         6JLF5GdDLVVN1K7lsUBmJAhX7eJRHpl5mzhOc1vfs0YYtUsnDjixooM3/wG0eOpSqMbx
         57Gw==
X-Gm-Message-State: ACrzQf0J3dGFbhkGPEZMVmm1ml45bhyYaKFev5iRZjDQsBu0NAUBPvgT
        xq0FmnvSOL008n3sxSg9p1M=
X-Google-Smtp-Source: AMsMyM6yOkASr2MgteVa9Ttgy3tnFpOEu9+lwwtqAmqWBQrJP/HnZ14EtyFoLwc6XL/qqMmmVURztQ==
X-Received: by 2002:a05:6000:144c:b0:230:816f:3167 with SMTP id v12-20020a056000144c00b00230816f3167mr4035765wrx.532.1665938788686;
        Sun, 16 Oct 2022 09:46:28 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm6523167wrp.78.2022.10.16.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:46:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] fs/sysv: Replace kmap() with kmap_local_page()
Date:   Sun, 16 Oct 2022 18:46:36 +0200
Message-Id: <20221016164636.8696-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/sysv is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
requires the mapping address, so return that address from dir_get_page()
to be used in dir_put_page().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending this patch adding a review tag from Ira. No changes to the
code. It's also a friendly ping, since first submission was on Aug 26th.

This code is not tested. I have no means to create an SysV filesystem.
Despite nothing here seems to break the strict rules about the use of
kmap_local_page(), any help with testing will be much appreciated :-)

 fs/sysv/dir.c   | 83 ++++++++++++++++++++++---------------------------
 fs/sysv/namei.c | 26 +++++++++-------
 fs/sysv/sysv.h  | 19 ++++++++---
 3 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..130350fde106 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,12 +28,6 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-static inline void dir_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 {
 	struct address_space *mapping = page->mapping;
@@ -52,12 +46,12 @@ static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static struct page * dir_get_page(struct inode *dir, unsigned long n)
+static struct page *dir_get_page(struct inode *dir, unsigned long n, void **page_addr)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page))
-		kmap(page);
+		*page_addr = kmap_local_page(page);
 	return page;
 }
 
@@ -80,11 +74,10 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct sysv_dir_entry *de;
-		struct page *page = dir_get_page(inode, n);
+		struct page *page = dir_get_page(inode, n, (void **)&kaddr);
 
 		if (IS_ERR(page))
 			continue;
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)(kaddr+offset);
 		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
 		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
@@ -96,11 +89,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
 					fs16_to_cpu(SYSV_SB(sb), de->inode),
 					DT_UNKNOWN)) {
-				dir_put_page(page);
+				dir_put_page(page, kaddr);
 				return 0;
 			}
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -124,7 +117,8 @@ static inline int namecompare(int len, int maxlen,
  * itself (as a parameter - res_dir). It does NOT read the inode of the
  * entry - you'll have to do that yourself if you want to.
  */
-struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
+struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry,
+				       struct page **res_page, void **res_page_addr)
 {
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
@@ -133,8 +127,10 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
 	struct sysv_dir_entry *de;
+	char *kaddr;
 
 	*res_page = NULL;
+	*res_page_addr = NULL;
 
 	start = SYSV_I(dir)->i_dir_start_lookup;
 	if (start >= npages)
@@ -142,10 +138,8 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	n = start;
 
 	do {
-		char *kaddr;
-		page = dir_get_page(dir, n);
+		page = dir_get_page(dir, n, (void **)&kaddr);
 		if (!IS_ERR(page)) {
-			kaddr = (char*)page_address(page);
 			de = (struct sysv_dir_entry *) kaddr;
 			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 			for ( ; (char *) de <= kaddr ; de++) {
@@ -155,7 +149,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 							name, de->name))
 					goto found;
 			}
-			dir_put_page(page);
+			dir_put_page(page, kaddr);
 		}
 
 		if (++n >= npages)
@@ -167,6 +161,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 found:
 	SYSV_I(dir)->i_dir_start_lookup = n;
 	*res_page = page;
+	*res_page_addr = kaddr;
 	return de;
 }
 
@@ -176,6 +171,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	struct page *page = NULL;
+	void *page_addr = NULL;
 	struct sysv_dir_entry * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -185,11 +181,11 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 
 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
-		page = dir_get_page(dir, n);
+		page = dir_get_page(dir, n, &page_addr);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
-		kaddr = (char*)page_address(page);
+		kaddr = page_addr;
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 		while ((char *)de <= kaddr) {
@@ -200,14 +196,13 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 				goto out_page;
 			de++;
 		}
-		dir_put_page(page);
+		dir_put_page(page, page_addr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + (char *)de - (char *)page_addr;
 	lock_page(page);
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	if (err)
@@ -219,7 +214,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 out_page:
-	dir_put_page(page);
+	dir_put_page(page, page_addr);
 out:
 	return err;
 out_unlock:
@@ -227,10 +222,9 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	goto out_page;
 }
 
-int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
+int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page, char *kaddr)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = (char*)page_address(page);
 	loff_t pos = page_offset(page) + (char *)de - kaddr;
 	int err;
 
@@ -239,7 +233,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 	mark_inode_dirty(inode);
 	return err;
@@ -259,19 +253,15 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
 		unlock_page(page);
 		goto fail;
 	}
-	kmap(page);
-
-	base = (char*)page_address(page);
+	base = kmap_local_page(page);
 	memset(base, 0, PAGE_SIZE);
-
 	de = (struct sysv_dir_entry *) base;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	strcpy(de->name,".");
 	de++;
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
 	strcpy(de->name,"..");
-
-	kunmap(page);
+	kunmap_local(base);
 	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
 fail:
 	put_page(page);
@@ -286,16 +276,15 @@ int sysv_empty_dir(struct inode * inode)
 	struct super_block *sb = inode->i_sb;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
+	char *kaddr;
 
 	for (i = 0; i < npages; i++) {
-		char *kaddr;
 		struct sysv_dir_entry * de;
-		page = dir_get_page(inode, i);
+		page = dir_get_page(inode, i, (void **)&kaddr);
 
 		if (IS_ERR(page))
 			continue;
 
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
 
@@ -314,22 +303,21 @@ int sysv_empty_dir(struct inode * inode)
 			if (de->name[1] != '.' || de->name[2])
 				goto not_empty;
 		}
-		dir_put_page(page);
+		dir_put_page(page, kaddr);
 	}
 	return 1;
 
 not_empty:
-	dir_put_page(page);
+	dir_put_page(page, kaddr);
 	return 0;
 }
 
 /* Releases the page */
 void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
-	struct inode *inode)
+		   void *page_addr, struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + (char *)de - (char *)page_addr;
 	int err;
 
 	lock_page(page);
@@ -337,19 +325,21 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	BUG_ON(err);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
-	dir_put_page(page);
+	dir_put_page(page, page_addr);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
 	mark_inode_dirty(dir);
 }
 
-struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
+struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p, void **pa)
 {
-	struct page *page = dir_get_page(dir, 0);
+	void *page_addr;
+	struct page *page = dir_get_page(dir, 0, &page_addr);
 	struct sysv_dir_entry *de = NULL;
 
 	if (!IS_ERR(page)) {
-		de = (struct sysv_dir_entry*) page_address(page) + 1;
+		de = (struct sysv_dir_entry *)page_addr + 1;
 		*p = page;
+		*pa = page_addr;
 	}
 	return de;
 }
@@ -357,12 +347,13 @@ struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
 ino_t sysv_inode_by_name(struct dentry *dentry)
 {
 	struct page *page;
-	struct sysv_dir_entry *de = sysv_find_entry (dentry, &page);
+	void *page_addr;
+	struct sysv_dir_entry *de = sysv_find_entry(dentry, &page, &page_addr);
 	ino_t res = 0;
 	
 	if (de) {
 		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
-		dir_put_page(page);
+		dir_put_page(page, page_addr);
 	}
 	return res;
 }
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..1371980ec5fb 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -152,14 +152,15 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
 {
 	struct inode * inode = d_inode(dentry);
 	struct page * page;
+	void *page_addr;
 	struct sysv_dir_entry * de;
 	int err = -ENOENT;
 
-	de = sysv_find_entry(dentry, &page);
+	de = sysv_find_entry(dentry, &page, &page_addr);
 	if (!de)
 		goto out;
 
-	err = sysv_delete_entry (de, page);
+	err = sysv_delete_entry(de, page, page_addr);
 	if (err)
 		goto out;
 
@@ -196,26 +197,29 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
 	struct page * dir_page = NULL;
+	void *dir_page_addr;
 	struct sysv_dir_entry * dir_de = NULL;
 	struct page * old_page;
+	void *old_page_addr;
 	struct sysv_dir_entry * old_de;
 	int err = -ENOENT;
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	old_de = sysv_find_entry(old_dentry, &old_page);
+	old_de = sysv_find_entry(old_dentry, &old_page, &old_page_addr);
 	if (!old_de)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = sysv_dotdot(old_inode, &dir_page);
+		dir_de = sysv_dotdot(old_inode, &dir_page, &dir_page_addr);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
+		void *new_page_addr;
 		struct page * new_page;
 		struct sysv_dir_entry * new_de;
 
@@ -224,10 +228,10 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = sysv_find_entry(new_dentry, &new_page);
+		new_de = sysv_find_entry(new_dentry, &new_page, &new_page_addr);
 		if (!new_de)
 			goto out_dir;
-		sysv_set_link(new_de, new_page, old_inode);
+		sysv_set_link(new_de, new_page, new_page_addr, old_inode);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -240,23 +244,21 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			inode_inc_link_count(new_dir);
 	}
 
-	sysv_delete_entry(old_de, old_page);
+	sysv_delete_entry(old_de, old_page, old_page_addr);
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
-		sysv_set_link(dir_de, dir_page, new_dir);
+		sysv_set_link(dir_de, dir_page, dir_page_addr, new_dir);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
 
 out_dir:
 	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
+		dir_put_page(dir_page, dir_page_addr);
 	}
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	dir_put_page(old_page, old_page_addr);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 99ddf033da4f..b0631ea6b506 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -119,6 +119,11 @@ static inline void dirty_sb(struct super_block *sb)
 		mark_buffer_dirty(sbi->s_bh2);
 }
 
+static inline void dir_put_page(struct page *page, void *page_addr)
+{
+	kunmap_local(page_addr);
+	put_page(page);
+}
 
 /* ialloc.c */
 extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
@@ -148,14 +153,18 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
-extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
+extern struct sysv_dir_entry *sysv_find_entry(struct dentry *dir,
+					      struct page **res_page,
+					      void **res_page_addr);
 extern int sysv_add_link(struct dentry *, struct inode *);
-extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
+extern int sysv_delete_entry(struct sysv_dir_entry *dir, struct page *page,
+			     char *kaddr);
 extern int sysv_make_empty(struct inode *, struct inode *);
 extern int sysv_empty_dir(struct inode *);
-extern void sysv_set_link(struct sysv_dir_entry *, struct page *,
-			struct inode *);
-extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
+extern void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
+			  void *page_addr, struct inode *inode);
+extern struct sysv_dir_entry *sysv_dotdot(struct inode *inode,
+					  struct page **page, void **page_addr);
 extern ino_t sysv_inode_by_name(struct dentry *);
 
 
-- 
2.37.2

