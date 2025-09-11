Return-Path: <bpf+bounces-68193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF7B53DF9
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4905A635C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70342DF3FD;
	Thu, 11 Sep 2025 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln9ho24i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC552DEA7B
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626960; cv=none; b=Hfj2SyOqc8TW3VFL17qIoIGOxAo8PDlnU9PluM7eVoHMjXVrG9dqZKDfV054qeudzAa/wLWi3mML08EIrqb53a67Kk1nt1mkifNl+o7v1Ql/8strSnf1VHBmyYiOCdBE2i8by4tum1RFN+oxcl3XQwK/9/N2anDwRZZOrem3owA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626960; c=relaxed/simple;
	bh=JCRX0D/Y0s922tDeBz4JsVrDDG6mxAhDC/CrPcqL/+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3wZT9dfGr53W3pEPz8ZMNBleMAiEniAtAy3KWbgZOZwKcF5oEwTE0ipZ/s/PSivAHzL3KMqicsC8JcIf7QwXIJ1QRDNNcTYfU0+QV2akuSF1cBtZ/AIiNeWkHYX0jMyMMzeWRv2yRRCbe97o38D3BUuOC+qmEzhPQbK0NTy5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln9ho24i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so10620945e9.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626957; x=1758231757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb9pbDtAT1HZdDQNFnfmnmPWHjns4yOgwnuRoU/EwoM=;
        b=Ln9ho24iSisXQvow1dXRVHhGFrIhO3Rgve5jxIvC10pt7pJKyrKFqKynQkN+GpP0n0
         SC28hlWyixTcGwHBlMcfZu2TBBDUdVle6+Mvt4R5xgrAfclnxE8Veeywjp80ev/YHrsP
         YcunO86Hwham2zPAN58doxyHRoXf9c7Bv/Fnxnd+ZqDKvcpdtfn43mQEtbYP2qkRy19q
         FZR2cGvoM14lT1ZDVGSXkZ4aMu6D7Mu0VIVHxkrOgk1+vQqN/1aALqJ9T8bxcgn9IXw3
         aREEfGDrnSujcNw6lNsWjxF+sFSojva3Yv1FhHz3O+D7/LCpi/Xpin+uVXHoxOGfkMEF
         0cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626957; x=1758231757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb9pbDtAT1HZdDQNFnfmnmPWHjns4yOgwnuRoU/EwoM=;
        b=Rk0oO5tFfdeMlTU0Sg9IaRvH7ArmxD5tQhy8n6/yp9ej7DLJe/2f4bKtZdhvi697Ta
         iC7F77EDgLAEXkRB9pnNfAi5aYGorUNF1TQhYMFfvUwny1KnKVixIUdKAh3PvoM7bbSg
         xZM1g74lptl7jxgQ7jfcUOmtrGnfd9Xvi5r1YeAMzDsADnk8an8cX9uyICsTleS5gSxr
         xAmUAV1jlJDmLPaWI8+9y2JbqZJIJ60VsaDp/aouLtgEYVxLbPjok8FZInmMTfe5rUa7
         Rc+ZjdYgGn2q8J/C79AYBFnJcoUN6TV14Oz5aMg/8KrIuzXEfA7xvDwKrG06wnL5Vh/4
         MRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyu8nO6tMq5XhINbcDFdUk66wfDedQH32BYmArOpnoFquNQh9d3eRd9l9a1xNExvoj0q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ10RJ94gFmdpHYaK9OKZeyG1QzinEPwrpUB9gu87GISyhn0VG
	Hovxw1UuYNuiBGfJUFoZ140tGd2lF8WTMJwEcSDEFganOJpwYDAywkG5aVzwDyiSJipj6FOCGpD
	JxB+JoXkWTves6r8SKEAebjPgmbb7eVk=
X-Gm-Gg: ASbGnctbj2A1jsd/h5p38vcGt9QevN381I9HpSok/xC4vynV2yOTYfLe84C93VI8ZiW
	kWJBGxuzScC22L2+K7oDvwZBq5NwjMjr7ge99ERuZiYexcE5D+hJnY0KvpzISt1Ue1HjuYhvOYW
	p7B4tYoblNo63BaRei074G8NsRwvkz6Uz2rxCUNtG0APgzpK47gTyx070+AYXIfDWvxVzO4+1QM
	6EjQw2kIuq1MWpfVkcLRLioIl3bA5tEz0PmgqtBklhkmWY=
X-Google-Smtp-Source: AGHT+IGpWdhb3hWb1MLcl/aIRw2DeMpzLK8lKylfyMbyiWpHgq1EQHJC3wTdonprV9TDW6jnSpUcUNH50Zdf3d9e3A0=
X-Received: by 2002:a05:600c:c098:b0:45c:b501:795c with SMTP id
 5b1f17b1804b1-45dfd5e3da8mr36564995e9.10.1757626956859; Thu, 11 Sep 2025
 14:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLcMi5YQhZKsU4z3S2uVUAGu_62C33G2Zx_ruG3uXa-Ug@mail.gmail.com>
 <35d7e2b8-c090-46fc-8f45-b976ffbd5dce@kernel.org> <CAADnVQL=FE0veZUFuHnwfyNix8_yU8x4_3QdtSp85G6mfYTgxA@mail.gmail.com>
 <20250911173936.3981f416@gandalf.local.home>
In-Reply-To: <20250911173936.3981f416@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 14:42:25 -0700
X-Gm-Features: AS18NWAXxtZarok7EGohBxKJ1ddMbMIj8Isyq1RI3AK8JefJwOdl8ozsD0u5bJE
Message-ID: <CAADnVQKSGs9btvagqC3kPVYStNmkMA7B-1N1OK592j=zHE=5KA@mail.gmail.com>
Subject: Re: bpftool uses wrong order of tracefs search
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Quentin Monnet <qmo@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 11 Sep 2025 14:32:50 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > Older kernels won't have this warn.
> > Also I don't know what these are:
> >                 "/tracing",
> >                 "/trace",
>
> It was common for people to hardcode the tracing and debug directories to
> short names. I use to do it, and I believe Arnaldo did it as well.
>
> > I think the fix would be to do:
> > "/sys/kernel/tracing",
> > "/sys/kernel/debug/tracing",
>
> Note, the libtracefs uses /proc/mounts to find the directory. Feel free t=
o
> copy it and tweak it for your needs:
>
>   https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tr=
acefs-utils.c#n89

get_tracefs_pipe() searches /proc on 2nd step,
and I would keep it in that order, since /proc parsing isn't fast.

