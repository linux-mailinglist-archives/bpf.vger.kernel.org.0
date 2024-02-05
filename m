Return-Path: <bpf+bounces-21197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94452849365
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28721C20BEE
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C11B674;
	Mon,  5 Feb 2024 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dURRPXbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946BB667
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707111300; cv=none; b=ZpZlyI9odGJ0bb2DYcRyvDn6eFaEQE5//p56hubPQSl4YFvGJ8vJbONIhACzU8eugJDu4Uj48uCZn6nKmFBxibNXp0CRhJEsnKFLeyqINcIormg60uhPcX/IXO1GsoYY/ZlYvxnQ3qnKZzA3aWfzABh4AMXAzHrreIeexlENmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707111300; c=relaxed/simple;
	bh=qpHZejvDHeVIOk27AURMGrJMxEA/TKyx+IXD1gPDiOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDXc8przLmd+9yGG+Evjgim6Vy+Xxbw1vX3JoAGh7nAVVJA9vFmdZJ1oviaKeL7+BKJSr0+r79/uwF8Hi0FGrWbzSBlDSrOmEiyWLn//euMvCwJo1h14yx1xzQDYFGKcikVep/czoNUaSwEJ9bvp2/XvKR4mhfywIIiO4HLuZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dURRPXbR; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55faa1e3822so4982693a12.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707111297; x=1707716097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OB/CyVi7cHOADnu1mc7fgfI9a1sVapFmucaLMFFH8g=;
        b=dURRPXbR6cdJpVK5cbh6dVBouwk397uMK2oTwcRiOPgJajTqlfwOjAxEEWjTFUq2En
         vLHZMquVUJHEWLLGF449bgY7W4o8ggGMrPJ6i+m0xNGiQdw0jOjWXfwWIBeRJB3ks/sB
         NKQzboEsAnJSPDHXoga0U4HIOOzwwWGDyUfvZM5A2j+qcHup/+yAOSNPdDuwgRYRigpV
         w8DFxtzNCzuo5eQS8kS3D6NsozwwJ+O0tIqoDtspADK6qRAmbrt868UX5dUwBJrPAEw1
         nfhMup4SpHGE6Rf7b7QZnc2k5v2nN+kIPHJIBL3DS/rDtXbzBGpjvYdo5uG8KFpFQrgr
         62XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707111297; x=1707716097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OB/CyVi7cHOADnu1mc7fgfI9a1sVapFmucaLMFFH8g=;
        b=aMhbOBoZ0jys+dLxzzM5rB5ArWWN4nqHmCBtD4T2Ld+xkW3PWaokkm1rMQbwymYVBH
         bcF3JchO+YDL8BlwrHOsdw4n4df6Ksqi6T22sWVrerpTHyaVvOdH/n6ySosAeBzrrogw
         pL1QOVwkKi+Ki26lsdQOvJ3tTPfmrEn7k4374LTkiDvhHPd/rKYioznq29K/5o9RL1vg
         y7PpcOtQfPecwyRA/SSPEYioVIfGunSmR8SjCHCQsF8LXXjC2F39VOA3H2suMgOX2/RP
         R02aYtWQq9Iz8lLhhjaWvK1c7xLMhhdH1ZNv9TrHzyJWM3+mxYvW3jmDvVfK/MAB0vuH
         hafg==
X-Gm-Message-State: AOJu0YzX2HOnVTwj04qaQ2qkdNPb6WnFTbAC6n8o2zKRVcBBX5015EpB
	SueeI2IkNx4DG1+uk55pB2eL4uKZugaCYfvSWE5FYXr956fRz0EkcSlztVqi/yLBuoOayfkI4Qh
	cWMy9iq5yHFX86LzlG/9avKdWARTBsinu7+8=
X-Google-Smtp-Source: AGHT+IHCo+XObT3kdJntBrQnWIU5jJkeGt8eW1ZiAzMcamz2OuXOQeu6f7nyKR4kS1tN9kYNI/nK0a+7n+kdgkX/yQo=
X-Received: by 2002:a17:906:185:b0:a37:4903:a84a with SMTP id
 5-20020a170906018500b00a374903a84amr3818910ejb.66.1707111296591; Sun, 04 Feb
 2024 21:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204230231.1013964-1-memxor@gmail.com> <20240204230231.1013964-3-memxor@gmail.com>
 <CALOAHbA8_yo_6md13Aye4XW4q3Rp+WpK-VqgWiEA4fKW=rtQ4w@mail.gmail.com>
In-Reply-To: <CALOAHbA8_yo_6md13Aye4XW4q3Rp+WpK-VqgWiEA4fKW=rtQ4w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 5 Feb 2024 06:34:20 +0100
Message-ID: <CAP01T74oC+gpMF2xTaoS2RkUv35SGW3mEFXiT7z1CmBoz5Ft2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for RCU lock
 transfer between subprogs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2024 at 03:54, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Mon, Feb 5, 2024 at 7:02=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Add selftests covering the following cases:
> > - A static subprog called from within a RCU read section works
> > - A static subprog taking an RCU read lock which is released in caller =
works
> > - A static subprog releasing the caller's RCU read lock works
>
> Given the global subprog is not allowed,  we'd better add failure
> cases for a global subprog.
>

I will add tests for global subprogs, but just to be clear, it's not
that they are disallowed, but that the verifier won't be able to see
whether their caller holds an RCU read lock or not. Therefore, it
would be similar to how the main subprog is verified, in the verifier
state for them active_rcu_lock will be false, and whatever that
entails will follow.

They can be called within an RCU read section, but they can't leave
the lock in an imbalanced state on exit.

> [...]

