Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2371DA3BB
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgESVkG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESVkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 17:40:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B7C08C5C0
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 14:40:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so425466plr.4
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZrnOBqdIK/f9ZKEYvAl0vw/13DRB3RwIGSmwGXyTpI=;
        b=YD0FWr1n4aRBwXbRpkumGdVcnRnTBzs8xC53EtpY/+CDnTQq5QrfVWZuUHWHC7t/oC
         GCluPTOCW1KYp8yaGOWLKDdonR1xl0cIqDBBpYL/Jc01xqzgLo2avep6uumO1EeeIe0+
         sqTXfRtYYEmAKVRLMLfBHLUyJCkqlV8EfLlTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZrnOBqdIK/f9ZKEYvAl0vw/13DRB3RwIGSmwGXyTpI=;
        b=kKC/qeO8dvphB52OZiJZ8fKDrsFd3+1C0Yok04D95bf5mcwHaOiPxHQaSWC85Ye9i8
         lMjMOs3RpELQCfeSQbTn+XS7dvBPKEzzCcN/dRBAaqwmWjMf0UzH8TaElLpLN3QAfuD7
         d1CF8dzkZtUmWMqoQpdd18KJJ5rzgJDiK6OY8pOFE+Ehpafd4xVGAwoqtzN1pQGTTEN+
         xF0FuHIPbWfxLysi/FgmYjj25g5lEzIHldUpQRS+IXyelaK1IRGDmCiYhvLs4/iTncYh
         K8Glipt+QKe+FpYiD0IMF7A3oWc7uh0ImUOEVtxAAFyo//qL2Y29bHOD8vx+aox+sMnP
         UzSg==
X-Gm-Message-State: AOAM533G4TKRUvgYCf9+Hjrb/vqPh1S4dYjLDV2BC6GGmRYtfP5hlD26
        lrbHvJYUv2041dQdGTXDLvXUyA==
X-Google-Smtp-Source: ABdhPJxxUbJw24Z12APTaY/3nigy/vJ+nnWJ/bpNRl0x+5MCtEWwJIZ0w7jwgPf8UyhhfpOzN1YH0w==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr1369227pls.291.1589924403251;
        Tue, 19 May 2020 14:40:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n67sm370238pfn.16.2020.05.19.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:40:01 -0700 (PDT)
Date:   Tue, 19 May 2020 14:40:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <202005191434.57253AD@keescook>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
 <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 19, 2020 at 09:18:47AM -0700, Alexei Starovoitov wrote:
> On Mon, May 18, 2020 at 7:53 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2020-05-19, Jann Horn <jannh@google.com> wrote:
> > > On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> > > > ## deep argument inspection
> > > >
> > > > The argument caching bit is, I think, rather mechanical in nature since
> > > > it's all "just" internal to the kernel: seccomp can likely adjust how it
> > > > allocates seccomp_data (maybe going so far as to have it split across two
> > > > pages with the syscall argument struct always starting on the 2nd page
> > > > boundary), and copying the EA struct into that page, which will be both
> > > > used by the filter and by the syscall.
> > >
> > > We could also do the same kind of thing the eBPF verifier does in
> > > convert_ctx_accesses(), and rewrite the context accesses to actually
> > > go through two different pointers depending on the (constant) offset
> > > into seccomp_data.
> >
> > My main worry with this is that we'll need to figure out what kind of
> > offset mathematics are necessary to deal with pointers inside the
> > extensible struct. As a very ugly proposal, you could make it so that
> > you multiply the offset by PAGE_SIZE each time you want to dereference
> > the pointer at that offset (unless we want to add new opcodes to cBPF to
> > allow us to represent this).
> 
> Please don't. cbpf is frozen.

https://www.youtube.com/watch?v=L0MK7qz13bU

If the only workable design paths for deep arg inspection end up needing
BPF helpers, I would agree that it's time for seccomp to grow eBPF
language support. I'm still hoping there's a clean solution that doesn't
require a seccomp language extension.

> > > We don't need to actually zero-fill memory for this beyond what the
> > > kernel supports - AFAIK the existing APIs already say that passing a
> > > short length is equivalent to passing zeroes, so we can just replace
> > > all out-of-bounds loads with zeroing registers in the filter.
> > > The tricky case is what should happen if the userspace program passes
> > > in fields that the filter doesn't know about. The filter can see the
> > > length field passed in by userspace, and then just reject anything
> > > where the length field is bigger than the structure size the filter
> > > knows about. But maybe it'd be slightly nicer if there was an
> > > operation for "tell me whether everything starting at offset X is
> > > zeroes", so that if someone compiles with newer kernel headers where
> > > the struct is bigger, and leaves the new fields zeroed, the syscalls
> > > still go through an outdated filter properly.
> >
> > I think the best way of handling this (without breaking programs
> > senselessly) is to have filters essentially emulate
> > copy_struct_from_user() semantics -- which is along the lines of what
> > you've suggested.
> 
> and cpbf load instruction will become copy_from_user() underneath?

No, this was meaning internal checking about struct sizes needs to exist
(not the user copy parts).

> I don't see how that can work.
> Have you considered implications to jits, register usage, etc ?
> 
> ebpf will become sleepable soon. It will be able to do copy_from_user()
> and examine any level of user pointer dereference.
> toctou is still going to be a concern though,
> but such ebpf+copy_from_user analysis and syscall sandboxing
> will not need to change kernel code base around syscalls at all.
> No need to invent E-syscalls and all the rest I've seen in this thread.

To avoid the ToCToU, the seccomp infrastructure must do the
copy_from_user(), so there's not need for the sleepable stuff in seccomp
that I can see. The question is mainly one of flattening.

-- 
Kees Cook
