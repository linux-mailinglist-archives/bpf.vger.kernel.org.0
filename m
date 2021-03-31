Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D07350103
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhCaNOq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 09:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235450AbhCaNOd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617196473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2d2FkP+IOtMtjXx6saUVQwKJ33CT7kQz6QABuLcPkiw=;
        b=JLgLiuKGpwQAfHfJfj0O+17SR5yDF+KCKh1mLDWb76HV18DA/9823cp+TIHjzSLb2+Mm6b
        N+xMpA0xtfPa/1iYDLd8xz/eC9LTnjaqAzOgtU51WFRbZyG/u8mcL0+9NP3IhDYLRKL+2I
        6sF3cpmgw/pv+59hEhJ6GkdHR0QdIc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-WT173dPdPI6FgFkcmErBsg-1; Wed, 31 Mar 2021 09:14:28 -0400
X-MC-Unique: WT173dPdPI6FgFkcmErBsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62707107ACCA;
        Wed, 31 Mar 2021 13:14:27 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E032B100164A;
        Wed, 31 Mar 2021 13:14:26 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 56E90F9; Wed, 31 Mar 2021 10:14:24 -0300 (-03)
Date:   Wed, 31 Mar 2021 10:14:24 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next] bpf: Generate BTF_KIND_FLOAT when linking
 vmlinux
Message-ID: <20210331131424.GA10292@redhat.com>
References: <20210331014356.256212-1-iii@linux.ibm.com>
 <CAEf4BzaF6WMz8pM2X03p_oQo95J1e-7Owi+8Y=GAOkXrx8H-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaF6WMz8pM2X03p_oQo95J1e-7Owi+8Y=GAOkXrx8H-aA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 30, 2021 at 11:28:36PM -0700, Andrii Nakryiko escreveu:
> On Tue, Mar 30, 2021 at 6:44 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > pahole v1.21 will support the --btf_gen_floats flag, which makes it
> > generate the information about the floating-point types.
> >
> > Adjust link-vmlinux.sh to pass this flag to pahole in case it's
> > supported. Whether or not this flag is supported is determined by
> > probing, which is chosen over version check for two reasons:
> >
> > 1) at this moment --btf_gen_floats exists only in master, which
> >    identifies itself as v1.20.
> > 2) distros may backport features, making the version check too
> >    conservative.
> >
> 
> Does anyone really cherry-pick and backport pahole patches, though? So
> far we've been using strictly version checks for pahole (1.13, then
> 1.16, then 1.19 for modules), that keeps everything simpler and more
> reliable, IMO. I'd stick with 1.21 check and just check with Arnaldo
> when he's planning to release a new version.

The plan is to get 1.21 out of the door when we finish the LTO work, which should be soon.

- Arnaldo
 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  scripts/link-vmlinux.sh | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 3b261b0f74f0..f4c763d2661d 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -227,8 +227,13 @@ gen_btf()
> >
> >         vmlinux_link ${1}
> >
> > +       local paholeopt=-J
> > +       if ${PAHOLE} --btf_gen_floats --help >/dev/null 2>&1; then
> > +               paholeopt="${paholeopt} --btf_gen_floats"
> > +       fi
> > +
> >         info "BTF" ${2}
> > -       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> > +       LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} ${paholeopt} ${1}
> 
> we know that -J is always specified, so I'd leave it intact, and just
> have "extra pahole options", potentially empty.
> 
> >
> >         # Create ${2} which contains just .BTF section but no symbols. Add
> >         # SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> > --
> > 2.29.2
> >

