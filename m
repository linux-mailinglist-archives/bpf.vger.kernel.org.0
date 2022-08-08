Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D458C76A
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiHHLTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHHLTT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 07:19:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9612DF31
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 04:19:17 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d187so50143iof.4
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FH5b+bhnE5BtqBeoGYY46+lsGSvFs1DB5NX9/YfyxNI=;
        b=EkeO3ZzGf2+S+5XtakovsgeqLBEckV4vBFY8W5nRL8ggNHwrIvDFmexO/b1v4BqaKr
         NhPCI9OoK6m0H+twcWFQ7pzhjswqWAz200y9OWG/f2K1bzyU2tjAcqshtiDbENjeg8oe
         yXzpL20uP+hRw/rJtV8jvYUZuH9cCSbxbc1kEqTgkTZhZVw8pDDOKGO/2s7SkUQZl73F
         WTbbaDcChbfBPSHaU35adz2h0F0MrHykZhnKgnKuvYhnYmJPMHRkqDA3Xmq0EhdR0IQe
         8Di7Ci+pVf0cMdEyePkiUKQUXyjFbCgMFvMPb/s4Vwyhrt1tsUMeNYCbks0xbgctrpN7
         YDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FH5b+bhnE5BtqBeoGYY46+lsGSvFs1DB5NX9/YfyxNI=;
        b=y6slVA/Q5ZeQl8jrVXMweH+yUko+0AP4CTAMmcHkHs89TowO9GMMNHhItHdKncbrpR
         ClgXJwKC9GpTxBF0KU1qHMwowHBy6q7ezrEo6iZ1KDwgTkpiYJfjfc6bFOuklip4ozqG
         o7JvPGxrD5WSj+RBavNyOio7XoeCuA6xTHYfSiZ3EqN0Tb3sn+wOVH0catp7Aa/u72RR
         maEzmtqIDs6p0cU8ouQ/dHfmi9w1jS7q48xxigkbBgebCbZ4YHtTSd71vcY28Yxemsgq
         qOxx72NFLRWwbvjzhkwdyeiVeuYLpqDjOMLkNQIHt1Bz5+Ls/5lZxlAYXm+qkgHDLj8U
         aQ2Q==
X-Gm-Message-State: ACgBeo1aLYWAM5XkQ0fobQBQ1QHnBAXLQAkLhPpOOOToOKgSJqSY6ihE
        l96b3r2gIx4qEbv1JzEb0pEAtzOHtGWWEeFQ5/K3gQv4
X-Google-Smtp-Source: AA6agR4Hkw5lklm+Z0D0MndI0XJ52gZiyjUE2uH4DFUE5cuf6bHqUoz2XTGuRO4JC8t2ao3VbN8HpZnwRrnBX3IqkS0=
X-Received: by 2002:a6b:c582:0:b0:67c:b3dc:54bd with SMTP id
 v124-20020a6bc582000000b0067cb3dc54bdmr6907376iof.62.1659957556881; Mon, 08
 Aug 2022 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com>
In-Reply-To: <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 8 Aug 2022 13:18:38 +0200
Message-ID: <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "toke@redhat.com" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 8 Aug 2022 at 08:09, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
> > The LRU map that is preallocated may have its elements reused while
> > another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> > only check_and_free_fields is appropriate when the element is being
> > deleted, as it ensures proper synchronization against concurrent access
> > of the map value. After that, we cannot call check_and_init_map_value
> > again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> > they can be concurrently accessed from a BPF program.
>
> If I understand correctly, one lru_node gets freed and pushed to free
> list without doing check_and_free_fields().

I don't think that's true, there is a check_and_free_fields call on
deletion right before bpf_lru_push_free in htab_lru_push_free.
Then once the preallocated items are freed on map destruction, we free
timers and kptrs again, so if someone has access to preallocated items
after freeing e.g. through an earlier lookup, we still release
resources they may have created at the end of map's lifetime.

> If later the same node is used with bpf_map_update_elem() and
> prealloc_lru_pop() is called, then with this patch,
> check_and_init_map_value() is not called, so the new node may contain
> leftover values for kptr/timer/spin_lock, could this cause a problem?
>

This can only happen once you touch kptr/timer/spin_lock after
deletion's check_and_free_fields call, but the program obtaining the
new item will see and be able to handle that case. The timer helpers
handle if an existing timer exists, kptr_xchg returns the old pointer
as a reference you must release. For unreferenced kptr, it is marked
as PTR_UNTRUSTED so a corrupted pointer value is possible but not
fatal. If spin_lock is locked on lookup, then the other CPU having
access to deleted-but-now-reallocated item will eventually call
unlock.

It is very much expected, IIUC, that someone else may use-after-free
deleted items of hashtab.c maps in case of preallocation. It can be
considered similar to how SLAB_TYPESAFE_BY_RCU behaves.

> To address the above rewrite issue, maybe the solution should be
> to push the deleted lru_nodes back to free list only after
> rcu_read_unlock() is done?

Please correct me if I'm wrong, but I don't think this is a good idea.
Delaying preallocated item reuse for a RCU grace period will greatly
increase the probability of running out of preallocated items under
load, even though technically those items are free for use.

Side note: I found the problem this patch fixes while reading the
code, because I am running into this exact problem with my WIP skip
list map implementation, where in the preallocated case, to make
things a bit easier for the lockless lookup, I delay reuse of items
until an RCU grace period passes (so that the deleted -> unlinked
transition does not happen during traversal), but I'm easily able to
come up with scenarios (producer/consumer situations) where that leads
to exhaustion of the preallocated memory (and if not that, performance
degradation on updates because pcpu_freelist now needs to search other
CPU's caches more often).

BTW, this would be fixed if we could simply use Alexei's per-CPU cache
based memory allocator instead of preallocating items, because then
the per-CPU cache gets replenished when it goes below the watermark
(and also frees stuff back to kernel allocator above the high
watermark, which is great for producer/consumer cases with alloc/free
imbalance), so we can do the RCU delays similar to kmalloc case
without running into the memory exhaustion problem.

>
> >
> > Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   kernel/bpf/hashtab.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index da7578426a46..4d793a92301b 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -311,12 +311,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
> >       struct htab_elem *l;
> >
> >       if (node) {
> > -             u32 key_size = htab->map.key_size;
> > -
> >               l = container_of(node, struct htab_elem, lru_node);
> > -             memcpy(l->key, key, key_size);
> > -             check_and_init_map_value(&htab->map,
> > -                                      l->key + round_up(key_size, 8));
> > +             memcpy(l->key, key, htab->map.key_size);
> >               return l;
> >       }
> >
