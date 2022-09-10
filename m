Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99225B435F
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 02:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIJAWI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIJAWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 20:22:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D2135D57
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 17:22:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nc14so7771313ejc.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eUD8DO7zG4gpVnEGeCkLhsIKco8VdY2wwoP14T1/UrQ=;
        b=eq94zskXruuqc2G1B1LfgY4aY4WQQjP+8ZSmQv9ynTrEaI9Ea1KsTDgs5scnG+SNn2
         QxSG5bkpoAOEtO7UXs8cRPHPs0P6ALuvFWTpbt6nhpKvbkdj7xs8Zb8h5bRrzaYJj6b7
         I/suAh3qK4K5JaWp6Nl+ztjM4pNvkN7sRsb6vDpYS6P/cVXdfWCP8MGQ0nxEx6RR1SQG
         dhRH22tUbT/0usmQbG67cAXC9wny3DjRPmbtOhmQ2U1YgG/8yzUyc3f2MMTQqP37C/Nt
         vLDc5Z3g4uk3a05GGa0CFOoCZfJIa6jXVye3zyZXLckrcAKOTrht+eoyd7QAmSZ4gLfc
         qpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eUD8DO7zG4gpVnEGeCkLhsIKco8VdY2wwoP14T1/UrQ=;
        b=nGwG5fvv7s25kI1FpHDm2/k8d+TTTDjsVSaa1t+WauVv1nuJGTAnFL4lPrBgLclraw
         H8GfRQ6zfI3hJuNSbRr7xJ8OvhJtWTzbY0Zy7be0widGnw/TVc/Cle8sgxPhPK7Lz12f
         By1h16BUZ9PXr0uB7ko9+TDB6+amSyOVyzMVnBGehumsbv5HhwNUy/AZekAQNAyk7WO3
         9O6nD8Jb24GM/z9GrRxHuRbr9W+OW92pa0+0TRQqmDcPbEmjVx+lxHjYpoDTLjdKnnuT
         i+wy9kE/IdcE+PCOoXS8JBT3Oj9ImNcdF/TZxgMk97rqdE+2ILf7Dfc78vdiXHnYkikV
         w4QQ==
X-Gm-Message-State: ACgBeo2sFJI4rzGEXf6Zc4dyQFX+lqinkIQmgInjLXUTLrSwETMW8Ewr
        lC/wgjIB70VzeyzHq4EDsddk+Ibi4OgrLRgRX44=
X-Google-Smtp-Source: AA6agR5kDYTF2V/rwEWL/rxNumJAOauPc/BiTIIMpu9g39HT9Ss+n5C8jzpCWLHSVzryjclC72JcS8O7YWEGHZ2mDD0=
X-Received: by 2002:a17:907:7e92:b0:741:5f7e:f1ac with SMTP id
 qb18-20020a1709077e9200b007415f7ef1acmr11789451ejc.176.1662769324050; Fri, 09
 Sep 2022 17:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzaoaS8QiPDXuuN1pAiJQ9X6j1WfM+eZhpbRr6ZZ=afZNA@mail.gmail.com> <20220909205720.4c73xecxrjrl2vkd@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220909205720.4c73xecxrjrl2vkd@macbook-pro-4.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 17:21:52 -0700
Message-ID: <CAEf4BzazaCKMu5FUB_iZ2z+SVtaw-w8VZhA7EBd9oKKB_o299Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
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

On Fri, Sep 9, 2022 at 1:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 09, 2022 at 01:21:05PM -0700, Andrii Nakryiko wrote:
> > On Fri, Sep 9, 2022 at 12:25 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Sep 09, 2022 at 11:32:40AM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Sep 9, 2022 at 7:58 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > > > > > > > >
> > > > > > > > > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > > > > > > > > Global variables reside in maps accessible using direct_value_addr
> > > > > > > > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > > > > > > > disallows us from holding locks which are global.
> > > > > > > > > >
> > > > > > > > > > This is not great, so refactor the active_spin_lock into two separate
> > > > > > > > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > > > > > > > enough to allow it for global variables, map lookups, and local kptr
> > > > > > > > > > registers at the same time.
> > > > > > > > > >
> > > > > > > > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > > > > > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > > > > > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > > > > > > > whether bpf_spin_unlock is for the same register.
> > > > > > > > > >
> > > > > > > > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > > > > > > > are doing lookup for the same map value (max_entries is never greater
> > > > > > > > > > than 1).
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > For libbpf-style "internal maps" - like .bss.private further in this series -
> > > > > > > > > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> > > > > > > > >
> > > > > > > > >   struct bpf_spin_lock lock1 SEC(".bss.private");
> > > > > > > > >   struct bpf_spin_lock lock2 SEC(".bss.private");
> > > > > > > > >   ...
> > > > > > > > >   spin_lock(&lock1);
> > > > > > > > >   ...
> > > > > > > > >   spin_lock(&lock2);
> > > > > > > > >
> > > > > > > > > will result in same map but different offsets for the direct read (and different
> > > > > > > > > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > > > > > > > > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> > > > > > > > >
> > > > > > > >
> > > > > > > > That won't be a problem. Two spin locks in a map value or datasec are
> > > > > > > > already rejected on BPF_MAP_CREATE,
> > > > > > > > so there is no bug. See idx >= info_cnt check in
> > > > > > > > btf_find_struct_field, btf_find_datasec_var.
> > > > > > > >
> > > > > > > > I can include offset as the third part of the tuple. The problem then
> > > > > > > > is figuring out which lock protects which bpf_list_head. We need
> > > > > > > > another __guarded_by annotation and force users to use that to
> > > > > > > > eliminate the ambiguity. So for now I just put it in the commit log
> > > > > > > > and left it for the future.
> > > > > > >
> > > > > > > Let's not go that far yet.
> > > > > > > Extra annotations are just as confusing and non-obvious as
> > > > > > > putting locks in different sections.
> > > > > > > Let's keep one lock per map value limitation for now.
> > > > > > > libbpf side needs to allow many non-mappable sections though.
> > > > > > > Single bss.private name is too limiting.
> > > > > >
> > > > > > In that case,
> > > > > > Dave, since the libbpf patch is yours, would you be fine with
> > > > > > reworking it to support multiple private maps?
> > > > > > Maybe it can just ignore the .XXX part in .bss.private.XXX?
> > > > > > Also I think Andrii mentioned once that he wants to eventually merge
> > > > > > data and bss, so it might be a good idea to call it .data.private from
> > > > > > the start?
> > > > >
> > > > > I'd probably make all non-canonical names to be not-mmapable.
> > > > > The compiler generates special sections already.
> > > > > Thankfully the code doesn't use them, but it will sooner or later.
> > > > > So libbpf has to create hidden maps for them eventually.
> > > > > They shouldn't be messed up from user space, since it will screw up
> > > > > compiler generated code.
> > > > >
> > > > > Andrii, what's your take?
> > > >
> > > > Ok, a bunch of things to unpack. We've also discussed a lot of this
> > > > with Dave few weeks ago, but I have also few questions.
> > > >
> > > > First, I'd like to not keep extending ".bss" with any custom ".bss.*"
> > > > sections. This is why we have .data.* and .rodata.* and not .bss (bad,
> > > > meaningless, historic name).
> > > >
> > > > But I'm totally fine dedicating some other prefix to non-mmapable data
> > > > sections that won't be exposed in skeleton and, well, not-mmapable.
> > > > What to name it depends on what we anticipate putting in them?
> > > >
> > > > If it's just for spinlocks, then having something like SEC(".locks")
> > > > seems best to me. If it's for more stuff, like global kptrs, rbtrees
> > > > and whatnot, then we'd need a bit more generic name (.private, or
> > > > whatever, didn't think much on best name). We can also allow .locks.*
> > > > or .private.* (i.e., keep it uniform with .data and .rodata handling,
> > > > expect for mmapable aspect).
> > > >
> > > > One benefit for having SEC(".locks") just for spin_locks is that we
> > > > can teach libbpf to create a multi-element ARRAY map, where each lock
> > > > variable is put into a separate element. From BPF verifier's
> > > > perspective, there will be a single BTF type describing spin lock, but
> > > > multiple "instances" of lock, one per each element. That seems a bit
> > > > magical and I think, generally speaking, it's best to start supporting
> > > > multiple lock declarations within single map element (and thus keep
> > > > track of their offset within map_value); but at least that's an
> > > > option.
> > >
> > > ".lock" won't work. We need lock+rb_root or lock+list_head to be
> > > in the same section.
> > > It should be up to user to name that section with something meaningful.
> > > Ideally something like this should be supported:
> > > SEC("enqueue") struct bpf_spin_lock enqueue_lock;
> > > SEC("enqueue") struct bpf_list_head enqueue_head __contains(foo, node);
> > > SEC("dequeue") struct bpf_spin_lock dequeue_lock;
> > > SEC("dequeue") struct bpf_list_head dequeue_head __contains(foo, node);
> > >
> > > > Dave had some concerns about pinning such maps and whatnot, but for
> > > > starters we decided to not worry about pinning for now. Dave, please
> > > > bring up remaining issues, if you don't mind.
> > >
> > > Pinning shouldn't be an issue.
> > > Only mmap is the problem. User space access if fine since kernel
> > > will mask out special fields on read/write.
> > >
> > > > So to answer Alexei's specific option. I'm still not in favor of just
> > > > saying "anything that's not .data or .rodata is non-mmapable map". I'd
> > > > rather carve out naming prefixes with . (which are  reserved for
> > > > libbpf's own use) for these special purpose maps. I don't think that
> > > > limits anyone, right?
> > >
> > > Is backward compat a concern?
> > > Whether to mmap global data is a flag.
> > > It can be opt-in or opt-out.
> > > I'm proposing make all named section to be 'do not mmap'.
> > > If a section needs to be mmaped and appear in skeleton the user can do
> > > SEC("my_section.mmap")
> > >
> > > What you're proposing is to do the other way around:
> > > SEC("enqueue.nommap")
> > > SEC("dequeue.nommap")
> > > in the above example.
> > > I guess it's fine, but more verbose.
> >
> > Well, I didn't propose to use suffixes. Currently user can define
> > SEC(".data.my_custom_use_case").
>
> ... and libbpf will mmap such maps and will expose them in skeleton.
> My point that it's an existing bug.

hm... it's not a bug, it's a desired feature. I wanted

int my_var SEC(".data.mine");

to be just like .data but in a separate map. So no bug here.

> Compiler generated .rodata.str1.1 sections should not be messed by
> user space. There is no BTF for them either.

Shouldn't but could if they wanted to without skeleton as well. In
generated skeleton there will be an empty struct for this and no field
for each of compiler's constant. User has to intentionally do
something to harm themselves, which we can never stop either way.

So stuff like .rodata.str1.1 exposes a bit of compiler implementation
details, but overall idea of allowing custom .data.xxx and .rodata.xxx
sections was to make them mmapable and readable/writable through
skeleton.

Carving out some sub-namespace based on special suffix feels wrong.

> mmap and subsequent write by user space won't cause a crash for bpf prog,
> but it won't be doing what C code intended.
> There is nothing in there for skeleton and user space to see,
> but such map should be created, populated and map_fd provided to the prog to use.
>
> > So I was proposing that we'll just
> > define a different *prefix*, like SEC(".private.enqueue") and
> > SEC(".private.dequeue") for your example above, which will be private
> > to BPF program, not mmap'ed, not exposed in skeleton.
> >
> > mmap is a bit orthogonal to exposing in skeleton, you can still
> > imagine data section that will be allowed to be initialized from
> > user-space before load but never mmaped afterwards. Just to say that
> > .nommap doesn't necessarily imply that it shouldn't be in a skeleton.
>
> Well. That's true for normal skeleton and for lskel,
> but not the case for kernel skel that doesn't have mmap.
> Exposing a map in skel implies that it will be accessed not only
> after _open and before _load, but after load as well.
> We can say that mmap != expose in skeleton, but I really don't see
> such feature being useful.

It's basically what .rodata is, actually. It's something that's
settable from user-space before load and that's it. Yes, you can read
it after load, but no one does it in practice. But we are digressing,
I understand you want to make this short and sweet and I agree with
you. I just disagree about wildcard rule for any non-dotted ELF
section or using special suffix. See below.

>
> > So I still prefer special prefix (.private) and declare that this is
> > both non-mmapable and not-exposed in skeleton.
> >
> > As for allowing any section. It just feels unnecessary and long-term
> > harmful to allow any section name at this point, tbh.
>
> Fine. How about a single new character instead of '.private' prefix ?
> Like SEC("#enqueue") that would mean no-skel and no-mmap ?
>
> Or double dot SEC("..enqueue") ?
>
> '.private' is too verbose and when it's read in the context of C file
> looks out of place and confusing.

As I said, I gave zero thought to .private, I just took it from
".bss.private". I'd like to keep it "dotted", so SEC("#something") is
very "unusual". Me not like.

For double-dot, could be just SEC("..data") and generalized to
SEC("..data.<custom>")? BTW, we can add a macro, similar to __kconfig,
to hide more descriptive and longer name. E.g.,

struct bpf_spin_lock my_lock __internal;

__internal, __private, __secret, don't know, naming is hard.
