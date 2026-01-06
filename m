Return-Path: <bpf+bounces-78003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F8FCFA431
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46C75302F7A4
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 18:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE334F497;
	Tue,  6 Jan 2026 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXCeqP5G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABF25CC6C
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724841; cv=none; b=rDcN+iAYgCQ81OvnJ79V3S26CXWOKdyrPbiTdyM/e3ML1m2xqQ/s/d25sQz8vNo6unRsQ+2f6vBuT1rq7Cm+b+llDOtE4ToGcmPzM2Bi+LmKBcLbiIzrx7olL06gH8dvKEm4ln/c2JGQ8JxEE7xCw4JLsXBetlbkIrQlI0BiTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724841; c=relaxed/simple;
	bh=RWNQHn4DGRgRLcnmtfeCdhR5hdgZkUGWzcMWI26afZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ognaI+AlFbWmkklPimlOAZecfNA+nsn974ISKi5t1YIuuCk2VJu+WaHJklEDCvt6CrfIC71MYbG9m5lCABdZ4sXgigD8kTd4DNaGnx72jKYIj6CAFAdMwdYszV8zhWo6I0h2LYbboWvJxim1nP0VPIKu8+v/BYOJpiTw4Q3JT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXCeqP5G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc305914so871385f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767724838; x=1768329638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88EtJmRK4Gu5YixrUz19hmnSc1gn5W+C/wUxSX+bTSg=;
        b=bXCeqP5GQns8wI+KvhIMU2WqwCdUH0yjZAW8P1q21ATMurPZu0Le+JRuQa8bw/Kqi9
         GpAVWI4uW+slJlNUIkL+Gq+HJpbgGJSZLcxEs1HMgTkSGA7OUY+paov1BN063fbj6g0c
         msM7awvtENEnqdK0OtbAoBjKS6yw8LzGwQ18S+YxQ5JRWHABg+DbapOmHMyu8mmM5XQx
         2474leM2EkFewrWraD/qIVif5pdcsn19fdK/q+cp0Lb5qt7rc8agDher0HPE/T1iv5cU
         ry3bitU+B/IB8gmvqMVD/HPpYacc3FrLP1B/pvSFuUawpn9ybhTBS34cv1JlOkhZEG09
         iWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767724838; x=1768329638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88EtJmRK4Gu5YixrUz19hmnSc1gn5W+C/wUxSX+bTSg=;
        b=pX74cSWNyOe69f0WTkHiZd1+yLWLqhZtqmrlbWXCvzGu4FlQLCaehabjnVxHDNjfr6
         9UkQKzEaMDgEaTiD5J0EnSb4rX92UlTZbVo/fAFHoBg3OvLHl1+8deuy010jAsWuiqyA
         3UXgeIHgAFhMeGe5Ghzv3xwDunfxCD9qyLrk7iSjzEhXEvc/tC219/cSldZ1+Hh+CUcN
         Di6DnpZOb6ttSzF53XQvHyanu4qeN6BOyZtXdDabmN4NOn8oMTmS00PUOzByDWaMJm2K
         3AhGssbtLXwnt6OlkuMJcuHRh5BKwp9IwdUZZsz3DIFWV9pac2KCCfmMlBhTe0ovhPPO
         PlIA==
X-Forwarded-Encrypted: i=1; AJvYcCWDLqQL3zoqDR4uceaz50R1jFFeI4imF639kPptj3tvDyMmOPhaRv+grhTZs58FdrIDAPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSN2KJLHjoMz8VIbNWr1UzSionze8LIBZcuOvWSNq6ZZ66+tP
	VBI1HJJB37+ev3LUT/2tbH3zAsSVVJF9luUrw6OVtT+KvwFgG8KwDYPaMVi8Kii3xCLnezjfNvT
	DT9erTo4sJ7Bg0n5VJBVR1ZzK/T63yHUTBVpA
X-Gm-Gg: AY/fxX79q+RZKciZVxJxM5txhLCzLcek/oigovx381nYaErcOvoOYgKtkaRddr1cJce
	i3BOOvbhPrCmk1km0vn5idbzq41Iyxwpm0kuqoug0cIuIjMi3HNZV5sEZ6e5XnmZcSdSnQKddyU
	CGqNeg2tu5RffGY8DbXBxkLGgDvBbAIEf9cyTsiAOyF3ke+g5kyISm68S5Rve8rWHcInEqcE/dJ
	UFEHSdzDihSVkH89YE5A7NvEriZaDIEmOon/CD72MY8obnzWi2Jx9j8UQ31+3EYS+HxjZhNimyD
	5+arXvlmZCk=
X-Google-Smtp-Source: AGHT+IGtlzo16Yj6LrFYJJD81pxgkQ4sznqpXw3oPq0nDS8PbHxR5tTePeMz/bovrxfRyAl9nY40dO3V8xON2Mne5mE=
X-Received: by 2002:a05:6000:1449:b0:430:feb3:f5ae with SMTP id
 ffacd0b85a97d-432c37a721dmr93020f8f.55.1767724837702; Tue, 06 Jan 2026
 10:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
 <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
 <877btu8wz2.fsf@cloudflare.com> <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
In-Reply-To: <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 10:40:25 -0800
X-Gm-Features: AQt7F2pViPcfQAB67_hx0J5Vj0LqXq-3QfVnB7KSk1GcSWnVDyn6jxTDjYHR88w
Message-ID: <CAADnVQ+VfT8nQA4eFec2Q7Fga0_2sbYmdaJffSbKpFmTwsE8eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Amery Hung <ameryhung@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:47=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7f5bc6a505e1..53993c2c492d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *=
insn_buf, u32 pkt_access_flags,
> >         /* ret =3D bpf_skb_pull_data(skb, 0); */
> >         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> >         *insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> > -       *insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> > -                              BPF_FUNC_skb_pull_data);
>
> This is why I was suggesting setting off =3D 1 in BPF_EMIT_CALL to mark
> a call as finalized. So that we can continue to support using
> BPF_RAW_INSN to emit a helper call in prologue and epilogue.

That's the only place in the code where BPF_RAW_INSN(CALL, BPF_FUNC_xxx)
is used, and it was done this way only because we didn't think
of finalized_call concept.
So I don't think we should introduce more corner cases with off=3D1.

