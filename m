Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B030243B1C5
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhJZMGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 08:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233868AbhJZMGD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Oct 2021 08:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0nMxe3hVb70E+20hbG82Aa3810ivgtjZzwzfNSAWc0=;
        b=iOjBXWB/glxyjjJRJ15hE5H7YcfOh3P5uzgjeYrpPtWgAVyGqn4WGUyW2+/dnocvXLu1gZ
        LuRQcYoG9kJH1NsrkPNsQseQBdJOCzOkmaTn4VEcBcceVqVZzCfI1dAbPE7BVodd+IDsGF
        uNK8dt18n9OmbON9lDPFNdMI21IwKjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-2EhCNb1OOk680gKZTqp8aQ-1; Tue, 26 Oct 2021 08:03:38 -0400
X-MC-Unique: 2EhCNb1OOk680gKZTqp8aQ-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso5039876wmc.1
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 05:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P0nMxe3hVb70E+20hbG82Aa3810ivgtjZzwzfNSAWc0=;
        b=noO+0AKDI6IiIBohqy2y/RbSmjms0VJuXddPumJJBwYL8q6g6JVjJqtHCWU/bCj4W6
         /LtiEleLyz4hsZ2plkATguPEFIqsSsL1gbDZ9o7SC/0+GRiR2j2Yw9YmnkfCfJpDKdMG
         hG4tOJEfOOjvscPgzg7cxXsM4LOiO17U9NWOXkLsnR9Rd1myZxq8SPbBJvFgPtnWkxPu
         bQhZ2dRvEnuJP5vKbJWdluchhKSFsnkzBDUdGN5ql5n1CJmvm89rWKXkkV5ei8+wkAm+
         /7tcsf+oKCEWul95PQL+UXER3d1ji46JBIwcG+CO1TS3iOblYCBHz3/gfCBKOoB4xOw/
         nSSQ==
X-Gm-Message-State: AOAM533tpiNZyotx3HTZAEuDgd10zZS3d00nt680JBEcF4SEO/qdKqx/
        nlaZ50Z9y9TCfAWDjf1+DQuNwjoaVb4eID6faTNJtS8oReYTQlpSms/WCuIcEFefXhFLISZnHCV
        8yYXt0WUyx9nB
X-Received: by 2002:a5d:5274:: with SMTP id l20mr4432614wrc.328.1635249817465;
        Tue, 26 Oct 2021 05:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGFYcDWKegak7lZKWZVg6qGQjlpWchFLO+aS1HDBIcbjueIlb4z8WBG5ZhcQkJ/2SdXt38Vg==
X-Received: by 2002:a5d:5274:: with SMTP id l20mr4432576wrc.328.1635249817265;
        Tue, 26 Oct 2021 05:03:37 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id w5sm18934729wra.87.2021.10.26.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 05:03:36 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:03:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [RFC bpf-next 0/2] bpf: Fix BTF data for modules
Message-ID: <YXfulitQY1+Gd35h@krava>
References: <20211023120452.212885-1-jolsa@kernel.org>
 <CAEf4BzbaD60KFsUB4VkTAH2v3+GFkRvRbY_O-bNSpNG0=8pJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbaD60KFsUB4VkTAH2v3+GFkRvRbY_O-bNSpNG0=8pJ0Q@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 09:54:48PM -0700, Andrii Nakryiko wrote:
> On Sat, Oct 23, 2021 at 5:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > I'm trying to enable BTF for kernel module in fedora,
> > and I'm getting big increase on modules sizes on s390x arch.
> >
> > Size of modules in total - kernel dir under /lib/modules/VER/
> > from kernel-core and kernel-module packages:
> >
> >                current   new
> >       aarch64      60M   76M
> >       ppc64le      53M   66M
> >       s390x        21M   41M
> >       x86_64       64M   79M
> >
> > The reason for higher increase on s390x was that dedup algorithm
> > did not detect some of the big kernel structs like 'struct module',
> > so they are duplicated in the kernel module BTF data. The s390x
> > has many small modules that increased significantly in size because
> > of that even after compression.
> >
> > First issues was that the '--btf_gen_floats' option is not passed
> > to pahole for kernel module BTF generation.
> >
> > The other problem is more tricky and is the reason why this patchset
> > is RFC ;-)
> >
> > The s390x compiler generates multiple definitions of the same struct
> > and dedup algorithm does not seem to handle this at the moment.
> >
> > I put the debuginfo and btf dump of the s390x pnet.ko module in here:
> >   http://people.redhat.com/~jolsa/kmodbtf/
> >
> > Please let me know if you'd like to see other info/files.
> >
> 
> Hard to tell what's going on without vmlinux itself. Can you upload a
> corresponding kernel image with BTF in it?

sure, uploaded

jirka

> 
> > I found code in dedup that seems to handle such situation for arrays,
> > and added 'some' fix for structs. With that change I can no longer
> > see vmlinux's structs in kernel module BTF data, but I have no idea
> > if that breaks anything else.
> >
> > thoughts? thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (2):
> >       kbuild: Unify options for BTF generation for vmlinux and modules
> >       bpf: Add support to detect and dedup instances of same structs
> >
> >  Makefile                  |  3 +++
> >  scripts/Makefile.modfinal |  2 +-
> >  scripts/link-vmlinux.sh   | 11 +----------
> >  scripts/pahole-flags.sh   | 20 ++++++++++++++++++++
> >  tools/lib/bpf/btf.c       | 12 ++++++++++--
> >  5 files changed, 35 insertions(+), 13 deletions(-)
> >  create mode 100755 scripts/pahole-flags.sh
> >
> 

