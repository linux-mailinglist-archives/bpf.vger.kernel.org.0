Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6846B5A392A
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiH0RWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiH0RWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 13:22:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2A2A71C;
        Sat, 27 Aug 2022 10:22:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x93so5387424ede.6;
        Sat, 27 Aug 2022 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y0Jg5A8w/HfRMOqIFodrSXnycjO3otfCsSGBf7fuc7s=;
        b=WUVXvgLZttin1TxB5PTeQhMlGjbA76GcjvcaHNxmnyBezANGPDX0hRLiJ9hAUSWH8n
         ptrQzFkR3uRpezTJC2SvmkgzB6Gt5lxDfrIdRSBqc8BBpJCzz+ay0qLY1m+r0/H7bVkk
         qaoEDGOIZeXL05D5XWpUnltj2UejzZ4I9Ip4qSFiy85utpevWbfxoYRIzvx7aIQNoECc
         sIi966KoGNCwxpf7J8NIxxvPe3F0vefk/nHREQ3YYbhyLKyMm6nolbL2j/FmZdm+iyYU
         zDN199+GuPYjhcTylGtpM9TI7+s+17Um5mN3RKmdpTc3FiyH8Tv6UyhMY+WQWJprk9zX
         EjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y0Jg5A8w/HfRMOqIFodrSXnycjO3otfCsSGBf7fuc7s=;
        b=5DrqqqYDLkn5rk2ftbOwNb+jDTJqxuWXpnZwHAuKn5toFKmsBMqe7m6cV47yTSIKox
         270wiBnimqjrBhGMSRil6kkI7QxtwCGeYuz4YS1XUVVlwMpiodcqqDHb8hHxXiCH6Efb
         qIEiF44q/NMLVogiAu9pu9IPyTh/EwnaDPGJSz8tUCJowU2wEHe59MfQO1kiGd+Yskwl
         35cbmqSu9SeJk+9nbX8Cbu/uRZq2MNqjNp5p2MOoR4mbfoNre1NUdup0SGKn2h0utXFH
         XkufVg/LGMU2YYktK2TIGaMUCrs1UwHNe5nIsBgQMrPp4IqvEu52lqVUz998Bks05VuA
         LChA==
X-Gm-Message-State: ACgBeo1H7LRqonpLUbK8qC+zbFGOnLwn8cQONHSOfLzz9J1ulEjLMDex
        dBoZWdYoT46fpoAAVXFlfq7KEt1gk0Om4CRR/tM=
X-Google-Smtp-Source: AA6agR6VTPMLHW4qz7XbQ0ud7EH9P97aYPuS5SBkYM56+6hVs6RomWEPd7pOVWmVo4GAMYbeAQS+rp4R+Z9pIYHVgUg=
X-Received: by 2002:aa7:cad7:0:b0:446:5d20:6708 with SMTP id
 l23-20020aa7cad7000000b004465d206708mr10714093edt.224.1661620923939; Sat, 27
 Aug 2022 10:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220822235649.2218031-1-joannelkoong@gmail.com>
 <20220822235649.2218031-2-joannelkoong@gmail.com> <CAEf4BzZm7eUX3w-NwP0JuWtvKbO6GxN911TraY5bA8-z+ocyCg@mail.gmail.com>
 <CAP01T77izAbefN5CJ1ZdjwUdii=gMFMduKTYtSbYC3S9jbRoEA@mail.gmail.com>
 <CAJnrk1Y0r3++RLpT2jvp4st-79x3dUYk3uP-4tfnAeL5_kgM0Q@mail.gmail.com>
 <CAP01T74O6ZuH_NPObYTLUjFSADjWjzfHjTsLBf8b67jgchf6Gw@mail.gmail.com>
 <CAJnrk1Z39+pLzAOL3tbqvQyTcB4HvrbLghmr6_vLXhtJYHuwEA@mail.gmail.com>
 <CAP01T76ChONTCVtHNZ_X3Z6qmuZTKCVYwe0s6_TGcuC1tEx9sw@mail.gmail.com>
 <CAJnrk1Zmne1uDn8EKdNKJe6O-k_moU9Sryfws_J-TF2BvX2QMg@mail.gmail.com>
 <CAP01T746gvoOM7DuWY-3N2xJbEainTinTPhyqHki2Ms6E0Dk_A@mail.gmail.com>
 <CAEf4BzZYTN=gGsc88jetv-SSMBy78P7w7Y08zfwGR7cCenJPiQ@mail.gmail.com> <CAP01T74mbnYJkq0CfknZBqYg4T5B-OenB+SB6=gc24GvpVxA8g@mail.gmail.com>
In-Reply-To: <CAP01T74mbnYJkq0CfknZBqYg4T5B-OenB+SB6=gc24GvpVxA8g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 27 Aug 2022 10:21:52 -0700
Message-ID: <CAEf4BzYpV-RJ456n0UQFPXSG6SvUPK5=jM4nS+x25z7pTkfMGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add skb dynptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        kafai@fb.com, kuba@kernel.org, netdev@vger.kernel.org
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

On Sat, Aug 27, 2022 at 12:12 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 27 Aug 2022 at 07:37, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 1:54 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 26 Aug 2022 at 21:49, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 11:52 AM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Fri, 26 Aug 2022 at 20:44, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Aug 25, 2022 at 5:19 PM Kumar Kartikeya Dwivedi
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, 25 Aug 2022 at 23:02, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > Related question, it seems we know statically if dynptr is read only
> > > > > > > > > or not, so why even do all this hidden parameter passing and instead
> > > > > > > > > just reject writes directly? You only need to be able to set
> > > > > > > > > MEM_RDONLY on dynptr_data returned PTR_TO_PACKETs, and reject
> > > > > > > > > dynptr_write when dynptr type is xdp/skb (and ctx is only one). That
> > > > > > > > > seems simpler than checking it at runtime. Verifier already handles
> > > > > > > > > MEM_RDONLY generically, you only need to add the guard for
> > > > > > > > > check_packet_acces (and check_helper_mem_access for meta->raw_mode
> > > > > > > > > under pkt case), and rejecting dynptr_write seems like a if condition.
> > > > > > > >
> > > > > > > > There will be other helper functions that do writes (eg memcpy to
> > > > > > > > dynptrs, strncpy to dynptrs, probe read user to dynptrs, hashing
> > > > > > > > dynptrs, ...) so it's more scalable if we reject these at runtime
> > > > > > > > rather than enforce these at the verifier level. I also think it's
> > > > > > > > cleaner to keep the verifier logic as simple as possible and do the
> > > > > > > > checking in the helper.
> > > > > > >
> > > > > > > I won't be pushing this further, since you know what you plan to add
> > > > > > > in the future better, but I still disagree.
> > > > > > >
> > > > > > > I'm guessing there might be dynptrs where this read only property is
> > > > > > > set dynamically at runtime, which is why you want to go this route?
> > > > > > > I.e. you might not know statically whether dynptr is read only or not?
> > > > > > >
> > > > > > > My main confusion is the inconsistency here.
> > > > > > >
> > > > > > > Right now the patch implicitly relies on may_access_direct_pkt_data to
> > > > > > > protect slices returned from dynptr_data, instead of setting
> > > > > > > MEM_RDONLY on the returned PTR_TO_PACKET. Which is fine, it's not
> > > > > > > needed. So indirectly, you are relying on knowing statically whether
> > > > > > > the dynptr is read only or not. But then you also set this bit at
> > > > > > > runtime.
> > > > > > >
> > > > > > > So you reject some cases at load time, and the rest of them only at
> > > > > > > runtime. Direct writes to dynptr slice fails load, writes through
> > > > > > > helper does not (only fails at runtime).
> > > > > > >
> > > > > > > Also, dynptr_data needs to know whether dynptr is read only
> > > > > > > statically, to protect writes to its returned pointer, unless you
> > > > > > > decide to introduce another helper for the dynamic rdonly bit case
> > > > > > > (like dynptr_data_rdonly). Then you have a mismatch, where dynptr_data
> > > > > > > works for some rdonly dynptrs (known to be rdonly statically, like
> > > > > > > this skb one), but not for others.
> > > > > > >
> > > > > > > I also don't agree about the complexity or scalability part, all the
> > > > > > > infra and precedence is already there. We already have similar checks
> > > > > > > for meta->raw_mode where we reject writes to read only pointers in
> > > > > > > check_helper_mem_access.
> > > > > >
> > > > > > My point about scalability is that if we reject bpf_dynptr_write() at
> > > > > > load time, then we must reject any future dynptr helper that does any
> > > > > > writing at load time as well, to be consistent.
> > > > > >
> > > > > > I don't feel strongly about whether we reject at load time or run
> > > > > > time. Rejecting at load time instead of runtime doesn't seem that
> > > > > > useful to me, but there's a good chance I'm wrong here since Martin
> > > > > > stated that he prefers rejecting at load time as well.
> > > > > >
> > > > > > As for the added complexity part, what I mean is that we'll need to
> > > > > > keep track of some more stuff to support this, such as whether the
> > > > > > dynptr is read only and which helper functions need to check whether
> > > > > > the dynptr is read only or not.
> > > > >
> > > > > What I'm trying to understand is how dynptr_data is supposed to work
> > > > > if this dynptr read only bit is only known at runtime. Or will it be
> > > > > always known statically so that it can set returned pointer as read
> > > > > only? Because then it doesn't seem it is required or useful to track
> > > > > the readonly bit at runtime.
> > > >
> > > > I think it'll always be known statically whether the dynptr is
> > > > read-only or not. If we make all writable dynptr helper functions
> > > > reject read-only dynptrs at load time instead of run time, then yes we
> > > > can remove the read-only bit in the bpf_dynptr_kern struct.
> > > >
> > > > There's also the question of whether this constraint (eg all read-only
> > > > writes are rejected at load time) is too rigid - for example, what if
> > > > in the future we want to add a helper function where if a certain
> > > > condition is met, then we write some number of bytes, else we read
> > > > some number of bytes? This would be not possible to add then, since
> > > > we'll only know at runtime whether the condition is met.
> > > >
> > > > I personally lean towards rejecting helper function writes at runtime,
> > > > but if you think it's a non-trivial benefit to reject at load time
> > > > instead, I'm fine going with that.
> > > >
> > >
> > > My personal opinion is this:
> > >
> > > When I am working with a statically known read only dynptr, it is like
> > > declaring a variable const. Every function expecting it to be
> > > non-const should fail compilation, and trying to mutate the variables
> > > through writes should also fail compilation. For BPF compilation is
> > > analogous to program load.
> > >
> > > It might be that said variable is not const, then those operations may
> > > fail at runtime due to some other reason. Being dynamically read-only
> > > is then a runtime failure condition, which will cause failure at
> > > runtime. Both are distinct cases in my mind, and it is fine to fail at
> > > runtime when we don't know. In general, you save a lot of time of the
> > > user in my opinion (esp. people new to things) if you reject known
> > > incorrectness as early as possible.
> > >
> > > E.g. load a dynptr from a map, where the field accepts storing both
> > > read only and non-read only ones. Then it is expected that writes may
> > > fail at runtime. That also allows you to switch read-only ness at
> > > runtime back to rw. But if the field only expects rdonly dynptr,
> > > verifier knows that the type is const statically, so it triggers
> > > failures for writes at load time instead.
> > >
> > > Taking this a step further, you may even store rw dynptr to a map
> > > field expecting rdonly dynptr. That's like returning a const pointer
> > > from a function for a rw memory, where you want to limit access of the
> > > user, even better if you do it statically. Then functions trying to
> > > write to dynptr loaded from said map field will fail load itself,
> > > while others having access to rw dynptr can do it just fine.
> > >
> > > When the verifier does not know, it does not know. There will be such
> > > cases when you make const-ness a runtime property.
> > >
> > > > >
> > > > > It is fine if _everything_ checks it at runtime, but that doesn't seem
> > > > > possible, hence the question. We would need a new slice helper that
> > > > > only returns read-only slices, because dynptr_data can return rw
> > > > > slices currently and it is already UAPI so changing that is not
> > > > > possible anymore.
> > > >
> > > > I don't agree that if bpf_dynptr_write() is checked at runtime, then
> > > > bpf_dynptr_data must also be checked at runtime to be consistent. I
> > > > think it's fine if writes through helper functions are rejected at
> > > > runtime, and writes through direct access are rejected at load time.
> > > > That doesn't seem inconsistent to me.
> > >
> > > My point was more that dynptr_data cannot propagate runtime
> > > read-only-ness to its returned pointer. The verifier has to know
> > > statically, at which point I don't see why we can't just reject other
> > > cases at load anyway.
> >
> > I think the right answer here is to not make bpf_dynptr_data() return
> > direct pointer of changing read-only-ness. Maybe the right answer here
> > is another helper, bpf_dynptr_data_rdonly(), that will return NULL for
> > non-read-only dynptr and PTR_TO_MEM | MEM_RDONLY if dynptr is indeed
> > read-only?
>
> Shouldn't it be the other way around? bpf_dynptr_data_rdonly() should
> work for both ro and rw dynptrs, and bpf_dynptr_data() only for rw
> dynptr?

Right, that's what I proposed:

  "bpf_dynptr_data_rdonly(), that will return NULL for non-read-only dynptr"

so if you pass read-write dynptr, it will return NULL (because it's
unsafe to take writable direct pointer).

bpf_dynptr_data_rdonly() should still work fine with both rdonly and
read-write dynptr.
bpf_dynptr_data() only works (in the sense returns non-NULL) for
read-write dynptr only.


>
> And yes, you're kind of painting yourself in a corner if you allow
> dynptr_data to work with statically ro dynptrs now, ascertaining the
> ro bit for the returned slice, and then later you plan to add dynptrs
> whose ro vs rw is not known to the verifier statically. Then it works
> well for statically known ones (returning both ro and rw slices), but
> has to return NULL at runtime for statically unknown read only ones,
> and always rw slice in verifier state for them.

Right, will be both inconsistent and puzzling.

>
> >
> > By saying that read-only-ness of dynptr should be statically known and
> > rejecting some dynptr functions at load time places us at the mercy of
> > verifier's complete knowledge of application logic, which is exactly
> > against the spirit of dynptr.
> >
>
> Right, that might be too restrictive if we require them to be
> statically read only.
>
> But it's not about forcing it to be statically ro, it is more about
> rejecting load when we know the program is incorrect (e.g. the types
> are incorrect when passed to helpers), otherwise we throw the error at
> runtime anyway, which seems to be the convention afaicu. But maybe I
> missed the memo and we gradually want to move away from such strict
> static checks.
>
> I view the situation here similar to if we were rejecting direct
> writes to PTR_TO_MEM | MEM_RDONLY at load time, but offloading as
> runtime check in the helper writing to it as rw memory arg. It's as if
> we pretend it's part of the 'type' of the register when doing direct
> writes, but then ignore it while matching it against the said helper's
> argument type.

I disagree, it's not the same. bpf_dynptr_data/bpf_dynptr_data_rdonly
turns completely dynamic dynptr into static slice of memory. Only
after that point it makes sense for BPF verifier to reject something.
Until then it's not incorrect. BPF program will always have to deal
with some dynptr operations potentially failing. dynptr can always be
NULL internally, you can still call bpf_dynptr_xxx() operations on it,
they will just do nothing and return error. That doesn't make BPF
program incorrect.

As I said, dynptr is about shifting static verification to runtime
checks for stuff that BPF verifier can't or shouldn't verify
statically. Like dynptr's dynamic size, for example. We've used a
special data/data_end pointer types to try to solve this for skb, but
it is quite painful in practice and relies on compiler generating
"good" sequence of instructions understandable to BPF verifier.

dynptr takes a different approach, shifts validation to runtime and
"interfaces" with static verification through bpf_dynptr_data() and
similar APIs.

>
> > It's only slightly tangential, but I still dread my experience proving
> > to BPF verifier that some value is strictly greater than zero for BPF
> > helper that expected ARG_CONST_SIZE (not ARG_CONST_SIZE_OR_ZERO).
> > There were also cases were absolutely correct program had to be
> > mangled just to prove to BPF verifier that it indeed can return just 0
> > or 1, etc. This is not to bash BPF verifier, but just to point out
> > that sometimes unnecessary strictness adds nothing but unnecessary
> > pain to user. So, let's not reject anything at load, we can check all
> > that at runtime and return NULL.
> >
> > But bpf_dynptr_data_rdonly() seems useful for cases where we know we
> > are not going to write
> >
> > >
> > > When we have dynptrs which have const-ness as a runtime property, it
> > > is ok to support that by failing at runtime (but then you'll have a
> > > hard time deciding how you want dynptr_data to work, most likely
> > > you'll need another helper which returns only a rdonly slice, when it
> > > fails, we call dynptr_data for rw slice).
> > >
> > > But as I said before, I don't know how dynptr is going to evolve in
> > > the future, so you'll have a better idea, and I'll leave it up to you
> > > decide how you want to design its API. Enough words exchanged about
> > > this :).
> >
> > directionally, dynptr is about offloading decisions to runtime, so I
> > think avoiding unnecessary restrictions at verification time is the
> > right trade off
>
> Fair enough, I guess I've made my point. Let's go with what you both
> feel would be best.

Sounds good. I tried to point out the "philosophy" behind dynptr. It
doesn't preclude making the BPF verifier smarter and track more
things. But it's a deliberate design of dynptr to shift more checks to
runtime because in a lot of cases it makes more sense than "fighting
BPF verifier". This "fighting verifier" phrase is like a meme now.
I've heard this exact phrase from multiple unrelated engineers. BPF
verifier should be helpful, we should engineers having to "fight" it,
so overly strict checks from verifier should be avoided if they don't
compromise correctness, IMO.
