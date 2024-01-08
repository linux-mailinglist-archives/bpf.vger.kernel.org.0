Return-Path: <bpf+bounces-19202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42F82781A
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2EB223B6
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A154F80;
	Mon,  8 Jan 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi7rmwnU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BB54F85
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso24970671fa.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704740773; x=1705345573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yA98EXpk94yYU68L5L4aM9oaAwCh5FYqhBcCy9p2l2g=;
        b=Fi7rmwnUGIM41XP65IV34FziZhG6ygnw5MkM585p54uBDPrMpQj5K2TTmGhNGf3wHw
         ekOMShIDsKWAxVqu3+ACudT6///d+wm88rxxMWIfNI+Gy/VN/2NhdzOofACPGXbZPPTg
         RdQf7l85NJMx5DuNa8T9G3zI2DuJtcz8DatqS1iM4qdfZpIaLGSJnA8D1vgRpYPAMyRQ
         +HEy0wwmvBQirIUR0Oud7TNyQarTZHUk5ZCh8JFdZ1Gn+xygCCDgtOX0hqYVpz58PMiO
         MGKscYKd/YhiEbsSiaBgYahEnPId6E0MaiokAZUZqV2MyQj+0iuY76F25w3BOVWJGs5r
         lIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704740773; x=1705345573;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA98EXpk94yYU68L5L4aM9oaAwCh5FYqhBcCy9p2l2g=;
        b=Ieo0TOa583oww4GMDDTxEC6v+++BKGokN6/N7hXKPVchasNueC5aOcXP8q6HO86W32
         R4qdphBh6ziZzlagbxmIolXBJqDr7ZLloWI6bctSQhl6MJhY6emeFz/WTDZoEJbaGUZO
         tvYyhrxEI2T7SIcK2ZUbDlRMiXAZ40CwzJNZSP9GMV517hG9+srStJ/e9dqrrlDsiuuQ
         zu3kkJF012GiyinnkMaUx7MZOOCv1Idr0Oj9hDtWNPpJz8Ut+WhfUYfwjOljhrxsqYaL
         w8wjY/YmmHVXUgLoi6RXIiEaddQWPaKjxqIMfYQkK7NWWQCAM9ZOY1LGFSYA19i2P9Ct
         cxXw==
X-Gm-Message-State: AOJu0YwodFEkbRSfceBZoAULY/MTdsm5hnsX2vq7t9TMhF69NOCNW5Q/
	fc0ImOg0HSgd9bRdpd4EWIk=
X-Google-Smtp-Source: AGHT+IFRqg4NpvptT0DGXPgsSsVEonyCXqRQ3U1Pm57OhyKvHVTLbp6yCDIo3tKQpKdUHenqgw0xcQ==
X-Received: by 2002:a05:651c:1688:b0:2cc:8bd4:b860 with SMTP id bd8-20020a05651c168800b002cc8bd4b860mr1745703ljb.85.1704740772666;
        Mon, 08 Jan 2024 11:06:12 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a2e7c0e000000b002ca092c194asm68612ljc.13.2024.01.08.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:06:12 -0800 (PST)
Message-ID: <ec2758667b5a286dd48ebaaa8cfafa1112699735.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Mon, 08 Jan 2024 21:06:10 +0200
In-Reply-To: <07d7d6e0-d090-47e6-9f17-0b083aeaa7af@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
	 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
	 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
	 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
	 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
	 <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
	 <5e31a6835b648fae9880f6bfbc40801539b2d143.camel@gmail.com>
	 <07d7d6e0-d090-47e6-9f17-0b083aeaa7af@linux.dev>
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

On Mon, 2024-01-08 at 10:59 -0800, Yonghong Song wrote:
[...]

> I guess one way could be doing backtracking with "... =3D arr[i]"
> is to have four ranges, [-32, -24), [-24, -16), [-16, -8), [-8, 0).
> Later, when we see arr[i] =3D r0 and i has range [-32, 0). Since it cover=
s [-32, -24), etc.,
> precision marking can proceed with 'r0'. But I guess this can potentially
> increase verifier backtracking states a lot and is not scalable. Conserva=
tively
> doing precision marking with 'r0' (in arr[i] =3D r0) is a better idea.

In theory it should be possible to collapse this range to min/max pair.
But it is a complication, and I'd say it shouldn't be implemented
unless we have evidence that it significantly improves verification
performance.

>=20
> Andrii has similar comments in
>    https://lore.kernel.org/bpf/CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BL=
R3iG-te-g@mail.gmail.com/
>=20


