Return-Path: <bpf+bounces-61175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF83AE1D8D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDFC161012
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634A2522A7;
	Fri, 20 Jun 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo+sU/eK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AB22A7F1;
	Fri, 20 Jun 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430261; cv=none; b=m0EhEwg75NkBn1TjFB9JDPPet3oDooewrsEKrH9vGZ4HWdCwIFw9/FjTmYP/tU66ouh+agwerwp7LRNve5rfb7ARMiQUIjYmPw1cW2/LQfrsmn7j3hxaiQM1xeV39JnpZ2QXhbh3ty09VQtOAcx8XntkCF3jmMn3PAqF7c4J6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430261; c=relaxed/simple;
	bh=3njAs+BECsX3BLkOrvTR5urBMw+IWwbwy/YIZIkrLkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9bfctQIppw8xM/G9hNEu/qgilq5of6jitF2IVdSbz0m5GweJ1lwpvpRmiJ7paAGYd+9s6WSpoIJjtMiHVUPrcNr/FEHWyXw15AssLpNrjw/kGWJFl+Uke/hr2LMhOw3JhTr59VFzLb6AhIpkEDtkixlG6m1ssDGQToXO9QM6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo+sU/eK; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso6335015ab.1;
        Fri, 20 Jun 2025 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750430259; x=1751035059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnMpwVE7C1F1wgClLwlEa3GiePGTUVMQT7i0qRnXzjQ=;
        b=Mo+sU/eKb1CZdTav9UQFjv1hM4AaMZxdRkO67uW8QkoSPaNPW4RXZsGlFASUvGUmay
         JSLsV1syOjfWPaUYkGtjE6CduEio0AaqeU0ERfolrweIcM+oFQMoPMZecYzAFPXt5iqE
         jqTUCi3GCGC9I8/YPznu7QnVtA/ce1YAecqqXZL1RQrxNeVyxkTYuIylJ+rgElW7tPTj
         U6EBcAMCEImwco7GJnK/PShKqVjTpmehH6OiKPcKFRkCp4wa5c7Hhtg+t3S3YimryxDT
         MlvCvPjhpoTZD06q1cKmedLY8aa93otf8Mw+26i6b4vcygOvkOaKPShArvmlz2gySvsk
         NNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750430259; x=1751035059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnMpwVE7C1F1wgClLwlEa3GiePGTUVMQT7i0qRnXzjQ=;
        b=RtQ8LbiNF1Yv8qBl9OEuFQAOyerZqDBqHQI4mqqqx7UGcpGWXG5D+XxCBiZOxWEjPD
         Ntbe+XYoGDOddbreLaS6iVoYxgL+ykGgHLfJEk2NGWXcU7h+HKZ3wLyfTMQnN9nKdKtF
         rHNvC9dTlGBxU1AaUE7M2Oq9Ari8/wj07wP/1J7UkVpGMaGiyGrMprUQ/1iInrGfm7C7
         MPQsBO229+s4x3SNmrJZbv5XKzujx2YyHvzHtrC/G7t6yPibc/KJ324+XVdNWYtFh0R3
         QGEV8SphJQYS26GEKORsitwZslyvnk2TBE7hXIJ6PHd+dxwkkQ+OsTpe9X1y6VxFUTWp
         6lnA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jygPRqcvupbFX/Co7h2C09stLsP80JAGMq0HkTHKBVbcxElikT8/56RkbVhtEdlXls/30AMD@vger.kernel.org, AJvYcCWWPPkpfi7OwY5Vb88/FF0P6NmkoiAH1EFoNaXk8aCPyJw2nCVIJbHaUA/jQjJGnmxgeIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv36yA8B9Lyyn2sVA/9IWEj9SpJur7a+THU96ittZsl8dU76Wh
	mOKHan5MiHzq5GnMdXPqjExkYzasE0g/R897MrmpTjLSiKLdYyppCvp4IeKlrsCXlu973PC8GYA
	/OkII0t8C9Js9OuW7L+4h9KDiYiAB3v2bsulQE4I=
X-Gm-Gg: ASbGncuVG2cF94vXPVBvQnaElb0g3O1ASF9YDzbiYlFFeQn3wXauCB5k85uZCX2R6QD
	4EWgf2oXDG3ZSTz2FiLnAgBE6e6TmkiBZ9gQ1s7UgVYy8VFmBjSmdArosS65GmoEocnuWTOLMMW
	c6iw6DWv7HVJZ7vkVVTuYTqGZpacGi9v/BuHx3oFjIVI8=
X-Google-Smtp-Source: AGHT+IGmrPjLUSzGQnn4xtInBJtscWqSK5NpL8mFCI3QIAY5aQonsWU5GEC629BaqWPAWWxE6vwwaAAAqy3podU06dI=
X-Received: by 2002:a05:6e02:2197:b0:3dc:868e:dae7 with SMTP id
 e9e14a558f8ab-3de38cba88fmr28938845ab.15.1750430258555; Fri, 20 Jun 2025
 07:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <6854165ccb312_3a357029426@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpfFPrYYfWa5P+Sr6S64_stUHiJj26QCtcx56cA5BWXg@mail.gmail.com>
 <685565722327f_3ffda42943d@willemb.c.googlers.com.notmuch> <68556906dc574_164a294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <68556906dc574_164a294f9@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 22:37:02 +0800
X-Gm-Features: AX0GCFuyOqNDcP9PxVsw9Fg6nS1Tb1nF8YNiRuTPOOkL17dacXtKXD2S5PL-oss
Message-ID: <CAL+tcoAMHPYw2bZV87epRFU4oL0=aeUPE3oM6=BUSJuOHPgo8w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 9:58=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Willem de Bruijn wrote:
> > Jason Xing wrote:
> > > On Thu, Jun 19, 2025 at 9:53=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The patch does the following things:
> > > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > > - Unify TX_BATCH_SIZE and MAX_PER_SOCKET_BUDGET into single one
> > > > >   tx_budget_spent.
> > > > > - tx_budget_spent is set to 32 by default in the initialization p=
hase.
> > > > >   It's a per-socket granular control.
> > > > >
> > > > > The idea behind this comes out of real workloads in production. W=
e use a
> > > > > user-level stack with xsk support to accelerate sending packets a=
nd
> > > > > minimize triggering syscall. When the packets are aggregated, it'=
s not
> > > > > hard to hit the upper bound (namely, 32). The moment user-space s=
tack
> > > > > fetches the -EAGAIN error number passed from sendto(), it will lo=
op to try
> > > > > again until all the expected descs from tx ring are sent out to t=
he driver.
> > > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequen=
cies of
> > > > > sendto(). Besides, applications leveraging this setsockopt can ad=
just
> > > > > its proper value in time after noticing the upper bound issue hap=
pening.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > > V3
> > > > > Link: https://lore.kernel.org/all/20250618065553.96822-1-kernelja=
sonxing@gmail.com/
> > > > > 1. use a per-socket control (suggested by Stanislav)
> > > > > 2. unify both definitions into one
> > > > > 3. support setsockopt and getsockopt
> > > > > 4. add more description in commit message
> > > >
> > > > +1 on an XSK setsockopt only
> > >
> > > May I ask why only setsockopt? In tradition, dev_tx_weight can be rea=
d
> > > and written through running sysctl. I think they are the same?
> >
> > This is not dev_tx_weight, which is per device.
> >
> > This is a per-socket choice. The reason for adding it that you gave,
> > a specific application that is known to be able to batch more than 32,
> > can tune this configurable in the application.

I was thinking a pair is needed like some existing options I'm
familiar with like TCP_RTO_MAX_MS. As I said, it's just a feeling.

Okay, I have no strong opinion on this. I will remove it then.

> >
> > I see no immediately need to set this at a per netns or global level.
> > If so, the extra cacheline space in those structs is not warranted.
> >
> > > >
> > > > >
> > > > > V2
> > > > > Link: https://lore.kernel.org/all/20250617002236.30557-1-kernelja=
sonxing@gmail.com/
> > > > > 1. use a per-netns sysctl knob
> > > > > 2. use sysctl_xsk_max_tx_budget to unify both definitions.
> > > > > ---
> > > > >  include/net/xdp_sock.h            |  3 ++-
> > > > >  include/uapi/linux/if_xdp.h       |  1 +
> > > > >  net/xdp/xsk.c                     | 36 +++++++++++++++++++++++++=
------
> > > > >  tools/include/uapi/linux/if_xdp.h |  1 +
> > > > >  4 files changed, 34 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > index e8bd6ddb7b12..8eecafad92c0 100644
> > > > > --- a/include/net/xdp_sock.h
> > > > > +++ b/include/net/xdp_sock.h
> > > > > @@ -65,11 +65,12 @@ struct xdp_sock {
> > > > >       struct xsk_queue *tx ____cacheline_aligned_in_smp;
> > > > >       struct list_head tx_list;
> > > > >       /* record the number of tx descriptors sent by this xsk and
> > > > > -      * when it exceeds MAX_PER_SOCKET_BUDGET, an opportunity ne=
eds
> > > > > +      * when it exceeds max_tx_budget, an opportunity needs
> > > > >        * to be given to other xsks for sending tx descriptors, th=
ereby
> > > > >        * preventing other XSKs from being starved.
> > > > >        */
> > > > >       u32 tx_budget_spent;
> > > > > +     u32 max_tx_budget;
> > > >
> > > > This probably does not need to be a u32?
> > >
> > > From what I've known, it's not possible to set a very large value lik=
e
> > > 1000 which probably brings side effects.
> > >
> > > But it seems we'd better not limit the use of this max_tx_budget? We
> > > don't know what the best fit for various use cases is. If the type
> > > needs to be downsized to a smaller one like u16, another related
> > > consideration is that dev_tx_weight deserves the same treatment?
> >
> > If the current constant is 32, is U16_MAX really a limiting factor.
> > See also the next point.
> >
> > > Or let me adjust to 'int' then?
> > > > > @@ -1437,6 +1436,18 @@ static int xsk_setsockopt(struct socket *s=
ock, int level, int optname,
> > > > >               mutex_unlock(&xs->mutex);
> > > > >               return err;
> > > > >       }
> > > > > +     case XDP_MAX_TX_BUDGET:
> > > > > +     {
> > > > > +             unsigned int budget;
> > > > > +
> > > > > +             if (optlen < sizeof(budget))
> > > > > +                     return -EINVAL;
> > > > > +             if (copy_from_sockptr(&budget, optval, sizeof(budge=
t)))
> > > > > +                     return -EFAULT;
> > > > > +
> > > > > +             WRITE_ONCE(xs->max_tx_budget, budget);
> > > >
> > > > Sanitize input: bounds check
> > >
> > > Thanks for catching this.
> > >
> > > I will change it like this:
> > >     WRITE_ONCE(xs->max_tx_budget, min_t(int, budget, INT_MAX));?
> >
> > INT_MAX is not a valid upper bound. The current constant is 32.
> > I would expect an upper bound to perhaps be a few orders larger.
>
> And this would need a clamp to also set a lower bound greater than 0.

Sorry, I don't fully follow here. I'm worried if I understand it in
the wrong way.

In this patch, max_tx_budget is u32. If we're doing this this:
        case XDP_MAX_TX_BUDGET:
        {
                unsigned int budget;

                if (optlen !=3D sizeof(budget))    // this line can
filter out those unmatched numbers, right?
                        return -EINVAL;
                if (copy_from_sockptr(&budget, optval,
sizeof(budget)))
                        return -EFAULT;

                WRITE_ONCE(xs->max_tx_budget, budget);

                return 0;
        }
, I'm thinking, is it sufficient because u32 makes sure of zero as its
lower bound?

Or you're suggesting like this:
        case XDP_MAX_TX_BUDGET:
        {
                unsigned int budget;

                if (optlen !=3D sizeof(budget))
                        return -EINVAL;
                if (copy_from_sockptr(&budget, optval, sizeof(budget)))
                        return -EFAULT;

                WRITE_ONCE(xs->max_tx_budget,
                           clamp_t(unsigned int, budget, 0, U16_MAX));
                return 0;
        }
?

Thanks,
Jason

