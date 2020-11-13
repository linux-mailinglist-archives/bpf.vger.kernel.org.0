Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C92B1A72
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKMMCj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 07:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgKMMCV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 07:02:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF62A22240;
        Fri, 13 Nov 2020 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605268354;
        bh=GliJtuwJN0V5MDYoyAHcUQQE0kS6tyklKVBe5yGHC9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDyNBx9vozSfE9ixs/ENLoE0Hapk7Fy19Wmz/BFbFxzUBqAJyjRJggAGc7Wva7OnW
         UJzG8S7joSgQXEnNVkZd/7prOyH2zDB3ZaxXNmRVgy4oJ0ZznhNzhwb3GhXEH2k32L
         MuOUNBWGwODoq6Gh5O90bVtTayCuRUFAUH/VhcSI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B18ED411D1; Fri, 13 Nov 2020 08:52:31 -0300 (-03)
Date:   Fri, 13 Nov 2020 08:52:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC/PATCH 3/3] btf_encoder: Func generation fix
Message-ID: <20201113115231.GC394182@kernel.org>
References: <20201112150506.705430-1-jolsa@kernel.org>
 <20201112150506.705430-4-jolsa@kernel.org>
 <CAEf4BzbhojeSdASwt4y4XEtgAF1caYx=-AuwzWJZv7qKgzkroA@mail.gmail.com>
 <20201112211413.GA733055@krava>
 <CAEf4BzbePw8gksT0MH=hwp4Pv1EV1-MOeiwfoFVR64XWFccTHw@mail.gmail.com>
 <20201113105923.GC753418@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113105923.GC753418@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Nov 13, 2020 at 11:59:23AM +0100, Jiri Olsa escreveu:
> On Thu, Nov 12, 2020 at 04:08:02PM -0800, Andrii Nakryiko wrote:
> > On Thu, Nov 12, 2020 at 1:14 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > On Thu, Nov 12, 2020 at 11:54:41AM -0800, Andrii Nakryiko wrote:
> > > > So I can't unfortunately reproduce that GCC bug with DWARF info. What
> > > > was exactly the symptom? Maybe you can also share readelf -wi dump for
> > > > your problematic vmlinux?

> > > hum, can't see -wi working for readelf, however I placed my vmlinux
> > > in here:
> > >   http://people.redhat.com/~jolsa/vmlinux.gz

> > > the symptom is that resolve_btfids will fail kernel build:

> > >   BTFIDS  vmlinux
> > > FAILED unresolved symbol vfs_getattr

> > > because BTF data contains multiple FUNC records for same function

> > > and the problem is that declaration tag itself is missing:
> > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> > > so pahole won't skip them

> > > the first workaround was to workaround that and go for function
> > > records that have code address attached, but that's buggy as well:
> > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107

> > > then after some discussions we ended up using ftrace addresses
> > > as filter for what we want to display.. plus we got static functions
> > > as well

> > > however for this way we failed to get proper arguments ;-)

> > Right, I followed along overall, but forgot the details of the initial
> > problem. Thanks for the refresher. See below for my current thoughts
> > on dealing with all this.

I'll add this to the set of regression tests I use with pahole:

[acme@five vfs_gettattr.multiple.btf.entries.jolsa]$ bpftool btf dump file vmlinux | grep -w FUNC | cut -d\' -f2 | sort | uniq -c | sort -nr | head
      3 __x64_sys_userfaultfd
      3 __x64_sys_timerfd_settime
      3 __x64_sys_timerfd_gettime
      3 __x64_sys_timerfd_create
      3 __x64_sys_syslog
      3 __x64_sys_sysfs
      3 __x64_sys_swapon
      3 __x64_sys_swapoff
      3 __x64_sys_socketpair
      3 __x64_sys_socket
[acme@five vfs_gettattr.multiple.btf.entries.jolsa]$ pfunct -F btf vmlinux | sort | uniq -c | sort -nr | head
      3 __x64_sys_userfaultfd
      3 __x64_sys_timerfd_settime
      3 __x64_sys_timerfd_gettime
      3 __x64_sys_timerfd_create
      3 __x64_sys_syslog
      3 __x64_sys_sysfs
      3 __x64_sys_swapon
      3 __x64_sys_swapoff
      3 __x64_sys_socketpair
      3 __x64_sys_socket
[acme@five vfs_gettattr.multiple.btf.entries.jolsa]$

I.e. the output of those tools need to match and all functions need to
appear only once.

I'll also use pfunct with -F dwarf to get the same results, probably
will add these to the 'btfdiff' tool that is in the pahole git repo.

- Arnaldo
