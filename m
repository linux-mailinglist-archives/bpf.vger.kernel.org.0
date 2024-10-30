Return-Path: <bpf+bounces-43497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC99B5C0A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7971C216D2
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E071D515C;
	Wed, 30 Oct 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0SC23yk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2013CF82;
	Wed, 30 Oct 2024 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271045; cv=none; b=AyqyeolZafvnyTKa6JYu1ZT4ZSICrbH7lbvDXMvaNFwnlE8tFp9rUFQBZDFslxQ3/JPeh3emUwCiuLxRym75JZL7qTRXnJPXQeMttCUVOZwkYEDVzo6Fkl292VpprtDarZwTAyU9KOXNA7SJwBx06fFRYKZKB66yvkxw3cAoM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271045; c=relaxed/simple;
	bh=BXt4eiLhj245sxOmQSiHJTniw0k3sZd0lAZqGoVeu+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyFpvKxif2Fgm+pqg/LSNtNFQvZzJM9Tn5rL3vtRS7W9pwbWqh5ROS3KTZ7wvjFzI/KbLr6e2g9v6DrnuGkIvw/9uwIL+DU6sDgc/YMOiQOxLiP4GDWo3E3iTNMrIGGlFslwWXknCIx2lqURH/mVUpTsGfQwiL+tomoGlEkMSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0SC23yk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so981586066b.0;
        Tue, 29 Oct 2024 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730271042; x=1730875842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pph5VvvQQbeho6+XLG/bZa5jhdCm1MgHIE1BMtQKjYY=;
        b=U0SC23ykgL0w3ZIvtPxTd8cnnb1eQ47w3lJ/15QKcZtEXndql0pEFf1opbXoyYr53M
         5jrVrjGcgBT+5ex3MsJ/Dl7GbOxUgGEChiTYiU8ir+s4XzEEAXUeQPxiQBKNkVqWr3xw
         fY3pYudCGTtwK09i7gE7fqNpz7ggG1lCMbdAFmlLloiHM3NsY3bci79Kc6m69rBLPxM5
         QbnXOu3G7iDixMMEvRb7vmqrc7JPHITmkn/ya+zkxMo53fs5OGm+oVANtFjQl5Slu8nm
         jXeaNWWLwcsFL4jrKw7orx1BCj/LbW3PLaBk3dSmxqFRgmBqmj6LtrCeuFIpm571oo48
         ydlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271042; x=1730875842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pph5VvvQQbeho6+XLG/bZa5jhdCm1MgHIE1BMtQKjYY=;
        b=r4LZb3/hCZMqCCLlojFFq6Lhi7HpxL1+wfY82UABCveW5VPykfIMekHUF2iOh28dGL
         xlkl9f4MljsL5SfIpW54QjUnmJ/GkFoO3k4YWs8bUBuoCxBdUKkbC6LQ2Afngj70Uj8g
         bVUt1gVKdL101LfLObkXJvL+5Uwp6nTCSPImKpeJPrJ3UTsEg6ehG9lKH/NvQRkQ5Wsk
         zEcA1kmSTyQ9Lk+FOp7x3Gw1t6tQ9w1lgTw8yWDtgn+iDtM425SSQoTBo5JWe09al+v7
         n4PUtcQSDJ4rCmTL9GZxoloyZjLM8fhaghmm759s4s0cQ17uOCjpH/5qj8Pl8HP/wcqu
         OJIA==
X-Forwarded-Encrypted: i=1; AJvYcCXBpN9j1WxCFnzHv22wTK0EouE5wMerRZtTOBKc2XYWPu2apGNIW9hl954H0BW2fvKfvYcgai02@vger.kernel.org, AJvYcCXMIW23HJp1s74lKDv8ALgXX3p9HHOdVsWQZzfePRtxmOiW5nC/RHmd2dX+1mR31ebRFYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm/zrQQkv4O54XJ8gxnvPLfV4jvyfT9jd+q2LqqVQzGx9S83y
	FddSwg44qeiTrCH50LBjyIhj6pfnjODTa+7hoGPf0JqwStogGl1Be2pAAA0k4LBz5qKN2Z/w06O
	+mTDQhBOX1sO7oeuiVjGFQSAazQE=
X-Google-Smtp-Source: AGHT+IGwn8QRPvn4nrOdmbWcN/R/sABrXWfmQbsQ9jhKQALMgnYuO0nRljkZGLOsNLArGYw/AGXFrl+1ambEEgtfEbs=
X-Received: by 2002:a17:907:971d:b0:a9a:13f8:60b9 with SMTP id
 a640c23a62f3a-a9de5fc7847mr1467119666b.36.1730271041605; Tue, 29 Oct 2024
 23:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com> <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
In-Reply-To: <8fd16b77-b8e8-492c-ab69-8192cafa9fc7@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 14:50:03 +0800
Message-ID: <CAL+tcoBNiZQr=yk_fb9eoKX1_Nr4LuDaa1kkLGbdnc=8JNKnNg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:42=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/28/24 4:05 AM, Jason Xing wrote:
> > +/* Used to track the tskey for bpf extension
> > + *
> > + * @sk_tskey: bpf extension can use it only when no application uses.
> > + *            Application can use it directly regardless of bpf extens=
ion.
> > + *
> > + * There are three strategies:
> > + * 1) If we've already set through setsockopt() and here we're going t=
o set
> > + *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey and =
will
> > + *    keep the record of delta between the current "key" and previous =
key.
> > + * 2) If we've already set through bpf_setsockopt() and here we're goi=
ng to
> > + *    set for application use, we will record the delta first and then
> > + *    override/initialize the @sk_tskey.
> > + * 3) other cases, which means only either of them takes effect, so in=
itialize
> > + *    everything simplely.
> > + */
> > +static long int sock_calculate_tskey_offset(struct sock *sk, int val, =
int bpf_type)
> > +{
> > +     u32 tskey;
> > +
> > +     if (sk_is_tcp(sk)) {
> > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> > +                     return -EINVAL;
> > +
> > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > +                     tskey =3D tcp_sk(sk)->write_seq;
> > +             else
> > +                     tskey =3D tcp_sk(sk)->snd_una;
> > +     } else {
> > +             tskey =3D 0;
> > +     }
> > +
> > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > +             sk->sk_tskey_bpf_offset =3D tskey - atomic_read(&sk->sk_t=
skey);
> > +             return 0;
> > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OP=
T_ID)) {
> > +             sk->sk_tskey_bpf_offset =3D atomic_read(&sk->sk_tskey) - =
tskey;
> > +     } else {
> > +             sk->sk_tskey_bpf_offset =3D 0;
> > +     }
> > +
> > +     return tskey;
> > +}
>
> Before diving into this route, the bpf prog can peek into the tcp seq no =
in the
> skb. It can also look at the sk->sk_tskey for UDP socket. Can you explain=
 why
> those are not enough information for the bpf prog?

Well, it does make sense. It seems we don't need to implement tskey
for this bpf feature...

Due to lack of enough knowledge of bpf, could you provide more hints
that I can follow to write a bpf program to print more information
from the skb? Like in the last patch of this series, in
tools/testing/selftests/bpf/prog_tests/so_timestamping.c, do we have a
feasible way to do that?

Thanks,
Jason

