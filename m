Return-Path: <bpf+bounces-50807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D3A2CEE6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9C13A5C89
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81B1B0F34;
	Fri,  7 Feb 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajEYgs9i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F30191F62;
	Fri,  7 Feb 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962888; cv=none; b=FsObFx7PNOD44it1ba1zG4WdSQOXfTsn1wN+3h8NmUeCSW4JH1c1Q4gQXIvmJu3/Nwhx5PZa1og7MqYWk38jIT0qCMouoqS/SS+LgRj1arJA8VplbrzkGCOBzJim3X/0BZ+TH6fpP1qi7v9G1MfuAEZBO5raMWzDdQjTSzXJAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962888; c=relaxed/simple;
	bh=UzW/j/MhqjsYRn0dghOTG6lqfHaO4zHzu7s6Zg/VY/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf+5SqMPPMm9WBBudqw9xDm7eCerFBLRnof9s7kKQG01M7cjeLjhX7ft5yi0d+BjFbNESZH5dM/odO/RfWQwZkkKNncaRnimaM3v9zUtfsNa9cJ+bxvnl6n9Wxi83WMvSUQhgdLH4vsXlDWBQu4k6zcf4QS6EyNysmEanEMVuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajEYgs9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDBFC4CED1;
	Fri,  7 Feb 2025 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962887;
	bh=UzW/j/MhqjsYRn0dghOTG6lqfHaO4zHzu7s6Zg/VY/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ajEYgs9iieuGO09n478aohb5YMW8lk2JTRt4af0yaVOQ1f/LWFzJYkZszvSuyxCdi
	 m6MJHrjqS7u4zjp6Pb/+wZEJQyYHGR/Urwk/ywwC8++BNosP6hTySNThSXqHCI4oNW
	 fUu9IFSkdAPdrkwWBvp08Sn/umIoCe6c3pZsqcnmfN3ZLGPcPAMS8pWApZRE7L6Ft6
	 Fy+pgcqOCeOT3cjagQmE9QRcJQjXbP3sD7IOVEvDfxQhUauhP6RxywKknJiXHRFUZy
	 gyJEPmo7EzMyKx9633gllG4ZmYJNCK9VwO8LtfbkGpEvRHIPCa4+UcIi56Si8I4zDy
	 pYrDLxLrDHMMA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307325f2436so23171411fa.0;
        Fri, 07 Feb 2025 13:14:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeN5m9HSSEoTdogWk9ET8q244Ha14ejdZle0SEPMixSEHCnE+oweAU6azd+1NyeV95h7MykZ3KhU/3TcfJ@vger.kernel.org, AJvYcCWOyDVZqFCNmxUSNLpLKvDfFNyMBf2z4xWx61fYc7+6SkiTGDAcQzTIZufYocPhTy3HiRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeivdGUUuX4oMP4hvOb8qgxH6NpvDCiKcjNIbozebAeWz6BgNE
	dqgJ6hkdQqfRa75hdjbfr+vIhVGDc4ApZ0pXWTTD5KHVoqodBBZbYJOi0LY2QtZRvFN7yEVx/6m
	dpf46it2Wu7mup8wEjYG9T+Om32s=
X-Google-Smtp-Source: AGHT+IFH/lse15fSsw/oIj5fPPzMgUf+j3EWKTx6cAiTONgWZxGRKhsKbpDczDZ5OAGzjx0G1mLA4wKdWJEkU80mgKI=
X-Received: by 2002:a2e:a545:0:b0:302:3261:8e33 with SMTP id
 38308e7fff4ca-307e57afd20mr16636731fa.4.1738962886567; Fri, 07 Feb 2025
 13:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40ab531dfb491020ae1cc07d68dd03b0fb1d1fc8.1738440683.git.dxu@dxuuu.xyz>
In-Reply-To: <40ab531dfb491020ae1cc07d68dd03b0fb1d1fc8.1738440683.git.dxu@dxuuu.xyz>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 8 Feb 2025 06:14:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKnzM8hX1P1Gt8MDb6DxO4Nys7k9vphwqsrVW29vZg8g@mail.gmail.com>
X-Gm-Features: AWEUYZm9fHMkVzPM1gtg6FqcNdCAygp82-dY1x8wHjOO6F2QFFyeM8FOUgnaSTo
Message-ID: <CAK7LNARKnzM8hX1P1Gt8MDb6DxO4Nys7k9vphwqsrVW29vZg8g@mail.gmail.com>
Subject: Re: [PATCH] tools/build: Skip jobserver flgas in -s detection
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 5:11=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Currently there is unnecessarily verbose output:
>
>     $ make -j8 bzImage
>     mkdir -p /home/dlxu/dev/linux/tools/objtool && make
>       O=3D/home/dlxu/dev/linux subdir=3Dtools/objtool --no-print-director=
y -C
>       objtool
>     mkdir -p /home/dlxu/dev/linux/tools/bpf/resolve_btfids && make
>       O=3D/home/dlxu/dev/linux subdir=3Dtools/bpf/resolve_btfids
>       --no-print-directory -C bpf/resolve_btfids
>       INSTALL libsubcmd_headers
>       INSTALL libsubcmd_headers
>       UPD     include/config/kernel.release
>
> The reason this happens is that it seems that make is internally adding
> the following flag to $(MAKEFLAGS):
>
>     ---jobserver-auth=3Dfifo:/tmp/GMfifo1880691
>
> This breaks -s detection which searches for 's' in $(short-opts), as any
> this entire long flag is treated as a short flag and the presence of any
> 's' triggers silent=3D1.
>
> Fix by filtering out such flags so it's still correct to do a substring
> search for 's'.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>


This is not the right fix.

The code for calculating short-opts is correct.

This is documented in GNU Make manual:
 Recall that MAKEFLAGS will put all single-letter options (such as =E2=80=
=98-t=E2=80=99) into
 the first word, and that word will be empty if no single-letter options we=
re
 given. To work with this, it=E2=80=99s helpful to add a value at the start=
 to ensure
 there=E2=80=99s a word: for example =E2=80=98-$(MAKEFLAGS)=E2=80=99.

https://www.gnu.org/software/make/manual/make.html#Testing-Flags


The root cause is different.




> ---
>  tools/scripts/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 0aa4005017c7..a413f73a7856 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -139,9 +139,9 @@ endif
>  # If the user is running make -s (silent mode), suppress echoing of comm=
ands
>  # make-4.0 (and later) keep single letter options in the 1st word of MAK=
EFLAGS.
>  ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> -short-opts :=3D $(firstword -$(MAKEFLAGS))
> +short-opts :=3D $(filter-out ---%,$(firstword -$(MAKEFLAGS)))
>  else
> -short-opts :=3D $(filter-out --%,$(MAKEFLAGS))
> +short-opts :=3D $(filter-out --% ---%,$(MAKEFLAGS))
>  endif
>
>  ifneq ($(findstring s,$(short-opts)),)
> --
> 2.47.1
>
>


--
Best Regards
Masahiro Yamada

