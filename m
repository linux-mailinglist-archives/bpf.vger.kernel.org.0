Return-Path: <bpf+bounces-27667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1148B0802
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3261F22C6E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC815A48C;
	Wed, 24 Apr 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Enmvdx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4B15991D
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956814; cv=none; b=tjVfNCnrgn+Nk0mjQwuiC5Dk5txVCK40IX6i9H4tf/dG40V4m8QvjCr9lz7iPXRHhkwjr5hA6MClJtb4hYoV3Rxh9yrhHvPgR3E4VccBpZxz+NXMkCYI8mUiJMK0LsRD41aymbl+09S5W8WhY6HiXMG1ODNKaQXyXMMSjYnnAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956814; c=relaxed/simple;
	bh=pO8hEyJt4gobEOjm9FK5m0Qwmoi5SN1PxtYmNMeZncU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVLxoXrd1dIOFP6WurQ7V/UiLSbX8xNDg3J+Rda/e///kqe9XDAfbXtb/w+zcho/HGac7sApf1dSeMAk/+98fs4YD1Yli3E6Bq90ChqQP21x/qbfZvMxIT9JQCSXulxjn7Dyh0hd0tqg5zzeCTaJ4vSQ2EbsIKPc1SmxKNc2A/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9Enmvdx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55b3d57277so413223466b.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713956811; x=1714561611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qs24b8/A8Epoj6Hu8sEkoX/c6axmuMDD5OU/QsFWMHQ=;
        b=l9Enmvdx2t7/DJ7aQ2qV9P1RVUazcKZ4MG2DjaaRVV0MSalbz42X99iEHQbJ1yJL4W
         y9+lIwGY7qBi2WIdrp3QzgYsrtpJi0b/K/PUPAA4sQPV+BoI6yZZf11+hp/ej3IybIPs
         4CWBykD2YO+nTJY6nHh2BOkmFCUWN18J1rDosELualwNcxnDnSeZn8iP0ECNsvNDH0dl
         dGZqxoPKsZugNdBMXroVtv8BphAjuQGcwTbyu9GIojhAR2C49wGPDvkLCT+AUZHCVvgD
         YNl66m0BieHAyhyWuXLieDbz8T77Kpk/VGzDCOdhw7DYSeIHsYIqCDfvLo9okvAOjAQd
         h9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956811; x=1714561611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs24b8/A8Epoj6Hu8sEkoX/c6axmuMDD5OU/QsFWMHQ=;
        b=D/mv+ywGx5QFZcQEXHe8tR6DCFTs42jq4NORiQz0HVbKhRoOPOU17vrtJTvA31SS4v
         VCV4/jWidB6HZ0MXZbptTbk5NMTxPT1HpVZZ3fj/N9Ip2ybsl272MHL96gj38o3Ywj5h
         NxI9Aei7/TrCegTMJE1kCdFU3GealesdC+gW/seDmfJaouHerFIX8sel6WxLWI9o1GNL
         H9rOKYI5FSrq+4unFFW8ElmXBtwZzFGMTHvhfd89nuW92MdoRCbBe3LLICa58GDF22fW
         jiFF3br4iYY7HThuwvSLZnmFteehbtjMXStb36PRqA3c/hcVwcAybZBjVBinlBfrqVhc
         ZvWg==
X-Gm-Message-State: AOJu0YzFr3eGuI4ep3DISYIT+5apSd8W8+6dN2j0FS3mhkIvCWqZLl2r
	svRpFALgX0gMgzps/JOBpyhJntAwLWf5ZFYa6C0S9ucHou2g1YVF
X-Google-Smtp-Source: AGHT+IHMoxnZ09OKp+F3G/uird4JGkAgo8fCLoHXmGHCnL0m6OfyQXOxvk5I1E7favZ3vKZURewlzA==
X-Received: by 2002:a17:907:b9c2:b0:a58:82b3:9b88 with SMTP id xa2-20020a170907b9c200b00a5882b39b88mr1311733ejc.37.1713956810731;
        Wed, 24 Apr 2024 04:06:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm8225934ejt.94.2024.04.24.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:06:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:06:48 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/2] Introduce bpf_preempt_{disable,enable}
Message-ID: <ZijnZoYq9loIvjFl@krava>
References: <20240424031315.2757363-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424031315.2757363-1-memxor@gmail.com>

On Wed, Apr 24, 2024 at 03:13:13AM +0000, Kumar Kartikeya Dwivedi wrote:
> This set introduces two kfuncs, bpf_preempt_disable and
> bpf_preempt_enable, which are wrappers around preempt_disable and
> preempt_enable in the kernel. These functions allow a BPF program to
> have code sections where preemption is disabled. There are multiple use
> cases that are served by such a feature, a few are listed below:
> 
> 1. Writing safe per-CPU alogrithms/data structures that work correctly
>    across different contexts.
> 2. Writing safe per-CPU allocators similar to bpf_memalloc on top of
>    array/arena memory blobs.
> 3. Writing locking algorithms in BPF programs natively.
> 
> Note that local_irq_disable/enable equivalent is also needed for proper
> IRQ context protection, but that is a more involved change and will be
> sent later.
> 
> While bpf_preempt_{disable,enable} is not sufficient for all of these
> usage scenarios on its own, it is still necessary.
> 
> The same effect as these kfuncs can in some sense be already achieved
> using the bpf_spin_lock or rcu_read_lock APIs, therefore from the
> standpoint of kernel functionality exposure in the verifier, this is
> well understood territory.
> 
> Note that these helpers do allow calling kernel helpers and kfuncs from
> within the non-preemptible region (unless sleepable). Otherwise, any
> locks built using the preemption helpers will be as limited as
> existing bpf_spin_lock.
> 
> Nesting is allowed by keeping a counter for tracking remaining enables
> required to be performed. Similar approach can be applied to
> rcu_read_locks in a follow up.
> 
> Changelog
> =========
> v1: https://lore.kernel.org/bpf/20240423061922.2295517-1-memxor@gmail.com
> 
>  * Move kfunc BTF ID declerations above css task kfunc for
>    !CONFIG_CGROUPS config (Alexei)
>  * Add test case for global function call in non-preemptible region
>    (Jiri)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Introduce bpf_preempt_[disable,enable] kfuncs
>   selftests/bpf: Add tests for preempt kfuncs
> 
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/helpers.c                          |  12 ++
>  kernel/bpf/verifier.c                         |  71 ++++++++-
>  .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
>  .../selftests/bpf/progs/preempt_lock.c        | 135 ++++++++++++++++++
>  5 files changed, 226 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c
> 
> 
> base-commit: 6e10b6350a67d398c795ac0b93a7bb7103633fe4
> -- 
> 2.43.0
> 
> 

