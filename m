Return-Path: <bpf+bounces-46964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71E9F1B2C
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329ED16B4A8
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195F1F12E3;
	Fri, 13 Dec 2024 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihbfMvsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F911F03CE;
	Fri, 13 Dec 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134245; cv=none; b=elJu0mtEzM6Mjw8IzjCR5JKlpQxzuhp8EgCkoL1uKx0lwbOR9JBo+JDnVSVY/OrERaa78m5cuGUGDdhXd8Fj7bfC8FWe7re7iZ+cGZSjgQPXWi0FYDpxGRw29GIEb0RNdlIYZYkR+EZ6wVrUglW6liPYogY562sfAUiPNYVeWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134245; c=relaxed/simple;
	bh=+cYwKDRd1fNSYotDWngbQ+3V+4w8Bafou8uCHEvJfKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZDUAY40bOMsCfWYeujRs6wY+kcHRrT8BUhfyrvhJ+ki2DoFDPu9pL2m4DO7WGWPhMP4Qv717EKuUoIBP+Zq/yKMq30pAhSqVSZriqHT9JG0wZPGf4iYNi4JR2sbxFOh4p9d7w7Ok7ThN3AbrEIk5ScXA8mCzQHGMt1dShmqae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihbfMvsT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so98761939f.0;
        Fri, 13 Dec 2024 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734134243; x=1734739043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cYwKDRd1fNSYotDWngbQ+3V+4w8Bafou8uCHEvJfKQ=;
        b=ihbfMvsT50cZy9umfqfc7nkG9a3iKU75DEDwzsVp5rbNOSKpTBbqXILr99uU19VxtD
         V9xTSf2nIHU5IvUhj2YFiGVIfzJPz0oBB2I01t3ILX/kEdHOVB8wXPyKQmeTAqUFJWK6
         1g4cY2kgSarrrBjJxn/6DcwVHuC7XjcWcK48e/oBR8OVlcnQC3k/c+dS2w33RX5GH60E
         yX4s6jH63TnNbl77OuOCvWt2J3J/RVz+Y2w2CKhkAbNMMdYo+Vs0ZGwLj9urjWoBTNc4
         cChwapSTGViKjnsbuatHqe4ip49ORiA6Boz5lJI/J+//c6fUK/EjnxRzw3S30dcYaetR
         2nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734134243; x=1734739043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cYwKDRd1fNSYotDWngbQ+3V+4w8Bafou8uCHEvJfKQ=;
        b=LhPEPyQocMT3BAq1NNAryPmNwYEpbTWHV7LSw9cw+JHv+icCHNpT0J1iM5OuXkfLoK
         jVV2TioxBZvM1NmvSbqI0E+HBf4UzwbCn2vk2BOMkix8u6BV+A9psohDUgxVGqItz4Dd
         MZpUqJ+W3Lg4bHU122lN++9jQ+n9hNBxOTLSQjXNUrbj425SYKQjCwEnb3Rs2si6wV0H
         NflE6pA/w1zwV5/oCFdfa22hZZu8bQNhqXSROt0DzCf4+KvP4aLnlqRfW0MQX+ZFHmhR
         A3MZliu2WwL3Jjy069rutzuPOFm+PV02V+1fB6RhMCvcqpgXHBuOQywNnF3kEbifcO3G
         bD1A==
X-Forwarded-Encrypted: i=1; AJvYcCVNpQxDSailXBFKRm+L1ZQIUozhPRqHbLnqjDOsRhIKEqoJEtDjeVbqo9DTQuum5+LwadI=@vger.kernel.org, AJvYcCXbrLxwH6vEPX95HcLkbSy7CVj7sQrVBtmJnyl9Xj4tKz6VSaMbO+x5/d5Pqd9/KKVqDATtIqFx@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3pGnPFHm76AzsaLGJ7Q4ZZW0sZkb2nAflXXVzyfxB5eoZ4H2
	dKiHz3AL0aF3IEAVeoYQeZ3rsbER+v+hWfbLfGdmpDBSLGisuGy2yYxHV33tL/Gg48Yx7/F73kR
	Gpj+QEYwcMm9jFBmFmpvMSIDBrenUIP57
X-Gm-Gg: ASbGncuFAriXboDG1C6RsdFcEL1VvuZIsL4klO9V8gPfE/qSY0xGWNPZbsBstjGjsWk
	O60shXc9I8cf4XKoVtCYwmLBiiaMe9jQuoFx3
X-Google-Smtp-Source: AGHT+IEgefJlfBI5ZIYnLn4EZ3LxcRmFlqOreLcDE1TCcJ3KIjGh9lEUw7ZdJD5491xKgHICfktUqsfQYkLzGGmrb+s=
X-Received: by 2002:a05:6e02:1846:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3afeee7924emr59617705ab.13.1734134243128; Fri, 13 Dec 2024
 15:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-3-kerneljasonxing@gmail.com> <f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.dev>
 <CAL+tcoDGq8Jih9vwsz=-O8byC1S0R1uojShMvUiTZKQvMDnfTQ@mail.gmail.com>
 <996cbe46-e2cd-44b6-a53a-13fd6ebfc4c0@linux.dev> <CAL+tcoAxmHj9_d5PUqvSHswavKFspd_D5tOt81fon-UtEf_OMA@mail.gmail.com>
 <c1701350-236d-4a9e-9c53-4badc0738309@linux.dev>
In-Reply-To: <c1701350-236d-4a9e-9c53-4badc0738309@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 14 Dec 2024 07:56:46 +0800
Message-ID: <CAL+tcoC+cw9MdU089C-dt=E6gLuv720DS3mCcp2RNWH45RjfWA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/11] net-timestamp: prepare for bpf prog use
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

On Sat, Dec 14, 2024 at 6:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/13/24 6:42 AM, Jason Xing wrote:
> >>>> I just noticed a trickier one, sockops bpf prog can write to sk->sk_=
txhash. The
> >>>> same should go for reading from sk. Also, sockops prog assumes a ful=
lsock sk is
> >>>> a tcp_sock which also won't work for the udp case. A quick thought i=
s to do
> >>>> something similar to is_fullsock. May be repurpose the is_fullsock s=
omehow or a
> >>>> new u8 is needed. Take a look at SOCK_OPS_{GET,SET}_FIELD. It avoids
> >>>> writing/reading the sk when is_fullsock is false.
>
> May be this message buried in the earlier reply or some piece was not cle=
ar, so
> worth to highlight here.
>
> Take a look at how is_fullsock is used in SOCK_OPS_{GET,SET}_FIELD. I thi=
nk a
> similar idea can be borrowed here.
>
> >>>
> >>> Do you mean that if we introduce a new field, then bpf prog can
> >>> read/write the socket?
> >>
> >> The same goes for writing the sk, e.g. writing the sk->sk_txhash. It n=
eeds the
> >> sk_lock held. Reading may be ok-ish. The bpf prog can read it anyway b=
y
> >> bpf_probe_read...etc.
> >>
> >> When adding udp timestamp callback later, it needs to stop reading the=
 tcp_sock
> >> through skops from the udp callback for sure. Do take a look at
> >> SOCK_OPS_GET_TCP_SOCK_FIELD. I think we need to ensure the udp timesta=
mp
> >> callback won't break here before moving forward.
> >
> > Agreed. Removing the "sock_ops.sk =3D sk;" is simple, but I still want
> > the bpf prog to be able to read some fields from the socket under
> > those new callbacks.
>
> No need to remove "sock_ops.sk =3D sk;". Try to borrow the is_fullsock id=
ea.
>
> Overall, the new timestamp callback breaks assumptions like, sk_lock is h=
eld and
> is_fullsock must be a tcp_sock. This needs to be audited. In particular, =
please
> check sock_ops_func_proto() for all accessible bpf helpers. Also check th=
e
> sock_ops_is_valid_access() and sock_ops_convert_ctx_access() for directly
> accessible fields without the helpers. In particular, the BPF_WRITE (able=
)
> fields and the tcp_sock fields.

Thanks for the valuable information. I will dig into them.

