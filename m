Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441EA2BFCB7
	for <lists+bpf@lfdr.de>; Sun, 22 Nov 2020 23:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKVW41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Nov 2020 17:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgKVW40 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 22 Nov 2020 17:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606085785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7C1OJFA3112ZAFA+JQXUY2iim7RZXde1/6ow0DwVwWk=;
        b=Xy7zvyvITFlP/pv258eOLxRM1tRj5ngVw+KF0Dc7geF2e9l/LaiYc4j5LFuXrFfcVh12Q+
        vpfVcO+hc7VMgBCDWTT6QOJ0pnGvZ8iEHBqzgj0YcXpNhK6D8QHxb+xP6qoaCqA4JOcvxV
        r2Pt2+QF0nnk2lHaKU+g5C0Id9jmO3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-vTRYCdUmO32IjW9wjb5dHg-1; Sun, 22 Nov 2020 17:56:22 -0500
X-MC-Unique: vTRYCdUmO32IjW9wjb5dHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08EA1005E40;
        Sun, 22 Nov 2020 22:56:20 +0000 (UTC)
Received: from krava (unknown [10.40.192.91])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE5685D6D3;
        Sun, 22 Nov 2020 22:56:18 +0000 (UTC)
Date:   Sun, 22 Nov 2020 23:56:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 0/2] btf_encoder: Fix functions BTF data generation
Message-ID: <20201122225617.GA1902740@krava>
References: <20201114223853.1010900-1-jolsa@kernel.org>
 <CAEf4BzZ-0exZK7skcB_UjyatAx_R=hNqAXKVZ8EXgmSsHmthFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ-0exZK7skcB_UjyatAx_R=hNqAXKVZ8EXgmSsHmthFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 20, 2020 at 05:13:24PM -0800, Andrii Nakryiko wrote:
> On Sat, Nov 14, 2020 at 2:39 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > recent btf encoder's changes brakes BTF data for some gcc
> > versions. The problem is that some functions can appear
> > in dwarf data in some instances without arguments, while
> > they are defined with some.
> 
> Hey Jiri,
> 
> So this approach with __start_mcount_loc/__stop_mcount_loc works for
> vmlinux only, but it doesn't work for kernel modules. For kernel
> modules there is a dedicated "__mcount_loc" section, but no
> __start/__stop symbols. I'm working around for now by making sure
> functions that I need are global, but it would be nice to have this
> working for modules out of the box as well.

hi,
I checked and it's bit more tricky than with vmlinux,
addresses are in __mcount_loc, but it's all zeros and
it gets filled after via relocation from .rela__mcount_loc

I think we could do relocation of __mcount_loc section
with zero base and get all base addresses.. and then
continue from there with current code checks

I'll check on it tomorrow

> 
> If you get a chance to fix this soon, that would be great. If not,
> I'll try to get to this ASAP as well, because it would be nice to have
> this in the same version of pahole that got static function BTFs for
> vmlinux (if Arnaldo doesn't mind, of course).

we're eagerly expecting the new pahole with the DWARF bug
workaround, so we asked Arnaldo to release soon, how big
problem is it for you if the modules fix is in the next one?

thanks,
jirka

> 
> >
> > v3 changes:
> >   - move 'generated' flag set out of should_generate_function
> >   - rename should_generate_function to find_function
> >   - added ack
> >
> > v2 changes:
> >   - drop patch 3 logic and just change conditions
> >     based on Andrii's suggestion
> >   - drop patch 2
> >   - add ack for patch 1
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (2):
> >       btf_encoder: Generate also .init functions
> >       btf_encoder: Fix function generation
> >
> >  btf_encoder.c | 86 +++++++++++++++++++++-----------------------------------------------------------------
> >  1 file changed, 21 insertions(+), 65 deletions(-)
> >
> 

