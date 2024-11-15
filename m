Return-Path: <bpf+bounces-44991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE699CF689
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BC0287047
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D251D5AC0;
	Fri, 15 Nov 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AelmMRIx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8012F585
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704585; cv=none; b=SEzShV6hRDJsEzL9uiGT8dqlvH9505kfYoCRRyU/kctBCu7M5DLXl9///kkLmnNBCPr/ZN12ZvusYbO2YwfQk+32R4dZNvD7PMZGb4/imJj83X+N8NAxd8YCTcinKnsSAJOSlFQ5gddVXClR8XkNpnjB6pTblK/ZYcdEwj7jw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704585; c=relaxed/simple;
	bh=WuSwvxDu8IdFNwExMXc3WtkpG5URLPsQ0etMS489aqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJz/T3+AideAKk8Z6nZlFmXQ16pn1aMZrY6qQAMyJECA9t0NEYs/gA9YrHoLHxMxvq2fHl+O7wctprk8IaNtJy/xMTuYO5Q5BWPcN9yE5vcZOWiEp7Gv7+PKxqSWbx+2NfSBpF+Joij3jK1qNsX7c4C0K1ULR+snOc2rAkPBVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AelmMRIx; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7edb6879196so1663074a12.3
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 13:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731704583; x=1732309383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuSwvxDu8IdFNwExMXc3WtkpG5URLPsQ0etMS489aqc=;
        b=AelmMRIxXZlMT2+QuQL4Gn6hIwo3rM1eKdUZ+GXds9ZpV2cWbZFPySnXdCwPjcesbk
         2g5KY6fILog07z5FU4WDJyEHs0D/1zCbWI1KyZ+9HKO9QVLW8DdYRyT1sFxkWQ+m7zFR
         3ps3DfqgmgqeqAewVJrnjFSo9MsLDSCyVe2HgAONmVBxkZD08QSFROunHHW32F4Xmoun
         D0bu4oosgna/EzS1YpM+JagUguupENeAxb3Vryd9vTLymnuqKUQ/S5qa8GTrnGsnhVCr
         aqAqkXpom75AwwlhJN/PwHmhoRrXYUpy64WkhPjCvTcr8s2YETmVRd0LOCHVAe9qTnJ1
         R5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704583; x=1732309383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuSwvxDu8IdFNwExMXc3WtkpG5URLPsQ0etMS489aqc=;
        b=SyPlvz/mWP5PP5Oyk4B2aq2zgmH8l7Xw4GPc/evShODK/A1w4WNUPS9OwALgimJj1T
         NylqBqyQbRPws27G1tfU97wZfO3QQbQ5dAq4rzatYhjkNGq3StKzEoHI01iT86Qyjl9k
         vSjmL2J8gteg+aNgp5dHFJMaiIdU5CR7z4y5CRofGONir8GKjrX6blQi7QYW5VUiWxEQ
         11q3mqWdWgs5MMXd3tL31S4SldZWK2tI9AnmIXpWwq14cgEnReWchjKQmOcmWzD3bIMe
         CVhfEzYsrphWE08WDb9m45Firy07Wy7Sl3VFczlHOpHub5ClgKXkdljpEf4wrBxVKJum
         ZRag==
X-Forwarded-Encrypted: i=1; AJvYcCXPahG3ElQZWCyYbXhsT5gjgrxMTytfGT/qFI+qyPtnAHb+bdAKH72ri1mZCZ2uruW+wyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9KLL1Av9W69KpY27Uf8r3HkB8qgA8NPPefSM8utZc4QZBiDi
	J185+6zJD6KDRLTHuYDuUGJ4FUJN5pSqeRqYspTXs0RVYu5EOetw5OicL68kl+BEXygZtoyXydQ
	6AK/mwHVc3yhAfWec8hy+okHwUBk=
X-Google-Smtp-Source: AGHT+IGPTA0M3KF9fxk/5v9glkEBVvpeC5H298PrhMgwa+Mdp069IcpYnkW256e0Ceq3g/Tw/puHBrh0KZW5sH+b/C0=
X-Received: by 2002:a17:90b:4c07:b0:2e2:aef9:1d8 with SMTP id
 98e67ed59e1d1-2ea154f5ed9mr4752224a91.11.1731704582685; Fri, 15 Nov 2024
 13:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-bpf-selftests-mod-compile-v4-1-730d5b824617@redhat.com>
In-Reply-To: <20241113-bpf-selftests-mod-compile-v4-1-730d5b824617@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Nov 2024 13:02:50 -0800
Message-ID: <CAEf4Bzb7KXhZW06vB=01O3SstQo8zNYfooyMNSx=6O0VXH__Bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Consolidate kernel modules
 into common directory
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 3:25=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> The selftests build four kernel modules which use copy-pasted Makefile
> targets. This is a bit messy, and doesn't scale so well when we add more
> modules, so let's consolidate these rules into a single rule generated
> for each module name, and move the module sources into a single
> directory.
>
> To avoid parallel builds of the different modules stepping on each
> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
> annotate the module copy target as .NOTPARALLEL, which makes all
> its *dependencies* execute sequentially regardless of whether make is
> doing parallel builds or not. This means the recursive make calls into
> the test_kmods directory will be serialised, and when the first one
> actually builds all four modules in the subdirectory, make will
> correctly skip the three other calls, so we end up with just one build
> of the subdir modules.
>
> Acked-by: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
> Changes in v4:
> - Rebase on bpf-next
> - Link to v3: https://lore.kernel.org/r/20241111-bpf-selftests-mod-compil=
e-v3-1-e2e6369ed670@redhat.com
>
> Changes in v3:
> - Use .NOTPARALLEL annotation instead of creating a modules.built file

Is it just me, or did this make everything non-parallel? When I
applied this locally, even .bpf.c compilation and skeleton generation
was sequential despite `make -j$(nproc)`.

We can't do that, it's too much of a regression.

pw-bot: cr

> - Link to v2: https://lore.kernel.org/r/20241107-bpf-selftests-mod-compil=
e-v2-1-ef781fe9ca95@redhat.com
>

[...]

