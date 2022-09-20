Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8495BEECD
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiITUzt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiITUzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 16:55:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC65F20C
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 13:55:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a41so5700981edf.4
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f18kT/0qMFhwptCqxqWEcHQOCDdzBoYSl4+OUp9tagg=;
        b=DRGoPX7lnbhbh/AsvST9hJSUKa0Aw/UqzdHootaMqfAjp6MKs28mB1oyDlQsqbk422
         NRcyP3mn0QDJq68wVZgjm8euuweBEn50KOKAjS5bW4J1OJA+wRwsqLmo0rdvoLRyocfA
         zZWAYlqKA08K1JaUtbwAEeRv+cHiBneOP5bx7TYgqJtoC6TWo+skkYInpDXCO6rxt00o
         SJ9tVUxMsJncKi0/4Kq9i0A/89O7wMtFfGB9a4vK3wfXvSg3mo8wvtKRQ1C3xOCwUjFG
         6wQViXtB51GSEfWNQXFEfzxuZGZhWcREb3CvC38RAhXQCqBTqirNBAEvV1RE0mk1zHJ9
         0UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f18kT/0qMFhwptCqxqWEcHQOCDdzBoYSl4+OUp9tagg=;
        b=mvNaxdhWgnSNhYrXeZ5Z3AQZTEzuxYiGqdCTeS9uwXlk83lO8ocd8Q93Xp7sD0AQSe
         9EAVZcEw5B+0PCsAExYOfFzkYz6GIXgFSkvv5UWLG5fKCHRzvoIyHikFktMPPEHWvvLI
         D+N783k9W4iYtaHqbYklLb2rXibGeEQh881GbI0pmRGudWSzi0JIDM4Q47AaAibgpqvb
         aQNO46vSgQHgOrPz14QV8itJAXx6gbaLWtJcda2WliN9vHTWNYE5Rku8TX0FRPcUSU48
         mVdvITjETKecCf4YtqSGUVmrLuuKcU0ClIyMlhn3AytC8Nl9+wtFda+MsslcrakpyWoP
         IfjA==
X-Gm-Message-State: ACrzQf3SlKVO1F/4u7mhggtgJtlSF1GG0lAxV5/SqH/C7O1uMwzMl9xm
        EGO3nx4eTRa/Yhtm0HkZrq80/8pTmKwZPMtwthM=
X-Google-Smtp-Source: AMsMyM64ws5Y05x+vUdUePPjPAkHmclRkTulEVdGCU/lRp2HVxIlR7wk9tLb+L20MrANxgNdVlKRnxR8ij5PBzLTWtE=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr21914124edb.333.1663707340784; Tue, 20
 Sep 2022 13:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzaoaS8QiPDXuuN1pAiJQ9X6j1WfM+eZhpbRr6ZZ=afZNA@mail.gmail.com>
 <20220909205720.4c73xecxrjrl2vkd@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzazaCKMu5FUB_iZ2z+SVtaw-w8VZhA7EBd9oKKB_o299Q@mail.gmail.com> <20220911223132.vnhyyojwjzdzo4wr@MacBook-Pro-4.local>
In-Reply-To: <20220911223132.vnhyyojwjzdzo4wr@MacBook-Pro-4.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Sep 2022 13:55:29 -0700
Message-ID: <CAEf4BzZSzqkGSZx6BUTGDWKesn_Ws042mG3F0XA=+KFwhKjKzg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 11, 2022 at 3:31 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 09, 2022 at 05:21:52PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > Well, I didn't propose to use suffixes. Currently user can define
> > > > SEC(".data.my_custom_use_case").
> > >
> > > ... and libbpf will mmap such maps and will expose them in skeleton.
> > > My point that it's an existing bug.
> >
> > hm... it's not a bug, it's a desired feature. I wanted
> >
> > int my_var SEC(".data.mine");
> >
> > to be just like .data but in a separate map. So no bug here.
>

Not to bury the actual proposal at the end of this email, I'll put it
here upfront, as I think it's a better compromise.

Given the initial problem was that libbpf creates an mmap-able array
for data sections, how about we make libbpf smarter.

The rule is simple and unambiguous: if ELF data section doesn't
contain any global variable, libbpf will not add MMAPABLE flag? I.e.,
if it's special compiler sections which have no variables, or if it's
user data section that only has static variables (which explicitly are
not to be exposed in BPF skeleton), libbpf just creates non-mmapable
array and we don't expose such sections as skeleton structs.

User can still enforce MMAPABLE flag with explicit
bpf_map__set_map_flags(), if necessary, so if libbpf's default
behavior isn't sufficient and user intended mmapable array, they can
still get this working.

That would cover your use case and won't require any new naming
conventions. WDYT?


> ".rodata.*" and ".data.*" section names are effectively reserved by the compiler.
> Sooner or later there will be trouble if users start mixing compiler
> sections with their own section names like ".data.mine".
> In bpf backend we specicialy check for '.rodata' prefix and avoid emitting BTF.
> llvm can emit .rodata.cst%d, .rodata.str%d.%d, .data.rel, etc
> Not sure how many such special sections will be generated once
> bpf progs will get bigger, but creating them as maps will waste
> plenty of kernel memory due to page align in bpf-array.
> llvm should probably combine them when possible and minimize section
> usage in general, but that's orthogonal.

agree about the combining in LLVM and it's an optimization that libbpf
should be oblivious to

> Mixing user and compiler sections under the same prefix is just asking for trouble.
>

ELF spec specifies that .data/.data1 and .rodata/.rodata1 are special.
And also adds:

  Section names with a dot (.) prefix are reserved for the system,
  although applications may use these sections if their existing meanings
  are satisfactory. Applications may use names without the prefix to avoid
  conflicts with system sections. The object file format lets one define
  sections not in the list above. An object file may have more than one section
  with the same name.

I treat libbpf as "a system" and thus treat .* is reserved for libbpf use.

As for not creating a map for .rodata.cst* and others. Isn't it
exactly the same as for .rodata? Compiler might generate relocation
against that section and will expect to be able to access contents of
such map at runtime (e.g., for struct literals, string constants,
etc). So I don't think we can do that.

> > > Compiler generated .rodata.str1.1 sections should not be messed by
> > > user space. There is no BTF for them either.
> >
> > Shouldn't but could if they wanted to without skeleton as well. In
> > generated skeleton there will be an empty struct for this and no field
> > for each of compiler's constant. User has to intentionally do
> > something to harm themselves, which we can never stop either way.
> >
> > So stuff like .rodata.str1.1 exposes a bit of compiler implementation
> > details, but overall idea of allowing custom .data.xxx and .rodata.xxx
> > sections was to make them mmapable and readable/writable through
> > skeleton.
>
> It's not a good idea to expose compiler internals into skeleton
> and even worse to ask users to operate in the compiler's namespace.
>
> > Carving out some sub-namespace based on special suffix feels wrong.
>
> agree. suffix doesn't work, since prefix is already owned by the compiler.
>
> > > mmap and subsequent write by user space won't cause a crash for bpf prog,
> > > but it won't be doing what C code intended.
> > > There is nothing in there for skeleton and user space to see,
> > > but such map should be created, populated and map_fd provided to the prog to use.
> > >
> > > > So I was proposing that we'll just
> > > > define a different *prefix*, like SEC(".private.enqueue") and
> > > > SEC(".private.dequeue") for your example above, which will be private
> > > > to BPF program, not mmap'ed, not exposed in skeleton.
> > > >
> > > > mmap is a bit orthogonal to exposing in skeleton, you can still
> > > > imagine data section that will be allowed to be initialized from
> > > > user-space before load but never mmaped afterwards. Just to say that
> > > > .nommap doesn't necessarily imply that it shouldn't be in a skeleton.
> > >
> > > Well. That's true for normal skeleton and for lskel,
> > > but not the case for kernel skel that doesn't have mmap.
> > > Exposing a map in skel implies that it will be accessed not only
> > > after _open and before _load, but after load as well.
> > > We can say that mmap != expose in skeleton, but I really don't see
> > > such feature being useful.
> >
> > It's basically what .rodata is, actually. It's something that's
> > settable from user-space before load and that's it. Yes, you can read
> > it after load, but no one does it in practice. But we are digressing,
> > I understand you want to make this short and sweet and I agree with
> > you. I just disagree about wildcard rule for any non-dotted ELF
> > section or using special suffix. See below.
> >
> > >
> > > > So I still prefer special prefix (.private) and declare that this is
> > > > both non-mmapable and not-exposed in skeleton.
> > > >
> > > > As for allowing any section. It just feels unnecessary and long-term
> > > > harmful to allow any section name at this point, tbh.
> > >
> > > Fine. How about a single new character instead of '.private' prefix ?
> > > Like SEC("#enqueue") that would mean no-skel and no-mmap ?
> > >
> > > Or double dot SEC("..enqueue") ?
> > >
> > > '.private' is too verbose and when it's read in the context of C file
> > > looks out of place and confusing.
> >
> > As I said, I gave zero thought to .private, I just took it from
> > ".bss.private". I'd like to keep it "dotted", so SEC("#something") is
> > very "unusual". Me not like.
>
> Why is this unusual? We have SEC("?tc") already.
> SEC("#foo") is very similar.

Unusual because these sections were so far used for BPF programs, not
for data. It's not the end of the world, but just not something I'd
like to do.

> Dot prefix is special. Something compiler will generate
> whereas the section that starts with [A-z] is user's.
> So reserving a prefix that starts from [A-z] would be wrong.

If we allow [a-zA-Z]* sections for data, we introduce potential
conflict for new SEC("abc") program annotations. Why would we do this
and cause more problems?

>
> > For double-dot, could be just SEC("..data") and generalized to
> > SEC("..data.<custom>")? BTW, we can add a macro, similar to __kconfig,
> > to hide more descriptive and longer name. E.g.,
> >
> > struct bpf_spin_lock my_lock __internal;
>
> Macro doesn't help, since the namespace is broken anyway.
> '..data' is dangerous because something might be doing strstr(".data")
> instead of strcmp(".data") and will match that section erroneously.
>

Not breaking broken/naive code is hardly a reason for anything. If
someone is doing strstr() and expects it to work as a prefix check,
well, it's a bug that should be fixed.

> > __internal, __private, __secret, don't know, naming is hard.
>
> Right. We already use special meaning for text section names: tc, xdp
> which is also far from ideal, but that's too late to change.
> For data I'm arguing that only '.[ro]data' should appear in skel
> and compiler internals '.[ro]data.*' should not leak to users.

I disagree. It's an already supported libbpf feature and I think it's
fine to keep it this way. It's not hard to avoid compiler "special"
sections, if it's at all a problem to share that section with the
compiler.

> Then emit all of [A-z] starting sections, since that's what compilers
> and linkers will do, but reserve a single character like '#'
> or whatever other char to mean that this section shouldn't be mmapable.
