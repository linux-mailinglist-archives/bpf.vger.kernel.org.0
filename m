Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDC5B42A5
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIIWuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIIWuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:50:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E7ABF1D
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:50:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d16so1553579ils.8
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4WZtSZGDGbF4xZNUZEBqYoeGViu2Sr1MumfXrZ0idIo=;
        b=OXheOgVKqv6I1FZTOcdDPHckE9NbGKCmVBgTRT7srdDoKP/BOg453vzea3b5tc54QX
         MEL78fJq26W1C2yQtJldjb7E+bP/THfSN+xFEX7CBaciuTkNlhDx0Dta1YxgJOhQ64IT
         XTJADRQ5/E4Nmff5uhNJhpkbFi0TVNhcnr0XGxvPSo1N9C9OIY+1/m30gj8yWfqkKJc2
         Ive1B2s9FuFlkwk876+oqqTuynxx/OI0CLA67OGqi2karwinqBzdI40h8PTMCkK/OtnH
         ciRJQ2bu1vn9rWSze4yAnWvllVWY59MoAqh3DdO2c+9e2UDUa0BkO18+7rbNcFUpDRJB
         UIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4WZtSZGDGbF4xZNUZEBqYoeGViu2Sr1MumfXrZ0idIo=;
        b=gq305WPSiL9qrVyH1gZDrok/NAsmD9oPn/PUVpmdmGQ1s2u6x+8iTZM2VVG12Gq4w7
         562en6roLKhVdpRUjQ/xKyc8AG65fdCCAnPRUH3B387XmQQXqWV+4Ncsu5U/TXxWDDyo
         /7FbfOx+hsE4sS+Z0heRXP7q6GreG7pRJEoFgGgu9lZxrndNLsjSN5dvhlpbsBXnX492
         5WHr4wz5oTl7uwPWeM7OJtBL2RjvEGp7phQW99fakLGhZAKXdjxuWAss1si2DDIuz5TQ
         eoDkdtvZTy+vth2T4rARfGKwU3ynlQgTBbgfgoD2olQvfzQCxt3cqovOYHvJfKeo7SGT
         yX6A==
X-Gm-Message-State: ACgBeo0VDJWDfBH/lDSTXw5XW81ejrbCZq9YM+lHiOpBrCLsRw+4FbZI
        EDu6gzKD2kuDKm2mHtvAmkaBcg8kZzxVP3FVct0=
X-Google-Smtp-Source: AA6agR6xutNvnncTTTqqaF7x6ZFx6obzdZEQ2MttijC5GRcG9cxRa2FEe5XLVOXNOdviYWjZ9AFJjg8FX7R271HQGhE=
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id
 u15-20020a056e02170f00b002f16cdf6f32mr5242760ill.216.1662763820927; Fri, 09
 Sep 2022 15:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com> <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com>
In-Reply-To: <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 10 Sep 2022 00:49:44 +0200
Message-ID: <CAP01T75voazy_BfqRzQKkLLt7k57LnYXNbu-E05jBKcsTkda3Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Sat, 10 Sept 2022 at 00:30, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/9/22 3:25 PM, Alexei Starovoitov wrote:
> > On Fri, Sep 09, 2022 at 11:32:40AM -0700, Andrii Nakryiko wrote:
> >> On Fri, Sep 9, 2022 at 7:58 AM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>>
> >>> On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>>>
> >>>> On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
> >>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>
> >>>>> On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >>>>>>
> >>>>>> On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>>>>>>
> >>>>>>> On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> >>>>>>>> Global variables reside in maps accessible using direct_value_addr
> >>>>>>>> callbacks, so giving each load instruction's rewrite a unique reg->id
> >>>>>>>> disallows us from holding locks which are global.
> >>>>>>>>
> >>>>>>>> This is not great, so refactor the active_spin_lock into two separate
> >>>>>>>> fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> >>>>>>>> enough to allow it for global variables, map lookups, and local kptr
> >>>>>>>> registers at the same time.
> >>>>>>>>
> >>>>>>>> Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> >>>>>>>> reg->map_ptr or reg->btf pointer of the register used for locking spin
> >>>>>>>> lock. But the active_spin_lock_id also needs to be compared to ensure
> >>>>>>>> whether bpf_spin_unlock is for the same register.
> >>>>>>>>
> >>>>>>>> Next, pseudo load instructions are not given a unique reg->id, as they
> >>>>>>>> are doing lookup for the same map value (max_entries is never greater
> >>>>>>>> than 1).
> >>>>>>>>
> >>>>>>>
> >>>>>>> For libbpf-style "internal maps" - like .bss.private further in this series -
> >>>>>>> all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> >>>>>>>
> >>>>>>>   struct bpf_spin_lock lock1 SEC(".bss.private");
> >>>>>>>   struct bpf_spin_lock lock2 SEC(".bss.private");
> >>>>>>>   ...
> >>>>>>>   spin_lock(&lock1);
> >>>>>>>   ...
> >>>>>>>   spin_lock(&lock2);
> >>>>>>>
> >>>>>>> will result in same map but different offsets for the direct read (and different
> >>>>>>> aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> >>>>>>> this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> >>>>>>>
> >>>>>>
> >>>>>> That won't be a problem. Two spin locks in a map value or datasec are
> >>>>>> already rejected on BPF_MAP_CREATE,
> >>>>>> so there is no bug. See idx >= info_cnt check in
> >>>>>> btf_find_struct_field, btf_find_datasec_var.
> >>>>>>
> >>>>>> I can include offset as the third part of the tuple. The problem then
> >>>>>> is figuring out which lock protects which bpf_list_head. We need
> >>>>>> another __guarded_by annotation and force users to use that to
> >>>>>> eliminate the ambiguity. So for now I just put it in the commit log
> >>>>>> and left it for the future.
> >>>>>
> >>>>> Let's not go that far yet.
> >>>>> Extra annotations are just as confusing and non-obvious as
> >>>>> putting locks in different sections.
> >>>>> Let's keep one lock per map value limitation for now.
> >>>>> libbpf side needs to allow many non-mappable sections though.
> >>>>> Single bss.private name is too limiting.
> >>>>
> >>>> In that case,
> >>>> Dave, since the libbpf patch is yours, would you be fine with
> >>>> reworking it to support multiple private maps?
> >>>> Maybe it can just ignore the .XXX part in .bss.private.XXX?
> >>>> Also I think Andrii mentioned once that he wants to eventually merge
> >>>> data and bss, so it might be a good idea to call it .data.private from
> >>>> the start?
> >>>
> >>> I'd probably make all non-canonical names to be not-mmapable.
> >>> The compiler generates special sections already.
> >>> Thankfully the code doesn't use them, but it will sooner or later.
> >>> So libbpf has to create hidden maps for them eventually.
> >>> They shouldn't be messed up from user space, since it will screw up
> >>> compiler generated code.
> >>>
> >>> Andrii, what's your take?
> >>
> >> Ok, a bunch of things to unpack. We've also discussed a lot of this
> >> with Dave few weeks ago, but I have also few questions.
> >>
> >> First, I'd like to not keep extending ".bss" with any custom ".bss.*"
> >> sections. This is why we have .data.* and .rodata.* and not .bss (bad,
> >> meaningless, historic name).
> >>
> >> But I'm totally fine dedicating some other prefix to non-mmapable data
> >> sections that won't be exposed in skeleton and, well, not-mmapable.
> >> What to name it depends on what we anticipate putting in them?
> >>
> >> If it's just for spinlocks, then having something like SEC(".locks")
> >> seems best to me. If it's for more stuff, like global kptrs, rbtrees
> >> and whatnot, then we'd need a bit more generic name (.private, or
> >> whatever, didn't think much on best name). We can also allow .locks.*
> >> or .private.* (i.e., keep it uniform with .data and .rodata handling,
> >> expect for mmapable aspect).
> >>
> >> One benefit for having SEC(".locks") just for spin_locks is that we
> >> can teach libbpf to create a multi-element ARRAY map, where each lock
> >> variable is put into a separate element. From BPF verifier's
> >> perspective, there will be a single BTF type describing spin lock, but
> >> multiple "instances" of lock, one per each element. That seems a bit
> >> magical and I think, generally speaking, it's best to start supporting
> >> multiple lock declarations within single map element (and thus keep
> >> track of their offset within map_value); but at least that's an
> >> option.
> >
> > ".lock" won't work. We need lock+rb_root or lock+list_head to be
> > in the same section.
> > It should be up to user to name that section with something meaningful.
> > Ideally something like this should be supported:
> > SEC("enqueue") struct bpf_spin_lock enqueue_lock;
> > SEC("enqueue") struct bpf_list_head enqueue_head __contains(foo, node);
> > SEC("dequeue") struct bpf_spin_lock dequeue_lock;
> > SEC("dequeue") struct bpf_list_head dequeue_head __contains(foo, node);
> >
>
> Isn't the "head and lock must be in same section / map_value" desired, or just
> a consequence of this implementation? I don't see why it's desirable from user
> perspective. Seems to have same problem as rbtree RFCv1's rbtree_map struct
> creating its own bpf_spin_lock, namely not providing a way for multiple
> datastructures to share same lock in a way that makes sense to the verifier for
> enforcement.
>

There is no such restriction here. You just put a lock and every list
or rbtree protected by that lock in the same section.
Then all of them share the same lock for the special section.

#define __private(X) SEC("map" #X)
struct bpf_spin_lock lock __private(a);
struct bpf_list_head head __contains(...) __private(a);
struct bpf_rb_root root __contains(...) __private(a);

As I said already, it's also possible to do a more fine grained
approach by having multiple of them globally.
Then this multiple separate section based approach is not needed at
all. You can have just one private section for such bpf special
structures, maybe even by default from libbpf side, as they can't be
mmap'd anyway.

libbpf will see that you have bpf_spin_lock, bpf_list_head,
bpf_rb_root, it will put them in .data.nommap.

But then the verifier needs to know which lock protects which data.
You always need that info, in any approach. Here we assume by default
just one bpf_spin_lock so the answer is known.
We can 'learn' that implicitly (storing what we see first in the
verifier, e.g. if you added to head while holding lockA, we assume
this is the one you'll be using to protect it). Later the same head
cannot be added to using lockB.
Or we can just make the user annotate that explicitly, like clang's
thread safety annotations (GUARDED_BY(lock) etc.).
Then the spin_lock_off protecting it is stored with other info in
bpf_map_value_off_desc.

So compared to the example above, user will just do:
struct bpf_spin_lock lock1;
struct bpf_spin_lock lock2;
struct bpf_list_head head __contains(...) __guarded_by(lock1);
struct bpf_list_head head2 __contains(...) __guarded_by(lock2);
struct bpf_rb_root root __contains(...) __guarded_by(lock2);

It looks much cleaner to me from a user perspective. Just define what
protects what, which also doubles as great documentation.

Regardless, the point is there are no limitations regarding
coarse-grained/fine-grained locking or lock sharing.
The question is more about how to expose it to the user.

> >> Dave had some concerns about pinning such maps and whatnot, but for
> >> starters we decided to not worry about pinning for now. Dave, please
> >> bring up remaining issues, if you don't mind.
> >
>
> @Andrii, aside from vague pinning concerns from our last discussion about this,
> I don't have any specific concerns. A multi-element ".locks" is more
> appealing to me now, actually, as I think it enables best-of-both-worlds for
> this impl and my rbtree RFCv2 experiments:
>
>   * This series uses (map_ptr, map_value_offset) as lock identity for
>     verification purposes and expects map_ptr for list_head and lock
>     to be the same.
>     * If my logic in comment preceding this one is correct, downside
>       is no lock sharing between datastructures.
>

See above.

>   * rbtree RFCv2 uses lock address as lock identity
>     for verification purposes and requires lock address to be known
>     when verifying program using the lock.
>     * Downside: no clear path forward for map_in_map general case,
>       can make it work for some specific cases but kludgey.
>
>   * If ".locks" exists, supporting multiple lock definitions, we can
>     use locks_sec_offset or locks_sec_map_{key,idx} as lock identity
>     for verification purposes.
>     * As a result "head and lock must be in same section" requirement
>       is removed, and there's a path forward for map_in_map inner maps
>       to share locks arbitrarily without losing verifiability.
>     * But I suspect this requires some special handling of the map backing
>       ".locks" on kernel side.
>
> I have some hacks on top of rbtree RFCv2 that are moving in this ".locks"
> direction, happy to fix them up and send something if I didn't miss anything
> above.

I don't really like the ".locks" section or the idea in general. There
is nothing really special about locks in particular.
Same problem with bpf_timer. A nommap map approach also allows having
more than one bpf_timer globally.

>
> Regardless, @Kumar, happy to iterate on .bss.private patch until it's in
> a shape that satisfies everyone.
>

Great, once the discussion concludes it would be great if you send it
out as its own patch, easier for me too.
