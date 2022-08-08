Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F958CE19
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiHHS4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiHHS4W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 14:56:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3221834B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 11:56:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o14so5366628ilt.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X6wWckFSd/llvt+xf8wcCctfIJ2Cn74UQyep6/D0Pu4=;
        b=F9Rh8pZYT7Be6HxfwO81aB9NkU/8K5LDK8lhYwUAEaUho3Agx9OmCQ7l7b7BamcMMi
         iVSif3uR9sn1VwrV9C5a6cK0i8z6ZGhjGPb50A6ZCmonzBHF9ZXv6gMdeGaDkGtW9wst
         6njqTQY29GUSTchWI58csB5v3ImMKK1P1fDbpYvvgz4EFnTUdEIyKlkTRslQlkLK0dOH
         DRbtbKSFlxd2BruA1WhvxYw2uFAPNJ03M2qm+lZdZJmwzPzeVGgZ2RkMna5++VnjG5vn
         ZYMhVa040GyLLvixZvfFSinhQLRd0ku8geBg23U+diqUcTR9YeT1sP8kXmji5hnLjLL7
         Kfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X6wWckFSd/llvt+xf8wcCctfIJ2Cn74UQyep6/D0Pu4=;
        b=1vlXIUc9ywZ2AkbB1X5LCBD96mtvAPldR7ZnK5Lm6pmK2jSd41wB3x1S26Xuk7IPQ0
         pRmWcnO5/NxRl7OHvBbwrgOdZ8/7g7smqUonmwSLJhjVtwTXaTr1rqvzOOdIsa434gLD
         4viodcTwdySbffEYgqfNad6GobgNC2/yqwB2DgSqY6tKBZApdeGordGxZ4+O4jPHi2ck
         C8h4O/+xnX7kvdB3l4lyILLAvNKDAhKrvKFyqmJMpx80G2aFM8csRBpZP3G0dKJhcGbb
         0rw/JgBjr2xQh0hfbaX+zfCgaVRgQMyg+kxRPaB9JLPhoQK5BLmCxR5qnRzjun2tfLHs
         MZxQ==
X-Gm-Message-State: ACgBeo2nZWlltoyWBaE/AKyxt2xuzDgdNvijVTbQtzpotEUOqMuDkw1j
        sxJ1Fk4psMzb07bMURFRttta1hj8Y28bRQx6DDpCzWVt
X-Google-Smtp-Source: AA6agR7aEk7sfiLn0GxIvIcLT/6t5UYQOmI7f6OleMaTT7Dtc6S9FN5y1bmkYq7PuEi+l2ypK2QLzvil2TNeCBXX3S4=
X-Received: by 2002:a05:6e02:218c:b0:2e0:c966:a39d with SMTP id
 j12-20020a056e02218c00b002e0c966a39dmr4521045ila.216.1659984980666; Mon, 08
 Aug 2022 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com> <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
 <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com>
In-Reply-To: <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 8 Aug 2022 20:55:26 +0200
Message-ID: <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
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

On Mon, 8 Aug 2022 at 18:19, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/8/22 4:18 AM, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 8 Aug 2022 at 08:09, Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
> >>> The LRU map that is preallocated may have its elements reused while
> >>> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> >>> only check_and_free_fields is appropriate when the element is being
> >>> deleted, as it ensures proper synchronization against concurrent access
> >>> of the map value. After that, we cannot call check_and_init_map_value
> >>> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> >>> they can be concurrently accessed from a BPF program.
> >>
> >> If I understand correctly, one lru_node gets freed and pushed to free
> >> list without doing check_and_free_fields().
> >
> > I don't think that's true, there is a check_and_free_fields call on
> > deletion right before bpf_lru_push_free in htab_lru_push_free.
> > Then once the preallocated items are freed on map destruction, we free
> > timers and kptrs again, so if someone has access to preallocated items
> > after freeing e.g. through an earlier lookup, we still release
> > resources they may have created at the end of map's lifetime.
> >
> >> If later the same node is used with bpf_map_update_elem() and
> >> prealloc_lru_pop() is called, then with this patch,
> >> check_and_init_map_value() is not called, so the new node may contain
> >> leftover values for kptr/timer/spin_lock, could this cause a problem?
> >>
> >
> > This can only happen once you touch kptr/timer/spin_lock after
> > deletion's check_and_free_fields call, but the program obtaining the
> > new item will see and be able to handle that case. The timer helpers
> > handle if an existing timer exists, kptr_xchg returns the old pointer
> > as a reference you must release. For unreferenced kptr, it is marked
> > as PTR_UNTRUSTED so a corrupted pointer value is possible but not
> > fatal. If spin_lock is locked on lookup, then the other CPU having
> > access to deleted-but-now-reallocated item will eventually call
> > unlock.
>
> Thanks for explanation. Originally I think we should clear everything
> including spin_lock before putting the deleted lru_node to free list.
> check_and_free_fields() only did for kptr/timer but not spin_lock.
>
> But looks like we should not delete spin_lock before pushing the
> deleted nodes to free list since lookup side may hold a reference
> to the map value and it may have done a bpf_spin_lock() call.
> And we should not clear spin_lock fields in check_and_free_fields()
> and neither in prealloc_lru_pop() in map_update. Otherwise, we
> may have issues for bpf_spin_unlock() on lookup side.
>
> It looks timer and kptr are already been handled for such
> cases (concurrency between map_lookup() and clearing some map_value
> fields for timer/kptr).
>

Yes, I also took a look again at other call sites of
check_and_init_map_value and everything looks sane.

> >
> > It is very much expected, IIUC, that someone else may use-after-free
> > deleted items of hashtab.c maps in case of preallocation. It can be
> > considered similar to how SLAB_TYPESAFE_BY_RCU behaves.
> >
> >> To address the above rewrite issue, maybe the solution should be
> >> to push the deleted lru_nodes back to free list only after
> >> rcu_read_unlock() is done?
> >
> > Please correct me if I'm wrong, but I don't think this is a good idea.
> > Delaying preallocated item reuse for a RCU grace period will greatly
> > increase the probability of running out of preallocated items under
> > load, even though technically those items are free for use.
>
> Agree. This is not a good idea. It increased life cycle for preallocated
> item reuse and will have some performance issue and resource consumption
> issue.
>
> >
> > Side note: I found the problem this patch fixes while reading the
> > code, because I am running into this exact problem with my WIP skip
> > list map implementation, where in the preallocated case, to make
> > things a bit easier for the lockless lookup, I delay reuse of items
> > until an RCU grace period passes (so that the deleted -> unlinked
> > transition does not happen during traversal), but I'm easily able to
> > come up with scenarios (producer/consumer situations) where that leads
> > to exhaustion of the preallocated memory (and if not that, performance
> > degradation on updates because pcpu_freelist now needs to search other
> > CPU's caches more often).
> >
> > BTW, this would be fixed if we could simply use Alexei's per-CPU cache
> > based memory allocator instead of preallocating items, because then
> > the per-CPU cache gets replenished when it goes below the watermark
> > (and also frees stuff back to kernel allocator above the high
> > watermark, which is great for producer/consumer cases with alloc/free
> > imbalance), so we can do the RCU delays similar to kmalloc case
> > without running into the memory exhaustion problem.
>
> Thanks for explanation. So okay the patch looks good to me.
>
> >
> >>
> >>>
> >>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
> >>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>
>

Thanks! I'll summarize our discussion in short and add it to the commit log.
