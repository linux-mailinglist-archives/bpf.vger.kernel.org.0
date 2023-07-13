Return-Path: <bpf+bounces-4891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6437515CA
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 03:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC001C210C7
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 01:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29C633;
	Thu, 13 Jul 2023 01:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2C7C;
	Thu, 13 Jul 2023 01:26:29 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF21FDE;
	Wed, 12 Jul 2023 18:26:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so1172891fa.2;
        Wed, 12 Jul 2023 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689211585; x=1691803585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxHIfdjUy2D+e36IlhY5UhNMqIoRQ40rBpziU8T3N10=;
        b=psdAc+8FN7dzzOo3MgPLwTCd3NAklAdi3rikz2jT3jc/p3me/4+OxL5Ksyd2+SZ2Qr
         Tr+5Vrz4vW28HUgdOo2frgGI2Aer7ABUIIt3AudPpk3UsWCye0gduL23mBOxZS65FWA+
         Js1aJQ/f89qX0rez6vlbHtfnCs3BbV32GOP6hIenAoD04wzSDA91sQ6RImD+N8iMF4iQ
         U0rYSIHOU5KZGIV883j1CWFWWS4t4Cf/feC8X+OFtCNSdQ4l+JCYw2EbfkhLMgwyoMQP
         WIs3Z08NzjmchL12enT1YArAE5Q1MD7zXq70V+HFpFERxtk+Rl8uKsyVIcYSe3I1bhAQ
         vBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689211585; x=1691803585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxHIfdjUy2D+e36IlhY5UhNMqIoRQ40rBpziU8T3N10=;
        b=c6Z+Xx+9mhQT+yYL+jCciN4JUB0V0BKb9+5cMiYII9XPDf8x0fprkZcjYVtn6GENpk
         fSlOJmaooX10jutonsN8Nj7L0bxR3ctNa5pm1K25xOXwKn6z80eAcBqs83JcPhdd5F/G
         LPZyRjOUJI2CBEMb54Ae75WR+YWFjF4CX0dBkSSb3Lh/QUqHbVSbZ57I1XwFfx+sjllk
         7H60pB20P9HNkFxRceqgs6ffY1QbCO2K1Zy2PO32jefquUVw2dxY7RLCLAPXGw24CoXV
         JjoHWPeaBL6q5PnaBMpdI3r0r7CdVHBuUtTV6hQIi9Km2y/M95+Mo1YJPpIXuemTiw8D
         PR0A==
X-Gm-Message-State: ABy/qLZN9zBWQLi1gRi5Lg/2emXHZ+DBBIBE9oEYFElCx6n3ToD+XCqM
	99fFEY/jom/cJzWtgSQIHf3gUflMbv4KC+9Q3eg=
X-Google-Smtp-Source: APBJJlGU3RbBtxCeeWcNJGLwmlEdH+7Gh2A5sIWRxtOds9k0BSq4bD0+y32Y6Uyma9QlqL2quVt71b5uT1Qyn5KXkko=
X-Received: by 2002:a2e:8456:0:b0:2b6:df00:b371 with SMTP id
 u22-20020a2e8456000000b002b6df00b371mr43638ljh.6.1689211584879; Wed, 12 Jul
 2023 18:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689203090.git.dxu@dxuuu.xyz> <d3b0ff95c58356192ea3b50824f8cdbf02c354e3.1689203090.git.dxu@dxuuu.xyz>
 <CAADnVQKKfEtZYZxihxvG3aQ34E1m95qTZ=jTD7yd0qvOASpAjQ@mail.gmail.com> <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
In-Reply-To: <kwiwaeaijj6sxwz5fhtxyoquhz2kpujbsbeajysufgmdjgyx5c@f6lqrd23xr5f>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jul 2023 18:26:13 -0700
Message-ID: <CAADnVQLcAoN5z+HD_44UKgJJc6t5TPW8+Ai9We0qJpau4NtEzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Florian Westphal <fw@strlen.de>, 
	"David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org, 
	Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 6:22=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Alexei,
>
> On Wed, Jul 12, 2023 at 05:43:49PM -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 12, 2023 at 4:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > > +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
> > > +       case NFPROTO_IPV6:
> > > +               rcu_read_lock();
> > > +               v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> > > +               if (!v6_hook) {
> > > +                       rcu_read_unlock();
> > > +                       err =3D request_module("nf_defrag_ipv6");
> > > +                       if (err)
> > > +                               return err < 0 ? err : -EINVAL;
> > > +
> > > +                       rcu_read_lock();
> > > +                       v6_hook =3D rcu_dereference(nf_defrag_v6_hook=
);
> > > +                       if (!v6_hook) {
> > > +                               WARN_ONCE(1, "nf_defrag_ipv6_hooks ba=
d registration");
> > > +                               err =3D -ENOENT;
> > > +                               goto out_v6;
> > > +                       }
> > > +               }
> > > +
> > > +               err =3D v6_hook->enable(link->net);
> >
> > I was about to apply, but luckily caught this issue in my local test:
> >
> > [   18.462448] BUG: sleeping function called from invalid context at
> > kernel/locking/mutex.c:283
> > [   18.463238] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> > 2042, name: test_progs
> > [   18.463927] preempt_count: 0, expected: 0
> > [   18.464249] RCU nest depth: 1, expected: 0
> > [   18.464631] CPU: 15 PID: 2042 Comm: test_progs Tainted: G
> > O       6.4.0-04319-g6f6ec4fa00dc #4896
> > [   18.465480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > [   18.466531] Call Trace:
> > [   18.466767]  <TASK>
> > [   18.466975]  dump_stack_lvl+0x32/0x40
> > [   18.467325]  __might_resched+0x129/0x180
> > [   18.467691]  mutex_lock+0x1a/0x40
> > [   18.468057]  nf_defrag_ipv4_enable+0x16/0x70
> > [   18.468467]  bpf_nf_link_attach+0x141/0x300
> > [   18.468856]  __sys_bpf+0x133e/0x26d0
> >
> > You cannot call mutex under rcu_read_lock.
>
> Whoops, my bad. I think this patch should fix it:
>
> ```
> From 7e8927c44452db07ddd7cf0e30bb49215fc044ed Mon Sep 17 00:00:00 2001
> Message-ID: <7e8927c44452db07ddd7cf0e30bb49215fc044ed.1689211250.git.dxu@=
dxuuu.xyz>
> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Wed, 12 Jul 2023 19:17:35 -0600
> Subject: [PATCH] netfilter: bpf: Don't hold rcu_read_lock during
>  enable/disable
>
> ->enable()/->disable() takes a mutex which can sleep. You can't sleep
> during RCU read side critical section.
>
> Our refcnt on the module will protect us from ->enable()/->disable()
> from going away while we call it.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  net/netfilter/nf_bpf_link.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> index 77ffbf26ba3d..79704cc596aa 100644
> --- a/net/netfilter/nf_bpf_link.c
> +++ b/net/netfilter/nf_bpf_link.c
> @@ -60,9 +60,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *li=
nk)
>                         goto out_v4;
>                 }
>
> +               rcu_read_unlock();
>                 err =3D v4_hook->enable(link->net);
>                 if (err)
>                         module_put(v4_hook->owner);
> +
> +               return err;
>  out_v4:
>                 rcu_read_unlock();
>                 return err;
> @@ -92,9 +95,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *li=
nk)
>                         goto out_v6;
>                 }
>
> +               rcu_read_unlock();
>                 err =3D v6_hook->enable(link->net);
>                 if (err)
>                         module_put(v6_hook->owner);
> +
> +               return err;
>  out_v6:
>                 rcu_read_unlock();
>                 return err;
> @@ -114,11 +120,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_lin=
k *link)
>         case NFPROTO_IPV4:
>                 rcu_read_lock();
>                 v4_hook =3D rcu_dereference(nf_defrag_v4_hook);
> +               rcu_read_unlock();
>                 if (v4_hook) {
>                         v4_hook->disable(link->net);
>                         module_put(v4_hook->owner);
>                 }
> -               rcu_read_unlock();
>
>                 break;
>  #endif
> @@ -126,11 +132,11 @@ static void bpf_nf_disable_defrag(struct bpf_nf_lin=
k *link)
>         case NFPROTO_IPV6:
>                 rcu_read_lock();
>                 v6_hook =3D rcu_dereference(nf_defrag_v6_hook);
> +               rcu_read_unlock();

No. v6_hook is gone as soon as you unlock it.

