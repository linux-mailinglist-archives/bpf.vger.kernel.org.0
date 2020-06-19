Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF51FFF25
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFSAHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 20:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgFSAHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 20:07:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936EC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 17:07:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w1so7424073qkw.5
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUcsCSdLKJLWuZ9L8PBinhK7LKVJ8dZ0jXpZRZMo4eY=;
        b=h7G7mkp7ZH7p4g1Kh0otltYq9whOZ+IZFFQ5lhOMfeBZrCkD/smF8TL9Ps6gonKQZJ
         bdJJuTuHUbKDhftBrq5Xn+fcxoHdC7dISKgbMUF3ykgC4n0QvBMia03WMKpc+z8ZsE30
         xNrxAepnt9J7eIDuneZ9ZAapo9aGe8dZG+HeWXFLpibjHRprlDZIB7dIalZLtp3BTNw5
         lRRmEwDOnqRhx7m1AoMyjmN+9lBbJG/M53UxxjLes+5Xe2FWKyUIqAAYIUlvo7jELBBD
         LJUmkpDOVe1/Ln3NtkfPl6c210dUjSkr2g2w97cUVOU9KC7JdhgPOlTETGnST/xWCUWt
         eYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUcsCSdLKJLWuZ9L8PBinhK7LKVJ8dZ0jXpZRZMo4eY=;
        b=VCtiai5Atv5WnTM9Kcs3B1N0Jkv6Y+DfRzw2fM84V/pd9O3xv9rGtfQGGt4+V1z1CI
         Cg5/JUmI9Yq0cuwjaEG6NGS0cJs+UbUqXjRKCdsVdvUQMNzBT9Uw93GDDDmXWqlcUAEa
         +T9oJVQqKQlhQyHP2rygTJUPhpR1SqYu74kkSUsXOj0scqBO1jCXVz/TQe7d5doxQVJN
         HPxIvdltJp2WyHaYlVmSjzCFSglGk5aifiTkeLw0QQ6MZnUaB/xC8YqPG8SNIPl46tNa
         vwtn3wjCDt3WOK3kM9UysMmLXiIpbKVIW888rtJztbydLRmSZ/TToiGLOqQVuHpKGGra
         MaGQ==
X-Gm-Message-State: AOAM531B6fRRm2xeGJyMvZg26q5hSwhk3warOtvNULg2QQHhZXh78VkN
        Pb6/tsQCnBLQ1COLtKLRsElxv3wbyfuyQ3POgmw=
X-Google-Smtp-Source: ABdhPJyea+7NNFClNfNpLAOrOYR/JSOMLq6R8+4NudwhiT4XP+VpJPVWjHi8wnOWRnfcaohBJjMSyUbjANZs6AqOn9Q=
X-Received: by 2002:a37:6712:: with SMTP id b18mr1102043qkc.36.1592525265055;
 Thu, 18 Jun 2020 17:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592426215.git.rdna@fb.com> <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
 <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
 <20200618194236.GA47103@rdna-mbp.dhcp.thefacebook.com> <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200618235122.GB47103@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Jun 2020 17:07:34 -0700
Message-ID: <CAEf4BzbHqzyurRnFSiKpR4Tb0v-QG36hmcwYrJUFzNu4nY3VDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Support access to bpf map fields
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 18, 2020 at 4:52 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrey Ignatov <rdna@fb.com> [Thu, 2020-06-18 12:42 -0700]:
> > Martin KaFai Lau <kafai@fb.com> [Wed, 2020-06-17 23:18 -0700]:
> > > On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
> > > [ ... ]
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index e5c5305e859c..fa21b1e766ae 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
> > > >   return ctx_type;
> > > >  }
> > > >
> > > > +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> > > > +#define BPF_LINK_TYPE(_id, _name)
> > > > +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > + [_id] = &_ops,
> > > > +#include <linux/bpf_types.h>
> > > > +#undef BPF_MAP_TYPE
> > > > +};
> > > > +static u32 btf_vmlinux_map_ids[] = {
> > > > +#define BPF_MAP_TYPE(_id, _ops) \
> > > > + [_id] = (u32)-1,
> > > > +#include <linux/bpf_types.h>
> > > > +#undef BPF_MAP_TYPE
> > > > +};
> > > > +#undef BPF_PROG_TYPE
> > > > +#undef BPF_LINK_TYPE
> > > > +
> > > > +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> > > > +                             struct bpf_verifier_log *log)
> > > > +{
> > > > + int base_btf_id, btf_id, i;
> > > > + const char *btf_name;
> > > > +
> > > > + base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> > > > + if (base_btf_id < 0)
> > > > +         return base_btf_id;
> > > > +
> > > > + BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> > > > +              ARRAY_SIZE(btf_vmlinux_map_ids));
> > > > +
> > > > + for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> > > > +         if (!btf_vmlinux_map_ops[i])
> > > > +                 continue;
> > > > +         btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> > > > +         if (!btf_name) {
> > > > +                 btf_vmlinux_map_ids[i] = base_btf_id;
> > > > +                 continue;
> > > > +         }
> > > > +         btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> > > > +         if (btf_id < 0)
> > > > +                 return btf_id;
> > > > +         btf_vmlinux_map_ids[i] = btf_id;
> > > Since map_btf_name is already in map_ops, how about storing map_btf_id in
> > > map_ops also?
> > > btf_id 0 is "void" which is as good as -1, so there is no need
> > > to modify all map_ops to init map_btf_id to -1.
> >
> > Yeah, btf_id == 0 being a valid id was the reason I used -1.
> >
> > I realized that having a map type specific struct with btf_id == 0
> > should be practically impossible, but is it guaranteed to always be
> > "void" or it just happened so and can change in the future?
> >
> > If both this and having one more field in bpf_map_ops is not a problem,
> > I'll move it to bpf_map_ops.
>
> Nope, I can't do it. All `struct bpf_map_ops` are global `const`, i.e.
> rodata and a try cast `const` away and change them causes a panic.
>
> Simple user space repro:
>
>         % cat 1.c
>         #include <stdio.h>
>
>         struct map_ops {
>                 int a;
>         };
>
>         const struct map_ops ops = {
>                 .a = 1,
>         };
>
>         int main(void)
>         {
>                 struct map_ops *ops_rw = (struct map_ops *)&ops;
>
>                 printf("before a=%d\n", ops_rw->a);
>                 ops_rw->a = 3;
>                 printf(" afrer a=%d\n", ops_rw->a);
>         }
>         % clang -O2 -Wall -Wextra -pedantic -pedantic-errors -g 1.c && ./a.out
>         before a=1
>         Segmentation fault (core dumped)
>         % objdump -t a.out  | grep -w ops
>         0000000000400600 g     O .rodata        0000000000000004              ops
>
> --
> Andrey Ignatov

See the trick that helper prototypes do for BTF ids. Fictional example:

static int hash_map_btf_id;

const struct bpf_map_ops hash_map_opss = {
 ...
 .btf_id = &hash_map_btf_id,
};


then *hash_map_ops.btf_id = <final_btf_id>;
