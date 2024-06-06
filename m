Return-Path: <bpf+bounces-31510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8A8FF2A3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CA1C26357
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA05198A07;
	Thu,  6 Jun 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CLJklMT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E42197A9D
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691775; cv=none; b=ognMmDrPoJFBqpR8gybuRbvbSAR2yMUhdaKHiEXwwclNRXSmofWeSFlFlPjPwXICgobDt81+LefH2qLDgV7u9MSgiWr06NpSrbkgN3tUklXWuYG8BcwHR0UagRlad75FoLZosZ4D3YpKtBUV+WHnnVkOmjVdIFTXeXjzqzQD3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691775; c=relaxed/simple;
	bh=XjZ3RsFkJyp4hT3U/cXKNfzi4lJY4Bt5PE2RgTUV+/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk7hsLqIugEjc1gtfXDDjcNnPTKRIXtG05OQ0Tm1FcXf/XdCNX6mGjI3oxypdyHF41rwrUdip4XtGyuo+fWt7DbAXtohmBWXi2klzOMyrhCIVUOTzLedTbn2xKTt1UgNXsTlDysq9KDsIWFNkPE5FGnAqDGUuMijZMbbXcu/i6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CLJklMT9; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a080a171dso11822977b3.0
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717691773; x=1718296573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO4HgCAXhU+/fG0PKG+W1DU8GpiBtRU7JPmpym8NvxU=;
        b=CLJklMT9iCR42oWIjfdnAmSK3FZwkWOoXYmXRNlNMcvqNBiunCYPIkU+REqRQ24jL0
         uT0LcAs1DyWY3upkJYSxrqrgj3dOq2u3jlpI+PBjuWpQ/Ng4FTMhfkCbmTWkZnORE/R3
         psRvdLnaG5/YkeyoRNC1N1mWNJ4fRd+vYcv7K5LOUjccsCzSwu1JbdVd4UDursGJ2ZPw
         y07RMsxad0+2BTUc/hz2VPGxnvO/Tc0z34f5YKI0WXaW8D17CDX94bWm9q9bF821pBnF
         4C9Q6hqR6/iwEo4jLNExxRvLKdUmss9DDOpy74v5hcWSYbjR6gTPCbh+0dnT72H+SwQx
         EaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691773; x=1718296573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO4HgCAXhU+/fG0PKG+W1DU8GpiBtRU7JPmpym8NvxU=;
        b=GSygyP3bHU8jYVOK24I+ZxgGzVRsFqEAi+KR/NnSqmmjp0fKSU78GZMA3B+NwonoFj
         zdQ0emX8xVgIg0hZy6t0zfoMSRrtXGX6rCe/nKYil0JFSCY79Gp24iveY2R3wctO9c3v
         AF8M141yFdCV6qcZxcvaPDAXM3HDUYeOSvNco6oX+7a6ilAvM9N1mz8iNLo/VFAZ/8Da
         WZIO5r2JjZuDsXsGaQVqRYagzjzYLbLPGm306wpgIbAG1WaUttGIzq8szUgndo1kL/u9
         EAZvf6KioqSoC6Nf4PqwT+wFkXTd8Vs26I99UEpDRiPsIEL7R1FFf7nAuCB2mFphJEfk
         WdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyFdP7qGuBTWm7WvpVD83eakJ2tpbYClpxhAvdXgabe//9+bgZll3f4s6rEWxysVf/2+P7xy6/elE8Whq2J9M6c8d4
X-Gm-Message-State: AOJu0YzTd8vqIxfpfWWGfxKX83uAARfv9AG5CWzgYdtoFeEzke8AC9Dq
	460env7Kc9E4++ParTwSRhUBKfS7qk0YlBsBzr/tVhKiYu6SDb5Rfczmp5gj2wUawJE9BLdL5sL
	uxijJbirog22kfjKQOuvV92RjB2lJ4lz7M1Ow
X-Google-Smtp-Source: AGHT+IHFTzL0tkYjhMUylkq7TqCT7Gbg1ojc/KR2wY3dg8HnW8DQQ6pXf+KpLfuC295RuXR35sTTpV8i0JPiUSoTf3s=
X-Received: by 2002:a05:690c:dcf:b0:627:e144:c607 with SMTP id
 00721157ae682-62cbb5ab502mr79913337b3.34.1717691772774; Thu, 06 Jun 2024
 09:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516003524.143243-1-kpsingh@kernel.org> <202406060856.95CBD48@keescook>
In-Reply-To: <202406060856.95CBD48@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Jun 2024 12:36:03 -0400
Message-ID: <CAHC9VhQ1NfdPZ1WVKTnsYmMt_0Lvb0XKMS3EqLKHQrX78yjohg@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Reduce overhead of LSMs with static calls
To: Kees Cook <kees@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, casey@schaufler-ca.com, 
	andrii@kernel.org, daniel@iogearbox.net, renauld@google.com, 
	revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:58=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Thu, May 16, 2024 at 02:35:19AM +0200, KP Singh wrote:
> > This series is a respin of the RFC proposed by Paul Renauld (renauld@go=
ogle.com)
> > and Brendan Jackman (jackmanb@google.com) [1]
> >
> > # Performance improvement
> >
> > With this patch-set some syscalls with lots of LSM hooks in their path
> > benefitted at an average of ~3% and I/O and Pipe based system calls ben=
efitting
> > the most.
>
> Hi Paul,
>
> With the merge window closed now, can we please land this in -next so we
> can get any glitches found/hammered out with maximal time before the
> next merge window?

It's in the queue, I've been swamped lately as you'll likely notice I
haven't really had a chance to process patches yet during this cycle.

We've also been over this soo many times that I've lost count - you
know this is on my list, I've mentioned it multiple times that this is
now high on the todo list, and your continued nagging does nothing
other than make me want to look at other patches first.  You're not
helping your cause Kees.

--=20
paul-moore.com

