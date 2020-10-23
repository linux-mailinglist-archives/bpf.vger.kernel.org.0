Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61E297866
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbgJWUpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 16:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S464027AbgJWUpt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Oct 2020 16:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603485947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=idAqEvlRlz8mHGmZYGPDujNEmBfo+3v1AEEqdtdtmYA=;
        b=aP1eLX+yEkPDLu8GZSRo9yiFrEboa9tv1u3cuaR2R4dlezGHMnYnVUFJfDVOox3hXVrLoa
        ugUc98GDsl92AT8qyYFXACVVtuVLMCcawMMrYXZVKI3HmHjUex7g32i5vkh/S6Ynje0caV
        5w4UxtjM/RmApC3WOJJCXW8fgdrtEgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-Krpg-Q7lNIuGMajHW7GCOg-1; Fri, 23 Oct 2020 16:45:45 -0400
X-MC-Unique: Krpg-Q7lNIuGMajHW7GCOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9700A1882FA0;
        Fri, 23 Oct 2020 20:45:44 +0000 (UTC)
Received: from krava (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id F30305C1C4;
        Fri, 23 Oct 2020 20:45:39 +0000 (UTC)
Date:   Fri, 23 Oct 2020 22:45:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201023204539.GB2495983@krava>
References: <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava>
 <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
 <20201023201702.GA2495983@krava>
 <CAEf4BzZzMNfBBPGeXazk0Qh8pbXMPip-i3iaSt6QqXE-tttT=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZzMNfBBPGeXazk0Qh8pbXMPip-i3iaSt6QqXE-tttT=A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 01:32:44PM -0700, Andrii Nakryiko wrote:

SNIP

> > right, we can generate them in bpftrace, but it's a shame
> >
> >
> > >
> > > But otherwise, I don't really have a good feeling what's the perfect
> > > solution here...
> >
> > I tried the check of dwarf record against function symbols
> > with adresses mentioned earlier (attached)
> >
> > getting more functions of course ;-)
> >
> > $ bpftool btf dump file ./vmlinux | grep 'FUNC '  | wc -l
> > 46606
> >
> > compared to 22869 on the same .config with working gcc
> > and current pahole
> 
> Just curious, what's the change in BTF size due to this?

current: 3342279
new:     4361045

so about 1MB

> 
> >
> > and resolve_btfids is happy, because there are no duplications
> >
> > jirka
> >
> >
> > ---
> 
> [...]
> 
> >  static int btf_var_secinfo_cmp(const void *a, const void *b)
> >  {
> >         const struct btf_var_secinfo *av = a;
> > @@ -72,6 +157,7 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
> >         if (!btfe)
> >                 return NULL;
> >
> > +       btfe->symbols = RB_ROOT;
> 
> Can you please check what we do for per-cpu variables with ELF
> symbols? Perhaps we can unify approaches. I'd also favor using a sort
> + bsearch approach instead of rb_tree, given we don't really need to
> dynamically add/delete elements, it's a one-time operation to iterate
> and initialize everything. Also binary search of linear arrays would
> be more memory-efficient and cache-efficient, most probably.

ok, will check

jirka

> 
> >         btfe->in_fd = -1;
> >         btfe->filename = strdup(filename);
> >         if (btfe->filename == NULL)
> > @@ -177,6 +263,7 @@ void btf_elf__delete(struct btf_elf *btfe)
> >                         elf_end(btfe->elf);
> >         }
> >
> > +       btfe__delete_symbols(btfe);
> >         elf_symtab__delete(btfe->symtab);
> >         __gobuffer__delete(&btfe->percpu_secinfo);
> >         btf__free(btfe->btf);
> 
> [...]
> 

