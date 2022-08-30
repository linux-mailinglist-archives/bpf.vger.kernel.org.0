Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1D5A585B
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH3ARy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiH3ARt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:17:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9277FFB5
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:17:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c4so8005865iof.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZWtypKVtYkfGDCvY0igETJTEM6IuiTNSBlreJ7oLMfA=;
        b=KrefOdKA3zTyTrMQ9Sd0LH5L4bS8nRCuMKQ3BsBwtqoRJGYfXrrssQnLQoFg9ix3jE
         n4RqejJxdHUox36LC84mt7nHQXpxtZ32dM+OaF2TI51IHibeXcgTJgO+jxtvzvLVaDRS
         mLDrK41m+piEtMJA6Qy94MixQyh8cXd3D4GkgUC/u+H4F0U1j4LSTQDCyUqivEFGjLQ8
         r1krZ+flJdIt9NfSSj4J7lv9TCEnQpewO9gOAuUikKeYtdEVnYNb/SJwIYduxC18h/9b
         mDHdi1C1s9daZzw2+smgtnc/vHuEgnbgntJuWTafz0/BP3O9qOmHMsvVBcfdJnT+Blrp
         m1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZWtypKVtYkfGDCvY0igETJTEM6IuiTNSBlreJ7oLMfA=;
        b=BZX3b1emXFNPZideMsk03QraVu9l9oM0O8qMEOHSbf8bMNt2o8JE3hX16yBmphzeGa
         zMpYj2z0m/J0vcQjCbqPq2+G2EGzNsX0ZT6VNhuOQ7H/PJ/3heBNmjQj2uAbof5IJLJ7
         mnqEeP08yGxMOO3+pAR+hw5qRgNqrZmCPuBIkhGH9bOMvKOH96l+3k9OdkqHubnCAKGz
         IFdrr7OXKFNQWdqPWKtOoM8Swxwjx9HrEex5QyQn4FCyfnJx9arQZcYMNcxk7muRkgk/
         Sw6o20C5xUbil323/HnyJsZGrbfiJjm87ZKD8ODfkcTNB1stBVfVVVAFHeacRGeEjNxm
         HaIQ==
X-Gm-Message-State: ACgBeo2pZJrQYRFJzvlhIitBQaeStzPrQJajGquMAp1rAYWRp8nxWkZ3
        uLUgq4L84Y4MTbQHQ328A/Tcv1EfCizqdYkclHY=
X-Google-Smtp-Source: AA6agR44yLWfq7+TJp1pRXC3wMzQ39QbSPhb6QiafUaW21FHvtSBue2fOKHR45nLS3vt9tpzp45hiQNgug6Fm6+9G6w=
X-Received: by 2002:a05:6638:2391:b0:34a:262:819d with SMTP id
 q17-20020a056638239100b0034a0262819dmr10930288jat.93.1661818668398; Mon, 29
 Aug 2022 17:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com> <CAP01T75G-gp2hymxO+x4=3cJ9CHJKsD3DHPn5QbvOL_-o_4qmA@mail.gmail.com>
 <32a60d8aa6414af288b00a222a019bd3932eb7d2.camel@fb.com> <CAP01T74nPCXAeP=Aj09pW_Ykv5Rx2Y4U_fULQe+a4pWygVxaGg@mail.gmail.com>
 <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com>
In-Reply-To: <5254e00f409cff1e0b8655aeb673b8f77dab21fe.camel@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 02:17:12 +0200
Message-ID: <CAP01T75LPynUfJmHG=Q6jPZxMOO5T-0TRT3rF6h5Ai=OJ2omBA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, 30 Aug 2022 at 01:18, Delyan Kratunov <delyank@fb.com> wrote:
>
> > [...]
> >
> > I don't think that assumption will hold. Requiring RCU protection for
> > all local kptrs means allocator cache reuse becomes harder, as
> > elements are stuck in freelist until the next grace period. It
> > necessitates use of larger caches.
> > For some use cases where they can tolerate reuse, it might not be
> > optimal. IMO the allocator should be independent of how the lifetime
> > of elements is managed.
>
> All maps and allocations are already rcu-protected, we're not adding new here. We're
> only relying on this rcu protection (c.f. the chain of call_rcu_task_trace and
> call_rcu in the patchset) to prove that no program can observe an allocator pointer
> that is corrupted or stale.
>
> >
> > That said, even if you assume RCU protection, that still doesn't
> > address the real problem. Yes, you can access the value without
> > worrying about it moving to another map, but consider this case:
> > Prog unloading,
> > populate_used_allocators -> map walks map_values, tries to take
> > reference to local kptr whose backing allocator is A.
> > Loads kptr, meanwhile some other prog sharing access to the map value
> > exchanges (kptr_xchg) another pointer into that field.
> > Now you take reference to allocator A in used_allocators, while actual
> > value in map is for allocator B.
>
> This is fine. The algorithm is conservative, it may keep allocators around longer
> than they're needed. Eventually there will exist a time that this map won't be
> accessible to any program, at which point both allocator A and B will be released.
>
> It is possible to make a more precise algorithm but given that this behavior is only
> really a problem with (likely pinned) long-lived maps, it's imo not worth it for v1.
>
> >
> > So you either have to cmpxchg and then retry if it fails (which is not
> > a wait-free operation, and honestly not great imo), or if you don't
> > handle this:
> > Someone moved an allocated local kptr backed by B into your map, but
> > you don't hold reference to it.
>
> You don't need a reference while something else is holding the allocator alive. The
> references exist to extend the lifetime past the lifetimes of programs that can
> directly reference the allocator.
>
> > That other program may release
> > allocator map -> allocator,
>
> The allocator map cannot be removed while it's in used_maps of the program. On
> program unload, we'll add B to the used_allocators list, as a value from B is in the
> map. Only then will the allocator map be releasable.
>

Ahh, so prog1 and prog2 both share map M, but not allocator map A and
B, so if it swaps in pointer of B into M while prog1 is unloading, it
will take unneeded ref to A (it it sees kptr to A just before swap).
But when prog2 will unload, it will then see that ptr value is from B
so it will also take ref to B in M's used_allocators. Then A stays
alive for a little while longer, but only when this race happens. But
there won't be any correctness problem as both A and B are kept alive.

Makes sense, but IIUC this only takes care of this specific case. It
can also see 'NULL' and miss taking reference to A.

prog1 uses A, M
prog2 uses B, M
A and B are allocator maps, M is normal hashmap, M is shared between both.

prog1 is unloading:
M holds kptr from A.
during walk, before loading field, prog2 xchg it to NULL, M does not
take ref to A. // 1
Right after it is done processing this field during its walk, prog2
now xchg it back in, now M is holding A but did not take ref to A. //
2
prog1 unloads. M's used_allocators list is empty.

M is still kept alive by prog2.
Now prog2 has already moved its result of kptr_xchg back into the map in step 2.
Hence, prog2 execution can terminate, this ends its RCU section.
Allocator A is waiting for all prior RCU readers, eventually it can be freed.
Now prog2 runs again, starts a new RCU section, kptr_xchg this ptr
from M, and tries to free it. Allocator A is already gone.

If this is also taken care of, I'll only be poking at the code next
when you post it, so that I don't waste any more of your time. But
IIUC this can still cause issues, right?
