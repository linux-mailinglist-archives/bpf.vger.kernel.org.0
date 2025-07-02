Return-Path: <bpf+bounces-62104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03CAF13F7
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA27A4130
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E826560D;
	Wed,  2 Jul 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHAi5kVB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC423371F;
	Wed,  2 Jul 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456057; cv=none; b=HvLONWrQMdHRSLtjBP/jDQ/Bx/QKhHmN23OaGIZ2ToNFPcA5ebqeNysEUT/dRCcA0QXR9Nm93e7FAdV2ajHNAAvSoQhSWM2f6PenY3Kw4PpKRD+riYtOtzggSMQj+7pSOrcbMhGLh/aH4e7C6ClnGfHi00Fw2cBIg7glP6bxp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456057; c=relaxed/simple;
	bh=Nq3rXKAUHavmOWHdiAxOlIxS5cCFcHFUGxZmUDclhSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0A7yikLIJEWOkZL3PZsOIWArn3xk9pXYwjDHXxEmsjLzAsOfEmjAxqOf5caPDzr1jj9gzFP0NPffvEdQAMzTIebLMTEDBK0E/ZeKi8bilCkRucqb1cU+ZXj5uMew/AkqyQuHDCMZRPSFtiL0jdOfiY5RcMqrMK4uJ/rCEMoY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHAi5kVB; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8723a232750so379843439f.1;
        Wed, 02 Jul 2025 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751456054; x=1752060854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj/QHuZV4QOpSEKs+oYRbdM+glo559vKGz/A6OFJUSU=;
        b=HHAi5kVBj5UyOSN4LEfY+SGrKNk0hZ7xfVKbi6Tk0ao6rh1efO3Mmrs3UJvTNzIiio
         yhLtA3CvQA69KvIq707I2YBiLy+qXG2yYb/Lu1+hZkq2rIBepeY7pKpEwsJTore/b6Jq
         LldgcyXNfeXM5dCzUaYDeLFQxPZxGwKblmOJddiqe6vdBjEPkwA9X3LexE4fn2uZ/fcV
         ueOOnRo0y/+pLJlkExJqSeuBKWeOON85SK0UEktvF481ThF4QOY30/L2gFmUli9yZd7r
         ja7DVc8HyDtMDcFfQ/NYnGy0RSeLLxgm5FHKgUw9Si99GNahJc+5BGjlthSpPlAbh6Ib
         JdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456054; x=1752060854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj/QHuZV4QOpSEKs+oYRbdM+glo559vKGz/A6OFJUSU=;
        b=qCAs3h3vMZvJJPgHZ6laurBDaQR4LfksqNLctRmml/cjdJiyI6GI4sXTPW7XUpAbEg
         WYw/fCy83S4oh1M30A5Fm4fKeK/3XhIT0Ikail/hnTdsXaxp1Po+ASl81td4XeknHw6Z
         o/tOmhkqc18fObGU7hhhJ0ww/YAejqlkxYRJ9FcIwnpA3Rq5IM9cC27bWhzYs7ihKRwS
         QQBapc9RbDLf18K6PYhlfv5wxJXEn7oLaL0ouz1TCjPrlWH/9x1eyDIAGF04vwo5YWlc
         c0OCTBJDoocYP1McK+DTzX5arasVWGXeAYvpaky3VeOnJAj1jsYr3tCaD/9pSmZ9Ubk+
         DlJA==
X-Forwarded-Encrypted: i=1; AJvYcCULgUjbTXqnSuvvhLgOzseskKygDtycCUjkwQq9p0v+r4a5qF9/2fYFRP9cmMWF9P/DxrkGJSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzrNqfnybqPE5ZD3r78FHcYgqF+Hjeh0uUGv+ISZdPytcq3Nx
	tcQBAG2Cg2q8KWNwalzgYtiq3NJDE3aI1qe+GqyU3hEGJ7EWHJf5x3UOyZ/zniwHS/yDbhK0znD
	S54jRVI52VqzXW68q4B4EqoldeK3zVbw=
X-Gm-Gg: ASbGnctHp7bfu59MHQIiMMhbK/mV/wGcFlgWNy+1pVt4FK+rAqBiipOa7DrYfVolAtr
	Zf2bmcn445PQ0IHetUrRCY4doNsiEVUTGIb8qYCdTpTQyslPWhQ14d6NLaWNR7Y/OvPMOJn1FO1
	dtqqrPsWbWKcYgeQfGynRYE2RUWWv6l2DFRJTICJG0QA==
X-Google-Smtp-Source: AGHT+IEof+wvSreCEhz+hqGy3sJk0udMWHJqJUpmffqFzM1zUhy/ADa6+A9Lkbk5BSnxWb2BsPwcv70cf+Cx7qZyJ4I=
X-Received: by 2002:a05:6e02:1988:b0:3df:1505:1d43 with SMTP id
 e9e14a558f8ab-3e054adbb28mr23658665ab.13.1751456054544; Wed, 02 Jul 2025
 04:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250627110121.73228-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Jul 2025 19:33:36 +0800
X-Gm-Features: Ac12FXzJvIQM7r7aIFq1ouNa3mwmFUqZNAjO2JDb1aDRaAESKrZwpEGXUSS05fY
Message-ID: <CAL+tcoA=-igx3KPG4dY=9a6Ahd6kSSLsHz-AicTzShuDosa-1w@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 7:01=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This patch provides a setsockopt method to let applications leverage to
> adjust how many descs to be handled at most in one send syscall. It
> mitigates the situation where the default value (32) that is too small
> leads to higher frequency of triggering send syscall.
>
> Considering the prosperity/complexity the applications have, there is no
> absolutely ideal suggestion fitting all cases. So keep 32 as its default
> value like before.
>
> The patch does the following things:
> - Add XDP_MAX_TX_BUDGET socket option.
> - Convert TX_BATCH_SIZE to tx_budget_spent.
> - Set tx_budget_spent to 32 by default in the initialization phase as a
>   per-socket granular control. 32 is also the min value for
>   tx_budget_spent.
> - Set the range of tx_budget_spent as [32, xs->tx->nentries].
>
> The idea behind this comes out of real workloads in production. We use a
> user-level stack with xsk support to accelerate sending packets and
> minimize triggering syscalls. When the packets are aggregated, it's not
> hard to hit the upper bound (namely, 32). The moment user-space stack
> fetches the -EAGAIN error number passed from sendto(), it will loop to tr=
y
> again until all the expected descs from tx ring are sent out to the drive=
r.
> Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> sendto() and higher throughput/PPS.
>
> Here is what I did in production, along with some numbers as follows:
> For one application I saw lately, I suggested using 128 as max_tx_budget
> because I saw two limitations without changing any default configuration:
> 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> this was I counted how many descs are transmitted to the driver at one
> time of sendto() based on [1] patch and then I calculated the
> possibility of hitting the upper bound. Finally I chose 128 as a
> suitable value because 1) it covers most of the cases, 2) a higher
> number would not bring evident results. After twisting the parameters,
> a stable improvement of around 4% for both PPS and throughput and less
> resources consumption were found to be observed by strace -c -p xxx:
> 1) %time was decreased by 7.8%
> 2) error counter was decreased from 18367 to 572
>
> [1]: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@g=
mail.com/
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hi Maciej, Stan, Willem, and other maintainers,

I wonder if you have further suggestions on the current patch?

Thanks in advance!

