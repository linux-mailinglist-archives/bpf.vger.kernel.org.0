Return-Path: <bpf+bounces-22155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516BF857F5D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7CB1F23AEA
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E112CDBD;
	Fri, 16 Feb 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVDT0Us2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6B12C7FB
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093669; cv=none; b=n3uQJRzBUaLSjGVPmD1DdhEQe/UQABrZ6i2LlKBB84cyDJtzIxt6fHzhzFvWQAP5ODPTLYcNDKHp4oUAzUkcwUdO1c6+DO8r1V7hzSqTw3MNWsi2dpKdfbACY9Ac5E4DAxrQiqAgD6luzOoG6X+jNVqflLyTatf0VXwv3xgUlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093669; c=relaxed/simple;
	bh=0bh+U/Rs8uaW1sGTDmW9fW8x0/eJYW0QTrXwSWwvZds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dkpt/m8jipzSs9WWnrG3eO8zwtGc/Hrmh7nKZf+m4dGfdavSuRWkDzgIrRsKG7ib1v2nn92oTpUtXwLwzLh/G8Bpoo94tm0SK/8kg40CKgNnnlmCU1vaBc7DbpJUmJttoqIXgrgCklQ7saqvpt/aXvi9KIE6JwScOVO7WJEbjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVDT0Us2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso212653366b.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 06:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708093666; x=1708698466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p/Y6Jl6GXn71nqLWqdCp34ZSufuoTM7qP2m6Dt8vC5w=;
        b=EVDT0Us2R4lVh9CVDGr7WED/JeE41+6p7p9X+BJt5zkFeAbudr/4gVAL0YrgAgGaqn
         LaVpx6y4COpmPqyahji52/ZTkl7Py2JduIYr7qsWdBPiIPmNFXMpQSWz8msvWX4z4aJe
         O2POpDctHjRsCwDE9V+Xo9Z4Ggn0WeMBONloeZsyOfLISbCrC1q1fV6hQ2kZRcGvV3Jd
         TzCmpN5qbD99ORuC+CDcRtkYQxVC8+DIryeHFJ6iObglc+EsmYiPPH4TAKr7/nTi5l5S
         AnU2/Ao8CP/YsWqrlVa7IO0yXr6JKeZF1rzCNQRKYKwoPu9Do8/9U5Dj60ppUoxBZiJr
         sJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093666; x=1708698466;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/Y6Jl6GXn71nqLWqdCp34ZSufuoTM7qP2m6Dt8vC5w=;
        b=YM1QPiM60K9CgmV+HMjIoEYHTDg0kDKTJUgVVJsyXEo4sdRdhhgdDGnmayesRlHa3/
         5qQVoPQ/4F6u8pIqJo1j/ouIzg5ZsIG9qNgITqSuP1JXggI1i6XyhkcCpp5UEx/bedV6
         FPevth33F1GHoA+1UTNTDXZqBL6jS3T/whgUb94aBiG7SgvQhVbiOLXQQUwyHx7jfvYm
         +6QWNik/Y0l4nzzGx8Q+/CVopaFd1dKi+MN5Fc5FuMSmryVj3RgmPXC/66nIcSO9rnGE
         dF+Z8531m1p5JBnQqK7zwB1HIs6sT2Bwy4KhW3D2aWc2HDNTP0NQvzXogs6ef4pVAlqd
         pnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvm2ZrW2f6AaTE0K8XSXSGWCc29toOZgGQGYfXxkdu4QdryJ3/L0RtxLcyiXbEU/dUWdT/cBksUbqhUjFGaW3zGykV
X-Gm-Message-State: AOJu0Yy+RAPO12vB7bQ1GFvTN3KxtODhPJCekpSpFP5kSBle8jtIVrdK
	Go2KHa+MCWgQwVZ3vtnCyE0qR4NG1yJkANkqy+vV3gdWS4VnS/cw
X-Google-Smtp-Source: AGHT+IEA8XXdY/I6UcxhaWVB5xj0pnAZnEi86+/e/I5S55PPsQMdShl2Ga28ArFyUxjsWHMwZ0fb5g==
X-Received: by 2002:a17:906:6bcc:b0:a3d:f81a:d50b with SMTP id t12-20020a1709066bcc00b00a3df81ad50bmr587479ejs.70.1708093665837;
        Fri, 16 Feb 2024 06:27:45 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id uz16-20020a170907119000b00a3d2ccea999sm1601095ejb.35.2024.02.16.06.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:27:45 -0800 (PST)
Message-ID: <9e19786565a3fbfea58dcd25bba644fe8e0ed6b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: check bpf_func_state->callback_depth
 when pruning states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, kuniyu@amazon.com
Date: Fri, 16 Feb 2024 16:27:44 +0200
In-Reply-To: <1fbcd9f1-6c83-4430-b797-a92285d1d151@linux.dev>
References: <20240212143832.28838-1-eddyz87@gmail.com>
	 <20240212143832.28838-3-eddyz87@gmail.com>
	 <fdf38873-a1e2-4a16-974b-ea2f265e08e1@linux.dev>
	 <925915504557d991bf9b576a362e0ef4a8953795.camel@gmail.com>
	 <0e5b990eeaa63590e067c8ac10642b6bc6d0e9a8.camel@gmail.com>
	 <1fbcd9f1-6c83-4430-b797-a92285d1d151@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 09:42 -0800, Yonghong Song wrote:

> >   .------------------------------------- Checkpoint / State name
> >   |    .-------------------------------- Code point number
> >   |    |   .---------------------------- Stack state {ctx.a,ctx.b,ctx.c=
}
> >   |    |   |        .------------------- Callback depth in frame #0
> >   v    v   v        v
> > 1  - (0) {7P,7P,7},depth=3D0
> > 2    - (3) {7P,7P,7},depth=3D1
> > 3      - (0) {7P,7P,42},depth=3D1
> > (a)      - (3) {7P,7,42},depth=3D2
> > 4          - (0) {7P,7,42},depth=3D2      loop terminates because of de=
pth limit
> > 5            - (4) {7P,7,42},depth=3D0    predicted false, ctx.a marked=
 precise
> > 6            - (6) exit
> > 7        - (2) {7P,7,42},depth=3D2
> > 8          - (0) {7P,42,42},depth=3D2     loop terminates because of de=
pth limit
> > 9            - (4) {7P,42,42},depth=3D0   predicted false, ctx.a marked=
 precise
> > 10           - (6) exit
> > (b)      - (1) {7P,7P,42},depth=3D2
> > 11         - (0) {42P,7P,42},depth=3D2    loop terminates because of de=
pth limit
> > 12           - (4) {42P,7P,42},depth=3D0  predicted false, ctx.{a,b} ma=
rked precise
> > 13           - (6) exit
> > 14   - (2) {7P,7,7},depth=3D1
> > 15     - (0) {7P,42,7},depth=3D1          considered safe, pruned using=
 checkpoint (a)
> > (c)  - (1) {7P,7P,7},depth=3D1            considered safe, pruned using=
 checkpoint (b)
>=20
> For the above line
>     (c)  - (1) {7P,7P,7},depth=3D1            considered safe, pruned usi=
ng checkpoint (b)
> I would change to
>     (c)  - (1) {7P,7P,7},depth=3D1
>            - (0) {42P, 7P, 7},depth =3D 1     considered safe, pruned usi=
ng checkpoint (11)

At that point:
- there is a checkpoint at (1) with state {7P,7P,42}
- verifier is at (1) in state {7,7,7}
Thus, verifier won't proceed to (0) because {7,7,7} is states_equal to {7P,=
7P,42}.

> For
> 14   - (2) {7P,7,7},depth=3D1
> 15     - (0) {7P,42,7},depth=3D1          considered safe, pruned using c=
heckpoint (a)
> I suspect for line 15, the pruning uses checking point at line (8).

Right, because checkpoints for a particular insn form a stack. My bad.

> Other than the above, the diagram LGTM.

Thank you for the feedback, I'll post v2 shortly.

