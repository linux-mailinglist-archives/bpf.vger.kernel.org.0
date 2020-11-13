Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0362B196B
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMK7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 05:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKMK7g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 05:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605265173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjjycHZm5P6aSgC39M2XF1jdwdTgRDZX9nIwDyf6yQ0=;
        b=M7oMLIeddDkjh1XKX7VDRfpfSNaz0KXX5/jjV+cf7AoLgU9KDEt2SY9xHOgGXI3LrI3Tlt
        RtvVcPnzbOK3/UMy4gKYUDqvWXc44/mUFsI+Vx0GqXDLTLqkCTf7eg6dZBr2RSe7mMRYgl
        J17JQ4PC9X5WWUY+4RRNlJR5nMbkSKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-WATDhn_XPbu68-A6hBHICg-1; Fri, 13 Nov 2020 05:59:28 -0500
X-MC-Unique: WATDhn_XPbu68-A6hBHICg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96D218E78B3;
        Fri, 13 Nov 2020 10:59:26 +0000 (UTC)
Received: from krava (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC7A210002A6;
        Fri, 13 Nov 2020 10:59:24 +0000 (UTC)
Date:   Fri, 13 Nov 2020 11:59:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
Message-ID: <20201113105923.GC753418@krava>
References: <20201112150506.705430-1-jolsa@kernel.org>
 <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava>
 <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 04:08:02PM -0800, Andrii Nakryiko wrote:
> On Thu, Nov 12, 2020 at 1:14 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Nov 12, 2020 at 11:54:41AM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > > @@ -624,32 +644,46 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > >                 has_index_type = true;
> > > >         }
> > > >
> > > > -       cu__for_each_function(cu, core_id, fn) {
> > > > -               /*
> > > > -                * The functions_cnt != 0 means we parsed all necessary
> > > > -                * kernel symbols and we are using ftrace location filter
> > > > -                * for functions. If it's not available keep the current
> > > > -                * dwarf declaration check.
> > > > -                */
> > > > -               if (functions_cnt) {
> > > > +       /*
> > > > +        * The functions_cnt != 0 means we parsed all necessary
> > > > +        * kernel symbols and we are using ftrace location filter
> > > > +        * for functions. If it's not available keep the current
> > > > +        * dwarf declaration check.
> > > > +        */
> > > > +       if (functions_cnt) {
> > > > +               cu__for_each_function(cu, core_id, fn) {
> > > > +                       struct elf_function *p;
> > > > +                       struct elf_function key = { .name = function__name(fn, cu) };
> > > > +                       int args_cnt = 0;
> > > > +
> > > >                         /*
> > > > -                        * We check following conditions:
> > > > -                        *   - argument names are defined
> > > > -                        *   - there's symbol and address defined for the function
> > > > -                        *   - function address belongs to ftrace locations
> > > > -                        *   - function is generated only once
> > > > +                        * Collect functions that match ftrace filter
> > > > +                        * and pick the one with proper argument names.
> > > > +                        * The BTF generation happens at the end in
> > > > +                        * btf_encoder__encode function.
> > > >                          */
> > > > -                       if (!has_arg_names(cu, &fn->proto))
> > > > +                       p = bsearch(&key, functions, functions_cnt,
> > > > +                                   sizeof(functions[0]), functions_cmp);
> > > > +                       if (!p)
> > > >                                 continue;
> > > > -                       if (!should_generate_function(btfe, function__name(fn, cu)))
> > > > +
> > > > +                       if (!has_arg_names(cu, &fn->proto, &args_cnt))
> > >
> > > So I can't unfortunately reproduce that GCC bug with DWARF info. What
> > > was exactly the symptom? Maybe you can also share readelf -wi dump for
> > > your problematic vmlinux?
> >
> > hum, can't see -wi working for readelf, however I placed my vmlinux
> > in here:
> >   http://people.redhat.com/~jolsa/vmlinux.gz
> >
> > the symptom is that resolve_btfids will fail kernel build:
> >
> >   BTFIDS  vmlinux
> > FAILED unresolved symbol vfs_getattr
> >
> > because BTF data contains multiple FUNC records for same function
> >
> > and the problem is that declaration tag itself is missing:
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> > so pahole won't skip them
> >
> > the first workaround was to workaround that and go for function
> > records that have code address attached, but that's buggy as well:
> >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> >
> > then after some discussions we ended up using ftrace addresses
> > as filter for what we want to display.. plus we got static functions
> > as well
> >
> > however for this way we failed to get proper arguments ;-)
> 
> Right, I followed along overall, but forgot the details of the initial
> problem. Thanks for the refresher. See below for my current thoughts
> on dealing with all this.
> 
> >
> > >
> > > The reason I'm asking is because I wonder if we should still ignore
> > > functions if fn->declaration is set. E.g., for the issue we
> > > investigated yesterday, the function with no arguments has declaration
> > > set to 1, so just ignoring it would solve the problem. I'm wondering
> > > if it's enough to do just that instead of doing this whole delayed
> > > function collection/processing.
> > >
> > > Also, I'd imagine the only expected cases where we can override  the
> > > function (args_cnt > p->args_cnt) would be if p->args_cnt == 0, no?
> >
> > I don't know, because originally I'd expect that we would not see
> > function record with zero args when it actualy has some
> >
> > > All other cases are either newly discovered "bogusness" of DWARF (and
> > > would be good to know about this) or it's a name collision for
> > > functions. Basically, before we go all the way to rework this again,
> > > let's see if just skipping declarations would be enough?
> >
> > so there's actualy new developement today in:
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c14
> >
> > gcc might actualy get fixed, so I think we could go back to
> > using declaration tag and use ftrace as additional filter..
> > at least this exercise gave us static functions ;-)
> >
> > however we still have fedora with disabled disabled CONFIG_DEBUG_INFO_BTF
> > and will need to wait for that fix to enable that back
> 
> Right, we better have a more robust approach not relying on
> not-yet-released GCC.
> 
> >
> > >
> > > >                                 continue;
> > > > -               } else {
> > > > +
> > > > +                       if (!p->fn || args_cnt > p->args_cnt) {
> > > > +                               p->fn = fn;
> > > > +                               p->cu = cu;
> > > > +                               p->args_cnt = args_cnt;
> > > > +                               p->type_id_off = type_id_off;
> > > > +                       }
> > > > +               }
> > > > +       } else {
> > > > +               cu__for_each_function(cu, core_id, fn) {
> > > >                         if (fn->declaration || !fn->external)
> > > >                                 continue;
> > > > +                       if (generate_func(btfe, cu, fn, type_id_off))
> > > > +                               goto out;
> > > >                 }
> > >
> > > I'm trending towards disliking this completely different fallback
> > > mechanism. It saved bpf-next accidentally, but otherwise obscured the
> > > issue and generally makes testing pahole with artificial binary BTFs
> > > (from test programs) harder. How about we unify approaches, but just
> > > use mcount symbols opportunistically, as an additional filter, if it's
> > > available?
> >
> > ok
> >
> > >
> > > With that, testing that we still handle functions with duplicate names
> > > properly would be trivial (which I suspect we don't and we'll just
> > > keep the one with more args now, right?) And it makes static functions
> > > available for non-vmlinux binaries automatically (might be good or
> > > bad, but still...).
> >
> > if we keep just the ftrace filter and rely on declaration tag,
> > the args checking will go away right?
> 
> So I looked at your vmlinux image. I think we should just keep
> everything mostly as it it right now (without changes in this patch),
> but add just two simple checks:
> 
> 1. Skip if fn->declaration (ignore correctly marked func declarations)
> 2. Skip if DW_AT_inline: 1 (ignore inlined functions).
> 
> I'd keep the named arguments check as is, I think it's helpful. 1)
> will skip stuff that's explicitly marked as declaration. 2) inline

ok, that should fix the fail on gccs that still generate
declaration tag, so you should be fine and our version of
gcc should continue work as well 

> check will partially mitigate dropping of fn->external check (and we
> can't really attach to inlined functions). So will the named args
> check as well. Then we should do mcount checks, **if** mcount symbols
> are present (which should always be the case for any reasonable
> vmlinux image that's supposed to be used with BPF, I think).
> 
> So together, it should cover all known issues, I think. And then we'll
> just have to watch out for any new ones. GCC bugfix is good, but it's
> too late: the harm is done and there are compilers out there that we
> should deal with.

hopefuly with this change we can enable BTF back before the gcc fix

thanks,
jirka

