Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2142F22DB
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 23:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbhAKWdV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 17:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387685AbhAKWdV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 17:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610404315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wnlkg0g7e1YrcYGzfxmDxEbKCTeITWcoDDln+owCI50=;
        b=TOGr/KA0iy7btmat781f29juhS9hVqLITo7mu4l6AKndrK9FjMGjZJ3jRr+JzwtbibmM4L
        lzl4QfJoDYE7fCYFBNLTCNKBhB7ye344gxfhYccScwvERJw5asJoFMXuXRtzcxwbJP4zdc
        a9w/pNlFgaeK+BQyxYsJb9tqjY/WSAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-b6nLIsbPN4OWS0SdgOsH9g-1; Mon, 11 Jan 2021 17:31:51 -0500
X-MC-Unique: b6nLIsbPN4OWS0SdgOsH9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8743DF8A4;
        Mon, 11 Jan 2021 22:31:48 +0000 (UTC)
Received: from krava (unknown [10.40.192.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id B5BCB60BE2;
        Mon, 11 Jan 2021 22:31:45 +0000 (UTC)
Date:   Mon, 11 Jan 2021 23:31:44 +0100
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
Message-ID: <20210111223144.GA1250730@krava>
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
 <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 10:30:22PM +0100, Sedat Dilek wrote:

SNIP

> > >
> > > Building a new Linux-kernel...
> > >
> > > - Sedat -
> > >
> > > [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> > > [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> > > [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> >
> > There are no significant bug fixes between pahole 1.19 and master that
> > would solve this problem, so let's try to repro this.
> >
> 
> You are right pahole fom latest Git does not solve the issue.
> 
> + info BTFIDS vmlinux
> + [  != silent_ ]
> + printf   %-7s %s\n BTFIDS vmlinux
>  BTFIDS  vmlinux
> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> FAILED: load BTF from vmlinux: Invalid argument

hm, is there a .BTF section in vmlinux?

is this working over vmlinux:
 $ bpftool btf dump file ./vmlinux

do you have a verbose build output? I'd think pahole scream first..

jirka

