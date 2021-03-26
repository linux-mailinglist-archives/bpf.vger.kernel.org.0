Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9C3349E47
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 01:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCZA4x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 20:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCZA40 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 20:56:26 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9227C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 17:56:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z3so3773730ioc.8
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yLYvhytE3EgW46Qf9NrkPKB4jf1paLRLX1SRNTntXkU=;
        b=PWkiskOUYsWHgJ/O67mRqRQNslGKWVZPJz8xOARaryxIv+cvHLDuG29tyeb/0r+pR9
         StINHOULTWMGnP0E7WJHuoA2tO+S+oAnlAv1g4EXF6JLzoxGzanFN7kyXrNfWwgkSUYT
         h8b5AuxvIXW0YvJqekDUxa7LRKj2K/ZdormkIqrpCig1L4ihOQIRlO99r0x3Q03M6wGI
         f5RI2yqth3C5l869xGF/kAxsvQbNA5i51Wc+Bf6197R49gdRhoUp55qf/U96JpRtgJXM
         TXKahmSiiQhTyrUfWhwyaPvpeClH2XYM6fgJn5uIaUuHPDkfJRtx+Rn3kLhgURljAe52
         MJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yLYvhytE3EgW46Qf9NrkPKB4jf1paLRLX1SRNTntXkU=;
        b=dsA9lMbSIvP9il7gDqf59pkdthIrfmVRprROA3Cu6xfKH2i/M+AziKqx0A1NG3jcg8
         tDkqD95Sq9NXPRp/OQ5cJ75rwUelk+Un8cLqk8PeeKyONxKeSS2BVQVW/tLmRlHbZSvo
         m0gmFsE3NgFabZ8ZfrLsERctC2xZTd5I3cQOVWtzFvs0o4FUP0ndbMW2vBJkclxnUgXj
         PcZDqJdchzlONQG2AnAgiAJ2EVFLfDl0bRZKuQh7OuSyTwQwlqRowg5ye6COSZfInFx5
         bN05CJvXUBCRsLeNZnMzEVAO7u18g0DH0nJxK10Yucs8W79rDKOp0n0mgwppXkhgLg5N
         re/A==
X-Gm-Message-State: AOAM53167zocY27yJqEZ9Oe7BQYpCRwZEr4Lu/eb4wInc5COQvPTHS9s
        ViopmaKlvG/5sVMZdD82vdc=
X-Google-Smtp-Source: ABdhPJzqZ+gbAEXjBqlg0/Ow3QkMXbT49JKv+5+c4bgMxPfD/XqvrjeSgXK2j+2ArlwSrxmmLzAuVw==
X-Received: by 2002:a6b:5818:: with SMTP id m24mr8139234iob.144.1616720184420;
        Thu, 25 Mar 2021 17:56:24 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id a14sm3531322ilm.68.2021.03.25.17.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:56:23 -0700 (PDT)
Date:   Thu, 25 Mar 2021 17:56:14 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Message-ID: <605d312ebe3e6_938e5208e@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzaY-iBDNg5m7EfW355HjZxayydFRHGN9P95oT-Ovm2Mpg@mail.gmail.com>
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
 <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch>
 <CAEf4BzaY-iBDNg5m7EfW355HjZxayydFRHGN9P95oT-Ovm2Mpg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute
 setter
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Mon, Mar 22, 2021 at 10:31 PM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Rafael David Tinoco wrote:
> > > Unfortunately some distros don't have their kernel version defined
> > > accurately in <linux/version.h> due to different long term support
> > > reasons.
> > >
> > > It is important to have a way to override the bpf kern_version
> > > attribute during runtime: some old kernels might still check for
> > > kern_version attribute during bpf_prog_load().
> > >
> > > Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c   | 10 ++++++++++
> > >  tools/lib/bpf/libbpf.h   |  1 +
> > >  tools/lib/bpf/libbpf.map |  1 +
> > >  3 files changed, 12 insertions(+)
> > >
> >
> > Hi Andrii and Rafael,
> >
> > Did you consider making kernel version an attribute of the load
> > API, bpf_prog_load_xattr()? This feels slightly more natural
> > to me, to tell the API the kernel you need at load time.
> 
> Um... kern_version is already part of bpf_load_program_attr, used by
> bpf_load_program_xattr. What am I missing? But you can't use that with
> bpf_object APIs.

Aha I mistyped. It looks like I have a patch floating around on my
stack to add it to bpf_object_load_attr.


> >
> > Although, I don't use the skeleton pieces so maybe it would be
> > awkward for that usage.
> 
> Yes, low-level APIs are separate. This is for cases where you have
> struct bpf_program abstractions, which are loaded by
> bpf_object__load(). We could set it at per-program level, but they
> should be all the same, so bpf_object__set_kversion() makes more sense
> and is more convenient to use. And there is already a getter for that,
> so it complements that nicely.

+1

> 
> >
> > Sorry, missed v1,v2 so didn't reply sooner.
> >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 058b643cbcb1..3ac3d8dced7f 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -8269,6 +8269,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
> > >       return obj->btf ? btf__fd(obj->btf) : -1;
> > >  }
> > >
> > > +int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
> > > +{
> > > +     if (obj->loaded)
> > > +             return -EINVAL;
> > > +
> > > +     obj->kern_version = kern_version;
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > Having a test to read uname and feed it into libbpf using
> > above to be sure we don't break this in the future would be
> > nice.
> 
> kern_version has been ignored by kernel for a long time. So there is
> no way to test this in selftests/bpf. We could use libbpf CI's old
> kernel setup to validate, but I don't think it's worth it. It's
> extremely unlikely this will ever change or break (and it's a legacy
> stuff we move away from anyways, so it's born sort of obsolete).

+1

For the patch, thanks for the details Andrii, thanks for the patch
Rafael it will be useful here.

Acked-by: John Fastabend <john.fastabend@gmail.com>
