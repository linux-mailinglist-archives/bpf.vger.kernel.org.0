Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02A2F2D2C
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 11:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbhALKr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 05:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbhALKr7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 05:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610448392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6UGpP/GOG7p8YqbEduT5rHYPzzcPgvWMqUPnCJMZHE4=;
        b=AoMaaqefN9VGoU/HuJjntZDRh1rqCJchafms+byG9GaBW2jcfddyHrkCV9x2UGbqPt2YNj
        wMw1yu8qwKZp8ZiAlOTuRDn1E3/EOfGopHh1ykVz41GnV6CgtsYy4Xuh85wgQWiU5OviJi
        +uYVw1fNJwJ1arZr4acZqxj7jtiOTHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-JXjMLP_CMCGn8tqskUz6yA-1; Tue, 12 Jan 2021 05:46:29 -0500
X-MC-Unique: JXjMLP_CMCGn8tqskUz6yA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A602E801B14;
        Tue, 12 Jan 2021 10:46:26 +0000 (UTC)
Received: from krava (unknown [10.40.195.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B7BC77BE1;
        Tue, 12 Jan 2021 10:46:23 +0000 (UTC)
Date:   Tue, 12 Jan 2021 11:46:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
Message-ID: <20210112104622.GA1283572@krava>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
 <20210111223144.GA1250730@krava>
 <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed779f29-18b9-218f-a937-878328a769fe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 02:34:04PM -0800, Tom Stellard wrote:
> On 1/11/21 2:31 PM, Jiri Olsa wrote:
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
> > >   BTFIDS  vmlinux
> > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > FAILED: load BTF from vmlinux: Invalid argument
> > 
> > hm, is there a .BTF section in vmlinux?
> > 
> > is this working over vmlinux:
> >   $ bpftool btf dump file ./vmlinux
> > 
> > do you have a verbose build output? I'd think pahole scream first..
> > 
> 
> It does.  For me, pahole segfaults at scripts/link-vmlinux.sh:131.  This is
> pretty easy for me to reproduce.  I have logs, what other information would
> be helpful?  How about a pahole backtrace?

that'd be great.. I'll try to reproduce, but with the latest clang
it will take me some time

jirka

> 
> -Tom
> 
> > jirka
> > 
> 

