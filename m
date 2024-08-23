Return-Path: <bpf+bounces-37998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418595D954
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683E7B2225F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444971C86FD;
	Fri, 23 Aug 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5IAnbwH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0821885AE
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724452995; cv=none; b=n1iUiI3LSTSOfQqNwD0MvhB9VIByz5/HmWTmJuY6dZ19UGF66Ffg0jeoWM14cpTaDbnE1l3lajZaUG+0Rdgq/+EY/wW9ld+wTNqn+KnD7cFhzO5cGqFWSYZsQT4TlOqZfQ0AeywHgLHXP8R3NAK/io6brqQMHt+Hlsgxhjxa/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724452995; c=relaxed/simple;
	bh=jJdDXyQb3YzwgPPmoZtSTHIlexWKnFj+0sCflst+hpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n13Dut8kEDHHix/f5nGIqZA3SbbzrFdgX/7Tr2kBnxdIqw2WYoEL9uLn0FRBV+zl96pcBO3qGnMnVcZJYWEs6lpOFd40HjJz3A9yt4HDH4SMmFSlpbvps6nQiQpOmVwGgL34eYiIYpI5iEgbaJ2yYkhWYTisEj4g2VS8ZQXfI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5IAnbwH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ab880b73eso20093175e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724452993; x=1725057793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJdDXyQb3YzwgPPmoZtSTHIlexWKnFj+0sCflst+hpQ=;
        b=U5IAnbwH8umKQspZM9SznpxvqdhEfj3ttKPwraWuYXzwwSJ8nYkCRrVZn+rO9CWlPn
         oxSOnXdGj145GGxDKrfjMuWWCeImdAX9tPwMgXanjeVUxC8IhWvgLDRxw0C7FMRz3LS0
         dR9WJudpxBA9ACuxg3ovigAn4CSJM8QzyUA77e/bAcasIdn5MAglUK0FglldidJtzU3P
         Shq9of28rh2AcYCDp8ZonymFLesLfNWRnkOoFPiq7ndRsWn7OMRt5I/Zyh+BH8LYMr9p
         /FD6IdKjPeZzZ5jKcgCeMXqe5S0oYqXQOgcCBNWpZdCMQpeY5Q7dkqE6vwv/eqr/0fv3
         m+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724452993; x=1725057793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJdDXyQb3YzwgPPmoZtSTHIlexWKnFj+0sCflst+hpQ=;
        b=LgF2IDgZy/2Q7HPpiniANIsMELOWSmZU+9DPozVvbJk5VYSWzRM7nk9lGa0akrTP0p
         h3TCrbFl8LckT9dptthDbS3R5Jv5qXongZJyCwLNiDsfSnbkZhByIVTnAzKt8BTtMd5W
         0pP9wa5VkuI0E2StJ5QqgUsG8k1OK2ukLu42aPWwjnHtSZLhxVsFtrliFBGZzHCLg5FD
         fTsynBzOAA6jiJ0f/G2C6EUmZr47Pe3mvgNHn7U2dnPplh9/XieTKrOtJ54xaKIIX6j0
         rhRlDQBpIr2ynHi3IR+YimWuNIjWdlVZe083DFIftwgRTyNHu53oFZeMpXNqRUnyhzqm
         BWjg==
X-Gm-Message-State: AOJu0YzaQm8DZU2ICqiBkloWZtaUGMDYiO+22Cdnx7++DFTN0JNdzuYB
	xx1HvRv+EiErl/u2YJzXcz8Ezb/EoyDh3DEfetJYVXd5nCpM67Ht/84boalKxT23AvGU6nD84Rh
	WXlWuksnh8CpqwHiWvRCWHHEaLxc=
X-Google-Smtp-Source: AGHT+IErHa17Cz/I+xqatgwE4SeKs8qUS9mDpJxvj8LEAXfoYWk4HvfIESdF0h6+XASXFcH382CqvqtHDROnJjNlMGU=
X-Received: by 2002:a05:600c:348e:b0:428:17b6:bcf1 with SMTP id
 5b1f17b1804b1-42acc8e143amr27618245e9.22.1724452992368; Fri, 23 Aug 2024
 15:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823195101.3621028-1-linux@jordanrome.com> <20240823195101.3621028-2-linux@jordanrome.com>
In-Reply-To: <20240823195101.3621028-2-linux@jordanrome.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Aug 2024 15:43:01 -0700
Message-ID: <CAADnVQ+gtj2O_U5uEzp4C+AMf_ru61_-WLcanfVuBVKOKKjMxw@mail.gmail.com>
Subject: Re: [bpf-next v10 2/2] bpf: Add tests for bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:51=E2=80=AFPM Jordan Rome <linux@jordanrome.com>=
 wrote:
>
> This adds tests for both the happy path and
> the error path.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>

I fixed the subject to 'selftests/bpf:' while applying.

