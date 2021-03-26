Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7A34ADAC
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZRfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 13:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhCZRfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 13:35:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28760619B8;
        Fri, 26 Mar 2021 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616780151;
        bh=o/TWp2WpTOs2d3+uE5S05MFCAj+iU2nJ+BxilU0BG6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2peE+p7w1WZhz6QtsAqdlAnwNS7cILfIttodDoTDpBQ2k2/Bwdy2jOfOe/w/m+Di
         AtD5YKyDMwelpoLZ0Bzuy/qg7N+70gtWqzoq69zkZphWmOZVBpvaI/XoHKYfPjxw/E
         grUP+wgJOMfltnQN4BUDqHDGjN3Kvi9Gpa+ZgbSf2cGKx4LoAqAp+BCcGflW8QiJw0
         poHRnOX9CQtjSOdZzewza+87oEpmSN/0FAUGhvA6keuoWgkeDfQ8Sb+DuLuew6bm8a
         8yq6E6pUeeYOlAVnwSZJi3pE4oKK5uIb/yiqZ7ttBIRQJK3U32js6F1Xd5xcunsWgl
         waVRt/OAYv03g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DEB5F40647; Fri, 26 Mar 2021 14:35:48 -0300 (-03)
Date:   Fri, 26 Mar 2021 14:35:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: add option to merge more dwarf
 cu's into one pahole cu
Message-ID: <YF4bdBxql+6xLKLC@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065332.3122473-1-yhs@fb.com>
 <YF3ynAKXDCE0kDpp@kernel.org>
 <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d618edb6-e4c0-a260-905f-e07720746594@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 26, 2021 at 08:18:07AM -0700, Yonghong Song escreveu:
> 
> 
> On 3/26/21 7:41 AM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 24, 2021 at 11:53:32PM -0700, Yonghong Song escreveu:
> > > This patch added an option "merge_cus", which will permit
> > > to merge all debug info cu's into one pahole cu.
> > > For vmlinux built with clang thin-lto or lto, there exist
> > > cross cu type references. For example, you could have
> > >    compile unit 1:
> > >       tag 10:  type A
> > >    compile unit 2:
> > >       ...
> > >         refer to type A (tag 10 in compile unit 1)
> > > I only checked a few but have seen type A may be a simple type
> > > like "unsigned char" or a complex type like an array of base types.
> > > 
> > > There are two different ways to resolve this issue:
> > > (1). merge all compile units as one pahole cu so tags/types
> > >       can be resolved easily, or
> > > (2). try to do on-demand type traversal in other debuginfo cu's
> > >       when we do die_process().
> > > The method (2) is much more complicated so I picked method (1).
> > > An option "merge_cus" is added to permit such an operation.
> > > 
> > > Merging cu's will create a single cu with lots of types, tags
> > > and functions. For example with clang thin-lto built vmlinux,
> > > I saw 9M entries in types table, 5.2M in tags table. The
> > > below are pahole wallclock time for different hashbits:
> > > command line: time pahole -J --merge_cus vmlinux
> > >        # of hashbits            wallclock time in seconds
> > >            15                       460
> > >            16                       255
> > >            17                       131
> > >            18                       97
> > >            19                       75
> > >            20                       69
> > >            21                       64
> > >            22                       62
> > >            23                       58
> > >            24                       64
> > > 
> > > Note that the number of hashbits 24 makes performance worse
> > > than 23. The reason could be that 23 hashbits can cover 8M
> > > buckets (close to 9M for the number of entries in types table).
> > > Higher number of hash bits allocates more memory and becomes
> > > less cache efficient compared to 23 hashbits.
> > > 
> > > This patch picks # of hashbits 21 as the starting value
> > > and will try to allocate memory based on that, if memory
> > > allocation fails, we will go with less hashbits until
> > > we reach hashbits 15 which is the default for
> > > non merge-cu case.
> > 
> > I'll probably add a way to specify the starting max_hashbits to be able
> > to use 'perf stat' to show what causes the performance difference.
> 
> The problem is with hashtags__find(), esp. the loop
> 
>         uint32_t bucket = hashtags__fn(id);
>         const struct hlist_head *head = hashtable + bucket;
> 
>         hlist_for_each_entry(tpos, pos, head, hash_node) {
>                 if (tpos->id == id)
>                         return tpos;
>         }
> 
> Say we have 8M types and (1 << 15) buckets, that means
> each bucket will 64 elements. So each lookup will traverse
> the loop 32 iterations on average.
> 
> If we have 1 << 21 buckets, then each buckets will have 4 elements,
> and the average number of loop iterations for hashtags__find()
> will be 2.
> 
> If the patch needs respin, I can add the above descriptions
> in the commit message.

I can add that, as a comment.

- Arnaldo
