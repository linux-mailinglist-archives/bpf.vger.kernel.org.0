Return-Path: <bpf+bounces-77042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A3CCDA89
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 22:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24D3A303999B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919F333752;
	Thu, 18 Dec 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRomzD5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EF32E732
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092521; cv=none; b=t3jRcsli2EIeXH7m1EqrY5mBYbwXhHH69bkhRUvCfuJo0T/dEf/OsdOT8V82PMzBOjVLapRZknX2kuk04Ez69zZ+KDHlkwxZXeFmTu/Ow3VSiT4J+Uux56dUZCKfEw0TDkLghxAzZzCyr6lXuCaYM8n1noppaGIogufxqwFH1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092521; c=relaxed/simple;
	bh=+u/ndDGOy2lwYXuLEGONv5mRvTF27BKeHvqNtnHgUXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8mCYsrtYloHDjUdZ8ta3826royRY5TFodbqDDQyOgLRA7etlvfYL7sdjxSrRoXc5/C5gAYbIlCiApf7ISm39ac3zAEDUkd3W7sA6wNKsg4szOWh2nw2rj6xlx30D1r8vxqEu+/Ofmsyx3YmrTM/7E4yniuq5Y9mjnwrT/+mOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRomzD5W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so1057336a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092512; x=1766697312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=bRomzD5WCVaGiStF4uMWFoyUQmggtiyNoSMZN0YYJr0AX6myvxMGXwNSxvEYywwIH7
         urvBhAKt7HqS5ZcmT6//NoKvKB30p7YbQKKUrxw/9Yp7NSWH7uf8nJj3rPSkeoqfASee
         bLwLLgs0UsApIV6EofnuSIy6x/BcXqy0bHbnIdWBGoSsWiwolwMwHa1Tis2JqL2LEchB
         exTcHaVC1iBaVStxPgjyZ0cZXZpSqHIjHmFbHc16yPtq16s/QhlrGtuOB/SE2GapzCXY
         GOAg2DaXPXpzPR4ebv4b0g2YsPaToxb4lI4ifLz0IbL3D41wVcLkDDoK7oCclOMFEdJW
         y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092512; x=1766697312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=gZ6PjugXjfhxzTj3e9bfy3CfgmjOAeS4rtnqi0dtFd5dPVsIdA9gbP4UjeDFUmr4fT
         u3+Pj69DUViBSaozZQXcWaEOWlVIutxDraRbdEsK/lVpEJTQnedI3b9+pBniVfE8Tp18
         AAhk14VOgDWV87aEq+MvXn9SmwQDHQIjJKDe7P1CY1egzDHa/qEET27//7iX5D+KPNFS
         No035gf3C0TpEATQ9hfPep74nazXf79Bh10HU/FLmzUJmsBB4yEfu7Uj2ZKty2aSxemz
         bWJ+SQxSaESZcr9qboiUG4Nuf57DiUa4UQLfNxRJnaLlt1b+KJsyZei747bZPEiQ4wZW
         XGuw==
X-Forwarded-Encrypted: i=1; AJvYcCXRC/YsBE/3QXRzMDpx7Pnof9bIr2/FEElqxnTKmy1kGf5hfBANfY6TDw1PSFWUCocI/pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJimvL5HqKB6GsRaq49mzAma44AbS8WE/ndqcxxtiILgt+8P28
	UBRlLmrC1e50LFPXfnLPzEEEtwb4sNhZ1ZLayqPWk+deV3F6px1m1Oa+Bph2YjFLaDLuROQ6uCw
	ObZuIjbY4W6DCF5zJ1QOEKGN07I7kSfA=
X-Gm-Gg: AY/fxX5fbNtBf8XYytIGDVlzj3b2iuEZAEj/Jqd83+BV2j+GSrEEyXa4hU6w2vULjfZ
	9ZzxSJb+NWAgxLlCEa17gUOhEL1UUVH3m9j0vVFlWyf94zF3POSk/d0sMZDrPJAIt7fbRmm9y04
	k76a2beuwcNx/HQUmm6rMPabdeKHz5+8UUbcWrn0uXgY9i22hnXhiitBdp+hI3x2FD3HPtfE3Xy
	I3Bfs5B6RYQE1up1uls85Q+TnkXsgKI7cSEg4wmhGVjKNatqzLZbleIvI+6La4/wTHuJsYrbnJB
	UM5UvRzmVmY=
X-Google-Smtp-Source: AGHT+IEm3NVQEyLOx1ZLRWTiMXhCy/qfbgPRFyUTvXpjkk44dBjMEz9r6YNUjYCIBztbo3i6KidyFHyedRAP9nmcsxQ=
X-Received: by 2002:a17:90b:56cc:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-34e921ad800mr512802a91.20.1766092512329; Thu, 18 Dec 2025
 13:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
 <20251218003314.260269-9-ihor.solodrai@linux.dev> <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
In-Reply-To: <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 13:15:00 -0800
X-Gm-Features: AQt7F2rLX8p5L_SWnAJnu2v6iF529lekiXcU8Qp40l-At9Q7hbzFSO_mSE-UP_c
Message-ID: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, Changwoo Min <changwoo@igalia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Vernet <void@manifault.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:54=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:33 PM, Ihor Solodrai wrote:
> > [...]
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index 840a55de42da..b8569d450ed9 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -1,5 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +gen-btf-y                            =3D
> > +gen-btf-$(CONFIG_DEBUG_INFO_BTF)     =3D $(srctree)/scripts/gen-btf.sh
> > +
> > +export GEN_BTF :=3D $(gen-btf-y)
> > +
>
> Ugh... GEN_BTF is not used anywhere in v4.
> Looks like I forgot a `git add` at some point.
>
> I'll wait a bit before sending a v5, in case there is more feedback.

It all looks good to me, so don't wait for any more feedback from my
side. If Eduard doesn't find anything in patch #8, please send new
revision, thanks!

>
> >  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> >  pahole-flags-y :=3D
> >
> > @@ -18,13 +23,15 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  =
=3D -j$(JOBS) --btf_features=3Denc
> >
> >  pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D --btf_features=
=3Dattributes
> >
> > -ifneq ($(KBUILD_EXTMOD),)
> > -module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> > -endif
> > -
> >  endif
> >
> >  [...]
>

