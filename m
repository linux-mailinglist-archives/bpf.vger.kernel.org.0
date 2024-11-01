Return-Path: <bpf+bounces-43731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627F49B91D8
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279D7283DB7
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F3174EFC;
	Fri,  1 Nov 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE2caVM6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20416F900
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467138; cv=none; b=WdHd72uYx0LKPX7PBGfYrglsKxB051E7OpC1QDpxp1XBpIGRZlexkJpcJHbDYFrM9BTXAuhYA2tTXNZqU1YQoo+GAnxbFvFJguvBxaigTtMcCzshejdchboems9aQ6F1synuXctykovc9mk7GbNuCtPmKgAVJKiF6xOG9JGjsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467138; c=relaxed/simple;
	bh=Zsga3EIaD/LV8XE6AgWCjoPG7pbYCIZ727pAHL2i+sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGuGSZaSX4XGTJJZ7PTkCpx2zt1OIqfg6sgYR+NJS3/C/2TGRsEt7wz2/yaspYLQfyNiZvHixtsFEX5SxYOBVKbAZqRW0ntP/zCUz6txrx6ealc7+MgQ03GtsE8cqiQVIuMLhKJQB0c/zqcVS6BnNHjQggOu9BdA15rnkoTn+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE2caVM6; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so2255703a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467134; x=1731071934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAt2aQB1gqPmOnwWnUYi4fnLX76QcmPynYeRPoEl3/c=;
        b=KE2caVM65jjYticpDXk7Keva1PTCrXvz8r1+2ZparD8WqkvffqPpTjLscx2t564ga5
         aZfTslsaUAgMyZSw4ZJNFe2CQNdGoKdv9yU0LomlBLbQU1p4Rth5rHzsxEux5jBv4HBN
         e6+LrUIa3qj+dmPlXNs9IOmmT2ujNK0Ahn9dqrY56u+Gk8G6Dh06PqY3ZBn9ksXD3c1u
         858dhS9PFOHMPu6p41DRF03Uqmp/FSCXuPJMV0U6vHCGKX1Gr8mHzqoVs+M01samRYiy
         ZdzsnIb9OCfKw1DaBm67z2nncOwLDwMEnxA2gF84RSnUTv1yvzlqUnjmJI+UtzjXuG/c
         Wx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467134; x=1731071934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAt2aQB1gqPmOnwWnUYi4fnLX76QcmPynYeRPoEl3/c=;
        b=UrI/Qzt1SyeCmG76J3Mh/YBKQq45yEPAFFCrWvr9bDms7Fk+TM1PntYwFdHbyKW4K0
         7b6oHItOeTkbx8CyQposSarQ/aPJ3ovVjfQw3sQ+jD8yjExKY/ROdoET8V59nX0K3TYA
         5yc4MwSUf1+CUIVbCghwhBa5v8nVPHcMfMGN6dGR3knAx4qQpSX1ydDvtx/UMzsMPnkk
         eZSxFG1MXtkoH9gz1m3Rzwf3ZlOFcsngsWytCNbYeq4QK6kgTFEmJeBE9BgxuXDSx1I4
         Qr5QWvB5KcgLqqueszAKWvgpUem1AoeneTf7a4bt48Eus45M3HVwOCYOVqIPEgO8RrW6
         7T2A==
X-Gm-Message-State: AOJu0YzpRSrc+w1CMEgnJB79ESAv0NNmmvsM6mQLTyVFxndpDCiyF3hA
	iGZQnk10K729Jbfb7jOFz2tD98KiM006PD8BQGopuwJHzMRQ2FI6uabI+oyTp0fFLuoryDuPIDA
	gxGsjPDcTm3ygPcdFQ85ZIW5WLC2/+Zzpa52Rqw==
X-Google-Smtp-Source: AGHT+IEYYwRfhSG2CaWJIrmfLTRr4TDyOq/KZxe8Sat+/afbkpzpG1ECgAh3Jtw5iGuO2pCrR5l2BSQ1QG5jXRmS3/c=
X-Received: by 2002:a05:6402:3202:b0:5c4:14fe:971e with SMTP id
 4fb4d7f45d1cf-5cbbf920567mr17263275a12.23.1730467133666; Fri, 01 Nov 2024
 06:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101000017.3424165-1-memxor@gmail.com>
In-Reply-To: <20241101000017.3424165-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 1 Nov 2024 14:18:17 +0100
Message-ID: <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp arguments
To: bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 01:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> More context is available in [0], but the TLDR; is that the verifier
> incorrectly assumes that any raw tracepoint argument will always be
> non-NULL. This means that even when users correctly check possible NULL
> arguments, the verifier can remove the NULL check due to incorrect
> knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
> kfuncs taking these trusted tracepoint arguments incorrectly assume that
> all arguments will always be valid non-NULL.
>
> In this set, we mark raw_tp arguments as PTR_MAYBE_NULL on top of
> PTR_TRUSTED, but special case their behavior when dereferencing them or
> pointer arithmetic over them is involved. When passing trusted args to
> helpers or kfuncs, raw_tp programs are permitted to pass possibly NULL
> pointers in such cases.
>
> Any loads into such maybe NULL trusted PTR_TO_BTF_ID is promoted to a
> PROBE_MEM load to handle emanating page faults. The verifier will ensure
> NULL checks on such pointers are preserved and do not lead to dead code
> elimination.
>
> This new behavior is not applied when ref_obj_id is non-zero, as those
> pointers do not belong to raw_tp arguments, but instead acquired
> objects.
>
> Since helpers and kfuncs already require attention for PTR_TO_BTF_ID
> (non-trusted) pointers, we do not implement any protection for such
> cases in this patch set, and leave it as future work for an upcoming
> series.
>
> A selftest is included with this patch set to verify the new behavior,
> and it crashes the kernel without the first patch.

I see that all selftests except one passed. The one that didn't
appears to have been cancelled after running for an hour, and stalled
after select_reuseport:OK.
Looking at the LLVM 18
(https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/32366412581?pr=7999)
run instead of LLVM 17
(https://github.com/kernel-patches/bpf/actions/runs/11621768944/job/32366400714?pr=7999,
which failed), it seems the next test send_signal_tracepoint.

Is this known to be flaky? I'm guessing not and it is probably caused
by my patch, but just want to confirm before I begin debugging.

>
>  [...]
>

