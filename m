Return-Path: <bpf+bounces-77195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 605BCCD1761
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B01543015D19
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBFE269B1C;
	Fri, 19 Dec 2025 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLTVGQFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9233F38D
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169885; cv=none; b=m3OIJLJcGkLP0iF+vkjCcDFHkN0V0mDs7kVrnvvdkZGajX7RZUboqJzTGTHpTuP4oLpgmW+NTUEDpQEDimqo46fT6lBJNwrxRjokn3T8alaN9T+MCS1lYlBwImAcTASWvjbDCjkWu4sdE3FkdRtRp8Cfdzn0oYltc/7m43TNers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169885; c=relaxed/simple;
	bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKHsL2RK++AdQFlIYA+DZ7U+as8emP8Tqu3HsVdB2F3yRsWHWRMCi5x8kAZpL9CWEQPpkVDw4GrurlWT2WQlM05+1jcabkmqkFt/V1449X7FcqOmNmyEZ+CVjWcmIX0RW4sv0PScUFKYGccRve0YlwvXWHjU6/hry4tEfUn6oB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLTVGQFO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c565c3673so1451652a91.0
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766169882; x=1766774682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
        b=eLTVGQFOzm5xYs/oOJBZEUEfMtz4C/cClPhCnkB1LQ7F1FZ2epst6goqVyorHscKA8
         0/RxHrU0w8afpP1kDBWuYeXR6UR/Kxy5oMTQGlXuncSMMQkQ0jeuawe7Mnq+69xNUM/h
         5tCcZUcRzrhAMEb6brjcE+pf6brIBGqJVjDvE6j1Pyuf6WSgfaxc5eLRbJz4A+MKUFmc
         +lSb4048Qg6Cpwx79oPhARzOZ3VHwyuTk9Zh7248ya6npu3TGG4fwiFxqTk2fD4fh7W5
         azn1IhpQqZ0H7taq+vn4uYoONFsFY3G+Lh9SFyecpdTj8R1kfPzy6KaobAQzaFi58cNk
         1nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766169882; x=1766774682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUIbJz4v0Rubf3X8GDdYbaOS1mdha3XyVNbYZgSaA2w=;
        b=gqTu1eA+QhLk+nk5B3kHaXAiaza0D6F25Qw3w6N35I4w2EIcgSYeu1GfLbJEphWya/
         AtdwiSggDKfizYs31uGarGF60mJsWqhIhroV9ezhsD71/HahyfQoiM1na+WDHH9PZg42
         K25cx0j0fAHLm4MXEpaYu09obNhFNY7V+U+QF/cq7p3gg+pfJtbSfez33ZvWYxw7JRum
         vWFKCtKtYcVzm6tPWippptJbUS0zFrEjBNN6TYso/01ySqeGTKwWZsAePLE7gV9u2+bR
         Rwh2h/FPbd8Mb8rDVh1+f8S1BYa3dZeyXNncUX08uQI843eYflBX9joetYGGpTbqXf/B
         HXWA==
X-Forwarded-Encrypted: i=1; AJvYcCUB+wpRK1B6S4p/NyhzUC6PYwfI9eZJBMuJ36E6RVMUnWKOGmKk3hzBZd62BUa8tgzPhW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5n7/+n9BlpS2ZQdgDUNyiSraXNdch5jit8SPFJ8V+rj8Chzc
	UgfeO4WtY5SRLtTgZbQWMbV8U82GtQfuYI9HwZwE7lblIk+rZJy/pF1J
X-Gm-Gg: AY/fxX5F/n9cfJ/XqmSRf86jg4RqACSwo7bQgg00njK+uAHAMvFiQCG7tTRv9A1+HVD
	qc6glapwc2v7lCdp1cLSFpsnd30ey4+UObJsk0tSwpwh0mizilUCZED11GlmfrK8XDp6ZdCAVj2
	E7RaosUoCvYZWrWIZUuP5+LwCAQuzXUbPuLGnGHvGrR5j8qi8nKxU2fXqc4XiRO9zsdgpraa4Nn
	ybesEytdPsmC7Smdr99US/l4RlRhVO5WYA3gzuYNpwU13gIM0IPTQ8FGO3RyBJOOB/hNhF1Cj/Y
	xvnFBgJJwkpWvQjnhkIZbhaFVmM6qeUFjPui07Py3mshxTG9mdS/5dr3ngCeh/R6CYmVMrY7d/R
	htA34KkWlcgvc1HwoHg10pqN8NdTDEv3dmtw82/DBnjzWSl5lMVjVOspYuLhVaSRUDOcu26bLA4
	6RP4UkZBA=
X-Google-Smtp-Source: AGHT+IG31t9E+qtbzvlggQ58tNUpirdrVXwoq5p8e1XvpatVKwcKANPdBsUzaj3dxq8sc9z2zdP7qg==
X-Received: by 2002:a17:90b:1d0d:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34e90d6980bmr3302082a91.5.1766169881612;
        Fri, 19 Dec 2025 10:44:41 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76ce0c8asm2156786a91.2.2025.12.19.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:44:40 -0800 (PST)
Message-ID: <aaeacdd937e2d0b04959c009bc9ebdd18497865b.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Fri, 19 Dec 2025 10:44:37 -0800
In-Reply-To: <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-3-alan.maguire@oracle.com>
	 <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
	 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
	 <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
	 <ccafde20-3ea5-458a-b2e7-219aaa9a7ff0@oracle.com>
	 <CAEf4BzZ+iH1XvaYOjE==GPJ6wFo14_QtrFYvyvWa=ebc6UKPbA@mail.gmail.com>
	 <a99c8b9148a71c7827b00be5c793bfe8379de1de.camel@gmail.com>
	 <CAEf4BzaS9xoFaTF7LEyjYg9iPZZGn3=UhDVXAv9AuuMz1wFoZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-19 at 10:41 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 19, 2025 at 10:36=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Fri, 2025-12-19 at 10:21 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > The sanitization for user-space consumption is doable alright, I wa=
s thinking
> > > > of the case where the kernel itself reads in BTF for vmlinux/module=
s on boot,
> > > > and that BTF was generated by newer pahole so has unexpected layout=
 info.
> > > > If we just emitted layout info unconditionally that would mean newe=
r pahole might
> > > > generate BTf for a kernel that it could not read. If however we rel=
axed the
> > > > constraints a bit I think we could get the validation to succeed fo=
r older
> > > > kernels while ignoring the bits of the BTF they don't care about. F=
ix that would
> > > > also potentially future-proof addition of other sections to the BTF=
 header without
> > > > requiring options.
> > >=20
> > > No, let's forget about allowing the kernel to let through some
> > > unrecognized parts of BTF. Pahole will keep introducing feature flags
> > > that we need to enable (like layout stuff, for example), so old
> > > kernels built with new pahole will be just fine. And any
> > > kernel-specific modifications will be moved to resolve_btfids and wil=
l
> > > be in-sync with kernel logic. I think we are all good and we don't
> > > have to invent new things on this front, potentially opening us up to
> > > some unforeseen attacks through BTF injection.
> >=20
> > That would mean that the flag to generate or not layout information
> > should remain, right?
>=20
> Yeah, unfortunately, as there will be no libbpf to sanitize that. But
> that brings the layout question for Clang/GCC, are we adding that?
> That should be emitted unconditionally, IMO.

I don't think we have layout generation in the current roadmap.
I'll add it to the plan.

