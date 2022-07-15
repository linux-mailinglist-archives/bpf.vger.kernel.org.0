Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2A3576A63
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiGOXFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGOXFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:05:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD628B497
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:05:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so11339694ejc.13
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ac/te7NgtMbM3auVz2vN6Pn6nPpWhyz/M/6RxlB7r08=;
        b=aT0JsU6ajrlNz7tAoQB+f98cQ2HwU8hc9rbpHf/FSd+hQDvGd3CnRA9koJSgcyb+2e
         8RsXZPCpd6044MxFHl6FwNLez01r8T9/YzzKtQEy3ihymUyBmV13AswItuhLR/FJkCpG
         Rsjrwy3FQPN6lQEzKuXoT2kHcYXQC6SP/8gjjFOIHQSvXHu53LJHoowAcq8PI9FfNitV
         c/QvjoEc07IhAz/+KcdXK2XQLfjuDz9/hbyKlmXpJIOus1bXjnWGWK8aWqsPtbFi6qOf
         5X+uROuIU/ge9JnP+6qj8rMo3Xt+etBdCYWZOxL358J52p5cW2PNdmqI8D+tG7MEodnn
         W9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ac/te7NgtMbM3auVz2vN6Pn6nPpWhyz/M/6RxlB7r08=;
        b=D6UN3XE4bU1CRuIePuCNNG+jAcjHiUjXbnnZ2nO4PRewVGNxvvzy0PLAju0xm7LF5E
         2cJnGeQIndCKq/oKWCJCXkqvNgwEp1JfANbHwGNTtqFAdE0c4bO7r3fThahRD/uFybZK
         HgVIxw/opIGlUI9kAR0BimIquOxKGl0B2LR6UKDaFHw12KqUH5oInGudOkwqEZivf/f/
         pEraPz7N6/wsa8Gwx3F0KKXutPBMYCobEAEAg3x43y+4teR2nN5imoIGqfgDr9aJuEk2
         YD15GpVlAJ4voc1QuB3OqoxkegPVLbA+T9e8XSxzdVQ969WUJkMSPwLF9BU4SGJfSb8z
         nYSg==
X-Gm-Message-State: AJIora8oZMY8agaPywQlMp4ICu8ALShWsI8wxVEQWWaW4MiRPDmLecCd
        sXsrGcSE96K3HHLVKIp9dsHAhNObND3g4nRIc8HK78vMv6A=
X-Google-Smtp-Source: AGRyM1uibsbrmGyMMcbqCMBjkwZ8pIO26OnGDnola2nUjpBnRFerPnwuX2N0lwIUdhQoroHigNS7WiYN2QhZvI0NyTk=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr15782585ejc.745.1657926344461; Fri, 15
 Jul 2022 16:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220715192456.1151015-1-andrii@kernel.org> <dceeb2c8-5676-34c0-4ee1-a67d9c230a8a@fb.com>
In-Reply-To: <dceeb2c8-5676-34c0-4ee1-a67d9c230a8a@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Jul 2022 16:05:32 -0700
Message-ID: <CAEf4BzaOUCE5yjkc0mCFCGqosHYgUdR_f0nRj0YbqsJREewW6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: make RINGBUF map size adjustments
 more eagerly
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Jul 15, 2022 at 3:43 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/15/22 12:24 PM, Andrii Nakryiko wrote:
> > Make libbpf adjust RINGBUF map size (rounding it up to closest power-of-2
> > of page_size) more eagerly: during open phase when initializing the map
> > and on explicit calls to bpf_map__set_max_entries().
> >
> > Such approach allows user to check actual size of BPF ringbuf even
> > before it's created in the kernel, but also it prevents various edge
> > case scenarios where BPF ringbuf size can get out of sync with what it
> > would be in kernel. One of them (reported in [0]) is during an attempt
> > to pin/reuse BPF ringbuf.
> >
> > Move adjust_ringbuf_sz() helper closer to its first actual use. The
> > implementation of the helper is unchanged.
> >
> >    [0] Closes: https://github.com/libbpf/libbpf/issue/530
>
> The link is not accessible. https://github.com/libbpf/libbpf/pull/530
> is accessible.
>

hm... strange, when I tried back then it was redirecting issue to
pull, but now it doesn't work. I'll update to use pull/530

> >
> > Fixes: 0087a681fa8c ("libbpf: Automatically fix up BPF_MAP_TYPE_RINGBUF size, if necessary")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c | 77 +++++++++++++++++++++++-------------------
> >   1 file changed, 42 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 68da1aca406c..2767d1897b4f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2320,6 +2320,37 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
> >       return 0;
> >   }
> >
> > +static size_t adjust_ringbuf_sz(size_t sz)
> > +{
> > +     __u32 page_sz = sysconf(_SC_PAGE_SIZE);
> > +     __u32 mul;
> > +
> > +     /* if user forgot to set any size, make sure they see error */
> > +     if (sz == 0)
> > +             return 0;
> > +     /* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
> > +      * a power-of-2 multiple of kernel's page size. If user diligently
> > +      * satisified these conditions, pass the size through.
> > +      */
> > +     if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
> > +             return sz;
> > +
> > +     /* Otherwise find closest (page_sz * power_of_2) product bigger than
> > +      * user-set size to satisfy both user size request and kernel
> > +      * requirements and substitute correct max_entries for map creation.
> > +      */
> > +     for (mul = 1; mul <= UINT_MAX / page_sz; mul <<= 1) {
> > +             if (mul * page_sz > sz)
> > +                     return mul * page_sz;
> > +     }
> > +
> > +     /* if it's impossible to satisfy the conditions (i.e., user size is
> > +      * very close to UINT_MAX but is not a power-of-2 multiple of
> > +      * page_size) then just return original size and let kernel reject it
> > +      */
> > +     return sz;
> > +}
> > +
> >   static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
> >   {
> >       map->def.type = def->map_type;
> > @@ -2333,6 +2364,10 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
> >       map->btf_key_type_id = def->key_type_id;
> >       map->btf_value_type_id = def->value_type_id;
> >
> > +     /* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> > +     if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> > +             map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> > +
> >       if (def->parts & MAP_DEF_MAP_TYPE)
> >               pr_debug("map '%s': found type = %u.\n", map->name, def->map_type);
> >
> > @@ -4306,9 +4341,15 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
> >
> >   int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
> >   {
> > -     if (map->fd >= 0)
> > +     if (map->obj->loaded)
> >               return libbpf_err(-EBUSY);
>
> This change is not explained in the commit message. Could you explain
> why this change? In libbpf.c, there are multiple places using map->f >=
> 0, not sure whether there are any potential issues for those cases or not.

obj->loaded is more reliable way to check that bpf_object__load()
already happened. It used to be equivalent to checking that map has FD
assigned, but with bpf_map__set_autocreate(map, false) we can now have
loaded object and no map FD. So I just made the check more reliable
while modifying this API. I don't know if it's worth adding comment
here, seems pretty self-explanatory in code, but I'll add a sentenced
about this in the commit.

>
> > +
> >       map->def.max_entries = max_entries;
> > +
> > +     /* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> > +     if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> > +             map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> > +
> >       return 0;
> >   }
> >
> [...]
