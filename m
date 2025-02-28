Return-Path: <bpf+bounces-52940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6791FA4A6C0
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4F33BC08C
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF61DF74C;
	Fri, 28 Feb 2025 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0vrA/Wj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9CE1CD205
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787074; cv=none; b=GKH1UV7fh2GqNBjyUQHF7nLncf8Z5pmUcRR8v1AsXXFAUhCL3LyvA0E5X6w7a0+FRjVDbdVGuFSqKG2ORvkL5pW7nx9ZhZ0ie+A/O/IqM5QPpW/l0FvPAFvJXmzzueR6j3A6vO2p367Ix9mSoH3U8n3/rovoUpVfjS4UUCY3BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787074; c=relaxed/simple;
	bh=AaVeAR2RA0eLDaiSSSPM36lkug9/pw3aFYocZaMfu4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKu/GAJQdcFRboXSaBMM5A/ULYGpDpq1/aRnL7SKKtTSYALfvKg9v5FZOFGvFMLqzLZ4SstmrKjRklW5Bo/y7JXT2tdcIsXktzP1Aiat/F2dpyqzjMVWG6lcDhJMjMX8UNAFHXKkXZN0ZdrbbRjCBILW3SRBgezo7TOgakQPuGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0vrA/Wj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2230c74c8b6so6485925ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740787072; x=1741391872; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ZU2130ltJSlUEKgYE5YIeDNHrUKscV6vQV2xS7l7fk=;
        b=g0vrA/WjdBxtBrOGSBGYvgfDruX2IU1P6/58RMVT1Kc+/BWvXzdcG27KJcc7I4InCT
         x6Z1vpcBBpbxOL2XTvdylOdZ87nfmnP4JcXgTQHt9hkVsrdyLTZPIJiLnGm2dAfzCMPk
         ISD9VHch2BOEHvx9fb1JEbJzyb9Q8j0jfSHSiFPf83E7BZx6zWzfwaAlkC7Cp6/KqS+F
         VttUhKw2AyNvB8FbQR1VSsmBPbzI/KhZL/RmsNUDbYg5maxw83QpGIeo4O5ae86KiGCa
         x/Ozvp4fwQgOkVHEYOBSZYuJ8FQxkPd4cTTxIL2/OQTPxKbjN9lnaONYKRk9PNf7bOtd
         jg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787072; x=1741391872;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZU2130ltJSlUEKgYE5YIeDNHrUKscV6vQV2xS7l7fk=;
        b=RR5kOZ6wHgGpG9XMNO5mbsHrYnKeTqpxXRqy49q0doAdbovWYt7O0uYJVt7BzeQl5H
         ZwuUBTOjUg4rq2EcI5sCPCBGfaWGh+7oiemBStfThz7lC83zFOJO1TnqljBRhSBA22+j
         ZE/5QeVUAbZDzNbwfFcnqJJ536wza7BTGF7WIlCg+tF1z5DPA1ATgYbYooop2hYd9cIt
         ZYBW/kBgLZcpQ9OKPeOxy1DTZ/JCWPwukYuLdyKzWzM4FmNgW/YiddBE28jByzXzTKuE
         3rZwNGrZ0DDE7CM0vESf/mbzVCTVuN1mriRctN58RQeatBmmpVmlFaGnjTTeZ01Tmq5S
         5H6A==
X-Forwarded-Encrypted: i=1; AJvYcCXA2e4Gk/H0mkQ+7bTzN57YHN6sBs0V/O8yUxyS0kgd0zWBhEulbPPw2+ByC/qsEC2tJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqUYW22vGDwl/ldidiNssB/lnPIT0RBI5s3+hE7Y5HbxeCCuoB
	DRUiozjkLXAS+v22WzWNZXMVlj+eh4uCCEtUi/l9ZLYerv/3DhtK
X-Gm-Gg: ASbGncuOeQoa5eFzbp3ilUBY07M1ZJnk3zo93GuLrCUGeBJ3O0NW0Y1R014S2JEIG1d
	MXrH0aeh6NHft1ZiHjLHQtnjG2Nn7Jz5VOQdOtr2G12OBJBs2zG5bfWJqRkxgF8UFguTwhhdLlP
	aQABL0MINr4rBcuTqFo1RdVdvt0YJ23d9YmxTP3yQAT/qxnSRUjqj/IxHZbeZs43bZ99lmCZWjR
	aMgyszKyIE/feaxwyiV28SiovpDO1M0AnOXFa7h9XyHqozWyuYcOnSbIqBPS+gUtsCYE1BtgXrh
	rmLvTL58Aw+U4ZKopdX/htu61kTAci5l/bf+Kkbo1w==
X-Google-Smtp-Source: AGHT+IHbHafx7TUxy/SpfSk7gxRN48hGWpYq/SwSmr1RWBChZXf1zdM1zykEOKfELqlAlX1XP0R6fw==
X-Received: by 2002:a05:6a00:1890:b0:730:937f:e835 with SMTP id d2e1a72fcca58-734ac3f41dbmr7019484b3a.17.1740787071737;
        Fri, 28 Feb 2025 15:57:51 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe6f066sm4328658b3a.83.2025.02.28.15.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:57:51 -0800 (PST)
Message-ID: <69a875c3c8be2851f71d64c062d139d9a2c64b07.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@kernel.org>,
 kkd@meta.com, kernel-team@meta.com
Date: Fri, 28 Feb 2025 15:57:46 -0800
In-Reply-To: <CAEf4BzZMhVCc0SVjbOLQj736kH-0yRdptqa7rNTftyD5X7ZDvw@mail.gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
	 <20250228162858.1073529-2-memxor@gmail.com>
	 <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com>
	 <3736b28f9266bf8b9c227998e80eb08253aef43e.camel@gmail.com>
	 <CAEf4BzZMhVCc0SVjbOLQj736kH-0yRdptqa7rNTftyD5X7ZDvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 15:34 -0800, Andrii Nakryiko wrote:

[...]

> > There were two alternatives on the table last time:
> > - add support for tags on global functions;
>=20
> I was supportive of this, I believe
>=20
> > - verify global subprogram call tree in post-order,
> >   in order to have the flags ready when needed.
>=20
> Remind me of the details here? we'd start validating the main prog,
> suspend that process when encountering global func, go validate global
> func, once done, come back to main prog, right?

Yes.
The tree can't be built statically if we account for dead code
elimination, as post-order might change.

> Alternatively, we could mark expected properties (restrictions) of
> global subprogs as we encounter them, right? E.g, if we come to global
> func call inside rcu_read_{lock,unlock}() region, we'd mark it
> internally as "needs to be non-sleepable".

For situation like below, suppose verification order is main, foo,
bar, buz:
- main() sleepable
  - foo()
  - bar()
- foo():
  - buz()
- bar():
  - foo() while holding lock
- buz():
  - calls something sleepable

I think, to handle this the call-tree needs to be built on the main
verification pass, and then checked for sleepable.
But that won't work for changes_pkt_data, as verdict has to be known
right-away to decide whether to invalidate packet pointers.

[...]


