Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D321D352F7A
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhDBTBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 15:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235938AbhDBTBN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 15:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617390071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lH8yhJxrynhxd0WvNK7HIa6U2kDcv+hX7f7c1Z+ZW/c=;
        b=RV2nDVjt9NSS1D8dRkPl23AUaqtpxWbhqpKNpjptx2BR3S98CmuKm45fKmnAfW4mQWzIZE
        /GfeRlEwjdDmngniSRiD0NEoyZEApxseaii7R5GA0KTBscXnHWS1BnEUvRSKqvdxR4A4BY
        AYLTgcqOpsVsM3y1N3hsr+wzUtq+Uog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ZeI0OyflNsO4b_Zb0QpKHA-1; Fri, 02 Apr 2021 15:01:09 -0400
X-MC-Unique: ZeI0OyflNsO4b_Zb0QpKHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA9EB18C43C1;
        Fri,  2 Apr 2021 19:01:07 +0000 (UTC)
Received: from krava (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 547891037E81;
        Fri,  2 Apr 2021 19:01:05 +0000 (UTC)
Date:   Fri, 2 Apr 2021 21:01:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
Message-ID: <YGdp8NITtcwOoOs2@krava>
References: <20210401213620.3056084-1-yhs@fb.com>
 <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
 <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 02, 2021 at 03:08:27PM -0300, Arnaldo wrote:
> 
> 
> On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
> >On 4/2/21 10:23 AM, Yonghong Song wrote:
> :> Thanks. I checked out the branch and did some testing with latest
> >clang 
> >> trunk (just pulled in).
> >> 
> >> With kernel LTO note support, I tested gcc non-lto, and llvm-lto
> >mode, 
> >> it works fine.
> >> 
> >> Without kernel LTO note support, I tested
> >>    gcc non-lto  <=== ok
> >>    llvm non-lto  <=== not ok
> >>    llvm lto     <=== ok
> >> 
> >> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
> >issue.
> >> Some previous version of clang does not have this issue.
> >> I double checked the dwarfdump and it is indeed has the same reason
> >> for lto vmlinux. I checked abbrev section and there is no cross-cu
> >> references.
> >> 
> >> That means we need to adapt this patch
> >>    dwarf_loader: Handle subprogram ret type with abstract_origin
> >properly
> >> for non merging case as well.
> >> The previous patch fixed lto subprogram abstract_origin issue,
> >> I will submit a followup patch for this.
> >
> >Actually, the change is pretty simple,
> >
> >diff --git a/dwarf_loader.c b/dwarf_loader.c
> >index 5dea837..82d7131 100644
> >--- a/dwarf_loader.c
> >+++ b/dwarf_loader.c
> >@@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die 
> >*die, struct cu *cu)
> >         int ret = die__process(die, cu);
> >         if (ret != 0)
> >                 return ret;
> >-       return cu__recode_dwarf_types(cu);
> >+       ret = cu__recode_dwarf_types(cu);
> >+       if (ret != 0)
> >+               return ret;
> >+
> >+       return cu__resolve_func_ret_types(cu);
> >  }
> >
> >Arnaldo, do you just want to fold into previous patches, or
> >you want me to submit a new one?
> 
> I can take care of that.
> 
> And I think it's time for to look at Jiri's test suite... :-)
> 
> It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.

heya,
I did not follow this change, but if you put the latest change
into some branch I can run it on top of that

jirka

