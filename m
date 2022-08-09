Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8558D300
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 06:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHIEni (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 00:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIEnh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 00:43:37 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7701D0C2
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 21:43:36 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g14so5942251ile.11
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AIKyVTyOHg6mQm71fxgKYRP1CctBkniBhdMdSsLAjeE=;
        b=T2R/QPn+f14ZUGAjzbwM+PQan/ZYWix8FwZjDYymJ3z+SsEU6W23nze8HTDErnmLeZ
         MuTjMowoHAQrSaXiyu2Zi+/eqrzXcAeUoKfae9Orq3RsrAn9orfgl/9mp4ighq8jQkIA
         xxLZHsGggfhj5OVTdoFmfjIV/yJSkgs77ho1ApOnQY5HU7QibLeTJCrZm0G1EO3WyBWO
         FkoYFx2gfzRFxhx1kt1QZpsYlgZoIEYSAu4kbvwmYZM+BCzTUo1omgHyOPEbGK5v7mRL
         iRFqSWdajhvRQ9PpamdNegclcvPVXSQyImSZPa/1+HLE8E/0ZYTswJqSKjVAt+Oj6Jtz
         UGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AIKyVTyOHg6mQm71fxgKYRP1CctBkniBhdMdSsLAjeE=;
        b=Km348Hq2+f1ePfL3IStjsEq1A2aqwW6PqC98wpRMut5uo/0FicOmuq13z+PP8MKDkR
         Xp/hvvkrlVx210Nt+fFDCFo+QIV4TEd9Loi8xQV/lJHUahHMN0eoYl2eDgtH8mXxIpIK
         7NyuamMUfM0rLWSLlf5o9R80KEkXHQzf7O9bhgHu+yL5tCtDLJSnd7g+o8GYUpdObqd3
         YIXTbrjiFWCY2HORI1RGzFSldUzt0dwWUDYVHECstfsnljAFqxIuixOnqm7gdB98iNWp
         sOPtWwn01a/AbEqW4avmtuPY2WRONSL88FalqvrrURhpeZAri2lnUDdqFrOJk9NFR+5X
         Mgrw==
X-Gm-Message-State: ACgBeo3wIG1PPlUWUb615jkxMbiUOlskwzXNSZYDvdHt5u+HdSf3AA9g
        q1fhHCYQHE63WCWQy6dMJu8QoED/+7exbsWenYo=
X-Google-Smtp-Source: AA6agR7EbsfAb/Y9mGcpXDZovRfDePULw12rc4DJZy11kKGOmGoGyo2SQDfIjXr7w0eJQbc7L6M3aiNnWKCNZHqHNwM=
X-Received: by 2002:a05:6e02:218c:b0:2e0:c966:a39d with SMTP id
 j12-20020a056e02218c00b002e0c966a39dmr5304402ila.216.1660020216063; Mon, 08
 Aug 2022 21:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com> <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
 <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com> <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
 <1052d7fa-3c36-6995-7455-1287fd8fab90@fb.com> <CAP01T77QGkJR=kvPuZ2eDtyF4UHiwq31+ixyfKQfedPBU06cZg@mail.gmail.com>
 <CAADnVQKBxv30_tBCiD8RwSyeNcgQb-qTpmYLfPXp3VLN-omM=g@mail.gmail.com>
In-Reply-To: <CAADnVQKBxv30_tBCiD8RwSyeNcgQb-qTpmYLfPXp3VLN-omM=g@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 9 Aug 2022 06:42:58 +0200
Message-ID: <CAP01T75iQ-auDUmb0bRJ6kztpRPwP2Y=Jcg3NNuqq=NLwHqkRA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Tue, 9 Aug 2022 at 05:18, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 8, 2022 at 5:25 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > Thinking again. I guess the following scenario is possible:
> > >
> > >       rcu_read_lock()
> > >          v = bpf_map_lookup_elem(&key);
> > >          t1 = v->field;
> > >          bpf_map_delete_elem(&key);
> > >             /* another bpf program triggering bpf_map_update_elem() */
> > >             /* the element with 'key' is reused */
> > >             /* the value is updated */
> > >          t2 = v->field;
> > >          ...
> > >       rcu_read_unlock()
> > >
> > > it is possible t1 and t2 may not be the same.
> > > This should be an extremely corner case, not sure how to resolve
> > > this easily without performance degradation.
> >
> > Yes, this is totally possible. This extreme corner case may also
> > become a real problem in sleepable programs ;-).
> >
> > I had an idea in mind on how it can be done completely in the BPF
> > program side without changing the map implementation.
>
> +1 it's best to address it inside the program instead
> of complicating and likely slowing down maps.
>
> As far as sleepable progs.. the issue is not present
> because sleepable progs are only allowed to use preallocated maps.

The problem being discussed in this thread is exactly with
preallocated maps, so I do think the issue is present with sleepable
progs. I.e. it can do a lookup, and go to sleep (implicitly or
explicitly), and then find the element has already been reused (i.e.
the window is wider so it is more likely). It's not a smart thing to
do ofcourse, but my point was that compared to the non-sleepable case
it won't be a corner case anymore that you might not hit very often.

> In non-prealloc maps free_htab_elem() would just call_rcu()
> and the element would be freed into the global slab which
> will be bad if bpf prog is doing something like above.
>
> Doing call_rcu_tasks_trace() + call_rcu() would allow
> non-prealloc in sleepable, but it doesn't scale
> and non-prealloc is already many times slower comparing
> to prealloc due to atomic_inc/dec and call_rcu.

Exactly, which means the element will be readily reused in the
sleepable case since it only uses preallocated maps, which takes us
back to the problem above.

>
> With new bpf_mem_alloc I'm experimenting with batching
> of call_rcu_tasks_trace + call_rcu, so hash map can be
> dynamically allocated, just as fast as full prealloc and
> finally safe in both sleepable and traditional progs.
> I was thinking of adding a new SLAB_TYPESAFE_BY_RCU_TASKS_TRACE
> flag to the slab, but decided to go that route only if
> batching of call_rcu*() won't be sufficient.

Interesting stuff, looking forward to it!

> Sorry it takes so long to get the patches ready.
> Summer in WA is the best time to take vacation :)
> I've been taking plenty.

Well, I think this thread was just me and Yonghong contemplating other
possible fixes to the original bug, so there's no rush, enjoy
yourself! :).
