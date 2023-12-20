Return-Path: <bpf+bounces-18422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3181A7E2
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C1286A04
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716B48CD8;
	Wed, 20 Dec 2023 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFyhXVgn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497B48796;
	Wed, 20 Dec 2023 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33668163949so69799f8f.2;
        Wed, 20 Dec 2023 13:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703106698; x=1703711498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcmfAZtKeHQ+xz4l7OTo1rSFylynVcbq+ZS/3NlOtSo=;
        b=iFyhXVgnnS060kCc2qzkZT6ysybHruYBFnPRAG2ar7hLIqlrG8Qbzisn6tGYmfvNik
         9VBIT/xh9CflEISptX6FR2gmjfDN8KEJHLre5A4b+QnQnryEQ31R818tr80FPx3/jEhP
         NSsyCPXRyxAJ/lg/6s9GKbyryB7+0ZcAypQj/b6osY1pS/EHb4aeASOGKCslpfE5GNz7
         FBz8TPtyh+LCekCya+83RylqbyAoBQEOVQ2BV8WzyMHTtE6Fl/L8h8akII73JZZBdQ4b
         R5vrAASBeNKn0CXgp3FExlYGZo7MluqProU2YVQbGKj+yAEpsB5Q9EmLu+vIc3or4pKX
         UOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703106698; x=1703711498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcmfAZtKeHQ+xz4l7OTo1rSFylynVcbq+ZS/3NlOtSo=;
        b=sqLYCwLIVCIz/hsWFqM+bTrYOm/pY6VzcGrIVq7OF7R0PzUFanIkZYQHwbp9zM1Z26
         F9G5uNIwiSjn3u8XX3bCk8HDakp8D6hFTI53Pr/2FzY5FrB8YfcizzUaMDOP1mF6ATIj
         SA+RgBsKfJMqVX36z3mcoYC1OGTFRlGvRbdI/i9sCsg9tKScsSziFy3S548POr0Uy4su
         v4roxjBSv2NvLkruHTEB8lRswi7uhAhXUm/wQWekz1ZZm0q8SbrK9TGqDaw1GCgrHQHC
         qZ7EMIrEQvuhIXcQEciNJ0vpb8pmM61sQswV6CwDsIPfWsIiCZCmNm1Vq+KM4QcLmbEQ
         NAkw==
X-Gm-Message-State: AOJu0YwsF0nRLAdcHKdmmABCHlWyFIooGHAeDr/HxARguldlILHpixmF
	6ASVXF09jNL4/uUq9yNNBa+cqyWu1Gpq0NbPsbM=
X-Google-Smtp-Source: AGHT+IHjOkPEU1b26MfTtMIY0DN6AeEhVHPXnN8otVaKeYwi4QrGZHpE84IQwSr4f+XbFVhBiTrH6O08PNUI51gjBGI=
X-Received: by 2002:a5d:4f06:0:b0:336:6ebb:704f with SMTP id
 c6-20020a5d4f06000000b003366ebb704fmr63710wru.122.1703106697456; Wed, 20 Dec
 2023 13:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com> <1703081351-85579-2-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1703081351-85579-2-git-send-email-alibuda@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Dec 2023 13:11:26 -0800
Message-ID: <CAADnVQK3Wk+pKbvc5_7jgaQ=qFq3y0ozgnn+dbW56DaHL2ExWQ@mail.gmail.com>
Subject: Re: [RFC nf-next v3 1/2] netfilter: bpf: support prog update
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, coreteam@netfilter.org, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 6:09=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> To support the prog update, we need to ensure that the prog seen
> within the hook is always valid. Considering that hooks are always
> protected by rcu_read_lock(), which provide us the ability to
> access the prog under rcu.
>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/netfilter/nf_bpf_link.c | 63 ++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 48 insertions(+), 15 deletions(-)
>
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index e502ec0..9bc91d1 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -8,17 +8,8 @@
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <uapi/linux/netfilter_ipv4.h>
>
> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
> -                                   const struct nf_hook_state *s)
> -{
> -       const struct bpf_prog *prog =3D bpf_prog;
> -       struct bpf_nf_ctx ctx =3D {
> -               .state =3D s,
> -               .skb =3D skb,
> -       };
> -
> -       return bpf_prog_run(prog, &ctx);
> -}
> +/* protect link update in parallel */
> +static DEFINE_MUTEX(bpf_nf_mutex);
>
>  struct bpf_nf_link {
>         struct bpf_link link;
> @@ -26,8 +17,20 @@ struct bpf_nf_link {
>         struct net *net;
>         u32 dead;
>         const struct nf_defrag_hook *defrag_hook;
> +       struct rcu_head head;

I have to point out the same issues as before, but
will ask them differently...

Why do you think above rcu_head is necessary?

>  };
>
> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *skb,
> +                                   const struct nf_hook_state *s)
> +{
> +       const struct bpf_nf_link *nf_link =3D bpf_link;
> +       struct bpf_nf_ctx ctx =3D {
> +               .state =3D s,
> +               .skb =3D skb,
> +       };
> +       return bpf_prog_run(rcu_dereference_raw(nf_link->link.prog), &ctx=
);
> +}
> +
>  #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG_IPV=
6)
>  static const struct nf_defrag_hook *
>  get_proto_defrag_hook(struct bpf_nf_link *link,
> @@ -126,8 +129,7 @@ static void bpf_nf_link_release(struct bpf_link *link=
)
>  static void bpf_nf_link_dealloc(struct bpf_link *link)
>  {
>         struct bpf_nf_link *nf_link =3D container_of(link, struct bpf_nf_=
link, link);
> -
> -       kfree(nf_link);
> +       kfree_rcu(nf_link, head);

Why is this needed ?
Have you looked at tcx_link_lops ?

>  }
>
>  static int bpf_nf_link_detach(struct bpf_link *link)
> @@ -162,7 +164,34 @@ static int bpf_nf_link_fill_link_info(const struct b=
pf_link *link,
>  static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog *ne=
w_prog,
>                               struct bpf_prog *old_prog)
>  {
> -       return -EOPNOTSUPP;
> +       struct bpf_nf_link *nf_link =3D container_of(link, struct bpf_nf_=
link, link);
> +       int err =3D 0;
> +
> +       mutex_lock(&bpf_nf_mutex);

Why do you need this mutex?
What race does it solve?

> +
> +       if (nf_link->dead) {
> +               err =3D -EPERM;
> +               goto out;
> +       }
> +
> +       /* target old_prog mismatch */
> +       if (old_prog && link->prog !=3D old_prog) {
> +               err =3D -EPERM;
> +               goto out;
> +       }
> +
> +       old_prog =3D link->prog;
> +       if (old_prog =3D=3D new_prog) {
> +               /* don't need update */
> +               bpf_prog_put(new_prog);
> +               goto out;
> +       }
> +
> +       old_prog =3D xchg(&link->prog, new_prog);
> +       bpf_prog_put(old_prog);
> +out:
> +       mutex_unlock(&bpf_nf_mutex);
> +       return err;
>  }
>
>  static const struct bpf_link_ops bpf_nf_link_lops =3D {
> @@ -226,7 +255,11 @@ int bpf_nf_link_attach(const union bpf_attr *attr, s=
truct bpf_prog *prog)
>
>         link->hook_ops.hook =3D nf_hook_run_bpf;
>         link->hook_ops.hook_ops_type =3D NF_HOOK_OP_BPF;
> -       link->hook_ops.priv =3D prog;
> +
> +       /* bpf_nf_link_release & bpf_nf_link_dealloc() can ensures that l=
ink remains
> +        * valid at all times within nf_hook_run_bpf().
> +        */
> +       link->hook_ops.priv =3D link;
>
>         link->hook_ops.pf =3D attr->link_create.netfilter.pf;
>         link->hook_ops.priority =3D attr->link_create.netfilter.priority;
> --
> 1.8.3.1
>

