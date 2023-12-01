Return-Path: <bpf+bounces-16393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF78800EA8
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163C0281BA3
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0904AF81;
	Fri,  1 Dec 2023 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVI9rFJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA61A6;
	Fri,  1 Dec 2023 07:36:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cde11fb647so2243235b3a.1;
        Fri, 01 Dec 2023 07:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444969; x=1702049769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVOmWwUFFk1k8CyqT9WvwOoomf+HNNEr1YCh3lVCYfw=;
        b=iVI9rFJz/orMjcMYSScp0qc7uY2X1fpAfjfoAe5MPq71Vk098KHs1gL9eo4fmumrzn
         gpV5M3uNUOb3/gYcYUa/dQGn7GJeImZTFLG2RQFpeB1/IxNoXgP1GjOsMrMIb6o+emN/
         D81tnrLEdJBNTo9vhxdFOorBRAOuEsJASvYBjZsIYhpXXVXCBvJjjf5+PM93FJ167Mg2
         1TIC5D9V1jU4oNYKDfxrS44tpTtV1/KH7ZT+9q04tSKDcrLvvtFr7uvLGjCUOviaUwvL
         F36+Goo5qTEAwbgCQn+Erc9MKfkp+10Nnt/T6Huuc4xRnaqylVLfTCV/RbOM17brth5S
         yN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444969; x=1702049769;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hVOmWwUFFk1k8CyqT9WvwOoomf+HNNEr1YCh3lVCYfw=;
        b=RDmX1vrei7UidOemfTuUx8h0R0Us4/sIiZFdWsr2pRQyC3a43hxNMsQftxdBMhFGK6
         aVXsBChXQyrW97xSwuSFHur8SZI2HpoFG1+NFGJzkkzwry5a4ILhWaz/7pI2A0dIqIZO
         Z7bpO5ksvNbd8Yix8mrmAsFJ0RiEj8OsYSvYsgN6FwDbtc8fZtG6tGqiGuAVz+LYED7v
         DwW025q22IDoH65t9HbBOE4N1HupR9negNdXixmOeH1mu2IDDs83QMRM8UucjApY4RGT
         vYFyhmw32H4MU/gy0nZPfrkX3/5SUVhLpNGLi4+KgR3dt/EJ49SAO4TEo4Gcjun+ECG+
         8kCQ==
X-Gm-Message-State: AOJu0Yw/1GRvKViIlMaoNUZmxmTRvGXKAsKoEiw61CLBPvkar1uTfrlO
	r4B3hVScKJblaKIvPUwFwXr22F93id39hA==
X-Google-Smtp-Source: AGHT+IEjm9oc+Rg9WTQ/4DP13kt1pnieell2yh3H92QLnT2Kvq5k2oDdLGPU9gyE1BqJZ97lOfSb5Q==
X-Received: by 2002:a05:6a20:2446:b0:18c:23b0:3b16 with SMTP id t6-20020a056a20244600b0018c23b03b16mr23316339pzc.60.1701444968797;
        Fri, 01 Dec 2023 07:36:08 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:7a9a:8993:d50f:aaa4])
        by smtp.gmail.com with ESMTPSA id r27-20020aa78b9b000000b006900cb919b8sm3117653pfd.53.2023.12.01.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:36:08 -0800 (PST)
Date: Fri, 01 Dec 2023 07:36:06 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: kuniyu@amazon.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <6569fd6649fc9_44402208de@john.notmuch>
In-Reply-To: <87il5i2req.fsf@cloudflare.com>
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-2-john.fastabend@gmail.com>
 <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
 <87il5i2req.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 1/2] bpf: syzkaller found null ptr deref in unix_bpf
 proto add
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki wrote:
> On Fri, Dec 01, 2023 at 10:24 AM +01, Eric Dumazet wrote:
> > On Fri, Dec 1, 2023 at 4:23=E2=80=AFAM John Fastabend <john.fastabend=
@gmail.com> wrote:
> =

> [...]
> =

> >> diff --git a/include/net/sock.h b/include/net/sock.h
> >> index 1d6931caf0c3..ea1155d68f0b 100644
> >> --- a/include/net/sock.h
> >> +++ b/include/net/sock.h
> >> @@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct soc=
k *sk)
> >>         return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=
=3D IPPROTO_TCP;
> >>  }
> >>
> >> +static inline bool sk_is_unix(const struct sock *sk)
> >
> > Maybe sk_is_stream_unix() ?
> >
> =

> +1. I found it confusing as well.
> =

> [...]

OK will do v2 with sk_is_stream_unix() so it reads better. Thanks.=

