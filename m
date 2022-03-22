Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32C4E47C8
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiCVUxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiCVUxg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 16:53:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B402DE1
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:52:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z7so21718813iom.1
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=177/hRdpdIJUv+MhzFyUWtLhDaWXi+C8lI8UOTgcidk=;
        b=Ks3PlpfzKXZmDUHBydQop174F4P28emWaszvVwwkeJ92wLph8M2EhZqxpSv39VWWYC
         kK0SW3IdY9eEJBwVaLxYByTkEt2lWHRwnZD9et3Evpp5lF3rZDhdDXNyMK8WmKyJnR9r
         RBzUnnId5wQLzKK38sMU8TPbbzz8khcVSYLuEd6BmBaBNLdqawjz4D3Ojk26LZblTLrY
         qMRLjh+FqL5m/oPPil9QS55qJepAS9q5wN2J9D1ERIGOYQdO4Y75Tqo6+Z9y9ilFwssn
         dqmm5eFM3EqbwuKZec8EM/vAsxaQV+GekxXJWypxpoTDrvZklBr6lnNV9xbrdR+8rM4y
         86wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=177/hRdpdIJUv+MhzFyUWtLhDaWXi+C8lI8UOTgcidk=;
        b=cWOvQ2WPAq7kcgtoK7eGTGa11VW6S6EI6L/Sm++yPA78yu0x7X1PGgK0fwfthM+NhZ
         dIHOxGafRC9zXTnZXQxqLwRjzoeHBeqdM3cQx6vcyohnEfjtfPMnwkblBa1PWVcAxiJH
         hoWrJ0DteoYQZDjYQCL6NjUBF/8g2rJ6agX4p6aezpihOVDyW7T5lrLeVrzJFo7dehS/
         L1M39/DfTvIY3uMgOhXnmDTRgNrJ56+VFKOpKadVqaDUwNi2yxVfbN5R8m0faE47ENkX
         DQKyMT832k/BB1obdQ52525BN1F7WfDvEO6G9lMKeoBUicf0YsbC125aIPZtWkY12Zjs
         65gw==
X-Gm-Message-State: AOAM531kxWmbp09myLF+jkD+2DprLowFkI9W5QR5itvk6VLZ2LNtRvEd
        AWAp5v/ylCstydBkb0U05WVQMui7NKFPNy0X0d8=
X-Google-Smtp-Source: ABdhPJxItBL6I5e+c8hNYaslR0cFcTKgHZ54ZJwcvw3zNYHKJIxjj3s4pfNbrFDTqUVZS/Ccps+OsOpNTMbjJgmOUTs=
X-Received: by 2002:a5d:9481:0:b0:649:db3d:5141 with SMTP id
 v1-20020a5d9481000000b00649db3d5141mr85783ioj.63.1647982327155; Tue, 22 Mar
 2022 13:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220320155510.671497-1-memxor@gmail.com> <20220320155510.671497-10-memxor@gmail.com>
In-Reply-To: <20220320155510.671497-10-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Mar 2022 13:51:56 -0700
Message-ID: <CAEf4BzaGkTBR_Fi+fmEBy8C5PbySKtHOC_pu++h2g3J1Fqcn_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Wire up freeing of referenced kptr
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> A destructor kfunc can be defined as void func(type *), where type may
> be void or any other pointer type as per convenience.
>
> In this patch, we ensure that the type is sane and capture the function
> pointer into off_desc of ptr_off_tab for the specific pointer offset,
> with the invariant that the dtor pointer is always set when 'kptr_ref'
> tag is applied to the pointer's pointee type, which is indicated by the
> flag BPF_MAP_VALUE_OFF_F_REF.
>
> Note that only BTF IDs whose destructor kfunc is registered, thus become
> the allowed BTF IDs for embedding as referenced kptr. Hence it serves
> the purpose of finding dtor kfunc BTF ID, as well acting as a check
> against the whitelist of allowed BTF IDs for this purpose.
>
> Finally, wire up the actual freeing of the referenced pointer if any at
> all available offsets, so that no references are leaked after the BPF
> map goes away and the BPF program previously moved the ownership a
> referenced pointer into it.
>
> The behavior is similar to BPF timers, where bpf_map_{update,delete}_elem
> will free any existing referenced kptr. The same case is with LRU map's
> bpf_lru_push_free/htab_lru_push_free functions, which are extended to
> reset unreferenced and free referenced kptr.
>
> Note that unlike BPF timers, kptr is not reset or freed when map uref
> drops to zero.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   |  4 ++
>  include/linux/btf.h   |  2 +
>  kernel/bpf/arraymap.c | 14 ++++++-
>  kernel/bpf/btf.c      | 86 ++++++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/hashtab.c  | 29 ++++++++++-----
>  kernel/bpf/syscall.c  | 57 +++++++++++++++++++++++++---
>  6 files changed, 173 insertions(+), 19 deletions(-)
>

[...]

> +                       /* This call also serves as a whitelist of allowed objects that
> +                        * can be used as a referenced pointer and be stored in a map at
> +                        * the same time.
> +                        */
> +                       dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
> +                       if (dtor_btf_id < 0) {
> +                               ret = dtor_btf_id;
> +                               btf_put(off_btf);

do btf_put() in end section instead of copy/pasting it in every single
branch here and below?

> +                               goto end;
> +                       }
> +
> +                       dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
> +                       if (!dtor_func || !btf_type_is_func(dtor_func)) {
> +                               ret = -EINVAL;
> +                               btf_put(off_btf);
> +                               goto end;
> +                       }
> +

[...]

> -       while (tab->nr_off--)
> +       while (tab->nr_off--) {
>                 btf_put(tab->off[tab->nr_off].btf);
> +               if (tab->off[tab->nr_off].module)
> +                       module_put(tab->off[tab->nr_off].module);
> +       }
>         kfree(tab);
>         return ERR_PTR(ret);
>  }
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 65877967f414..fa4a0a8754c5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -725,12 +725,16 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
>         return insn - insn_buf;
>  }
>
> -static void check_and_free_timer(struct bpf_htab *htab, struct htab_elem *elem)
> +static void check_and_free_timer_and_kptr(struct bpf_htab *htab,

we'll need to rename this to
check_and_free_timer_and_kptrs_and_dynptrs() pretty soon, so let's
better figure out more generic name now? :)

Don't know, something like "release_fields" or something?

> +                                         struct htab_elem *elem,
> +                                         bool free_kptr)
>  {
> +       void *map_value = elem->key + round_up(htab->map.key_size, 8);
> +
>         if (unlikely(map_value_has_timer(&htab->map)))
> -               bpf_timer_cancel_and_free(elem->key +
> -                                         round_up(htab->map.key_size, 8) +
> -                                         htab->map.timer_off);
> +               bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
> +       if (unlikely(map_value_has_kptr(&htab->map)) && free_kptr)
> +               bpf_map_free_kptr(&htab->map, map_value);

kptrs (please use plural consistently for functions that actually
handle multiple kptrs).

>  }
>
>  /* It is called from the bpf_lru_list when the LRU needs to delete

[...]

>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>  {
> -       check_and_free_timer(htab, elem);
> +       check_and_free_timer_and_kptr(htab, elem, true);
>         bpf_lru_push_free(&htab->lru, &elem->lru_node);
>  }
>
> @@ -1420,7 +1424,10 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
>                 struct htab_elem *l;
>
>                 hlist_nulls_for_each_entry(l, n, head, hash_node)
> -                       check_and_free_timer(htab, l);
> +                       /* We don't reset or free kptr on uref dropping to zero,
> +                        * hence set free_kptr to false.
> +                        */
> +                       check_and_free_timer_and_kptr(htab, l, false);

ok, now reading this, I wonder if it's better to keep timer and kptrs
clean ups separate? And then dynptrs separate still? Instead of adding
all these flags.

>                 cond_resched_rcu();
>         }
>         rcu_read_unlock();
> @@ -1430,6 +1437,7 @@ static void htab_map_free_timers(struct bpf_map *map)
>  {
>         struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>
> +       /* We don't reset or free kptr on uref dropping to zero. */
>         if (likely(!map_value_has_timer(&htab->map)))
>                 return;
>         if (!htab_is_prealloc(htab))

[...]
