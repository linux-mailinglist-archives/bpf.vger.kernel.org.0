Return-Path: <bpf+bounces-43498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D29B5C11
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 07:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F841F22338
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 06:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0F1DA617;
	Wed, 30 Oct 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udwh8VJB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD41D515C;
	Wed, 30 Oct 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271300; cv=none; b=leM1W2io3dI0bI2thsqC4DtrTwZ+JyCYj9GRvw8evc7/DYc1cm9avT7c5OnADXRG+Mtjoo7bd0SA5v/Uk/W89MqwjPQ+y1J6giqc4CQB2JeEoovIr14sajWobbQWjnlLcZ/7o3FOfJS6ZdIij2MIYi3ypI8PTbFPyPUXQWOiP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271300; c=relaxed/simple;
	bh=BKKz/icmQ82AYruwgF3/yFljISwH2oNnOSVeJxPnyGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky/876D12M+XC4Kj+TyKfma1CGxtMnxkizxLLbXZjmxbMMAWNp2B8b/GCcFrE8iwOYa1VgCuPp5aM5IQwOcIP/jb4PZ25XAmt/CGjH0LlMDQGrXgfupxJrWxKqElyf5g2SP05VFefKZ+exNlScE45O8NLAt2d22IljBKIhyw990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udwh8VJB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so755556466b.2;
        Tue, 29 Oct 2024 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730271296; x=1730876096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKKz/icmQ82AYruwgF3/yFljISwH2oNnOSVeJxPnyGM=;
        b=Udwh8VJB2shLabI64WU6/Pmsa2ROqudHVuCFgVuZxXDWUfcB1nNaihwcn3tZmpp776
         JyPEUHZBfiqhCwzXmoPJpp/hAmrCYZEILi6/cfIR4I4BnlbjklyYdf8qyjhCPI2hvp/3
         ErIGgC79t4PL/4r25ZsfRKlup0CU2ON8CFQ+YqzbUy1TJjtmew4cdfBckAummuB7Jgnz
         1PO4MkrHsm1654i89C9mFbW2VabwEm/xUjuY3mD85RUmZKOSMlKRgt4cc8dDC/WQJtin
         v1Iv6SfP2yfKZCrfOzEel3gFfi52ppVC48CzJy6U2PN75HkZYBQFL2328c8gX3xPhW5g
         4edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730271296; x=1730876096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKKz/icmQ82AYruwgF3/yFljISwH2oNnOSVeJxPnyGM=;
        b=bxMI06B6WW8z43FMG3t6+qwU5bR+i0XMIfYjOI8oX+olrmCjkZGQN0ec0FdEKWZ7vy
         M9yp83YdmzRXW0T914KEID3FfqeCKK5ZH62w7XcRuKinO7B4lyq/FKZ+OvSSulHIHq1U
         fWj1MgOV7hzcx9asM4/UIb1jvBIJsXmrDf/hzIuRG+VfAAiVbcUiOMM9i2CZzRxQQabv
         oA/Aa6UHpL8vlR3Ly9eXRRB1Vm6V1okeoWLO6Ru9XlC1JeGZ7766AFUF382EuqmR1FcH
         bfguZyGG6Gf5G+QRdiJhqsE7pKqJnq64BFMM48fZpDjxYT5D+zP0p0O6FKPEGUc8myXq
         4t/w==
X-Forwarded-Encrypted: i=1; AJvYcCVuTkxr9enabwEiumaBvkkOOzG7quieiQ22cUw9EhoomTr5wtmOxEBU2KpWOXOlfbSpOIo=@vger.kernel.org, AJvYcCWoO9qtUzCAh7ixSmJ5HexskDZvFaiHZm++AtNbVGnlLmaT63M5Pt5DcS99E3tYQrxS94cmUouZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IYevM8bkrVcrycqME9vDdTl56ieKAwhdOngZfU2Atm29IvRV
	byHoI0+pNmBUHzK6KsAjPLjIC8gbWlnBFJWAhO/azDiAUwSEADaSe9fVSTkH3203BGsGDWp964z
	VsOoGL4iAAPRwzPu6QXzF+SlUgkE=
X-Google-Smtp-Source: AGHT+IEctoS15MbRJ/OkILHRla6GJXmTmMo9ctvBZT15TX9hg7dEejt1STvhf5Gp//dWREX3fH94QrccwCZmz4xuCyc=
X-Received: by 2002:a17:907:1c9d:b0:a9a:5b8d:68ad with SMTP id
 a640c23a62f3a-a9de615abc0mr1431826366b.48.1730271296157; Tue, 29 Oct 2024
 23:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-15-kerneljasonxing@gmail.com> <d443142f-c7a1-46f8-8c8f-ee0172e10bdf@linux.dev>
In-Reply-To: <d443142f-c7a1-46f8-8c8f-ee0172e10bdf@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 14:54:17 +0800
Message-ID: <CAL+tcoBQ4MGKOhBh=Y1bAwvW02pLj63Dj2J4anGEW0H=W7if_g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:58=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/28/24 4:05 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only check if we pass those three key points after we enable the
> > bpf extension for so_timestamping. During each point, we can choose
> > whether to print the current timestamp.
>
> The bpf prog usually does more than just print. The bpf prog aggregates d=
ata
> first before sending all raw data to the user space.
>
> The selftests will be more useful for the reviewer and the future user if=
 it can
> at least show how it can calculate the tx delay between [sendmsg, SCHED],
> [SCHED, SND], [SND, ACK].

Got it, I will dig into how to implement it and then post a new
version. Before this, I only used the bpf program to print timestamps
to one file without using those advanced functions (like aggregating
data) in bpf. Let me try :) If you know some good examples of this,
please show me :) Thanks in advance.

Thanks,
Jason

