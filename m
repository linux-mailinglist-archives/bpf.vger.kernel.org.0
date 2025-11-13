Return-Path: <bpf+bounces-74428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A243C59686
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32A650329C
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81A2F83AE;
	Thu, 13 Nov 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a70/uYfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481930CD88
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054461; cv=none; b=MUJrEcIF8IAky2GMhTSC2/sabKYKvDOIkQba18iK2t48TFjG7eqT65h3i1cQF7CgcZs1Ee8LNRQb6H3TD362n37eirSQUT19YzUtKipPn8/nXP0a4YMGd8hRXjwtGnzrJ6K3MwzGXILHKS3IDhL0BjJn7G7URAweTxY1B+MeMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054461; c=relaxed/simple;
	bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbxcHGNop/St6tizUgiHkK4Rc1l6kOn7QtFjFJy4jM3u8aNwg7nwrhtRmTdI8OHzDF7QZTL4jVAEaXLnhP7NCMABT9f3r+oSQKt+8OVf9MKvV4xRJBo/kbZawVGfwE1vplyB0CO+faKO7C9Cs9JzNcOXIkUrmfvWedCWLukh+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a70/uYfQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso647781f8f.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763054458; x=1763659258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
        b=a70/uYfQuTgr3k2xxALfpdE+QRYDRDG+ZiUFDfexK4i1vPMjSizPrsckDusIlSM2NG
         T7qAMg7PPMCxqq7a+aXY5ieyiNlfovDQTxd9UidCc1aYqUdlgIcUCyhtxFnmmcxK+pNx
         WQdaaReNYvBh6B5K1sM0xF07zKpLnKnOlXn5S3CbeZK1VXEZmkVUP6yhC0KLMBtVvh/D
         T4Zk7m2JYWjRSDZz6ikVZQAOyqhd6od2U+NvqurxXGEwUV+Qi8LNxWavyY5Wa2tSWBwx
         HHw9oKNuG/DpTQnCyGAxnRsxXhfnklfz/6OuCU7k1Iz0+/N94YNyNmtZN/5/THOnGJDH
         YVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763054458; x=1763659258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztuiaKnD+yWEMM5b9BFNroowD4ifQN+vT3IcDBlsurA=;
        b=prZ0F7kI3eFKgW2WQFR/WheHEbuugeTkOZpinHPDfqHqibU/1wgINTvm/SIXCZ1k7Y
         DDQ1m0ANR4VCufkf1EO/I29GkfHRlURUmSJJ+iyqR/zIsrt2fzuCGFZ1NS21DtQKXeJY
         1HGezPwe3lQ9BjRKv5IAfN065u14TD6/QcmkYRIKiEWiAcvqGK5z5OWozhrgMeBXuSop
         VmmG52U6Bi+r4e5VNjxSDb03eL2LsCSFSMtkVf4TTBwiqkZ2b2o29blQ1D1zz+uVJL4A
         +ujpJpUd/Ycw65QSAdaTLZSdP1lU4cKhEym2JW5jTCQOG8Vur+Cb12UHIoLDGjM8VTtD
         IH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9LHP1Y9U9AZsyUaP8PBx9M/GU7YE/k4P6m5TOr3P60rHyiLcbq0GhmHbzXwtV2q9Jwpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Rx1ZF1nkq3NOA13IbuWZ7tqfrbjx7rZLcDLXuT+tm1NEVZvA
	mkGL4qNBDVAEtmUCo1oU95pRqALjEN91ISKXJWf6oQm2ooDQk71rlMQQRG22kYth5exuRrvQl2p
	8k16YwIJVRsaXxG8L+8HPDPm96Ka1+sY=
X-Gm-Gg: ASbGnct53opvHkmWJG6JKuHE3tya4n2I8RJUZo0R39MJ+qe7iefXzkDzIt9FqzUnSMw
	cxM5eSTJsJB90HlA7g9GDEOgGn5Q2Q5Z7CuOoMh2/3X1nRGClC2PWe6sE5hiMhEFxn/K4RYp7V6
	8pa6MrPmb+qMmNRkmSDtjgaF1FFhVva5dvxl7PgFngvpeMJnRvqMNmh7gPsXLTBDef/lpBjCwP4
	1/te0YlmA5RQ4oTem9uoIOkMT0euCJOovYLsNR63vI48lBL5tND4302VgFqA8bMrfmkCEHEVtMK
	an+3krV2bLQ=
X-Google-Smtp-Source: AGHT+IFexBzERRqEOeduYo/jq8Gjn9rqtZFbfZHoVzMREkhVjwVRm9s8zp4/bVSVMyhcijrbYEejga9scygQSLJEjjQ=
X-Received: by 2002:a05:6000:651:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-42b5935df1dmr187498f8f.3.1763054457715; Thu, 13 Nov 2025
 09:20:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106012835.260373-1-ihor.solodrai@linux.dev> <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
In-Reply-To: <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 09:20:44 -0800
X-Gm-Features: AWmQ_bkdhBLkmzEsx2PBtYFukuxhtCYUyvi6M7hnPybNPl0_2PlSHrkAKxPSNTg
Message-ID: <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 06/11/2025 01:28, Ihor Solodrai wrote:
> > This series refactors a few functions that handle how BTF functions
> > are emitted.
> >
> > v3->v4: Error handling nit from Eduard
> > v2->v3: Add patch removing encoder from btf_encoder_func_state
> >
> > v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.solodr=
ai@linux.dev/
> > v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.solodr=
ai@linux.dev/
> > v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solod=
rai@linux.dev/
> >
>
> series applied to the next branch of
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Same rant as before...
Can we please keep it normal with all changes going to master ?
This 'next' branch confused people in the past.
I see no value in this 'next' thing.
All development should happen in master and every developer
should base their changes on top of it.
Eventually the release happens out of master too when it's deemed stable.

