Return-Path: <bpf+bounces-63499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3EB08113
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 01:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94654E7B78
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33032EF659;
	Wed, 16 Jul 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpJU0fbP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D51A2541;
	Wed, 16 Jul 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709101; cv=none; b=PqiDqrqehvuqlzGdoBuPppXvVVbJF2AgGrPQaqWkxWrxyqZjP2BTCqFfR34CyhOPMLcHR9y1uYvWTOBht8WfMpbdotob/7t9Cs0dmdzAdMNnO++zH+nnU0MsM+HGJRvhwVcgeX2P0F3w35RroVXB/9adiqLqQLkyCyLli560R78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709101; c=relaxed/simple;
	bh=WnBPGbZHN8MyLEwmKPdPYdFmerhUPe9ZW/F7GFMCIl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRiZYGKW7wtwE8NNEjV8Uz7Zh0eRX/r1FwuaxUUnoNec4GmnVRZhliWIubh/T2kE/zNpvWdPSuQr2ihCCHCRmyk6nUeObKNnucC9xJa0dkJQI44ZRYu4X7pDyZzEx2l9WvUSfE+P+X8O2kCjl1vrzcnQPPDZ00ZrTOcJAfrtq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpJU0fbP; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df210930f7so2073265ab.1;
        Wed, 16 Jul 2025 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752709099; x=1753313899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnBPGbZHN8MyLEwmKPdPYdFmerhUPe9ZW/F7GFMCIl0=;
        b=TpJU0fbPS99Lu/EZsZiI8AtuRmzMtkTY6p06zAG0Zq7Deg8uCCdzECwKngtiYL+n5R
         drWCqifMGTG/SzarNcfGGKjdmRO70dypXPC4cbnmQzpvt1mwaXAVXY97DMml6s6cpART
         rn8ndIcwZ/Kd6Futrrm8pm6tmk1O5/aSNyGVnEYQHnKmk1qy3w/RGHw1rAaCUEdR7P/1
         gwXqa8Zatc7Dzj2iedfqSnxXDDPlasT+gySfbfDx3QSdzcGS/0ys7Y0yk/8CRTq8m9XV
         FQuGjsW4ffx4/aG89zNKLuuswB9gR5n9B0FrO8rwqfgk+Leth+DgbwmigW7iXDL8Fcei
         IaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752709099; x=1753313899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnBPGbZHN8MyLEwmKPdPYdFmerhUPe9ZW/F7GFMCIl0=;
        b=C0qgd53f/2GnqXj+Us9Xhk/8O6IAuWEKy4LszTm0u0su9X332Od4ALQ0esZbTwmwej
         L7wUIp1PR36LpeLPRATbNAy3nNpBt1C2UoKrsQrEfZYANkexfCCeVlOZeNjXQqulnmgc
         t9LVuZI6wGnZLF9lXUH54kDd9UEDH+jniIdVVekYfc8jWI3ZknkWM+2Vr1qVEzSjZBVF
         swGzvmKWvQgFLqDU33Th1pHTXbI0o7AjktHhlvnWNIrx/BkZ27pP5kLQZkDdFVa0SQUF
         Yl0yC9HZbTB+PHYgwJ7itrlpZUFhl/e7RX1SI6b2vOgv07nQvkgxXXjJbJhEkoO9yIPP
         85JA==
X-Forwarded-Encrypted: i=1; AJvYcCWrZ2SEIylETXPZPuZtv72Rc1tg9MEPeWK/YH6RObvdxzI6jTQREHly03Am4+YP8huy9cVfxYKX@vger.kernel.org, AJvYcCX7rA0wvLbgA6m2E217s+WP8kleeI8z9nRhydMGDywYjDH58Zm2Id6oN997QG4ooRA8lvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KVrTY+5muVPZf/WjOGQqgqiIXTZWMHlWE1DfIQ3oSutjoTdz
	dRIxRBsx6NOIbyKNCNNaILX4sUZDt70+qB+Hyshk+l5eu4W6PngVjPf1Ql/vhSPqBFw1GsDAQim
	MLaQpfr4MsiE/9YLZ6OaRVjdNsLGmH3TdNMxmFmc=
X-Gm-Gg: ASbGncsst8gDLF3JKktJ+YVZX2IjyARefejrvjyMl07uM/16rXdgke7bqtElHw1zjx4
	M6H98a9DrkgAYvERewuCNv4DK4Rck7wrohh+cW0xiyi1uMjTiT5w4ND9md7sfcA0McuCd5Jdq4N
	cbqV5U1dWJTASljFfFyo60H6TcRAB5KTwcnANeckm0Q44J8/U8JLA7eYK8GVxRNpvlq6tdiN5+w
	jE1IfsC0lJ1xOCk
X-Google-Smtp-Source: AGHT+IGLU4j2Z+4A2a7IE9jIZ5JVg2lxK5ewDkcxUvkSSMVq4Oq2ZRrPD2EqjElE5AILxdDsjnoKt2YHT9/0llMU4Co=
X-Received: by 2002:a05:6e02:164d:b0:3e2:84aa:f473 with SMTP id
 e9e14a558f8ab-3e28bd601a8mr11219535ab.1.1752709098732; Wed, 16 Jul 2025
 16:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716122725.6088-1-kerneljasonxing@gmail.com> <20250716145645.194db702@kernel.org>
In-Reply-To: <20250716145645.194db702@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Jul 2025 07:37:42 +0800
X-Gm-Features: Ac12FXwBZw_J17bGtiTHFBOEddTWFxuJd9t1uFa8oFJPMvf_5_wZjr3xEsoLCMY
Message-ID: <CAL+tcoByyPQX+L3bbAg1hC4YLbnuPrLKidgqKqbyoj0Sny7mxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: skip validating skb list in xmit path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Jul 2025 20:27:25 +0800 Jason Xing wrote:
> > This patch only does one thing that removes validate_xmit_skb_list()
> > for xsk.
>
> Please no, I understand that it's fun to optimize the fallback paths
> but it increases the complexity of the stack.

Are you suggesting to remove this description? And I see you marked it
as 'rejected', so it seems that I should use the V1 patch which
doesn't increase the complexity.

https://lore.kernel.org/all/20250713025756.24601-1-kerneljasonxing@gmail.co=
m/

Thanks,
Jason

> --
> pw-bot: reject

