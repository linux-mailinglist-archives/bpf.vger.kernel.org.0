Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA51355A08
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhDFRKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244361AbhDFRKO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 13:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617729005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=730Pc8Z9gMDM8Tc5fKn12Q2kODndskDoLofmuZpRxJo=;
        b=aLygi6APCrZbu8vmsSrpLuspEelKTkf7Z1ngLPtEyplvrn1wKEmkMvXQt9Z9FYqdb6RUVm
        gMzd077bz2SBXnFhMepxn6127OIKJSGeRhyhhoQVb4twZSsQafuzIP36joGbCeCV959Fjg
        Ys6YZPeVXXw5W02++/CO9yAmBa/Ujeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-5jU6fqNPNha3OGLac4sxcQ-1; Tue, 06 Apr 2021 13:10:02 -0400
X-MC-Unique: 5jU6fqNPNha3OGLac4sxcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 621048030CA;
        Tue,  6 Apr 2021 17:10:00 +0000 (UTC)
Received: from krava (unknown [10.40.195.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D0FD10016F4;
        Tue,  6 Apr 2021 17:09:57 +0000 (UTC)
Date:   Tue, 6 Apr 2021 19:09:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyV5QNKIdbpntny@krava>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 01, 2021 at 01:56:57PM -0700, Bill Wendling wrote:
> On Thu, Apr 1, 2021 at 12:35 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > Function cus__merging_cu() is introduced in Commit 39227909db3c
> > > ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> > > binary") to test whether cross-cu references may happen.
> > > The original implementation anticipates compilation flags
> > > in dwarf, but later some concerns about binary size surfaced
> > > and the decision is to scan .debug_abbrev as a faster way
> > > to check cross-cu references. Also putting a note in vmlinux
> > > to indicate whether lto is enabled for built or not can
> > > provide a much faster way.
> > >
> > > This patch set implemented this two approaches, first
> > > checking the note (in Patch #2), if not found, then
> > > check .debug_abbrev (in Patch #1).
> > >
> > > Yonghong Song (2):
> > >   dwarf_loader: check .debug_abbrev for cross-cu references
> > >   dwarf_loader: check .notes section for lto build info
> > >
> > >  dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
> > >  1 file changed, 55 insertions(+), 21 deletions(-)
> > >
> > With this series of patches, the compilation passes for me with
> > ThinLTO. You may add this if you like:
> >
> > Tested-by: Bill Wendling <morbo@google.com>
> 
> I did notice these warnings following the "pahole -J .tmp_vmlinux.btf"
> command. I don't know the severity of them, but it might be good to
> investigate.
> 
> $ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
>   BTFIDS  vmlinux
> WARN: multiple IDs found for 'inode': 355, 8746 - using 355

the message means that there are multiple instances of 'inode'
structs in the BTF data with ids 355 and 8746

that can happen when some object/struct name is duplicated in
multiple objects and it's causing two distinct type hierarchies
in BTF data.. like the one we fixes in here:
  f7f2b43eaf6b crypto: bcm - Rename struct device_private to bcm_device_private

if you provide the .config, I can check if I reproduce

jirka

> WARN: multiple IDs found for 'file': 588, 8779 - using 588
> WARN: multiple IDs found for 'path': 411, 8780 - using 411
> WARN: multiple IDs found for 'seq_file': 1414, 8836 - using 1414
> WARN: multiple IDs found for 'vm_area_struct': 538, 8873 - using 538
> WARN: multiple IDs found for 'task_struct': 28, 8880 - using 28
> WARN: multiple IDs found for 'inode': 355, 9484 - using 355
> WARN: multiple IDs found for 'file': 588, 9517 - using 588
> WARN: multiple IDs found for 'path': 411, 9518 - using 411
> WARN: multiple IDs found for 'seq_file': 1414, 9578 - using 1414
> WARN: multiple IDs found for 'vm_area_struct': 538, 9615 - using 538
> WARN: multiple IDs found for 'task_struct': 28, 9622 - using 28
> WARN: multiple IDs found for 'seq_file': 1414, 12223 - using 1414
> WARN: multiple IDs found for 'file': 588, 12237 - using 588
> WARN: multiple IDs found for 'path': 411, 12238 - using 411
> ...
> 
> -bw
> 

