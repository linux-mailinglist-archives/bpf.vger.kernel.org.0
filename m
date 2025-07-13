Return-Path: <bpf+bounces-63136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4924B0335C
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7D73A8D1D
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1C1F462D;
	Sun, 13 Jul 2025 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUSTJ4Po"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07F211F;
	Sun, 13 Jul 2025 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752447804; cv=none; b=L8OLpaUu6O7Im/MgvL/56XPCbv2FR8/iA39AzIXRH1Ezy6efJot+dmNZlGTBpiQkJAPueBhtgRlD/apXCnbkkaTdIMjYInnLg+0kq6D+eqtFSEn7rOcEGoao4LcgOG/yHxoPWexVtZ9di7QoExm2otmAAQQ9baXE8Aa/diy0N2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752447804; c=relaxed/simple;
	bh=9kzrBuWIdjq+hahwO7p1ufYaiez3/2LISo/W7awimbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b59zt748xlHh9E/rVHQocoAIXWcS1Xo6dg5MK54NVOU0fxtlEWruJqAAU2Ba0TkEXgwFX1XARlLYWbNy86ZGDCcHHoUHgTrC9pCjJd0XoDlmqB3IUMvWQzXCTagnIDnX70vrSGk8Gjg9+tFYBsjvPpoDWErT1sc4B+Ep0alf5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUSTJ4Po; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a52874d593so3172919f8f.0;
        Sun, 13 Jul 2025 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752447801; x=1753052601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kzrBuWIdjq+hahwO7p1ufYaiez3/2LISo/W7awimbg=;
        b=DUSTJ4Pojye8wSeS6P0lxLKWFR4Uy9Zbt/+abKNAzqQnDURri5GJP9gVrecDeqpNNk
         gjLGI/x8+RZ8zYvDDXJTzVAxc1OFA9PlaJGhg8Miowrf5ZatD66rgCKVo0iSnTmpTBrR
         b5fVIZfBOC32Wz+D90ErqjDy5jBLp4bsvHh7fA1XuS0hAXf0i1dEQq8bLCOTtbYza+MD
         MonB/5q0Do7STIHWKqJnfIyRuJsAyBfdUQOD4pbYdemiq9A+uK9FghGDDPbEVIB5vBLX
         oicfd0EIcMREG8tzOV+lgGjbBrfRH9M3DcvhiQOjku0G9DMD2AFRFEWKe16TurmpSEUb
         7PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752447801; x=1753052601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kzrBuWIdjq+hahwO7p1ufYaiez3/2LISo/W7awimbg=;
        b=PMsHjoGidq8tjyX7bPXGaaFCG1kWjL7Hh2GOQ9rvjsPC6K6tj8eLeXOeBjQf2C4g1u
         MDGfb3+/R6wWdCKqV1ApwFDHzmd3AeMSZGc/fkm95N5E7lze/uCqXjyXka75r2cqHQ+c
         YLuI2ypdrEHKSOIF2gd9b82QgbIQ8mv1/h2IlDlFdDx52dOmRcMpYpkNHibjnf/jgWfk
         MQ/R3EIixXc1f+KEiLsUkfdMWsCI1zFT7hwy4qKf5V8RPn6b5qmhnBGn3wjqDl1b/iip
         biW3vYCnxklqtwD9cQd7Q1VkauZriwiJZc+c1W5RheXDF8phJW4IAr2QjcSAiLODkhGM
         ouMg==
X-Forwarded-Encrypted: i=1; AJvYcCUMBc7H46/Vh6KMmzYUS8BEZx2Ro7ehMaSWCgVSMrIpUumg3wn8CBjHLgY1SbuvcOWugdM=@vger.kernel.org, AJvYcCXXQO8JreQ4AOO9FdYHle88nFZGuSPkUVez4+NN2Rg6kTi3alVrcV2Cfc3qxpCjry0YeowJttQXp/ku/ng7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ibqp523W/8IocztxaIttV8XA5cmgVzw0ZHqJbtqBMGTNE18x
	sD3W9Ku/iPm7NeqncNVDuYzMy1rM3kmGBUv/NEkrulXWKf+LBxCGWzRvVfoB8vOqI/lFzS5aU8v
	pdoBYgbNKTn0WXZ0GyrMvxSeSjF5bfI4=
X-Gm-Gg: ASbGnctiS8pdP9lu6w83dFD7UdAPHcz+RAAVXVDrKIpbzIVMCs1cFReNmxgHCECumLh
	7ePkitLuZSBNKfFWkWLUKtX9Tm8NAji6dikxkYEsldMrFKGdrGM5iqKd5J8CdFu8AKp2I7f/SHR
	I7wDgJ5ukb+D/OPOGIDHS0QM0BVaZtW/FJSuEJ0FUBM6ZqYw5vArov8fogBmoorBhMwzNqMMBGO
	vvZF5DcUQlEKIZ2rcCFAwD5LKaYOSsJjOyw
X-Google-Smtp-Source: AGHT+IF6kv1tzrjLlZieXma2s0+pFwpXKasLaf+fuAOH/Xs1QTqBgCCUt8qkNrK3Kfor1K1glVQiKZj/bvtQn2lir/E=
X-Received: by 2002:a05:6000:26cc:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3b5f187d0b9mr9226282f8f.10.1752447801355; Sun, 13 Jul 2025
 16:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
 <c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net> <87a558obgn.fsf@gentoo.org>
 <CAADnVQJTHnOVX9uBtTS_7bfiS2SoDL4uL7wJWd0CzbXf08_dyg@mail.gmail.com> <871pqjofzn.fsf@gentoo.org>
In-Reply-To: <871pqjofzn.fsf@gentoo.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Jul 2025 16:03:09 -0700
X-Gm-Features: Ac12FXyqmiLx9EQrPW_JuefqB-ao8VsJArBs327U_NfoibcrHUDDD-Z9NFNkYO4
Message-ID: <CAADnVQLjjLoT6v3kPtVseVqPi09SU8n4buP-au2X-4PzQ6We_g@mail.gmail.com>
Subject: Re: [PATCH] tools/libbpf: add WERROR option
To: Sam James <sam@gentoo.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 3:58=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Sat, Jul 12, 2025 at 11:24=E2=80=AFPM Sam James <sam@gentoo.org> wro=
te:
> >>
> >> Daniel Borkmann <daniel@iogearbox.net> writes:
> >>
> >> > On 7/5/25 12:43 PM, Sam James wrote:
> >> >> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=
=3D0.
> >> >> This mirrors what tools/perf and other directories in tools do to
> >> >> handle
> >> >> -Werror rather than adding it unconditionally.
> >> >
> >> > Could you also add to the commit desc why you need it? Are there par=
ticular
> >> > warnings you specifically need to suppress when building under gento=
o?
> >>
> >> Sure. In this case, it was https://bugs.gentoo.org/959293 where I thin=
k
> >
> > I don't recall it was reported on bpf mailing list.
> >
> >> it's fixed by
> >> https://github.com/libbpf/libbpf/commit/715808d3e2d8c54f3001ce3d7fcda0=
844f765969
> >
> > and looks like it was fixed by accident, so..
>
> I'll note that I've sent patches that have been merged for these
> before. It's just that they're sensitive to optimisation level and prone
> to false positives. Especially with e.g. -Og.

Yeah. Compilers do produce false positives and, like any tool,
any warning is not authoritative, but we prefer people reporting
them instead of silencing and moving on.

