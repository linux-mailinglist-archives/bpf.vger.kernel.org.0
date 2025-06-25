Return-Path: <bpf+bounces-61475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12ADAE73B6
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7169C3BC30A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F892B9A5;
	Wed, 25 Jun 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx366FEQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B928F58;
	Wed, 25 Jun 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810780; cv=none; b=nB30u9TPtAcqNq73FAz5OlfjInNXl3Iw3Xx+fs5oTRY8fTFJWeTYAfW4wdy3z8R7U3pIzVrMwpUPCVclfTmjMWf1CEbYfeXxbai0I1kIVtK8hcPRDQhN8ctXJb6YFRMNK3uBddb5VXaeADY3UjzaEvbAeeDevIPSx+m7MeDH9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810780; c=relaxed/simple;
	bh=a7wjzVy/r7x+Nyd08sAoM4J2gWsjuRd+V4EGUw1R6XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCOIT6ninLTaBh9Q7oLM9KWR13S0sClv//TtdLGLp6kRaaxl/UjVkaLN0/h14VPTUaf2Rn7RRIyOgQQs3HJhivM5mmuSSjNXeaDySiW04tOCBC0INsT1h2iumJt/rJd77T24gukajdPtuwui+mceYMbq85fYruV1mCmd9JJTZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx366FEQ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so7495695ab.1;
        Tue, 24 Jun 2025 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810778; x=1751415578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc+3hUor/fe4fOg/ZXIRIZ2LBDoXP14DIJKaJhU8spo=;
        b=Fx366FEQuPC8bcURb48LKZfEjzJ/sgqqUwZZbTv6QqgOyIb6xCeEzyjVmcg/GKI5za
         /fIU6rUrGaG2wrrN0DAFWEPNm1xuvoYrg4pZERh6lHuxrZfTvubszIOMj7A7gdSMLfU1
         R7xyzetyjYz4/M/0LlI29vbdw5fn5JZfg42/rlAhT6UO0OgsMSlE0MnoOcGyOK0N28ES
         rndLqnielTuqk1+vXjpMi2avYZFP3W7tneNf9HsX96+H3NK7r3EdYSyswr4tDr10/rP7
         9cu1t+B0wZosdcSwqEFKWtawH8ZCfCuGACnrCXcHjVUbinTR+WoJsdRJ+cNdEGwsI79z
         WP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810778; x=1751415578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc+3hUor/fe4fOg/ZXIRIZ2LBDoXP14DIJKaJhU8spo=;
        b=MV1Ty4P7drP/6ghD+EQAMRczcztemBPUU+tSY7JpsrzRfy6/qhDDbY60kqo35Iu0ER
         ts2R4ixrT05R5NzYM6v42pfQ9XNcCh/h+GXLLOxpcppxfmG43Z+ysmAQedhPFwmEVHHM
         HkCiUyigD7qyrvxjOKCOJCgKlwzy0FikqefK0jqdj1Ft+1VAOjJ+joISP62g+GB+eWFd
         TbUiuIgQ37VU7RJICZS+zxg8vhv36kjbHuxkMNBtNE0LnegbFUESm8+zONnSGU0RbM4z
         iXEcUTgi/KCTpM891CYL6KhiF+9+K7/fQHdjMWR1OzEvYqjYh8uQYsb8+8o9a+29O72K
         2YaA==
X-Forwarded-Encrypted: i=1; AJvYcCVolpJ1AOgQh5HatjgA30WMyRhw33fnvlOEgTL9Wxs1x21ks9lufNYQlFK/SbzTSXk+B4bDpGy3@vger.kernel.org, AJvYcCWvc7QZ9ch62Lh4/ey0I4frRl9XzYstKJcWd+k5LvSDocz285suvrqR+Eq1FySaqE9ZZ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9mFOkudM95JIgb1/LV5xs1EEx+4IQmLd+ZrxsZB4WThzYtEa
	AQpUJspB8tPdjfrYJ2yXjjhomecvKiVwuRVRQxcZLPHLIbHQS2gem/qzBDKS1bq9eurzIrNeLvI
	jOZJNR44EniOT8gNsCCi8W9dTE/8mGiE=
X-Gm-Gg: ASbGncueabusbegWAGe9tlHdLzIqcniUNyG06DDLLwtvTJ0uReO9demQWLScmfPselK
	1REGVGJisbf5hU+ZP252Y/D2P/HRmEH5QPMC86GmQ0ZzuOM8+b8W43nZL05dZEaKGOiQ2Jxdws0
	J+JtHpg9Lv1S+Ol49CbRm8FcZv/zHqpwz241uXf5ITWg==
X-Google-Smtp-Source: AGHT+IFroH5KsAzHW2FXzYXlZZ9789zcgOoJ1xpqexS+mIEjVqj00OoM0laVq3MOYQXTFzzgjRHg8aqf5DSdN2Oeqs0=
X-Received: by 2002:a05:6e02:3811:b0:3dd:b5ef:4556 with SMTP id
 e9e14a558f8ab-3df3290dd68mr16922755ab.18.1750810777698; Tue, 24 Jun 2025
 17:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623021345.69211-1-kerneljasonxing@gmail.com> <20250624163114.712a9c43@kernel.org>
In-Reply-To: <20250624163114.712a9c43@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Jun 2025 08:19:01 +0800
X-Gm-Features: Ac12FXyjJgvorLi2Ocj62AKXb1mCAGhn4uA6CwcCGwhfuZ8nxXa932I6D_EH2EI
Message-ID: <CAL+tcoBQvDJO8n7npQjzKBd6HEZ8KhE08g4hRhqokU-bpTe6tw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: xsk: introduce XDP_MAX_TX_BUDGET setsockopt
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Jun 2025 10:13:45 +0800 Jason Xing wrote:
> > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, s=
truct xdp_desc *desc)
> >       rcu_read_lock();
> >  again:
> >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > -             if (xs->tx_budget_spent >=3D MAX_PER_SOCKET_BUDGET) {
> > +             int max_budget =3D READ_ONCE(xs->max_tx_budget);
> > +
> > +             if (xs->tx_budget_spent >=3D max_budget) {
> >                       budget_exhausted =3D true;
> >                       continue;
> >               }
>
> I still think you're mixing two very different things. In the generic
> xmit path the value you're changing is a budget. But xsk_tx_peek_desc()
> *does not* exit after the "per socket budget" gets spent. The per
> socket budget only controls how many frames we pick from a single sock
> before we move to the next. But if we run out of budget on all sockets
> we give every socket a full budget again and start from the first one

Ah, my fault. Thanks for reminding me. I missed the 'refilling budget'
process...
For the record:
xsk_tx_peek_desc()
    -> xs->tx_budget_spent =3D 0;

> again.
>
> For the ZC case the true budget is set by the driver's NAPI loop.

True.

I will remove this one.

Thanks,
Jason

> --
> pw-bot: cr

