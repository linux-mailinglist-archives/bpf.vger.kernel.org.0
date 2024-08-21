Return-Path: <bpf+bounces-37740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AB95A312
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135A1B2381E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F2116C685;
	Wed, 21 Aug 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njAmwaqq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D713BAFA;
	Wed, 21 Aug 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258572; cv=none; b=Tmirfg6mLcyYycyieVohrzyKvDKKEfOu+6hH5XlDXLBgpCzCyZq/Y/YZYTUMH+rlWVwoHqU3PNn0hmKTnThNO0ocqyQXmCABJMXwTqafsrAxEa1sDleZpknzFRejmIEAT6tb/H7qQvsmtjTBbES1S7jNrI93ccWGu2O6c2m9ZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258572; c=relaxed/simple;
	bh=RUg69PvC4VJT/QoaTo+jte2EflazXzB30/Q7VGN+J98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLsgzZ182s5hyVHnVYwFoiVSmeSkmZuMlS+gQ2NRlwMMGruY4ZWUKXuiuu8Bn0s3njBEmJ6nW+aYb40dliHidpzvt4BuWVr6GQ8ozz6VzXHsKHwWwX/m6d/z3j1Xg9zx5wyG1sySZ7rlDo3uFijAqX5LHJ/Q33hJRkuDapGoHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njAmwaqq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714184b23d1so1467137b3a.0;
        Wed, 21 Aug 2024 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258570; x=1724863370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RUg69PvC4VJT/QoaTo+jte2EflazXzB30/Q7VGN+J98=;
        b=njAmwaqqffU0ldErG5B9HMAOoGdxrmzdHk+4EI8HfFT5DDXI9XFpTCFuYl2pZ/o5vn
         RmPY5NXAOhot0+lxjOVO7am4dE1YDWY1h+YMqiPAM7Xsgdy0izvxOBtcuilNao2+tkFK
         XPiRayCs8tdvbQkB9I9ARWwyegZpyChl517QoWBWwgfLaNvg/i9tS4ZWSHy3WjzBpvCU
         /9q7uAku4NkitdQESWROZ7d3ec68n/aCVUt7bFNqY/Vl4Li1lnTA9xVbyQltP0lAj7Td
         bIIQ2yKzKDUmTGDFm3UQ0c9Z7LTNmrM5jSuSItjTE+An1qX8tVGWOJY4FPGpN1Wf6xJP
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258570; x=1724863370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUg69PvC4VJT/QoaTo+jte2EflazXzB30/Q7VGN+J98=;
        b=aeujX9C8RlVhoJ0nuz+t/JPKWept6t5U4i4zrbdA41SQu2heYNH231PZrdjtWeeq28
         8nYAOECddD4q3y1cbsxA2gXdX+NUMZZkgCw0hUozphDhhI+tA1DJpU7UFUfqCXPIzupS
         sB3L7w9OxZVU6O8IImC3cw2DX/oEJzqb0gPLqEwid1JK4UflV2zTw2dznGEWPnKECZ1n
         xiKsSKEVhkGAaxsvDiw2iPb7zYf7QTxrBXSh8V1SV1Xxx7z2fkUFSQCkLYzJDh9Nd1QT
         ljQNjzqNItgZtEBeLDRRn0qkabueseGdudD6axwjjH2UNnvdx0/yDFG59hwE/Kvw1vgr
         5Ivw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZlijA8keoUsVArfcX4BO9aZBGrObCwRX4J0Bg+0BqBbWG1yT9FfAIvKFRaz8F5XVB/he2bRh@vger.kernel.org, AJvYcCU7xv0qZEYHumx3l6OsAO+5VT3c2pv4TBrB973IfIYssy4/Gqn4gwHyUgTGTNf3uuBhfms=@vger.kernel.org, AJvYcCUuZtVcC88q7vfvlhpKr6MFNzhVNwuWg46X9GcBMh2zwgDXxF42dQGWUOMUlMDAd+HjOyqlMNbGQIL2RJjK@vger.kernel.org
X-Gm-Message-State: AOJu0YxapGs6et2pwjJ1xb2URieNi0Oa6pj06Pv0iopQQ13o+2xKdc4b
	ScJ+iscCVQr4rJpgxZCEweYSvVzUlzR/CBIUgYW5npNXrNvkvpfl
X-Google-Smtp-Source: AGHT+IEFVDB9uKDdQcuZxWC0w8ez4eUeUcKT+aIyDYXI087So4zKKfgjfNM3pvw0j9i4MVpT8NRq3Q==
X-Received: by 2002:a05:6a21:9185:b0:1c6:a777:4cf6 with SMTP id adf61e73a8af0-1cad7fac22amr4118905637.10.1724258570261;
        Wed, 21 Aug 2024 09:42:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714131601d1sm2876034b3a.19.2024.08.21.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:42:49 -0700 (PDT)
Message-ID: <2bc94ca9dc634785c3f464576fac7450ffe8e686.camel@gmail.com>
Subject: Re: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Liu RuiTong <cnitlrt@gmail.com>, stable <stable@vger.kernel.org>, Linux
 Regressions <regressions@lists.linux.dev>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 21 Aug 2024 09:42:44 -0700
In-Reply-To: <CAADnVQ+9oy6L+oYWJsvy_yMri8vDL9jBQRhZ8nf0SEMm+mT4DA@mail.gmail.com>
References: 
	<CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
	 <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
	 <188a0d1310609fddc29524a64fa3c470fc7c4c94.camel@gmail.com>
	 <2449825072217d392b5b631e8fd394e91b22a256.camel@gmail.com>
	 <CAADnVQ+9oy6L+oYWJsvy_yMri8vDL9jBQRhZ8nf0SEMm+mT4DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 09:40 -0700, Alexei Starovoitov wrote:
> On Wed, Aug 21, 2024 at 9:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2024-08-21 at 04:46 -0700, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > will post a fix to bpf mailing list shortly.
> >=20
> > Status update:
> > apologies for the delay, the fix is trivial but I have some problems
> > with test case not printing expected log on BPF CI, need some time to d=
ebug.
> >=20
> > Link to wip patch:
> > https://github.com/eddyz87/bpf/tree/relo-core-bad-local-id
>=20
> I would ship the fix (since it's trivial) and sort out selftest later.

Makes sense, will submit the fix.

