Return-Path: <bpf+bounces-64452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DBB12C1F
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 21:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 001887B1BE6
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6C213E7B;
	Sat, 26 Jul 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTbjJ3Dg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA721401B;
	Sat, 26 Jul 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753559822; cv=none; b=LPBlknboFCUlgbPcAS0RMVBtQd7pLRsk9xozqE4SSKu7ZSfnkaXzAFoeIpgI3X6wdI9myr6/lfE+GCmf5ywf+Zr1uaLfzVTAglX1OmSJEy9u/Gu9d9ThZpgm25k2Jzsz+4V5Wcs/eVPpmynsNwZqkpWIeiB0wY5z7RSwE9NW1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753559822; c=relaxed/simple;
	bh=ZZJS8vmyBJ54WEVUEJMgCAOohs70QF5H7BRFzIbEGP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMig3kiEJKHEIMO17XSOUWl4PhHt4dQk+g8KN2EoKMN5zOesuq5OGOGfdj9dKAAYpz3RjQf322e3z2BNCDKpzXMu5L0kOQoED6UOhbIiC3Y/+MZWLZHGw3whk/hC/An7cX0LwI4DBD9z0+MmP++qm3/prW+eCXHJIVXJjSML9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTbjJ3Dg; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-884f22d91f9so41886241.1;
        Sat, 26 Jul 2025 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753559820; x=1754164620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjzLMbzT1iVYkNvHW3G4OLXlODM2cB+ZOhaGwXMVBN4=;
        b=RTbjJ3DgTBqabNaJiaycGvxMKeJg6yOJbPnAflUhUDm7fpQdJDW/3dBqoPesksNHxR
         LqwDK8Ag9aSW4QyPH8LlaoHP71qxfv8KNcxE8MwRMLsMVPEhfR1jAFEW4s6YN2cLQuEu
         oMw+M+zJ40Y16HTWSL+e1/TlSqTcWj9OW3onKAalA2iVbYT22fxlcw0dwa7EJjb9FZwo
         35vK6UtYMwp4a67J6Tg8/lL6NWr+Q3pHdCfxGLCuDo2ifL8g+Aywb8EQ/XMPJNWEUUYD
         +y/ql0YIO6WP78fwHD3/xoqRIu8okuEQFJS0qROTY902cdXZfl4J6FVU5DZ62BWdutDx
         ADIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753559820; x=1754164620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjzLMbzT1iVYkNvHW3G4OLXlODM2cB+ZOhaGwXMVBN4=;
        b=uDZ6hY4esFU7QrWWGC7u+73Einvy1qdJ2jW7OEkoingNyBOxPyaAh6hUJaTBjnVore
         BI8mjfGEm95suTlez7Bsf30WMSZ0Yilrird98a9I/UJ2Ft/LUDsYLvRdN1tcAForBVy4
         iPn44gnQPulYfxQL3odMUdw1Tz0Pwg5FFD3WzFVoaKnAr189B+1xudbOOwbN3l2fUjGR
         BW65owXXLwvicFwYxSK5Ld6yHBId078vuLSfwAAUvNkXRJgn53fWkgCrogVVyY5lCdr1
         JO/LVV11jMre+pTnhs2Cd2s89xCfN0Gia4OfE3OuxmFglrkjppKG51sDU+FHXhs8DjJx
         QRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1EaXpt8ZsfQ7bkFBV5gvNypyUb0wLhi6nN3cdZUg8BR8LMLtloHN0Lsu8/HdXzzr4WQ4u3OP0@vger.kernel.org, AJvYcCWeKNrkTZ43kbESNdjMZIACus3QhbzsxSZx5YjzVQ66CfHQXymoOrD3dtFDxLhp+K0Y+Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYcSROffcqeCGA0iHTrhbxMeBozOt59EYDaO6LyQsLe/HMcxz
	5FGSt5Vac7FPA9V7em5nvGv/ed++cecFvCH+gsA39Z+4gfhOlB+NcKcnYpmi3lN0gUsOrtUZL9n
	Os9VCW4xezAJEc/G+UWvIDjfC4a0wqw==
X-Gm-Gg: ASbGncs1m1kY2//fHTLOkO02ZZE0mbeQAUnRvp08KH/sW/UuzxVNCspzNqcta4SIFi2
	DvGYrJt78BKN3iQt4ZxFrPWwQpA0/uqwsQqcdta4khtemQGcg4eBdEZryqIXS5W+WijUdLL9nP6
	saPlXrLZsQePfZiEBq+DnyHfFbAi/FlWQ25s0oazSwBJ4+Lf6q9SAOuL4iieHyZMkdQdTywK5tf
	PgZJo1wIatQuqNcR/FIZmp+DJEg6ylDo0wz2B8=
X-Google-Smtp-Source: AGHT+IEGoIe0zXdy01wXvFWgnYCfeCXxZhSWf9e9c06WXVTpVKkcc+4LK3K0swXZerq8I4zvSkJqmOByl30bpONImXI=
X-Received: by 2002:a05:6102:3589:b0:4f1:7ed8:9e0a with SMTP id
 ada2fe7eead31-4fa3f8a46cbmr897542137.0.1753559819808; Sat, 26 Jul 2025
 12:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com> <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
 <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
In-Reply-To: <8d987133-0e22-4aa8-bf2e-57ef105c8db8@linux.dev>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 26 Jul 2025 12:56:48 -0700
X-Gm-Features: Ac12FXzDvgLq0UlhRr_NSb5IuTbpazmORXx3QtkaaYw6NWkZT7fSnZHSSIS1E1Y
Message-ID: <CALGdzuquTFAgnKyPKBs2v4YwaPafzkVyt7qpXG3H0TKYj0-zPw@mail.gmail.com>
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: Edward Cree <ecree@amd.com>, Paolo Abeni <pabeni@redhat.com>, ecree.xilinx@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org, 
	netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org, 
	zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much for your suggestion! I just submitted the v2 based on
your comments for this issue :)

On Fri, Jul 25, 2025 at 5:39=E2=80=AFAM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> On 2025/7/25 18:11, Edward Cree wrote:
> > On 7/24/25 10:57, Paolo Abeni wrote:
> >> On 7/23/25 2:32 AM, Chenyuan Yang wrote:
> >>> The xdp_convert_buff_to_frame() function can return NULL when there i=
s
> >>> insufficient headroom in the buffer to store the xdp_frame structure
> >>> or when the driver didn't reserve enough tailroom for skb_shared_info=
.
> >> AFAIC the sfc driver reserves both enough headroom and tailroom, but
> >> this is after ebpf run, which in turn could consume enough headroom to
> >> cause a failure, so I think this makes sense.
> > Your reasoning seems plausible to me.
> > However, I think the error path ought to more closely follow the existi=
ng
> >   error cases in logging a ratelimited message and calling the tracepoi=
nt.
> > I think the cleanest way to do this would be:
> >       if (unlikely(!xdpf))
> >               err =3D -ENOBUFS;
> >       else
> >               err =3D efx_xdp_tx_buffers(efx, 1, &xdpf, true);
> >   so that it can make use of the existing failure path.
> > Adding the check to efx_xdp_tx_buffers() is also an option.
> >
> > -ed
> >
> Hi Chenyuan,
>
> THX for addressing this edge case. I concur with Edward's suggestion to
> integrate this with the existing error handling flow. This will ensure:
> Consistent observability (ratelimited logs + tracepoints)
> Centralized resource cleanup
> Clear error type differentiation via -ENOBUFS
>
> Proposed refinement:
>
> diff
>   case XDP_TX:
>       /* Buffer ownership passes to tx on success. */
>       xdpf =3D xdp_convert_buff_to_frame(&xdp);
> +    if (unlikely(!xdpf)) {
> +        err =3D -ENOBUFS;
> +    } else {
> +        err =3D efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
> +    }
>
> -    err =3D efx_siena_xdp_tx_buffers(efx, 1, &xdpf, true);
>       if (unlikely(err !=3D 1)) {
>           efx_siena_free_rx_buffers(rx_queue, rx_buf, 1);
>           if (net_ratelimit())
>               netif_err(efx, rx_err, efx->net_dev,
> -                  "XDP TX failed (%d)\n", err);
> +                  "XDP TX failed (%d)%s\n", err,
> +                  err =3D=3D -ENOBUFS ? " [frame conversion]" : "");
>           channel->n_rx_xdp_bad_drops++;
> -        trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> +        if (err !=3D -ENOBUFS)
> +            trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
>       } else {
>           channel->n_rx_xdp_tx++;
>       }
>       break;
>
>
> -- Thanks, TAO. --- =E2=80=9CLife finds a way.=E2=80=9D

