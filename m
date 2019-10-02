Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F238BC8D63
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJBPu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 11:50:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44612 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJBPu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 11:50:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so15065036otj.11
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hNL+V3s98tVzEQiFJWECAokOa0LPZtRse55Heky8biI=;
        b=XeXUtDx6KAH0gioULC7Esmo+a8lYz4MkL3zP0UO1gwh0cc2ls0XF9U53/CQqq4IteN
         U4+I1SJPO1COO80IV0qOxzVbttme2wAFX2raKev0iOSoYODwQfDN1kkYzsXpRBD50J2a
         HJBuBhzHyFjHQy8BcpY3BFVAjYUl6z/dBTpk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hNL+V3s98tVzEQiFJWECAokOa0LPZtRse55Heky8biI=;
        b=Iyiv1o9IeNB3ZRFD9m2lw0QrdnQ0iqI3KeN3XZhnlXR3YWKnruuQXJXrHiopJCuYA+
         RleEnyac2IL2gZ4/nIgv2Bl+YKO4m6Pn5DgY0cw43occHVSElXE6IMahMxY0PIppP3Uc
         OIvlQbvUAuXwBP4NVY1TTVzj8pTHsj4qskE90iJxWy9EzUNKuqUdt4I4nydAuMK4bl2F
         EtwGCrkV7PQMq0PiA6F6gRo94T0j/SWcIKqXl3PpEY2gQWznBn5DNFTr3ToH8Mjr7Sfk
         6VFAJhbNx02Cqixqr6s7eRAqjptPFRXb/KoW2RDoUJ2PMumtWlrzG6twy4TGQflFbcPF
         Gcww==
X-Gm-Message-State: APjAAAVoYhUxVC8HxCh3dEtTpjS3MeC1ric5VR03Oxc/G8n5BSQ0VQ0Z
        IivzS2DDYQB4tgjbFwK/py4SR+fwcdB5AgTHD5cN3A==
X-Google-Smtp-Source: APXvYqzL3hJbpSDPNUCu6NYYHahtsI7/DsOSPkOL4AHzx+6OuWKPeln1Eq1QSzE9bhSqFE0v+Tsgkpi1b+Tkgabi4j8=
X-Received: by 2002:a9d:7398:: with SMTP id j24mr3064257otk.289.1570031457056;
 Wed, 02 Oct 2019 08:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <157002302448.1302756.5727756706334050763.stgit@alrua-x1> <157002302672.1302756.10579143571088111093.stgit@alrua-x1>
In-Reply-To: <157002302672.1302756.10579143571088111093.stgit@alrua-x1>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 2 Oct 2019 16:50:45 +0100
Message-ID: <CACAyw9-u7oAmC1F4rW8wH2a2aoxrDHCENcM4j5WmriS7YLmevQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] xdp: Add new xdp_chain_map type for
 specifying XDP call sequences
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2 Oct 2019 at 14:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 113e1286e184..ab855095c830 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1510,3 +1510,156 @@ const struct bpf_map_ops htab_of_maps_map_ops =3D=
 {
>         .map_gen_lookup =3D htab_of_map_gen_lookup,
>         .map_check_btf =3D map_check_no_btf,
>  };
> +
> +struct xdp_chain_table {
> +       struct bpf_prog *wildcard_act;
> +       struct bpf_prog *act[XDP_ACT_MAX];
> +};
> +
> +static int xdp_chain_map_alloc_check(union bpf_attr *attr)
> +{
> +       BUILD_BUG_ON(sizeof(struct xdp_chain_table) / sizeof(void *) !=3D
> +                    sizeof(struct xdp_chain_acts) / sizeof(u32));
> +
> +       if (attr->key_size !=3D sizeof(u32) ||
> +           attr->value_size !=3D sizeof(struct xdp_chain_acts))
> +               return -EINVAL;

How are we going to extend xdp_chain_acts if a new XDP action is introduced=
?

> +
> +       attr->value_size =3D sizeof(struct xdp_chain_table);
> +       return htab_map_alloc_check(attr);
> +}
> +
> +struct bpf_prog *bpf_xdp_chain_map_get_prog(struct bpf_map *map,
> +                                           u32 prev_id,
> +                                           enum xdp_action action)
> +{
> +       struct xdp_chain_table *tab;
> +       void *ptr;
> +
> +       ptr =3D htab_map_lookup_elem(map, &prev_id);
> +
> +       if (!ptr)
> +               return NULL;
> +
> +       tab =3D READ_ONCE(ptr);
> +       return tab->act[action - 1] ?: tab->wildcard_act;
> +}
> +EXPORT_SYMBOL_GPL(bpf_xdp_chain_map_get_prog);
> +
> +/* only called from syscall */
> +int bpf_xdp_chain_map_lookup_elem(struct bpf_map *map, void *key, void *=
value)
> +{
> +       struct xdp_chain_acts *act =3D value;
> +       struct xdp_chain_table *tab;
> +       void *ptr;
> +       u32 *cur;
> +       int i;
> +
> +       ptr =3D htab_map_lookup_elem(map, key);
> +       if (!ptr)
> +               return -ENOENT;
> +
> +       tab =3D READ_ONCE(ptr);
> +
> +       if (tab->wildcard_act)
> +               act->wildcard_act =3D tab->wildcard_act->aux->id;
> +
> +       cur =3D &act->drop_act;
> +       for (i =3D 0; i < XDP_ACT_MAX; i++, cur++)
> +               if(tab->act[i])
> +                       *cur =3D tab->act[i]->aux->id;

For completeness, zero out *cur in the else case?

> +
> +       return 0;
> +}
> +
> +static void *xdp_chain_map_get_ptr(int fd)
> +{
> +       struct bpf_prog *prog =3D bpf_prog_get(fd);
> +
> +       if (IS_ERR(prog))
> +               return prog;
> +
> +       if (prog->type !=3D BPF_PROG_TYPE_XDP ||
> +           bpf_prog_is_dev_bound(prog->aux)) {
> +               bpf_prog_put(prog);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return prog;
> +}
> +
> +static void xdp_chain_map_put_ptrs(void *value)
> +{
> +       struct xdp_chain_table *tab =3D value;
> +       int i;
> +
> +       for (i =3D 0; i < XDP_ACT_MAX; i++)
> +               if (tab->act[i])
> +                       bpf_prog_put(tab->act[i]);
> +
> +       if (tab->wildcard_act)
> +               bpf_prog_put(tab->wildcard_act);
> +}
> +
> +/* only called from syscall */
> +int bpf_xdp_chain_map_update_elem(struct bpf_map *map, void *key, void *=
value,
> +                                 u64 map_flags)

Nit: check that map_flags =3D=3D 0

> +{
> +       struct xdp_chain_acts *act =3D value;
> +       struct xdp_chain_table tab =3D {};
> +       u32 lookup_key =3D *((u32*)key);
> +       u32 *cur =3D &act->drop_act;
> +       bool found_val =3D false;
> +       int ret, i;
> +       void *ptr;
> +
> +       if (!lookup_key)
> +               return -EINVAL;

Is it possible to check that this is a valid prog id / fd or whatever it is=
?

> +
> +       if (act->wildcard_act) {

If this is an fd, 0 is a valid value no?

> +               ptr =3D xdp_chain_map_get_ptr(act->wildcard_act);
> +               if (IS_ERR(ptr))
> +                       return PTR_ERR(ptr);
> +               tab.wildcard_act =3D ptr;
> +               found_val =3D true;
> +       }
> +
> +       for (i =3D 0; i < XDP_ACT_MAX; i++, cur++) {
> +               if (*cur) {
> +                       ptr =3D xdp_chain_map_get_ptr(*cur);
> +                       if (IS_ERR(ptr)) {
> +                               ret =3D PTR_ERR(ptr);
> +                               goto out_err;
> +                       }
> +                       tab.act[i] =3D ptr;
> +                       found_val =3D true;
> +               }
> +       }
> +
> +       if (!found_val) {
> +               ret =3D -EINVAL;
> +               goto out_err;
> +       }
> +
> +       ret =3D htab_map_update_elem(map, key, &tab, map_flags);
> +       if (ret)
> +               goto out_err;
> +
> +       return ret;
> +
> +out_err:
> +       xdp_chain_map_put_ptrs(&tab);
> +
> +       return ret;
> +}
> +
> +
> +const struct bpf_map_ops xdp_chain_map_ops =3D {
> +       .map_alloc_check =3D xdp_chain_map_alloc_check,
> +       .map_alloc =3D htab_map_alloc,
> +       .map_free =3D fd_htab_map_free,
> +       .map_get_next_key =3D htab_map_get_next_key,
> +       .map_delete_elem =3D htab_map_delete_elem,
> +       .map_fd_put_value =3D xdp_chain_map_put_ptrs,
> +       .map_check_btf =3D map_check_no_btf,
> +};

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
