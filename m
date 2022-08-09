Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36658D17F
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 02:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbiHIAyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 20:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiHIAyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 20:54:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F95186D2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:54:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h138so8506351iof.12
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lwXfgBPDxQJGPxiLqU21+IAac7zBnXy5icoNCxIkrFg=;
        b=Qeu2T0lE9H+ht4b6zySxfx/Ml/8XMuq7HvjwVqaEcgQw5oal6J17w0r6cxWQJ6Hk6Y
         s7VVjs8Rfv8wsvFQ/xWh8HwHQLJdnU9a93IUJdPncNyg2qG9fPBIDGuIDjhY+lvRRhj4
         MuP95PtWK45LHIBbXy2f5c+t7K6/45KvE0TJAws3uYDTGsCRiTKXtzxTeU9jDfBi/eqd
         Em+VBXOLCugHTcTQAwz51ZBA0A5BuXpys0zh7lu9Tz9L3L2IyiOJV1AbIYvH2g97lfVL
         zkIabmaQqEV9QiWZB/jVjkC/LpxwSk70YN/Pe6tBtJuX2gJD+QQQt0HmZUDQ9TIQfo+1
         n91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lwXfgBPDxQJGPxiLqU21+IAac7zBnXy5icoNCxIkrFg=;
        b=OnONRSMldPAhA3aTai4/CSW5z62gKzqJBvwZql6Rw01LSAJVU/1a41gc2GXnLSroXi
         f/oynqxvSJ6XPu6lIe7BsTCl4G202bEo2ZSiCPElXk82H0uyPae2DGz1VdvS/XHfl9PN
         nzpi2wxkj76zWaceC6ZG0wC7fjsvPYwQB+JyKlswe96KXkeVqLZVf4mVWwn1moTaVSFo
         iaQvBFTcN0damqs7DGBPUmDe5KI6qHFsJDa5AfbvWTEtcOzmAlUH3SxpXo6AqzUW7ERy
         PvHNRGe3VNIBAolxmMBQScFGOX5mAJDiaxy/IFC+dhaWrHECy19zWdbNftQsxOWWvlzs
         b73w==
X-Gm-Message-State: ACgBeo36X4JgKvgDjwMudSZt/5KmZ+RJbsQ5I+Uml64MA89v7QqTVE6V
        61z3Uq8dHUadEI9m/SjMAkG8V6q5DLCh3bI422/PbwuG
X-Google-Smtp-Source: AA6agR5dkKKNVWzGWklprdP1qyb8nn5E24E7DP6BvGENsRtlXuL11kEUudH32IVhxWWtu+yA5P1XDbUSZ6dVybXxNsw=
X-Received: by 2002:a05:6638:3822:b0:342:a65d:ade3 with SMTP id
 i34-20020a056638382200b00342a65dade3mr9664195jav.206.1660006449939; Mon, 08
 Aug 2022 17:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com> <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
 <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com> <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
 <1052d7fa-3c36-6995-7455-1287fd8fab90@fb.com> <CAP01T77QGkJR=kvPuZ2eDtyF4UHiwq31+ixyfKQfedPBU06cZg@mail.gmail.com>
In-Reply-To: <CAP01T77QGkJR=kvPuZ2eDtyF4UHiwq31+ixyfKQfedPBU06cZg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 9 Aug 2022 02:53:34 +0200
Message-ID: <CAP01T76ACrgBfTU0bR1+z5oZYJFDY=0HXTOeHevjTN-4QCHsVg@mail.gmail.com>
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

On Tue, 9 Aug 2022 at 02:24, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Tue, 9 Aug 2022 at 01:23, Yonghong Song <yhs@fb.com> wrote:
> > On 8/8/22 11:55 AM, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, 8 Aug 2022 at 18:19, Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 8/8/22 4:18 AM, Kumar Kartikeya Dwivedi wrote:
> > >>> On Mon, 8 Aug 2022 at 08:09, Yonghong Song <yhs@fb.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 8/5/22 6:46 PM, Kumar Kartikeya Dwivedi wrote:
> > >>>>> The LRU map that is preallocated may have its elements reused while
> > >>>>> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> > >>>>> only check_and_free_fields is appropriate when the element is being
> > >>>>> deleted, as it ensures proper synchronization against concurrent access
> > >>>>> of the map value. After that, we cannot call check_and_init_map_value
> > >>>>> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> > >>>>> they can be concurrently accessed from a BPF program.
> > >>>>
> > >>>> If I understand correctly, one lru_node gets freed and pushed to free
> > >>>> list without doing check_and_free_fields().
> > >>>
> > >>> I don't think that's true, there is a check_and_free_fields call on
> > >>> deletion right before bpf_lru_push_free in htab_lru_push_free.
> > >>> Then once the preallocated items are freed on map destruction, we free
> > >>> timers and kptrs again, so if someone has access to preallocated items
> > >>> after freeing e.g. through an earlier lookup, we still release
> > >>> resources they may have created at the end of map's lifetime.
> > >>>
> > >>>> If later the same node is used with bpf_map_update_elem() and
> > >>>> prealloc_lru_pop() is called, then with this patch,
> > >>>> check_and_init_map_value() is not called, so the new node may contain
> > >>>> leftover values for kptr/timer/spin_lock, could this cause a problem?
> > >>>>
> > >>>
> > >>> This can only happen once you touch kptr/timer/spin_lock after
> > >>> deletion's check_and_free_fields call, but the program obtaining the
> > >>> new item will see and be able to handle that case. The timer helpers
> > >>> handle if an existing timer exists, kptr_xchg returns the old pointer
> > >>> as a reference you must release. For unreferenced kptr, it is marked
> > >>> as PTR_UNTRUSTED so a corrupted pointer value is possible but not
> > >>> fatal. If spin_lock is locked on lookup, then the other CPU having
> > >>> access to deleted-but-now-reallocated item will eventually call
> > >>> unlock.
> > >>
> > >> Thanks for explanation. Originally I think we should clear everything
> > >> including spin_lock before putting the deleted lru_node to free list.
> > >> check_and_free_fields() only did for kptr/timer but not spin_lock.
> > >>
> > >> But looks like we should not delete spin_lock before pushing the
> > >> deleted nodes to free list since lookup side may hold a reference
> > >> to the map value and it may have done a bpf_spin_lock() call.
> > >> And we should not clear spin_lock fields in check_and_free_fields()
> > >> and neither in prealloc_lru_pop() in map_update. Otherwise, we
> > >> may have issues for bpf_spin_unlock() on lookup side.
> > >>
> > >> It looks timer and kptr are already been handled for such
> > >> cases (concurrency between map_lookup() and clearing some map_value
> > >> fields for timer/kptr).
> > >>
> > >
> > > Yes, I also took a look again at other call sites of
> > > check_and_init_map_value and everything looks sane.
> >
> > Sounds good.
> >
> > >
> > >>>
> > >>> It is very much expected, IIUC, that someone else may use-after-free
> > >>> deleted items of hashtab.c maps in case of preallocation. It can be
> > >>> considered similar to how SLAB_TYPESAFE_BY_RCU behaves.
> > >>>
> > >>>> To address the above rewrite issue, maybe the solution should be
> > >>>> to push the deleted lru_nodes back to free list only after
> > >>>> rcu_read_unlock() is done?
> > >>>
> > >>> Please correct me if I'm wrong, but I don't think this is a good idea.
> > >>> Delaying preallocated item reuse for a RCU grace period will greatly
> > >>> increase the probability of running out of preallocated items under
> > >>> load, even though technically those items are free for use.
> > >>
> > >> Agree. This is not a good idea. It increased life cycle for preallocated
> > >> item reuse and will have some performance issue and resource consumption
> > >> issue.
> > >>
> > >>>
> > >>> Side note: I found the problem this patch fixes while reading the
> > >>> code, because I am running into this exact problem with my WIP skip
> > >>> list map implementation, where in the preallocated case, to make
> > >>> things a bit easier for the lockless lookup, I delay reuse of items
> > >>> until an RCU grace period passes (so that the deleted -> unlinked
> > >>> transition does not happen during traversal), but I'm easily able to
> > >>> come up with scenarios (producer/consumer situations) where that leads
> > >>> to exhaustion of the preallocated memory (and if not that, performance
> > >>> degradation on updates because pcpu_freelist now needs to search other
> > >>> CPU's caches more often).
> >
> > Thinking again. I guess the following scenario is possible:
> >
> >       rcu_read_lock()
> >          v = bpf_map_lookup_elem(&key);
> >          t1 = v->field;
> >          bpf_map_delete_elem(&key);
> >             /* another bpf program triggering bpf_map_update_elem() */
> >             /* the element with 'key' is reused */
> >             /* the value is updated */
> >          t2 = v->field;
> >          ...
> >       rcu_read_unlock()
> >
> > it is possible t1 and t2 may not be the same.
> > This should be an extremely corner case, not sure how to resolve
> > this easily without performance degradation.
>
> Yes, this is totally possible. This extreme corner case may also
> become a real problem in sleepable programs ;-).
>
> I had an idea in mind on how it can be done completely in the BPF
> program side without changing the map implementation.
>
> We can add a new tag that marks a field as direct access only, so it
> will be treated like kptr/timer/spin_lock during copy_map_value, and
> not touched on deletion or update (i.e. no reset on deletion, no init
> on update).
>
> Then, use a sequence counter field with this tag, and update it
> whenever performing a deletion or doing an update.
> On first update, this counter will be 0 (thanks to allocation being
> zeroed by default).
> On deletion side, it will be:
> v = lookup_elem(...);
> if (cmpxchg(&v->seq, v->seq, v->seq + 1))
>   delete_elem(...);
>
> No ABA problems as seq is ever increasing. Odd seq means item is in
> freelist, even means it is alive, on update it is incremented (but
> using a cmpxchg) to indicate item is back alive. So the cost is one
> lookup + cmpxchg on delete and update resp.
>
> On the reader side, the reader starts by loading the seq before doing
> read, and comparing the seq after its read (seqlock style).
>
> seq1 = v->seq;
> smp_rmb();
> // read data
> smp_rmb();
> seq2 = v->seq;
> if (seq1 != seq2 || seq1 & 1)
>   handle_bad_read();
>
> smp_rmb() is free on x86, but it can be generalized when we have a
> proper BPF memory model. Since seq is 'direct access only' field, it
> is preserved across alloc -> free -> alloc -> ....
>
> Maybe I missed some details so it might be incorrect somewhere, but
> the main idea is to do something similar to rechecking key/generation
> counter when items are reused in SLAB_TYPESAFE_BY_RCU, but also
> ensuring integrity of the data being read from map value at the same
> time. So if you want absolutely bullet proof reads and are willing to
> pay some cost for that, this should work.

This whole scheme is a bit complicated, but would be less costly for
readers. The other option that comes to mind is refcounting of map
elements, which is easier to implement and add support to the map
itself, but I don't know how appealing that is (and whether it really
fits in well with the current update/delete style helpers).
