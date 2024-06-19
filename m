Return-Path: <bpf+bounces-32480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6A90E0EC
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 02:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD90B21749
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C056D1103;
	Wed, 19 Jun 2024 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kILstslU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA31878
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757223; cv=none; b=ianY3rdsrCoZD22wHfV9PuUcjvguSYVniVNkryqF+lFf/FhGh6aXmeWiSxPzlaKTgJiu4HELyDqGyFnNqnuMvco6HOlJv14rzYomNj1lng3BzCsVnf0KKWNycY79OOrlRVxPvSwkbYBfNF0tu+xdVCwwrmph2Uzxb3c2MQ6jyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757223; c=relaxed/simple;
	bh=dIfIWnwpavEuRgXCy4LQWlU91z5uZAEgYrfrktygM5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCLkWoO20obFrsAPzqErcwsDfE+tn8Pe+MoGzT5byKT+kesxVKAfnxoAkjK8YRJl4DKJNxambv24J38mTn0XsTJg2r+/tVbDYABN1q5OMt4LxxV6BNMqVqR6wfeZ62dPbf5EB03YgheBzPo5MjdKnz91x7OY1sPSZMBQouxajGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kILstslU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-421a1b834acso51223905e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 17:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718757220; x=1719362020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIfIWnwpavEuRgXCy4LQWlU91z5uZAEgYrfrktygM5Y=;
        b=kILstslUqc3wtV4B04SPInZkY00J0+EDTzKkEHy/n78A9UQWsBy0OvFtjYWvIblVRF
         RvQpYzam6BO4vYzFMNz05IHFVhilRKF+U/dzc2TsXmWHR9UvqYPc3W99X74fHcO0oaSx
         +mAutwgYn3/wBLM7cbg8aJG0FYDjSkX2elmVnoJskQgOlCZqtncN9rZCQB6/EECvow7W
         5t4HYz8WSsf1lR0cFDj9+F1y2d22v7nsarcnRuz2NkXXI0w5g8Q2hCH0ggrOAkh0SvNZ
         yKsSvygR86JNYtA9B3CX3RVCZjYJhHD/Lasz2bf3cHc55FfzJ0wZ5BfX2d3qn8SQ9vOF
         bEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718757220; x=1719362020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIfIWnwpavEuRgXCy4LQWlU91z5uZAEgYrfrktygM5Y=;
        b=Ac55BHbOZgAKVhj9qnwJ4A/It0mCw1R5w/LH4Hbw+ZJIIsqaxPyEHDWJUUSlNA166h
         nukfuyvhCq+ydg8ZuW+chxIwPAtlxoVNTAaCcZAVqQ/UtbikSmK91gUwtdJ9Ae7THGeA
         Pb8uEK5CrHqyWSfNLvjB6Mj1tQVhnbaMtisOSh5ILuZZI+QoxaQHPeOL6WAzQCOD1CMn
         jTEhyg+019Qb/lc9g5UNVm158ZZffXN+2YnB36dxMQxLiJlN4nBARwp9mF+ZFp6x22YJ
         8kWamKejdTV9FkPk+UEkIN+YSSMtFJJAD/r2HBfMcWS22LvFJURknv+TZS4kq3I9fONR
         x76Q==
X-Gm-Message-State: AOJu0YzRe/8NJwpERKbU3a63tjgqUE86/v8berUlM5G5nmbNjjxim0Re
	Gokmu4GCtOVV6MilkPK8TCClm6WiQdSUpfFrEhrE9U/B929HWQJwsMzBllMSkMzLFYc5CXX3Hpj
	cTbZVlwINFKh63jLjuNq16fZ4PSg=
X-Google-Smtp-Source: AGHT+IGVozjQ+roTZ7Y3uGrkalbMUVLOroGyrVRfg17NCU0mqCJ2XDIWQsOM9l84YkuPMEhg+X9Vyld02/9k2vKaj0M=
X-Received: by 2002:a5d:660c:0:b0:363:13bf:e7fa with SMTP id
 ffacd0b85a97d-363193c4f57mr779974f8f.48.1718757219984; Tue, 18 Jun 2024
 17:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
 <20240618184219.20151-2-alexei.starovoitov@gmail.com> <5f74aaa8b05a709cfdd42748128948c2728d2ae8.camel@gmail.com>
In-Reply-To: <5f74aaa8b05a709cfdd42748128948c2728d2ae8.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jun 2024 17:33:28 -0700
Message-ID: <CAADnVQLgbPV455UkzLpLFZXK0gL9wENrxUH11Hz6r0xeTb52+Q@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Tests with may_goto and jumps to
 the 1st insn
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zac Ecob <zacecob@protonmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-06-18 at 11:42 -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Add few tests with may_goto and jumps to the 1st insn.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Nit:
> I think a test with conditional jump and a test with gotol are needed as =
well
> (or some of the tests in this patch could be modified).

Ok. will add in v2.

Thanks for the quick review.

