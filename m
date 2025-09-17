Return-Path: <bpf+bounces-68710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC65B81E5E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 23:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788583A7497
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634C302CBD;
	Wed, 17 Sep 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWKZcHut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575A18D656
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143554; cv=none; b=bUdVujGEXZ4DWSEziBQJZbpuRLuXpnUS7HV7j8Mvr87kQU46znJcy3NKnfGLSdqEnuI/rhRLu//+r9s/0DsE2MPa4UqFt3+6l9+LDlTeUm/oF7hJTWrXoWrTWubqwNOH44bBh2cAPk4OMWc33TbHzazdDScTYsW6twI4Qtyokrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143554; c=relaxed/simple;
	bh=RC3dqTa0+HoRBYxgO59V3/qfOlTCoBQEoCmJziD8RWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bk4bV5TFr5HWchFPwzvF9QHryEvwgZzgn9JPGNxVELFP8jSA2vy8L8+HURB6A4H89gKHwCSk/sKUnEl173rNWR4MczY06u1BQ9LrbgfPyPi+8eB2PIKZoS0J8VzbZ0pYWYT2tXYL9Zn1G2IBSsxiwhMkHf3SWJb42vRLNA8ZKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWKZcHut; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269639879c3so2163105ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143553; x=1758748353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCPsIBs3cCxgpCeomkGN40vlj32nmQbzRTZm6GwTvHs=;
        b=mWKZcHut8W1qhIyuUzCBW0hqTy+99cCBvFXjvBlz2TBHbq3I/YIujETx+B4DVaVY49
         O4zvenkvWEUsNGTMik6/ksYsZPBb0UmT2a1WwrNq1bUCaZQAk37HFSJMkexyJAJf4wup
         xT9MZc68tlKBL3JEecDzDeZQMgtIsVrmmM0lMFHJy7EZd8jdu8Gn9JcMwCo8fFtmiz3s
         Mz5ZnOalEfpt0H4x3owgu/pcqTiQb1ur54+2HJO7GdeeQYjpFclT7STP8tnNN1UtFTv9
         FgnkqGOuMtJfGOM+QS40ICe55hnyu3MctHBmbfHka+YgRKrJ9EgR3/374roaShFMPpRE
         U4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143553; x=1758748353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCPsIBs3cCxgpCeomkGN40vlj32nmQbzRTZm6GwTvHs=;
        b=lA9O4C1CC+4aaUSUnQyqXPZRc8I9wLGu73KyNozeaq5o/iJ4B0QyAIEADqQeVFTH0+
         +HQJ0CypUudte3IObTtk641kPEWNvZ1vUG1nAKdbBZ4gTzb4suCdyLYRU91LpZkJkmja
         42u1chw5wXRkzWvXqp/rky+Bk/OVEuX4m4F3UcbF3rpl614JRMui9c7hxepXyOGHBeOt
         dCQNDFNZZcy0Z817vmxJXyH2GvA6P8DqGncQpqA7uI7E1A45iISsF1FAS3A6ZQxntGja
         AC4vDVTF2+rVZQ82z0zNWBN6UzNexF1HDhLY4yihc9WKeBSjaIVM/97iEd0UHeIZmi03
         etpQ==
X-Gm-Message-State: AOJu0YxIdlKEWLB8UVd8Acs1ASqsZuR+aTj40EVYPXdNFsfGO8XJaCG5
	9ZlhmtIe1gPfxfw2VOmXmzBkH8B5SC0ui8FIfNEnFGJxT2iyFE843+mDUO5EHI4aqCQ1iksngkG
	XgNPcNrLfeiMTcbqviZ0hhMBtzvCnmF7Iqw==
X-Gm-Gg: ASbGncspjwPDxo1oCp1np5J8NfL2Yx1KnkbiEWYbWUdMOUqdi8t451RVwvKOeyzv96j
	Y6HlzexTHs/pZbdcWQ7TXkpu9ElJbF36ObfzU1CiA72HQ6iXPiSeZBS221RdUPsn3tPX2l1jDYv
	3yYOjM83h9KAaUKnzONooyZCCt7r4MtZ5viXMURE0L5AqwkOp7VkrIPXGGh3WQpzJ2T/NsmHcGf
	nv+I7s39MARSXn2+SNjEbI=
X-Google-Smtp-Source: AGHT+IHk0D8i8IstMTV0cZp4yche+F44qByQT3FkgnhzkXmkNKq+U6gCoYV2EuOSlXk7sMfdVZfQKkPG75Ba8eA1C/U=
X-Received: by 2002:a17:903:17c6:b0:269:74bf:f19a with SMTP id
 d9443c01a7336-26974bff7ddmr24672915ad.11.1758143552639; Wed, 17 Sep 2025
 14:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-4-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 14:12:19 -0700
X-Gm-Features: AS18NWBc6XkdiZs4liA3A07LFlIzmSjnJyPPkPjhu6vC_88uEGliX6IFexS1XjM
Message-ID: <CAEf4BzaRYeT4wzU7uCuYLF-7THnXL2KgbF3kkg-8fLE3phM-5w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/6] bpf: Add common attr support for
 prog_load and btf_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> The log buffer of common attributes would be confusing with the one in
> 'union bpf_attr' for BPF_PROG_LOAD and BPF_BTF_LOAD.
>
> In order to clarify the usage of these two 'log_buf's, they both can be
> used for logging if:
>
> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> * One of them is missing, then another one will be used for logging.
>

I agree with the logic above, but I'm not sure whether we need to
plumb common_attrs all the way into bpf_vlog_init, tbh. There are only
two commands that can have log specified through both bpf_attr and
bpf_common_attrs. I'd have those two commands check and resolve the
log buffer pointer, size and flags on their own (sure, a bit of
duplicated logic, but we won't have any new command having to do that,
so that's fine in my book).

And then I'd keep bpf_vlog_init completely unaware of common_attrs
(which eventually have more stuff in it that's irrelevant to logging).

This seems cleaner than plumbing this through so deeply.

> If they both have 'log_buf' but they are not same, a log message will be
> written to the log buffer of 'union bpf_attr'.
>

Meh, whatever, this is unlikely user error, just error out with
-EINVAL or something. Let's not invent "log here, but not here" logic.

> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h          |  3 ++-
>  include/linux/bpf_verifier.h |  2 +-
>  include/linux/btf.h          |  3 ++-
>  kernel/bpf/btf.c             | 12 +++++++-----
>  kernel/bpf/log.c             | 23 ++++++++++++++++++++++-
>  kernel/bpf/syscall.c         | 14 ++++++++------
>  kernel/bpf/verifier.c        |  8 ++++----
>  7 files changed, 46 insertions(+), 19 deletions(-)
>

[...]

