Return-Path: <bpf+bounces-77587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A04CEBFB5
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 13:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31F82300E8D4
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747C322B83;
	Wed, 31 Dec 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3jKDzRb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315E3148B8
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767184502; cv=none; b=oMr56gm7o5ngh0Fn9h3L6Ix2+PvZy5OR2Q1vogI08F3Zzem/Ybepi9+xSQp79B3w65U6i8CQJ+RZIcK5I0WHw8Zl+vpR5TyF1/2UyNJwyWfL6Aq/77rA6Vw9/P6QkMSEtP17MDBHt0GL89gGDR5+zpc1xzyIG51cXdPnwa85RtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767184502; c=relaxed/simple;
	bh=0b7e3Q4nvnJzzXG4VuhNpxvQcZV5K5/GkMiEmT25CpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE7YtiJcodpBsIR0NGjrtSJiiRgHryPWPLLm9oT9KL36xr4bPTkhtbDABR/7hRm427SGkAHXpLxCaKt9JKXhR3IwoSH7hKlmZ1gFP8tEmiTCEb+Xt9aModEqrrFR+TNfwFXnHFLdsa6jP6ffFzR8dAYjhxO1wTa71rq0McFv38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3jKDzRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FC0C113D0
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767184499;
	bh=0b7e3Q4nvnJzzXG4VuhNpxvQcZV5K5/GkMiEmT25CpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X3jKDzRbZTW7iInNHx/Bp6zgFDr0bTKcx/aJHrW9ekeMRgp7rib3J3jUHZv3izM0Q
	 ZMxUfPnwegSxduE2Z/2d7RODDTrTJSn3mA1XDtGyyd6Wk1yaNqqTMdQOhI4cqRshrX
	 AnpVf5oDB+wgyqO9jds7zO/EDcxahHfBqr1GPdRS56S9vZEPC44drNc3sJOS2QCgWW
	 +ivoQj6PI2NdQqg8rHLSHxVoRVLcS5QkFJkbr5jY/EIJsa32aJBA5LfQKddYI/P0Eg
	 o9QtFgV0jYwRO6fvkj8NFdaXH5in//Ix6/flZWrBaUa6O53JfgJT5IbsuaCXpzix+U
	 JuztJXlYnxszw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7eff205947so1538005666b.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 04:34:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yz2FEb0vGDVZa4fJ0Hy0z3w34038rWoLVYnKlMmLL5bThDmR2bC
	DRwTCyZVCksRyOaOxVL0UDfGegCP7zfgUz6/1ebVaNgsv9obs6FvCXt4YN/Sh0E1OybBzLfXirO
	ziBAWUdqubDrIEfMC0Cvr1fMzPGTFkdY=
X-Google-Smtp-Source: AGHT+IGXYzle8rsVJdOQ8Wpp6OoQEfXdEV8R5kEW66gLg4xpla5AOSlJjpClTDtvf0IgpCzJgwMj7lKdYUwh9x4kFgg=
X-Received: by 2002:a17:907:6d1e:b0:b83:8f35:773b with SMTP id
 a640c23a62f3a-b838f35775dmr598523066b.54.1767184498401; Wed, 31 Dec 2025
 04:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224192448.3176531-1-puranjay@kernel.org> <20251224192448.3176531-2-puranjay@kernel.org>
 <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
 <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com> <6d032492af465929e1e02c53a479f71ef8964d76.camel@gmail.com>
In-Reply-To: <6d032492af465929e1e02c53a479f71ef8964d76.camel@gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 12:34:46 +0000
X-Gmail-Original-Message-ID: <CANk7y0jdE-1cVE3UsyQaC2HwZ0TyjPZr=q=c4meYjH27PdUwJg@mail.gmail.com>
X-Gm-Features: AQt7F2oP8dedVZUGVP5VjX9pABbTeEGmaCxv7N3_Ba8Dk91T058Brj2rtZvqzT8
Message-ID: <CANk7y0jdE-1cVE3UsyQaC2HwZ0TyjPZr=q=c4meYjH27PdUwJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 12:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-12-31 at 00:08 +0000, Puranjay Mohan wrote:
>
> [...]
>
> > I wish to do a full review of all kfuncs and make
> > sure either they are tagged with correct __nullable, __opt annotation
> > or fixed to make sure they are doing the right thing. But currently I
> > just made sure all selftests pass, some of the kfuncs might not have
> > self tests and would need manual analysis and I will have to do that.
>
> Ack, sounds like a plan.
>
> > Some kfuncs will have breaking changes, I am not sure how to work
> > around that case, for example css_rstat_updated() could be
> > successfully called from fentry programs like the selftest fixed in
> > Patch 7, it worked because css_rstat_updated() doesn't mark the
> > parameters with KF_TRUSTED_ARGS, but now KF_TRUSTED_ARGS is the
> > default so this kfunc can't be called from fentry programs as fentry's
> > parameters are not marked as trusted.
> >
> >
> > Looking at the code of css_rstat_updated() it seems that it assumes
> > the parameters to be trusted and therefore not allowing it to be
> > called from fentry would be the right thing to do,
> > but it could break perfectly working BPF programs.
>
> Indeed, it expects 'css' to be not NULL as it dereferences the
> pointer immediately.

So what do you think is the right way to move forward? it will break
some programs but for their good. I think correctness and security
outweigh backwards compatibility.

