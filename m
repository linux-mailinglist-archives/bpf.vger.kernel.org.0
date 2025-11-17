Return-Path: <bpf+bounces-74813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377FC66894
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6DF43553C8
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A352989BF;
	Mon, 17 Nov 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOSF2ZKq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168018DF9D
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421396; cv=none; b=hMdyJVp5nWNlQP93+4EXfWgwJUcthQ1WHIJKmYqvgmS7HQOItTtkdz7wfgWqBtK+qj9CsP6Y3s2DmlhvVqdcwhh9b+PTLIiMlF0B/X/5/RUaBfyOthZLOa1RcDPg0wlGD5Aow5+kEX0GSgkqIhwfHDYdSng1o6OUqGyldz7K1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421396; c=relaxed/simple;
	bh=jxLodLca7ewiKe1f9MT5tlc0H0ctntQd5FX8FHuwEis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw4Ky1oUl0JdfNJ5mWkvx3MhmKOUxr1gZaKtM5bWXqlv6Sri03eNYMp/CJgn+EIc0UjIzAYnwDvUDa6F9aVPkUUPRIdREWf9GFCVYS/RFu74o1fpeqrlX1Zwh8DY/hwJO+plbjz6co22SdkJ7dj92+EQRF5SKyylaGmalso8O3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOSF2ZKq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787f28f89faso46782197b3.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763421394; x=1764026194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIzs5G7K9p0I4vbdZrShECv8LDggXVlaKJcjtUKpClU=;
        b=EOSF2ZKqfxGQotUMUh1XB42VA+6YG1p9d4us4KnuK1ZETm8eeItSVH724vRo+9B9m3
         UvMHP91NTZS+vYLl37Ck31Y7oM8bIBlfN1oxsj7iN+Vo1yuV+yIazIKDnqYkFehwKJ18
         XO8fRkjPsUISK2u++0xHe2aIDO80BvN3V2EhsxC+Md8TfKM8WCxyoAbOahHRJlECS0dC
         g+FoPt4Czuv1OTocN0FTtKMDnhWQYgoqXIIvqJlrWQWhXK9V7aUeJzQ/C3hKFQ44aH+E
         nVzU6wBg5CwxJ6Td874CqS2QRXhZ/BiFA6KNPeS+CxInP+oD/WCCjwhJo46g/TEU+Zb9
         Spww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763421394; x=1764026194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIzs5G7K9p0I4vbdZrShECv8LDggXVlaKJcjtUKpClU=;
        b=li28n8vFvQdhjpk4GakFuk98b21jOaIYlbUIfo7IImcjNeLwmCgfOPEP7Sxzr3qeTT
         LNMjNFetp2Q1+fR79+AKzpE74rBkVBrzh65+oFW5tf0mkKNaZKSNKItsXtoo+QorCxPu
         N7hABP1/O71H9LVV4c6pNfDaTcRkiS/p+8E3tLa79MMuh7d+q73TIsOHZSUPlgz852Jx
         VuQwUgxT2pJ6zMK/QXDw6FLdQ34Y0m3pMXP9DkLn0T7IS4uRS1jS6VNv2TkwmzNyKnGr
         xqbCcxgcW4hpH3VVI9fHtOvlaURbd7MAILZqEwtnPtKzvYwkEVR6Df8WwyCFh69ojE9V
         Jnmw==
X-Gm-Message-State: AOJu0YwH0ECiMfQTo4CxyCx8WLcNUhGPvf2mPA6Qy4yZmFrNPuhXNcCo
	bHqjda70sahaXAj+ZXEtFPLldtsXe3kzYSDrWUpLoai0ZMvGqs30bDQsDzf1iIgI6DaHUv58/53
	gI9r+PzfIec/58cbrtrwoeoyAH29y1vA=
X-Gm-Gg: ASbGncujVJ70sr5uKeNg8+3IaarOLEyM+YRaDCjJdGKfnfLufiPhdiCWxv0+1P6Pd5F
	UVpTj+Gq95aqjYOo9k/6gSUXzX/P8V7x7elfh9lX+K3LJ7W4AoPdogcgQFmRQNY0P+bVuSXA2+f
	BKcp/vp4vq5Pb/G+qqtU3sBsa7peuTcZwwkzfwsTLwn/Mmb43dNFjbSzSTGOvVRLn8EVq4umtw0
	k6ToGxpNbFWjBQ20r4lSUdVSPtndxnsoyagaJ8nOUiiqS1nNkr1yMqMl6P+mpU4Hl893QuMpHWO
	vPSdcg==
X-Google-Smtp-Source: AGHT+IHq8mFdaWAwTH5NweYkAifSFQ6Db/XmUJ6O4Ebx8lkQwBoyAEHCQmSnoznZ7K01d/QRU2wTN08P1ghJarvmDGw=
X-Received: by 2002:a53:c049:0:20b0:63e:350c:aea4 with SMTP id
 956f58d0204a3-641e75e617dmr9907487d50.32.1763421393869; Mon, 17 Nov 2025
 15:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Nov 2025 15:16:21 -0800
X-Gm-Features: AWmQ_bnh7sdfaFebeRQSEnluv2kSf8mibeBxu_b7E56z0al6w3nF10mPIwtzUEg
Message-ID: <CAMB2axPYM6xa0q_8B-r5PNedW-WeOGFHE+UH_fHrtq=AYXAG2g@mail.gmail.com>
Subject: Re: [bpf-next v1 0/5] selftests/bpf: networking test cleanups and
 build fix
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:56=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> This series refactors several networking-related BPF selftests and fixes
> a toolchain propagation issue in runqslower.
>
> The first four patches simplify networking selftests by removing custom
> IPv4/IPv6 address wrappers, migrating to sockaddr_storage, dropping
> duplicated TCP helpers, and replacing open-coded congestion-control
> string checks with bpf_strncmp(). These changes reduce duplication and
> improve consistency without altering test behavior.

Patch 1-4 look good to me. All selftests changed also passed on my test VM.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> The final patch fixes a build issue where the runqslower sub-make does
> not inherit the LLVM toolchain selected for the main selftests build.
> By forwarding CLANG and LLVM_STRIP, the intended toolchain will be used
> for the nested build.
>
> Hoyeon Lee (5):
>   selftests/bpf: use sockaddr_storage instead of addr_port in
>     cls_redirect test
>   selftests/bpf: use sockaddr_storage instead of sa46 in
>     select_reuseport test
>   selftests/bpf: move common TCP helpers into bpf_tracing_net.h
>   selftests/bpf: replace TCP CC string comparisons with bpf_strncmp
>   selftests/bpf: propagate LLVM toolchain to runqslower build
>
>  tools/testing/selftests/bpf/Makefile          |  1 +
>  .../selftests/bpf/prog_tests/cls_redirect.c   | 95 ++++++-------------
>  .../bpf/prog_tests/select_reuseport.c         | 67 ++++++-------
>  .../selftests/bpf/progs/bpf_cc_cubic.c        |  9 --
>  tools/testing/selftests/bpf/progs/bpf_cubic.c |  7 --
>  tools/testing/selftests/bpf/progs/bpf_dctcp.c |  6 --
>  .../selftests/bpf/progs/bpf_iter_setsockopt.c | 17 +---
>  .../selftests/bpf/progs/bpf_tracing_net.h     | 11 +++
>  .../selftests/bpf/progs/connect4_prog.c       | 21 ++--
>  .../bpf/progs/tcp_ca_write_sk_pacing.c        |  2 -
>  tools/testing/selftests/lib.mk                |  1 +
>  11 files changed, 87 insertions(+), 150 deletions(-)
>
> --
> 2.51.1
>
>

