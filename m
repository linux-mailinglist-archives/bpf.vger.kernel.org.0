Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6DE358F1D
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhDHVXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 17:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhDHVXx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 17:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617917021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UNtpRwMCYUQEKSW/rnSecQHWPrqwfmhzTyqLh1wSNk=;
        b=LCyKdj0yAyA0qLMtGJ2WVa2L3sE8vIdISz8YbAPAO1SU9MepCBVteSHxOJIsptv1oec+Gb
        6+5NmMfSQwfodmcx41LHV6H/yP6mkFTj38R4W9Sxe8QxMGMGJvniAR9iKPQfwbMk37arLh
        NjTVtlpjpSFG+tEh2NXWTDL1cADzU1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-a2NJ5TGkNNqL_K5BbtvHRA-1; Thu, 08 Apr 2021 17:23:37 -0400
X-MC-Unique: a2NJ5TGkNNqL_K5BbtvHRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 913CA801A82;
        Thu,  8 Apr 2021 21:23:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6579F5D71D;
        Thu,  8 Apr 2021 21:23:33 +0000 (UTC)
Date:   Thu, 8 Apr 2021 23:23:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFT] prepping up pahole 1.21, wanna test it? was Re: [PATCH
 dwarves] dwarf_loader: handle subprogram ret type with abstract_origin
 properly
Message-ID: <YG90VJNUJA6EWZ1X@krava>
References: <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
 <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com>
 <YG3RpVgLC9UEUrb8@kernel.org>
 <YG3SYoNWqb8DlP61@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3SYoNWqb8DlP61@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 07, 2021 at 12:40:18PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 07, 2021 at 12:37:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Apr 07, 2021 at 07:54:26AM -0700, Yonghong Song escreveu:
> > > Arnaldo, just in case that you missed it, please remember
> > > to fold the above changes to the patch:
> > >    [PATCH dwarves] dwarf_loader: handle subprogram ret type with
> > > abstract_origin properly
> > > Thanks!
> > 
> > Its there, I did it Sunday, IIRC:
> > 
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=9adb014930f31c66608fa39a35ccea2daa5586ad
> 
> So I pushed it all to the master branch, hopefully some more people may
> feel encouraged to give it a try for the various things it fixes since
> 1.20:

heya,
the test script passed

jirka

> 
> [acme@quaco pahole]$ git log --oneline v1.20..
> ae0b7dde1fd50b12 (HEAD -> master, origin/tmp.master, origin/master, origin/HEAD, github/master, five/master, acme.korg/tmp.master, acme.korg/master) dwarf_loader: Handle DWARF5 DW_OP_addrx properly
> 9adb014930f31c66 dwarf_loader: Handle subprogram ret type with abstract_origin properly
> 5752d1951d081a80 dwarf_loader: Check .notes section for LTO build info
> 209e45424ff4a22d dwarf_loader: Check .debug_abbrev for cross-CU references
> 39227909db3cc2c2 dwarf_loader: Permit merging all DWARF CU's for clang LTO built binary
> 763475ca1101ccfe dwarf_loader: Factor out common code to initialize a cu
> d0d3fbd4744953e8 dwarf_loader: Permit a flexible HASHTAGS__BITS
> ffe0ef4d73906c18 btf: Add --btf_gen_all flag
> de708b33114d42c2 btf: Add support for the floating-point types
> 4b7f8c04d009942b fprintf: Honour conf_fprintf.hex when printing enumerations
> f2889ff163726336 Avoid warning when building with NDEBUG
> 8e1f8c904e303d5d btf_encoder: Match ftrace addresses within ELF functions
> 9fecc77ed82d429f dwarf_loader: Use a better hashing function, from libbpf
> 0125de3a4c055cdf btf_encoder: Funnel ELF error reporting through a macro
> 7d8e829f636f47ab btf_encoder: Sanitize non-regular int base type
> [acme@quaco pahole]$
> 
> - Arnaldo
> 

