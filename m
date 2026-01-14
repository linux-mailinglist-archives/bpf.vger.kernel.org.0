Return-Path: <bpf+bounces-78859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2C6D1DBC0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BCD730549AA
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0B381703;
	Wed, 14 Jan 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO7Fgpwv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB14325709
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384346; cv=none; b=XEKPhj6llGKhEvvW3pE1LuCSXcYLglFIJ3VJOwgNeKthem+7tl1CRHlpQSlW44BNt6qsGBuJzDGQ/hTrt0R+nS5N9lVUlG1/Js3hgY0B7sFHg/PIepMwL9AvKgCmLdImbPEbQHNDY7to8OP8yMnWNTiR2P8Dmd75Yvh4W/wd/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384346; c=relaxed/simple;
	bh=Dzq6SMAbcHfFRJIMzWCCCgKrfkJdaUPxHNRc/88832c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXpjoabqo+dUcoqvE7zePE9OAXpobMygSsNwq2an9Wn1WQComU2M6qLwm8k4QpiKLuDHeZMU542iDTr2LMdFFUZYx82n28sgi2zzKiFkHLPHWoatU7qwLIbCkU4APB4V67Dwzw6uQxvq5O8259PApImfzCwY6Lrbqu3FdCZCYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO7Fgpwv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so3390735e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768384343; x=1768989143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73XmT9Nkz/b8xnW5w5fum9Y/ieYcnHFnxskIolQuydA=;
        b=OO7Fgpwv89ucMu4IpN0KFO6wQCIU3XI775R5MITt3n6BFH/6NPeSzJ4rCyYAqW3xws
         FJ9UoO9VzAlnBRrxctOkjaVvpn9I52GAeEeTMGoo4/KfJ51xYtztBk6G0Nj+7nfdnZKt
         kzWiTiTO1zhVAz2hV6CmqnnO02gzzmFP70hex9vv5I4MUBXhfE8aLaEEGHY7CF/L3ofD
         0RENyVQK9kY/t3mrLuJNcidU6bolkq1wGwVaJCWb+SlT6ScInwfvXTDI/n9GX12oqbOy
         VhRHSq1kVnqVmcO9ZYqKhVulMgJstLoRVc63yyQHMg9tpTk3+/FFL70kfn8UN4tTA8jS
         cjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384343; x=1768989143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73XmT9Nkz/b8xnW5w5fum9Y/ieYcnHFnxskIolQuydA=;
        b=CEaLA0as9G5OdnzZZ6Q9eGHAgXr5jdbVnFUK5Rn3Iso/FXscniz0Uxg6mGhS26ds+y
         o6WtXF5A3W2dMK8FP9A8xBT46YRe5dKewEtmOYaugP2a57/5m5RpnuecbWqAIxrbor4o
         GofKVgJepptbsjnQzJCYBxwvMP3q7TWNPCn68Xx87KnqOrlx3SkRKHs2mTsVEEZKmJCg
         fsZzXFDg9ujelczvkX4rHNAkCjq7EFRar/rKq+/YS+5Y7cqpVZfgl8Fryv5jB9vnx22j
         nJQlOz8buH1UaVfrA+LpUE3ngLGLHSsv6z72N2+FKEblkwP/PBGszPJ4EIrKaszEd33U
         naRA==
X-Forwarded-Encrypted: i=1; AJvYcCX5fMjICyM9nOw2qRQv24nufvA4OXgcBzpJ+aJiZ1dqUsS0chNqbgkfi8jGxA41J7Snm2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNU+TvOPp3AL93/e+xrT2tLqeVpdeMeAOPKWjDGWyZT2Pc60tJ
	jmLaLPQ4LaUBkezSHOfEn5S9TZ7yuQ8cL0TKG+iJYhJVjR83CMYoHaOt
X-Gm-Gg: AY/fxX6CWErVgZCOjYXL796qmCkXuNMhh3lMTrjqOUtdHqSxEbMs3HxAHoSaJ6Nh/k7
	yNXxRC1MgdpZToxIgH5EYYuSRkh5r+yGh1UHWJ0YwqlIqFoBidqYcnw8E3kq62O+hVXiXzStl3k
	0352SZ7tPg1rVXMSMcNMDEbQmLBo+etbL+1PPX2g3Ny46+K3aisbqc/bsqhR2MfEtePQxa5N7e+
	bZWlS156YPd4ZS+7xCsmzFSYQFM4OVmZ11AyVl8BDhflxOu8d8FCmAFvC3JYS+H2zprbj3U+Yjh
	Nvmq8AqXxkIgUzwdzzZLAWqECnudUZLJPNo8K+PG8sNRiVYZcGbpwdjOkeYhgbZ2hepA11p3quK
	ulkjwi2RRtJxuCxs3N4mlNTDKDa4CKPva1erhy6fMnaXrJ9Q07vLi+9libImqMAjNilPzQzyJ/V
	kZKlMjS04wL5ujfgRZjNdwGTMpBfebkr5X4IsypBE+A4Jk9BuzZCJL
X-Received: by 2002:a05:600c:34d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47ee47b9e52mr15009465e9.4.1768384342949;
        Wed, 14 Jan 2026 01:52:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27ce2b2sm17140995e9.5.2026.01.14.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:52:22 -0800 (PST)
Date: Wed, 14 Jan 2026 09:52:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args
 in trampoline
Message-ID: <20260114095221.460c059b@pumpkin>
In-Reply-To: <2336927.iZASKD2KPV@7940hx>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
	<20260110141115.537055-3-dongml2@chinatelecom.cn>
	<CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
	<2336927.iZASKD2KPV@7940hx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 10:19:02 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:

> On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote: =20
> > >
> > > For now, ctx[-1] is used to store the nr_args in the trampoline. Howe=
ver,
> > > 1-byte is enough to store such information. Therefore, we use only the
> > > last byte of ctx[-1] to store the nr_args, and reserve the rest for o=
ther =20
> >=20
> > Looking at the assembly below I think you are extracting the least
> > significant byte, right? I'd definitely not call it "last" byte...
> > Let's be precise and unambiguous here. =20
>=20
> Yeah, the "last 8-bits", "last byte" is ambiguous. So let's describe it as
> "the least significant byte" here instead :)

Or just s/last/low/

	David

>=20
> Thanks!
> Menglong Dong

