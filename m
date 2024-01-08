Return-Path: <bpf+bounces-19205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E98278E7
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3D9B22DC8
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE25576E;
	Mon,  8 Jan 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSo2mpoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09654F9B
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so2289908e87.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704744317; x=1705349117; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iVa8BPCe8azlxmuFHOfaW/NuhOD3RDmXpfBDHnE7StE=;
        b=KSo2mpoU1b1Ui9cHaQWGRKtEI30c0QVjf4ExnPui1its6QgJfm9P0g4WH3lgillB/7
         JMFotGSbXHh1TXtPlhy+U4IokbaSnZv3QzL82c9B8vxRlApgI9/mbyCaBXHoPwCUqdZl
         sOy/OStNyEFW0J6vIk9bTtkezyW9B6BMc4vsvbst3em/BeDONJGayBAQEkcS8hN82koh
         SgX2OQZYUkhlnnTHnGAQXQWqc1Y+2yLgOocs9K/Xa+Vi9/TBAxkwJ1MbfXgKEHfBpd9D
         fermnCJcZ81cqWIAu10jjpo/F/78Bb+5RrqyxYsyMCeDbqMiO7rWmmsnWTjkJ2vCyLXF
         BGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744317; x=1705349117;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVa8BPCe8azlxmuFHOfaW/NuhOD3RDmXpfBDHnE7StE=;
        b=sTljC9zXVyjRg5hrtD0tIRIFxLSkWOjdNloGfZkODyQtuJAY5zTBr/fYqGtcY1obfx
         wvli+NjRwcQLkf6S4ifEhPDzvivA9poZlnrqTDGuMBbrC29UJfflNhE8falEIQ/i9Fp0
         jBOcdUDCxFVPFcfuvpR37dSHX9udsOVbIAufYaCr3r5eZvoW5aBpJ44VlRBbjSVR+6bl
         nkMNxDMNxlsqiOd6ykqf3ZnpbRjQ//sWclFUT9hSTfAUns8cpCi9icerWqZv275PKYBE
         f7ZhdI5SL+KyzC/9kkR8mr12RtzDihCmq309Pni2dSqjYYbC9iE/6MRPROWcQAutL76a
         ohnQ==
X-Gm-Message-State: AOJu0YxuUpfllFQ566ywtZBNBF3rmjRvLQAxYilWDdN66vk8t2M+NCtX
	KReXVnBh5g7EgyVnrzDOYgg=
X-Google-Smtp-Source: AGHT+IFjE+elOg6bUv6Nj6IceSkVDU5Pan2/vulb0+W6gkjRRHhByptSLM/IZMinyIjPrzPh1PKLKw==
X-Received: by 2002:a05:6512:11f2:b0:50e:7fd9:9 with SMTP id p18-20020a05651211f200b0050e7fd90009mr1547922lfs.44.1704744317040;
        Mon, 08 Jan 2024 12:05:17 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w5-20020a056512098500b0050eae31c990sm61375lft.147.2024.01.08.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:05:16 -0800 (PST)
Message-ID: <60cd23a09c8fe6ea45af151b6e806e456a0b120c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Mon, 08 Jan 2024 22:05:15 +0200
In-Reply-To: <60c5be25-5c35-4e47-948b-66cc8b1b4feb@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
	 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
	 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
	 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
	 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
	 <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
	 <60c5be25-5c35-4e47-948b-66cc8b1b4feb@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 11:51 -0800, Yonghong Song wrote:
[...]
> > In case if check_stack_read_var_off() would be modified to check not
> > only for STACK_ZERO, but also for zero spills, I think that all such
> > spills would have to be marked precise at the time of read,
> > as backtracking would not be able to find those later.
>=20
> I don't understand the above. If the code pattern looks like
>    r1 =3D ...; /* r1 range [-32, -16);
>    *(u8 *)(r10 + r1) =3D r2;
>    ...
>    r3 =3D *(u8 *)(r10 + r1);
>    r3 needs to be marked as precise.
>=20
> Conservatively marking r2 in '*(u8 *)(r10 + r1) =3D r2' as precise
> should be the correct way to do.
>=20
> Or you are thinking even more complex code pattern like
>    *(u64 *)(r10 - 32) =3D r4;
>    *(u64 *)(r10 - 24) =3D r5;
>    ...
>    r1 =3D ...; /* r1 range [-32, -16) */
>    r3 =3D *(u8 *)(r10 + r1);
>    r3 needs to be marked as precise.
>=20
> In this case, we should proactively mark r4 and r5 as precise.
> But currently we did not do it, right?

Yes, I'm thinking about the latter scenario.
There would be zero spills for fp-32 and fp-24.
If check_stack_read_var_off() is modified to handle zero spills,
then it would conclude that r3 is zero.
But if r3 is later marked precise, there would be no info for
backtracking to mark fp-32, fp-24, r4, r5 as precise:
- either backtracking info would have to be supplemented with a list
  of stack locations that were spilled zeros at time of
  check_stack_read_var_off();
- or check_stack_read_var_off() would need to conservatively mark
  all spilled zeros as precise.

Nothing like that is needed now, because check_stack_read_var_off()
would return unbound scalar for r3 upon seeing zero spill.

> I think this later case is a very unlikely case.

But it is possible and verifier has to be conservative.

