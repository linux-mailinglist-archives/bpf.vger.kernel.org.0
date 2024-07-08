Return-Path: <bpf+bounces-34112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16D92A826
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CD6B21569
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745E1474A3;
	Mon,  8 Jul 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4BByjxn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D2AD55
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459158; cv=none; b=Rej8PEjSPiycr2ODqakhri+VsZy5V0fO+GqSg17J3kwxBfCaX6eSjJRUdeu3s3EjXio3ftB3NNzNl2cWtyO3feWgyfPzf5rSoNUW+TGWh905JK8PDz460RUE3YQeBKXNTUVMY9FkjUO+/VrbN3mI7GFiRh6o+wEWefOt7neOpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459158; c=relaxed/simple;
	bh=KQc7qd3qVn6LU+IPHGc6NjYZ0lB0aJr2oJNT5b72ub8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnfPVkp/bZdk9zIf4R/G1D9Hmb3j+SEPfGUhU9gi9njfHJdlZMObeZC6MUIbXXwjN8Uat+wLNd3vWQGZmJpNSTsDNzmn50939uc5oXuolfv2ZfXhqoct5Hvs87/DtwLvWuLQ78ZnlIk8LtZ4+PWy6o1okkmA3qzydGLFVNrOQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4BByjxn; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d932b342bfso648977b6e.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459156; x=1721063956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuMW7CGXUFhPlboLoxSx5vwfvrEI2T/YJz3/jzYkY5w=;
        b=V4BByjxnQg/DBd0LS8MQLseUwTmPda5fJ07pKQYX6cSNRgD6iHe4uOM7WFYH2+TLux
         OCkbN2pztzggwyv9HryyzoGLtkscx5TcSNsVb5AS0Bi3Al84bdWg0oDkUQC1TdBE8fpp
         BpJMC5xpwPXxzMXcw47z4OA9pKxXBhzrS9+K2lpBWP6YayD4Z2QiW3Z89G3dZiZO27E7
         HIY2BcJHuoOTvXV7wGKwgTpItemk6AqBIuc58LDe6+A1NvJxTOb8O6fRXQrOdNeqFLqL
         lhKBAGeRTAjphssx6PKLrqikg5GQPO4AOrE6lJyrboyGso9shcQp4hWyH/iZ+auvrbqK
         9MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459156; x=1721063956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuMW7CGXUFhPlboLoxSx5vwfvrEI2T/YJz3/jzYkY5w=;
        b=eFu4yb4mGpEeAtknXULXguTxWxvrzaxfKfz1xznUX34OlJwvyqMS9v6KWUxbP5kRRN
         MoibeGH2ixi6H+MCeN+KAvQlcpqHUFUzDA/yyvxyOcpmNRLJaBjvUwONQ2sarbUjIdh4
         cvoDESRd136ezSqYMH4IuciImPLdRghSRCCVcHpXUMIacvUk5UF1Yeqh4B6gejWFQkP9
         rN6H3gRPrpbW5WYbn4nVhbp0YclEMYUxsUBcXBqvMO12PjJ9PIS+SkiGWqrjXV2DJufV
         apyaOvuDfbvUMZ5v3iHApaMhuWZLlIP4HpMWUYY4///8RbUyUm1TuZjIyCeFTSRLuN+2
         nwTg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwT091f23JX8g2Dh1VnkY8qQxZj8jvNCWxcWxMdAPBz6tlGlXtMDhVW4KgKHAGQ+oaAeL/LYVyqCPNWjNwvEqDtkZ
X-Gm-Message-State: AOJu0YywhQN2qlMRB+5Z5wUPqvDmw2to9zeSqGr6DOa8DXTtbww1+U9B
	DelNOVLUGtUFxziFc74KxSlq5v2s0jMgHriJ/BGkADcWyZ3LRQQNJiZ58q56qHyNcoCsJAV+1vF
	wYJAkj5tT4/lx5aN8+DBE3KISSzRWSQ==
X-Google-Smtp-Source: AGHT+IGPXmH45cgvPwr6eJj17/TR0HWfczTLC9Xq5FOIp/BjzD41Z5DfEzJPdbAabjETehVqhNYBrUpxn/9H3E3PI5k=
X-Received: by 2002:a05:6808:130b:b0:3d9:2697:d398 with SMTP id
 5614622812f47-3d93bdd179dmr29265b6e.9.1720459155975; Mon, 08 Jul 2024
 10:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704001527.754710-1-andrii@kernel.org> <20240704001527.754710-3-andrii@kernel.org>
 <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com>
In-Reply-To: <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:19:03 -0700
Message-ID: <CAEf4BzaJf+-+GSGoDok=uXPXishJtOcBEt3LhvAotGhpj7bQ=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix BPF skeleton forward/backward
 compat handling
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 8:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 04/07/2024 01:15, Andrii Nakryiko wrote:
> > BPF skeleton was designed from day one to be extensible. Generated BPF
> > skeleton code specifies actual sizes of map/prog/variable skeletons for
> > that reason and libbpf is supposed to work with newer/older versions
> > correctly.
> >
> > Unfortunately, it was missed that we implicitly embed hard-coded most
> > up-to-date (according to libbpf's version of libbpf.h header used to
> > compile BPF skeleton header) sizes of those strucs, which can differ
> > from the actual sizes at runtime when libbpf is used as a shared
> > library.
> >
> > We have a few places were we just index array of maps/progs/vars, which
> > implicitly uses these potentially invalid sizes of structs.
> >
> > This patch aims to fix this problem going forward. Once this lands,
> > we'll backport these changes in Github repo to create patched releases
> > for older libbpfs.
> >
> > Fixes: d66562fba1ce ("libbpf: Add BPF object skeleton support")
> > Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
>
> Great catch! I suppose it also sort of
>
> Fixes: 08ac454e258 ("libbpf: Auto-attach struct_ops BPF maps in BPF
> skeleton")
>
> ...since that introduced the new bpf_map_skeleton field. Not a big deal
> since it's new and not a stable backport candidate.
>

yeah, I put the original changes that introduced this
bug/inflexibility in the first place. Either way Github releases and
backporting will be done separate from the kernel repo.

> > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I'm guessing that you found this when auto-attach silently didn't happen?

nope, we actually got crashes due to memory corruption in our internal
production testing

>
> Nit: would it be worth dropping a debug logging message here
>
>
>         /* Skeleton is created with earlier version of bpftool
>          * which does not support auto-attachment
>          */
> -        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
> +        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton)) {
> +               pr_debug("libbpf version mismatch, cannot auto-attach\n")=
;

ok, sure. But as Eduard pointed out, it's not really a bug or anything
like that, it's an expected backwards compat mechanism. I can add
debug-level (or probably info-level?) message, though.

>                 return 0;
> +       }
>
> ...as it's a hard issue to spot?
>
> For the series:
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

