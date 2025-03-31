Return-Path: <bpf+bounces-54994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B4A76E10
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F403C16B4E7
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CF21A92F;
	Mon, 31 Mar 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqbC87M2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B321A45A
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451935; cv=none; b=ZiBQXCHFyGjzpraFdJFv0X4aJ7+GoFoEz9/wUip0ORGDciCLMEhg4zv3rd1aRHvhoVx6byeq0eM9WI8Y6s0S4bEGJ9BRpqJOigKxCrDY/tZ+h+pQ1SLZMWJY4tGdHyVGZajvtfUyLPzynUInQnSZCgeQUWAEuRy3+nMPZ6LSp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451935; c=relaxed/simple;
	bh=SH1xL5YWfjT5Z7iVAhIXMMYwoGmrMHQAYmn8G344WEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pjdd44S97wPCSj2Y1MCHc0Xfrm9iaIPLSOHpgWNsex7zgI8lTXt5S1lYDWr+wa5P+ZGd+LLWVdQip0hfDU9Q53ZDG1xys1N0XW5u+RDi1uTNUBrBkc99thcyqLV+nKzNNLpwlnwrWCS3preMpMyBqIw9AqLJhNkZRhcHFxuZI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqbC87M2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so132004935ad.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451933; x=1744056733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGhpAf5RBKmGiKLeNBabpZa5QO5dMHeRd3cjcMuUg5M=;
        b=TqbC87M2HwjWKV6bKgKi8NpY0j9JT4PfI3jKewS837rRS3hBfhbac4XBh3huOUGqLj
         r37PusFyXEdu9mQQUA5M4qoUP//eMS9W1UMAAdqt0L6QrAW+oGAxs20i4j5fJUHoxfXS
         EnyhYpbzSbTtQomGpJRyMakUhMx/LeoPxkS/b2mvO2RZocgzWEDz1bb58OmibKJMnZw+
         soN7nyCgJ993enPqrxlJByGpmwHnJIW5W6b5zDZ9PaRH0kpadlxSbf3S4SqcgSJx4oCg
         JLYWDapMs3KmY81AstKGGrg3azR714jBY8RyiQDOwRcrePzni0TbERo2st5w+FQp9t69
         Ja6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451933; x=1744056733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGhpAf5RBKmGiKLeNBabpZa5QO5dMHeRd3cjcMuUg5M=;
        b=dShf5ClEwHcQd83JwBMrW6RXCw7QCdPa51s8YqxDwot4Kqs53TybaXvYEquyXmiW4a
         fRm4FbVDpNQsDGsHGyJSYY4wmWn6h47yHG6U+N+0yYq5lJ8CzGcz60rIfqBIdpihqL+t
         cdiJEgXjYFxFD/JN0SJ6x3heNO/Fjd+hYBd+OrOUpEWlcFkZFkbcn9NW0K3/dwawNKG9
         LUSqshFY9XBBwIO4370qq7fxwi4Tu97WPRbpTgUA+clZ5uf4gYIDyJ4AfBezJUJg1J6B
         Jm0FZGfBYIj7l59nPpZhOMSUOw2Ib8VLVI2ybsuhiKy9cN07LmO2r9AUsCCkludLXeVZ
         QaCg==
X-Gm-Message-State: AOJu0Yy6SkW8+DMtukb6AyT/44SuH6GYNrP8NFwB63pwF5SMWsw5/fCb
	U+PKyGnWsOH5kdf4xZYcS49ImoHr6YhB7f51/yH6wu8cwJGmCPQL8iJzDNHnhYkN7Z6NlNJMJ+q
	hAxyThiB15RzxnSQSNUSQ/RjB5R4=
X-Gm-Gg: ASbGnctYfCrruAzBz9md/XxlnpjeU+OUNTOOCubpKnJfddwDrFTXQS6t3Zc09BPqdQV
	bzxNpLQ0cptwKav2kVyrd4IfXZMUX6s4ha2wLXmp6EIyVowxODk/TbCgFTzdc2tOBxrj39VlkKN
	ySsKh2uRf7En+tTdD3pscB9oBOfbDUij0QTuvK1LD5wg==
X-Google-Smtp-Source: AGHT+IGnOeBhqwue8b6HsA7ZZ3pb3DX8g6vDRBmrAf5SCxo4sTj/vdw3l+sQpV8eLJ70YGMmgDoushjLHp97HQ427MM=
X-Received: by 2002:a05:6a00:cd3:b0:736:3768:6d74 with SMTP id
 d2e1a72fcca58-73980387a7bmr15383782b3a.7.1743451933379; Mon, 31 Mar 2025
 13:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 31 Mar 2025 13:12:01 -0700
X-Gm-Features: AQ5f1JoJBn_aLs9x__oU4bSu7_A0svy4_ZFn36XgXNAQy6DJR8hyUFvLhPexuok
Message-ID: <CAEf4BzaTf-SKBW8j7Y_D81Y4j+MB76Bn0xBRr0YJdv+B7aWfTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] likely/unlikely for bpf_helpers
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 1:08=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Andrii suggested to send this piece with small fixes
> separately from the insn set rfc.
>
> The first patch fixes a comment in <linux/bpf.h>, and the latter
> three patches add likely/unlikely macros to <bph/bpf_helpers.h>.
> The reason there are three patches and not one is to separate
> libbpf changes such that userspace libbpf can be updated more
> easily, and the order is such that each commit can be built.
>
> Anton Protopopov (4):
>   bpf: fix a comment describing bpf_attr
>   selftests/bpf: add guard macros around likely/unlikely
>   libbpf: add likely/unlikely macros
>   selftests/bpf: remove likely/unlikely definitions

let's just collapse the last 3 patches into one? libbpf sync process
will be totally fine with that.

pw-bot: cr

>
>  include/uapi/linux/bpf.h                          | 2 +-
>  tools/include/uapi/linux/bpf.h                    | 2 +-
>  tools/lib/bpf/bpf_helpers.h                       | 8 ++++++++
>  tools/testing/selftests/bpf/bpf_arena_spin_lock.h | 3 ---
>  tools/testing/selftests/bpf/progs/iters.c         | 2 --
>  5 files changed, 10 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>

