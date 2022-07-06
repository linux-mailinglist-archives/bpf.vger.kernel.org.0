Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04496568EA5
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGFQGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFQGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 12:06:39 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE125EB3
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 09:06:37 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3EF4C24002A
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 18:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657123595; bh=DLib4DaFLxbHP4zBSItq6bMqdHnKnvGvuxyPghHDe7k=;
        h=Date:From:To:Cc:Subject:From;
        b=m4A5qGuEleColyYLqNhulq5IB91q0HHVIoYHNLN8e83SCWZISDfG87e4JfYR4TAFa
         RIZjGlrzTdkdwNika2JDOiSdKPcte4VxcmdCXczCgf7jWEjD2WtIYBjJgYnSQa42gs
         y0INHeEhFXCiIKyL7XzudUk16yAUSgVI/cCuL18/cWsu6FRRShrrHBRoTJybcDIgbA
         iVSfs6uY07KAqaJQ03+4MifGUpR4CaSbCzEyPgZnUl+g+1KEHfZ4zGNo10EZqqPUsm
         kDWxzh6d3Ckpcun5b7jgwi9uN+ZHwcsMkMR5oTjgbEat4CXmSE16b4KPVU/WrJG3qh
         G8RDK0sIdUcPg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LdPYN3R8Vz9rxF;
        Wed,  6 Jul 2022 18:06:32 +0200 (CEST)
Date:   Wed,  6 Jul 2022 16:06:28 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/10] Introduce type match support
Message-ID: <20220706160628.z3lyfzzz5s4fzual@muellerd-fedora-MJ0AC3F3>
References: <20220628160127.607834-1-deso@posteo.net>
 <20220705210700.fpyw4msqy7tkiuub@muellerd-fedora-MJ0AC3F3>
 <CAEf4Bzb=2QnL_oUYTLZ9T_poDGcQ0_WB_ZJs8LQNuC3Dp0Qfng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb=2QnL_oUYTLZ9T_poDGcQ0_WB_ZJs8LQNuC3Dp0Qfng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 05, 2022 at 09:16:27PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 5, 2022 at 2:07 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Tue, Jun 28, 2022 at 04:01:17PM +0000, Daniel Müller wrote:
> > > This patch set proposes the addition of a new way for performing type queries to
> > > BPF. It introduces the "type matches" relation, similar to what is already
> > > present with "type exists" (in the form of bpf_core_type_exists).
> > >
> > > "type exists" performs fairly superficial checking, mostly concerned with
> > > whether a type exists in the kernel and is of the same kind (enum/struct/...).
> > > Notably, compatibility checks for members of composite types is lacking.
> > >
> > > The newly introduced "type matches" (bpf_core_type_matches) fills this gap in
> > > that it performs stricter checks: compatibility of members and existence of
> > > similarly named enum variants is checked as well. E.g., given these definitions:
> > >
> > >       struct task_struct___og { int pid; int tgid; };
> > >
> > >       struct task_struct___foo { int foo; }
> > >
> > > 'task_struct___og' would "match" the kernel type 'task_struct', because the
> > > members match up, while 'task_struct___foo' would not match, because the
> > > kernel's 'task_struct' has no member named 'foo'.
> > >
> > > More precisely, the "type match" relation is defined as follows (copied from
> > > source):
> > > - modifiers and typedefs are stripped (and, hence, effectively ignored)
> > > - generally speaking types need to be of same kind (struct vs. struct, union
> > >   vs. union, etc.)
> > >   - exceptions are struct/union behind a pointer which could also match a
> > >     forward declaration of a struct or union, respectively, and enum vs.
> > >     enum64 (see below)
> > > Then, depending on type:
> > > - integers:
> > >   - match if size and signedness match
> > > - arrays & pointers:
> > >   - target types are recursively matched
> > > - structs & unions:
> > >   - local members need to exist in target with the same name
> > >   - for each member we recursively check match unless it is already behind a
> > >     pointer, in which case we only check matching names and compatible kind
> > > - enums:
> > >   - local variants have to have a match in target by symbolic name (but not
> > >     numeric value)
> > >   - size has to match (but enum may match enum64 and vice versa)
> > > - function pointers:
> > >   - number and position of arguments in local type has to match target
> > >   - for each argument and the return value we recursively check match
> > >
> > > Enabling this feature requires a new relocation to be made known to the
> > > compiler. This is being taken care of for LLVM as part of
> > > https://reviews.llvm.org/D126838.
> >
> > To give an update here, LLVM changes have been merged and, to the best of my
> > knowledge, are being used by BPF CI (tests that failed earlier are now passing).
> >
> 
> I did a few small changes and combined patches 4-6 together (because
> they add the same functionality to both libbpf and kernel
> simultaneously, there were compilation warnings about non-static
> functions not having a proper prototype defined). But I've split out
> the bpf_core_type_matches() macro in bpf_core_read.h into a separate
> patch. I also dropped patch #3 as it wasn't needed anymore.
> 
> Please see comments I left for two further follow ups.

Sounds good. Will address your comments soon. Thanks for merging!

Daniel
