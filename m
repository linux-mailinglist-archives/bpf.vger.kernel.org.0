Return-Path: <bpf+bounces-35888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E557F93FA68
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EA01C22152
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64652150981;
	Mon, 29 Jul 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BX0EjTz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBF8172D
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269767; cv=none; b=A7IflPTEVYFRqMyRCWNuJL4AH9Xr/iSOTS8HuFayyxZRgyQctetExiXS0HhnpQANxbmI4Y6Ms26O3nj3Yu4TXQajeVMj2gI5KSdrbIdMKs9y+505EtQbICJ6uEEW9qNcqq/p0lPL3b/atwlm+8DGrrz/K/YE9bVt/gBgfoR7Gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269767; c=relaxed/simple;
	bh=d18Gy67ikbYuUZdaoOJUpFbMEluKyBKjTm4b3S21oFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su1LccEGINQAp2v1mai0pF74W6Z37UylKmqtbG7tjOn8n38TwNLUA5SmS0V13MC4fg4spcuC5/5M3rc8H5Ojz4P6K5QyrX3WZq4x8yFS6CRTZQDDnyt0FViptMMSpvSMalipLgU29V2lNCWxQu9vmixPvQcwPL5jzMPkyZ+JIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BX0EjTz5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso15641a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722269765; x=1722874565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d18Gy67ikbYuUZdaoOJUpFbMEluKyBKjTm4b3S21oFY=;
        b=BX0EjTz5MD7VJvtNy8/k5fEGvmMpyxlWjadlcZGc6tM/O2he5YIzr1k92f2bCLng8z
         Gp1ZGQAfgDkCxZnFDa0WdxMHgdYwkucPaIuobVmL0aeiGL9w8TwXPLkICb6NQqBwZj+o
         /BeP8ntTDvyRSebtuc5qxezBgQgzhELUqVGOb41ZZHgpijXNuhbnmfbsgKMIjvS8Ij6B
         OvFjgm8gn9ejXVHYvzlVkgvLYOp4TOy5AA5R06XAQ2TKwD1waZPz/jG6vqF+choC6XeO
         HbDIl65xLhecyTwPO37LBPAlOykuiuRu5Vmi6um4e4+M1RUPeaBGpoUmrqlKf0R+S+IN
         9ZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269765; x=1722874565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d18Gy67ikbYuUZdaoOJUpFbMEluKyBKjTm4b3S21oFY=;
        b=kHn5qURBAGYxFutFVpJgejM5RHA4et2K5JIzasRC1Xcu1Bmt2CQorS5wILsKoe+TUP
         KWF9A1Y9cbw+z7lJvdE3/VzHAc+g9Bue4BSMF+x152fT/dGZ7YDQDU3j7qrDSCJYpFJv
         hoEGjMJzjDJM9hCNGSPizbv2yokEicByTj3CxtxTfu6UiCa49gTAxcmebZrh88Lp9ZbY
         dDk3JCw+vr81zLpOt6M3zpTJSt8s7RBj5n53bKvFX/BR9bNt/vs9GAVVNquN/ZFAeIe7
         tzqwWzZaRGhWzt9R9p1mKmffZJsyocKoKZWSOsq4Ro0bjYkky1ECLG7bVlSSjAiVnIUj
         AeoA==
X-Gm-Message-State: AOJu0YyaPl8DONBDMJ15oePWvt63hUI8w3omPISSE6AgGCfKOcD8BFGe
	SzwadhYJ/vTNOt32UUd7ZBb0z3VaA4EZwSGtAz5SsNYPW6AIxndm6Cd6BkrZvUyLw0DeM/xrPCQ
	oXpURRG6hDe6JWIeqzUZhyA3Jm4MTYPGmWzAEYDKM5poH7kmWOTzSPO+Pcg==
X-Google-Smtp-Source: AGHT+IFq7wwFm0yDbIXrhXFmEY2q6vGwMcUWFfTzQ0yzkf4W85Zpi28KqinyomoROUU4QxcEIMksYCFXQcQW1eegr9A=
X-Received: by 2002:a05:6402:430c:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5b40cede5c1mr22853a12.4.1722269764183; Mon, 29 Jul 2024
 09:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-8-andrii@kernel.org>
In-Reply-To: <20240724225210.545423-8-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 18:15:28 +0200
Message-ID: <CAG48ez0p-oH6VCv38NYyBq1g4URu6Tntj0B7Moz6Cmpr=vy5PQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/10] lib/buildid: harden build ID parsing
 logic some more
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:52=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> Harden build ID parsing logic some more, adding explicit READ_ONCE()
> when fetching values that we then use to check correctness and various
> note iteration invariants.
>
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

If I understand correctly, build ID parsing is already exposed to
untrusted code since commit 88a16a130933 ("perf: Add build id data in
mmap2 event"), which first landed in v5.12, right? Can you put fixes
for parsing build IDs from untrusted memory at the start of your
series with stable backport markers, so that we can fix this on
existing systems? Or should this be fixed on existing stable trees
with a separate stable-only fix?

