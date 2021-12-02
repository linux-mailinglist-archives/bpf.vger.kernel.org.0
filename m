Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390FA466D14
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 23:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbhLBWmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 17:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbhLBWms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 17:42:48 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A1C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 14:39:25 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f186so3826041ybg.2
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIeAZA+UAxvi05PTyOIEsop78IzbY53pjM88qfCQVOg=;
        b=LuLjHZ2txwdiilqODIUY6D1lMBF9/qFWQg4CUpwCm2BnzrtML8PhleiMNdqX8bTO46
         8UKNMCCRLzeQXHKWzzZGZ+H79GmPmxBLmTniw+00EQL4FzknWiGffFxd7wL2S16voDGR
         Dls0vjmQFoBPmfB/Z07ZPUAoX2KNu4YNzI/ge4yMNHyuG23kKT5KcZF12oVh9Us3bdO4
         k4mqmwAkychRyrSEmmJzOrHkzlUnlmtyzXNWWbQQRjqNIC8sjKjH/UVkWhZ3C/RUT85g
         HtGrszEO9uhoOu3kJYzEHwEc8fcYy00d7kWwcY3iv2N9kmMkZUtzQVPzNd+/0JijZTdK
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIeAZA+UAxvi05PTyOIEsop78IzbY53pjM88qfCQVOg=;
        b=iptiUB5ATBhaVlbBCN8KfJ0CrVvOVwC7IVHTgqFg1ZZSF/vJkW41LUs1PlJwYgGtF5
         GaWolSQhrau/q2BMjVlT+MiodI0lDoNHLlHUdRuAk6oRG7k1NLIf/Vw92B5dnhtoKj1Z
         MpzSNz7WUfWepTdMnLOPfQLNYwk9HS4x01Pnf4miAwep8clXL3hqsRnBWtcXhAx87lGY
         5XBgdG5FOjaz4y55tDYdcB++vfYVVBis9wpQ6Je/ZWc8n7PaOkEGqnA1uOa6hPzl0SRQ
         gP7SFlHabQJdN4Rb7JpEKb7frob88JjfA/wAti+dcrWexHfRbypYM0MBko0na0RSZ3x2
         QqnQ==
X-Gm-Message-State: AOAM533hs95wBP+WZh7bh5e8O3Ci4qRka6LQ25mOj83fGZRtbX0ji1kL
        hdvkfKOxPWeFnYhRAT3HHrBqiZYusiP8/C5vdMIyMYYeRCs=
X-Google-Smtp-Source: ABdhPJxeCPO/phLLf1oWI5SKGkTTHlwTf+YKtbT3BUhGpVoKbo+QNM07Treg7Y594+qroBJmHc5Tn9gO9AXRE0CVqxY=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr20180487ybt.252.1638484764694;
 Thu, 02 Dec 2021 14:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20211122144742.477787-1-memxor@gmail.com> <20211122144742.477787-4-memxor@gmail.com>
 <CAEf4BzbLGhxCAUbU-UFscuMub+kO3a=k=1fosR_Keobk=E4AQw@mail.gmail.com> <20211130195644.fehcdx3xo47qb5ou@apollo.legion>
In-Reply-To: <20211130195644.fehcdx3xo47qb5ou@apollo.legion>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 14:39:13 -0800
Message-ID: <CAEf4BzaokaKA6bGq9+Xc+Ed+ShR=701DJ3=djUmuqyGMdbViOw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/3] tools/resolve_btfids: Skip unresolved symbol
 warning for empty BTF sets
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 30, 2021 at 11:56 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Nov 30, 2021 at 05:16:46AM IST, Andrii Nakryiko wrote:
> > On Mon, Nov 22, 2021 at 6:47 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > resolve_btfids prints a warning when it finds an unresolved symbol,
> > > (id == 0) in id_patch. This can be the case for BTF sets that are empty
> > > (due to disabled config options), hence printing warnings for certain
> > > builds, most recently seen in [0].
> > >
> > > The reason behind this is because id->cnt aliases id->id in btf_id
> >
> > do we need to alias this, btw? We are trying to save 4 bytes on 800+
> > struct (addr[ADDR_CNT] is big) and instead are getting more confusion
> > in the code.
> >
>
> I can do that, but going to wait for Jiri's response before respinning.
>

Alright, I've applied the patch set to bpf tree. Please follow up with
the discussed improvements separately. Thanks.

> > > struct, leading to empty set showing up as ID 0 when we get to id_patch,
> > > which triggers the warning. Since sets are an exception here, accomodate
> > > by reusing hole in btf_id for bool is_set member, setting it to true for
> > > BTF set when setting id->cnt, and use that to skip extraneous warning.
> > >
> > >   [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com
> > >
> > > Before:
> > >
> > > ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> > > adding symbol tcp_cubic_kfunc_ids
> > > WARN: resolve_btfids: unresolved symbol tcp_cubic_kfunc_ids
> > > patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> > > sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> > > update ok for net/ipv4/tcp_cubic.ko
> > >
> > > After:
> > >
> > > ; ./tools/bpf/resolve_btfids/resolve_btfids -v -b vmlinux net/ipv4/tcp_cubic.ko
> > > adding symbol tcp_cubic_kfunc_ids
> > > patching addr     0: ID       0 [tcp_cubic_kfunc_ids]
> > > sorting  addr     4: cnt      0 [tcp_cubic_kfunc_ids]
> > > update ok for net/ipv4/tcp_cubic.ko
> > >
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> >
> > Jiri, can you please take a look as well?
> >
> > > Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
> > > Reported-by: Pavel Skripkin <paskripkin@gmail.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  tools/bpf/resolve_btfids/main.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > > index a59cb0ee609c..73409e27be01 100644
> > > --- a/tools/bpf/resolve_btfids/main.c
> > > +++ b/tools/bpf/resolve_btfids/main.c
> > > @@ -83,6 +83,7 @@ struct btf_id {
> > >                 int      cnt;
> > >         };
> > >         int              addr_cnt;
> > > +       bool             is_set;
> > >         Elf64_Addr       addr[ADDR_CNT];
> > >  };
> > >
> > > @@ -451,8 +452,10 @@ static int symbols_collect(struct object *obj)
> > >                          * in symbol's size, together with 'cnt' field hence
> > >                          * that - 1.
> > >                          */
> > > -                       if (id)
> > > +                       if (id) {
> > >                                 id->cnt = sym.st_size / sizeof(int) - 1;
> > > +                               id->is_set = true;
> > > +                       }
> > >                 } else {
> > >                         pr_err("FAILED unsupported prefix %s\n", prefix);
> > >                         return -1;
> > > @@ -568,9 +571,8 @@ static int id_patch(struct object *obj, struct btf_id *id)
> > >         int *ptr = data->d_buf;
> > >         int i;
> > >
> > > -       if (!id->id) {
> > > +       if (!id->id && !id->is_set)
> > >                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
> > > -       }
> > >
> > >         for (i = 0; i < id->addr_cnt; i++) {
> > >                 unsigned long addr = id->addr[i];
> > > --
> > > 2.34.0
> > >
>
> --
> Kartikeya
