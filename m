Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC95B3EDE
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIIScz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIIScy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 14:32:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB12124609
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 11:32:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nc14so6005707ejc.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z2Alu4CjbG0QDhSCOyzS4G1WOd2Dnx8q235PQuLbeNA=;
        b=fCl8JZ0UfdPQZVV1/e8wuXkpJ63xEVK4BRyWh9b9cozdvx63Gv1canra+MoJIRHexw
         oJx+pEkWO2NyODUKu+5ZMnHM141jjWiBOEo1OB5UwtbrCJsytOoLaYiZqyNgpJlZqzPu
         bad1x/utSF+bUTSt/TacKIQBmWMqQ0secwZZmO9tG85R+O+jyDY1az5Qm+Gl6AaFdPys
         kbGG+aG7qgwQkq9Q1Uf3aa23X+KtBS+iOKwTyxO7lVHoO4YHZT71c4q4ZBE+rUtBxY6d
         WlM/szbwo9pgmD92ri1sf2yUBPcN+eXol7ju4H1/9SNR1/rKKOlydC8ofl5PyXKsmbnR
         L9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z2Alu4CjbG0QDhSCOyzS4G1WOd2Dnx8q235PQuLbeNA=;
        b=ni148WsGyoZVysQrQRa/F+W8bFPy0Q4zptW4irtpPFA8G5scpwQ+/suGs08SydyB/l
         HfHRWVVHCipb/b2Y/LdRM/rmPnNHkMg3lfJILLio1EA3xrS7coPmYNeq7CRUuhvQxFjj
         0Si1zFLeotYZOXMwO1COjenXA0dgFIyXde7kcIxD1d9Bmh7ORnfA/qxRwzmmjpsarVQm
         QUutmthJhUqMAxhNM0lh5n1M/Vv+5UCZfi4pCIX10K8wnNRkNAxg6+G7eSyg3uddYWR+
         bnvwF79yy1Pxm+bs85pdxrC6xoDdphOByUWA67h8Xktw/WwrG7XZxEV3ccPiGCwzz/3o
         jwqw==
X-Gm-Message-State: ACgBeo1wRmr4PjWu1e0vq0rmY6sIFldv7oZWewNANsZbDFkd8JKp3yLZ
        2G6R6JsYgCri3Daywm8mIObw/udLv+hBlkl55L8=
X-Google-Smtp-Source: AA6agR6/GXZwWQl7qnHS4l2cZJ/HPiOp250r1ysBmZ/hSZ+YmzBonY31e6EMKCf80vf4zyNDStdAueI9GI5WAW+15aY=
X-Received: by 2002:a17:907:2bd8:b0:770:77f2:b7af with SMTP id
 gv24-20020a1709072bd800b0077077f2b7afmr1319476ejc.545.1662748371453; Fri, 09
 Sep 2022 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com> <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
In-Reply-To: <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 11:32:40 -0700
Message-ID: <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
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

On Fri, Sep 9, 2022 at 7:58 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > > > >
> > > > > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > > > > Global variables reside in maps accessible using direct_value_addr
> > > > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > > > disallows us from holding locks which are global.
> > > > > >
> > > > > > This is not great, so refactor the active_spin_lock into two separate
> > > > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > > > enough to allow it for global variables, map lookups, and local kptr
> > > > > > registers at the same time.
> > > > > >
> > > > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > > > whether bpf_spin_unlock is for the same register.
> > > > > >
> > > > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > > > are doing lookup for the same map value (max_entries is never greater
> > > > > > than 1).
> > > > > >
> > > > >
> > > > > For libbpf-style "internal maps" - like .bss.private further in this series -
> > > > > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> > > > >
> > > > >   struct bpf_spin_lock lock1 SEC(".bss.private");
> > > > >   struct bpf_spin_lock lock2 SEC(".bss.private");
> > > > >   ...
> > > > >   spin_lock(&lock1);
> > > > >   ...
> > > > >   spin_lock(&lock2);
> > > > >
> > > > > will result in same map but different offsets for the direct read (and different
> > > > > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > > > > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> > > > >
> > > >
> > > > That won't be a problem. Two spin locks in a map value or datasec are
> > > > already rejected on BPF_MAP_CREATE,
> > > > so there is no bug. See idx >= info_cnt check in
> > > > btf_find_struct_field, btf_find_datasec_var.
> > > >
> > > > I can include offset as the third part of the tuple. The problem then
> > > > is figuring out which lock protects which bpf_list_head. We need
> > > > another __guarded_by annotation and force users to use that to
> > > > eliminate the ambiguity. So for now I just put it in the commit log
> > > > and left it for the future.
> > >
> > > Let's not go that far yet.
> > > Extra annotations are just as confusing and non-obvious as
> > > putting locks in different sections.
> > > Let's keep one lock per map value limitation for now.
> > > libbpf side needs to allow many non-mappable sections though.
> > > Single bss.private name is too limiting.
> >
> > In that case,
> > Dave, since the libbpf patch is yours, would you be fine with
> > reworking it to support multiple private maps?
> > Maybe it can just ignore the .XXX part in .bss.private.XXX?
> > Also I think Andrii mentioned once that he wants to eventually merge
> > data and bss, so it might be a good idea to call it .data.private from
> > the start?
>
> I'd probably make all non-canonical names to be not-mmapable.
> The compiler generates special sections already.
> Thankfully the code doesn't use them, but it will sooner or later.
> So libbpf has to create hidden maps for them eventually.
> They shouldn't be messed up from user space, since it will screw up
> compiler generated code.
>
> Andrii, what's your take?

Ok, a bunch of things to unpack. We've also discussed a lot of this
with Dave few weeks ago, but I have also few questions.

First, I'd like to not keep extending ".bss" with any custom ".bss.*"
sections. This is why we have .data.* and .rodata.* and not .bss (bad,
meaningless, historic name).

But I'm totally fine dedicating some other prefix to non-mmapable data
sections that won't be exposed in skeleton and, well, not-mmapable.
What to name it depends on what we anticipate putting in them?

If it's just for spinlocks, then having something like SEC(".locks")
seems best to me. If it's for more stuff, like global kptrs, rbtrees
and whatnot, then we'd need a bit more generic name (.private, or
whatever, didn't think much on best name). We can also allow .locks.*
or .private.* (i.e., keep it uniform with .data and .rodata handling,
expect for mmapable aspect).

One benefit for having SEC(".locks") just for spin_locks is that we
can teach libbpf to create a multi-element ARRAY map, where each lock
variable is put into a separate element. From BPF verifier's
perspective, there will be a single BTF type describing spin lock, but
multiple "instances" of lock, one per each element. That seems a bit
magical and I think, generally speaking, it's best to start supporting
multiple lock declarations within single map element (and thus keep
track of their offset within map_value); but at least that's an
option.

Dave had some concerns about pinning such maps and whatnot, but for
starters we decided to not worry about pinning for now. Dave, please
bring up remaining issues, if you don't mind.

So to answer Alexei's specific option. I'm still not in favor of just
saying "anything that's not .data or .rodata is non-mmapable map". I'd
rather carve out naming prefixes with . (which are  reserved for
libbpf's own use) for these special purpose maps. I don't think that
limits anyone, right?
