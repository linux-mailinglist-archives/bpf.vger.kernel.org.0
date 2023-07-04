Return-Path: <bpf+bounces-3984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200674742C
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2879280FE8
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638975697;
	Tue,  4 Jul 2023 14:33:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D5A2C
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 14:33:34 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43365E47
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:33:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3143493728dso2880300f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688481210; x=1691073210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cUYxa/RIxSFp2aYnGJvOb11fMXdQnhKS87xLnOI+Kc=;
        b=V/AJDly5fJh8FVj2aHhpCip6FSGvxY955ns7QInXtUg/6/DKlbHYj5aDrHRu4QllD+
         rEhsKuDezVPSm8YLE/Pi+Pm6B1KBLz/D3cD8x5yIciP9xI4LGJgssQr48ztkI8jU9QN6
         YP8NF0f0Otdjvh+KOAO/9O48gVF8wSveyodS1X6iDR87Hg6lHolGnnRx3Md3IjPVBZBU
         Ns5mv8XqOjuk0KUD2CNokxCMdsIu3Zy5kmet9pgQhYRAQcH8Pke/kwI9OKYQpEmVIQ6C
         vDmaWFlwq1V5J0g1FxBWzR/jGTUuKOaulAPkX74bOCy6MxHMxHrLJjWmEfcBW8LW44s3
         tsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688481210; x=1691073210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cUYxa/RIxSFp2aYnGJvOb11fMXdQnhKS87xLnOI+Kc=;
        b=Jvx9E0h/4AI5mwyNPw4KdnCtVraX33padQXNww1ffTLuhATnMTywcOgZ+I9bg//Tol
         aunqihQPZxMJhSxaQg1UGzvTyUOIyJzEdGUu4GX0M4BdJLMjpzj2TAdlV7zitNK5K77F
         6bHbCPAx1WfRaHuIyCWVrborwTUnEIxYOmxS7bczJHO1BNg/kzElboaFgMWBIHGrc4B3
         bJVwlRuKpw3wJmQwsmV36TKasNb9WT9+bQYSbHv1zTE22I9GsOk2WbdXY1DDKLySgNR7
         HCyIUOnc0pxsoPYE5xr/nM8+eq0KEo6aM3x0JSdNWiyjf2Ko/uqPAs6Y72xgc9sTTsZO
         CAKA==
X-Gm-Message-State: ABy/qLa0PgVUqPwcwsdLwUYWAUyD7hguu7g32P7TOtXxzzqwAqachhNj
	Qp7kNJA8yZZofaNDuOpMiZkhQQ==
X-Google-Smtp-Source: APBJJlFofbA3p236vHTlt/wp0KnSdZCjndmk3wG9jEWkc3dhMbQDBCpoQ8AAplS8JQZqQomcI7oakw==
X-Received: by 2002:a5d:58e9:0:b0:314:14be:1004 with SMTP id f9-20020a5d58e9000000b0031414be1004mr11805253wrd.63.1688481209717;
        Tue, 04 Jul 2023 07:33:29 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id y11-20020a1c4b0b000000b003fbe4cecc5fsm204687wma.34.2023.07.04.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:33:29 -0700 (PDT)
Date: Tue, 4 Jul 2023 14:34:27 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
Message-ID: <ZKQt84Qz0A0ZkgN1@zh-lab-node-5>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-4-aspsk@isovalent.com>
 <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 09:56:36PM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> > Initialize and utilize the per-cpu insertions/deletions counters for hash-based
> > maps. Non-trivial changes only apply to the preallocated maps for which the
> > {inc,dec}_elem_count functions are not called, as there's no need in counting
> > elements to sustain proper map operations.
> >
> > To increase/decrease percpu counters for preallocated maps we add raw calls to
> > the bpf_map_{inc,dec}_elem_count functions so that the impact is minimal. For
> > dynamically allocated maps we add corresponding calls to the existing
> > {inc,dec}_elem_count functions.
> >
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  kernel/bpf/hashtab.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 56d3da7d0bc6..faaef4fd3df0 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -581,8 +581,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
> >  		}
> >  	}
> >  
> > +	err = bpf_map_init_elem_count(&htab->map);
> > +	if (err)
> > +		goto free_extra_elements;
> Considering the per-cpu counter is not always needed, is it a good idea
> to make the elem_count being optional by introducing a new map flag ?

Per-map-flag or a static key? For me it looked like just doing an unconditional
`inc` for a per-cpu variable is better vs. doing a check then `inc` or an
unconditional jump.

> > +
> >  	return &htab->map;
> >  
> > +free_extra_elements:
> > +	free_percpu(htab->extra_elems);
> >  free_prealloc:
> >  	prealloc_destroy(htab);
> Need to check prealloc before calling prealloc_destroy(htab), otherwise
> for non-preallocated percpu htab prealloc_destroy() will trigger invalid
> memory dereference.

Thanks!

> >  free_map_locked:
> > @@ -804,6 +810,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
> >  		if (l == tgt_l) {
> >  			hlist_nulls_del_rcu(&l->hash_node);
> >  			check_and_free_fields(htab, l);
> > +			bpf_map_dec_elem_count(&htab->map);
> >  			break;
> >  		}
> >  
> > @@ -900,6 +907,8 @@ static bool is_map_full(struct bpf_htab *htab)
> >  
> >  static void inc_elem_count(struct bpf_htab *htab)
> >  {
> > +	bpf_map_inc_elem_count(&htab->map);
> > +
> >  	if (htab->use_percpu_counter)
> >  		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
> >  	else
> > @@ -908,6 +917,8 @@ static void inc_elem_count(struct bpf_htab *htab)
> >  
> >  static void dec_elem_count(struct bpf_htab *htab)
> >  {
> > +	bpf_map_dec_elem_count(&htab->map);
> > +
> >  	if (htab->use_percpu_counter)
> >  		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
> >  	else
> > @@ -920,6 +931,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
> >  	htab_put_fd_value(htab, l);
> >  
> >  	if (htab_is_prealloc(htab)) {
> > +		bpf_map_dec_elem_count(&htab->map);
> >  		check_and_free_fields(htab, l);
> >  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
> >  	} else {
> > @@ -1000,6 +1012,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
> >  			if (!l)
> >  				return ERR_PTR(-E2BIG);
> >  			l_new = container_of(l, struct htab_elem, fnode);
> > +			bpf_map_inc_elem_count(&htab->map);
> >  		}
> >  	} else {
> >  		if (is_map_full(htab))
> > @@ -1224,7 +1237,8 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
> >  	if (l_old) {
> >  		bpf_lru_node_set_ref(&l_new->lru_node);
> >  		hlist_nulls_del_rcu(&l_old->hash_node);
> > -	}
> > +	} else
> > +		bpf_map_inc_elem_count(&htab->map);
> >  	ret = 0;
> >  
> >  err:
> > @@ -1351,6 +1365,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
> >  		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
> >  				value, onallcpus);
> >  		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
> > +		bpf_map_inc_elem_count(&htab->map);
> >  		l_new = NULL;
> >  	}
> >  	ret = 0;
> > @@ -1437,9 +1452,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
> >  
> >  	l = lookup_elem_raw(head, hash, key, key_size);
> >  
> > -	if (l)
> > +	if (l) {
> > +		bpf_map_dec_elem_count(&htab->map);
> >  		hlist_nulls_del_rcu(&l->hash_node);
> > -	else
> > +	} else
> >  		ret = -ENOENT;
> Also need to decrease elem_count for
> __htab_map_lookup_and_delete_batch() and
> __htab_map_lookup_and_delete_elem() when is_lru_map is true. Maybe for
> LRU map, we could just do bpf_map_dec_elem_count() in
> htab_lru_push_free() and do bpf_map_inc_elem_count() in prealloc_lru_pop().

Thanks. I will fix the logic and extend the selftest to test the batch ops as well.

> >  
> >  	htab_unlock_bucket(htab, b, hash, flags);
> > @@ -1523,6 +1539,7 @@ static void htab_map_free(struct bpf_map *map)
> >  		prealloc_destroy(htab);
> >  	}
> >  
> > +	bpf_map_free_elem_count(map);
> >  	free_percpu(htab->extra_elems);
> >  	bpf_map_area_free(htab->buckets);
> >  	bpf_mem_alloc_destroy(&htab->pcpu_ma);
> 

