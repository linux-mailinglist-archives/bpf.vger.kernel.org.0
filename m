Return-Path: <bpf+bounces-72183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1AC08E3D
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291534E5612
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 09:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072022D73A3;
	Sat, 25 Oct 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niZfEqwR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06026E6E6
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383359; cv=none; b=J8h+hJDQ83Qa5lXDaxW08TPMa/Rki7Tt9aPJLCTAh8E49hobXYHEtMDFhOO42dHYf33dLrouo5AqEVF/2zJ+LRKkipUuvb/+CXTlwORyvmG1vG8o9ealiWHVU+FdQKJi0/97dXjuJGUT7sUkXLqxcvFMT/Hu5PTFiPcDyqOaNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383359; c=relaxed/simple;
	bh=eeUxRX6wA3kX3IpjOS3Z/Ztmdmm45ZwhQctFObU6MyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmK1XElH2ikAOGdCv3Malp6n9vxwUl2XyJ+0rRhrUQS/C83KPQQKZLneOKOrwgtfxl3yXfhp45SdiZi6Q2EfbiA4lzvIRz/W4/EIgRyMuBkeIGG/BgDWY5Oo0t3398ztxoOHUxEu/Bc2kyZEHtAODWINrYNSgX3NOAjkc2jIFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niZfEqwR; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940d9772e28so119099239f.2
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761383357; x=1761988157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bobkrvdQMDsuIJ67l+CLS/OxcB3mtpUzmxeUhoej5LU=;
        b=niZfEqwRDLhJ/fiHmEN770XxjbP4fVTCHc3t/0sudLTKQfBNSNbwqPBNg2LtgTejt4
         jfoa1FgWGnAB8Qw0x6YcW4JQGjidSh64IkJxZBqFNZqh6WsDljgkBlAOav2wbS9dmDLq
         wfVOywtNr+kK1KxC+zV8IXAc8KjPq7bYgE/vzkedqJIxHFTxHRmVUhDSrxi2bTsfE0w8
         zFc26N8X9fukdc8YHf8Oq1YX7/SYbbDEZmgi1ouNs7AJZiwTSJa/ff44KLLxUg23rWQU
         BMSGgvucdBfNu8iE/7UIzvIk0HWDM/Nj9wF+knPb6+ebZtyd7wv8K8LwH5piVc+YqEqy
         dVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383357; x=1761988157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bobkrvdQMDsuIJ67l+CLS/OxcB3mtpUzmxeUhoej5LU=;
        b=GU2CwqJxy5W/R3U7bPf9hFshUNJDB++yoAx4Wrz0XEiQQBWS03Hy6jSw+tMy8ZtnKq
         nPUpuG9aKnbc+8qNw+v5dkuVD2W2NPDYDpRcxIFTCYMJKDleSPpkAZhDC1IogajTjH2F
         E91eRI/jbMXjQu1zinNxndq+Wd9a3TubfRl4llZEN9yz4IbhRWnmHgU9V1V1Th8do8Wr
         FS5uEX9EAeDRojpXBYomeDSSCqmP8QpfOx3KPoUiOzbDxZ6do9U2CjaEycNvCaAp9hHH
         1MuGMXIgiTF0Dr80FO2FvQSW/tnxmpxTmsfXyun9ZouCZ7Q7GsCc7UPlBHj4H1nB3Kdq
         4zjA==
X-Forwarded-Encrypted: i=1; AJvYcCXNjE3ilfYSF+BHmChnnQHMbE5wjiN4W2/L8GOL5u5C62yKLX7pOazj06L9DrgXoOdS6JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3QcESCBP3fpUkE4I/VX8AkRKu5pib4/CJefDWFJ3Pu7k1h3j
	ml9zQueTccLcDF1hYMN48mYIDuGLY7TakDIWIdaALn+00ctNIJRAWrmEgUAtxCWxYEzCT6JEDJp
	7tQ9ayCu1YJ3HF7PYZWWAgPa/1kKOoT4=
X-Gm-Gg: ASbGncu1bu1We00eX+PZO0437jyrvXBSruTElhKE7x0sGjC6ZFGuYY4CEJyKVS0kLUs
	h5+fz8N2fOuRpQKY/fW3PkcNP2fJpk7EgDvh9Hxe9sq1fzr8QNXy21vYNxk/352G4qTe78VGsfO
	JqON8MWpIwrmPYQnMcOckPj+REtyVJsUi8/EwY9nIsXn38b9FGdpRNI4NK2HllJyTs5LPXvvS34
	i45S/lJR/2EpPH8ZFfCZpfQTJGPmsgjkCFQDCG1m43FvVEQwfdZbkDfv1dRLnhNCQTJeQ==
X-Google-Smtp-Source: AGHT+IGOfHt6F9tgUPi+KV/Nx0MlbfF6hSeK6AFa2ZWRRpfWu1QqMgVa1l1LDcLKouQFBwma+OClxVeyDiZZXk79BOg=
X-Received: by 2002:a05:6e02:156c:b0:430:aec5:9bd9 with SMTP id
 e9e14a558f8ab-430c5209291mr410023595ab.5.1761383356809; Sat, 25 Oct 2025
 02:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-2-kerneljasonxing@gmail.com> <aPt_WLQXPDOcmd1M@horms.kernel.org>
In-Reply-To: <aPt_WLQXPDOcmd1M@horms.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:08:39 +0800
X-Gm-Features: AWmQ_bm-1ooyQKKNpkJINvnv6rYi7UxoCUx6g8TZ3Ndg8WGj9vygX4jur5LE5GU
Message-ID: <CAL+tcoDnAv7+kG4WdAh1ELP0=bj_1og+DdD-JS4YuWzZC+9OhA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Fri, Oct 24, 2025 at 9:30=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 21, 2025 at 09:12:01PM +0800, Jason Xing wrote:
>
> ...
>
> > index 7b0c68a70888..ace91800c447 100644
>
> ...
>
> > @@ -1544,6 +1546,55 @@ static int xsk_setsockopt(struct socket *sock, i=
nt level, int optname,
> >               WRITE_ONCE(xs->max_tx_budget, budget);
> >               return 0;
> >       }
> > +     case XDP_GENERIC_XMIT_BATCH:
> > +     {
> > +             struct xsk_buff_pool *pool =3D xs->pool;
> > +             struct xsk_batch *batch =3D &xs->batch;
> > +             struct xdp_desc *descs;
> > +             struct sk_buff **skbs;
> > +             unsigned int size;
> > +             int ret =3D 0;
> > +
> > +             if (optlen !=3D sizeof(size))
> > +                     return -EINVAL;
> > +             if (copy_from_sockptr(&size, optval, sizeof(size)))
> > +                     return -EFAULT;
> > +             if (size =3D=3D batch->generic_xmit_batch)
> > +                     return 0;
> > +             if (size > xs->max_tx_budget || !pool)
> > +                     return -EACCES;
> > +
> > +             mutex_lock(&xs->mutex);
> > +             if (!size) {
> > +                     kfree(batch->skb_cache);
> > +                     kvfree(batch->desc_cache);
> > +                     batch->generic_xmit_batch =3D 0;
> > +                     goto out;
> > +             }
> > +
> > +             skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP_KER=
NEL);
> > +             if (!skbs) {
> > +                     ret =3D -ENOMEM;
> > +                     goto out;
> > +             }
> > +             descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP_KER=
NEL);
> > +             if (!descs) {
> > +                     kfree(skbs);
> > +                     ret =3D -ENOMEM;
> > +                     goto out;
> > +             }
> > +             if (batch->skb_cache)
> > +                     kfree(batch->skb_cache);
> > +             if (batch->desc_cache)
> > +                     kvfree(batch->desc_cache);
>
> Hi Jason,
>
> nit: kfree and kvfree are no-ops when passed NULL,
>      so the conditions above seem unnecessary.

Yep, but the checkpatch complains. I thought it might be good to keep
it because normally we need to check the validation of the pointer
first and then free it. WDYT?

Thanks,
Jason

