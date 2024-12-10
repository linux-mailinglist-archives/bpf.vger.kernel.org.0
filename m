Return-Path: <bpf+bounces-46535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042499EB940
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894E71889E15
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008521421C;
	Tue, 10 Dec 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0N9ZUZS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0238DEC
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855031; cv=none; b=IXuc02BFOmIGWOv/PHj9EPHakleyRnsp5xgeKC2l3+5wYSBGXwoh6HzYCHcVegOtsmQXcvxkVwFDBELfqFl4f6pAjqy+B/znndNa3idWqklSxa3KbOX1yM4wurlSqpbrepn5LeIg4/edZO2fiTUSZQSeigZQuOI2DEMgugt5Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855031; c=relaxed/simple;
	bh=EVYtM1ctE/xOTNKBmw1pYRzhz5R8zxWBzAX/1FZuXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHK+BxhxwiCxPK+5XEdIWoQdt1iiPFmxM6nRwG0mKnpkYeyz3TfyUyymIonkMA8iuJvPB5o8hsHBX+pgVcgEcUhEVpcY4ZM8J8WqZ4PybNNArIZ3OiU5OGrTRCX256/Xpc/y3rOYIJdsUNfp/+9TX32/7bEmgcAeDPp1RKFIwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0N9ZUZS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-432d86a3085so39382855e9.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733855028; x=1734459828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVYtM1ctE/xOTNKBmw1pYRzhz5R8zxWBzAX/1FZuXSk=;
        b=k0N9ZUZSG42CfhY3ynsca+XpbqaQDWyDYjzf6jY4KggSfmKXIhZeWz0xCzZqV0CKiy
         qeisuEfd3LtyC9udYApgnBkcYNCpxFi/XHGj7qJXB7xXFTW3bJNujyCQu+PUokZtHmrK
         jmPRkAi9JiE99kNZUVgcY6HurY8EyI9P8JuMfIr6cl2LXZqSyUFwpwXNHjEvz9rgmJ0Z
         3oQd9iA5mLCJLx1nTejqws/eDVcV2o/2topMwEHBvfn2em9Nh3NOdDhYXfKB9sK1tOQ3
         UaGPMRd3ZjxHvw0EZs1BlpQ2e9+9o23saR4uo4qA0TN+1dtpy0LT3I+6X5+VAz+oCBWH
         6TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855028; x=1734459828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVYtM1ctE/xOTNKBmw1pYRzhz5R8zxWBzAX/1FZuXSk=;
        b=EKpj1hDOfDGSydqx72lyu29wdn7RQuq0xEWYIgFfCFaoOVLslYm+RAhU3IM9uKxRv5
         1FVklcqdl5cx0f6ZfioXRY0y2HRg3YAcHfjW9w+Bp47Xl+RHvxtN3ncqJfrycZFE1nNF
         kDMB87xkJSxnNUg1S0z7Y92rbczmVplPiKz1ivLM50dwNcbF3HL5ItBm7Xx8v2Mtaj60
         /Tm9Rdk5O2gtIcbDdXYYC7kOO3HlRfvmcHeL/bj0x1eCc/NyE6lN2pg3u7DuU+dkDU1C
         gf/srD3h3YGMdqi60N8mrv50xqLLBgfubp74tgW0wP7ECq4/0jNzyPE+KQpg7Tfm0FzG
         FlRA==
X-Forwarded-Encrypted: i=1; AJvYcCW8fXXh7UdZdU2Qr1yLAvrSWsDUVWTcyfqVu1aBHzka2Bwo54M7v8AJ/fekFRJS8eSB7ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7Q1YjARDlPRwZFz8RuyUucw5sUoOh7y09rtUUzHRRSTd8LUR
	RPsFz8+pj+KR+aTodw8DLAFpCljIo82iZ02cMLOTvgI4LaUg8p7tPcCZhrbVo8W1FArTPkMytBl
	CGsrX+COY9EAw0bqOe0FAvrpicIs=
X-Gm-Gg: ASbGncu8EGf9pIceeekk2HW+XaYHW0QsUtnvdZaxI/6xwfctQ9+G1F0ZsougKarZqHO
	ZfqqbQAt8QwMa2kl+GCHTgWwo3ogmP34Us4i/pLa6bdaVjU2O574=
X-Google-Smtp-Source: AGHT+IGQA4MEK5XAzgKD0czS+pvUnQiTBR/a4fjsh6G4GdCIaIM/TTs0aDAhwZuM7yDfOl1BB1DQEXp5ayNrEKfz7zE=
X-Received: by 2002:a05:6000:4405:b0:385:f13c:570f with SMTP id
 ffacd0b85a97d-3864ce5fbcemr87266f8f.33.1733855028347; Tue, 10 Dec 2024
 10:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041100.1898468-1-eddyz87@gmail.com> <20241210041100.1898468-8-eddyz87@gmail.com>
 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
In-Reply-To: <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 10:23:36 -0800
Message-ID: <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
To: Nick Zavaritsky <mejedi@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 2:35=E2=80=AFAM Nick Zavaritsky <mejedi@gmail.com> =
wrote:
>
>
> > Tail-called programs could execute any of the helpers that invalidate
> > packet pointers. Hence, conservatively assume that each tail call
> > invalidates packet pointers.
>
> Tail calls look like a clear limitation of "auto-infer packet
> invalidation effect" approach. Correct solution requires propagating
> effects in the dynamic callee-caller graph, unlikely to ever happen.
>
> I'm curious if assuming that every call to a global sub program
> invalidates packet pointers might be an option. Does it break too many
> programs in the wild?

It might. Assuming every global prog changes pkt data is too risky,
also it would diverge global vs static verification even further,
which is a bad user experience.

> From an end-user perspective, the presented solution makes debugging
> verifier errors harder. An error message doesn't tell which call
> invalidated pointers. Whether verifier considers a particular sub
> program as pointer-invalidating is not revealed. I foresee exciting
> debugging sessions.

There is such a risk.

> It probably doesn't matter, but I don't like bpf_xdp_adjust_meta(xdp, 0)
> hack to mark a program as pointer-invalidating either.
>
> I would've preferred a simple static rule "calls to global sub programs
> invalidate packet pointers" with an optional decl tag to mark a sub
> program as non-invalidating, in line with "arg:nonnull".

That's not an option.

