Return-Path: <bpf+bounces-13479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274D7DA16A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215C62825A8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F33DFFB;
	Fri, 27 Oct 2023 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKZpW2fw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D13AC22
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 19:40:55 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED701B3
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:40:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c3aec5f326so747732666b.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435651; x=1699040451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzKQXsJ9PPJ95N5huUjFyALdgbkkeZmKhRTaQ99Yt+o=;
        b=wKZpW2fww82ttWeUy1lpz4jS6QO+dMf2wi5uMBR4ioUAJkaxBwfJwDdylta/HtSNzr
         wf6eDWx+upBsAk32+pi0zevJDyYABjRG8JU1jwfr0CBpKZYT1U+d0VaM2NitjhGiUpwW
         VeBSmfIjP/dVTwSUreGHdvuIGNtp8TvrjhgbGCgeraQyTlSl3onoR1GJkyWRCD9jXxhD
         x/dVJyenJeaoAwSCEWqvB4hCxajNDdXyFyrMJxNJQ8JEqKdQxbbtt1rJfX9MKZviWayz
         z77uLsAOK4RL6x9uhNLlBG0tsHf7ypU9mY/lkL7wFBAx3Uxfz0zO3qw6ke/EJsOlxu11
         /hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435651; x=1699040451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzKQXsJ9PPJ95N5huUjFyALdgbkkeZmKhRTaQ99Yt+o=;
        b=ly9wsKqeL09hicvqnKbl9VkxJ6gFYarXAU+HTOXJoyEMkI2xb6QO8pdW49aaSGU/I1
         QboBsaDFSXiBEpQWwYFtKZ3CbLfa5RLy8jvjGUis27mQU57xLKv7IcIr+pM7AexsQd5c
         6RwaujUVJsl1fdrdnxjzNzgJJ39aQqS8wf85Xo9xvK9zHhTPxRaKtgq77zEI3HPW8Nr9
         uzU4bHOj7hx2OJskYH10je5GFUg5bv5/MKESqQT5CXJbf3p+cWgSJBHDX1Kh3i8/+9Mf
         beXSe7XkgX/6zfo68wp6kYxQjzS5Sr/DgcYZyK6GoM3tpvNt+yuQhRnol7O2h+LHqD/6
         OLjA==
X-Gm-Message-State: AOJu0YwadTbJfvidjux5UhyK1ROJsS4dw1k+Q8ScTnw0YFcyN3tTocfD
	7mwA0SDmwVTZFXB1hj754j4D6KjG5khmG/p5FcYgAQ==
X-Google-Smtp-Source: AGHT+IEPfEM/trnfZm6cOr0U7cu+iGr19zJct2V4K5qR5GqFK9SelPMa/Z/9udzIJpJO7oi3U+zFq2t/7LTPw2L/vcI=
X-Received: by 2002:a17:907:2da3:b0:9c3:97d7:2c67 with SMTP id
 gt35-20020a1709072da300b009c397d72c67mr3978966ejc.25.1698435651329; Fri, 27
 Oct 2023 12:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com> <8521c712250bcffce5c71e8d2b2574de786d4572.camel@perches.com>
In-Reply-To: <8521c712250bcffce5c71e8d2b2574de786d4572.camel@perches.com>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 27 Oct 2023 12:40:39 -0700
Message-ID: <CAFhGd8p9ytqbRuqgWmKe=zCg7Nhft0NMvbuuEyjAQHNAcBedaQ@mail.gmail.com>
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
To: Joe Perches <joe@perches.com>
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
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	=?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
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

On Thu, Oct 26, 2023 at 3:39=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2023-10-26 at 21:56 +0000, Justin Stitt wrote:
> > Add some warnings for using ethtool_sprintf() where a simple
> > ethtool_puts() would suffice.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7011,6 +7011,25 @@ sub process {
> >                            "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
> >               }
> >
> > +# ethtool_sprintf uses that should likely be ethtool_puts
> > +             if ($line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$=
FuncArg\s*\)/) {
> > +                     if(WARN("ETHTOOL_SPRINTF",
> > +                        "Prefer ethtool_puts over ethtool_sprintf with=
 only two arguments\n" . $herecurr) &&
> > +         $fix) {
> > +         $fixed[$fixlinenr] =3D~ s/ethtool_sprintf\s*\(/ethtool_puts\(=
/;
> > +       }
> > +             }
> > +
> > +             # use $rawline because $line loses %s via sanitization an=
d thus we can't match against it.
> > +             if ($rawline =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\=
s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
> > +                     if(WARN("ETHTOOL_SPRINTF",
> > +                        "Prefer ethtool_puts over ethtool_sprintf with=
 standalone \"%s\" specifier\n" . $herecurr) &&
> > +         $fix) {
> > +         $fixed[$fixlinenr] =3D~ s/ethtool_sprintf\s*\(\s*(.*?),.*?,(.=
*?)\)/ethtool_puts\($1,$2)/;
>
> Thanks, but:
>
> This fix wouldn't work if the first argument was itself a function
> with multiple arguments.
>
> And this is whitespace formatted incorrectly.
>
> It:
>
> o needs a space after if
> o needs a space after the comma in the fix
> o needs to use the appropriate amount and tabs for indentation
> o needs alignment to open parentheses
> o the backslashes are not required in the fix block
>
> Do you want me to push what I wrote in the link below?
> https://lore.kernel.org/lkml/7eec92d9e72d28e7b5202f41b02a383eb28ddd26.cam=
el@perches.com/

Ah, I didn't see you provided a diff in previous thread.

Yeah you can push it but it's not really a standalone so perhaps I'll
just steal the diff and
wrap into v3?

>
> > +       }
> > +             }
> > +
> > +
> >  # typecasts on min/max could be min_t/max_t
> >               if ($perl_version_ok &&
> >                   defined $stat &&
> >
>

Thanks
Justin

