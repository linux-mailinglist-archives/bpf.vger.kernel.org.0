Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48982F6317
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 15:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbhANO0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 09:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729191AbhANO0H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 09:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610634281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OWeXR5g8sFOaWy16++87vypsCr4n11fyoItyYOQT9J0=;
        b=D98oDpe0E0c+Mur2J1HxVK7PDHUXLh4endrMyzu9jsb5gli75oC5UYZBojFkxBS8OsiLDS
        NkeSGHfxK+nDaq4HTNoK/bHkStc2vDyVNJD+Pco97vJtoLfU0mI4XweA7NtmnJTBw57BG+
        C8RZhmjzcHTqx0hXVhCOZvjkl3ALznc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Fp7mhD9xPAS1IgVvhZ7uVg-1; Thu, 14 Jan 2021 09:24:37 -0500
X-MC-Unique: Fp7mhD9xPAS1IgVvhZ7uVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A71B9CC03;
        Thu, 14 Jan 2021 14:24:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id EB41260CED;
        Thu, 14 Jan 2021 14:24:31 +0000 (UTC)
Date:   Thu, 14 Jan 2021 15:24:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
Message-ID: <20210114142431.GB1416940@krava>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava>
 <CA+icZUWaMktPBYy9P-gbgL-AD7EEPrrvS4jenahJ-3HkxOOC0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWaMktPBYy9P-gbgL-AD7EEPrrvS4jenahJ-3HkxOOC0g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 03:13:18PM +0100, Sedat Dilek wrote:
> On Mon, Jan 11, 2021 at 11:31 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:
> >
> > SNIP
> >
> > > > >
> > > > > Building a new Linux-kernel...
> > > > >
> > > > > - Sedat -
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> > > >
> > > > There are no significant bug fixes between pahole 1.19 and master that
> > > > would solve this problem, so let's try to repro this.
> > > >
> > >
> > > You are right pahole fom latest Git does not solve the issue.
> > >
> > > + info BTFIDS vmlinux
> > > + [  != silent_ ]
> > > + printf   %-7s %s\n BTFIDS vmlinux
> > >  BTFIDS  vmlinux
> > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > FAILED: load BTF from vmlinux: Invalid argument
> >
> > hm, is there a .BTF section in vmlinux?
> >
> > is this working over vmlinux:
> >  $ bpftool btf dump file ./vmlinux
> >
> 
> I switched to LLVM v12 from <apt.llvm.org> and saw the same FAILED line.
> 
> The generated vmlinux file is cleaned on failure.
> 
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>  BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument

did pahole generated the .BTF section? earlier in the log

jirka

