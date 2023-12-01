Return-Path: <bpf+bounces-16361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451F80074C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 10:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E40A1C20A10
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511481DDE0;
	Fri,  1 Dec 2023 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WJbwxA9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AC139
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 01:39:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00a9c6f283so266351966b.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701423551; x=1702028351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnFUtdIlVA2d9tBtQukci+iRJrwP/AAcyQDASJ91hoE=;
        b=WJbwxA9kuGtFoatgTd0wMQjlpE/H2K8s90pddAnKs2BLSHULxwoKs729i4kP0bF1lr
         jrc+F9l/+ZI/qedVAWKu8VKiMuzlVKo9ugH725e5UpjPUw8yxHpsZs8v6j0k+NAvKPwp
         hANHGX823UXrsDJL81/2fCO6ZK/v63Tc87k07nwI8+tyRZou7R1o8g4wFBOI4XbX1EV7
         0yfvzfFEgGckOpLvIRnyiOBS0nI7ovvKOITLnUN+ImA79qAa4TjGd8wFjiGVT4HQza8q
         qrkRVZ2a9b2hPjH/6+budsYQLyB+B2kbo3jX+yldhnWke+Q7mTN2fJ+/YnQInm0Ipzhr
         3c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423551; x=1702028351;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnFUtdIlVA2d9tBtQukci+iRJrwP/AAcyQDASJ91hoE=;
        b=F5dHxgYfG5wXhp0KNCTHhqD72qJEl/jWMLY9jCyTrqMBzVSwXpDXlLQ2csoBLOSPgm
         7SjIPd1Z4TKLQkMVUFQ7mIzZxlwxqnWJyRcvraSYl4rRErmyYT9QMmInsF6/frukPAm6
         tncWqW/pFtkLDqjULpOvSQrB0dZPZXMql+d5OdiG6Kg5Erdnrx3nM54oCGfXj6CD9KZb
         4Y63YJR2LNmgygn2XzNcWIoBUXYw0f/ntnWyHN72BqCi202r1a5O4uDqke1lgBqJtLUo
         060X/aw65ZlpUw0CXiIIef2d34yP9bFermcPqDOgu6cvVoqKyuXC9xWI2HNVfasUf/nq
         ZOIg==
X-Gm-Message-State: AOJu0YxAM0HC24uPdbjv9r1TwbnQeBuTgQg+LU5cbphuuEubWPlwRT3H
	IxEuEHFGEjGSETatKqFm2/jG7aoWBA4k8T9hQ5R1fA==
X-Google-Smtp-Source: AGHT+IFh4SRWbrGt/QYaqztQ2PCTlQT+mzzgDginVCRhKBzxaJDHVJG03TQYHdbTTerjGqsXiumyDQ==
X-Received: by 2002:a17:906:44:b0:a01:bc90:736d with SMTP id 4-20020a170906004400b00a01bc90736dmr1226431ejg.40.1701423551382;
        Fri, 01 Dec 2023 01:39:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506e:2dc::49:54])
        by smtp.gmail.com with ESMTPSA id fw5-20020a170906c94500b00a1a26260b15sm340711ejb.13.2023.12.01.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:39:10 -0800 (PST)
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-2-john.fastabend@gmail.com>
 <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>
Cc: kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: syzkaller found null ptr deref in unix_bpf
 proto add
Date: Fri, 01 Dec 2023 10:35:48 +0100
In-reply-to: <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
Message-ID: <87il5i2req.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 10:24 AM +01, Eric Dumazet wrote:
> On Fri, Dec 1, 2023 at 4:23=E2=80=AFAM John Fastabend <john.fastabend@gma=
il.com> wrote:

[...]

>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 1d6931caf0c3..ea1155d68f0b 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct sock *s=
k)
>>         return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=3D =
IPPROTO_TCP;
>>  }
>>
>> +static inline bool sk_is_unix(const struct sock *sk)
>
> Maybe sk_is_stream_unix() ?
>

+1. I found it confusing as well.

[...]

