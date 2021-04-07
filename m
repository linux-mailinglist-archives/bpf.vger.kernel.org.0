Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4C35707A
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353529AbhDGPhW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 11:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343796AbhDGPhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 11:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E5D6113A;
        Wed,  7 Apr 2021 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617809831;
        bh=HZh+2CDGlk3M90njZ5nvEWB6Xmx16vz+SlphG0rJpnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtaEvoO7M0UMpa2eLwM7CcK5MeqYQn75gGVwUc1GMzSP9NUzW7pO5feOhvA2Imlyf
         AtETT6g/jzXdQqa3hKd7/Oz1dAtB/AX4Q22kDqHHGcq32UG9Mqf1H+CnRPro1V/emN
         FaWQDU09wY9vHF+5laWaKQ2nwDYmyceI25rYFIenJJimq5QhfqFFSFLrn7SQFECx7T
         9c/BlgbrU1mVzlj+8SOAVyoQ34osYaOIWGfJTWH7IRT5zHzyyQGVWXbeVgK3aV2Su6
         vbc9ssWNHLscvvMqj1cWN8aTbI/ESAWKR3l1OaJ8KsqqmGZe36nw78suNESi80eap3
         RfYhvyRvsT8lg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BFEA40647; Wed,  7 Apr 2021 12:37:09 -0300 (-03)
Date:   Wed, 7 Apr 2021 12:37:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
Message-ID: <YG3RpVgLC9UEUrb8@kernel.org>
References: <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org>
 <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Apr 07, 2021 at 07:54:26AM -0700, Yonghong Song escreveu:
> On 4/2/21 11:08 AM, Arnaldo wrote:
> > On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
> > > On 4/2/21 10:23 AM, Yonghong Song wrote:
> > :> Thanks. I checked out the branch and did some testing with latest
> > > clang
> > > > trunk (just pulled in).
> > > > 
> > > > With kernel LTO note support, I tested gcc non-lto, and llvm-lto
> > > mode,
> > > > it works fine.
> > > > 
> > > > Without kernel LTO note support, I tested
> > > >     gcc non-lto  <=== ok
> > > >     llvm non-lto  <=== not ok
> > > >     llvm lto     <=== ok
> > > > 
> > > > Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
> > > issue.
> > > > Some previous version of clang does not have this issue.
> > > > I double checked the dwarfdump and it is indeed has the same reason
> > > > for lto vmlinux. I checked abbrev section and there is no cross-cu
> > > > references.
> > > > 
> > > > That means we need to adapt this patch
> > > >     dwarf_loader: Handle subprogram ret type with abstract_origin
> > > properly
> > > > for non merging case as well.
> > > > The previous patch fixed lto subprogram abstract_origin issue,
> > > > I will submit a followup patch for this.
> > > 
> > > Actually, the change is pretty simple,
> > > 
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index 5dea837..82d7131 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die
> > > *die, struct cu *cu)
> > >          int ret = die__process(die, cu);
> > >          if (ret != 0)
> > >                  return ret;
> > > -       return cu__recode_dwarf_types(cu);
> > > +       ret = cu__recode_dwarf_types(cu);
> > > +       if (ret != 0)
> > > +               return ret;
> > > +
> > > +       return cu__resolve_func_ret_types(cu);
> > >   }
> > > 
> > > Arnaldo, do you just want to fold into previous patches, or
> > > you want me to submit a new one?
> > 
> > I can take care of that.
> 
> Arnaldo, just in case that you missed it, please remember
> to fold the above changes to the patch:
>    [PATCH dwarves] dwarf_loader: handle subprogram ret type with
> abstract_origin properly
> Thanks!

Its there, I did it Sunday, IIRC:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=9adb014930f31c66608fa39a35ccea2daa5586ad

@@ -2295,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die *die, struct cu *cu)
 	int ret = die__process(die, cu);
 	if (ret != 0)
 		return ret;
-	return cu__recode_dwarf_types(cu);
+	ret = cu__recode_dwarf_types(cu);
+	if (ret != 0)
+		return ret;
+
+	return cu__resolve_func_ret_types(cu);
 }

 static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,

----

My latest tests were all with it in place.

- Arnaldo
 
> > 
> > And I think it's time for to look at Jiri's test suite... :-)
> > 
> > It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.
> > 
> > Cheers,
> > 
> > - Arnaldo
> > 

-- 

- Arnaldo
