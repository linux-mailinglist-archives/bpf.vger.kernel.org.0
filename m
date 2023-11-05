Return-Path: <bpf+bounces-14263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B807E1668
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 21:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EA01C20A9B
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF023212;
	Sun,  5 Nov 2023 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA325370
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 20:33:54 +0000 (UTC)
Received: from mx.der-flo.net (mx.der-flo.net [IPv6:2001:67c:26f4:224::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB5B8
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 12:33:53 -0800 (PST)
Date: Sun, 5 Nov 2023 21:33:49 +0100
From: Florian Lehner <dev@der-flo.net>
To: David Rheinsberg <david@readahead.eu>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, daniel@zonque.org
Subject: Re: [PATCH bpf-next] bpf, lpm: fix check prefixlen before walking
 trie
Message-ID: <ZUf8Ld8pQu46dyTi@der-flo.net>
References: <20231105085801.3742-1-dev@der-flo.net>
 <1d237338-6341-45be-9f0e-f1f1a9bdc153@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d237338-6341-45be-9f0e-f1f1a9bdc153@app.fastmail.com>

On Sun, Nov 05, 2023 at 08:08:43PM +0100, David Rheinsberg wrote:
> Hi
> 
> On Sun, Nov 5, 2023, at 9:58 AM, Florian Lehner wrote:
> > When looking up an element in LPM trie, the condition 'matchlen ==
> > trie->max_prefixlen' will never return true, if key->prefixlen is larger
> > than trie->max_prefixlen. Consequently all elements in the LPM trie will
> > be visited and no element is returned in the end.
> >
> 
> Am I understanding you right that this is an optimization to avoid walking the entire trie? Because the way I read your commit-message I assume the output has always been NULL? Or am I missing something.
> 
> Do you have a specific use-case where such lookups are common? Can you explain why it is important to optimize this case? Because you now add a condition for every lookup just to optimize for the lookup-miss of a special case. I don't think I understand your reasoning here, but I might be missing some context.
> 
> Thanks!
> David

Hi David,

Your understanding is correct. The return value currently and with this patch is
in both cases the same for the case where key->prefixlen > trie->max_prefixlen.

The optimization is to avoid the locking mechanism, walking the trie and
checking its elements. It might not be the most common use case, so I see your
point.

> 
> > Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
> > Signed-off-by: Florian Lehner <dev@der-flo.net>
> > ---
> >  kernel/bpf/lpm_trie.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > index 17c7e7782a1f..b32be680da6c 100644
> > --- a/kernel/bpf/lpm_trie.c
> > +++ b/kernel/bpf/lpm_trie.c
> > @@ -231,6 +231,9 @@ static void *trie_lookup_elem(struct bpf_map *map, 
> > void *_key)
> >  	struct lpm_trie_node *node, *found = NULL;
> >  	struct bpf_lpm_trie_key *key = _key;
> > 
> > +	if (key->prefixlen > trie->max_prefixlen)
> > +		return NULL;
> > +
> >  	/* Start walking the trie from the root node ... */
> > 
> >  	for (node = rcu_dereference_check(trie->root, rcu_read_lock_bh_held());
> > -- 
> > 2.39.2

