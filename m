Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D716928E9
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 22:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBJVHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 16:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjBJVHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 16:07:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5047B171;
        Fri, 10 Feb 2023 13:07:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so19069950ejc.2;
        Fri, 10 Feb 2023 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5c2ACZuFFTh4lLYq1CMAdfAXqUF+vpuoKUlv20dnV8Y=;
        b=V1/zcRhANAMqVMDBwCttFnH86sIZHQU2VTtOS9zQl1ci/BBDfW/w8lOPvgAetemYtc
         wnaHiwTjuVOHoFDpbytc536rEPNeSaUGcCzEuDLCtavaudwYe+Kx8jmIHlUhQIsXV5Vo
         mBaP5NSLIlVQbZEJ6eWWQ/+hdlrkjdOlK/2RW0bXK5xXgUAgIiPEEThCgQopMF1nOLPM
         QpHdT9P9lwZ/WF1tvzctLVF9LlNZjQXiOXm6dsMz5CF99oCdn0kWsoEEpW0hgF1zTlko
         EvawMp3UyKX8hOYRcPJC4soapdMXyPKa0ITzRx8mFQRud7gI1hTiKo7pJhWCWxW+ljzA
         3Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c2ACZuFFTh4lLYq1CMAdfAXqUF+vpuoKUlv20dnV8Y=;
        b=kOffC0ZWvpdOQDYloaox2HTGWznRYsLTelW7/R9ejwKnbr0NcXTKvloqTCQfGYy8ST
         1bk7DvHXlya90wA0lH8OQ1GaOnYzzFdINbk2JfLKuMbUTPrZcuDdHxX63h20KY7P6u/8
         PxezTsbr1oJ6dpGEaMXUnUdFo5f6hU5Ue2A7Cm4glHhDcMCgKmfxChhyvC7EwtSNheim
         RZ/iuzh8GFS1USuqjwHvaihjkV2PSKzTSrAPUnt8vjgmvzBZHbn+TNXt68z93BFpZO7D
         rX2omwVJRGwqHV7T8R9aWBl+a+wcnSW94KTq82HY6V/0cF3zUrtnxOfdOzhxybrtL58o
         jG+g==
X-Gm-Message-State: AO0yUKXSWdB3TwcN9JX+KVSLClIg1XbBR0va7mWfx8YIf4cxxNo3VwGU
        0DmtPSsoEpJYAKxvTiCIu8Ya+lQyRGbWEevCF/0=
X-Google-Smtp-Source: AK7set902w2IBDigxPYSpnFcScVLX36wjNm3vw0Rz6XjCFJR2FTtGF1eAXym/q5Y2MVJMty7rhpe8TwnHsb6BupwgRk=
X-Received: by 2002:a17:906:4ccf:b0:883:ba3b:eb94 with SMTP id
 q15-20020a1709064ccf00b00883ba3beb94mr1525913ejt.3.1676063223676; Fri, 10 Feb
 2023 13:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com> <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
In-Reply-To: <20230210163258.phekigglpquitq33@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 10 Feb 2023 13:06:52 -0800
Message-ID: <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 8:33 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Jan 04, 2023 at 07:26:12PM CET, Alexei Starovoitov wrote:
> > On Tue, Jan 3, 2023 at 11:14 PM Yonghong Song <yhs@meta.com> wrote:
> > >
> > >
> > >
> > > On 1/3/23 10:30 PM, Hou Tao wrote:
> > > > Hi,
> > > >
> > > > On 1/4/2023 2:10 PM, Yonghong Song wrote:
> > > >>
> > > >>
> > > >> On 1/3/23 5:47 AM, Hou Tao wrote:
> > > >>> Hi,
> > > >>>
> > > >>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
> > > >>>>
> > > >>>>
> > > >>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
> > > >>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
> > > >>>>>> From: Hou Tao <houtao1@huawei.com>
> > > >>>>>>
> > > >>>>>> Hi,
> > > >>>>>>
> > > >>>>>> The patchset tries to fix the problems found when checking how htab map
> > > >>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
> > > >>>>>> freed elements may lead to two problems in htab map:
> > > >>>>>>
> > > >>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
> > > >>>>>>        htab map value and it may corrupt lookup procedure with BFP_F_LOCK
> > > >>>>>>        flag which acquires bpf-spin-lock during value copying. The
> > > >>>>>>        corruption of bpf-spin-lock may result in hard lock-up.
> > > >>>>>> (2) lookup procedure may get incorrect map value if the found element is
> > > >>>>>>        freed and then reused.
> > > >>>>>>
> > > >>>>>> Because the type of htab map elements are the same, so problem #1 can be
> > > >>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
> > > >>>>>> these special fields in map element only when the map element is newly
> > > >>>>>> allocated. If it is just a reused element, there will be no
> > > >>>>>> reinitialization.
> > > >>>>>
> > > >>>>> Instead of adding the overhead of ctor callback let's just
> > > >>>>> add __GFP_ZERO to flags in __alloc().
> > > >>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
> > > >>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> > > >>>>> will behave the same way.
> > > >>>>
> > > >>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
> > > >>>> tried to address a similar issue for lru hash table.
> > > >>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
> > > >>>> hash table?
> > > >>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
> > > >>
> > > >> The following is my understanding:
> > > >> in function alloc_htab_elem() (hashtab.c), we have
> > > >>
> > > >>                  if (is_map_full(htab))
> > > >>                          if (!old_elem)
> > > >>                                  /* when map is full and update() is replacing
> > > >>                                   * old element, it's ok to allocate, since
> > > >>                                   * old element will be freed immediately.
> > > >>                                   * Otherwise return an error
> > > >>                                   */
> > > >>                                  return ERR_PTR(-E2BIG);
> > > >>                  inc_elem_count(htab);
> > > >>                  l_new = bpf_mem_cache_alloc(&htab->ma);
> > > >>                  if (!l_new) {
> > > >>                          l_new = ERR_PTR(-ENOMEM);
> > > >>                          goto dec_count;
> > > >>                  }
> > > >>                  check_and_init_map_value(&htab->map,
> > > >>                                           l_new->key + round_up(key_size, 8));
> > > >>
> > > >> In the above check_and_init_map_value() intends to do initializing
> > > >> for an element from bpf_mem_cache_alloc (could be reused from the free list).
> > > >>
> > > >> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
> > > >>
> > > >> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
> > > >> {
> > > >>          int i;
> > > >>
> > > >>          if (!foffs)
> > > >>                  return;
> > > >>          for (i = 0; i < foffs->cnt; i++)
> > > >>                  memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
> > > >> }
> > > >>
> > > >> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> > > >> {
> > > >>          bpf_obj_init(map->field_offs, dst);
> > > >> }
> > > >>
> > > >> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
> > > >> list_head, list_node, etc.
> > > >>
> > > >> This is the problem for above problem #1.
> > > >> Maybe I missed something?
> > > > Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
> > > > problem by only calling check_and_init_map_value() once for the newly-allocated
> > > > element, so if a freed element is reused, its special fields will not be zeroed
> > > > again. Is there any other cases which are not covered by the solution or any
> > > > other similar problems in hash-tab ?
> > >
> > > No, I checked all cases of check_and_init_map_value() and didn't find
> > > any other instances.
> >
> > check_and_init_map_value() is called in two other cases:
> > lookup_and_delete[_batch].
> > There the zeroing of the fields is necessary because the 'value'
> > is a temp buffer that is going to be copied to user space.
> > I think the way forward is to add GFP_ZERO to mem_alloc
> > (to make it equivalent to prealloc), remove one case
> > of check_and_init_map_value from hashmap, add short comments
> > to two other cases and add a big comment to check_and_init_map_value()
> > that should say that 'dst' must be a temp buffer and should not
> > point to memory that could be used in parallel by a bpf prog.
> > It feels like we've dealt with this issue a couple times already
> > and keep repeating this mistake, so the more comments the better.
>
> Hou, are you plannning to resubmit this change? I also hit this while testing my
> changes on bpf-next.

Are you talking about the whole patch set or just GFP_ZERO in mem_alloc?
The former will take a long time to settle.
The latter is trivial.
To unblock yourself just add GFP_ZERO in an extra patch?
