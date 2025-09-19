Return-Path: <bpf+bounces-68881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219BB87A4F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1288F4E5F68
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F0254841;
	Fri, 19 Sep 2025 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COrL/nP0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0524A076
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246809; cv=none; b=o/kjFNWCUPPLJYNbeh1fmMAMyAfqHgRGFDKNYERoED0vMzQ0zD7AeMXDbCWaD4B67bufLG0I+LrcokXtjRoQiIPSyppSV1MlUAKgUSBrn3xqZo7Dk7JrnOibgq3nlGumeL0X6aibGAZt+r/boDKTnWiQca9izSuGcN5Vexye1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246809; c=relaxed/simple;
	bh=tNuZYr45LuDmKMgN7p8JFs4FizrbqwXLGUm5K7CSBwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sChfhvXzieey32tK3nbU/Ua3THgVB1c3xP1zQfgTlsyryec1Rq9nNTHzJ7VJLw6+da/Vj4qM0B+nkUeENBeKCWHvyRrXb2j73/K/nScjPoMGq8kWLbR4uk6HIzpmEqF1R9hdusCGhHMa68ndqY4mli7FuTiPo3Td1KGC96xZ5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COrL/nP0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46130fc5326so10049685e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758246806; x=1758851606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HKwg1oZ9UTq81kHS9XaJthE6hD8ZBFLS70erUklo98=;
        b=COrL/nP0Rkqme3uB9YBEl8LYwFve2//idrr8g+XOJSvrJ039aHGY2EQIT4HMpLmy8i
         AouRgMHy9ZfIv5KaI4HQ3MrUhlOjM25Wub3YmFumPgtB4UOxhLwPow0Me1k2RCvQjJKt
         TSQllMI1oelfNK/lk1Ici7eO9ftay7VltsVvbz6neu8bCRrWRQu07L9G5RImSFKCA9Fy
         ANMkR4Y4LX8D6DVg7VChDLsCTCv2RvZEDSQm2j/P+3islpDwVnIWa5EU5eRN5jTUBikP
         4FnWAYEjq8MVzX6iTbQC0ETPYxSO7ivPR8lhN3VQGvKxxzpyJoY5276Mw9SUstAoRjZN
         QwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758246806; x=1758851606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HKwg1oZ9UTq81kHS9XaJthE6hD8ZBFLS70erUklo98=;
        b=AAIvuEOamSaVnY9iv8YnHaxG2TegeUOUAggrcJOd9eLYLPcwgcABi4qwach8Gz1p4F
         nEGgqTG1hr/6uBEgmqjC70/rhBN0GEmOjgqOso/igmtcw2aO3Tw270u4FNDVmIgZBcf4
         frjQMYOq53HwoWKncftyT8P5bdwaYl6Dfd2655Owus4nkrJb88H4Pmab6M8/Q2x/ZzmP
         8Hd3GLhzpWODr640SUKzHiSbE8qdz3hs9l61nlpSXyOaRgJzIccFHQBhlDRwAs9yqLOA
         vlvJ5eUZ8sHWpaNEVY/Lvo/iZt+iknFL5nxx3CndHn6YHcA2YjgXN3TxRBdpfdJubHv3
         6vEw==
X-Forwarded-Encrypted: i=1; AJvYcCXR2PaOC9Knac70ZcMDHH3NVlbnZ3rjZLQTbE8N/wfONxaB+OTltGHtTBv5jdyYIIKIVX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPYSXRCWC+atxnWSaGkDeu0aALq+VnVU+ZoPzyrbEumOtv848
	3TIs96oPtyLjJxVztheEeEEQ+FgCFkBes+ME4q6PYCMxu2GVCQb6jSAxU7qAh7cyxttV/ZooM5w
	7u3TVvcR0xX4BJH3NpPzhZN70nHjmLuA=
X-Gm-Gg: ASbGnctDJIOpIg1oA53HAhh3k66Y46oaxfJdcfVHLVDDC1AHfrBtOasmpqKP+VxiKAD
	6X1X894oJEvmgY57SnufBgQJVhuAkjkLfoF6Pge8dV7I8ipdri8Z7/zNopaborMrDux0iQAYT4m
	97k+pogP+2xKbMiwrI+BnJFGfX1PngzIKj80a9QJOF/Q6RhxEze9Fev8V6K0MwMyJQAw2k/l20V
	T1EGHKdWD7hl4twcMW77ZmbQ/NjdywilrxJ
X-Google-Smtp-Source: AGHT+IHm6MeO3qVTr3AQrRpwa+9tXQtzfItkyqnoCkByTwJ2vZrlOT4aI2tMUGWEswQQjBHKW6HdtiK6fNIGDCtx/0Q=
X-Received: by 2002:a05:600c:630e:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-467eb047163mr10032475e9.17.1758246805660; Thu, 18 Sep 2025
 18:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916155211.61083-1-leon.hwang@linux.dev> <20250916155211.61083-4-leon.hwang@linux.dev>
 <dbea9a14-e010-4e2f-a34d-4e2fd14a31f6@linux.dev> <bd40f8ce-37ed-48b0-b2ad-69eff76a4c20@linux.dev>
In-Reply-To: <bd40f8ce-37ed-48b0-b2ad-69eff76a4c20@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 18:53:14 -0700
X-Gm-Features: AS18NWDEjOeRUM8DQ2695fNquZhRUAZaAObe6kb1GwhUETHTcad900uL6vWLC_k
Message-ID: <CAADnVQJNA7YvfDx1Go+ga+6HmwdLKnwuLz3duVZ=s7eNpNr8VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add union argument tests
 using fexit programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Tao Chen <chen.dylane@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Puranjay Mohan <puranjay@kernel.org>, davidzalman.101@gmail.com, 
	cheick.traore@foss.st.com, mika.westerberg@linux.intel.com, 
	Amery Hung <ameryhung@gmail.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:47=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 19/9/25 00:09, Tao Chen wrote:
> > =E5=9C=A8 2025/9/16 23:52, Leon Hwang =E5=86=99=E9=81=93:
> >> By referencing
> >> commit 1642a3945e223 ("selftests/bpf: Add struct argument tests with
> >> fentry/fexit programs."),
> >> test the following cases for union argument support:
> >>
> >
> > Can we use =E2=80=98commit 1642a3945e22=E2=80=99 with 12 chars, maybe i=
t's minor nit
> > anyways or not.
> >
> Thank you for pointing this out.
>
> I=E2=80=99ll update my script to generate the commit information in the p=
roper
> format.

Since you're going to respin please rewrite the whole commit log
in both patches.
There is no need to talk about patch 1642a3945e223 at all.
It doesn't matter what you used to get inspiration from.
Also don't say things like:

cd tools/testing/selftests/bpf
./test_progs -t tracing_struct/union_args
472/3   tracing_struct/union_args:OK
472     tracing_struct:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

of course they suppose to pass. Above is not useful in the commit log.

Instead describe what the test is for and what it's doing.

Similar in patch 1 trim bpftrace output.
Only mention the relevant parts. The command line and the error.
Things like:

processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

are not useful.

