Return-Path: <bpf+bounces-18627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7E81CFC4
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 23:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065961F243B6
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866C2F863;
	Fri, 22 Dec 2023 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulfp/KWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97C2F841;
	Fri, 22 Dec 2023 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33687627ad0so1874917f8f.2;
        Fri, 22 Dec 2023 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703283835; x=1703888635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2tp8ZC0eCMI9N8BD25jpBQaJ34ePmriVNS2iAQ9Mo8=;
        b=Ulfp/KWvyKevKS/w4XAsAgTE8nl/OBZr3xzRFs/+zyaK2Q2ZwcEAHRmUJaWCaMoX0d
         381SwZZL/YjNK3PyDW7HvtXmSW7m1dAl9XgvH3s/lmC3LncM7Sh3E5hB7D0U2LAuizpf
         3zkhl/ZKnvuGkIuZtXA2k/WiKb+BzaXHY3qZOMaFER1Zw8Dy+QKLfC9HAxbM9uziU3LP
         0YecXRBf+DmvVmVfNIdPi1RuJ08kpbi8ytVTOBJl2DHrXqmngsC/2XNScBL5kg+2F+A5
         6yUQuhIk9zJowcuzci2L6Rjww06coVXNtOnTtGW+HQbg9yZc+xmgtSkfjszc0lZkJQpV
         qd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283835; x=1703888635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2tp8ZC0eCMI9N8BD25jpBQaJ34ePmriVNS2iAQ9Mo8=;
        b=sFgXpIMO0mwOu+on71YDIhXKbDr5pec5wR1qvJ8LUtEq5NvpFxPj1M4BKDbf8haZTF
         LnrOVGDX8w+nzc0qBG4I56LU7YumCNsgu0B3TLSkhJN4rIJH9iYIpkijn9dSoWX+Em5G
         C7TCaiLIAc+0jPb88SPCt7xF+y506FRvuRE+DNkINS6xPRFQ4n7zDeniy8kzy5H2F+gs
         nCVgZf2HSXog2M66Dgzw0fGGEwoIz/hYFxsChNH2wG2cCp8gmmac3uxi552fUI5Bpk5r
         btHJT0utkMRdlc4ERCymKm15msny91fbwfemi/c/c34pdDCRFeaVeJfOODT8jRg3QeIC
         e3qQ==
X-Gm-Message-State: AOJu0YxpUXF6+BwOQDTuOQviZD5/kUY8H30q3R3WxK11XVCJ9Kec7qjL
	hrKPjtR5Vr8reoTfYPl+MqJFVidyoC30kx9mVo8=
X-Google-Smtp-Source: AGHT+IH6rf1CX7wOZUO7SEoZEEDKsMXA/e1ab7kZtfh8E8POCY6CxcL3woHHxqlc1Lv4fmeFjEGSER89PGWLBgR1B14=
X-Received: by 2002:adf:e851:0:b0:336:7657:98cc with SMTP id
 d17-20020adfe851000000b00336765798ccmr993015wrn.122.1703283835114; Fri, 22
 Dec 2023 14:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1703081351-85579-1-git-send-email-alibuda@linux.alibaba.com>
 <1703081351-85579-2-git-send-email-alibuda@linux.alibaba.com>
 <CAADnVQK3Wk+pKbvc5_7jgaQ=qFq3y0ozgnn+dbW56DaHL2ExWQ@mail.gmail.com> <1d3cb7fc-c1dc-a779-8952-cdbaaf696ce3@linux.alibaba.com>
In-Reply-To: <1d3cb7fc-c1dc-a779-8952-cdbaaf696ce3@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Dec 2023 14:23:43 -0800
Message-ID: <CAADnVQJEUEo3g7knXtkD0CNjazTpQKcjrAaZLJ4utk962bjmvw@mail.gmail.com>
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

On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
>
>
>
> On 12/21/23 5:11 AM, Alexei Starovoitov wrote:
> > On Wed, Dec 20, 2023 at 6:09=E2=80=AFAM D. Wythe <alibuda@linux.alibaba=
.com> wrote:
> >> From: "D. Wythe" <alibuda@linux.alibaba.com>
> >>
> >> To support the prog update, we need to ensure that the prog seen
> >> within the hook is always valid. Considering that hooks are always
> >> protected by rcu_read_lock(), which provide us the ability to
> >> access the prog under rcu.
> >>
> >> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> >> ---
> >>   net/netfilter/nf_bpf_link.c | 63 ++++++++++++++++++++++++++++++++++-=
----------
> >>   1 file changed, 48 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> >> index e502ec0..9bc91d1 100644
> >> --- a/net/netfilter/nf_bpf_link.c
> >> +++ b/net/netfilter/nf_bpf_link.c
> >> @@ -8,17 +8,8 @@
> >>   #include <net/netfilter/nf_bpf_link.h>
> >>   #include <uapi/linux/netfilter_ipv4.h>
> >>
> >> -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *s=
kb,
> >> -                                   const struct nf_hook_state *s)
> >> -{
> >> -       const struct bpf_prog *prog =3D bpf_prog;
> >> -       struct bpf_nf_ctx ctx =3D {
> >> -               .state =3D s,
> >> -               .skb =3D skb,
> >> -       };
> >> -
> >> -       return bpf_prog_run(prog, &ctx);
> >> -}
> >> +/* protect link update in parallel */
> >> +static DEFINE_MUTEX(bpf_nf_mutex);
> >>
> >>   struct bpf_nf_link {
> >>          struct bpf_link link;
> >> @@ -26,8 +17,20 @@ struct bpf_nf_link {
> >>          struct net *net;
> >>          u32 dead;
> >>          const struct nf_defrag_hook *defrag_hook;
> >> +       struct rcu_head head;
> > I have to point out the same issues as before, but
> > will ask them differently...
> >
> > Why do you think above rcu_head is necessary?
> >
> >>   };
> >>
> >> +static unsigned int nf_hook_run_bpf(void *bpf_link, struct sk_buff *s=
kb,
> >> +                                   const struct nf_hook_state *s)
> >> +{
> >> +       const struct bpf_nf_link *nf_link =3D bpf_link;
> >> +       struct bpf_nf_ctx ctx =3D {
> >> +               .state =3D s,
> >> +               .skb =3D skb,
> >> +       };
> >> +       return bpf_prog_run(rcu_dereference_raw(nf_link->link.prog), &=
ctx);
> >> +}
> >> +
> >>   #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) || IS_ENABLED(CONFIG_NF_DEFRAG=
_IPV6)
> >>   static const struct nf_defrag_hook *
> >>   get_proto_defrag_hook(struct bpf_nf_link *link,
> >> @@ -126,8 +129,7 @@ static void bpf_nf_link_release(struct bpf_link *l=
ink)
> >>   static void bpf_nf_link_dealloc(struct bpf_link *link)
> >>   {
> >>          struct bpf_nf_link *nf_link =3D container_of(link, struct bpf=
_nf_link, link);
> >> -
> >> -       kfree(nf_link);
> >> +       kfree_rcu(nf_link, head);
> > Why is this needed ?
> > Have you looked at tcx_link_lops ?
>
> Introducing rcu_head/kfree_rcu is to address the situation where the
> netfilter hooks might
> still access the link after bpf_nf_link_dealloc.

Why do you think so?

>
>                                                       nf_hook_run_bpf
>                                                       const struct
> bpf_nf_link *nf_link =3D bpf_link;
>
> bpf_nf_link_release
>      nf_unregister_net_hook(nf_link->net, &nf_link->hook_ops);
>
> bpf_nf_link_dealloc
>      free(link)
> bpf_prog_run(link->prog);
>
>
> I had checked the tcx_link_lops ,it's seems it use the synchronize_rcu()
> to solve the

Where do you see such code in tcx_link_lops ?

> same problem, which is also the way we used in the first version.
>
> https://lore.kernel.org/bpf/1702467945-38866-1-git-send-email-alibuda@lin=
ux.alibaba.com/
>
> However, we have received some opposing views, believing that this is a
> bit overkill,
> so we decided to use kfree_rcu.
>
> https://lore.kernel.org/bpf/20231213222415.GA13818@breakpoint.cc/
>
> >>   }
> >>
> >>   static int bpf_nf_link_detach(struct bpf_link *link)
> >> @@ -162,7 +164,34 @@ static int bpf_nf_link_fill_link_info(const struc=
t bpf_link *link,
> >>   static int bpf_nf_link_update(struct bpf_link *link, struct bpf_prog=
 *new_prog,
> >>                                struct bpf_prog *old_prog)
> >>   {
> >> -       return -EOPNOTSUPP;
> >> +       struct bpf_nf_link *nf_link =3D container_of(link, struct bpf_=
nf_link, link);
> >> +       int err =3D 0;
> >> +
> >> +       mutex_lock(&bpf_nf_mutex);
> > Why do you need this mutex?
> > What race does it solve?
>
> To avoid user update a link with differ prog at the same time. I noticed
> that sys_bpf()
> doesn't seem to prevent being invoked by user at the same time. Have I
> missed something?

You're correct that sys_bpf() doesn't lock anything.
But what are you serializing in this bpf_nf_link_update() ?
What will happen if multiple bpf_nf_link_update()
without mutex run on different CPUs in parallel ?

