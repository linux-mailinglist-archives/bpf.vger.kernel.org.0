Return-Path: <bpf+bounces-77377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B8CDA59C
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2833070A28
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFF34AB00;
	Tue, 23 Dec 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMHhWAoH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64A279DCC
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 19:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517852; cv=none; b=EaGCq2WmdvdoKS2/3O2otWbqdvIdrEfOOY1l7Xu/Cx7XHauH11cfYLB/4cPwa79/4hyu+XD9f11uGJK4eMlR5Dzm4EpEDLyD43BuQVSrc0i8ddnplNoVP/+QxD/1U0w75v3hm1S1cwK7e/26YapVF0Vkc49rzGZcmWl5r0esMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517852; c=relaxed/simple;
	bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKYEPj8KsBclkLkOUCFJdYT3/X7GjnW5JWKM0k4ih5XCD4t67S2WCDPg3HRliq4t2D+6nXutmuQ24v0FRFomAK/xcB8F6Yjo4TxxYpnHRasVXNFO3ccSYhECVYurl9BdMk5uUsq+iNMiESbErLAUIS0YG4wstl8KAs4XMUTCQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMHhWAoH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so53822065e9.2
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766517849; x=1767122649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
        b=dMHhWAoHEY8bLj6yKeFcAj4oWEcBhr84c9A8UsaxRDoAvt7gIx6PEpM9CcGD6Xw7V+
         nSuyEivDT9ro8v4KncN4H7t+fnNEF2KIazbF+XnQ50BO/gzXm1bP1kRQXYt4Lbg39Dk8
         ziISx2RCJdFhgwwwiG3ToK3g1Gk+aE8ph4y3pWTZabLqbwqkh1W7xmNjVIq6/Jn3IAXE
         a6rFkvt2x0B1+YYsgn3KEOSB5MAILSVWx5J9QGIuPmG3EOHwojKBTRixlbaBoAf/Hg6O
         Ll/OoMlaIlfkIdEu0PzoxZ8z1Qwxbvn11mGbIpDsu56h15TuGi/OMGa4anxWikxoa2OE
         kLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517849; x=1767122649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU0c+Ej+ibCsAFMveNpQ3mdIdSrtdeoPA94mykdrdO8=;
        b=n7WELb3kpixU4kaP1kY/dxDLmVJrWdevK1Or7ZAfC0xMcMeKc0GfayYTQNiGmJt1EY
         R3462x7sAQKaCHcrhFv1ev755310MyZ8EhEyvum+cfZS9+dtPHgwgOxhb60Xjv2cQUZ5
         CtH6vshMrI6AQWG9AJ9uQYoUGoVaoiIEy2pzBtors3BVg8eyy2ild8FhnYt6TC6STwmM
         dGHEVF9Maz4ga4LbdbCb+K1NJ70QW39t4iH++waKbjwig7NeUE3n8pztf1xOGZjOfjlB
         5AkJYaT/Lpz3YqNajNy1fk5yKiQfNrcqIg+pMQpEQSljBB4EP2a3U8CP5JxKiEGlkdep
         jwhw==
X-Forwarded-Encrypted: i=1; AJvYcCW3/l6wbgohfa7cED2QQuf2WQr9m15i1VesWtRnMuUCjr6DSR6YpLkDKwuP+WoojlNedVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53sRCkkjvRPQWykgRVjWScNqg2fB7V4+0m8LAProw42NCSuF7
	NC0AHGk+8rIAKDu8q9goKzHqPF5OipBNO5JaiXAJQB3Mgg5mHxwL4nt/z8ZuDsNVgpudi1d58tX
	TrjKyFmKb3QE6LFVY1Bg+id64oKfUK2Y=
X-Gm-Gg: AY/fxX51WGs+T9/4UKmH9pwrUte662Rt92FcSueM6F2J/RUXEJ8wJkScaothIoOrJYD
	ywh3kwg1teGTWoC1gOxseUVH07L3W7xN+uueS9j5SOO955ZQfnCg/oyVbkQx2p7ypfXP5cqEzJX
	Y3CIh673XWRX89jpoc2RTCWeZWTHjQ2jTNo4jiArGu8Hmtba2Fhj6MRxPD/xF3xuK8l0aQi/a7Z
	XajqFf1I4oqOcInkZjpfCAPs4VNWNjUEkNM71CqjvMeLA1cWV7H+aQpmEUQ5KdLYmG6TE4m
X-Google-Smtp-Source: AGHT+IEA8N0l7f37xu5fuodrmydJdjU8BPqUpk7joEMKf2v+HTz+VBQEMv8K8hO4h1IbRN6r+aIM0AZTsebwkuXeaXM=
X-Received: by 2002:a05:600c:1c9d:b0:477:9cc3:7971 with SMTP id
 5b1f17b1804b1-47d1957f7cfmr167023245e9.20.1766517848747; Tue, 23 Dec 2025
 11:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-dev-module-init-eexists-bpf-v1-1-7f186663dbe7@samsung.com>
 <47165c76-d856-4c5d-bf2d-6d5a7fe08d43@linux.dev>
In-Reply-To: <47165c76-d856-4c5d-bf2d-6d5a7fe08d43@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Dec 2025 09:23:57 -1000
X-Gm-Features: AQt7F2paAUP67eAz86aT4EZ2zxYpVE22u8U7q7vZXo758q6RP0KM0jYtAiwhChs
Message-ID: <CAADnVQJAmb8NFWFCgpBUO9wT3NTzTJAd2gH1cs3rpLxAK1WNrQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: crypto: replace -EEXIST with -EBUSY
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Lucas De Marchi <demarchi@kernel.org>, bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 8:55=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 20/12/2025 03:48, Daniel Gomez wrote:
> > From: Daniel Gomez <da.gomez@samsung.com>
> >
> > The -EEXIST error code is reserved by the module loading infrastructure
> > to indicate that a module is already loaded. When a module's init
> > function returns -EEXIST, userspace tools like kmod interpret this as
> > "module already loaded" and treat the operation as successful, returnin=
g
> > 0 to the user even though the module initialization actually failed.
> >
> > This follows the precedent set by commit 54416fd76770 ("netfilter:
> > conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> > issue in nf_conntrack_helper_register().
> >
> > This affects bpf_crypto_skcipher module. While the configuration
> > required to build it as a module is unlikely in practice, it is
> > technically possible, so fix it for correctness.
> >
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> > The error code -EEXIST is reserved by the kernel module loader to
> > indicate that a module with the same name is already loaded. When a
> > module's init function returns -EEXIST, kmod interprets this as "module
> > already loaded" and reports success instead of failure [1].
> >
> > The kernel module loader will include a safety net that provides -EEXIS=
T
> > to -EBUSY with a warning [2], and a documentation patch has been sent t=
o
> > prevent future occurrences [3].
> >
> > These affected code paths were identified using a static analysis tool
> > [4] that traces -EEXIST returns to module_init(). The tool was develope=
d
> > with AI assistance and all findings were manually validated.
> >
> > Link: https://lore.kernel.org/all/aKEVQhJpRdiZSliu@orbyte.nwl.cc/ [1]
> > Link: https://lore.kernel.org/all/20251013-module-warn-ret-v1-0-ab65b41=
af01f@intel.com/ [2]
> > Link: https://lore.kernel.org/all/20251218-dev-module-init-eexists-modu=
les-docs-v1-0-361569aa782a@samsung.com/ [3]
> > Link: https://gitlab.com/-/snippets/4913469 [4]
>
> Even though I'm not quite sure that we should care once the core
> module loader can adjust the error, the change looks ok to me:
>
> Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Applied to bpf-next.

