Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23329D455
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgJ1Vv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727481AbgJ1VvW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kneR4tnwy4pTTLA25Zm/bUt3+Ry5M5dryQBZQKk/NwE=;
        b=UDq7ZtYdaMjtft7Y84jBe/uuOXwITuhfoTgvniu0TY1PyGS3uLIP2l0GjAxMEhrK/IleuH
        gtIV8PBzFUNaAAG+H0tRo1uYXsICWkCE1ZuWvX9oByeiBTBafAj4yMXRnO/ChgrKwdgv60
        L/Exva/LYBL7PWRLDqD1FtQxY+O127Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-OE3dl1aqOH-VWbEVVTG89g-1; Wed, 28 Oct 2020 11:49:34 -0400
X-MC-Unique: OE3dl1aqOH-VWbEVVTG89g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57CD6760C1;
        Wed, 28 Oct 2020 15:49:32 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 61D0960C04;
        Wed, 28 Oct 2020 15:49:26 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:49:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [RFC 0/3] pahole: Workaround dwarf bug for function encoding
Message-ID: <20201028154925.GO2900849@krava>
References: <20201026223617.2868431-1-jolsa@kernel.org>
 <CAEf4Bzav_WF3duq4JYmaPvyUXdREkXJMPAb+ASUxAxq_mqXd5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzav_WF3duq4JYmaPvyUXdREkXJMPAb+ASUxAxq_mqXd5Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 04:13:46PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > because of gcc bug [1] we can no longer rely on DW_AT_declaration
> > attribute to filter out declarations and end up with just
> > one copy of the function in the BTF data.
> >
> > It seems this bug is not easy to fix, but regardless if the
> > it's coming soon, it's probably good idea not to depend so
> > much only on dwarf data and make some extra checks.
> >
> > Thus for function encoding we are now doing following checks:
> >   - argument names are defined for the function
> >   - there's symbol and address defined for the function
> >   - function is generated only once
> >
> > These checks ensure that we encode function with defined
> > symbol/address and argument names.
> >
> > I marked this post as RFC, because with this workaround in
> > place we are also encoding assembly functions, which were
> > not present when using the previous gcc version.
> >
> > Full functions diff to previous gcc working version:
> >
> >   http://people.redhat.com/~jolsa/functions.diff.txt
> >
> > I'm not sure this does not break some rule for functions in
> > BTF data, becuse those assembly functions are not attachable
> > by bpf trampolines, so I don't think there's any use for them.
> 
> What will happen if we do try to attach to those assembly functions?
> Will there be some corruption or crash, or will it just fail and

the attach code checks for the __fentry__ nop,
so it will fail probably with EBUSY

> return error cleanly? What we actually want in BTF is all the
> functions that are attachable through BPF trampoline, which is all the
> functions that ftrace subsystem can attach to, right? So how does
> ftrace system know what can or cannot be attached to?

not sure, I think it records all the functions with
__fentry__ calls, perhaps we could take these records
as base for FUNCs, I'll check

jirka

> 
> >
> > thoughts?
> > jirka
> >
> >
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> > ---
> > Jiri Olsa (3):
> >       btf_encoder: Move find_all_percpu_vars in generic config function
> >       btf_encoder: Change functions check due to broken dwarf
> >       btf_encoder: Include static functions to BTF data
> >
> >  btf_encoder.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
> >  elf_symtab.h  |   8 +++++
> >  2 files changed, 170 insertions(+), 59 deletions(-)
> >
> 

