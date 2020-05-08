Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734D71CBA9F
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgEHWSq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 May 2020 18:18:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHWSq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 18:18:46 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=mussarela)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1jXBKK-00079A-Uq; Fri, 08 May 2020 22:18:41 +0000
Date:   Fri, 8 May 2020 19:18:35 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 1/2] Revert "libbpf: Fix readelf output parsing on
 powerpc with recent binutils"
Message-ID: <20200508221833.GF24356@mussarela>
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
 <20200507145652.190823-2-yauheni.kaliuta@redhat.com>
 <CAEf4BzYPDKfJLSGVQucgRuDUyzwizQHAWyUWWGsq6ZvgRUO0yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYPDKfJLSGVQucgRuDUyzwizQHAWyUWWGsq6ZvgRUO0yg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 08, 2020 at 02:46:56PM -0700, Andrii Nakryiko wrote:
> On Thu, May 7, 2020 at 7:57 AM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > The patch makes it fail on the output when the comment is printed
> > after the symbol name (RHEL8 powerpc):
> >
> > 400: 000000000000c714   144 FUNC    GLOBAL DEFAULT    1 bpf_object__open_file@LIBBPF_0.0.4         [<localentry>: 8]
> >
> > But after commit aa915931ac3e ("libbpf: Fix readelf output parsing
> > for Fedora") it is not needed anymore, the parsing should work in
> > both cases.
> >

If it's working either way after aa915931ac3e, is there any specific reason
for the revert?

Cascardo.

> > This reverts commit 3464afdf11f9a1e031e7858a05351ceca1792fea.
> >
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
> 
> Looks good, though would be nice to have people originally involved in
> those fixes you mentioned to confirm it works fine still. Added them
> to cc.
> 
> If no one shouts loudly in next few days:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  tools/lib/bpf/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > index aee7f1a83c77..908dac9eb562 100644
> > --- a/tools/lib/bpf/Makefile
> > +++ b/tools/lib/bpf/Makefile
> > @@ -149,7 +149,7 @@ TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
> >  GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
> >                            cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
> >                            sed 's/\[.*\]//' | \
> > -                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
> > +                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
> >                            sort -u | wc -l)
> >  VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
> >                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
> > @@ -216,7 +216,7 @@ check_abi: $(OUTPUT)libbpf.so
> >                 readelf -s --wide $(BPF_IN_SHARED) |                     \
> >                     cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |   \
> >                     sed 's/\[.*\]//' |                                   \
> > -                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
> > +                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
> >                     sort -u > $(OUTPUT)libbpf_global_syms.tmp;           \
> >                 readelf -s --wide $(OUTPUT)libbpf.so |                   \
> >                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
> > --
> > 2.26.2
> >
