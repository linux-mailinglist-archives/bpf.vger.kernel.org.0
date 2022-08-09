Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432458D253
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 05:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHIDSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 23:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHIDSw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 23:18:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB891E3E9
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 20:18:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j8so19986633ejx.9
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7CLP/LbkSmdSEeoQMhy2dh4wDa/igezNugIuBOVJh4=;
        b=jk8lzsusB4jtJ4DaPAPVZiLyLzvq/K44H8a+bmUDytFco117UtZq/X+PNhE9NZwcfA
         nnnlnxugsjyJ8Wi33aqQQJ/H7pSHgcgZRyutpB5Gqi2LLy51t1M/vN5L1EZVJjnzZz3K
         ost1uIBzn/rlD5FRISS7vyGSDXco2ewUBflecRMJorB15zGjjfuR08BF5sUZjEyXB1NR
         8JESjlqP0PMg2gZuXCJJfx/OttvUYEN1lV/R1kpsaqYH/H26BvgOtDG+f4ZZ2QbACLKj
         7dea/ms0Ikkj5HjqeYS9mmzlwO63m++dAoXrUrc3QzS+M/TeB9SyDU2Cf3KOMrMHT8yk
         SlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7CLP/LbkSmdSEeoQMhy2dh4wDa/igezNugIuBOVJh4=;
        b=Kr4UuHcSqQ+o78of/7rHXeB27YQu0RGmzzpksW0qgXDPJsP9DUJPeRXGeScS32QGtW
         YDG4jPU1kbGrJOL/rbyZJUcdgEKo3vJKjhs+SL1xk2kiMLg/iqSuHGZm3QEmJGOla6YT
         gIXVbjbslsDdas+z8lnyloqUDMFnNXDtEpww/xeupRiJEFKZ/hvxQHS9iDnoXkxIT03M
         n5lRVU6hJnBD2dPpkGb0j0k7bns78muuXg8ZbgcF49+5WL00TwrOVs2hJYa5BF4ut8J9
         fPJdoFeJjCRZ1/tOpw9Fa02w2WOWPSZMDXXrqkdQXg4ZDafHtUA2HhsO04SXhAwnp0XA
         kxLA==
X-Gm-Message-State: ACgBeo0NmUY8Qk3oGIPdeQpvznG2wu5P16owZVGAO7cff0LSe/5iVGFz
        snSG/HzfH1scJaPL2wVtYvoEf7u8iuncpsPefIYyIRXHMjU=
X-Google-Smtp-Source: AA6agR4yT+v6e4ZnJVeGkXyPXOEUcCm2WToKVMtDDYuXVMfWlO5J9cD+8tO8/AmbjpejMXcuwT6GFLSVnjzvs+X5VIg=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr16199235ejc.502.1660015128678; Mon, 08
 Aug 2022 20:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-3-memxor@gmail.com>
 <fcd4ad34-8abe-d156-f1ff-d2f752748e5b@fb.com> <CAP01T76kSupCeSvPDFX=5R24DkMvjD_iNnScqGy9eofZE=f2Mw@mail.gmail.com>
 <334f055b-4b44-f1d1-3770-b5c4ffe61913@fb.com> <CAP01T76W95FnsT26L=f6ErVWvjkxMg92o-XLGqP9zbHLEG1yvw@mail.gmail.com>
 <1052d7fa-3c36-6995-7455-1287fd8fab90@fb.com> <CAP01T77QGkJR=kvPuZ2eDtyF4UHiwq31+ixyfKQfedPBU06cZg@mail.gmail.com>
In-Reply-To: <CAP01T77QGkJR=kvPuZ2eDtyF4UHiwq31+ixyfKQfedPBU06cZg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 8 Aug 2022 20:18:37 -0700
Message-ID: <CAADnVQKBxv30_tBCiD8RwSyeNcgQb-qTpmYLfPXp3VLN-omM=g@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Mon, Aug 8, 2022 at 5:25 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
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

+1 it's best to address it inside the program instead
of complicating and likely slowing down maps.

As far as sleepable progs.. the issue is not present
because sleepable progs are only allowed to use preallocated maps.
In non-prealloc maps free_htab_elem() would just call_rcu()
and the element would be freed into the global slab which
will be bad if bpf prog is doing something like above.

Doing call_rcu_tasks_trace() + call_rcu() would allow
non-prealloc in sleepable, but it doesn't scale
and non-prealloc is already many times slower comparing
to prealloc due to atomic_inc/dec and call_rcu.

With new bpf_mem_alloc I'm experimenting with batching
of call_rcu_tasks_trace + call_rcu, so hash map can be
dynamically allocated, just as fast as full prealloc and
finally safe in both sleepable and traditional progs.
I was thinking of adding a new SLAB_TYPESAFE_BY_RCU_TASKS_TRACE
flag to the slab, but decided to go that route only if
batching of call_rcu*() won't be sufficient.
Sorry it takes so long to get the patches ready.
Summer in WA is the best time to take vacation :)
I've been taking plenty.
