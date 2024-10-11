Return-Path: <bpf+bounces-41756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33D99A915
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4661C22EB1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4419DF5B;
	Fri, 11 Oct 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiz1TXV1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAB19ABD1;
	Fri, 11 Oct 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665088; cv=none; b=VbUYIQanXOPALBUCikA4+tZ0+ViHQc2ADxYk2gRycNFNoxzjrqjvKKGGtS1tNmqBXKvkyd9+48BrvT06vnqq9geZUHp0mQsf0w6kPaWoCN5tFPhRqWWHWtuX7mRrOPLmGaIuoM/ZAddpmiMcwIEUc2lzll4PiUwyoLMHSUQNi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665088; c=relaxed/simple;
	bh=8ipAP7rKzsJHYG0l55F8C3yoyi1nzpis8LqueewE/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng5yQeSaSX8K6na+FCy+1+tESJem0YMJZlICMnSAqkmI3OWZ9WXFh4Zbpd6AML4HwYlHGsBJfwNnywHUEJbtYoS1S7UnvnrNMhqBfEQV71oYAAD4k8H3kFQLw2u2Y4BDoprX/lDKOgh357lGGELEpJgcrqv9LgXyp2jtCwnR3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiz1TXV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32DCC4CEC7;
	Fri, 11 Oct 2024 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728665088;
	bh=8ipAP7rKzsJHYG0l55F8C3yoyi1nzpis8LqueewE/WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiz1TXV1z/zVIveYuhW45H8b1TH5OzQFtqdjaZiVVGcTayiNRt88LJfafAKGLhMFK
	 1FEoPhQAYIHv9B2+qasE+fW9n3z0cTFg5Lq+2bDFocO3U6fa55YdcTytD6fB60d8xC
	 KgIRRespKuuKONLWLDx7Li3P9YBuqZNis7GxDLJx4Y4M7LvOpnf9Fc5E2rGFLJ2IJ9
	 qsZWMuYGwNyoLtmDMiIiUUqZd//EQ/3VKGQiT4paCOEcpvEuIFC9daRnTPLz1I+n8a
	 g1k2iimVnjgeG2+Fyb2TsF7PMdPxhvjbYGUbaOHEL9txEtAh3FtldWPDQSlWhRqjtt
	 Y4QiiOn7uldHQ==
Date: Fri, 11 Oct 2024 09:44:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tools: Fix possible compiler warnings in hashmap
Message-ID: <ZwlV_jyx3OjfQxwS@google.com>
References: <20241009202009.884884-1-namhyung@kernel.org>
 <CAEf4BzYQenNtKPmWV=P3EsnqBsjNuAeXpC5ypL1k2z-H60i0=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYQenNtKPmWV=P3EsnqBsjNuAeXpC5ypL1k2z-H60i0=w@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:48:26PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 9, 2024 at 1:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The hashmap__for_each_entry[_safe] is accessing 'map' as if it's a
> > pointer.  But it does without parentheses so passing a static hash map
> > with an ampersand (like &slab_hash below) caused compiler warnings due
> > to unmatched types.
> >
> >   In file included from util/bpf_lock_contention.c:5:
> >   util/bpf_lock_contention.c: In function ‘exit_slab_cache_iter’:
> >   linux/tools/perf/util/hashmap.h:169:32: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
> >     169 |         for (bkt = 0; bkt < map->cap; bkt++)                                \
> >         |                                ^~
> >   util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
> >     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~
> >   /home/namhyung/project/linux/tools/perf/util/hashmap.h:170:31: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
> >     170 |                 for (cur = map->buckets[bkt]; cur; cur = cur->next)
> >         |                               ^~
> >   util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
> >     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > I've discovered this while prototyping the slab symbolization for perf
> > lock contention.  So this code is not available yet but I'd like to fix
> > the problem first.
> >
> > Also noticed bpf has the same code and the same problem.  I'll send a
> > separate patch for them.
> >
> 
> Yep, please do. Fixes look good, thanks.

Sure will do, can I get your Acked-by for this patch?

Thanks,
Namhyung

> 
> >  tools/perf/util/hashmap.h | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> > index c12f8320e6682d50..0c4f155e8eb745d9 100644
> > --- a/tools/perf/util/hashmap.h
> > +++ b/tools/perf/util/hashmap.h
> > @@ -166,8 +166,8 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
> >   * @bkt: integer used as a bucket loop cursor
> >   */
> >  #define hashmap__for_each_entry(map, cur, bkt)                             \
> > -       for (bkt = 0; bkt < map->cap; bkt++)                                \
> > -               for (cur = map->buckets[bkt]; cur; cur = cur->next)
> > +       for (bkt = 0; bkt < (map)->cap; bkt++)                              \
> > +               for (cur = (map)->buckets[bkt]; cur; cur = cur->next)
> >
> >  /*
> >   * hashmap__for_each_entry_safe - iterate over all entries in hashmap, safe
> > @@ -178,8 +178,8 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
> >   * @bkt: integer used as a bucket loop cursor
> >   */
> >  #define hashmap__for_each_entry_safe(map, cur, tmp, bkt)                   \
> > -       for (bkt = 0; bkt < map->cap; bkt++)                                \
> > -               for (cur = map->buckets[bkt];                               \
> > +       for (bkt = 0; bkt < (map)->cap; bkt++)                              \
> > +               for (cur = (map)->buckets[bkt];                             \
> >                      cur && ({tmp = cur->next; true; });                    \
> >                      cur = tmp)
> >
> > @@ -190,19 +190,19 @@ bool hashmap_find(const struct hashmap *map, long key, long *value);
> >   * @key: key to iterate entries for
> >   */
> >  #define hashmap__for_each_key_entry(map, cur, _key)                        \
> > -       for (cur = map->buckets                                             \
> > -                    ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
> > +       for (cur = (map)->buckets                                           \
> > +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
> >                      : NULL;                                                \
> >              cur;                                                           \
> >              cur = cur->next)                                               \
> > -               if (map->equal_fn(cur->key, (_key), map->ctx))
> > +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
> >
> >  #define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)              \
> > -       for (cur = map->buckets                                             \
> > -                    ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
> > +       for (cur = (map)->buckets                                           \
> > +                    ? (map)->buckets[hash_bits((map)->hash_fn((_key), (map)->ctx), (map)->cap_bits)] \
> >                      : NULL;                                                \
> >              cur && ({ tmp = cur->next; true; });                           \
> >              cur = tmp)                                                     \
> > -               if (map->equal_fn(cur->key, (_key), map->ctx))
> > +               if ((map)->equal_fn(cur->key, (_key), (map)->ctx))
> >
> >  #endif /* __LIBBPF_HASHMAP_H */
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
> >

