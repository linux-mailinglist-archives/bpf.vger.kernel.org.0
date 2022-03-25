Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43B4E7569
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359415AbiCYOwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355899AbiCYOwD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:52:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0A92D16
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:50:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so8532259pjp.3
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N78VsVGQB6w0ssRhHhvH8efOfyWhQh9F3APX2it7jwg=;
        b=LoiEKBVmjtYQxxIl9LY2iCbx3gYXS1lPJjMaYdGSYS0jrx0ZtuE6R9l8BNi1q5NWOn
         q+KMNxJ/afhhTSpkIxHPEF0r0bNfxsQN2KguImU4Wudb7sFuifQFiq37/1UtxOBWlGW6
         WEA7LlRA5fXTMERRGBliSxA4ILMRhzik1vDmMuSlauBZC0RVPWOq3jN2W/WDl7IdXbJL
         8M/vrfTMXfjn1DRxHue3C5NJyKwLa5R0wKgxoDJQV599WFJrwhJJE6P+Cw5PjiMJKBcV
         aiHwUZx9KHlpxaXgq0rXwcUQIzMKuFT7aMFAfWtvGciYqDbQWi2NhtUwKKQrITEJRh/P
         MBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N78VsVGQB6w0ssRhHhvH8efOfyWhQh9F3APX2it7jwg=;
        b=O//QpmAbW9JREi0XpVQGj3qQ+uqRtD6fkeFdziQOAA8a7u4KpTTdu2OPFMBmJrTXl/
         nUnp+fkQ4AELM6bOkPz9LLNrgeymg56MzxzxK6B2Zb1F3L6OwTr5MiZ1beIggNwn+uX4
         vYsUtTGtjXshWhQ03XlS6MCDNOx6hBLfZ4V5rFt+kh24f4e6Ao39JxZ4qAc8FU5Kwwjr
         ZUU98BMgq0DBS8zPCag3iNxk4h9qOJzUdqyb6XIkqyVo7es9EW3lx82G/VvBjaGeH3fe
         rWjuzmUNvNdSMBUdLwajXOG5h7E1ITxKCyeCxr86b24sPyB0RjOirz7jtnmN9LmW/K96
         9wKw==
X-Gm-Message-State: AOAM530Q9oOp7favpx8MScsdZqelatKrT8GlANMXVCWPACoVNp6P3NIP
        2gFQtQBBesN+0/xqkHc32IsB6j8TdAk=
X-Google-Smtp-Source: ABdhPJx+1S03vKL4Teqp2G55uie2HdpTtpq3ehjuRq3ZJ97Wb5O/i1NeDKVSIiC3AngXJEagJRa7OQ==
X-Received: by 2002:a17:90a:4682:b0:1bc:236:7e46 with SMTP id z2-20020a17090a468200b001bc02367e46mr12957707pjf.212.1648219828361;
        Fri, 25 Mar 2022 07:50:28 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faba984f62sm7213306pff.67.2022.03.25.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 07:50:28 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:20:25 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Wire up freeing of referenced kptr
Message-ID: <20220325145025.i7xewucgq6mibweg@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-10-memxor@gmail.com>
 <CAEf4BzaGkTBR_Fi+fmEBy8C5PbySKtHOC_pu++h2g3J1Fqcn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaGkTBR_Fi+fmEBy8C5PbySKtHOC_pu++h2g3J1Fqcn_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 02:21:56AM IST, Andrii Nakryiko wrote:
> On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > A destructor kfunc can be defined as void func(type *), where type may
> > be void or any other pointer type as per convenience.
> >
> > In this patch, we ensure that the type is sane and capture the function
> > pointer into off_desc of ptr_off_tab for the specific pointer offset,
> > with the invariant that the dtor pointer is always set when 'kptr_ref'
> > tag is applied to the pointer's pointee type, which is indicated by the
> > flag BPF_MAP_VALUE_OFF_F_REF.
> >
> > Note that only BTF IDs whose destructor kfunc is registered, thus become
> > the allowed BTF IDs for embedding as referenced kptr. Hence it serves
> > the purpose of finding dtor kfunc BTF ID, as well acting as a check
> > against the whitelist of allowed BTF IDs for this purpose.
> >
> > Finally, wire up the actual freeing of the referenced pointer if any at
> > all available offsets, so that no references are leaked after the BPF
> > map goes away and the BPF program previously moved the ownership a
> > referenced pointer into it.
> >
> > The behavior is similar to BPF timers, where bpf_map_{update,delete}_elem
> > will free any existing referenced kptr. The same case is with LRU map's
> > bpf_lru_push_free/htab_lru_push_free functions, which are extended to
> > reset unreferenced and free referenced kptr.
> >
> > Note that unlike BPF timers, kptr is not reset or freed when map uref
> > drops to zero.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   |  4 ++
> >  include/linux/btf.h   |  2 +
> >  kernel/bpf/arraymap.c | 14 ++++++-
> >  kernel/bpf/btf.c      | 86 ++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/bpf/hashtab.c  | 29 ++++++++++-----
> >  kernel/bpf/syscall.c  | 57 +++++++++++++++++++++++++---
> >  6 files changed, 173 insertions(+), 19 deletions(-)
> >
>
> [...]
>
> > +                       /* This call also serves as a whitelist of allowed objects that
> > +                        * can be used as a referenced pointer and be stored in a map at
> > +                        * the same time.
> > +                        */
> > +                       dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
> > +                       if (dtor_btf_id < 0) {
> > +                               ret = dtor_btf_id;
> > +                               btf_put(off_btf);
>
> do btf_put() in end section instead of copy/pasting it in every single
> branch here and below?
>

Ok.

> > +                               goto end;
> > +                       }
> > +
> > +                       dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
> > +                       if (!dtor_func || !btf_type_is_func(dtor_func)) {
> > +                               ret = -EINVAL;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
>
> [...]
>
> > -       while (tab->nr_off--)
> > +       while (tab->nr_off--) {
> >                 btf_put(tab->off[tab->nr_off].btf);
> > +               if (tab->off[tab->nr_off].module)
> > +                       module_put(tab->off[tab->nr_off].module);
> > +       }
> >         kfree(tab);
> >         return ERR_PTR(ret);
> >  }
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 65877967f414..fa4a0a8754c5 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -725,12 +725,16 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
> >         return insn - insn_buf;
> >  }
> >
> > -static void check_and_free_timer(struct bpf_htab *htab, struct htab_elem *elem)
> > +static void check_and_free_timer_and_kptr(struct bpf_htab *htab,
>
> we'll need to rename this to
> check_and_free_timer_and_kptrs_and_dynptrs() pretty soon, so let's
> better figure out more generic name now? :)
>
> Don't know, something like "release_fields" or something?
>

Ok, will change.

> > +                                         struct htab_elem *elem,
> > +                                         bool free_kptr)
> >  {
> > +       void *map_value = elem->key + round_up(htab->map.key_size, 8);
> > +
> >         if (unlikely(map_value_has_timer(&htab->map)))
> > -               bpf_timer_cancel_and_free(elem->key +
> > -                                         round_up(htab->map.key_size, 8) +
> > -                                         htab->map.timer_off);
> > +               bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
> > +       if (unlikely(map_value_has_kptr(&htab->map)) && free_kptr)
> > +               bpf_map_free_kptr(&htab->map, map_value);
>
> kptrs (please use plural consistently for functions that actually
> handle multiple kptrs).
>

Ok, will audit all other places as well.

> >  }
> >
> >  /* It is called from the bpf_lru_list when the LRU needs to delete
>
> [...]
>
> >  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
> >  {
> > -       check_and_free_timer(htab, elem);
> > +       check_and_free_timer_and_kptr(htab, elem, true);
> >         bpf_lru_push_free(&htab->lru, &elem->lru_node);
> >  }
> >
> > @@ -1420,7 +1424,10 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
> >                 struct htab_elem *l;
> >
> >                 hlist_nulls_for_each_entry(l, n, head, hash_node)
> > -                       check_and_free_timer(htab, l);
> > +                       /* We don't reset or free kptr on uref dropping to zero,
> > +                        * hence set free_kptr to false.
> > +                        */
> > +                       check_and_free_timer_and_kptr(htab, l, false);
>
> ok, now reading this, I wonder if it's better to keep timer and kptrs
> clean ups separate? And then dynptrs separate still? Instead of adding
> all these flags.

Right, in case of array map, we directly called bpf_timer_cancel_and_free,
instead of going through the function named like this, I guess it makes sense to
do the same for hash map, since I assume both kptrs and dynptrs wouldn't want to
be freed on map_release_uref, unlike timers.

>
> >                 cond_resched_rcu();
> >         }
> >         rcu_read_unlock();
> > @@ -1430,6 +1437,7 @@ static void htab_map_free_timers(struct bpf_map *map)
> >  {
> >         struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >
> > +       /* We don't reset or free kptr on uref dropping to zero. */
> >         if (likely(!map_value_has_timer(&htab->map)))
> >                 return;
> >         if (!htab_is_prealloc(htab))
>
> [...]

--
Kartikeya
