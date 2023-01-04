Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E665DC13
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjADS0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbjADS00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 13:26:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3F2C6;
        Wed,  4 Jan 2023 10:26:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so84724136ejb.7;
        Wed, 04 Jan 2023 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itueWGntME/HJ7mxZ4jEceXi5tp6FXhPueApKpZ9kUg=;
        b=huxAJLozgoYyBdPxHez+iNgzCdUbuBFXuopahtVd3Oawsaj9btL7D21ClfP+g52eU7
         93an1oJxDmElkYCxFGozKX8cEH1hKzJ4/MvBn8sGjxmx2AcyYrZ0a4a7NkaOBlSr5btm
         GaUqcoyJ9EKjJNM1i7F72CVZNJkjlHzZgAI8nc6X4DQoYYtKTCRpx1dCoxXtFGI2+FFO
         sSFDuHEG+UViEiCEpWNkYT9L0hzfQN/8MjSxebjI5Y906qrX23Z3WIVrn7G19exqA3He
         bOLHGsieHj3JWoAnNWPqWUcneremyKiu6h/uDS6ys9HgdrV4EbMwXMJhQuE3zR7WFOPJ
         yxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itueWGntME/HJ7mxZ4jEceXi5tp6FXhPueApKpZ9kUg=;
        b=71GoTHs9fTOB2NpFCOESkYzv2t3+BZWay7myZ7bPvPZxITy7tGSbMIIyJiogzu7xQe
         Ft0+xC0mtJcuFbkhhD99PMRsiAlPzkcioJ9MIEtRhswZnuBv/ZaYXKNgBKVLrTdXylVH
         LRrHj8Jv8gtNZriUxBIdiUPY3vtGLqTcUileghR3lgQNa8BBMas/pstbDVmnvc9w6tSn
         +fIytBCig1vZMcCRy1N0Oi2AlvCCMPV9jp0hmLEZCs1oh9t+GyDFeoWk5ChBTVa4vp2k
         SrDZLfpX+BXlDvjUvXtpwK+0cb5wi9yHQ+pHweKT7nz1iNmSbhTHYPSKD7iGCX9wSPq4
         vpQA==
X-Gm-Message-State: AFqh2kq+cH/P9xRAWE2+kJGqWNy/kUoG/P2cO0GtKVoO0hnBcKTyHptP
        XPGR+nguLQE8AWo/EfnVYvm/Ns6akQyEXIhD3uM=
X-Google-Smtp-Source: AMrXdXvnMUOKpRxjUz2DoU/uauO3gbCdMCVKOfcRopDdliVKTeyPtpyF9ZTuqTgGvFDyEMJXcIo+gRs5kzkWSgoUXwU=
X-Received: by 2002:a17:906:30c9:b0:7c1:bb5:f29c with SMTP id
 b9-20020a17090630c900b007c10bb5f29cmr2853641ejb.58.1672856783768; Wed, 04 Jan
 2023 10:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com> <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com> <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
In-Reply-To: <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Jan 2023 10:26:12 -0800
Message-ID: <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Yonghong Song <yhs@meta.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
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

On Tue, Jan 3, 2023 at 11:14 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 1/3/23 10:30 PM, Hou Tao wrote:
> > Hi,
> >
> > On 1/4/2023 2:10 PM, Yonghong Song wrote:
> >>
> >>
> >> On 1/3/23 5:47 AM, Hou Tao wrote:
> >>> Hi,
> >>>
> >>> On 1/2/2023 2:48 AM, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 12/31/22 5:26 PM, Alexei Starovoitov wrote:
> >>>>> On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
> >>>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> The patchset tries to fix the problems found when checking how htab map
> >>>>>> handles element reuse in bpf memory allocator. The immediate reuse of
> >>>>>> freed elements may lead to two problems in htab map:
> >>>>>>
> >>>>>> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
> >>>>>>        htab map value and it may corrupt lookup procedure with BFP_F_LOCK
> >>>>>>        flag which acquires bpf-spin-lock during value copying. The
> >>>>>>        corruption of bpf-spin-lock may result in hard lock-up.
> >>>>>> (2) lookup procedure may get incorrect map value if the found element is
> >>>>>>        freed and then reused.
> >>>>>>
> >>>>>> Because the type of htab map elements are the same, so problem #1 can be
> >>>>>> fixed by supporting ctor in bpf memory allocator. The ctor initializes
> >>>>>> these special fields in map element only when the map element is newly
> >>>>>> allocated. If it is just a reused element, there will be no
> >>>>>> reinitialization.
> >>>>>
> >>>>> Instead of adding the overhead of ctor callback let's just
> >>>>> add __GFP_ZERO to flags in __alloc().
> >>>>> That will address the issue 1 and will make bpf_mem_alloc behave just
> >>>>> like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
> >>>>> will behave the same way.
> >>>>
> >>>> Patch https://lore.kernel.org/all/20220809213033.24147-3-memxor@gmail.com/
> >>>> tried to address a similar issue for lru hash table.
> >>>> Maybe we need to do similar things after bpf_mem_cache_alloc() for
> >>>> hash table?
> >>> IMO ctor or __GFP_ZERO will fix the issue. Did I miss something here ?
> >>
> >> The following is my understanding:
> >> in function alloc_htab_elem() (hashtab.c), we have
> >>
> >>                  if (is_map_full(htab))
> >>                          if (!old_elem)
> >>                                  /* when map is full and update() is replacing
> >>                                   * old element, it's ok to allocate, since
> >>                                   * old element will be freed immediately.
> >>                                   * Otherwise return an error
> >>                                   */
> >>                                  return ERR_PTR(-E2BIG);
> >>                  inc_elem_count(htab);
> >>                  l_new = bpf_mem_cache_alloc(&htab->ma);
> >>                  if (!l_new) {
> >>                          l_new = ERR_PTR(-ENOMEM);
> >>                          goto dec_count;
> >>                  }
> >>                  check_and_init_map_value(&htab->map,
> >>                                           l_new->key + round_up(key_size, 8));
> >>
> >> In the above check_and_init_map_value() intends to do initializing
> >> for an element from bpf_mem_cache_alloc (could be reused from the free list).
> >>
> >> The check_and_init_map_value() looks like below (in include/linux/bpf.h)
> >>
> >> static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
> >> {
> >>          int i;
> >>
> >>          if (!foffs)
> >>                  return;
> >>          for (i = 0; i < foffs->cnt; i++)
> >>                  memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
> >> }
> >>
> >> static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> >> {
> >>          bpf_obj_init(map->field_offs, dst);
> >> }
> >>
> >> IIUC, bpf_obj_init() will bzero those fields like spin_lock, timer,
> >> list_head, list_node, etc.
> >>
> >> This is the problem for above problem #1.
> >> Maybe I missed something?
> > Yes. It is the problem patch #1 tries to fix exactly. Patch #1 tries to fix the
> > problem by only calling check_and_init_map_value() once for the newly-allocated
> > element, so if a freed element is reused, its special fields will not be zeroed
> > again. Is there any other cases which are not covered by the solution or any
> > other similar problems in hash-tab ?
>
> No, I checked all cases of check_and_init_map_value() and didn't find
> any other instances.

check_and_init_map_value() is called in two other cases:
lookup_and_delete[_batch].
There the zeroing of the fields is necessary because the 'value'
is a temp buffer that is going to be copied to user space.
I think the way forward is to add GFP_ZERO to mem_alloc
(to make it equivalent to prealloc), remove one case
of check_and_init_map_value from hashmap, add short comments
to two other cases and add a big comment to check_and_init_map_value()
that should say that 'dst' must be a temp buffer and should not
point to memory that could be used in parallel by a bpf prog.
It feels like we've dealt with this issue a couple times already
and keep repeating this mistake, so the more comments the better.
