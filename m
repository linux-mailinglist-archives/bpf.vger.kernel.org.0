Return-Path: <bpf+bounces-57911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1DAB1C84
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35616A92B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391523F26A;
	Fri,  9 May 2025 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmgASslS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DB23BCFA;
	Fri,  9 May 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816063; cv=none; b=j0YcjJZNdpDApNWxm/h1nCi+gJJy70pFWbOhlPKW6Pl2P9jPwLWoWTtvjMnETZYnOpIoAj9Mqnx/A9CEwKUV9dBj0GvAzFb/Z4ktuljIuePuZbk93U/TWnZNGxX2bkXn0788jekOzJRQ2jWepQO1UrdcEJ6/dzsQDMhJ80WfqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816063; c=relaxed/simple;
	bh=ZFnT+rzuIarsD0rGVmAFtrNtNGfRhiitqCzBkZwC6iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuYvMEmECDn0DEUm0A+NJnTpoH50r6+uqEE6l7a3XhUiMBGVsqZACvgiuS60DXXQZR4r7bzO7xJjhzTAMW/M+fJqTcEgo/XDKaRRVB2yAG7rFLDheixRqDfsxknz7VKT/7t/ZnjQW5fQUQGDB4vW0SzS8wAyzKijekWCY9E+15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmgASslS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a894cc07cso2541759a91.2;
        Fri, 09 May 2025 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746816061; x=1747420861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+jrfAc92NCVuy2+u3wPc+sAATavWi3G6nTuuXlgyeM=;
        b=KmgASslSVBq2IvyiDL5Byq7qxQzcgKhW6lB3SVHQRkgn1AZJfOplJ1diS/3Zz4Kq5h
         Np4TPHNQn5HsyVJJzyxZ4JM5RDcI1HYkDp8LByG7MUOVT6lBMtQG+RaMXGpxQgZdB/U/
         7FAhwfo/ID9aIKgr8JAGmBfN7fS3oadEhh/OjBiZ3tlYD+UF65oQHzo9/3QK4/86HCyU
         gGP2NGu/7NgSwWHFqPD1OhBm+zrXdakXQBPu+yRrH9yNWgWAlzjk226JIVVTNljXZxUq
         GnmWbaIk8WajVDNJumDZZFTVETbtApTg/2wjZFRjW1zzaeb9YVhZRE4VEQ7HmIrdzoiD
         HOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746816061; x=1747420861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+jrfAc92NCVuy2+u3wPc+sAATavWi3G6nTuuXlgyeM=;
        b=NIQ0hQHa4/25Ck2ZdTJgFKBuVSoABZGRZ8wQr+cnfNS2nVsfMQHAreBro8oX9Dxr31
         fCjmjdONq9C2s2ijCoiK3tBupoYnqHycmbKo6LFRyXDkhl0AViGaWfGc6xqLErr3jrzO
         gs6PEhzpCNOQTB3Chz+Sb7B/bWkdBaDMUGx1YPquzdMp51DGNALO04x5DRhr8uvpn6f9
         hTLDNNuymzsh+su9wM5xJ1iYwGC7vh5KUsHbXOv3JsW8hoQhpQ13MYoekH+6xJCKnAB8
         M8BRh6rXBWqsXHbF1n+4W4YUt+/rqNP8njD38OqMssaOp2qS0J7BOqHKoXuyEt/Byt9z
         n6/g==
X-Forwarded-Encrypted: i=1; AJvYcCW8mI2uYRNkffNFgfH6dGPJNxap9/A+wPiuDkUTVHpzynz7t7V3qkEENd4PLIdKlAVjR1NU1flglg==@vger.kernel.org, AJvYcCX8FhspMARPKyx3ccEay6xVxZFpMbs+v66EE6WdaJPVPqg/FcKFnuxU5oAjZ682B7p5KiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB1RNQiK6UYfskJI0fUhiFrIGxdizMIrPoVvkFEXubX1NOUvu
	sESwJjZn/waj8dZm7NGVhF1XBUf5kHRzidG623orq/JrutqfdAwDweiEw/JRDoSsB/Ee8P409fp
	Iqzc7TgTv1qEbu+y8ZUP6CoTyvzI=
X-Gm-Gg: ASbGncthYTARC3kubvwiFk+bsKccgT6kcLSQ6xvoNxw9vfYosz+Ml3AfF12wgKSNjVi
	4lIJZ705xY9DCOTM0FgX57Y2o8zrUeaXzabh7RC7yQpsAlthssUCmTarViBiwjzxuwVETbq+rHf
	fV5xL5k04bP/LP/+RKTH6gNPyKwMrJbki1o9gW/CKm9hTriiNx
X-Google-Smtp-Source: AGHT+IGP1WoR2seY6CN/wBEOtYt3baFEoEZBxvVvlEVXkKGKA7QEpz9mB1pmf817U2aZYLXeOnf4fEKGZEr81FaCaHg=
X-Received: by 2002:a17:90a:d2ce:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-30c3ce034f7mr7160350a91.8.1746816061228; Fri, 09 May 2025
 11:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
In-Reply-To: <20250508132237.1817317-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 11:40:47 -0700
X-Gm-Features: ATxdqUGAyGuycGLqLaIVu58nBWFcD0TGIr9rfq41lS2I4338xwWi5cElhZwpFN4
Message-ID: <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
To: Alan Maguire <alan.maguire@oracle.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, 
	tony.ambardar@gmail.com, alexis.lothore@bootlin.com, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 6:22=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> When testing v1 of [1] we noticed that functions with 0-sized structs
> as parameters were not part of BTF encoding; this was fixed in v2.
> However we need to make sure we handle such zero-sized structs
> correctly since they confound the calling convention expectations -
> no registers are used for the empty struct so this has knock-on effects
> for subsequent register-parameter matching.

Do you have a list (or at least an example) of the function we are
talking about, just curious to see what's that.

The question I have is whether it's safe to assume that regardless of
architecture we can assume that zero-sized struct has no effect on
register allocation (which would seem logical, but is that true for
all ABIs).

BTW, while looking at patch #2, I noticed that
btf_distill_func_proto() disallows functions returning
struct-by-value, which seems overly aggressive, at least for structs
of up to 8 bytes. So maybe if we can validate that both cases are not
introducing any new quirks across all supported architectures, we can
solve both limitations?

P.S., oh, and s390x selftest (test_struct_args) isn't happy, please check.


>
> Patch 1 updates BPF_PROG2() to handle the zero-sized struct case.
> Patch 2 makes 0-sized structs a special case, allowing them to exist
> as parameter representations in BTF without failing verification.
> Patch 3 is a selftest that ensures the parameters after the 0-sized
> struct are represented correctly.
>
> [1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambarda=
r@gmail.com/
>
> Alan Maguire (3):
>   libbpf: update BPF_PROG2() to handle empty structs
>   bpf: allow 0-sized structs as function parameters
>   selftests/bpf: add 0-length struct testing to tracing_struct tests
>
>  kernel/bpf/btf.c                                     |  2 +-
>  tools/lib/bpf/bpf_tracing.h                          |  6 ++++--
>  .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
>  tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
>  5 files changed, 30 insertions(+), 3 deletions(-)
>
> --
> 2.39.3
>

