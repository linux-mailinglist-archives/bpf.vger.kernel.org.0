Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C6179855
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDSsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:48:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36774 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 13:48:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so2187818qto.3;
        Wed, 04 Mar 2020 10:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=15In9YVKQ2pHnhm9j0jbBoey+4goOkNMMZ6tPTLuAzo=;
        b=eymAGfuNnH6CVQK5GO4lho+oipqQOkC49ZIvGmk3/QF3p82lWtXEvjm30QoxSaDYr4
         +obg4AE9PJxqJI3IIPeHWCRNe6HlUVoyMNOuIBvBCEc8n/SbLsqOJKC3LghYmogzBfVb
         xGNZ9T2loSur3Lc5NOAHWrsTGffxowBGp91ZfKefUYkgSKAjzfF9yzC357RNJ4ogQh8B
         GzuLLUM+aqfq/yeTGspD09AUE4Sf+PX8idMhG6eZcrdzoiF47eUzZ0h5RkqyOprx8VQi
         aqOR+rhIMgIS1Qg+9SzbIcDC3F7L27Y8B52KKenaKRxHi4Yh/Rr6thLTCzJ6RUlQS1Kr
         35Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=15In9YVKQ2pHnhm9j0jbBoey+4goOkNMMZ6tPTLuAzo=;
        b=CV0YnRkE13OGmxGDqhxzu5g2HGSbJzZtoRk30r2ZtZKK6K/ldnil75G0KaAC5XYWoE
         ETu3Kut4R97+mLygMqSO7fv6jskj4LYkehumxY+14ATmIOGDuC24FbnnJ0N7QXwSbEJq
         /dOfF53ldZbN0VcCUElWYVqBdWm12KinpEdqwhv6QnRhn+lWQA31Auyv/5qAMt0wlke+
         zjP5VbUCHHJE7GjyDnARqOuSgnwSG9aPZeHNfVapW6KfWjXw0eAuK9RP9lZsUHTVg4to
         +VI2SK4w8OZ+7GOAF1o2oqpC1DVF9LXvQBN8TLQa9gZX2TBdJXX5+yZ5OeAIrChw88N1
         AJMA==
X-Gm-Message-State: ANhLgQ1KaSftX80TZaKSQY5xtEmIw2oZPZ+UKv2DcPXIdUThutHEm0MY
        CnNsR0nkuHJKmzKA84/9JqeGcV7SATYC5BnYp0I=
X-Google-Smtp-Source: ADFU+vvzvuM/4z5OiYfYDR7O85wCTvENuORqBUvdXXXn8wovxobhaxU6YvN1G/m+LtaL09Da1fAc5wmYho8NHovfGl8=
X-Received: by 2002:ac8:4d4b:: with SMTP id x11mr3650581qtv.171.1583347681515;
 Wed, 04 Mar 2020 10:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20200304154747.23506-1-kpsingh@chromium.org> <20200304154747.23506-2-kpsingh@chromium.org>
 <cb54c137-6d8e-b4e5-bd17-e0a05368c3eb@iogearbox.net> <20200304184441.GA25392@chromium.org>
In-Reply-To: <20200304184441.GA25392@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Mar 2020 10:47:50 -0800
Message-ID: <CAEf4Bza4y_H+Avry=OdQ=j6Ey-niTYLafKUwicVeutmQ3X5g=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Refactor trampoline update code
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 4, 2020 at 10:44 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 04-M=C3=A4r 19:37, Daniel Borkmann wrote:
> > On 3/4/20 4:47 PM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > As we need to introduce a third type of attachment for trampolines, t=
he
> > > flattened signature of arch_prepare_bpf_trampoline gets even more
> > > complicated.
> > >
> > > Refactor the prog and count argument to arch_prepare_bpf_trampoline t=
o
> > > use bpf_tramp_progs to simplify the addition and accounting for new
> > > attachment types.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> >
> > [...]
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index c498f0fffb40..9f7e0328a644 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> > >     struct bpf_struct_ops_value *uvalue, *kvalue;
> > >     const struct btf_member *member;
> > >     const struct btf_type *t =3D st_ops->type;
> > > +   struct bpf_tramp_progs *tprogs =3D NULL;
> > >     void *udata, *kdata;
> > >     int prog_fd, err =3D 0;
> > >     void *image;
> > > @@ -425,10 +426,18 @@ static int bpf_struct_ops_map_update_elem(struc=
t bpf_map *map, void *key,
> > >                     goto reset_unlock;
> > >             }
> > > +           tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KE=
RNEL);
> > > +           if (!tprogs) {
> > > +                   err =3D -ENOMEM;
> > > +                   goto reset_unlock;
> > > +           }
> > > +
> >
> > Looking over the code again, I'm quite certain that here's a memleak
> > since the kcalloc() is done in the for_each_member() loop in the ops
> > update but then going out of scope and in the exit path we only kfree
> > the last tprogs.
>
> You're right, nice catch. Fixing it.

There is probably no need to do many allocations as well, just one
outside of the loop and reuse?

>
> - KP
>
> >
> > > +           tprogs[BPF_TRAMP_FENTRY].progs[0] =3D prog;
> > > +           tprogs[BPF_TRAMP_FENTRY].nr_progs =3D 1;
> > >             err =3D arch_prepare_bpf_trampoline(image,
> > >                                               st_map->image + PAGE_SI=
ZE,
> > >                                               &st_ops->func_models[i]=
, 0,
> > > -                                             &prog, 1, NULL, 0, NULL=
);
> > > +                                             tprogs, NULL);
> > >             if (err < 0)
> > >                     goto reset_unlock;
> > > @@ -469,6 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> > >     memset(uvalue, 0, map->value_size);
> > >     memset(kvalue, 0, map->value_size);
> > >   unlock:
> > > +   kfree(tprogs);
> > >     mutex_unlock(&st_map->lock);
> > >     return err;
> > >   }
