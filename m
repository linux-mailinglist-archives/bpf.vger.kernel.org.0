Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07E5B5190
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 00:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIKWbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIKWbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 18:31:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC382655B
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 15:31:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f24so6913405plr.1
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YLFNY9k6rjiecQmTjibs+vLe2qHaUIC505VRJ6oqKUk=;
        b=iZwmQVWEvcmZ28EnDoo9mx6Ym6DyzWVCassqWUWDIRSmVfzFqR3y7NnHAS4Z1RLzPG
         YrxmX7jnhGsiKQzZqNLb86jdaezuqU1GNapRdpJx4BXk8fISHmYA9OrM08uV8K70DSH3
         QQjipOyl0WqViEg6iC17basgRtpjeYrhrGsVsLZSC6/VNZtH7fEfN55xBruiuiCt3xRJ
         qulYpRrffl6IdTBxePyI/qgQw8poHMmuPdGSYUW1IfdJaygIBWB2PwBnnT1rLmALezW8
         MJ3ey9Jq1NgGVavnlVxyJBqPMBMg6stkobfuVE1zlBQDASIVa5L1CLKriXE8hll0CqbC
         5kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YLFNY9k6rjiecQmTjibs+vLe2qHaUIC505VRJ6oqKUk=;
        b=ZoUyWd675A1nriRo6eX+9tC6kctNFALSAvEUbj+YFzJFNXp7CX9trBeUPEPOhjQDri
         idQL5OoPzbgJh/Actx00R/hCJenJHY1d8cRUpF7Zm4AjwoBloCyVylq2zrhgkNVxKISf
         N7JP5SEPSPobBhCZjXvkkye6+SY6g9LrxXpos+jVkRS9BIZSowbNVWUsr7XCBGH+A9rs
         bo/Rmga7mybXxZIXls9/PYn6OvTCbnfSwHkiBh3Larlt6syzFVNGRNCSOn+zQuizm0SU
         0a2p+iWfob0opMYx/H3nHBOnM3FLRDCKn+dRQWwnVYxepGRcNKHmgnCscF0rp88+yssv
         iIhw==
X-Gm-Message-State: ACgBeo07XiSdcDHHuL3X3iarj74j0YUT0wyuRg1wTia21oWX6LNhno62
        gJdrkUXPenTJdeoM3Swp721LQm27Y7gqUQ==
X-Google-Smtp-Source: AA6agR6qhkIbiOjds6ZisEu+ADOw9S4Ih/v3eRRMJ9AqAWYuZQCd1m87HwKSLZVaz+hGuWfz657mLQ==
X-Received: by 2002:a17:90b:1b4a:b0:1f5:5578:6398 with SMTP id nv10-20020a17090b1b4a00b001f555786398mr20681373pjb.122.1662935500279;
        Sun, 11 Sep 2022 15:31:40 -0700 (PDT)
Received: from MacBook-Pro-4.local ([2620:10d:c090:400::5:9b0b])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b00177f8f234cesm2775918plh.258.2022.09.11.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:31:39 -0700 (PDT)
Date:   Sun, 11 Sep 2022 15:31:32 -0700
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
Message-ID: <20220911223132.vnhyyojwjzdzo4wr@MacBook-Pro-4.local>
References: <311eb0d0-777a-4240-9fa0-59134344f051@fb.com>
 <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzaoaS8QiPDXuuN1pAiJQ9X6j1WfM+eZhpbRr6ZZ=afZNA@mail.gmail.com>
 <20220909205720.4c73xecxrjrl2vkd@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzazaCKMu5FUB_iZ2z+SVtaw-w8VZhA7EBd9oKKB_o299Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzazaCKMu5FUB_iZ2z+SVtaw-w8VZhA7EBd9oKKB_o299Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 05:21:52PM -0700, Andrii Nakryiko wrote:
> > >
> > > Well, I didn't propose to use suffixes. Currently user can define
> > > SEC(".data.my_custom_use_case").
> >
> > ... and libbpf will mmap such maps and will expose them in skeleton.
> > My point that it's an existing bug.
> 
> hm... it's not a bug, it's a desired feature. I wanted
> 
> int my_var SEC(".data.mine");
> 
> to be just like .data but in a separate map. So no bug here.

".rodata.*" and ".data.*" section names are effectively reserved by the compiler.
Sooner or later there will be trouble if users start mixing compiler
sections with their own section names like ".data.mine".
In bpf backend we specicialy check for '.rodata' prefix and avoid emitting BTF.
llvm can emit .rodata.cst%d, .rodata.str%d.%d, .data.rel, etc
Not sure how many such special sections will be generated once
bpf progs will get bigger, but creating them as maps will waste
plenty of kernel memory due to page align in bpf-array.
llvm should probably combine them when possible and minimize section
usage in general, but that's orthogonal.
Mixing user and compiler sections under the same prefix is just asking for trouble.

> > Compiler generated .rodata.str1.1 sections should not be messed by
> > user space. There is no BTF for them either.
> 
> Shouldn't but could if they wanted to without skeleton as well. In
> generated skeleton there will be an empty struct for this and no field
> for each of compiler's constant. User has to intentionally do
> something to harm themselves, which we can never stop either way.
> 
> So stuff like .rodata.str1.1 exposes a bit of compiler implementation
> details, but overall idea of allowing custom .data.xxx and .rodata.xxx
> sections was to make them mmapable and readable/writable through
> skeleton.

It's not a good idea to expose compiler internals into skeleton
and even worse to ask users to operate in the compiler's namespace.

> Carving out some sub-namespace based on special suffix feels wrong.

agree. suffix doesn't work, since prefix is already owned by the compiler.

> > mmap and subsequent write by user space won't cause a crash for bpf prog,
> > but it won't be doing what C code intended.
> > There is nothing in there for skeleton and user space to see,
> > but such map should be created, populated and map_fd provided to the prog to use.
> >
> > > So I was proposing that we'll just
> > > define a different *prefix*, like SEC(".private.enqueue") and
> > > SEC(".private.dequeue") for your example above, which will be private
> > > to BPF program, not mmap'ed, not exposed in skeleton.
> > >
> > > mmap is a bit orthogonal to exposing in skeleton, you can still
> > > imagine data section that will be allowed to be initialized from
> > > user-space before load but never mmaped afterwards. Just to say that
> > > .nommap doesn't necessarily imply that it shouldn't be in a skeleton.
> >
> > Well. That's true for normal skeleton and for lskel,
> > but not the case for kernel skel that doesn't have mmap.
> > Exposing a map in skel implies that it will be accessed not only
> > after _open and before _load, but after load as well.
> > We can say that mmap != expose in skeleton, but I really don't see
> > such feature being useful.
> 
> It's basically what .rodata is, actually. It's something that's
> settable from user-space before load and that's it. Yes, you can read
> it after load, but no one does it in practice. But we are digressing,
> I understand you want to make this short and sweet and I agree with
> you. I just disagree about wildcard rule for any non-dotted ELF
> section or using special suffix. See below.
> 
> >
> > > So I still prefer special prefix (.private) and declare that this is
> > > both non-mmapable and not-exposed in skeleton.
> > >
> > > As for allowing any section. It just feels unnecessary and long-term
> > > harmful to allow any section name at this point, tbh.
> >
> > Fine. How about a single new character instead of '.private' prefix ?
> > Like SEC("#enqueue") that would mean no-skel and no-mmap ?
> >
> > Or double dot SEC("..enqueue") ?
> >
> > '.private' is too verbose and when it's read in the context of C file
> > looks out of place and confusing.
> 
> As I said, I gave zero thought to .private, I just took it from
> ".bss.private". I'd like to keep it "dotted", so SEC("#something") is
> very "unusual". Me not like.

Why is this unusual? We have SEC("?tc") already.
SEC("#foo") is very similar.
Dot prefix is special. Something compiler will generate
whereas the section that starts with [A-z] is user's.
So reserving a prefix that starts from [A-z] would be wrong.

> For double-dot, could be just SEC("..data") and generalized to
> SEC("..data.<custom>")? BTW, we can add a macro, similar to __kconfig,
> to hide more descriptive and longer name. E.g.,
> 
> struct bpf_spin_lock my_lock __internal;

Macro doesn't help, since the namespace is broken anyway.
'..data' is dangerous because something might be doing strstr(".data")
instead of strcmp(".data") and will match that section erroneously.

> __internal, __private, __secret, don't know, naming is hard.

Right. We already use special meaning for text section names: tc, xdp
which is also far from ideal, but that's too late to change.
For data I'm arguing that only '.[ro]data' should appear in skel
and compiler internals '.[ro]data.*' should not leak to users.
Then emit all of [A-z] starting sections, since that's what compilers
and linkers will do, but reserve a single character like '#'
or whatever other char to mean that this section shouldn't be mmapable.
