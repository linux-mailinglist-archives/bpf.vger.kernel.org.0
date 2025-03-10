Return-Path: <bpf+bounces-53746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE088A59B0F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F581886E0D
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690DA2309A0;
	Mon, 10 Mar 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dN650yOg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8322FF27
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624299; cv=none; b=U3AvunIPEHwf85/aEcV31nYYHlbNHpRHoQv8Bc7qPOrd8VvzzbPh6FVXJi89BnNRNcGYCQ8cm8W/bW/t7D3MJw+02IFNrHAqEx7hPTyhZDe26xeeEw4TDhg+cq7LlTmtWDGhoQCANu5vH5YW6sIfQpgfZcUoe3q3ZkNaTurd9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624299; c=relaxed/simple;
	bh=EOzJGti6xtE/KS0s/r8JB1JyrUcLNSuZkkzVMvKg/uA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=nvNdYMPct5caA/HMKql5Wqyv6GxoxIH7RMTNuf9tgvyYexBnym0wIlEbUOMUTDb3SYUC94gPJ+E+JgiSshldrcSTyd0X1AGIapBP8Xyzw81/BnAo3iKzcuiGIHlj6kWnia5m1C3WQT9Q57FWgXyN9ugQqZhHmlxwwjfUH8YQtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dN650yOg; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47692b9d059so7863301cf.3
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741624295; x=1742229095; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=dN650yOgLkW1MLoBZYEBHGx5/s6s5eakefzMlmnu962JPwhfd6GjTKiL3ftoSz9OKQ
         8NiGNIiFWFybSC6g5vwBTg/SY9oAOs67Kcg1/p9J61/h7jI5O2i9H+6YcMABjhvC9LHn
         /vuSKDlasEt0EZQ/FDL6PF10s3BppbQLDQ8i71ITG14j96Xq0sUXhh/TIiwewO0diVOc
         15m8Q81PTy52dr+kyV02zc4SBnCMtAGVhqv2K6WrbQW2s9/Gyfhap2RBtM9bGgdvUttC
         LqLFINudK8XhgLltE1LAJPLIEWnZQ4IK/AlNxn7X5vQ6HOiotplzZK4Kkhif6iB01KHH
         TDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624295; x=1742229095;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=ayVZdpqIsNP8BnWdDQ9ozwpNmA9qes/ZXvr4Nz+snLacrmc9LrxtUs5OSH9dhBGSo2
         rbSmwTuQD6bxJbbwmDGVCGt0OVs6mFlicv3avQB43uhOnRLbLJJrf9dQnoMPBL7Wsv31
         G+l+4uzUNUGs9hj6v2NdoWylpIeennTWKKQdKvAHbxeTb3xm1MpOpNMEq4Sc6ORBdNil
         k92SftgsrdtVx1YYuHcNRjB9LIygZgKOqyfYbnGuap7QrUnZbnyWNsQU4T67PWBqq5C/
         Or1TDlO9d3XZHIgACg4+RPrp9kYbcvgoj/pyUM2cLNcRbheO+e+lACp6x75jS9KD2JXF
         FZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUNE8jtHv3M8VKdA1kNdNQzGMEC4wA5ie9hEpwHq71Zcyym8T7Efa9vO3qODrxfZUd2Hew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRr0ZfoTKLsjrRh/SIl9JTyDyR0DN6t49faKV9EXDkTn1CZ6p
	PrAxQpZFaqSaPdHjwFaktIsY+OHcIrVYGGohSku3g2Zz8LGzqtA3ZH0gUYm14A==
X-Gm-Gg: ASbGncvKtcUDO+YMSqi8Ze+V4y9bgALzNUjJZgDEopLxyFWHdHmYvDmhSYusGmE2OsQ
	lvXbo5pSX2fRdhq2kighGfDE9174PkiiW4e8uYpgq/d9wBeUvvMja0IQ/lmbei7AojJaUgnNgDY
	IN+ihD9zQV4eHlUkkvD/DtPejoqqVZOcTNNBZXBA6LCYqN2UtMSrldt2iNNjCJLUUiOSLRD2Bc+
	fd5ev/FGMjgDg6mPqgqJtdrvw9Uv4M1vJJAyRmTj0Umd+Mc6l6ecuUKPaJIazcAQbfsZczjRMZP
	zKCrUdLsKps6jyDLIjQPSrfXKjypagHcBdZgLtGKG4XCr0wRqDugedGrBVgjQiibaIQNIhKzKkd
	kV9j9KrLtr+WxJXOKoZHp3ZdG
X-Google-Smtp-Source: AGHT+IHlZT3bIAT3WS2IFI/YedPMfsOmKAgmF62kbG0sEZfn6Fzjq1oKL8J7czbvA3wYWZrIG85mUw==
X-Received: by 2002:a05:622a:ca:b0:475:486:2fa7 with SMTP id d75a77b69052e-476109bc959mr190733101cf.26.1741624295266;
        Mon, 10 Mar 2025 09:31:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4768cf1ec2dsm15915861cf.31.2025.03.10.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:31:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:31:34 -0400
Message-ID: <2101885775982b2b6310298ae96a3278@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] security: Propagate caller information in bpf hooks
References: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>

On Mar  7, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
> 
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
> 
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h                     |  6 +++---
>  include/linux/security.h                          | 12 ++++++------
>  kernel/bpf/syscall.c                              | 10 +++++-----
>  security/security.c                               | 15 +++++++++------
>  security/selinux/hooks.c                          |  6 +++---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
>  .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
>  .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
>  .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
>  .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
>  .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
>  .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-
>  12 files changed, 37 insertions(+), 33 deletions(-)

This still looks good to me (ACK already present), are the BPF folks
still on track to merge this into their tree?  It would be good to get
this into linux-next sooner rather than later if we want to send this
up to Linus during the next merge window.

--
paul-moore.com

