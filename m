Return-Path: <bpf+bounces-21311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6684B8A3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079D2287732
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA18133286;
	Tue,  6 Feb 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adpB6Jk1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10499132C13
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231451; cv=none; b=uz6exjqpQrJJ4PEMfVtkgTOv8zheL8BvUn6muIZAkB2L4f65m0VLsEWM2QEWJgzd9vzwVoH+lb7LLDLG/YNIzzd4u8rm9jAJZslXcAntImUvK79e1Gul0LY9vDCwhGkGXI+sWRH5/EFfiU9U7BZ1QobZ4EGt2Or8Itdddjv06VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231451; c=relaxed/simple;
	bh=K5o5ftfoYIIZw5LyKgwh8KEsOOd1PCTHn8sc6sXzi/8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcwAqBXjBljqgqLVMGs7IYiZsjk4khOhf16s6lpMOsEzbvnJCZwEma/T3pM9dq1C3aT5aoFngL1XZr8TLdKCVCUxPFh8Hgu5WfOKMbdlplJQsvySAdySgLG1gONhgfTmIA7RQ/WE7i2d+vRDSPxXlcdWFIrrKK6rroLUlNEOPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adpB6Jk1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26f73732c5so812846566b.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231448; x=1707836248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Coj8hkNpVV4uQp3ezJhY5NSbcSy5Vo2ONMSNAbiuWcY=;
        b=adpB6Jk1/4FNbJa/Wi4aQcZTvAb58JuvIEoXjZzZbjznqiM0jVepMWtQSoZK4RDvLY
         5ZqoF9tXROor0BlOdAAGBxXXCM0IdRsrIjGPsSmt0aaqNi1CQM4cpnOUec/jy7IyNrPo
         oNp0YQASGKz+gwBUurfgn8FlXDLlDo4Bef5Hkl+AClS3BBJr/Nf7UO2WbO9EA/Dry6w2
         IviBSc9LXleeFWP+oF0umyrXw7taNxwZOa5bUK23ykzIoYlPEBt+LO1D05rglLskTKdi
         R7UQTqsEmFs6y5orAh+kKcnZCWZaHYtbUqE46ZCFptDE/Q2EQbM7nX34AkLEKodtlnRI
         yKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231448; x=1707836248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Coj8hkNpVV4uQp3ezJhY5NSbcSy5Vo2ONMSNAbiuWcY=;
        b=smVsLOhFWxQWFaMPd7EXbQ1TkhZzyms+BDuFzBluT/ErPbEGMWSiqJpCHLj/kWvjxX
         3LrGnP6uxXTEyjI5/JMtHHoExhyRRQSg6qYVkhMgXb+6vZ6Fj5B8vXenadx1aOr8+YNt
         GmLbe2wsFhnEBzXZlD9DPUkbIkeFC/vZgatbzAXAht6NedXhxIkHrOE8HtKb6CrANw8C
         b34UUSUP9G8VQjOlC3ThpodvdQceM7WRIq6CyFQK8XcBCAn2v47NEdDJnC8fovhUxOa6
         b+c2M1V2lKccyEDkLquCM0yZnnjBKYGsajPAuvEwgY+mYl7nlMC4oQCsE9qr89g2idLM
         U15w==
X-Gm-Message-State: AOJu0YwHftX8R7N9gahXghG7xr8jYx3BSoQPyySAmUYUrOb2eXpAHTzL
	d3gZozXlJm824UAysZIQ1mfI/LjJlmeU5qHhJJHRGcF5sJqP6WvE
X-Google-Smtp-Source: AGHT+IEmDoMVQ5uh3LBUTMnb2go2CGi+2NE1eoqMO130qw4PwKGWyrMVZ0KTqNiUIB5g49vEzUu//Q==
X-Received: by 2002:a17:906:3108:b0:a37:2652:28bd with SMTP id 8-20020a170906310800b00a37265228bdmr1832429ejx.35.1707231447881;
        Tue, 06 Feb 2024 06:57:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqy7d5UH+swlzjQmvzzQw2En90647Kfyu0OBt0s9k8ZAJTtf3rwF3fQkEsZqtm9mS/m48SxEBzpmABjCWvFzxYHzRP9kq86grz7MvpI9gfSQQwo4HDlYk/Ra2U2GEmzN0qFOQ25CEKNgqQSh43P5a4nSSPWs457gDT45FzdLfzPjAQ9WrSCHbgpwSpJk1YZJAV78yx4qi27WE8fqU/wweaLrJz0p+MgbLVo5UYYg8R/CsT9HJhfF6FLPuMzGIylje16yqqwDQQTCZ4uWdSWptll9WZgeuckKQFl3Y0M7s3kPpHiPC8mFSPGmeWN+AKx8w9GzSAW5cWSvUQ6oD2orELpoYgV8Vq1vs0oszaHVqZO+8pQ9XnoR1GlqtLGQTuFij6xkJEpQnXFSLboVjhOJOQ0RApIlbMDxNikUFMYEOCvri9tAhc0DXtyg6Uzksgj14pUSm5Q4tUbCCsIyahPiZo9p8t7TGn7Mg6GV4sXOo1
Received: from krava ([144.178.231.99])
        by smtp.gmail.com with ESMTPSA id hw17-20020a170907a0d100b00a37319aadb0sm1243384ejc.15.2024.02.06.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:57:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Feb 2024 15:57:25 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Manu Bretelle <chantr4@gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] tools/resolve_btfids: fix
 cross-compilation to non-host endianness
Message-ID: <ZcJI1auXFbrckOnz@krava>
References: <cover.1707223196.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707223196.git.vmalik@redhat.com>

On Tue, Feb 06, 2024 at 01:46:08PM +0100, Viktor Malik wrote:
> The .BTF_ids section is pre-filled with zeroed BTF ID entries during the
> build and afterwards patched by resolve_btfids with correct values.
> Since resolve_btfids always writes in host-native endianness, it relies
> on libelf to do the translation when the target ELF is cross-compiled to
> a different endianness (this was introduced in commit 61e8aeda9398
> ("bpf: Fix libelf endian handling in resolv_btfids")).
> 
> Unfortunately, the translation will corrupt the flags fields of SET8
> entries because these were written during vmlinux compilation and are in
> the correct endianness already. This will lead to numerous selftests
> failures such as:
> 
>     $ sudo ./test_verifier 502 502
>     #502/p sleepable fentry accept FAIL
>     Failed to load prog 'Invalid argument'!
>     bpf_fentry_test1 is not sleepable
>     verification time 34 usec
>     stack depth 0
>     processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>     Summary: 0 PASSED, 0 SKIPPED, 1 FAILED
> 
> Since it's not possible to instruct libelf to translate just certain
> values, let's manually bswap the flags (both global and entry flags) in
> resolve_btfids when needed, so that libelf then translates everything
> correctly.
> 
> The first patch of the series refactors resolve_btfids by using types
> from btf_ids.h instead of accessing the BTF ID data using magic offsets.
> 
> ---
> Changes in v4:
> - remove unnecessary vars and pointer casts (suggested by Daniel Xu)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Changes in v3:
> - add byte swap of global 'flags' field in btf_id_set8 (suggested by
>   Jiri Olsa)
> - cleaner refactoring of sets_patch (suggested by Jiri Olsa)
> - add compile-time assertion that IDs are at the beginning of pairs
>   struct in btf_id_set8 (suggested by Daniel Borkmann)
> 
> Changes in v2:
> - use type defs from btf_ids.h (suggested by Andrii Nakryiko)
> 
> Viktor Malik (2):
>   tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
>   tools/resolve_btfids: fix cross-compilation to non-host endianness
> 
>  tools/bpf/resolve_btfids/main.c | 70 ++++++++++++++++++++++++++-------
>  tools/include/linux/btf_ids.h   |  9 +++++
>  2 files changed, 65 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.0
> 

