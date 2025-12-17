Return-Path: <bpf+bounces-76875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89198CC8BC1
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB37B3023D56
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7732ABFB;
	Wed, 17 Dec 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG0M4DSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4F329E77
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987992; cv=none; b=Ku2ieV/IniEbJlOd2//zLMbZujcw6A7Z1QuBj789TUZfoFbjSiUcXf+S3gyDi3sBP9J4e/d8dSyJjWW7lim/mK42+23u3kJLnY3JntZw7NL823/U3DnorB0pWzs4PlYLgK47maErryzZg0/YydIPZMwKZ9Ju9NLdt/Aj3D9g/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987992; c=relaxed/simple;
	bh=27FhYn+Ldk8zA3WnIB5TNv2dJawoPgWOKh1N09wCfPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHdVllVqfE2W1iRJNxnZ8Vw24BUnTO7+RHgqjFFZ/YPmMJ3qSzPp0j6cqd5bBiee2PIwLudn15Wge77asvrDIpxUoPpGoKsEIJUTHmER6Bij+70IpXb+GbIll7+VrUXPTezZhQy3ENzMKxbTXMiaBVrpJu3GsZiTKb24N7hbM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG0M4DSo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3601903f8f.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765987989; x=1766592789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/M0yE2CsY+Sdgb0I+EEYUMGlPLpSRD/fQQ/bZ/KF1k=;
        b=LG0M4DSo9RTe6k3wzUAOqxa6Q3wKFLS1RWLXT+qtx/gYpXKMcXsu7iVh963OUUdRiz
         /9umNclABqR1FI4fN4Aplro5sgQYYOQWewLIM1XIjUGKD+4PYHwyjqPWSwnu11w8AAjr
         XqoMcZDgiioYF5VaiAT+ansz6eDSbhGypuv81/VZ3bZ/aUvekkTn0aJqoZhf+nbnL9kJ
         NGZj0lJm0AXkTXwaE+umUDuD6L7THze3/2rS+iDq4d7mFz4KvQGJsxU3oBDZF30rB4oZ
         i1YnBkNuP8YSi0KQddVw//S9W3QqaHyPBwaRxD86Rx0QLfdP6R+XvABX3eyNa9QHZnG8
         O96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987989; x=1766592789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/M0yE2CsY+Sdgb0I+EEYUMGlPLpSRD/fQQ/bZ/KF1k=;
        b=T5KWpmmIhZArt/Yl/u4qnncbsSGKwBZAwQa2eSYwE616pqeYL9JR16oebX+Lqm+0EW
         1mChyGN7CMvbXo4zSMA+1dlfOnhDit+IlA/UZ44mUps1dzE/o/SqF7YlIHG+rYEjVS6z
         2S9wj4mMbJPI6ELwqCDBCwvx9TvMCg2d6clHAh4wyOjjlhwCGfqWNa08tkXMhxQe0n0S
         IJRrZ8sQw24BKlcSfRscD/pYfPW0h5n61z1i9E3Io6AUUSZEL5WOT1uD7r7VL3CyIAcS
         8fFh5pQMha43LBjHEMXTBDiGKvTwTxaRqnYBrnxA1afw1AyptGrWwMhbM2WGJj9f4ng8
         nLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVths2a7pc7MLKr4grb9Iv0y4G/jLBnKs5MImF0tBtErhxWnGZKNP6RuOBTAF7As3hhuY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJ50XPLAbLI15j74XRRfNgHWgrD+Y/xWxra+w95crurej+Iuy
	bL/bORi0LQNUCzNycQd1u4gVa4yScLNZ34j+du/c84Z4fdQWZWroi3HOVddP3Lei1yx4UlCzBxI
	zNmLyPwTTHC1l6uwI3blqbiWX8InkCDE=
X-Gm-Gg: AY/fxX7JTjfTGKLmT6UnCs31FsUOncFjBY167bPTN4J6aZSr53WkbCTUMcCyHsSqP40
	tpYS2SmVCP7QfpSyBDAd7HFYXg7HQ1FE2jWY1PzVFZ/LwfkxTIySkGjlentXMwLTokTh4ucuj1d
	f3Z7dqKAHIp2OHuTGqrro6waQyBfdfbM/eCSUa2Spwji+wnteVZL9G+ynfRUMMrpMgUdbMn9hiA
	MkrGS9QsprSF74cibLHvJO3BgO++/ug4MlV1x7TfBX7JHn7N3xcicOP7ecB2IY0NBBjxrKn/oED
	oQknmnuL4bTo/aJVjwgizgPCaEkP
X-Google-Smtp-Source: AGHT+IGq4/pPJ9cKS+GAdJxc6PzbjiCHTLLzfAeNabJrf/Xb9K0c2vh7cp3sXxOcg08lmJi7RzNf1ueujJu3YUGSsNQ=
X-Received: by 2002:a05:6000:2411:b0:42b:396e:27fd with SMTP id
 ffacd0b85a97d-42fb46e5003mr19359495f8f.38.1765987988426; Wed, 17 Dec 2025
 08:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com> <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
In-Reply-To: <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 08:12:55 -0800
X-Gm-Features: AQt7F2qNhk3PJxTwbXo5dgGQTN8lTn3UxzMnqTQAWqhMsLAcgLURZ5HRMYRydhs
Message-ID: <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:06=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> struct foo {
>         struct foo *ptr;
> };
>
> struct bar {
>
> #ifdef __MS_EXTENSIONS__
>         struct foo;
> #else
>         struct {
>                 struct foo *ptr;
>         };
> #endif

Did you test it ? I suspect AI invented it.
I see nothing like this in gcc or llvm sources.

