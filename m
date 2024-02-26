Return-Path: <bpf+bounces-22740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7886834F
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 22:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D7A28E960
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 21:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67713173B;
	Mon, 26 Feb 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="YDFj+xZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7E1DFCD
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984119; cv=none; b=l1tREX9Hxw7HYxmid0Cll3kLmaYzTqwtxTW2nqaWN05QXzNb8Op6/P8w2lOJF/OwbuGde3eH8BWEI1cZVbWTWjGj1DSQrX4ChxLubYUL+xdfz7Gr7+BwMgrhEsKVurt8bPDSIh0D9EmazPRSsh/LR6UcMJMZ/SIyOx8Ow7go58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984119; c=relaxed/simple;
	bh=zz0QwXFct8UqMv9SmsifHCcWjgDEeIbtBJBKY3mpHx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5RG05sAUibt6BdKzAYvFtA1SSmCzrRYeaUyj23ygoBMAcDzNkah3e/aD9gJCKwcHu21fdKeCyj7k/EGEzc9zM2snpxB6T1CTudxA9+Up9WzEPJzEADUSRynzbxoD4cYPw8DwyIuGWKlTl6NPbU+ns/QA1qznoupecxQnUQ71Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=YDFj+xZH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso28305835e9.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1708984113; x=1709588913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz0QwXFct8UqMv9SmsifHCcWjgDEeIbtBJBKY3mpHx4=;
        b=YDFj+xZHZb9E/jNalTDusiEFVrHIDs+vPU10EvuhSGEk5Uhl+TKx5syEnV9m4SZ/tQ
         ZsjmLvjXAr94HE2xUUml6X9x71nqSMn3RIaorDPGzXwe6RlHaCQ07wGlDYIUcg29Syyf
         j3jhBcp1G4RQQm7k5zURrpirQD6IQ8YaFuRhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984113; x=1709588913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz0QwXFct8UqMv9SmsifHCcWjgDEeIbtBJBKY3mpHx4=;
        b=Toz5flNoARzEKZO8K6aaF336oKS+cj+u4M6kos6gINiwcgnk7fyy6ZfrxyGvuRVsFf
         eVKSwEISkYb+yBiVqK9U9wYba5ipdDCTJ+zR1n8GedNW5aLKUuXV71044XneXA6QCYFQ
         oD3yHiRtgSX7Dy5Yezhl93nyx9Bg3vaMVsBJr3qcdRs6BzRmurjKNLjTaK6So6XfqF3D
         vE6ZPrEsU2cKO/u8SNdwmlyc1pTmbKnOs1nlh0sUYt0qD0vCAqjJhWWdJRbs3KF5/DS2
         3johjd2HrUwFYuk9vQBZ+pqms5W3Kb/9J1A2l0VXfYr7h0GkQIOvVP3meqHS7FmSH+S4
         wFbA==
X-Forwarded-Encrypted: i=1; AJvYcCUkqzumAGhu/LF5H6IQuNzjEHsMaJjIhn7mi2CNunJcFuSP/YrTi7LUYNtf3R1BXCM+7uktrbRH013s0RnYRIukBBWi
X-Gm-Message-State: AOJu0YxOzzRqC1zqPDnrWNM/7khprmXUgKoxZ8tYJlUOGJgBnfVLbthR
	Fa8bCtcjL5DH4DcqjY3wTTnYiFJvoVqpR8cZlwsQLgLGjW8+v97q2zrWyIK3G7Rnu5MUUJzAGi3
	TOOvDSDyAK4JC7tiWo+KcsSR2P/AQV4UVs3Spng==
X-Google-Smtp-Source: AGHT+IFgTshQBXaNdXhPaDg8NeHZlLCuY9+2T1TL98BhxeLYSjrTvGkSZ4IrTg77lxBBbRlk6SgvzBWUHAH6ZZ5c/Fw=
X-Received: by 2002:adf:eb86:0:b0:33d:be93:5021 with SMTP id
 t6-20020adfeb86000000b0033dbe935021mr5355883wrn.58.1708984113277; Mon, 26 Feb
 2024 13:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com> <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
In-Reply-To: <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
From: Bryce Kahle <bryce.kahle@datadoghq.com>
Date: Mon, 26 Feb 2024 13:48:22 -0800
Message-ID: <CALvGib9iaYRkvy0YHpwv3yqx9tNuDbbLNAoeeOpfo_Fnw1bxdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024, at 2:10 PM, Andrii Nakryiko wrote:
> But yes, you'd have to specify both vmlinux and all the module
> BTFs at the same time (which bpftool allows you to do easily with its
> CLI interface, so not really a problem)

I didn't see a way to specify a directory for vmlinux and all the
modules BTFs. Are you suggesting I specify the path to each
individually? I didn't see a way to do that with the current CLI api.
It assumes that the input is only a single path.

On Mon, Feb 5, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> 2) append each module BTF to that instance (we have btf__add_btf() API
> already for that). This will rewrite type IDs for each module
> (shifting them by some constant number)

It looks like btf__add_btf() doesn't support split BTF, which the
module BTF has to be in order for it to parse correctly. Any
suggestions for how to proceed? Do I need to add support for split BTF
to btf__add_btf() to libbpf? If so, any thoughts on how that should
work would be appreciated.

