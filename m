Return-Path: <bpf+bounces-13367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBEC7D8B6F
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBF01C20ED8
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D73F4A9;
	Thu, 26 Oct 2023 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2j7S08R"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5303E48B
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 22:10:15 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D091
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:10:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so5341043a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698358212; x=1698963012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYkYcPfrdjdF13EUZZ4eE7TIV+DAr//+SL8WC077uOs=;
        b=J2j7S08RIHdtE5P9LPqWSBmyk4JHy8o0zMHOmCUxJ6ex6gtuzLsOyVnrMcjETdt2my
         aMWugK8ndDJSbiDSwZtZ3UHf6hLc21mR0kfIJuWsP843otfXTHdMtPWVB6DWEjF6jAvo
         dKb3bUr/D9d6/CjNzhGa/2kFkg3of1YD3rpsViEouTud9mlyJvZ3egsu134wJnAZppla
         PH8df/P9K4J6HSuJTPKBgIeEii29VDLq4gtZszfRO4HAaXEjs2qNvKIgcvf0et/1iWR1
         Bhdr9p+K04toNFsaZlhw0lxk8QKmA/g/C7wE5qjar9deQc6EsbiVR7ymUK4MJTqE8RUL
         A3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358212; x=1698963012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYkYcPfrdjdF13EUZZ4eE7TIV+DAr//+SL8WC077uOs=;
        b=fcFjS8fXbSmtSqu63e0w4LVVf+ptHrouhhObrwT7jZB+3Uh78SnlNhx0Jt85vtIYS4
         nIxUNASkpWZ3fEY28srDmOi9GMOaLK75Ov202eyPFgl8F+nsgtKPAVMPzuurzDckxh+z
         072ouGJVmZnVo1ut5TGXVM3mqwVZJZ3rl2u3A/kCUFx7UZFwYaKqbLXb4hglXE0j3Yis
         a8/gIF8Bx2aohHTBuyn+Ut64wYvvrtb7x3eROAOn/yCyJkFbw9shksWVuwZDvCqcGprJ
         FFKGD5ddtKDUM3Us2qLdaKgcGVoQywrqO1Q2sMpYQobmE9wxjNkYTt8WGG1f/VAdtv7s
         aLQA==
X-Gm-Message-State: AOJu0Yyg5DdEUkdLG91/FzdFQnqFAwgUmUaiH5zGpnE4VRFQEaLLsdcq
	chG9yv2cpp6AdCNH26DOoxA62wdfWrgv/W+eWTofDg==
X-Google-Smtp-Source: AGHT+IHuRGkSLp8NehiD60eytlHzZjcZDIT/jEslbKqr0KO3Wpe3LN4KZHOprmb19kQBB0q3jCL/Ej5UEDw1oqFqc4o=
X-Received: by 2002:a50:fa83:0:b0:52a:38c3:1b4b with SMTP id
 w3-20020a50fa83000000b0052a38c31b4bmr1216507edr.15.1698358211957; Thu, 26 Oct
 2023 15:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com> <20231026220248.blgf7kgt5fkkbg7f@skbuf>
In-Reply-To: <20231026220248.blgf7kgt5fkkbg7f@skbuf>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 26 Oct 2023 15:09:59 -0700
Message-ID: <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 3:02=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hi Justin,
>
> On Thu, Oct 26, 2023 at 09:56:07PM +0000, Justin Stitt wrote:
> > Use strscpy() to implement ethtool_puts().
> >
> > Functionally the same as ethtool_sprintf() when it's used with two
> > arguments or with just "%s" format specifier.
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  include/linux/ethtool.h | 34 +++++++++++++++++++++++-----------
> >  net/ethtool/ioctl.c     |  7 +++++++
> >  2 files changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index 226a36ed5aa1..7129dd2e227c 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -1053,22 +1053,34 @@ static inline int ethtool_mm_frag_size_min_to_a=
dd(u32 val_min, u32 *val_add,
> >   */
> >  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt,=
 ...);
> >
> > +/**
> > + * ethtool_puts - Write string to ethtool string data
> > + * @data: Pointer to start of string to update
> > + * @str: String to write
> > + *
> > + * Write string to data. Update data to point at start of next
> > + * string.
> > + *
> > + * Prefer this function to ethtool_sprintf() when given only
> > + * two arguments or if @fmt is just "%s".
> > + */
> > +extern void ethtool_puts(u8 **data, const char *str);
> > +
> >  /* Link mode to forced speed capabilities maps */
> >  struct ethtool_forced_speed_map {
> > -     u32             speed;
> > +     u32 speed;
> >       __ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
> >
> > -     const u32       *cap_arr;
> > -     u32             arr_size;
> > +     const u32 *cap_arr;
> > +     u32 arr_size;
> >  };
> >
> > -#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                       =
       \
> > -{                                                                    \
> > -     .speed          =3D SPEED_##value,                               =
 \
> > -     .cap_arr        =3D prefix##_##value,                            =
 \
> > -     .arr_size       =3D ARRAY_SIZE(prefix##_##value),                =
 \
> > -}
> > +#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                      \
> > +     {                                                            \
> > +             .speed =3D SPEED_##value, .cap_arr =3D prefix##_##value, =
\
> > +             .arr_size =3D ARRAY_SIZE(prefix##_##value),            \
> > +     }
> >
> > -void
> > -ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, =
u32 size);
> > +void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *m=
aps,
> > +                                 u32 size);
> >  #endif /* _LINUX_ETHTOOL_H */
>
> Maybe this is due to an incorrect rebase conflict resolution, but you
> shouldn't have touched any of the ethtool force speed maps.

Ah, I did have a conflict and resolved by simply moving the hunks
out of each other's way. Trivial resolution.

Should I undo this? I want my patch against next since it's targeting
some stuff in-flight over there. BUT, I also want ethtool_puts() to be
directly below ethtool_sprintf() in the source code. What to do?

>
> Please wait for at least 24 hours to pass before posting a new version,
> to allow for more comments to come in.

Ok :)

Thanks
Justin

