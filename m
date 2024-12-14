Return-Path: <bpf+bounces-46965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694619F1B38
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4D16B498
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703EE137E;
	Sat, 14 Dec 2024 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn1+RUTj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757357E9;
	Sat, 14 Dec 2024 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134580; cv=none; b=piqP7OovL4PTNlLptAEvzR2I7dzTt52LdRGZYjAr4Jr6ReTL9Mh6Qh5R2tM8UbyRl8gvq6D77VLeRdE+3cB4GHBwd3JBL3gllJXhAISjgGJb8XLoso7NUK1FG9GytoDZT2se9DH4/bTPDVZd23sl5uBFpyPg7dhVSAQDEpwcj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134580; c=relaxed/simple;
	bh=UacBWSlMlk9FFofQiDxPJ6RZ6HyR4ZR6dNZUtB2KMls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3lGrbPaoXEE6QuU5YJOoxyybE3ZyZ4QGhtK07r275MUV+fk1dg5FoX2R0JQSFi9JeUPSBLKbx1X9OE8B7zFiEfUIZFDCrMnJcq2LG2AjtWL9+K7/0DQaqVOk7q8TxqgN5ru9tnqDW3po0/k4p8Nhcvqa3uH+UFjgOKYV3rz5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn1+RUTj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e1eb50e2so70942039f.0;
        Fri, 13 Dec 2024 16:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734134577; x=1734739377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yiYHeFiVkurIha7130PlHGb8cpw9DSInrY7PDUmogk=;
        b=Mn1+RUTj67myltoiabONQdNiK/nS12hJbhZ47w0I95qlAMJC0ALs9MusOoo/anktTP
         4nNEdfrVDUUopWPykZTgdNuqu+zpwKLjFuDQPOH9z2qX7eu5ERqh+a6Y2pJBdTVcSNcx
         uAEClW/6u2C8KW3VvukILEVhzSb/VRYbm2KuuKveUuOhqEe6TqngQTqZnq4hIiNlXaDi
         +MoCvqAmA0TAA4kon46n0H3T6ZgP8UwuwYMreOlwOHzYLI1Ca24KA8iGrkjzxKJx3NUE
         WyDNO/ZmtR3JlnoLhBazuea92lfzPD6eBMXVupJBegE9AqdJJqYpGHkIe6wzC1PZZBUH
         ZRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134577; x=1734739377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yiYHeFiVkurIha7130PlHGb8cpw9DSInrY7PDUmogk=;
        b=n0z2nxWnB78iuvnXbOdDQjw3tZdUJwoC/CeMAEPLawuSCXD6OOnKEjqZLkGHr9xZL5
         +R8c17MC6y1CawDZT9ECdN03A0T5/Y4z/vJNq710Q7aSK2x+CB76JTabBE/83WQQ0P+0
         wAtASZKcyptIywTvgidXKCAQEA0SqddK6Ywdu8JKNlO9XjzM81s+zVnE+JI12wolpjAE
         77tjBWbKZ76xNWvjucP+K/xv0cM1nDU/0z8WAP1tHWkAED5CSlhAErY31jG4OV+xRfqi
         MVPxziXtBL+vIEQMgiiOnkOFAHJwM14a5mmelQAzNfTYEVts8sUnKZnwx/Jpl6kVpjwk
         bU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWS4W0RRTVBKT3sJyVsfbDPMJLvhrfCNAfybKnBDEq5VcpgAaAqVZRgwaiUOInEMaMuqY8=@vger.kernel.org, AJvYcCX5ulRlS/ZmxBC9KKMZjXT80dj1DMZzL32SA4QVs0mu6u4JYdmDiJJmfH1VaIzHCzCsp8qKLuvo@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6n7SrSafDrIGXRV9wGvSRBo0+OCvpNKc8XU1JWQ9rLk99PRJ
	goxuF7Ya/4pCzYCHliBtjx/EZnNx7wEyC5FeGOB8CUvLs73QcNW86IdgdPuNXR+GGuQMTNCrp7L
	FaQVHBt7UgQf75nBEE8V+uP3HuQhkFouY
X-Gm-Gg: ASbGncvjUZHdd5MsUbu7GEYuOmNR1eMFYwz4WyUSVxoENUrGdK2paH0Qk5CGHGeoo7c
	697wzshcDU4bJUH6tFDnTNo119J/cSP+Y3l+t
X-Google-Smtp-Source: AGHT+IFG8VfbB021J59F7yO1ebzrmUDBdfO6qsYBBSjy50MuO6HkjsclpNgrzGy+MTuF7Euk7uqU66hd3c0FQOzFa8E=
X-Received: by 2002:a05:6e02:1a25:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3aff039a554mr59434635ab.13.1734134577538; Fri, 13 Dec 2024
 16:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-8-kerneljasonxing@gmail.com> <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
 <CAL+tcoCyu6w=O5y2fRSfrzDVm04SB2ycXB06uYn2+r2jSRhehA@mail.gmail.com> <53c3be2f-1d5d-44cb-8c27-18c84bc30c9e@linux.dev>
In-Reply-To: <53c3be2f-1d5d-44cb-8c27-18c84bc30c9e@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 08:02:21 +0800
Message-ID: <CAL+tcoBzapbhMuu6=jsDbf6N5eT84JmZ-siZFgHNogcRANj9bA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
 for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 7:15=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 7:13 AM, Jason Xing wrote:
> >>> -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb=
, int tstype)
> >>> +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb=
,
> >>> +                             struct skb_shared_hwtstamps *hwtstamps,
> >>> +                             int tstype)
> >>>    {
> >>> +     struct timespec64 tstamp;
> >>> +     u32 args[2] =3D {0, 0};
> >>>        int op;
> >>>
> >>>        if (!sk)
> >>> @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *s=
k, struct sk_buff *skb, int tstype
> >>>                break;
> >>>        case SCM_TSTAMP_SND:
> >>>                op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >>> +             if (hwtstamps) {
> >>> +                     tstamp =3D ktime_to_timespec64(hwtstamps->hwtst=
amp);
> >> Avoid this conversion which is likely not useful to the bpf prog. Dire=
ctly pass
> >> hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in args=
[0] and
> >> higher 32bits in args[1].
> > It makes sense.
>
> When replying the patch 2 thread, I noticed it may not even have to pass =
the
> hwtstamps in args here.
>
> Can "*skb_hwtstamps(skb) =3D *hwtstamps;" be done before calling the bpf =
prog?
> Then the bpf prog can directly get it from skb_shinfo(skb)->hwtstamps.
> It is like reading other fields in skb_shinfo(skb), e.g. the
> skb_shinfo(skb)->tskey discussed in patch 10. The bpf prog will have a mo=
re
> consistent experience in reading different fields of the skb_shinfo(skb).
> skb_shinfo(skb)->hwtstamps is a more intuitive place to obtain the hwtsta=
mp than
> the broken up args[0] and args[1]. On top of that, there is also an older
> "skb_hwtstamp" field in "struct bpf_sock_ops".

Right, right, last night, fortunately, I also spotted it. Let the bpf
prog parse the shared info from skb then. A new callback for hwtstamp
is needed, I suppose.

