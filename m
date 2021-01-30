Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1CF30985B
	for <lists+bpf@lfdr.de>; Sat, 30 Jan 2021 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhA3Utq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jan 2021 15:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhA3Utp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Jan 2021 15:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612039698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRe6hB7+FjbxOUrs96X+yC7oIpthfG0uqkuDXn9iS2w=;
        b=PQfyQ7BEwOSRGAD/NRT3RuSp7amzCvYb9hWkpEBDZjZdlVtFAT7196FcmrEPUBpfzBrKdF
        U78WFp28uC4QvVe2tw+mecKjLNc/qO4gkGYFhoufCrGyhaZzAyiiPlbA+zq7aR0we1KqWC
        uT8/MKA1hUX5q8fAMt1VYnZLvgoGfuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-Fyto3C7yO3OAQbFcC8GL4w-1; Sat, 30 Jan 2021 15:48:14 -0500
X-MC-Unique: Fyto3C7yO3OAQbFcC8GL4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53B3D107ACE3;
        Sat, 30 Jan 2021 20:48:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 930F05C1BD;
        Sat, 30 Jan 2021 20:48:11 +0000 (UTC)
Date:   Sat, 30 Jan 2021 21:48:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
Message-ID: <YBXGChWt/E2UDgZc@krava>
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 07:13:21PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 29, 2021 at 2:15 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Jan 25, 2021 at 5:42 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Mon, Jan 25, 2021 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > Hello all,
> > > >
> > > > My apologies if this has already been reported, but I didn't see
> > > > anything obvious with a quick search through the archives.  I have a
> > > > test program that behaves very similar to the existing
> > > > selftest/bpf/test_verifier_log test that has started failing this week
> > > > with v5.11-rc5; it ran without problem last week on v5.11-rc4.  Is
> > > > this a known problem with a fix already, or is this something new?
> > > >
> > > > % uname -r
> > > > 5.11.0-0.rc5.134.fc34.x86_64
> > > > % pwd
> > > > /.../linux/tools/testing/selftests/bpf
> > > > % git log --oneline | head -n 1
> > > > 6ee1d745b7c9 Linux 5.11-rc5
> > > > % make test_verifier_log
> > > >   ...
> > > >   BINARY   test_verifier_log
> > > > % ./test_verifier_log
> > > > Test log_level 0...
> > > > Test log_size < 128...
> > > > Test log_buff = NULL...
> > > > Test oversized buffer...
> > > > ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13
> > >
> > > Thanks for reporting.
> > > bpf and bpf-next don't have this issue. Not sure what changed.
> >
> > I haven't had a chance to look into this any further, but Ondrej
> > Mosnacek (CC'd) found the following today:
> >
> > "So I was trying to debug this further and I think I've identified what
> > triggers the problem. It seems that the BTF debuginfo generation
> > became broken with CONFIG_DEBUG_INFO_DWARF4=n somewhere between -rc4
> > and -rc5. It also seems to depend on a recent (Fedora Rawhide) version
> > of some component of the build system (GCC, probably), because the
> > problem disappeared when I tried to build the "bad" kernel in F33
> > buildroot instead of Rawhide."
> 
> I see. There were fixes for dwarf and btf, but I lost the track.
> I believe it was a combination of gcc bug that was worked around in pahole.
> Arnaldo, Jiri, Andrii,
> what is the status? Did all fixes land in pahole?

I checked on rawhide and besides many pahole warnings,
the resulted BTF data have many duplications in core structs

	  BTFIDS  vmlinux
	WARN: multiple IDs found for 'task_struct': 132, 1247 - using 132
	WARN: multiple IDs found for 'file': 440, 1349 - using 440
	WARN: multiple IDs found for 'inode': 698, 1645 - using 698
	WARN: multiple IDs found for 'path': 729, 1672 - using 729
	WARN: multiple IDs found for 'task_struct': 132, 2984 - using 132
	WARN: multiple IDs found for 'task_struct': 132, 3043 - using 132
	WARN: multiple IDs found for 'file': 440, 3085 - using 440
	WARN: multiple IDs found for 'seq_file': 1469, 3125 - using 1469
	WARN: multiple IDs found for 'inode': 698, 3336 - using 698
	WARN: multiple IDs found for 'path': 729, 3366 - using 729
	WARN: multiple IDs found for 'task_struct': 132, 5337 - using 132
	WARN: multiple IDs found for 'inode': 698, 5360 - using 698
	WARN: multiple IDs found for 'path': 729, 5388 - using 729
	WARN: multiple IDs found for 'file': 440, 5412 - using 440
	WARN: multiple IDs found for 'seq_file': 1469, 5639 - using 1469
	WARN: multiple IDs found for 'task_struct': 132, 6243 - using 132
	...

	# gcc --version
	gcc (GCC) 11.0.0 20210123 (Red Hat 11.0.0-0)

I'm guessing there are some DWARF changes that screwed BTF
generation.. I'll check

it's not covered by the fix I posted recently, but I think
Arnaldo is now fixing some related stuff.. Arnaldo, maybe
you are seeing same errors?

I uploaded the build log from linking part to:
  http://people.redhat.com/~jolsa/build.out.gz

jirka

