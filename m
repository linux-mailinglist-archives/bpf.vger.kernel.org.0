Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FA1E693C
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405774AbgE1SV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405744AbgE1SV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:21:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45551C08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:21:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so4025877qkf.9
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6x4YW2HE3g1U+cpAeFswoFndpL5GmLQ3E12lHWrPD2A=;
        b=Guuefrf76288xNNUFTUYQ+5pqq4uHrBvCfKmu6bVo5F3JMFqrgnpeRWzcfD1UR+Faz
         LXC4cmvzdP0xHK/9mPUuKzgBntk5wam3ju1m853sp7TAmfGb5nj088APRDgDy19MeI5r
         iTSuOAb5ODYC7nswNaVFywrzeKsrY8iCB0SYtnOf5CHVZvojsk6r/1gqqpx2W1SXLaWP
         u1XkAyymL/klnl/N48Ib+Oi/ZjDk975MySMlIJEKKGrdufFHKA0/3UJNyOAZ9P59tbUn
         cciEgzuDdjRc5o6p1kMZh5chhUjs7oPlJJXe6XNfjB0aSrOklJJ34svnEBFqchrEwIME
         IEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6x4YW2HE3g1U+cpAeFswoFndpL5GmLQ3E12lHWrPD2A=;
        b=EHQZI5a15XnMcdpp9w+o9UsBBePZ3VAuezvV1KZhrD87ou/kbTfQMbHujqBInPZRkS
         n0v5gjlFjbVRqMjcxtZjf/evqpTazvwSHc3aGucDpSUODVbC7TcCeoMVK92U4boYtrdo
         nulqq0br1ySGyg+0G/5Pcz46vhYNM3xMBUEc+REG4oPnQmtiY1ZluM6vi5OPSwEqeqij
         csN3agnW0m0bqvFMZQFoB7t9d+H3BbfcdAm5kLKnxkAN8HplR36cA9UQwK1PhufdY7ko
         vuD96uIEDsfnEzDu31xNrcGE1TJvlGI2uXlcZnqXrcMPIqnflUezWPKA4F69kg75Rf1c
         F88g==
X-Gm-Message-State: AOAM532YGbrhBLAviT+Q/cQQfJOKfsZWRGxER4M4JU+X+/aLZgtwpoyC
        y87LJ2DPni0ZblYVcgPXY5N28zUTfZLuMe3wIyk=
X-Google-Smtp-Source: ABdhPJyBPp5u34v8jboArjygdDFJ+AbeDROxUJiJmyptm5AX0WWzVsG5BK3f/71TsCmN997sFXIM3FYu3kkpnUicstY=
X-Received: by 2002:a37:6508:: with SMTP id z8mr4146126qkb.39.1590690116427;
 Thu, 28 May 2020 11:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <159057923399.191121.11186124752660899399.stgit@firesoul>
 <CAEf4Bzavr2hLv+Z0be0_uGRfPqNsBKAsQL7MpQUoXQX46rj4eA@mail.gmail.com> <20200528090842.6fb4e42d@carbon>
In-Reply-To: <20200528090842.6fb4e42d@carbon>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 11:21:45 -0700
Message-ID: <CAEf4BzZ0L=J9PbYndB4rFLvBEnZR6opUppDnD=b9BXsR2AR0cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: Fix map_check_no_btf return code
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 12:08 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 27 May 2020 15:59:46 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > But regardless, can you please reply on v1 thread why adding support
> > for BTF to these special maps (that do not support BTF right now)
> > won't be a better solution and won't work (as you claimed)?
>
> (I will reply here instead of on v1) and I have not claimed it won't

Well, maybe I misinterpreted your response from that thread, but not
sure how I should have interpreted it differently:

> > > For special maps, we can just enforce
> > > that BTF is 4-byte integer (or typedef of that), so that in practice
> > > you'll be defining it as:
> > >
> > > struct {
> > >     __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> > >     __type(key, u32);
> > >     __type(value, u32);
> > > } my_map SEC(".maps");
> > >
> > > and it will just work?
> >
> > Nope, this will also fail.
>
> Why? If kernel supports 4-byte integers as BTF types for key/value for
> such maps, then what would fail in this case?


> work.  It will work, but we loose an opportunity if we just allow BTF
> across the board, without using it for per map validation.

I don't see how we are losing any extensibility, honestly. Right now
we can allow simple "4-byte integer". If we need to extend it in the
future, we'll allow 4-byte integer (for backwards compatibility), and
whatever struct makes sense for extended use case. But maybe I don't
completely understand what you are after here. See below.

>
> We have an opportunity with these special maps, that do not support BTF
> right now.  The value field in these maps are actually a UAPI and also
> kABI (Binary).
>
> Simply describing the struct with BTF is nice, but only helpful to make
> the end-user understand they binary layout.  On the kernel side we are
> still stuck with a kABI that can only be end-extended and size increased.
> I want to use BTF on the kernel-side to validate and enforce that user
> provided the expected "named" layout, and possibly reject it.  This
> gives us a layer that can provide a flexible kABI.  From my current
> understanding of the kernel side code that parse/walk BTF, I we can
> actually have flexible offsets (for e.g. structs) in the binary value,
> and remap those on the kernel side.  Enforcing a named layout when we
> enable BTF for these maps, will give us binary flexibility for future
> changes.  I hope you agree?

Can you expand on this named approach and what are the use cases you
are seeing? I guess it's something like what is done for
bpf_spin_lock, where we require struct with well-defined name and
field name, etc. But please elaborate here.


My biggest grudge with changing error code is that old error code will
still be used in older kernels, so if libbpf were to help users with
more helpful message, it now needs to support both error codes,
forever, potentially depending on kernel version. This constant
splitting of logic is annoying, so I'd rather avoid it.

>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
