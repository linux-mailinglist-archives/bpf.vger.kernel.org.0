Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE44434D20B
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2ODJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 10:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhC2OCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 10:02:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E79E761919;
        Mon, 29 Mar 2021 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617026561;
        bh=jZ84Kx1QKeMriH5E5MyUFs6HkGziTJC38y5O0J97dvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntLOyS/HUdvyJGAYVGGoKL5X+ZXb6HQ2oymcMWkW+y+vSICwqb5oeCFbrmAoXSwpX
         h2l2+id6pzrei7hMaTTxOtetZV9ugdgcIGSO7xSl+SE2s5Ugu2FGvqqJXDMXdhofwR
         eo8P5SEbRl9QumIdnkNG/lnYpYy+QeIJIugO8Le4gObAkFAs57YHavB/9FXaZ3jgQd
         73lfx46nKiRkzEYXx2cpkH5YMQbC2mh68hpD2EtQgkH/+qMUgpjYt3XnfxU4tG4/hn
         NuQKzaNE50ywcvy0NrjYVQK77F80SJIQii9Wh/+EXsJlcH4cz0nYBUoAcWUUj9sPxE
         k3ajfWzjt8HVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B79DF40647; Mon, 29 Mar 2021 11:02:38 -0300 (-03)
Date:   Mon, 29 Mar 2021 11:02:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH dwarves 1/3] dwarf_loader: permits flexible HASHTAGS__BITS
Message-ID: <YGHd/qO/MwurHcaR@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
 <20210325065322.3121605-1-yhs@fb.com>
 <CAEf4BzYcfEjeRHD_aVPvJNXqtqR2Uso4Rt+Q4SmCk5+GUoAzEg@mail.gmail.com>
 <55c83f03-1b86-ad79-2bfa-69c8c26fa7d2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c83f03-1b86-ad79-2bfa-69c8c26fa7d2@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Mar 26, 2021 at 04:26:20PM -0700, Yonghong Song escreveu:
> 
> 
> On 3/26/21 4:13 PM, Andrii Nakryiko wrote:
> > On Wed, Mar 24, 2021 at 11:53 PM Yonghong Song <yhs@fb.com> wrote:
> > > 
> > > Currently, types/tags hash table has fixed HASHTAGS__BITS = 15.
> > > That means the number of buckets will be 1UL << 15 = 32768.
> > > In my experiments, a thin-LTO built vmlinux has roughly 9M entries
> > > in types table and 5.2M entries in tags table. So the number
> > > of buckets is too less for an efficient lookup. This patch
> > > refactored the code to allow the number of buckets to be changed.
> > > 
> > > In addition, currently hashtags__fn(key) return value is
> > > assigned to uint16_t. Change to uint32_t as in a later patch
> > > the number of hashtag bits can be increased to be more than 16.
> > > 
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >   dwarf_loader.c | 48 +++++++++++++++++++++++++++++++++++++-----------
> > >   1 file changed, 37 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > > index c106919..a02ef23 100644
> > > --- a/dwarf_loader.c
> > > +++ b/dwarf_loader.c
> > > @@ -50,7 +50,12 @@ struct strings *strings;
> > >   #define DW_FORM_implicit_const 0x21
> > >   #endif
> > > 
> > > -#define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
> > > +static uint32_t hashtags__bits = 15;
> > > +
> > > +uint32_t hashtags__fn(Dwarf_Off key)
> > > +{
> > > +       return hash_64(key, hashtags__bits);
> > 
> > I vaguely remember pahole patch that updated hash function to use the
> > same one as libbpf's hashmap is using. Arnaldo, wasn't that patch
> > accepted?

I guess so:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=9fecc77ed82d429fd3fe49ba275465813228e617

dwarf_loader: Use a better hashing function, from libbpf

This hashing function[1] produces better hash table bucket
distributions. The original hashing function always produced zeros in
the three least significant bits. The new hashing function gives a
modest performance boost:

  Original: 0:11.373s
  New:      0:11.110s

for a performance improvement of ~2%.

[1] From the hash function used in libbpf.

Committer notes:

Bill found the suboptimality of the hash function being used, Andrii
suggested using the libbpf one, which ended up being better.

Signed-off-by: Bill Wendling <morbo@google.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Cc: dwarves@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> > But more to the point, I think hashtags__fn() should probably preserve
> > all 64 bits of the hash?
> 
> I don't know the context. If the purpose is to avoid future changes
> in case that the hashtags__bits > 32 happens, yes, the change may
> make sense.
> 
> > 
> > > +}
> > > 
> > >   bool no_bitfield_type_recode = true;
> > > 
> > > @@ -102,9 +107,6 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
> > >          *(dwarf_off_ref *)(dtag + 1) = spec;
> > >   }
> > > 
> > > -#define HASHTAGS__BITS 15
> > > -#define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
> > > -
> > >   #define obstack_chunk_alloc malloc
> > >   #define obstack_chunk_free free
> > > 
> > > @@ -118,22 +120,41 @@ static void *obstack_zalloc(struct obstack *obstack, size_t size)
> > >   }
> > > 
> > >   struct dwarf_cu {
> > > -       struct hlist_head hash_tags[HASHTAGS__SIZE];
> > > -       struct hlist_head hash_types[HASHTAGS__SIZE];
> > > +       struct hlist_head *hash_tags;
> > > +       struct hlist_head *hash_types;
> > >          struct obstack obstack;
> > >          struct cu *cu;
> > >          struct dwarf_cu *type_unit;
> > >   };
> > > 
> > > -static void dwarf_cu__init(struct dwarf_cu *dcu)
> > > +static int dwarf_cu__init(struct dwarf_cu *dcu)
> > >   {
> > > +       uint64_t hashtags_size = 1UL << hashtags__bits;
> > 
> > I wish pahole could just use libbpf's dynamically resized hashmap,
> > instead of hard-coding maximum size like this :(
> > 
> > Arnaldo, libbpf is not going to expose its hashmap as public API, but
> > if you'd like to use it, feel free to just copy/paste the code. It
> > hasn't change for a while and is unlikely to change (unless some day
> > we decide to make more efficient open-addressing implementation).
> > 
> > > +       dcu->hash_tags = malloc(sizeof(struct hlist_head) * hashtags_size);
> > > +       if (!dcu->hash_tags)
> > > +               return -ENOMEM;
> > > +
> > > +       dcu->hash_types = malloc(sizeof(struct hlist_head) * hashtags_size);
> > > +       if (!dcu->hash_types) {
> > > +               free(dcu->hash_tags);
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > 
> > [...]
> > 

-- 

- Arnaldo
