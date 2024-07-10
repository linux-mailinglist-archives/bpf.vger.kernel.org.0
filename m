Return-Path: <bpf+bounces-34417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14592D7CE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840861F226E4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491A1957E8;
	Wed, 10 Jul 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZHV7CWk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6719539F
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634167; cv=none; b=EHlrqrYGYJfuKNSAuintDYy+BrWZY42dTWeMUmzIBwAFaZC11SUhaIQAjqKoMH7Zu0WAwC1UNgh9VSegFwxqsiPUFndG0Di01KK6vr4K6xl2ZvHYj8SFpNilaBUWjHrVVTz6ZCSI8Aa2CIPqw003D96ErMFkUi1pv46q31iQa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634167; c=relaxed/simple;
	bh=eNB3kRQlm19F/9yTXwnlw7G85yfStMtNm70Ht0LzIcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOzxujxN6Evvdk4ZAcWyZS2dUFobEvnVatpPD4K/Svjz6w/UxtW6o97HvlrlNLmGG2jv+aBwEbRMnU2ZVmBq64ehQvjibwCsAjof9fQtviGd9Ss5W2tP+JdeZe1V10FLUndajH+LCGANOF1MSRJix4EQOS8kfe2jzTUAbiUU+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZHV7CWk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ca8dfa2cceso54726a91.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720634165; x=1721238965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCajYZpAuUNXA2jM7uwuBwWJ6/LbREly4uKERcMarrQ=;
        b=jZHV7CWkPA7iLusCEelwl69SwXCG2dA46YZHX/8dyIwBGUMEdMvfQuurvJksFlQFxP
         ybW9M+skTJbO93tiVQTb+YJj+FpfOXbyU7a4kgDLW3c7ldKkxrLjkVhP/+GrDBTbW9kT
         s0Hx9lCckltvichCEHI9ay+83b5H9Ml4VTJlI0RoNrfl65bnMJB5HySBIhPWRXH9uzI/
         Uv47vJkwOOfsVZZZXheyJcYVmUs6uBw8xN4MOAXOae4+IVZZVixYpmGj3MoRB+8r9bpt
         kB8ZSM2xOLsr/M7R35BknxA6v/Ro9ghAtwHkpoxIwsey2Jx4lkF9Lzyfh5Og9g92w6nH
         O2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634165; x=1721238965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCajYZpAuUNXA2jM7uwuBwWJ6/LbREly4uKERcMarrQ=;
        b=FDIsbzARRxaSs2XcNfbT7R3/D4+odecXsU2zpcE0bghG/ZNau/nOjvbxj1/3aHRrB5
         cYoWgsssOEvH18gSvFRp/LuDq2zWw1zglmz5c7l4b7bnd8MhBbTsgd3dwTpsw7VQx2J1
         4HY7hP/PmR5sTGNQOQYR1jIIUK4JRidDHmpRhsDjceKpqaqn02WwtOwfNvoSmExbIHOv
         blkJdAdg4CCHq69W1tS0avIyjuQWY+5A7MgZfFQT96wb1JqwAkS519ACJnFj7JgCb3f0
         e41cEMgMerB9HEvjqn8qsJX3qanfE+cGIAWYny3P0JaFcnIVJ3yMhRvhdoj+tldnPrp7
         VvMw==
X-Gm-Message-State: AOJu0YwwJDCIjibP+fvQtvz9zZLM/PfTDrnpFnIxML8ND5qYX+JNTm9e
	FhK7g1OMtwUchalDW48/UHcqxujoT9oMQGrAfODBs9UBkql8pSuRZXwABPx8LKhPOJYghNedftX
	nQScgVpXRVs4py8zI27w2I6Yj+g0=
X-Google-Smtp-Source: AGHT+IEuSaTnZXGipdbFreupSnVfkDM61IOHIKVbupRuKm0mIZQwNCcUkC/g4yn93EsjxY2usZpPdKL8vnl/9Jg4Cvs=
X-Received: by 2002:a17:90b:4a4c:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2ca35d4878amr4841662a91.38.1720634164874; Wed, 10 Jul 2024
 10:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709204245.3847811-1-andrii@kernel.org> <20240709204245.3847811-11-andrii@kernel.org>
In-Reply-To: <20240709204245.3847811-11-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 10:55:52 -0700
Message-ID: <CAEf4BzY8KfjR==9Yfcgij18Px6ggxqySqyYis6cv8GZY4PVxbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: add build ID tests
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	ak@linux.intel.com, osandov@osandov.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:43=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add a new set of tests validating behavior of capturing stack traces
> with build ID. We extend uprobe_multi target binary with ability to
> trigger uprobe (so that we can capture stack traces from it), but also
> we allow to force build ID data to be either resident or non-resident in
> memory. That way we can validate that in non-sleepable context we won't
> get build ID (as expected), but with sleepable uprobes we will get that
> build ID regardless of it being physically present in memory.
>
> Also, we add a small add-on linker script which reorders
> .note.gnu.build-id section and puts it after (big) .text section,
> putting build ID data outside of the very first page of ELF file. This
> will test all the relaxations we did in build ID parsing logic in kernel
> thanks to freader abstraction.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++++++
>  .../selftests/bpf/progs/test_build_id.c       |  31 +++++
>  tools/testing/selftests/bpf/uprobe_multi.c    |  34 +++++
>  tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
>  5 files changed, 197 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
>  create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld
>

FYI for anyone that decided to not look at this patch set because BPF
CI build is failing. It's due to outdated libc headers that don't have
MADV_POPULATE_READ constant. I've fixed it up with the usual
#ifndef+#define+#endif block in selftests.

I'm not going to send another revision just to fix this up, I will
wait for feedback. Thanks!

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e0b3887b3d2d..45f67e822f49 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -762,9 +762,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>

[...]

