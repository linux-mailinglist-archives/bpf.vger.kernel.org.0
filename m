Return-Path: <bpf+bounces-16731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E04B805612
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1D1B20EB2
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3A5D916;
	Tue,  5 Dec 2023 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPPhkiy2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E3197
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 05:34:47 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so43716281fa.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701783286; x=1702388086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gniqLuA09yD/Ep8rxSgOfmD5DoHDPqmS+QioS7r8tDI=;
        b=KPPhkiy2mbXNtanIpjXkTWJAE6+uoFyegPF/L9Qh0QPLreIeyKVDMJrZ9saO/hhxxU
         3rDHyxhBiKjVGSuGZQSFzOuDfLL9wzmlxsh3I0UtSCBUmjoGjqOhHaLOdBc/Aux+P6AF
         FUWIS1zhXETxBzwTyofnOmSQyA3NHvsIYOXozvf/hD1GHBUMT+j1H3AZPSdeEYBEjSQ2
         t3d86bYV4ryvq+SluTk8cl3KLnnAvBU7DzvJSemhQgOZEmFPUOtXSQVgi2on+c3ZfyiN
         Hk56W3cHJf8YpW84gcpCUlvqJmqehl6hUpSTJvvyuH3pLQf4E0N0Wp7AImwrzb0MrQqq
         ZPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701783286; x=1702388086;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gniqLuA09yD/Ep8rxSgOfmD5DoHDPqmS+QioS7r8tDI=;
        b=KmnRBQ2kkX8dfU/kyM6jX4mBuLU4XdI62CSZLs8ULlEufdb6AGRzKrgE8VsLSbUUCA
         ktWobrE4ySvNonpZHlDbw1YnfTcehzEzNeYHG4AkCigXlpke6m8VzSfpqPFtbbdt0qXR
         2CfWIG3R9U092Cq4B66dYVgqqIIIzBcBGhOUgoo6XxBseNDMMdB0hR8a2IWzoKKd+fE/
         LHSKPTo75dzHWUmVlwSFlrGp/kTFy0yl7t5enr6231mYqa1VFJT5vo217GYamjzULqa6
         rHJriD9vX0svv1vlsurMrKaUdFP4/sKtuHtVf0cv6v+dcmlOPKjSF8VSVvPep6538lda
         LOww==
X-Gm-Message-State: AOJu0YyaIanEjAcANT1IofYF1LTpDukTEDP0kASSrkE6M/ECU/BYlN2Q
	dZSNKJYb8Vkmow23pNS7phU=
X-Google-Smtp-Source: AGHT+IEDUdzPFMqdh8TkGBGDVjVA0pH8SmvvrTjCL/SMpVtBh4ie2UWtN4aW7QYXoK8jrsKT8aiFZQ==
X-Received: by 2002:a2e:9184:0:b0:2c9:f7d3:7d61 with SMTP id f4-20020a2e9184000000b002c9f7d37d61mr2247860ljg.82.1701783285414;
        Tue, 05 Dec 2023 05:34:45 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u28-20020a2eb81c000000b002ca0155b9e6sm764448ljo.81.2023.12.05.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:34:44 -0800 (PST)
Message-ID: <7aa8af01db4fdcbedab376423d3960c22016aba3.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org,  kernel-team@meta.com
Date: Tue, 05 Dec 2023 15:34:43 +0200
In-Reply-To: <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com>
References: <20231204192601.2672497-1-andrii@kernel.org>
	 <20231204192601.2672497-4-andrii@kernel.org>
	 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
	 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
	 <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
	 <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 19:56 -0800, Andrii Nakryiko wrote:
[...]
> > > So it makes me feel like the intent was to reject any partial writes
> > > with spilled reg slots. We could probably improve that to just make
> > > sure that we don't turn spilled pointers into STACK_MISC in unpriv,
> > > but I'm not sure if it's worth doing that instead of keeping things
> > > simple?
> >=20
> > You mean like below?
> >=20
> >         if (!env->allow_ptr_leaks &&
> >             is_spilled_reg(&state->stack[spi]) &&
> >             is_spillable_regtype(state->stack[spi].spilled_ptr.type) &&
>=20
> Honestly, I wouldn't trust is_spillable_regtype() the way it's
> written, it's too easy to forget to add a new register type to the
> list. I think the only "safe to spill" register is probably
> SCALAR_VALUE, so I'd just do `type !=3D SCALAR_VALUE`.
>=20
> But yes, I think that's the right approach.

'type !=3D SCALAR_VALUE' makes sense as well.
Do you plan to add this check as a part of current patch?

> If we were being pedantic, though, we'd need to take into account
> offset and see if [offset, offset + size) overlaps with any
> STACK_SPILL/STACK_DYNPTR/STACK_ITER slots.
>=20
> But tbh, given it's unpriv programs we are talking about, I probably
> wouldn't bother extending this logic too much.

Yes, that's definitely is an ommission.

