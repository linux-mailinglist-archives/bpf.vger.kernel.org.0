Return-Path: <bpf+bounces-9773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C275B79D735
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D961C20EB0
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC035666;
	Tue, 12 Sep 2023 17:07:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9B1C05;
	Tue, 12 Sep 2023 17:07:48 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A72D1710;
	Tue, 12 Sep 2023 10:07:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502934c88b7so9483310e87.2;
        Tue, 12 Sep 2023 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538466; x=1695143266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL7MyqLp5Ltk2dlKSxArA64ehXB/n2DZ7FckeLMxSeU=;
        b=Cahj0BLBNXk2POxVzaS2r7Hz3bTvEbEr8O0/eMIM7JdUuaeBTyvfjMgRhkoZJxnzxE
         MfxdLsXnVUvN6YyfWkRAj6BBbzXO58fcDtaJeX47IWtfor5xeVOL1ixbCs/BgFEqAg00
         zDw5bGctJh2cDJFXWCJAGPMVgh9IuYKzQguGsCQ5dVTHmPMwPz69NH2ZXbnm2vm/NkZL
         KU+ued56aQJcaHZRmgfChmjB0hQPR2mKRQqGNlnJhFYbBBwQcu7wO3haGT0U4yQk+tqM
         MVh0FCuAMKz1UmCHZgeDMVwqOeCh71tQ+A8g0BKC1WfQafh9tAdn1UcTmjcTUESnso6z
         YMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538466; x=1695143266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL7MyqLp5Ltk2dlKSxArA64ehXB/n2DZ7FckeLMxSeU=;
        b=IFmz6eTudzLIuiLCJSlziKL3uxLpC0v3hxhr9k67t5tvHaQRncIw9iYLTiJLpdMBL/
         iolV6rmwHEhCyQz+/CYABfV54lLo3VK2z+mxbXjoshdxnIWRA8IggJIq75w2hsTUJgba
         F+k0vn5zLuG8QxQXZRV7YOs+CEYTy4z627za2EcHObvjrejhPg8svV6D2AWS6a0iyM2W
         yG1kvRnCG/xT/4aesYELMFhbxfxRNE8ZiR7EyZiObTwIpSsaI9LyHE3NFGwzVC5ejt9Z
         LcH8BnnuVs+wEzMg04ZHMd11uG3wJCAkSfVqn26HvfR9GJrWUEIylUl734i6MRKh91Xc
         2Vhg==
X-Gm-Message-State: AOJu0YxsLixCPPrTzcryjzXDbkAPpBWkw90DxavrrdMBdWMxT1ZcLvzp
	BF3BtN9jtchRDXa0iM+pkY6cp82rE0FbQlDCpKQ=
X-Google-Smtp-Source: AGHT+IHqIVPppW66u0UK7ipERkpm3zGAIUc4T/5xRvEo1k9V9BXZ+5tMa6CrWbpOFNqLtgZ4SXIBTkNpyAojGAP5Hyc=
X-Received: by 2002:ac2:58c8:0:b0:4fe:3724:fdae with SMTP id
 u8-20020ac258c8000000b004fe3724fdaemr82576lfo.66.1694538466120; Tue, 12 Sep
 2023 10:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com> <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
In-Reply-To: <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 10:07:35 -0700
Message-ID: <CAADnVQLk4JRKXoNA6h=hd25bmCuVP=DM0yRswM0a=wgKuYbdhA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 10:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > > > It's rather a gigantic list of heards that is very hard to follow=
.
> > > > > Sorting helps to see what's already included and what's not.
> > > > > It improves a maintainability in a long term.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >
> > > > Hi Andy,
> > > >
> > > > At the risk of bike shedding, the sort function of Vim, when operat=
ing
> > > > with the C locale, gives a slightly different order, as experssed b=
y
> > > > this incremental diff.
> > > >
> > > > I have no objections to your oder, but I'm slightly curious as
> > > > to how it came about.
> > >
> > > !sort which is external command.
> > >
> > > $ locale -k LC_COLLATE
> > > collate-nrules=3D4
> > > collate-rulesets=3D""
> > > collate-symb-hash-sizemb=3D1303
> > > collate-codeset=3D"UTF-8"
> >
> > I'm unsure this change is worthy. It will make any later fix touching
> > the header list more difficult to backport, and I don't see a great
> > direct advantage.
>
> As Rasmus put it here
> https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusv=
illemoes.dk/
> In short term you can argue that it's not beneficial, but in long term it=
's given
> less conflicts.

I agree with Paolo.

This is just code churn.
The includes will become unsorted eventually.
Headers might get renamed, split, etc.
Keeping things sorted is a headache.

