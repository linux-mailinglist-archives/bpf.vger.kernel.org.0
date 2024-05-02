Return-Path: <bpf+bounces-28480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E708BA22C
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF081F21B26
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FD18132E;
	Thu,  2 May 2024 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn25PC9v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F93181312
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684936; cv=none; b=EMU2kPmofAmIB5o/+fNsLylEjtoM1DD+eM35QQARXM+CaIQtW9W6FLJ47orpSHmGNf/WcvaDBVFNEhhDV478XVmGj0MfRkvtk/oJMFoasHKO9qJCIbGh8jAUm9YgxedaZ9GdDpTmODJ79+DHd5Uy4wXIuQz9D6SuOaav/eP2mZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684936; c=relaxed/simple;
	bh=azKNwdiy61cF/tCmm2MyLePoCnew8+1d6HsmgP0dCWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThGoTYSv6bckHusQhl2vZm0/S4G8En0GXqm2eTLNUEdEPCa7PGVvSMzgqot7yfQX+MiRatFczuuf97OJDsFUcY7Nqs42NOZOMHiewMpKg8LfNoGXfRvYDpERl1LLQSs3f7JItbTaQsJo675WIZ/PVGRc15PQem743+SyPE6NZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn25PC9v; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso1043905a91.0
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714684934; x=1715289734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVK3Dh/qofSfExF8xoljoIs3SZpADAM9gumgStjeZvM=;
        b=jn25PC9v/fq05Q4JVbivhJ9EVZX0VsYy9t+9OQNxmL8rMdVWE/lcsqx4Ex7lhIGazJ
         eMaeAMN4KLG+ImzZJTy1gFXYWaBBiF6ocWOYjMdvOjoODkXYKOM2C7phFxPQ7cqjIxtd
         DBA13wJPVhxGFNpEAzwpybWNMacGAlYGdotKQx4n0wdDL8um1gFBn47CLpar+KXatauu
         c6Ls1NRv/gX/psHoasjiNr4skCe/RmBlMO9pft3FDll4fhghfg0auDL17BKJBg+jAMu8
         tAJLhz9iQMPkEWrME+uPx2BFEJX+mD4UTiqToMsGXy70Z9DA0pcjsiAic+cAr4ETywE5
         G03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714684934; x=1715289734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVK3Dh/qofSfExF8xoljoIs3SZpADAM9gumgStjeZvM=;
        b=s5r99GVb0Ho2vbMLfJ1z7ArLCL+yAUkJX1vzxjdujeHX0h4L9fI5g5r60r3cAKYtw4
         XE0sZGdwownE9i0D5IMtXNtGGlt/r9ZLEE17sTrvIqRnJr5euFQhOqDl1vbaGADLIEq8
         SfBn4YRp2hNA7Vf0vHxHLcooejlX6fse0nA2bs6g5blYgODEMgaiHnkYRFuQfuA3Gja8
         83x7uMSoXmPvVCBcNb34eo+sLsc7O02jmDKbSBHsGBMMYh8YbC7xsGrC0X/94YMGPHp5
         vu6EIoECHnDdmOSrwPg4ftLQATz+huLGDdJkPvOL0lLpbHh0INiEHQ98vTftun1liwDR
         3CKw==
X-Forwarded-Encrypted: i=1; AJvYcCXiDT4pzocEEAQ562qH745AtAmgY9PVI6sPEzSSSQ77KIrXbv1vF8xRZL52dvzhkQn4lCZTBOzIIOc8VA29Sn3vAk3s
X-Gm-Message-State: AOJu0YyRfFNGtGMBVh6MJcrm45ZHmRJuXn3Q8WkVQi+j5PQ9eHlL4ps0
	ctTcM9hSa7JxL5MsxmU77UfJWmz5NS/ytA5K4uTQKJr2YA14RDvxHd/HyUDbVn+ShX5XhXNa4ZI
	SEkQWmMXPKzhlcg7BYTj5XiimR3s=
X-Google-Smtp-Source: AGHT+IFKyfjBtW13tMyaQgcxC2+biKLuMleJ8KjzbjyKgwtxXLub4BUoSWIgcLbVzI2rqmpct2v1mjjb8NxiAafHb64=
X-Received: by 2002:a17:90a:d783:b0:2b2:195a:d7bd with SMTP id
 z3-20020a17090ad78300b002b2195ad7bdmr5351171pju.2.1714684933651; Thu, 02 May
 2024 14:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mb61p1q6k869u.fsf@kernel.org>
In-Reply-To: <mb61p1q6k869u.fsf@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 14:22:01 -0700
Message-ID: <CAEf4BzYPQ7QS+UUxYj=okGyKirkqkmT+48DiRQFZ_DeC+zo+cA@mail.gmail.com>
Subject: Re: On inlining more helpers in the JITs or the verifier
To: Puranjay Mohan <puranjay@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:37=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
>
> Hi Everyone,
>
> While working on inlining bpf_get_smp_processor_id() in the ARM64 and
> RISCV JITs, I realized that these archs allow such optimizations because
> they keep some information like the per-cpu offset or the pointer to the
> task_struct in special system registers.
>
> So, I went through the list of all BPF helpers and made a list of
> helpers that we can inline in these JITs to make their usage much more
> optimized:
>
> I. ARM64 and RISC-V specific optimzations if inlined:
>
>     A) Because pointer to tast_struct is available in a register:
>         1. bpf_get_current_pid_tgid()
>         2. bpf_get_current_task()

These two are used really frequently, so it might make sense to
optimize them (and also bpf_get_current_task_btf(), of course), if
others agree with me.

>         3. bpf_set_retval()
>         4. bpf_get_retval()
>         5. bpf_task_pt_regs()

I'm leaning towards saying that probably not, unless we have a really
good reason to. Inlining is not free in terms of code maintenance and
complexity, so I wouldn't go and inline everything possible. But maybe
others have another opinion.


>         6. bpf_get_attach_cookie()

definitely no, there are multiple implementations depending on
specific program type

>
>     B) Because per_cpu offset is available in a register:
>         1. bpf_this_cpu_ptr()

maybe, but I don't think we inline at BPF instruction level, so
inlining in BPF JIT seems premature


>         2. bpf_get_numa_node_id()

I'm not sure how actively this is used, so I'd say no to this one as well.

>
>         These can be inlined in the verifier too using the newly
>         introduced per-cpu instruction.

yep, I'd start with doing BPF assembly inlining for
bpf_this_cpu_ptr/bpf_per_cpu_ptr, tbh

>
> II. These are very basic writes, can be inlined in the verifier or the JI=
T:
>     1. bpf_msg_apply_bytes()
>     2. bpf_msg_cork_bytes()
>     3. bpf_set_hash_invalid()

I'd say this is also going overboard with inlining.

>
> I will first try to inline all these in the ARM64 JIT and see the
> performance improvement. I am not sure what would be the best way to
> benchmark all of this inlining.
>
> Andrii, can you suggest something for the benchmarking?
>
> Looking forward to your thoughts on this.
>
> Thanks,
> Puranjay

