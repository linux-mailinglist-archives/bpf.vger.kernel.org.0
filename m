Return-Path: <bpf+bounces-49248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90537A15B17
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E20167DDC
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2A42077;
	Sat, 18 Jan 2025 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0PUtFp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDE23C9;
	Sat, 18 Jan 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737167874; cv=none; b=gMI0PxjxKh95MWlOpjc0WzZy1Y4ZjHE7w8dahpnWfson5ZCsvhF9Nh5k/B8MZmtm5fCHn+mcjeqyM2090p/ROIPYOzregC5OjuT9swIvfr5ihd0p/nzUAcibhJ6d0SBSvClzevm3i6Md/6aEFO5prr+oz1HnwHn17YVlBdYEnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737167874; c=relaxed/simple;
	bh=srub4pOgrT7whtFMuZdWzw9uT4uD+pFgSf53nM4lnso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmfDjfiPuzS5XczvXXgpj3KKIleZa2O5yezxcgPeRypwZ4kVIFV3+t9rWN/mi/Cz7TgDdRUQAzILrJR39QIDk1jzBge0U1CVJ1vv2NB7u/ikPXtCznzuzrTmD+MiepMCuGhzxppivIUMRvF6coW4n82voH58Kln6+u/jaQJW+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0PUtFp; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso23090195ab.1;
        Fri, 17 Jan 2025 18:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737167872; x=1737772672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSGYQKRGrpMszh1rhCKkSOchjkUZ6YXzO1T56SE1Psw=;
        b=MJ0PUtFpl0GdEqpzXWuDkAodIJ6wneagAdxw9n+OO4IIQ8JvYQ5GcvOSIyom9cg+4N
         ggH0IvDrNaBae2lDf1kBOFFyaPBAdfa8xC3eWNs7D5cgffb6BaRKbg9guytafEmqFvFq
         clG4BpFcnPFrhKRfbWyf7NzOcc9SbzWMr26eVIKi7Wt+A06Vdf8bZZUAgoqP3gevVgfm
         Me34aqllxR7wPralYXadTyYNKvxICqTxcUbGNjPbtks2XWu+mFuiKD8ezde1ijX22mIF
         KEIoMzUiqaf+0k8S/cwItHLRuPPUIbtosJELHBi7mX/bujLbLyth+T3G2eejCTRMj1x6
         Kq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737167872; x=1737772672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSGYQKRGrpMszh1rhCKkSOchjkUZ6YXzO1T56SE1Psw=;
        b=QrQS8/X9XfYy0YEZ8WNzMjkboqIdpVnvx/lF5BGVTt708yeXv6DqPaYKjqfnH2p5XU
         IGjXCsYLCRSK0EPhsESHJt+02A7UE+kdX8Yab5+5/CjfzLDacuxku51yCvDkEqMLdM+U
         aHGE2/vLESWGDAxMvAvmqdfuDraJ9/1p562BFLstjmk37tMeI64S+WJXjwfl5Wn5cGnG
         nmQeeCDYGnodmvVzXL5GTnPvY77fEPSMHKTEIw8fDDxl22fdfuJ9LDrI/J4kAnRDzSD0
         HHXC4+j8813MogBMWAdH24Ql35tEO0Sb8/q7u1bHvlET6l6G4KHn1Qy0FAklErTvud+v
         KDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVNeECmKRlHueVLrA1cNOgxKTVbBhVPcnL5IpezFF6dN3f5Ju3ZEBRdFxEge6JLlUzVZes=@vger.kernel.org, AJvYcCWxyCIGkpscxtRCPbR3pGP+dduRy0v2D7cEh0GvY+BgsLNHJ1umzcY5FpD1Q2kCa5/Cvk3klaTP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ifceUAVjEs4WNtXsiYeEVp6N1C2L7lg/f8MqE+pFaQC329vs
	rHIsWcdBL1OTicuDN8mLCTyL7QIIuulhRb4LYffAbGNddV9oMZI89+WCudZkV7qXQLk1pOsXdFm
	SWtI+sJOFnt3uwJcT1cuDe2fHT4I=
X-Gm-Gg: ASbGncuetfW94osB9ye0O/+7beXMHRKivx0/Ci2mhbU5fyhdxam/MepXAC28eGRB3rF
	2lgdGrxfxe34hfLLd2+xLX3OBFtHCYO/RW+dCUxvbC7R23RoVA1w=
X-Google-Smtp-Source: AGHT+IFWP0KDaGvIVdpLBfuIMDfiJI7jGVAzTHcptRFi/zRuGWlIxJT63KqtibbxbIV07c1LTegPTsaCH2fnex/NQu8=
X-Received: by 2002:a05:6e02:1608:b0:3ce:7e5d:6292 with SMTP id
 e9e14a558f8ab-3cf743f7c3fmr48439425ab.8.1737167872441; Fri, 17 Jan 2025
 18:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com> <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
 <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
 <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com>
 <ba353503-bfd3-4de0-bb99-9c7e865e8a73@linux.dev> <CAL+tcoChGB3vA7LMm0VHb9OjmXHUw0--f6v4Crz5R7U+EPo+cg@mail.gmail.com>
 <41688754-20fc-4789-879f-60f763b3a9db@linux.dev> <CAL+tcoCpWs0f145_d+KLmAnuKhQ-83bANkiXXLHE_hoyhGj6Pw@mail.gmail.com>
 <060c5a50-85b6-4f1c-b458-33084858db12@linux.dev>
In-Reply-To: <060c5a50-85b6-4f1c-b458-33084858db12@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 Jan 2025 10:37:16 +0800
X-Gm-Features: AbW1kvaDcipx-2OXoL34ZxGSTrGlaFMRX6dwiviWtRk2zFlEj8cDz6Evr39QIW0
Message-ID: <CAL+tcoBLDvTDQSH-509xDBHXkmutCOZzqX-N0HkPSVzkPjB62Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 10:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/17/25 5:58 PM, Jason Xing wrote:
> >> On 1/15/25 5:12 PM, Jason Xing wrote:
> >>>>> Also, I need to set allow_direct_access to one as long as there is
> >>>>> "sock_ops.is_fullsock =3D 1;" in the existing callbacks.
> >>>> Only set allow_direct_access when the sk is fullsock in the "existin=
g" sockops
> >>>> callback.
> >>> Only "existing"? Then how can the bpf program access those members of
> >>> the tcp socket structure in the current/new timestamping callbacks?
> >> There is at least one sk write:
> >>
> >>          case offsetof(struct bpf_sock_ops, sk_txhash):
> >>                  SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
> >>                                           struct sock, type);
> >>
> >> afaict, the kernel always writes sk->sk_txhash with the sk lock held. =
The new
> >> timestamping callbacks cannot write because it does not hold the lock.
> > Surely, I will handle the sk_txhash case as you suggested =F0=9F=99=82
>
> to be clear, not setting the allow_tcp_access in the new timestamping cb =
should do.

Right, I will only apply to the existing callbacks. I think your last
email is pretty clear to me and dispelled my concern. Prior to this, I
was worried about not being allowed to access struct tcp_sock in
timestamping cb. Thanks for your guidance.

Thanks,
Jason

