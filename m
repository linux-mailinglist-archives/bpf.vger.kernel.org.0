Return-Path: <bpf+bounces-21857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442F853650
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A218B2494A
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D05FF12;
	Tue, 13 Feb 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8yloPLE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F4B65E
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842370; cv=none; b=o/f2i++gVhz2kVetp+CzBzTIk5E/BqY+C+p3SE+PYIyY8XG1Z1fS50hE7vJ1LGzc1Rty9s/jbdraTjMzH/XIYVd5ABOkYsuMDkDi1Be72NB9nJFvV6Z1x6Ymo2qMMZVEb/u/qTKTmoL7rIcScz7KnqnqkMgV9gYlCpJ5h2XD3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842370; c=relaxed/simple;
	bh=qaJifvVNLyP4hWsAjRYNWLmAHAWYLFDSbyXGrHIFXEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF4JFe/LTWz8EvqYbikLKv7NRroLNseOiOMvnpxO1nKCguLwTwIcDheyhYs4rBu1j+u1MxH7WeHEAuqz1Tg0SZ9qTeNOCASWJiPjllFeBDJbZ1rs9l6JDdaIB5+ivJzUu/4dp348NsJGAEvSk0UIkJNaA7p9ZWURBv4ASEYpx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8yloPLE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2a17f3217aso590659666b.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 08:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842367; x=1708447167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JFqHNsEjyUjKjcKJm1kWaOpjXeMsgbr7nSwDWm6eLY=;
        b=m8yloPLE3HsREfkO1elB+OqWjO8V8B3XR0bBZ31fLA7ZjJYflm6Vlk+czhR6rZWMHj
         W8QtIYeij5hBOSNCLrlNJD3TJhoVgtXbneZNjzXrmm2nDxbfPKKD7IuqzRVMWU1o8kKE
         uG1MDROgQk7SFKkAda19zFtFPJR/odLnAqF7Mi6N/FZtYAnp+OhnsrURr/O2fWs9EVL9
         ubZ242HMn0xgYZpNwrEF1XNwPOcFHYuiyeQL2MzXC7WO6Y1wpoU8YoTT10FvNC5FV9lb
         5At6ReXVshc5WFbhcVnE3zW8WX5Ut+18N4q3dfLfjOHzp2EOZ0xMRQGMeBZOiGebQHeV
         29eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842367; x=1708447167;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JFqHNsEjyUjKjcKJm1kWaOpjXeMsgbr7nSwDWm6eLY=;
        b=hCeV9CI3dRDiosh7atVc32u6B7wnSJsa0EVEN/IbzKaWW9PEmq/LrqOVJQ8jwjueBh
         hrqJslajRmwc+rS2n3GP9ZszZp8F22bbQjEMVFqCVp92PRz49/iJu2xOm8nuMEszyzFZ
         dYRMzyuM7/Z50OAdT7JkKi7PRK4SYcySJO+zisQAumPTau3DLJTLp6WZ7X/LrBrcX7GH
         RHTHqWQi/9Kib8jPKcGh++nMoIrinBZa/ZHbxO7g1/41KC2bNGDMCyJx5pIwoi4GMkCJ
         odQ1hgqK/ZFLQQQzt13C4PoAYbh63MNg5630lJhaqVQaLDt4+PWEnh4KXbqi3Od510qS
         iJYw==
X-Forwarded-Encrypted: i=1; AJvYcCWRe7Oa9JkQmcr9iqJoGmanS030Man84e5O85diiOY71GUNf7HAEHt0BwTFv56cEoU/ttQjOKoX6maBZ8S/G7edfpQ5
X-Gm-Message-State: AOJu0YyOIT79rj6XRrVIhwRP+sjNHAheFRXROunmdJEOxHDDFaLNtSAj
	Gag4NDT6tS0zRPZUxQan5DIFMhl+S8Iz0eeJ4JS2GWlN8WV5tsH8bSeEnMN/
X-Google-Smtp-Source: AGHT+IGrzAwp+ZQjrhSB3mCOq59xksWcs4Vh/305ubkij/hsc03sRf3tp9wx5Jr2OEFPqsD91SnULQ==
X-Received: by 2002:a17:906:390d:b0:a3d:15f4:6118 with SMTP id f13-20020a170906390d00b00a3d15f46118mr1108160eje.13.1707842366921;
        Tue, 13 Feb 2024 08:39:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW07UC2zHWNNKP3NChIl+kQAI/Q+xJk8JHSvBmE5NgpfFEMhDv1CqniWb01vB1hi1skAduyJnBBy+mRtkT87dM57rH9V4ggyEWfKKgc2jHIRiCF+HKyPR0bQ4yj+I+hUtu5bat9Uf0uenQAoBW4J3iMtNNSaa/FPIuUGfCgMbinUg==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sa9-20020a1709076d0900b00a379be71a84sm1433498ejc.219.2024.02.13.08.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:39:26 -0800 (PST)
Message-ID: <8fa4a4ed5957f32b20eb12fac8e590c61502cd6b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Fix global subprog PTR_TO_CTX arg
 handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 13 Feb 2024 18:39:25 +0200
In-Reply-To: <20240212233221.2575350-1-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 15:32 -0800, Andrii Nakryiko wrote:
> Fix confusing and incorrect inference of PTR_TO_CTX argument type in BPF
> global subprogs. For some program types (iters, tracepoint, any program t=
ype
> that doesn't have fixed named "canonical" context type) when user uses (i=
n
> a correct and valid way) a pointer argument to user-defined anonymous str=
uct
> type, verifier will incorrectly assume that it has to be PTR_TO_CTX argum=
ent.
> While it should be just a PTR_TO_MEM argument with allowed size calculate=
d
> from user-provided (even if anonymous) struct.
>=20
> This did come up in practice and was very confusing to users, so let's pr=
event
> this going forward. We had to do a slight refactoring of
> btf_get_prog_ctx_type() to make it easy to support a special s390x KPROBE=
 use
> cases. See details in respective patches.
>=20
> v1->v2:
>   - special-case typedef bpf_user_pt_regs_t handling for KPROBE programs,
>     fixing s390x after changes in patch #2.
>=20
> Andrii Nakryiko (4):
>   bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
>   bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX
>     global arg
>   bpf: don't infer PTR_TO_CTX for programs with unnamed context type
>   selftests/bpf: add anonymous user struct as global subprog arg test
>=20
>  include/linux/btf.h                           | 17 ++++---
>  kernel/bpf/btf.c                              | 45 +++++++++++++------
>  kernel/bpf/verifier.c                         |  2 +-
>  .../bpf/progs/test_global_func_ctx_args.c     | 19 ++++++++
>  .../bpf/progs/verifier_global_subprogs.c      | 29 ++++++++++++
>  5 files changed, 88 insertions(+), 24 deletions(-)
>=20

I have a nit for patch #2 but that might be not important.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>



