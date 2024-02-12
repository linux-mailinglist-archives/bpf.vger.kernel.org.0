Return-Path: <bpf+bounces-21761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9E851E64
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC70286BFD
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14DF482D3;
	Mon, 12 Feb 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyqrbw5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195341208
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768339; cv=none; b=TJqKE4aAzTwTJ46QgpNGR5Aod6a1DdfjPGyu3QtFMSuiG0gr3REchwZc5S14KgG72ZyWXSANpt5nV/qTQ5cxUcvQ12E5GreyRPQ722a83+UT284tKd+cYDUyrMkIYmymsVTgonOhRvzx9ktyzxp5dJ88ekpybJvb5sOusE80gxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768339; c=relaxed/simple;
	bh=OaC3kOO3zaGsGIJA+/rt+FcCMDLbkpX9XfVJdSTTaqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MInyR7tn/T6t+cg3fpcxr6BvmI6p2zA0NsIcnzJbtJs4CoV/rujB13Qmh3uezuy+41QrdAKOnrV2idwl4OXQQL0Zup2JPQPPoSjx8Is8yNn3UA4ZUyg3/8eyktItqgq3vKzO7BEf68bQxrVarWiSfbtQa9dfxnymWpwbXK6WpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyqrbw5I; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410da137230so8886055e9.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707768336; x=1708373136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3hlpId6GEbKxNV+OdDg+IJsCi9qBugOgPouKwxUv4A=;
        b=Dyqrbw5I5vc6u+SjL81v3Y7ccn/7uiQcfyCuBqOwSQMd0sRLC0f9RWz4g/fe/x6rX1
         +WcZ5Fb3myaGL6e2nq5vxGwdapg1ffJIWB06fadoKL3Ob/w/2ENhz/qw341x+/al84AW
         L466xwGIwbNnn9EyXjXUNZk87ThY2Fa/Ui3yibSAfX80WetW3YFOoezuwW0k3K9aO7UO
         wQ6P48WdbP9vOsE3nTJi7TOV06q19JVvILI3jlA/SDqwv0S4MASAjMTS30UKiK7+uu++
         0B6YSriKR+K5UMBY4ow2pU7b3za/OP4R3gSrFb3bFGT3jOu96zWc6R2+hTWU4DITGmp+
         qOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768336; x=1708373136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3hlpId6GEbKxNV+OdDg+IJsCi9qBugOgPouKwxUv4A=;
        b=GK9OuchI/twMsz1PLQiv0HyCocWWnELnweJifB3Ni3JeMqUpX22QRYSKAiq7hRULSa
         zZqTssj+HSGpdKai4RrpYasTJnkxtoyYtdgCjkaQY4DdpSi6Xo5MVUwkLrBo0ELv7rlD
         PRMIpvtqOKaMwFdigUZ0zPa64otJFfUqrQuD1kJIxEBPRQnazriYRTSiALSmq1F1E15V
         64gVrPvIrW4v7wiOXC8NKt8WOy1Fdt4DhSleSPf0qm6SjaTxD34mx8XKxLkJu8c/j0Eh
         KP6/oQl+sJmyjvVcYNsbTIb9rY+YNhSlVsIjw0a16Cp4+I9wLM3zijKAo7pO6eCTbr7p
         3O2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdb4gN5npoXUeQIeRQfy2IP9k3FEtaYHbMgOYIJxLqDP0aLxwADaUCF0IX9iua2oSdlQxcFY0yKzzDVQBxaR7pGHum
X-Gm-Message-State: AOJu0YzcMjWmMv06tLvwFvjnLlBSk/tcyEUY1LXAo6Mrpg7DolBvfZZr
	F7gQejlmChrwcbt4KvPGRx8fSfKj4zxSavYcbebh+VCc8kbzK+/v669EUmIcrv6MN8D1vWhPp6e
	t3YeIi37OFBUS3kTJxR+IDgLC4qw=
X-Google-Smtp-Source: AGHT+IFh/IFu53Y5iFjvtCOiSEUzjgjYijrzk2jQNcXXTj2lCfyYIWav79M5RCtbzzmhj8lgx5gEEIzEETW5SqKGOw4=
X-Received: by 2002:a5d:56c4:0:b0:33b:504e:d36a with SMTP id
 m4-20020a5d56c4000000b0033b504ed36amr4790025wrw.4.1707768335234; Mon, 12 Feb
 2024 12:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210003308.3374075-1-andrii@kernel.org> <CAADnVQ+yvpZ=-gWtU_4w4wJ52ULZcqVRq+4E-BGNZmTjfKPYRA@mail.gmail.com>
 <CAEf4Bzb11hQw9DX7c+AKcCjTrsh8yAcEPvUotCBwZv=1B3Su2g@mail.gmail.com> <CAEf4Bzb0KajZt85zgRJSeSJazFDFFXmJyhQd64zZUc5phqBUFA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0KajZt85zgRJSeSJazFDFFXmJyhQd64zZUc5phqBUFA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 12:05:23 -0800
Message-ID: <CAADnVQLU0Gp0T6nATdMCJrwDQRA1wGcWPqi+N2a=aXUBiy87Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: emit source code file name and line number
 in verifier log
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:02=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > Can't say that either is super nice and clean. But when I tried e)
> > proposal, I realized that semicolon separators are used also for
> > register state (next to instruction dump) and they sort of overlap
> > visually more and make it a bit harder to read log (subjective IMO, of
> > course).
> >
> > But let me know if you still prefer e) and I'll send v2 with it.
> >
>
> Goodness, gmail made everything even worse. See [0] for visual comparison
>
>   [0] https://gist.github.com/anakryiko/f5e9217f277b0f8cd156ceb6cb641268


Two ; ; are indeed not pretty.
Maybe let's use a single character that is not used in C ?
Like @ ?

Then it will be:
; if (i >=3D map->cnt) @ strobemeta_probe.bpf.c:396
; descr->key_lens[i] =3D 0; @ strobemeta_probe.bpf.c:398

Some asm languages use ! as a comment. It's ok-ish. a bit worse imo:
; if (i >=3D map->cnt) ! strobemeta_probe.bpf.c:396
; descr->key_lens[i] =3D 0; ! strobemeta_probe.bpf.c:398

or single underscore ?
; if (i >=3D map->cnt) _ strobemeta_probe.bpf.c:396
; descr->key_lens[i] =3D 0; _ strobemeta_probe.bpf.c:398

I think all of the above are better than () or []

