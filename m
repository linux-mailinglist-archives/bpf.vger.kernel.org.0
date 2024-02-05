Return-Path: <bpf+bounces-21237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60B84A202
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC15EB21ADB
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058547F74;
	Mon,  5 Feb 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E89eEpcI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061847F71
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157285; cv=none; b=rTpAjQsICXlO1CaeQIYcpEXkkuYIgfg0oQT0o7Cj/OcWHJ2hmS1YNYIsZj4Xp/W80IFrmXSNznwuNmYnDRdf9/gwsoyw1sQNGPSKebPvC6sm9L26aX5ZgN/jF/QnmXtpLmJlbnGB6q2bSj4zXnVlELZNCNZOjlVqxXFXobegQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157285; c=relaxed/simple;
	bh=QGmzyEiH2d4hVicOT0KcbdIaIyS4F8SpsfgPMfscVSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3T1DUkHx9wDy70Qj7uKT0xhHfkuT40Zi6sMJDadV0LN+ovMbOmsuJ3NnTziyoPTyTbETRhcKuZTKAVxE2Vgo/0rwz12JaZB4b1hpSE8bw3MgFFsB2rLEKaHhCTFr59l7kTsGX4q8yrjdRSawdkhRJTom3mxU0FW1UCqAbAMrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E89eEpcI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3460552b3a.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157283; x=1707762083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGmzyEiH2d4hVicOT0KcbdIaIyS4F8SpsfgPMfscVSI=;
        b=E89eEpcIS44n8xbtuQ917thJSUNZK386jfFEWkKE4cWvv0X7dl0zaX4wWrNu5Xylim
         hhAdMYJtRDibGSCtgLQ6bDwVu2avaZe04fx4Ph1olIZt7bHhSGCRM9DwTpa+gewhyw1G
         AeLM5abqzR6kyLFlU9nGVzxp6HRBo/vniKCwOgMmlP+dCJ6hmHKeVhyCGkscEhnLJF5s
         ev8UU1570BeiYZWm+BKXph4fRevsod1cV7sYBqm3baRdwBlpZGsLLVkJhV9eR6ldJhMr
         A5DsyYX1Pb3gUTD4KUkvSq8QhGkuOJlgzYr/LzKYR5cIKthtc64ZJbfRsl95/ZDxk3bl
         yHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157283; x=1707762083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGmzyEiH2d4hVicOT0KcbdIaIyS4F8SpsfgPMfscVSI=;
        b=pK8nWrHyggx7CErLFPCBMm9vr0fihpHmK1k+yIR4cI5XkfDHIAHlRT8VLkwZ0CLoBB
         W0vkM/jBzT7E+2pIuaQT0Q8yT247+uADZn47wkqG8+zgt39OUZuqOHDG6h++DZoaL1lN
         Ja0LK7iZmYVp5fT4RCpkbMeFz4k//G4MEI81UhZno6V3jB2dFAqCou1PrYSWhjtYcBRC
         3AAS69Vax/qUMAGlCWqMThKMlLnoIXOaX9cPJwBVd/zHklrbAHEe3ALVrlmNrLn4Aloy
         E89v4l02lnFh6zjkNIXXyvmvNvk+U0mqBpgfmHDmW7E+PIUC3fOKK+Q/E/7/2/ChGwCo
         SHYg==
X-Gm-Message-State: AOJu0YyZ3j4nmmgtNJDUOnDRBh/i+cPNBwH+mLMqlGX5F6aCHDvN0tFB
	UXzgb+r/YfrOVks5k5Mlikp4T0X4RDlo8N/jE/dF7yIFsSyBmSi2NCRTDKqLzwG5emb7ySnj9LS
	DJ3GQyeCXiXX9n8GhVhBIDfZbo3Y=
X-Google-Smtp-Source: AGHT+IFk8Hqq6xCKYNQWBPVI5ImbNbA+dUHiLFFCBCiDZOlm6mpjjodENUxazS1gCvs7xahnl+IumOQY6HewojW5jo0=
X-Received: by 2002:a62:d11d:0:b0:6e0:542f:9690 with SMTP id
 z29-20020a62d11d000000b006e0542f9690mr304832pfg.30.1707157283337; Mon, 05 Feb
 2024 10:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com> <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
In-Reply-To: <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Feb 2024 10:21:10 -0800
Message-ID: <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Bryce Kahle <git@brycekahle.com>
Cc: Bryce Kahle <bryce.kahle@datadoghq.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:58=E2=80=AFPM Bryce Kahle <git@brycekahle.com> wro=
te:
>
> On Fri, Feb 2, 2024, at 2:10 PM, Andrii Nakryiko wrote:
> >
> > Maybe the right solution is to concat vmlinux and all the relevant
> > module BTFs first, dedup it again, then minimize against that "super
> > BTF". But yes, you'd have to specify both vmlinux and all the module
> > BTFs at the same time (which bpftool allows you to do easily with its
> > CLI interface, so not really a problem)
> >
>
> How would you handle the Type ID conflicts between the modules, since the=
y all start at vmlinux+1? Is there a danger of conflicting type names, wher=
e there are two types with the same name but different layouts?

The sequence would be:

1) create BTF instance from vmlinux BTF
2) append each module BTF to that instance (we have btf__add_btf() API
already for that). This will rewrite type IDs for each module
(shifting them by some constant number)
3) btf__dedup() will deduplicate everything, so that only unique type
definitions remain.

>
> I was trying to mirror the sysfs file layout, so a loader didn't have dif=
ferent behavior between user-supplied BTF and kernel-provided BTF.

