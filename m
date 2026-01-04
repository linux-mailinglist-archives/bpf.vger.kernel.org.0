Return-Path: <bpf+bounces-77763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D018BCF0A89
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 07:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926CD3006442
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F42DF707;
	Sun,  4 Jan 2026 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icOJK9J9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62C2DECBD
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767507777; cv=none; b=uAn1sN/NbLr7R9Mw1K00pze//WszH23VnsCSvBGxlMQS/fS+EsN6HvcLzEtlekjNMeORUZPwD8JFlXyVrLgXWHqYl7eQxVv+ny5aGjPMKrozEO6TFyYs6N+x+OH4UGP/Af4M3RnGi3QRF0wprVtisGBCzDQ8wnLMU6EINHColK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767507777; c=relaxed/simple;
	bh=nmvNTEn2d2Kw218CvlRrrbyqxjZtPZvg0zO+e9VgXnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0QuNXv7j2LeRnRnUbc1jheMGiXmJWkPw+VJYBy9sqkWkSbfPHtX7avuEvckdsWkP4UNbri/AuAWZo3KMfAqTTGAL5t3X+SMyNWhCcZbC7zPcUXS4vYG3Ou+0YK970dHXy06YzA3si/V4EoK+/rrS4qJ4BYxZmIgVCwt2si/ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icOJK9J9; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f0d1a39cabso8473704fac.3
        for <bpf@vger.kernel.org>; Sat, 03 Jan 2026 22:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767507772; x=1768112572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFfPlAf5+lGKz5BhLDkt0s58hyQ5L/Fh79A19Mu9HtQ=;
        b=icOJK9J98CqvKrYWJIDE6E78U7K/zODI9DdmWPPhdKE4bVxbpqb1IM0QEfVwLwVHHg
         8Q047gkcbk7CsRHRs9TE/lrNHIO2c/lxMLydrTykBUmiFtZje2Qb/XwiPm5I7EFSnTnM
         ZKGndtdjvs4zjPf+LBydoBBaTnwefFLS/swwfTHR4XAUexVpLQnPWWDyHAhud8f9yNsG
         sS7Ul7CIPsj+S9/5U2x5K1soCPVIdMIDMsVfsJWdGI4gQGIhgXlo4bnDkRaTXflT4iVs
         gRrSVHDRkxPdYaWyYhJYRtbPdX1EI0j2ckMmRH2djD5XMr83rOyq7MexuvVml29kZXZN
         TtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767507772; x=1768112572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFfPlAf5+lGKz5BhLDkt0s58hyQ5L/Fh79A19Mu9HtQ=;
        b=AT8vAZib8a1baQst9xuWohgHVKZIl+8w66fmVA3bcMpqCe+yKI1kXgWRzVPl4lbWVU
         89JvQVuvE4zKr4muoHPENuAzmhltsF29n4vJ+8qK4OdAtgZretGNTX+wq6ElGrcAP0n+
         FY6y+4dp8sQc11uw8LX5lM5vYpY4SAzjN/2BC6GHhyHhLnuBDvOUk62NaeTsoa0kw/gI
         NrABisRDgV3VFRBmpe3UQs2AS+vfOdcyrwP18j8/C47dh7AMTqnRYnNdGEGq8WR6asjs
         nsRBMB9CNqtclKHXNAfgM1j2LangNZyekEw55bBAHNvBDNERYkZXFmBzewXRHLxdA7vc
         g/xw==
X-Forwarded-Encrypted: i=1; AJvYcCVfcZ3sL+LY3xuVxXZmvIwo15P/a1ur56aORaxI3v7T4knwlN/92iqAdZrGtJuxXukniIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybeWRiFxRR+XzcJGDdjH8dxovmrnAoCp5NNAPDNNloMxybwJGu
	29l7jY+LUIcNJVxAqUa4qre7AGK5RZoGweg+1/zAvwj3+BYPUHh3v/RNnP0HhT+oO9geJyyzFD+
	Q7Vm7klnwQk0tMzN+R7oA+bN4mvY2n4U=
X-Gm-Gg: AY/fxX4jSg/kl2sMiL8JGOWgQpsa8tVbxPQRK8Qq8ky4pJt8R1Xi2MNE3LC+RGpZSKm
	clSb6C1UsFoYdeqP3PQ/A4xl7f0NojTRstJQw4lO1HshuwaXJEct9ThlY0GEec3wpUJnJMVg5ZE
	if3i85g8BF/LM5MqQ/ppieskL7rudGruz/6j2olV2yJRLJdrXOEV/lRUMe4fKNdHBMeUuaz1wgF
	alfpsHPgP9Qfab2ErdtFcSqTQi6rGVOoF+qlzxqkZOkZoaH5tsHG8XcEyczyyvOpuzdtbgL
X-Google-Smtp-Source: AGHT+IHKUzNaqXfAAOXTQH/wyhLdPifEG8hdfQus5/ZP24EhvnoebGBAh1/QoRljvFz3JP4QEo0R0qH1KXixAhwxZ7E=
X-Received: by 2002:a05:6820:330d:b0:65c:f046:bb71 with SMTP id
 006d021491bc7-65d0ea9933fmr13839045eaf.46.1767507772044; Sat, 03 Jan 2026
 22:22:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104032313.76121-3-kerneljasonxing@gmail.com> <e15de586e958d118e15c59026406ca4df756ccd9075fdcedd458639685b661a9@mail.kernel.org>
In-Reply-To: <e15de586e958d118e15c59026406ca4df756ccd9075fdcedd458639685b661a9@mail.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 4 Jan 2026 14:22:15 +0800
X-Gm-Features: AQt7F2rOvf6soK_ZUGhuzyLkXSDXSaX75Goy7BHhQb-bgoLkIADQtPUhfMbpsMo
Message-ID: <CAL+tcoB6eCogZXXxDQ58nxp-VxWFOPR2DP4pyLVxGtjXdWPQXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] xsk: introduce a dedicated local
 completion queue for each xsk
To: bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernelxing@tencent.com, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 11:39=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f41e0b480aa4..0a724cf20fcb 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> > +{
> > +     struct xsk_buff_pool *pool =3D xdp_sk(skb->sk)->pool;
> > +     u32 idx, addr, pos =3D xsk_get_start_addr(skb);
>              ^^^^
>
> Should addr be u64 here? The lcq->desc[] array stores u64 values
> (descriptor addresses), and xskq_prod_write_addr() expects a u64 paramete=
r.
> Declaring addr as u32 truncates the upper 32 bits when reading from
> lcq->desc[].
>
> For reference, struct local_cq in include/net/xdp_sock.h declares:
>
>     u64 desc[] ____cacheline_aligned_in_smp;
>
> And xskq_prod_write_addr() in net/xdp/xsk_queue.h has signature:
>
>     static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx,=
 u64 addr)
>
> If a umem is large enough that descriptor offsets exceed 4GB, this would
> silently write incorrect addresses to the completion queue, causing user
> space to receive corrupted descriptor addresses.

Yes, it can happen. Thanks for pointing this out.

