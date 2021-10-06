Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E164247B7
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhJFUJH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 16:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239279AbhJFUJG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 16:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633550833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHzIelJadnRS/j3Vm7h6CrTo9MDSeVUCHjzInhdbR2g=;
        b=e8R1KOvIqrbCXbueaIHoZg/MqG4ZSvmE5hTLQDS5yOCILtrbkxmkAVAFH/B/nrtUiIv82I
        c10+1u3yghIivNB7SqMdwBls9SUbj2zy84ANcZsA7WK1UFoulN30CojKhp8l1QhtZXvCTc
        dtvvOmpU8f4IViEgGmtcMQwe3kVL2D0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ojwUXu2fOLutld0sHmalVg-1; Wed, 06 Oct 2021 16:07:10 -0400
X-MC-Unique: ojwUXu2fOLutld0sHmalVg-1
Received: by mail-wr1-f70.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso2893328wrb.20
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 13:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHzIelJadnRS/j3Vm7h6CrTo9MDSeVUCHjzInhdbR2g=;
        b=dUpUc+36udk6EA15ydG1G+RscSimN4x7DsLkPJrpyyqVu212j0s8gFGyFfPaG8/h0j
         SflYeSlHsU64ito4oCs1KPwE94+bdSfDoYZn5HCzS+eu2tmXdUOYN+DqJ1DdQEPdKIJI
         u9OoaFBgC5LHdbzvJvbnyvG58jETRfTh3qIg6UoQFw8f6ImVHXkiaEmv+DDeYGrMfeUs
         /RtAgd2bMs2nGAfeEjuzuHWaLVZxJt18a++MvRAYJuriUR4HdlLpRQw8eWGRGCz8P2FP
         8aRN13z25kjhkjiBWw6dYnHnFAvkYvaLvEcYJ9veLGlk4L+d/LSJI/PmUbETdw1cQpvQ
         vuWg==
X-Gm-Message-State: AOAM533FcOwS2zPQJDlVC5SDKhXf8D6tIP+A9/IO+rLXaynA1OgdKkfi
        gzKw14/QB6Q7D/S1wUUUKeV7//t21n9OLC+nVfd16fPfrp6s7zPvhVDWmWuzLPLSgyK2BqyOLs5
        uAkt7uYx3WXdF
X-Received: by 2002:adf:9791:: with SMTP id s17mr173947wrb.122.1633550829184;
        Wed, 06 Oct 2021 13:07:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo2gS7y2xl/y0Q9acKCMNNR3wL2fxqFLbprZzYf1iP9T6dmu/b4rBaNjc7gJGDdzRbsvEgHQ==
X-Received: by 2002:adf:9791:: with SMTP id s17mr173917wrb.122.1633550829029;
        Wed, 06 Oct 2021 13:07:09 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id l21sm7271308wmg.18.2021.10.06.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:07:08 -0700 (PDT)
Date:   Wed, 6 Oct 2021 22:07:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] store function address in BTF
Message-ID: <YV4B6nUbtCVLHbZW@krava>
References: <YV1hRboJopUBLm3H@krava>
 <YV1h+cBxmYi2hrTM@krava>
 <CAADnVQLeHHBsG3751Ld3--w6KEM1a+8V4KY8MReexWo+bLgdmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLeHHBsG3751Ld3--w6KEM1a+8V4KY8MReexWo+bLgdmg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 06, 2021 at 07:53:31AM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 6, 2021 at 1:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 10:41:41AM +0200, Jiri Olsa wrote:
> > > hi,
> > > I'm hitting performance issue and soft lock ups with the new version
> > > of the patchset and the reason seems to be kallsyms lookup that we
> > > need to do for each btf id we want to attach
> >
> > ugh, I meant to sent this as reply to the patchset mentioned above,
> > nevermind, here's the patchset:
> >   https://lore.kernel.org/bpf/20210605111034.1810858-1-jolsa@kernel.org/
> >
> > jirka
> >
> > >
> > > I tried to change kallsyms_lookup_name linear search into rbtree search,
> > > but it has its own pitfalls like duplicate function names and it still
> > > seems not to be fast enough when you want to attach like 30k functions
> > >
> > > so I wonder we could 'fix this' by storing function address in BTF,
> > > which would cut kallsyms lookup completely, because it'd be done in
> > > compile time
> > >
> > > my first thought was to add extra BTF section for that, after discussion
> > > with Arnaldo perhaps we could be able to store extra 8 bytes after
> > > BTF_KIND_FUNC record, using one of the 'unused' bits in btf_type to
> > > indicate that? or new BTF_KIND_FUNC2 type?
> > >
> > > thoughts?
> 
> That would be on top of your next patch set?
> Please post it first.

ok, will do

jirka

