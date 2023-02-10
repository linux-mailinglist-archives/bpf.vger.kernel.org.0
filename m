Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D769235A
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjBJQdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 11:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjBJQdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 11:33:03 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637A71F2F;
        Fri, 10 Feb 2023 08:33:02 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id rp23so17308648ejb.7;
        Fri, 10 Feb 2023 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36jfRfjpqhmNS1duPNkwxJx3IHGqur1VspGy4Ua1oiQ=;
        b=KlPsEcLIuiSdvhUROlVLCP9c0G7mgvflpGqsFum0tOO2YzABNUGWEGUUTD2+RsXRQa
         ZTNRWnQZxj4Bm4uyDzuZsSwhJZaVK/wOTCb4Tvl04xYri9maWCcxInbS3GrddC+iuRNF
         pzJ24gR8pin4MP4QRiZ5B9VbmhQCNibNG7LymTPMzn0uuM7N9SjkdnHh0p75h+0D9n3E
         8ulWZmjthpU5hHLqr3uNu67Gi4WWMcs7ot0zYqoGHJBjVailbOqD5B8CsizRcMW6BEHI
         Rp1gJs7iN02px1WDFedgIeltOR7X9wljjuByth30O0swkUTwx4fFA3Sin3zEpftGJekY
         I6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36jfRfjpqhmNS1duPNkwxJx3IHGqur1VspGy4Ua1oiQ=;
        b=WzAnEjU6Q4Ubqp0Iv/eDOXfsj1IRAUs3mHkGxa+TfFegziQ8836ZQxpL3zu78633kP
         bVWFc8XOrQyuaNMzpJfDeM7tQ7C4By795K/0UDGxrfRyHsaR/mchWFE8hX5ltJOI/8R4
         XujTRcjdmqpkuci3qfXT58opo/nQSJ/9p6L8qCJRZyAkXGh0CLyuDPqormTtdRgam0KR
         lfVAGEzfJcbGHJoKFfGNuKiG5cHfJfAQnCCyYy9GJuMplc7aFHqfrgef0ucQ4+WPGYVH
         tVqm9Ulp9R0/GwqmOm5msXQKoTr4jsIgTY9LT0/jNLEDSriXRkNf3nc7+IlLk7jpjxf3
         A8GA==
X-Gm-Message-State: AO0yUKXW5aKVTIAePLWjdyvcahekvnP8YAJGWZS87i0UIgWq6k1P1dh1
        DJnZezD4mwp16QwnV/3RJzg=
X-Google-Smtp-Source: AK7set8DE7gfT4eECNAkT57ZQlfLptfGdu85VnKZFp4cev3WIP8r/ys3Lv3HgDZTB3eOjj79CR0dWA==
X-Received: by 2002:a17:907:62a1:b0:86f:64bb:47eb with SMTP id nd33-20020a17090762a100b0086f64bb47ebmr22733938ejc.3.1676046780586;
        Fri, 10 Feb 2023 08:33:00 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:2d0])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b008a586200573sm2588517ejd.66.2023.02.10.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:32:59 -0800 (PST)
Date:   Fri, 10 Feb 2023 17:32:58 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Hou Tao <houtao@huaweicloud.com>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Message-ID: <20230210163258.phekigglpquitq33@apollo>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 07:26:12PM CET, Alexei Starovoitov wrote:
> On Tue, Jan 3, 2023 at 11:14 PM Yonghong Song <yhs@meta.com> wrote:
> >
> >
> >
> > On 1/3/23 10:30 PM, Hou Tao wrote:
> > > Hi,
> > >
> > > On 1/4/2023 2:10 PM, Yonghong Song wrote:
> > >>
> > >>
> > >> On 1/3/23 5:47 AM, Hou Tao wrote:
> > >>> Hi,
> > >>>
> > >>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
> > >>>>
> > >>>>
> > >>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
> > >>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
> > >>>>>> From: Hou Tao <houtao1@huawei.com>
> > >>>>>>
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> The patchset tries to fix the problems found when checking how htab map
> > >>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
> > >>>>>> freed elements may lead to two problems in htab map:
> > >>>>>>
> > >>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
> > >>>>>>        htab map value and it may corrupt lookup procedure with BFP_F_LOCK
> > >>>>>>        flag which acquires bpf-spin-lock during value copying. The
> > >>>>>>        corruption of bpf-spin-lock may result in hard lock-up.
> > >>>>>> (2) lookup procedure may get incorrect map value if the found element is
> > >>>>>>        freed and then reused.
> > >>>>>>
> > >>>>>> Because the type of htab map elements are the same, so problem #1 can be
> > >>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
> > >>>>>> these special fields in map element only when the map element is newly
> > >>>>>> allocated. If it is just a reused element, there will be no
> > >>>>>> reinitialization.
> > >>>>>
> > >>>>> Instead of adding the overhead of ctor callback let's just
> > >>>>> add __GFP_ZERO to flags in __alloc().
> > >>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
> > >>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> > >>>>> will behave the same way.
> > >>>>
> > >>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
> > >>>> tried to address a similar issue for lru hash table.
> > >>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
> > >>>> hash table?
> > >>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
> > >>
> > >> The following is my understanding:
> > >> in function alloc_htab_elem() (hashtab.c), we have
> > >>
> > >>                  if (is_map_full(htab))
> > >>                          if (!old_elem)
> > >>                                  /* when map is full and update() is replacing
> > >>                                   * old element, it's ok to allocate, since
> > >>                                   * old element will be freed immediately.
> > >>                                   * Otherwise return an error
> > >>                                   */
> > >>                                  return ERR_PTR(-E2BIG);
> > >>                  inc_elem_count(htab);
> > >>                  l_new = bpf_mem_cache_alloc(&htab->ma);
> > >>                  if (!l_new) {
> > >>                          l_new = ERR_PTR(-ENOMEM);
> > >>                          goto dec_count;
> > >>                  }
> > >>                  check_and_init_map_value(&htab->map,
> > >>                                           l_new->key + round_up(key_size, 8));
> > >>
> > >> In the above check_and_init_map_value() intends to do initializing
> > >> for an element from bpf_mem_cache_alloc (could be reused from the free list).
> > >>
> > >> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
> > >>
> > >> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
> > >> {
> > >>          int i;
> > >>
> > >>          if (!foffs)
> > >>                  return;
> > >>          for (i = 0; i < foffs->cnt; i++)
> > >>                  memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
> > >> }
> > >>
> > >> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> > >> {
> > >>          bpf_obj_init(map->field_offs, dst);
> > >> }
> > >>
> > >> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
> > >> list_head, list_node, etc.
> > >>
> > >> This is the problem for above problem #1.
> > >> Maybe I missed something?
> > > Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
> > > problem by only calling check_and_init_map_value() once for the newly-allocated
> > > element, so if a freed element is reused, its special fields will not be zeroed
> > > again. Is there any other cases which are not covered by the solution or any
> > > other similar problems in hash-tab ?
> >
> > No, I checked all cases of check_and_init_map_value() and didn't find
> > any other instances.
>
> check_and_init_map_value() is called in two other cases:
> lookup_and_delete[_batch].
> There the zeroing of the fields is necessary because the 'value'
> is a temp buffer that is going to be copied to user space.
> I think the way forward is to add GFP_ZERO to mem_alloc
> (to make it equivalent to prealloc), remove one case
> of check_and_init_map_value from hashmap, add short comments
> to two other cases and add a big comment to check_and_init_map_value()
> that should say that 'dst' must be a temp buffer and should not
> point to memory that could be used in parallel by a bpf prog.
> It feels like we've dealt with this issue a couple times already
> and keep repeating this mistake, so the more comments the better.

Hou, are you plannning to resubmit this change? I also hit this while testing my
changes on bpf-next.
