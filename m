Return-Path: <bpf+bounces-38065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26495EE59
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B02FB23894
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420901474A5;
	Mon, 26 Aug 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnsuM+S1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305242E414;
	Mon, 26 Aug 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667523; cv=none; b=sP8UcFSQzovlcgkO8WjcsMMYSFDpr2u1Ddr6zgqj+zg8SovCtRaDtphqvKauYXBWceCaMVIdcC5htmlyjRrHUxIdGFaIIQQTv+cbzqtUsBQZInmYb0aghORpjTuZ/IAqkgrkv/66ss5pUMtpCe2qdmE2voiJ5C+OU1jM1FFeYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667523; c=relaxed/simple;
	bh=bz0S7QSRtc7JtODcDyzNbKOGW4GmsMgZza30MiR3xYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofVAqkoArSi1riFs+BD9IBWmSFoQ59qy6/lXfS1omiP8C9aqEGMZ2e9zWWr2u3DQJSfuwFcI7krAPjIiG+ZHkBv1Rm6D1WO3MCf9Tl0qitiOQotQYhZXcqNikNeJKMXLCvAuRikGECXbPjfyq2qZTwC/52j5XQRePDAGhjGmZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnsuM+S1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533463f6b16so4709273e87.1;
        Mon, 26 Aug 2024 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724667520; x=1725272320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bz0S7QSRtc7JtODcDyzNbKOGW4GmsMgZza30MiR3xYg=;
        b=QnsuM+S1TyHbzEO1r3vm4SIiVTeUqMSqQB8nkM4zqEBHXhWemlszCcCbPpEzn51rI+
         SkGrTG6waCJneruAbDJAh5k81YI1e6mcU2OGp/XMUiJb41OKet0T1X9HWfoDNXEwjhcA
         Ztpa5O//7UvdYuwXxkOn7/CZas3QfZ4qoLtOpt6VcjA0eTDmss7+1HA96DIHgzEPLk6N
         hr+tHnF+0ZyCjt1pzEq+6i1ni5cP5N/b65sjR0oN8R0uOf+YaeUlGIIYBGX70BzC3nyf
         q57aP4m5zMmNdquxKZmXqymxOpMI2FP+KgviCTCNyr1XoIzF4u6GIVbzxJrP6RyEDGvL
         1MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724667520; x=1725272320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz0S7QSRtc7JtODcDyzNbKOGW4GmsMgZza30MiR3xYg=;
        b=DT0Yv3Wed4fd10IiJx7s/lEoEn8fVoSXxfJqQWwnzzArrOK27qYCvmdzaJ0dqJDSMi
         z/dxoA7abZGFaVgrmTUN8yWOPLiECFamNGdt3ifgKxC2LHKkIWc4EbQBOJU5VwLPWkek
         nLCzbNbNrU7UcYT2ExckdBnlPpUivDq41zrhOmSs60n+FU+NLW8rQMKnLO5M+bFXpAzI
         M0BtNj+HdLgSdEZ6AU/+bA6bqHupo0DTuyEOMBBLkdtsX4T9PQ05q8HzPNxH+f1fc/OZ
         Fu2R6kZUGch2V+9eRe4itLRDkr21ZZSJXtHaLwdbhjc7bnGctdKO97ts9RY2L35zAIAG
         8TmA==
X-Forwarded-Encrypted: i=1; AJvYcCU9G3MVcQqPdMGyOpENMVUIYId7IsrYugyMTdvVZUbdFtu0nl6E74ZVdqWvy6Q24twY04cwFMfpEg==@vger.kernel.org, AJvYcCWy9qaXMLL10guf5f+g2olFy7xBxqQ5ceao5DqC+HIxV4N1kxTECZiFIt7tWdjd5xYBR3htOwgFzwDNYYkJ@vger.kernel.org, AJvYcCWyqZeRIs/TSyAZO1II+PxT84uGxrt0AJ5klZYNDGODNAl7fQPWxNL7T75FZw+eUlsssWqPlMuIcHLWndlN@vger.kernel.org, AJvYcCX0BQXjvfjBb/19w1joc9d/1yC6isJwMzMqvBlLLdN5yAByZPqnNbtWZxso7LGfsoCsOL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1TBL3kDOXdBXWJvxWMmTIR/ZQChqThqyDx9oVQcB/5chD+Fj
	8Rbv1jhOCZKNO5PbgjhLbZMUEsAOJ4uQfrpsvkEsetg+R/zbQty848LzhqZ+TZW0DXL/rGiI7pP
	QhSIBYaE6xWViCVCBI0d6FnQCQV0fBhQ/
X-Google-Smtp-Source: AGHT+IEZUDabS3AfPtgjlwoMvm9tGwtqv0CiOr2sv864GntoCh69fE2bFCWwII+opI2vogyBfdf1ISxGZQFomPJ9GcY=
X-Received: by 2002:a05:6512:33d0:b0:52e:9b4f:dd8c with SMTP id
 2adb3069b0e04-53438785cd9mr7102800e87.35.1724667519884; Mon, 26 Aug 2024
 03:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820085950.200358-1-jirislaby@kernel.org> <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org> <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org> <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
In-Reply-To: <ZsdYGOS7Yg9pS2BJ@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 26 Aug 2024 12:18:03 +0200
Message-ID: <CA+icZUVL13oPX8KybWirie5zH77qWuzG9-9yTNM7O1CxwhOp1w@mail.gmail.com>
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:

> Please let me know if what is in the 'next' branch of:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>
> Works for you, that will be extra motivation to move it to the master
> branch and cut 1.28.

For pahole version 1.28 - Please, Go Go Go.

-Sedat-

pahole 1.27 segfaults when generating BTF for modules built with LTO #2032
https://github.com/ClangBuiltLinux/linux/issues/2032

