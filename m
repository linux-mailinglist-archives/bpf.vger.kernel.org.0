Return-Path: <bpf+bounces-44126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59169BE6BE
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 13:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5627B1F27BC4
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1151E0083;
	Wed,  6 Nov 2024 12:03:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB31DF729;
	Wed,  6 Nov 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894621; cv=none; b=HA/o/HNK24AL2wGJUv+BvqAAylddFl5qsiPmIst8nEYKf0VR0sdIXy0B+Ogjktff8Wk/lN8AIUa2nxbt3shusmNfALU2Fi70MJTlnP1oK1k+Jjah0yiyfHBQZhe65cdX4SdDKv5uv8yv35iLM6ZM32zGdrVUCC1IQHBbSypwbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894621; c=relaxed/simple;
	bh=1u9uJe0U72U2UBDcBDMBh9WyxwRnpqCGuTrm9v/jNAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUJMuIIxCtRS5Mv77+l7sa1nh/DsMfJUEkRcyCq/KRzfys2yHOX8rwSVh/WvJNTXkgR2ySF3nzYXoOYMAWFlR960jz4PnfBFZGUyzgsrMSMYNWcSl6Ena3x/tl/eCGhJ9/fNghq1MJPtJ8JOCTDvrn2V+ann2g+x3nyYbHHFS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso4717356a12.1;
        Wed, 06 Nov 2024 04:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894618; x=1731499418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAdKCHu4KzxDCkkQKBDhoW2UK3wGCXxAFsKHJYg1LAI=;
        b=eNvG87DxnChdVtWAzEOdN6XDlnGvtp3vwRQaJrQCAQgHOnGrdGV6zlcad9n+EBgFXO
         cr1oNGmruixLHGM2y9DS+9DEeGxmtJZWo7FHGIscFBgHojcVGr5n9qM2Owyjl7Sn0QJl
         n9oyy36eXSpPC6A7ytbb3UgNmfF6Ffjt1ZMYKDCKRWvpEqWFAsirUiWQ+3tpoaxNICr6
         TNJ63KP7s1gNobGJ9dRs1T/EFWsIiKjjXwDcCPzZTQZFij+I0nH2JlV3znBTeieoCIJw
         6Loqy1iwJTrJCycFUn41H1E/olcS5bavQUIY1blbRlFM6gV+PSOiMqsH0077raQfFZwu
         PJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+gI+HOC/WnObfnUMuaFsPEvw8XA2ec1P9PwugKn6HsnxNagXj/ll3NakcUE4TRqWvWO4dhp7Z8WmipRO@vger.kernel.org, AJvYcCWn9w+ARPW81u2Q9DDWSKjl7l310Jw9Xv8VwL9nJv+nbbZhrYGawmkkbpAqK/yJubtINCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBn4AT0QyO41B7NBqW3rvztXbsoVyAp/vCXUYLPfSiww4OELpx
	mWzI3Z3RCyoEhvvXXz0xMV2mO/Tduo0bAVW5rkFcicygxeosLnEB
X-Google-Smtp-Source: AGHT+IGzKy/R2dqbY68xlQLh8qj6KcnlqGVzvzo5n76OGX3XV31gMGmie4AvwvKPTMNWMeaxOfq1Aw==
X-Received: by 2002:a05:6402:2187:b0:5cb:6718:7326 with SMTP id 4fb4d7f45d1cf-5cd54a958f5mr18094994a12.21.1730894617844;
        Wed, 06 Nov 2024 04:03:37 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6aafc8dsm2713695a12.24.2024.11.06.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:03:37 -0800 (PST)
Date: Wed, 6 Nov 2024 04:03:34 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <20241106-transparent-athletic-ammonite-586af8@leitao>
References: <20240903174603.3554182-1-andrii@kernel.org>
 <20240903174603.3554182-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903174603.3554182-5-andrii@kernel.org>

Hello Andrii,

On Tue, Sep 03, 2024 at 10:45:59AM -0700, Andrii Nakryiko wrote:
> uprobe->register_rwsem is one of a few big bottlenecks to scalability of
> uprobes, so we need to get rid of it to improve uprobe performance and
> multi-CPU scalability.
> 
> First, we turn uprobe's consumer list to a typical doubly-linked list
> and utilize existing RCU-aware helpers for traversing such lists, as
> well as adding and removing elements from it.
> 
> For entry uprobes we already have SRCU protection active since before
> uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> won't go away from under us, but we add SRCU protection around consumer
> list traversal.

I am seeing the following message in a kernel with RCU_PROVE_LOCKING:

	kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!

It seems the SRCU is not held, when coming from mmap_region ->
uprobe_mmap. Here is the message I got in my debug kernel. (sorry for
not decoding it, but, the stack trace is clear enough).

         WARNING: suspicious RCU usage
           6.12.0-rc5-kbuilder-01152-gc688a96c432e #26 Tainted: G        W   E    N
           -----------------------------
           kernel/events/uprobes.c:938 RCU-list traversed without holding the required lock!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
           3 locks held by env/441330:
            #0: ffff00021c1bc508 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x84/0x1d0
            #1: ffff800089f3ab48 (&uprobes_mmap_mutex[i]){+.+.}-{3:3}, at: uprobe_mmap+0x20c/0x548
            #2: ffff0004e564c528 (&uprobe->consumer_rwsem){++++}-{3:3}, at: filter_chain+0x30/0xe8

stack backtrace:
           CPU: 4 UID: 34133 PID: 441330 Comm: env Kdump: loaded Tainted: G        W   E    N 6.12.0-rc5-kbuilder-01152-gc688a96c432e #26
           Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
           Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22 07/03/2024
           Call trace:
            dump_backtrace+0x10c/0x198
            show_stack+0x24/0x38
            __dump_stack+0x28/0x38
            dump_stack_lvl+0x74/0xa8
            dump_stack+0x18/0x28
            lockdep_rcu_suspicious+0x178/0x2c8
            filter_chain+0xdc/0xe8
            uprobe_mmap+0x2e0/0x548
            mmap_region+0x510/0x988
            do_mmap+0x444/0x528
            vm_mmap_pgoff+0xf8/0x1d0
            ksys_mmap_pgoff+0x184/0x2d8


That said, it seems we want to hold the SRCU, before reaching the
filter_chain(). I hacked a bit, and adding the lock in uprobe_mmap()
solves the problem, but, I might be missing something, since I am not familiar
with this code.

How does the following patch look like?

commit 1bd7bcf03031ceca86fdddd8be2e5500497db29f
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Nov 4 06:53:31 2024 -0800

    uprobes: Get SRCU lock before traverseing the list

    list_for_each_entry_srcu() is being called without holding the lock,
    which causes LOCKDEP (when enabled with RCU_PROVING) to complain such
    as:

            kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!

    Get the SRCU uprobes_srcu lock before calling filter_chain(), which
    needs to have the SRCU lock hold, since it is going to call
    list_for_each_entry_srcu().

    Signed-off-by: Breno Leitao <leitao@debian.org>
    Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4b52cb2ae6d62..cc9d4ddeea9a6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1391,6 +1391,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 	struct list_head tmp_list;
 	struct uprobe *uprobe, *u;
 	struct inode *inode;
+	int srcu_idx;

 	if (no_uprobe_events())
 		return 0;
@@ -1409,6 +1410,7 @@ int uprobe_mmap(struct vm_area_struct *vma)

 	mutex_lock(uprobes_mmap_hash(inode));
 	build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_list);
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
 	/*
 	 * We can race with uprobe_unregister(), this uprobe can be already
 	 * removed. But in this case filter_chain() must return false, all
@@ -1422,6 +1424,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		}
 		put_uprobe(uprobe);
 	}
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 	mutex_unlock(uprobes_mmap_hash(inode));

 	return 0;


