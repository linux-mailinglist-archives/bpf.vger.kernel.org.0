Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4360B7CC
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiJXTde (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiJXTdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 15:33:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82372476C5
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:03:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-360a7ff46c3so97538247b3.12
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1W4COW227y1aljclFVB4DMM0UVXXW3Ga8dwPdHFh004=;
        b=Ai4e64uWR6Fn6sf8KZrJVl7N1QJ4SSOruj07zkal+UJJ+/elp6Rztzzh7VBceGOiX0
         4z6CzCpcMAY+ytKlb9nl8wvRjlWrzHZgtgRYTZcp7y89f5KZuY6tlSDKY2wUiraKQVXs
         sRtk+nkAkcSnD6KsoCcXl7hu03w1uNnSYDIXrrCWOx5pf8W6v4mVV0TYqju37cmYcVhB
         3hiJa2YPH+dUFLiGfjdFNnkXm2ckCghqJMV/U8lwSVe7UgAkyXDzblFU8l5wg4MUe5wr
         QxHJB3CwIHTVWPMgu6ky7VoPuD08RPAT0r1aDIUHXDGkfaetfcXtTHRUoFywPXs2M/Uf
         Xpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1W4COW227y1aljclFVB4DMM0UVXXW3Ga8dwPdHFh004=;
        b=oVqBFV15bgyMsGn8dka9tkM9X8eNQzCtQGM0F4X26Y2oYiiB5FsYHk/QIcJ4wJEYP0
         qd9KG4P2my5Ugh2iH1JJibugfah6Cd60BNaGDOvjPPV4mNUoixMoc0SCWUpzjXBloQjK
         fVxMXw+eHY6x+Rx35rVcbcb9JEU2mkMXbXxbKxrLUg9hGyqUInUkUs5tvjppLCustd4v
         2s5g1hp6m7PxHuthOAkTijSwppqRB82NJIKxXXXvCYesXeSdMdBfLNQRk8A1Ppf5gaYU
         E1O8lRw2A9weHiLKjLoJgDFFo3wRTxD3TUnTFyACB0A5RyBKi72XVWudQgy9tm+PNJ9G
         o7jQ==
X-Gm-Message-State: ACrzQf1Kpl03xI4tlPUPV9yakpC/DqeIZ02uTGQQnrq7zaVszplCvZmk
        6mHPg5bFk9KLpkddRrRt5KdmGBA=
X-Google-Smtp-Source: AMsMyM5+edUCkiqlB86Nctg+Hv2aZNAeB20G0xodkvYJSik5eECA+ZdKywcqWybGmB6B0UPhQdpNXis=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:c713:0:b0:6ca:203:504f with SMTP id
 w19-20020a25c713000000b006ca0203504fmr23725194ybe.574.1666634544720; Mon, 24
 Oct 2022 11:02:24 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:02:23 -0700
In-Reply-To: <20221023180524.2859994-1-yhs@fb.com>
Mime-Version: 1.0
References: <20221023180514.2857498-1-yhs@fb.com> <20221023180524.2859994-1-yhs@fb.com>
Message-ID: <Y1bTL/v1UjyPDWVA@google.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Refactor inode/task/sk storage
 map_{alloc,free}() for reuse
From:   sdf@google.com
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/23, Yonghong Song wrote:
> Refactor codes so that inode/task/sk storage map_{alloc,free}
> can maximally share the same code. There is no functionality change.

Does it make sense to also do following? (see below, untested)
We aren't saving much code-wise here, but at least we won't have three  
copies
of the same long comment.


diff --git a/include/linux/bpf_local_storage.h  
b/include/linux/bpf_local_storage.h
index 7ea18d4da84b..e4b0b04d081b 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -138,6 +138,8 @@ int bpf_local_storage_map_check_btf(const struct  
bpf_map *map,
  				    const struct btf_type *key_type,
  				    const struct btf_type *value_type);

+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage  
*local_storage);
+
  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
  				   struct bpf_local_storage_elem *selem);

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 5f7683b19199..5313cb0b7181 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -56,11 +56,9 @@ static struct bpf_local_storage_data  
*inode_storage_lookup(struct inode *inode,

  void bpf_inode_storage_free(struct inode *inode)
  {
-	struct bpf_local_storage_elem *selem;
  	struct bpf_local_storage *local_storage;
  	bool free_inode_storage = false;
  	struct bpf_storage_blob *bsb;
-	struct hlist_node *n;

  	bsb = bpf_inode(inode);
  	if (!bsb)
@@ -74,30 +72,11 @@ void bpf_inode_storage_free(struct inode *inode)
  		return;
  	}

-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
  	raw_spin_lock_bh(&local_storage->lock);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_inode_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_inode_storage = bpf_local_storage_unlink_nolock(local_storage);
  	raw_spin_unlock_bh(&local_storage->lock);
  	rcu_read_unlock();

-	/* free_inoode_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
  	if (free_inode_storage)
  		kfree_rcu(local_storage, rcu);
  }
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9dc6de1cf185..0ea754953242 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -98,6 +98,36 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
  		kfree_rcu(local_storage, rcu);
  }

+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage  
*local_storage)
+{
+	struct bpf_local_storage_elem *selem;
+	bool free_storage = false;
+	struct hlist_node *n;
+
+	/* Neither the bpf_prog nor the bpf-map's syscall
+	 * could be modifying the local_storage->list now.
+	 * Thus, no elem can be added-to or deleted-from the
+	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 *
+	 * It is racing with bpf_local_storage_map_free() alone
+	 * when unlinking elem from the local_storage->list and
+	 * the map's bucket->list.
+	 */
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * local_storage.
+		 */
+		bpf_selem_unlink_map(selem);
+		free_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, false, false);
+	}
+
+	/* free_storage should always be true as long as
+	 * local_storage->list was non-empty.
+	 */
+	return free_storage;
+}
+
  static void bpf_selem_free_rcu(struct rcu_head *rcu)
  {
  	struct bpf_local_storage_elem *selem;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6f290623347e..60887c25504b 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -71,10 +71,8 @@ task_storage_lookup(struct task_struct *task, struct  
bpf_map *map,

  void bpf_task_storage_free(struct task_struct *task)
  {
-	struct bpf_local_storage_elem *selem;
  	struct bpf_local_storage *local_storage;
  	bool free_task_storage = false;
-	struct hlist_node *n;
  	unsigned long flags;

  	rcu_read_lock();
@@ -85,32 +83,13 @@ void bpf_task_storage_free(struct task_struct *task)
  		return;
  	}

-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
  	bpf_task_storage_lock();
  	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_task_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_task_storage = bpf_local_storage_unlink_nolock(local_storage);
  	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
  	bpf_task_storage_unlock();
  	rcu_read_unlock();

-	/* free_task_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
  	if (free_task_storage)
  		kfree_rcu(local_storage, rcu);
  }
