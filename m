Return-Path: <bpf+bounces-51035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1743A2F6D2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E623A6445
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A2F2566EE;
	Mon, 10 Feb 2025 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1olh1jz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78622257D
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211745; cv=none; b=fuWlzaJc1dSL71JYKjQYEk9OfG2HlI2PvXcQ0Y2uncxUN+OiIOLRBQty2/YbT2mCOClRY2SkpMgF56QFkMsaeY/HfqZ1BjfpEnJzi794KBKtvnSjRO0FETUIVO3QS6R+nPhMfMewYouIB6F6tq3dVeIXw2tLcrDqEFMWdhZrTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211745; c=relaxed/simple;
	bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rHA5kXujflw8lJIzcfRYXO0kvn99AYoNIhs7+CYraDQwymtQbXn/CPsJfVuqPQdq8/BntYpaw/YdlV+aBGpMKuK5JCWglWnMN8B5rlo//ECxlSFjgZSmwqHWinsbmk7XHvGkO3TIw7TdYC6qGUaaZoBhAR8mA8ocL/6dxdqJtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1olh1jz; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d13fe99d03so5495ab.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739211743; x=1739816543; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
        b=b1olh1jzEupzU/TXA4iKTVqgf6+0E7yYWLgFM6zHR4n16dH78YZ83whPBcdbsqpTLB
         hXKq6pWb0LEq8PCN1LRR6lA2p7i8yw1FpFQsSFlqDWme2rsi4Nf0y7AWVpeWBmKTr5YI
         Ic5LLI/PWhjIIhRc6GMHnHEE9yIJjIGa+eLMKy77bR2UGCGBz+vRVvKKJPbWCVqTlQ9O
         fKX/GEMTOH9ky3QLZqzyu3MUzIzW6D+knSZuk4wzWDc75JD+ev0skfcRnGBfzjBFRo3+
         fuMfxZYL9gt5TlKLo/QY/5XaEqeTRtyWr+Q0smWjjb9/IjzB6lG1ST96rSeX+jUmOM1k
         +6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211743; x=1739816543;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcdrIqs90CcLCAGhFUsmvv1jkxcaZyMPFUeEij+QgGg=;
        b=p1mQy/I609+3WnelC3VqJhpKrotKugo1SDe+pUs9fBzZcBic5mufbcP6gspcSvkEg7
         CMFIloMeW24G4J5BhbJcFBl9RiUzNwVUm5ViHRyQ0YZW9EVV+xSPnd5sDm13F/cVM6f9
         bYKrOdTpe7LnVIrsUPUgnlnP6fE0+gfjwtB1fd92iNn78WY0ZLF2pjQ5E/n+eanBrp9W
         NM/3F3VJUdtqZ7RXqsPdLMYqnAUtPljuEhQ3Z/076pc+RLu409CZYpyrFMJ92dtDwTBE
         FhLmywQnEON6yaoUOWULyDdRcs5+tq+8URhouW67a9vbeIx+/rGrCLwNx47cXQ/PlrkL
         Sm7g==
X-Forwarded-Encrypted: i=1; AJvYcCWsKHbiUoZinqe1YAxWXX3cXlofNBPM4rIo4uep7dgwUB+dpwkxbuzl00gW2TU4WTEvLsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtM9Yvfe4+I+ALCU5jam5KnFqF0gDaaRePfUsWPREgx+CB/UYR
	kQ466l/kJACblYIsQpQpmbFTReWOs/DSWbVRhKC6nCd82WH4uuEizdzVYarmCx3OP1iAlewoBFI
	67+pQGtzdb8TQK+0KJzn24Idd5wuS/2Rw6lgV
X-Gm-Gg: ASbGncsq+EVGe72N0zi8xXqpZN0GDKOEFuSzOXZ59cBvMuFx1uy7poeMO/ZVNUd+DSF
	smgksRvebU/Ip9ZE97gXnUULuNa2kT7PbvOTPpYm9mxS7X8ad/AJd/nU2Ug0RnWMFTRjAjw9rnB
	Rv7DYLtYdp5asDpc4EhPgZQ+62
X-Google-Smtp-Source: AGHT+IFTAuNfiw/XhQoBcYu+J9Hya4qnn2jHdbkYvCPw3zBjIRxktXB1NTEFecewpM4GA6NHDMZjZHi5G1f5cYQe1Cg=
X-Received: by 2002:a05:6e02:2491:b0:3d0:62be:12c3 with SMTP id
 e9e14a558f8ab-3d14efbfcd0mr7274625ab.1.1739211743085; Mon, 10 Feb 2025
 10:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106215443.198633-1-irogers@google.com>
In-Reply-To: <20250106215443.198633-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Feb 2025 10:22:12 -0800
X-Gm-Features: AWEUYZmXHIPhU1yc2AP2lYcBo-6OHxpX8oMootUclJA7tttmBpiUKue4uJ9MEFM
Message-ID: <CAP-5=fWvsy74obPj7Fs2ghUHNVu1A5ywkpjOU6ibC7vvWu2b0w@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 1:54=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> There's some expressed interest in having the compiler flag
> -Wconversion detect at build time certain kinds of potential problems:
> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
>
> As feature detection passes -Wconversion from CFLAGS when set, the
> feature detection compile tests need to not fail because of
> -Wconversion as the failure will be interpretted as a missing
> feature. Switch various types to avoid the -Wconversion issue, the
> exact meaning of the code is unimportant as it is typically looking
> for header file definitions.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Also:
Reviewed-by: James Clark <james.clark@linaro.org>
Would be nice to be cleaner wrt compiler warnings.

Thanks,
Ian

