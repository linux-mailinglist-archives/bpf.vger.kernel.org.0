Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FCD1CBE09
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgEIGSG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 02:18:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728745AbgEIGSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 May 2020 02:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589005084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iALo2kuzYx7pZWC4tqFh8GRvXhdK7vauuiUQRlHegwM=;
        b=ExfX+GarVh3X56H1wD3itz2ui+ybxXTeA6dq5TMHH8mHpmw6dQ59RzR932gkID5TRyY+Jt
        xj7T65sRqvjl0UwvB05m3Fpo+HfufiKhY4dYhumSgDZH80jXVZDSJ8j5dzaAnd90YNXE/O
        bhfSRIS1Mv0a6O5XT2TnsuYFmfjgr80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-XCjHQXwBN0eKDlU-rrn7Gw-1; Sat, 09 May 2020 02:17:59 -0400
X-MC-Unique: XCjHQXwBN0eKDlU-rrn7Gw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24BCB460;
        Sat,  9 May 2020 06:17:58 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-13.ams2.redhat.com [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63C2D100164D;
        Sat,  9 May 2020 06:17:55 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 1/2] Revert "libbpf: Fix readelf output parsing on powerpc with recent binutils"
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
        <20200507145652.190823-2-yauheni.kaliuta@redhat.com>
        <CAEf4BzYPDKfJLSGVQucgRuDUyzwizQHAWyUWWGsq6ZvgRUO0yg@mail.gmail.com>
        <20200508221833.GF24356@mussarela>
Date:   Sat, 09 May 2020 09:17:39 +0300
In-Reply-To: <20200508221833.GF24356@mussarela> (Thadeu Lima de Souza
        Cascardo's message of "Fri, 8 May 2020 19:18:35 -0300")
Message-ID: <xunyh7wphbss.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Thadeu!

>>>>> On Fri, 8 May 2020 19:18:35 -0300, Thadeu Lima de Souza Cascardo  wrote:

 > On Fri, May 08, 2020 at 02:46:56PM -0700, Andrii Nakryiko wrote:
 >> On Thu, May 7, 2020 at 7:57 AM Yauheni Kaliuta
 >> <yauheni.kaliuta@redhat.com> wrote:
 >> >
 >> > The patch makes it fail on the output when the comment is printed
 >> > after the symbol name (RHEL8 powerpc):
 >> >
 >> > 400: 000000000000c714 144 FUNC GLOBAL DEFAULT 1
 >> > bpf_object__open_file@LIBBPF_0.0.4 [<localentry>: 8]
 >> >
 >> > But after commit aa915931ac3e ("libbpf: Fix readelf output parsing
 >> > for Fedora") it is not needed anymore, the parsing should work in
 >> > both cases.
 >> >

 > If it's working either way after aa915931ac3e, is there any
 > specific reason for the revert?

 Well, not really, agree.

 > Cascardo.

 >> > This reverts commit 3464afdf11f9a1e031e7858a05351ceca1792fea.
 >> >
 >> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> > ---
 >> 
 >> Looks good, though would be nice to have people originally involved in
 >> those fixes you mentioned to confirm it works fine still. Added them
 >> to cc.
 >> 
 >> If no one shouts loudly in next few days:
 >> 
 >> Acked-by: Andrii Nakryiko <andriin@fb.com>
 >> 
 >> 
 >> >  tools/lib/bpf/Makefile | 4 ++--
 >> >  1 file changed, 2 insertions(+), 2 deletions(-)
 >> >
 >> > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
 >> > index aee7f1a83c77..908dac9eb562 100644
 >> > --- a/tools/lib/bpf/Makefile
 >> > +++ b/tools/lib/bpf/Makefile
 >> > @@ -149,7 +149,7 @@ TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 >> >  GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 >> >                            cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 >> >                            sed 's/\[.*\]//' | \
 >> > -                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
 >> > +                          awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
 >> >                            sort -u | wc -l)
 >> >  VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 >> >                               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 >> > @@ -216,7 +216,7 @@ check_abi: $(OUTPUT)libbpf.so
 >> >                 readelf -s --wide $(BPF_IN_SHARED) |                     \
 >> >                     cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |   \
 >> >                     sed 's/\[.*\]//' |                                   \
 >> > -                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 >> > +                   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
 >> >                     sort -u > $(OUTPUT)libbpf_global_syms.tmp;           \
 >> >                 readelf -s --wide $(OUTPUT)libbpf.so |                   \
 >> >                     grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
 >> > --
 >> > 2.26.2
 >> >


-- 
WBR,
Yauheni Kaliuta

