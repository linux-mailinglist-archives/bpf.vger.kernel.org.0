Return-Path: <bpf+bounces-38557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C704496634E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03646B2329E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510DB1AD5CB;
	Fri, 30 Aug 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNtOm81v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1332206E;
	Fri, 30 Aug 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025538; cv=none; b=PC0efRyEp7ol6/LS4UOrqEc8V20mJAA/eWyzivvAGaiYTDJ9nmuiW3sCxem5i//2H9nVeJNfVKDA6oyCig6a4QIHfOuamts5GLWLwQv+u8TZ2i16C9xZ3kshHD+R3bIKBxlgVK8vhq1UMGfZQSD0vZ3Dw+DsDi4UYNtknVirDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025538; c=relaxed/simple;
	bh=8cyvDmBlLdyJ6zWWHWSbPYiq6VdvYJ7GLQPgGEAcEp8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq3jjCPIYYe48B3GoFsWthixkbs4b579RbgSQOHiiZCbnw6X7K0/simSzJJHnytWTuWIB9kyVvtFc3K9+NVsISF/qRMM0QlvWmTh9gYday0M01jb9pJ8qD4zZhIWrwCLJPaCFz8Ieiv+ueMaGF5Cjaa1/foQ81StFkOa9rgpaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNtOm81v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428101fa30aso16775405e9.3;
        Fri, 30 Aug 2024 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725025535; x=1725630335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvk5xj5HcQs8F8Y9lix/vFgo6lKGMY7Ot7HFz02xoSA=;
        b=HNtOm81vxujhdJZCIK37u4T0/LQWIAvin8mn9LTi2X/kqNFkD737LRk74sDpRPdinj
         lfLi9X+HPqq/T+7q2NazZsvCgsY7ZdzUvGfct3RF1aEBx1XQ5yOYiPOdKNRIzFGW/l8o
         Fuc4vFIh6NrgCg+dUpf5DUWswCoDaUtagChQTwZ8/DePxhqUxePPzPYWrxKIKkAoWn8k
         txc0mWSlpFh0i93AZwyGbDZ4oahf9rJm/OMD5KWNJAkyUeLJ/jvr9LITePrUMtTwnYw1
         QHyP3u4Bo44uEKbzBNGYwgnUHcsqTkKII/uWyvzYw6dLorz0TSOUtNZSnitQUmkk74xb
         2jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725025535; x=1725630335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvk5xj5HcQs8F8Y9lix/vFgo6lKGMY7Ot7HFz02xoSA=;
        b=srup60ozyiUIhfgECAyM1Zl0qrkXaL8GztxzLQtqKh2OvbxEB+/xXAIVFCjkOd5cX5
         D3TOPjmGb35Frbauw7pgepB4cate0Rz4k+PWY/wORZKUxoKwn4dqLOG4bXVwJNT6bqbl
         mmNrZVpR3aJvfM3a58nXPM1fxtnXrRGHlohjNL7792gSN/sakPrENjuwry2UzLREgbUX
         9xfZFs5iC3rDrJE0klfx9RciCU0zv4W4TToz5k0ppdcP5bv3wKd1Lo/6elyA/KrlWtHo
         bECrziAxx0NrqRCWmGh1w1TsRbsv2dQExPZclfXAGAo9ylbgN2ti3uVdh61TKqOcfjBa
         ic9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGUlvecXFIEJ8M+V5/tSBCcnC5AV1Xb49KTUqiiDDAjZf+2XPSAT/4bKzFFLovG4YzcbI=@vger.kernel.org, AJvYcCVhk6CpVieWYBPH6YXV8c4WxkrnmbAGALqp27aoMonDJb04Rr1QLKBFfKWJZdeHCUKH4jNqlXk9FiARN7ng@vger.kernel.org, AJvYcCVs/m2fH6CbHgHb9GEYwRqiNmPqYidA9KiGTss7jQv08djhOe7iVgAOZ/DinuUJMB2n1Hl4Nup3To83gn3p6Q9JWGal@vger.kernel.org
X-Gm-Message-State: AOJu0YxVV89/K+9FgrZmPhal+oEQYahbyIlss/IeZcPVm5n66VYoJL2e
	nyxaDIZTnp0X1kD+MouVpdhakQ9MhoVmYcEFkMcqfAUORxZ9Tf6Z
X-Google-Smtp-Source: AGHT+IG1irtMijjcjuapScPlFGSv1lbeL0zHht56vvPfbZLTQboZ7Hw3pgObdnFpA//+pSxOplLgVA==
X-Received: by 2002:a05:600c:4f8d:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-42bb27ba52fmr50700575e9.31.1725025534651;
        Fri, 30 Aug 2024 06:45:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df1066sm46736995e9.18.2024.08.30.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:45:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Aug 2024 15:45:32 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <ZtHM_C1NmDSKL0pi@krava>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>

On Thu, Aug 29, 2024 at 04:31:18PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 29, 2024 at 4:10 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 11:37:37AM -0700, Andrii Nakryiko wrote:
> > > uprobe->register_rwsem is one of a few big bottlenecks to scalability of
> > > uprobes, so we need to get rid of it to improve uprobe performance and
> > > multi-CPU scalability.
> > >
> > > First, we turn uprobe's consumer list to a typical doubly-linked list
> > > and utilize existing RCU-aware helpers for traversing such lists, as
> > > well as adding and removing elements from it.
> > >
> > > For entry uprobes we already have SRCU protection active since before
> > > uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> > > won't go away from under us, but we add SRCU protection around consumer
> > > list traversal.
> > >
> > > Lastly, to keep handler_chain()'s UPROBE_HANDLER_REMOVE handling simple,
> > > we remember whether any removal was requested during handler calls, but
> > > then we double-check the decision under a proper register_rwsem using
> > > consumers' filter callbacks. Handler removal is very rare, so this extra
> > > lock won't hurt performance, overall, but we also avoid the need for any
> > > extra protection (e.g., seqcount locks).
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/uprobes.h |   2 +-
> > >  kernel/events/uprobes.c | 104 +++++++++++++++++++++++-----------------
> > >  2 files changed, 62 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index 9cf0dce62e4c..29c935b0d504 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -35,7 +35,7 @@ struct uprobe_consumer {
> > >                               struct pt_regs *regs);
> > >       bool (*filter)(struct uprobe_consumer *self, struct mm_struct *mm);
> > >
> > > -     struct uprobe_consumer *next;
> > > +     struct list_head cons_node;
> > >  };
> > >
> > >  #ifdef CONFIG_UPROBES
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 8bdcdc6901b2..97e58d160647 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -59,7 +59,7 @@ struct uprobe {
> > >       struct rw_semaphore     register_rwsem;
> > >       struct rw_semaphore     consumer_rwsem;
> > >       struct list_head        pending_list;
> > > -     struct uprobe_consumer  *consumers;
> > > +     struct list_head        consumers;
> > >       struct inode            *inode;         /* Also hold a ref to inode */
> > >       struct rcu_head         rcu;
> > >       loff_t                  offset;
> > > @@ -783,6 +783,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> > >       uprobe->inode = inode;
> > >       uprobe->offset = offset;
> > >       uprobe->ref_ctr_offset = ref_ctr_offset;
> > > +     INIT_LIST_HEAD(&uprobe->consumers);
> > >       init_rwsem(&uprobe->register_rwsem);
> > >       init_rwsem(&uprobe->consumer_rwsem);
> > >       RB_CLEAR_NODE(&uprobe->rb_node);
> > > @@ -808,32 +809,19 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> > >  static void consumer_add(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > >  {
> > >       down_write(&uprobe->consumer_rwsem);
> > > -     uc->next = uprobe->consumers;
> > > -     uprobe->consumers = uc;
> > > +     list_add_rcu(&uc->cons_node, &uprobe->consumers);
> > >       up_write(&uprobe->consumer_rwsem);
> > >  }
> > >
> > >  /*
> > >   * For uprobe @uprobe, delete the consumer @uc.
> > > - * Return true if the @uc is deleted successfully
> > > - * or return false.
> > > + * Should never be called with consumer that's not part of @uprobe->consumers.
> > >   */
> > > -static bool consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > > +static void consumer_del(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > >  {
> > > -     struct uprobe_consumer **con;
> > > -     bool ret = false;
> > > -
> > >       down_write(&uprobe->consumer_rwsem);
> > > -     for (con = &uprobe->consumers; *con; con = &(*con)->next) {
> > > -             if (*con == uc) {
> > > -                     *con = uc->next;
> > > -                     ret = true;
> > > -                     break;
> > > -             }
> > > -     }
> > > +     list_del_rcu(&uc->cons_node);
> > >       up_write(&uprobe->consumer_rwsem);
> > > -
> > > -     return ret;
> > >  }
> > >
> > >  static int __copy_insn(struct address_space *mapping, struct file *filp,
> > > @@ -929,7 +917,8 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
> > >       bool ret = false;
> > >
> > >       down_read(&uprobe->consumer_rwsem);
> > > -     for (uc = uprobe->consumers; uc; uc = uc->next) {
> > > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > >               ret = consumer_filter(uc, mm);
> > >               if (ret)
> > >                       break;
> > > @@ -1125,18 +1114,29 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > >       int err;
> > >
> > >       down_write(&uprobe->register_rwsem);
> > > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > > -             err = -ENOENT;
> > > -     } else {
> > > -             err = register_for_each_vma(uprobe, NULL);
> > > -             /* TODO : cant unregister? schedule a worker thread */
> > > -             if (unlikely(err))
> > > -                     uprobe_warn(current, "unregister, leaking uprobe");
> > > -     }
> > > +     consumer_del(uprobe, uc);
> > > +     err = register_for_each_vma(uprobe, NULL);
> > >       up_write(&uprobe->register_rwsem);
> > >
> > > -     if (!err)
> > > -             put_uprobe(uprobe);
> > > +     /* TODO : cant unregister? schedule a worker thread */
> > > +     if (unlikely(err)) {
> > > +             uprobe_warn(current, "unregister, leaking uprobe");
> > > +             goto out_sync;
> > > +     }
> > > +
> > > +     put_uprobe(uprobe);
> > > +
> > > +out_sync:
> > > +     /*
> > > +      * Now that handler_chain() and handle_uretprobe_chain() iterate over
> > > +      * uprobe->consumers list under RCU protection without holding
> > > +      * uprobe->register_rwsem, we need to wait for RCU grace period to
> > > +      * make sure that we can't call into just unregistered
> > > +      * uprobe_consumer's callbacks anymore. If we don't do that, fast and
> > > +      * unlucky enough caller can free consumer's memory and cause
> > > +      * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
> > > +      */
> > > +     synchronize_srcu(&uprobes_srcu);
> > >  }
> > >  EXPORT_SYMBOL_GPL(uprobe_unregister);
> > >
> > > @@ -1214,13 +1214,20 @@ EXPORT_SYMBOL_GPL(uprobe_register);
> > >  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
> > >  {
> > >       struct uprobe_consumer *con;
> > > -     int ret = -ENOENT;
> > > +     int ret = -ENOENT, srcu_idx;
> > >
> > >       down_write(&uprobe->register_rwsem);
> > > -     for (con = uprobe->consumers; con && con != uc ; con = con->next)
> > > -             ;
> > > -     if (con)
> > > -             ret = register_for_each_vma(uprobe, add ? uc : NULL);
> > > +
> > > +     srcu_idx = srcu_read_lock(&uprobes_srcu);
> > > +     list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> > > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > > +             if (con == uc) {
> > > +                     ret = register_for_each_vma(uprobe, add ? uc : NULL);
> > > +                     break;
> > > +             }
> > > +     }
> > > +     srcu_read_unlock(&uprobes_srcu, srcu_idx);
> > > +
> > >       up_write(&uprobe->register_rwsem);
> > >
> > >       return ret;
> > > @@ -2085,10 +2092,12 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > >       struct uprobe_consumer *uc;
> > >       int remove = UPROBE_HANDLER_REMOVE;
> > >       bool need_prep = false; /* prepare return uprobe, when needed */
> > > +     bool has_consumers = false;
> > >
> > > -     down_read(&uprobe->register_rwsem);
> > >       current->utask->auprobe = &uprobe->arch;
> > > -     for (uc = uprobe->consumers; uc; uc = uc->next) {
> > > +
> > > +     list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > > +                              srcu_read_lock_held(&uprobes_srcu)) {
> > >               int rc = 0;
> > >
> > >               if (uc->handler) {
> > > @@ -2101,17 +2110,24 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > >                       need_prep = true;
> > >
> > >               remove &= rc;
> > > +             has_consumers = true;
> > >       }
> > >       current->utask->auprobe = NULL;
> > >
> > >       if (need_prep && !remove)
> > >               prepare_uretprobe(uprobe, regs); /* put bp at return */
> > >
> > > -     if (remove && uprobe->consumers) {
> > > -             WARN_ON(!uprobe_is_active(uprobe));
> > > -             unapply_uprobe(uprobe, current->mm);
> > > +     if (remove && has_consumers) {
> > > +             down_read(&uprobe->register_rwsem);
> > > +
> > > +             /* re-check that removal is still required, this time under lock */
> > > +             if (!filter_chain(uprobe, current->mm)) {
> >
> > sorry for late question, but I do not follow this change..
> >
> > at this point we got 1 as handler's return value from all the uprobe's consumers,
> > why do we need to call filter_chain in here.. IIUC this will likely skip over
> > the removal?
> >
> 
> Because we don't hold register_rwsem we are now racing with
> registration. So while we can get all consumers at the time we were
> iterating over the consumer list to request deletion, a parallel CPU
> can add another consumer that needs this uprobe+PID combination. So if
> we don't double-check, we are risking having a consumer that will not
> be triggered for the desired process.
> 
> Does it make sense? Given removal is rare, it's ok to take lock if we
> *suspect* removal, and then check authoritatively again under lock.

with this change the probe will not get removed in the attached test,
it'll get 2 hits, without this change just 1 hit

but I'm not sure it's a big problem, because seems like that's not the
intended way the removal should be used anyway, as explained by Oleg [1]

jirka


[1] https://lore.kernel.org/linux-trace-kernel/ZtHKTtn7sqaLeVxV@krava/T/#m07cdc37307cfd06f17f5755a067c9b300a19ee78

---
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index bf6ca8e3eb13..86d37a8e6169 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
+#include "uprobe_multi_removal.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 #include "../sdt.h"
@@ -687,6 +688,28 @@ static void test_bench_attach_usdt(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+static void test_removal(void)
+{
+	struct uprobe_multi_removal *skel = NULL;
+	int err;
+
+	skel = uprobe_multi_removal__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi_removal__open_and_load"))
+		return;
+
+	err = uprobe_multi_removal__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi_removal__attach"))
+		goto cleanup;
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_1();
+
+	ASSERT_EQ(skel->bss->test, 1, "test");
+
+cleanup:
+	uprobe_multi_removal__destroy(skel);
+}
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -703,4 +726,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_usdt();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("removal"))
+		test_removal();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_removal.c b/tools/testing/selftests/bpf/progs/uprobe_multi_removal.c
new file mode 100644
index 000000000000..0a948cc1e05b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_removal.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+int test;
+
+SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_1")
+int uprobe(struct pt_regs *ctx)
+{
+	test++;
+	return 1;
+}

