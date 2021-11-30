Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76735463EEF
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbhK3UAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 15:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbhK3UAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 15:00:09 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C1C061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 11:56:49 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id np3so16126440pjb.4
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NDaXpybPH95VoK3R2b2ZPGRvFFOZjhyyJv6Mwurt/X4=;
        b=VHLd665HQ9LwPea980980/Do0XT7tuzgb3C2J2fDxCFKesVnhN2eRuyKmT4KjPko8s
         nf1WJRzs7+HCngQr59UbXJ+GzC5uBq+GsJNbODXWtFHhpUEeDDVb4dPmjTjMOdTtFdLa
         X71xOyUQudZUpFPkkOFYwCx51oeX1bh59t74FLObPS9IL8IyWG2jVqCqeh++zIqVDYQo
         B77UhdLqp5ewesj52n5NLwUUW50UXC+6bWy5ds2pp1/UDx2c62+w3/t31bK4MJv06kkZ
         LsUUy0wKiJuPDvOSvJ2K4I+Lxtdo4NGYHJLwInx0zN8l6sUwhZAqR4cD79mTISRL5VJW
         dVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NDaXpybPH95VoK3R2b2ZPGRvFFOZjhyyJv6Mwurt/X4=;
        b=eSBUJTTe7sw3bMCioygj9ZP9VMVsgPB4TotyHGpWLkmQg5SIOaQGJnLGbNWDNiAgKJ
         kARHOcZgJRJQe9bjbYlxo78Dr1nmYhbKj7lKhhARgdwoKOtKcd836Cn3VwrxNNsRF4+B
         eGifPKKa8wofKBwIALXO1udDU/9ozE1Obpbq2btt8E+vmrnVctTPDtRo77poC2HgJ1bG
         jiugF7TTSrqc46IplZmd9jQRj1I2ObJV+wYGc0Wksf1pqyLr37vliOY7zoEoNz3k0YSR
         XzYc8NSOW0m1XADWvrH+aC8WbQTTDIwN2ImryMsnVB1RgYjOeMxFFrGaipZEhVc8nP/V
         Y6hA==
X-Gm-Message-State: AOAM532Nm6phMeYKpBGxPGoMcyD4AQJBExSfsoQL1SfpGhf8ArOqY1U4
        vgLc9DpevzcqK5UyYy682yzADS4TBlM=
X-Google-Smtp-Source: ABdhPJzlvQCgRh1jFflZIyqz+FS7ky5YP2xaqeLR8KXmZEOzmUXDeen2Z2I96GiqVsCQo253Jqq1Cg==
X-Received: by 2002:a17:90a:909:: with SMTP id n9mr1337956pjn.1.1638302209205;
        Tue, 30 Nov 2021 11:56:49 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id o4sm3239735pjq.23.2021.11.30.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:56:48 -0800 (PST)
Date:   Wed, 1 Dec 2021 01:26:44 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 3/3] tools/resolve_btfids: Skip unresolved symbol
 warning for empty BTF sets
Message-ID: <20211130195644.fehcdx3xo47qb5ou@apollo.legion>
References: <20211122144742.477787-1-memxor@gmail.com>
 <20211122144742.477787-4-memxor@gmail.com>
 <CAEf4BzbLGhxCAUbU-UFscuMub+kO3a=k=1fosR_Keobk=E4AQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbLGhxCAUbU-UFscuMub+kO3a=k=1fosR_Keobk=E4AQw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 30, 2021 at 05:16:46AM IST, Andrii Nakryiko wrote:
> On Mon, Nov 22, 2021 at 6:47 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > resolve_btfids prints a warning when it finds an unresolved symbol,
> > (id == 0) in id_patch. This can be the case for BTF sets that are empty
> > (due to disabled config options), hence printing warnings for certain
> > builds, most recently seen in [0].
> >
> > The reason behind this is because id->cnt aliases id->id in btf_id
>
> do we need to alias this, btw? We are trying to save 4 bytes on 800+
> struct (addr[ADDR_CNT] is big) and instead are getting more confusion
> in the code.
>

I can do that, but going to wait for Jiri's response before respinning.

> > struct, leading to empty set showing up as ID 0 when we get to id_patch,
> > which triggers the warning. Since sets are an exception here, accomodate
> > by reusing hole in btf_id for bool is_set member, setting it to true for
> > BTF set when setting id->cnt, and use that to skip extraneous warning.
> >
> >   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
> >
> > Before:
> >
> > ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> > adding symbol tcp_cubic_kfunc_ids
> > WARN: resolve_btfids: unresolved symbol tcp_cubic_kfunc_ids
> > patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> > sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> > update ok for net/ipv4/tcp_cubic.ko
> >
> > After:
> >
> > ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> > adding symbol tcp_cubic_kfunc_ids
> > patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> > sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> > update ok for net/ipv4/tcp_cubic.ko
> >
> > Cc: Jiri Olsa <jolsa@kernel.org>
>
> Jiri, can you please take a look as well?
>
> > Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> > Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/bpf/resolve_btfids/main.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index a59cb0ee609c..73409e27be01 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -83,6 +83,7 @@ struct btf_id {
> >                 int      cnt;
> >         };
> >         int              addr_cnt;
> > +       bool             is_set;
> >         Elf64_Addr       addr[ADDR_CNT];
> >  };
> >
> > @@ -451,8 +452,10 @@ static int symbols_collect(struct object *obj)
> >                          * in symbol's size, together with 'cnt' field hence
> >                          * that - 1.
> >                          */
> > -                       if (id)
> > +                       if (id) {
> >                                 id->cnt = sym.st_size / sizeof(int) - 1;
> > +                               id->is_set = true;
> > +                       }
> >                 } else {
> >                         pr_err("FAILED unsupported prefix %s\n", prefix);
> >                         return -1;
> > @@ -568,9 +571,8 @@ static int id_patch(struct object *obj, struct btf_id *id)
> >         int *ptr = data->d_buf;
> >         int i;
> >
> > -       if (!id->id) {
> > +       if (!id->id && !id->is_set)
> >                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > -       }
> >
> >         for (i = 0; i < id->addr_cnt; i++) {
> >                 unsigned long addr = id->addr[i];
> > --
> > 2.34.0
> >

--
Kartikeya
