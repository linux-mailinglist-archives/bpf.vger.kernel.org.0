Return-Path: <bpf+bounces-61804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2456AECB1E
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 04:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB5C3B95D0
	for <lists+bpf@lfdr.de>; Sun, 29 Jun 2025 02:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9110513BC3F;
	Sun, 29 Jun 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifdxIhbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A52F1FE2;
	Sun, 29 Jun 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751165556; cv=none; b=olfSzwU8dEI6vKsgPZZccsFeP33KrBoD4HA2AapORf19YxK9JmrkM4VBEjGWMN8PXdNSV9eZB3Qlo3CKj63dFL9C4bAVrLmPNGFORxF3wDq9bYqwnRq9tk/nXyZFbxyqyZx9HJuFaih6MReFUznXGNylCjGGO1E5NSFAyTZ6MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751165556; c=relaxed/simple;
	bh=JUu4d6Lu/r48ANhRNx+jrIxyrNppEQqkxSGp6HYToIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGP38tsnmgvaX0O/SOjt1yDTCapNIMjHrZH+7DoF4MH7vFJfxQP6qaBby5imuLhP5s71TK21XZpBbOT9qMsZn5jj7lFksrKTR8JcbwXuATDNt4cPT8HoVZC/mD6hpjiTKGfYzDBXFqoMO4AToxT62OifPdBmutUq1rCUZrclm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifdxIhbF; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso5795595ab.2;
        Sat, 28 Jun 2025 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751165554; x=1751770354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTIn6bX/pcDrl5VzI3z6pvqx/3sHwV7Go2abDrLLtgs=;
        b=ifdxIhbF97Ghv2rg73t8CoUUR2kIZHKH1yjLtcwV/7IKiXmrR1hAnS4c/MTfl8jmum
         Nd9px+aVH8jn/u/4Uw69NrF7YzEeY9MdKokgLpSaXJS+oILgXMYixLFkGUgpudvePbm5
         xVBoeAoIXh7dU/6rDONTa6gTIcScTtfnEXaL5OVJWtsb4R9bIT30fE7t6edJ5z5okw0w
         3vyWWXiESdS+NFAjR8KQcUdCIv7uNkVxERNvvdeXFgfxfk9ihg2llJMPJA5TwTlre/fn
         FM3d+ZEufP4NhmGelWU1lf2PL2W612bLGt0M9Gkt5ZALVQE2g5PS1EOC/EVyEg6vqRes
         sHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751165554; x=1751770354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTIn6bX/pcDrl5VzI3z6pvqx/3sHwV7Go2abDrLLtgs=;
        b=vZa6Ehs6E0xXAQ2+h4aJPiMNF/Na6IEbQcM0t7u9YmlLY/RSD1zzXUz6TB7pXiddTA
         6Vu+dOPFCxJcmoZGixJkUbYFCmaCwP7o6ZLDmBQes1DotY4avlLTQyy5O60RouXg6LYG
         kZTGYyG+MgAXIHBG4LZ7+Z9BHMGt933OspqI8Z5uGgsYFQEUyP6Pwk00r+EG1SmcdJkQ
         PqZ1bUaMa8i5Fh1zHKU/Ox+OmpQ8bCIsAzB0NE3H2ZdOUY+nP8AOp3SXk3rlaOClGBoB
         NSKlgFGn6kuqUa1vzDKvbmoFzNh4XT52CL8p83WK4FDYtl9xKkFvLh+2aaKcTkAGXgXU
         EOSw==
X-Forwarded-Encrypted: i=1; AJvYcCX3g0I8vCdkg7g6v8N2/PJn1M90xqUsUtVDTen5C5xep+t3yybKEDETeEhRLUMIuKPLWd3t2dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaQ5rx62Rm7enwBZjT7PfeMJvPFvRzsqWEU3pi7JU+tUCutNB
	UOk/wrLEAtLt+7WS5kQ1xsSwAeLFPNqmrMi+0Q5ouiZWMBED1+0ZVUdfvg9XhzXHCmgtfGxNfuj
	j1si8HE23My6QGyCkPOInz96273sMGDg=
X-Gm-Gg: ASbGncuwRON0bgfI4YzeGXUUS8tPrH29Q7wcZparnUC4Vq2+jJVe5xVg0Wdi6ebhyce
	1uUMcwLznYoKHedsVblo/XgFpSQAEQJmIb150ihRBS40HHfZlo4kNIlCBEBJx+xoFtQ1Ys51S0T
	dhILgs7zCwy8lIzEMI6YxoHWc+JWN5xzLMR287OxBFtA==
X-Google-Smtp-Source: AGHT+IEDnvtHrTUWB+UWMUfEOhNVfh7lXsYxCnJn28f/nA63rMKiq21nBJTuGZstL87WpOyv9xciulcXGNXmHhJRuIE=
X-Received: by 2002:a05:6e02:1a0c:b0:3dd:b4b5:5c9f with SMTP id
 e9e14a558f8ab-3df4ace8ef5mr102247725ab.19.1751165553620; Sat, 28 Jun 2025
 19:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250627110121.73228-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 29 Jun 2025 10:51:57 +0800
X-Gm-Features: Ac12FXznGNTBxfDxAHPTXZ8dubaXwFW_NkSg8bJ_Qa2xDiQ471BbpIT3R-dIqZg
Message-ID: <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
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

More interesting numbers are arriving here as I run some benchmarks
from xdp-project/bpf-examples/AF_XDP-example/ in my VM.

Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256"

Using the default configure 32 as the max budget iteration:
 sock0@eth0:1 txonly xdp-drv
                   pps            pkts           1.01
rx                 0              0
tx                 48,574         49,152

Enlarging the value to 256:
 sock0@eth0:1 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 148,277        148,736

Enlarging the value to 512:
 sock0@eth0:1 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 226,306        227,072

The performance of pps goes up by 365% (with max budget set as 512)
which is an incredible number :)

If the next-respin is needed, I will attach those convincing numbers
in the commit message.

Thanks,
Jason

