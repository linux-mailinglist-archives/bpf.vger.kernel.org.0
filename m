Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136E5B3F76
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIITZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIITZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:25:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA1CB5159
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:25:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pj10so2398544pjb.2
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QHW8ux7wp+zJ3YDV12s9JA4OE1zTUpmqSydS3IuDiTg=;
        b=eJqzU5Tae+goNacSd+ykMJNW8qpS/+8de/1um6XG/1XsbJb77aKnUc1u5hw5HOA5XX
         goqtEfxqx08SE/J66DPze+KxDoYLVxNw7IXxE7h9fxyrBEjs8bVTGcp2jCycCQMv8x7M
         aZap90cYR8ZeLP3dKgtaN16ioSKToHxiNCLTj1ESkG5JdxD0AzUsfzCeiK7EmierqKwq
         jbTMOftUf68Brc7zYlpZE2OCjy1CY/08t+wvcErQ/DoxRV8p9j/PjhdrpmJtRd2ZtKW/
         fqB+LN5+/18KdQbHEmTR5RZEX0BUz4EAj4SbV5aHzIhlgy1i3heGe4rskzqqZ0RR6aSc
         qqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QHW8ux7wp+zJ3YDV12s9JA4OE1zTUpmqSydS3IuDiTg=;
        b=rfwKWm4IlOjk0gvk48/LTpC3Lix6zoy+C5aLh7naxUjLISQYFAQBde4HPpH/4zZjbh
         30IcMrf0EQGLpoPd3iHxmyl0/grrdBk+OcE+vTpW2eR/1xP5Dwqtnuyi4dnCo9Rj3hEy
         5n2SlFammdmsUml/D6u/T6aY6vNwWuRAwIsZ1FG4foOO39q9JasmFDf2Ix/EfU5cvugk
         0pvrGwv+kW1I6NV/3pjVGb7OZ9fJ8LNPxMjaV57ER5XRDE30VBqnfZE23v1Q9Trzqzs8
         GAG7HcwVDmXaChyAjbvLht6L21g84PCt/HdpebBGdP/ZJy37/wQdSGEDv9pP94aoLFUu
         io/g==
X-Gm-Message-State: ACgBeo3XcdBPKahU75CaImH8gIZVk2P8OCqGIJgzw/oxNMDLjoq5xjTT
        hhp241ICrOmUZWJIJkK+QReomwpXoP4=
X-Google-Smtp-Source: AA6agR7cv/n5gDQvxgbsKLcT+JBBrXNOQI5fKPQAsMujkzjsORAfd0Sg0nnthiwKP+Xbc153FixY4w==
X-Received: by 2002:a17:902:bc44:b0:176:909f:f636 with SMTP id t4-20020a170902bc4400b00176909ff636mr14841799plz.21.1662751528726;
        Fri, 09 Sep 2022 12:25:28 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5aff])
        by smtp.gmail.com with ESMTPSA id ij17-20020a170902ab5100b0016dc26c7d30sm818944plb.164.2022.09.09.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:25:28 -0700 (PDT)
Date:   Fri, 9 Sep 2022 12:25:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
 <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 11:32:40AM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 9, 2022 at 7:58 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 9, 2022 at 7:51 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Fri, 9 Sept 2022 at 16:24, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 9, 2022 at 4:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > > >
> > > > > On Fri, 9 Sept 2022 at 10:13, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > > > > >
> > > > > > On 9/4/22 4:41 PM, Kumar Kartikeya Dwivedi wrote:
> > > > > > > Global variables reside in maps accessible using direct_value_addr
> > > > > > > callbacks, so giving each load instruction's rewrite a unique reg->id
> > > > > > > disallows us from holding locks which are global.
> > > > > > >
> > > > > > > This is not great, so refactor the active_spin_lock into two separate
> > > > > > > fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> > > > > > > enough to allow it for global variables, map lookups, and local kptr
> > > > > > > registers at the same time.
> > > > > > >
> > > > > > > Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> > > > > > > reg->map_ptr or reg->btf pointer of the register used for locking spin
> > > > > > > lock. But the active_spin_lock_id also needs to be compared to ensure
> > > > > > > whether bpf_spin_unlock is for the same register.
> > > > > > >
> > > > > > > Next, pseudo load instructions are not given a unique reg->id, as they
> > > > > > > are doing lookup for the same map value (max_entries is never greater
> > > > > > > than 1).
> > > > > > >
> > > > > >
> > > > > > For libbpf-style "internal maps" - like .bss.private further in this series -
> > > > > > all the SEC(".bss.private") vars are globbed together into one map_value. e.g.
> > > > > >
> > > > > >   struct bpf_spin_lock lock1 SEC(".bss.private");
> > > > > >   struct bpf_spin_lock lock2 SEC(".bss.private");
> > > > > >   ...
> > > > > >   spin_lock(&lock1);
> > > > > >   ...
> > > > > >   spin_lock(&lock2);
> > > > > >
> > > > > > will result in same map but different offsets for the direct read (and different
> > > > > > aux->map_off set in resolve_pseudo_ldimm64 for use in check_ld_imm). Seems like
> > > > > > this patch would assign both same (active_spin_lock_ptr, active_spin_lock_id).
> > > > > >
> > > > >
> > > > > That won't be a problem. Two spin locks in a map value or datasec are
> > > > > already rejected on BPF_MAP_CREATE,
> > > > > so there is no bug. See idx >= info_cnt check in
> > > > > btf_find_struct_field, btf_find_datasec_var.
> > > > >
> > > > > I can include offset as the third part of the tuple. The problem then
> > > > > is figuring out which lock protects which bpf_list_head. We need
> > > > > another __guarded_by annotation and force users to use that to
> > > > > eliminate the ambiguity. So for now I just put it in the commit log
> > > > > and left it for the future.
> > > >
> > > > Let's not go that far yet.
> > > > Extra annotations are just as confusing and non-obvious as
> > > > putting locks in different sections.
> > > > Let's keep one lock per map value limitation for now.
> > > > libbpf side needs to allow many non-mappable sections though.
> > > > Single bss.private name is too limiting.
> > >
> > > In that case,
> > > Dave, since the libbpf patch is yours, would you be fine with
> > > reworking it to support multiple private maps?
> > > Maybe it can just ignore the .XXX part in .bss.private.XXX?
> > > Also I think Andrii mentioned once that he wants to eventually merge
> > > data and bss, so it might be a good idea to call it .data.private from
> > > the start?
> >
> > I'd probably make all non-canonical names to be not-mmapable.
> > The compiler generates special sections already.
> > Thankfully the code doesn't use them, but it will sooner or later.
> > So libbpf has to create hidden maps for them eventually.
> > They shouldn't be messed up from user space, since it will screw up
> > compiler generated code.
> >
> > Andrii, what's your take?
> 
> Ok, a bunch of things to unpack. We've also discussed a lot of this
> with Dave few weeks ago, but I have also few questions.
> 
> First, I'd like to not keep extending ".bss" with any custom ".bss.*"
> sections. This is why we have .data.* and .rodata.* and not .bss (bad,
> meaningless, historic name).
> 
> But I'm totally fine dedicating some other prefix to non-mmapable data
> sections that won't be exposed in skeleton and, well, not-mmapable.
> What to name it depends on what we anticipate putting in them?
> 
> If it's just for spinlocks, then having something like SEC(".locks")
> seems best to me. If it's for more stuff, like global kptrs, rbtrees
> and whatnot, then we'd need a bit more generic name (.private, or
> whatever, didn't think much on best name). We can also allow .locks.*
> or .private.* (i.e., keep it uniform with .data and .rodata handling,
> expect for mmapable aspect).
> 
> One benefit for having SEC(".locks") just for spin_locks is that we
> can teach libbpf to create a multi-element ARRAY map, where each lock
> variable is put into a separate element. From BPF verifier's
> perspective, there will be a single BTF type describing spin lock, but
> multiple "instances" of lock, one per each element. That seems a bit
> magical and I think, generally speaking, it's best to start supporting
> multiple lock declarations within single map element (and thus keep
> track of their offset within map_value); but at least that's an
> option.

".lock" won't work. We need lock+rb_root or lock+list_head to be
in the same section.
It should be up to user to name that section with something meaningful.
Ideally something like this should be supported:
SEC("enqueue") struct bpf_spin_lock enqueue_lock;
SEC("enqueue") struct bpf_list_head enqueue_head __contains(foo, node);
SEC("dequeue") struct bpf_spin_lock dequeue_lock;
SEC("dequeue") struct bpf_list_head dequeue_head __contains(foo, node);

> Dave had some concerns about pinning such maps and whatnot, but for
> starters we decided to not worry about pinning for now. Dave, please
> bring up remaining issues, if you don't mind.

Pinning shouldn't be an issue.
Only mmap is the problem. User space access if fine since kernel
will mask out special fields on read/write.

> So to answer Alexei's specific option. I'm still not in favor of just
> saying "anything that's not .data or .rodata is non-mmapable map". I'd
> rather carve out naming prefixes with . (which are  reserved for
> libbpf's own use) for these special purpose maps. I don't think that
> limits anyone, right?

Is backward compat a concern?
Whether to mmap global data is a flag.
It can be opt-in or opt-out.
I'm proposing make all named section to be 'do not mmap'.
If a section needs to be mmaped and appear in skeleton the user can do
SEC("my_section.mmap")

What you're proposing is to do the other way around:
SEC("enqueue.nommap")
SEC("dequeue.nommap")
in the above example.
I guess it's fine, but more verbose.
The gut feeling is that the use case for naming section will be specifically
for lock+rbtree. Everything else will go into common global .data or .rodata.
Same thinking about compiler generated special sections with constants.
They shouldn't be mmaped by default, but we're not going to hack llvm
to add ".nommap" suffix to such sections.
Hence the proposal to avoid mmap by default for all non standard sections.
