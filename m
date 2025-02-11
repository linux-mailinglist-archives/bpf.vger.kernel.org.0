Return-Path: <bpf+bounces-51094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9CA3016F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AAF3A4D69
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF722318;
	Tue, 11 Feb 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO4tI0ad"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980026BD92;
	Tue, 11 Feb 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240733; cv=none; b=gltfhPuZ4qWO+GNmSmAVJ5aHJNALD9I+5votVwk7B89X6zASqalHvTsK67/a3Wi2hfMTBuIpQx4WvD5hZgrr0SI/wF9BKsIpJl8DTbHFuA8/byoS5i7ILDZDv0vRKm/dCHSMhVbu7SxAY7uF8ddZcJId0B5QHm4YNZW42T0Fw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240733; c=relaxed/simple;
	bh=keTYlBxqOYwHbGSIc1QuNfobWOPRvUUfpVGH7qDdrfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCy1kdPlLDYq52PnFdB6wuQ6Hz/efNuA6KgXmhB/WWYncax6xFjGeXwm1PZj2EkWT+qwohXSWCstUFV/pMgdrcapII6R/Z4OMJqH0zlVhGFqn5p+icK27UMR1yLGgqVAkzNPUZ4K1aRu4F4rJewrDIZjxMyfpTW6OY/khDehW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO4tI0ad; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-855418e04e7so27958839f.1;
        Mon, 10 Feb 2025 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739240731; x=1739845531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keTYlBxqOYwHbGSIc1QuNfobWOPRvUUfpVGH7qDdrfI=;
        b=kO4tI0adeMPFMlBTb6baGygirW2NhaeZz+ZT7pCzcuy7mABrYpqBRtoYPVaOZfCgLn
         AMeTjevlVdjKQtDEzij0//JMdfNHnTibeBTIpaLRXkHScnq9bFi8sCB2mNdrSA8luhmO
         8OK3ygHkUo3InwvxcrQJ5Ch1ZZH2jAbNuFPDjWyw1qcKhMavZhnc/eZGT22sDv59zU92
         D2FSZrK74ZClnEPFPPBUafhNI3Apb83T6JGS+3d83H9RdUYIRH5ac1W1N+83UpsyEuZU
         9XPbMqrXKbdWiwGlD0xKu9/ZOIh3/w8Y6SStWw7ktN7cIvLyzE4kR12peqnzeqc/WYNc
         XRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739240731; x=1739845531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keTYlBxqOYwHbGSIc1QuNfobWOPRvUUfpVGH7qDdrfI=;
        b=TDk+dvOBJWbh5We0bptWBxtxvrjm7DJiACuE/m21In1IQT2U3sKL5TtoKncOExrVMZ
         O1R6hDh9sPXqp/cgDyT5ye0gO/u7p8hQ9sI+7nom9zmhipF6IHd6L2oNU2wyDwyBIM9c
         llyHKi0mwrAyLAxRamSdWG66/xuqYE3l79hjOK5hfI90JyDsDt/y6/hRq7tgbMzUmbZS
         m1C1kLFnZMa5tTOtuYgIMnFmQdiQL39G9PFwQE156RYLxl0Z7CYGoABraojm3WXLGk16
         2DtPLpwaPsdfZIqqyPvhOT/u4UOgKv0/6N3yfe7jDFqFrIx7N/tztbQC8NvqC8tYOQCm
         6zrw==
X-Forwarded-Encrypted: i=1; AJvYcCUghGfmMX+CVGIe/Ik30x5GjHMh8KjVe0co/aydQcO6xksPwFkhlMOdxnOyzF/LhnZ3Bmbt/VA2@vger.kernel.org, AJvYcCWTpTBEdmDAHHUBTZwDAjstF12QKBPRf3xdofbMTPSNvccHFEE1f2NHVGUOOtG8qeW6gtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys18Joqa3xHz7gMQudquUHBAzLI1Dzjrd4tgnmJ9anw5zRjOSM
	1lruG+zZnF5iKN7wymBz8kvi7I33RW9i8SOhtcP8+ZSyn4ZX1ml83BMeYSotwianNzFTyD8Nubu
	Uu6ci9YZQWPN533U6WzMi0f/4pF7+izJzMxPxAg==
X-Gm-Gg: ASbGnctST7hBweiBizMOxg2481gC7dkJU5lPKQ5aMkOQ2Ur1LWur9Zzd9rC1afEnH6i
	Wb+Qez8gW/K6mNO0eFYZBLsNAn4DX25W+zPiDVjqFGtdyrN2DbpbJCwvtRRwtIk1Voy+d92cF
X-Google-Smtp-Source: AGHT+IGnYZhX/QpUADHSREEjyirFMgNE55Is1wlm7pINcbeqX7tzT9l07s/9lVEqyD+iQops/MbEjnZ0a4b1rF6q/tk=
X-Received: by 2002:a05:6e02:1c83:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3d13dd2c372mr115635795ab.1.1739240730859; Mon, 10 Feb 2025
 18:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-2-kerneljasonxing@gmail.com> <85d1b9e5-e1c4-452d-af50-e5c3784372ce@linux.dev>
In-Reply-To: <85d1b9e5-e1c4-452d-af50-e5c3784372ce@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 10:24:54 +0800
X-Gm-Features: AWEUYZn7p8YN6Q0wqEWrg98_41xnrepsitNFG2h3niGim3qXgDvsw6SOHbbUZFs
Message-ID: <CAL+tcoDESkWTnGV=mQwDd=8-RWK3gsYs7C+HoVSTs-+J1ChQAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/12] bpf: add support for bpf_setsockopt()
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

On Tue, Feb 11, 2025 at 9:03=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > Users can write the following code to enable the bpf extension:
> > int flags =3D SK_BPF_CB_TX_TIMESTAMPING;
> > int opts =3D SK_BPF_CB_FLAGS;
> > bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));
>
> The commit message should explain what is added/changed and why it is nee=
ded.
> The above only tells how it is used, and the subject "bpf: add support fo=
r
> bpf_setsockopt()" is unclear. Add what support? Also, both get- and
> set-sockopt() are changed.
>
> Subject: "bpf: Add networking timestamping support to bpf_get/setsockopt(=
)"
>
> What: The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are added=
 to
> bpf_get/setsockopt.
>
> Why: The later patch will implement the BPF networking timestamping. The =
BPF
> program will use bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPIN=
G) to
> enable the BPF networking timestamping on a socket.

Thanks. Learning a lot on how to write a good description, I will
adjust commit messages as you suggested.

Thanks,
Jason

