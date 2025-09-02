Return-Path: <bpf+bounces-67220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3CB40DEB
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37E33A991B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 19:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC052E5B19;
	Tue,  2 Sep 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrlbrY9M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB46286D7F
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841593; cv=none; b=cI+tbGD0AcI9rX29gMyj8VcMVtSeLZbzBc+oeU+XYpAQXvGYSmn/kHT3jHaLlwGJlpaclerSUxFRLjtGWAwNxmSt++kgD0C7PossKtfk0c6+JC2oara24Z+rrWsv/u0N99+OQ9f/t/Ez7Ololkk99AScG6voxquwJxHFcC8JPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841593; c=relaxed/simple;
	bh=DZVG7cD3+F5INllVXM8wY5G9pLWUGigl6+7rZcEMjuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6JBY37gPHYYirYIs71CDNrN2xNgFQbXaQqfkKJdRj0TO5EnEXalLivLfslvZbapxuhEhgrpYwMVbRdLwlQSgMTwDTQxi/ipzSmj67Thr2nLIWRDerLTWQ5qU/N6Hzn+W3XKrzoVRaD0vxdUurOjJ/R0XC49SG+9NcQJ5R1qy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrlbrY9M; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77256200f1bso1931517b3a.3
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756841592; x=1757446392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYwp8Zr2q1d600NBfnugsNcS1VrI9GFl0s1kI6DYjPE=;
        b=hrlbrY9MGsv5S5rE9ZawGGJ2p9+ExIT67I6FQfc3g3Mz4SYNWYGiKz6y7Tj5JeZeSg
         0sFquzi2WViyZDGhYatn035wCfv/dM0xhYVTkbxWA2PjFTr2R7jgNaPAiE0pEhRu3WqV
         aeC0QiY92qFD8+imZp9JqIoRdihqhCivAl6U0ZTlTTwL9s6K1ysafMGGoSs3DnhsKGD6
         Q8rRHnTZf2z/2I8wfw7VTearwiAPtQltEjDQo8svk8wV60lsIsUQ+GNFmHyoIW8W/HCa
         s2MBHxE3QPC1SFu8kA6JoM8R+n6mnaGRoQMhxL8eajHzEQK6Al9M2hMR15XwF3SH3TnC
         6RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841592; x=1757446392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYwp8Zr2q1d600NBfnugsNcS1VrI9GFl0s1kI6DYjPE=;
        b=WQ8PrhrkwfJ1mFc5O/Xzt4YPnepcOcf5rWBWAiAZ+NrpbVSupJ529rXYkwXXhFvb+E
         Rl7+xUtq+9scOZTl2DFpoB7phVb/TGyCupsVOJkT5XOVc5Or59SL5VGdF9TeZlkFJ3/F
         j2NEteElaGCZx43koi9ydT5m9EldILiF2KRm3xA/e7MqdSoHS0zAMAg3Eo3rPP6ms0lA
         jumlE6GeZMQ0gBEO9Q7pzSJ7fJHZH34/JJzkzHiyA+kQa2fClkQeygkxM+kcfkTsSgik
         E/QPlX2hktRNDx4SIbMcPmztHIUBYAqLnVlIQQ0LN8lTb9bfFtMS6jWF/Kvd6srRr9f9
         6R9w==
X-Forwarded-Encrypted: i=1; AJvYcCUjTS7Nhqc7/5yMM8nkFtjMLxpadJrhNAVRt2RY8dQlN5rmQzpPDtg7Dsi2RQW40r2pSBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Do6oaByb+ETRkR3vRfB+ml+K+wnikSMnQA1VptQF7vZT6fDQ
	kWgFX6DHLNhD5DBkfzLcR+BGvk2Zw2mthUkgYNzloddWn8T+1km6gnJD7iFbKm1o1OZVtqRsBWz
	0pIy1ARPwPhG3Q8Hg3JFBBP+niGVHVRVvjSGMTavf
X-Gm-Gg: ASbGnctRXF4A6yT4etQ7W6LRR91P/G2MmcYoAjSrFJCkZ7SvQRv/glJn55cu/iosPiJ
	jHHcJh2XGYZIWhWceX0EMXIWr2gCTFvgKpv1LXM4S1qPT6WHz7J/Dfu7jbY5q3vmMovObP3SWy2
	T9R/WoYdac5rJs/pxj4CpaWzZd9ArT72TfJn656xMkEdfVo9gl9YC8UOfYHkbcrtBEVJPpcKWut
	v42U3tEZnfj66+yvtjMgpQ2TgmzulUMyhf+afTE0jAE+G5FmUf4bwvKEIRB3SVYlXp5AZW6l3Qn
	hA==
X-Google-Smtp-Source: AGHT+IEATvy9q2b2V7CURED7FUCTkt0VWc77CBS1KVMeBeSUsRNGYkpjgAHH8burand5lFozqhssA7q8awK1+uH5zCs=
X-Received: by 2002:a17:903:46c3:b0:246:cf6a:f009 with SMTP id
 d9443c01a7336-24944b46499mr176478375ad.46.1756841591456; Tue, 02 Sep 2025
 12:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-3-kuniyu@google.com>
 <9bc995b4-d0bd-41a8-8867-97507a55d449@linux.dev>
In-Reply-To: <9bc995b4-d0bd-41a8-8867-97507a55d449@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 12:33:00 -0700
X-Gm-Features: Ac12FXzAhZBeB4p5Hn_96Y1BXB7W98FDKQSN1fHhXlm7f7jXYCMLYEKLpI72O7o
Message-ID: <CAAVpQUBzyT8t1c+8ukk93q_GQMXAxg4WX4fOo4iishJX4wKEkA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:10=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > +BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level=
,
> > +        int, optname, char *, optval, int, optlen)
> > +{
> > +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto =
=3D {
>
> nit. There is a bpf_unlocked_"sk"_{get,set}sockopt_proto which its .func =
is also
> taking "struct sock *". This one is sock_create specific, how about renam=
ing it
> to bpf_sock_create_{get,set}sockopt_proto. The same for the its .func.

Sounds better to me :)
Will rename both.

>
>
> > +     .func           =3D bpf_unlocked_sock_setsockopt,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +     .arg3_type      =3D ARG_ANYTHING,
> > +     .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> > +     .arg5_type      =3D ARG_CONST_SIZE,
> > +};
> > +
> > +BPF_CALL_5(bpf_unlocked_sock_getsockopt, struct sock *, sk, int, level=
,
> > +        int, optname, char *, optval, int, optlen)
> > +{
> > +     return __bpf_getsockopt(sk, level, optname, optval, optlen);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_unlocked_sock_getsockopt_proto =
=3D {
> > +     .func           =3D bpf_unlocked_sock_getsockopt,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +     .arg3_type      =3D ARG_ANYTHING,
> > +     .arg4_type      =3D ARG_PTR_TO_UNINIT_MEM,
> > +     .arg5_type      =3D ARG_CONST_SIZE,
> > +};
>

