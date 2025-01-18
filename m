Return-Path: <bpf+bounces-49245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887DA15AFA
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 02:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92780188C17C
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB0138DE9;
	Sat, 18 Jan 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BueBHZxX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122117548;
	Sat, 18 Jan 2025 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737165576; cv=none; b=ULYIXPZlR6YdsY3xxfyDz24uXJnrS5LSUHYfbrADAgxtRwcx0ZyHKv9K3rGWS0ooCtLAmul3TBwddn9asQO91hjGtzL0ZtJTuZk/6gxUoEg2w4gyTpoiyr/uOgbFDOzvahyXDMEuElRu9OQgEroiLlifWkAMh4QFv9HSncrD8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737165576; c=relaxed/simple;
	bh=0UwZvfJSdF6Ig0l8rdWDJ7VgWP/I4E332SqjzZqxmlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdgAQzAOBtGSwDqoqmI6P6bjxBc+KBtud74Csj3De6AM2wbsnLXkmojIDofqmjJf6dpoGATwsgRFFJsGKLDF8jy4vs7rFk+n714b8NZz/EhO+orGIRfnjaFMlshHZ1QqZNDMxZsJUwv8Rba2m4OAdy+xHXhVj/M+WTaSLCY3NJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BueBHZxX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so14988239f.2;
        Fri, 17 Jan 2025 17:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737165573; x=1737770373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BxUJjIdeFI90yowVjPW9OroJnfxfZbFrGuqa1h50BY=;
        b=BueBHZxXFO/DqpSRIcTZNuSXT7oekQSFFpRGdckx7GeTUSLSiqAa1caQfaAQSxWZsL
         jJxaBV2EK+6NBaxntmBKc/VmvEXQSmlTbQKKMMVzNsvJmhVOzvSnMP2cQ8F+lojOhqgY
         /iHIKnRHM+y6noAA5y2Ph1ntw5P/23lL0UcN4ZF4Alic5A/89uv6ycXLXAggOb6/6mBE
         I1/NginZUgda5wlqIN7KzwtNBNF2/Eservi11/84qTkKnFxirZiPfIZVG6Wuzm170z6K
         7e8Iu2lAPhdphrFi5ct9m2SpeJls7zjRvH3O9O/GwyH4G48MFsbSIn+lv+jmp4zZH4+o
         VOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737165573; x=1737770373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BxUJjIdeFI90yowVjPW9OroJnfxfZbFrGuqa1h50BY=;
        b=rxY2guQ3zcGqKWopHjpSVVxmp4+erPk40Qn+O9403J8Qq9AH5jLFIm05+rGgufwDN/
         NkP5RgIchguj2oRU7Qz86409qj66aJIbGiTRw7KDVj7wAACDHkcgzEL3c6jHK5q7JLOF
         tiATcz589R2gO3+iEf0mL6amLm2oHqM7MPeyEnZNQW4Uzm1pWvODcwxChq5Wc0cDHD6B
         IafyBrPvb6CNV3iVpmZRxf8qyEXtiD8Jib/JsYcw0ENMst4QChkEzM0foNkh+JoYgImN
         DYixhI98mfjMj88jJr+iiTYDJUmEv7EOOrR0FRE6ceTVWyd/N10+LfZpUv+LWHovwq5m
         8CSA==
X-Forwarded-Encrypted: i=1; AJvYcCWi8gwIYzpL/mFXwst8qBHzuYIjxBYU+16m8+3pnpDRcpRAV6d4BMcGz7OPh+Q6ykctzGNUk902@vger.kernel.org, AJvYcCWksuayBmIPqkQT2YqUgnHcC7lO8qAmYco8Xdu4/PdhaT0VxKqq41WU7Nqv+wKDXBWSvJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+BGTxEWeLD1MVe7ec8Sn+0hFvQ/TsNU4dV8XfyWjo7g+CEX8
	12swx7RWcnFVVAqTDi7qyu6p5zhlveKZXwmq3AOrlueeD45Mqcms3RZEq4Atbw97YTJb1asJsrb
	XvkbuwmxwWZ6D+ictdkpDPwDcMfA=
X-Gm-Gg: ASbGnctUCBf+cISOmFJjaSeJ3HIZuVf2FByawm6aDG0aVic32njpc06MlIdZW6nTnVv
	wdGRrQxtrtQS+z8jcL5LBdlhh4eBOLUJ3Q/+4/FUYabK8CoPq9bw=
X-Google-Smtp-Source: AGHT+IGw4/21cm2RDhgPlKfCYBNhkkjsM5AJsfeObl10FugsSjY4xZhsiMiLR76iz9AnwnDPtN02PcjUGUx76CQycKQ=
X-Received: by 2002:a05:6e02:1c26:b0:3ce:7cca:db1b with SMTP id
 e9e14a558f8ab-3cf74416386mr41237835ab.12.1737165573087; Fri, 17 Jan 2025
 17:59:33 -0800 (PST)
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
 <41688754-20fc-4789-879f-60f763b3a9db@linux.dev>
In-Reply-To: <41688754-20fc-4789-879f-60f763b3a9db@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 18 Jan 2025 09:58:57 +0800
X-Gm-Features: AbW1kvb2cVDrr2uXIHJ7yFlvgiPdhQxupRoN2PWH-og0cr0Fk3kEfjicmR6N454
Message-ID: <CAL+tcoCpWs0f145_d+KLmAnuKhQ-83bANkiXXLHE_hoyhGj6Pw@mail.gmail.com>
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

On Sat, Jan 18, 2025 at 9:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/15/25 5:12 PM, Jason Xing wrote:
> >>> Also, I need to set allow_direct_access to one as long as there is
> >>> "sock_ops.is_fullsock =3D 1;" in the existing callbacks.
> >> Only set allow_direct_access when the sk is fullsock in the "existing"=
 sockops
> >> callback.
> > Only "existing"? Then how can the bpf program access those members of
> > the tcp socket structure in the current/new timestamping callbacks?
>
> There is at least one sk write:
>
>         case offsetof(struct bpf_sock_ops, sk_txhash):
>                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>                                          struct sock, type);
>
> afaict, the kernel always writes sk->sk_txhash with the sk lock held. The=
 new
> timestamping callbacks cannot write because it does not hold the lock.

Surely, I will handle the sk_txhash case as you suggested :)

> Otherwise, it needs another flag in bpf_sock_ops_kern to say read only or=
 not.
> imo, it is too complicated to be worth it.
>
> It is fine for the new timestamping callbacks not able to access the tcp_=
sock
> fields through the bpf_sock_ops. We are not losing anything. The accessib=
le

Oh, that was my concern.

> tcp_sock fields through the bpf_sock_ops is limited and the  bpf_sock_ops=
 api is
> pretty much frozen. The bpf prog should use the bpf_core_cast(skops->sk, =
struct
> tcp_sock). The future UDP timestamping support will likely need to use th=
e
> bpf_core_cast anyway because we are not extending "struct bpf_sock_ops" f=
or the
> udp_sock specific fields.

Thanks! Now I learned an interesting usage about bpf!

Thanks,
Jason

