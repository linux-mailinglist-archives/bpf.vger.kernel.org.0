Return-Path: <bpf+bounces-75830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA2FC98D83
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 20:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4353A4CEE
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146925392C;
	Mon,  1 Dec 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHytndiy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EF244661
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616963; cv=none; b=APV/SwIWHF15YoRy1+RlVtAtAHE7j1dzu+UilHxxxjAvzTO+bwVMv13GNqklZ9lkSRY/F0IESSmUfVTuojxdIuJJ4nyaEAtGCu0Dx+gvbspZeMk8bVPaFEQfFINDO/a+uhVThxY8E4io467bNdq1iu/QrbMyk5thREoT9md9YCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616963; c=relaxed/simple;
	bh=6bGmfSg9pFxFWCQ2lBH9/70lRpBBtellr+mx+SjLue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYo6rQAFDn9lWq3Sf4FMNzP/p382iyv+rmE9Elkj2BaPFoosk9GHIRoGsp6VO3co3L1RWphTMPrbq4tZtCBd3q5MJ+doBCTRp5UCfLucQq4WDCQXgSgtpCU2nhy5ijDZ0W0EnTrXFqJYarrSv6OlCCyztMhr13TnRmiaiC19nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHytndiy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so7989811a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764616959; x=1765221759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z59nUw0HuPHZG3Lmu1RiiXJwza3oOV4CrE+d6R1LGsw=;
        b=fHytndiyVGErJBS9twJOur9xegsonwVPMvvm43AofXqqfNNkG2ovdU11ylj4d14hDW
         F50+mse2Znh1kFPNxgqIpK5Fb0A+BmoO3lCaemKkWLbO2il5Gux9hk8nT2fZMvswgNGQ
         VeTsJ1tKmS3H6bXFZa8EugqoI05IA0T4DDpaISuKfCGcLzlHWBpOjSbDoI317b1rcjzx
         d/6e+KHN6xeBFY5jKfoAjf/S9a10WTF++gYpw/ZSQjOVdyLFf2fMzWsjJGvvbo/xPz46
         MoYQsfmLeg3pOfDmyOwrrqdtZlt4Sbbb2q91xVl+TBLxprn2ByTNYhY0LsuCI3zeyZO5
         eamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616959; x=1765221759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z59nUw0HuPHZG3Lmu1RiiXJwza3oOV4CrE+d6R1LGsw=;
        b=Ip0uMKnmH8b3yQRv9CxCBLAPuq0eTx+bJZ/UWF8iwi47IabkwAQVe9a4Ru5OU4pVKf
         TjN2xlWoR0q7ldrc0DukuvgcgkKIgDXuh2UNQ+qULtErgSdHZphzD6NUAt8ZpdzdPxZu
         fMEmQ4YOQr3rGg+L9sP3pQlBzIwVJDfCBV2EEhAXOTwGt1g2t6NhkHu01+rY8cxP9EnA
         Y2nD2qPEFcSdSdgvYpd95A4OQ+u396hfcRyWn3xLhQWP+DAVONu2N7WF3a2Tl+p4x4dM
         R6FjWlFHWWbeE2w5l5JeRvKiKbd0FhrYKeBINnwNqvDzpGZMqPu33jAyeYeqKwezFgG0
         DXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjYYC5BuPsPua6wRip322KVroNfx6vEwFy8UTid5Ub+aODCRLHVJwu3MFO2O5kiYwA7PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7h3AmEgq/bWpGtPzwGJhWvBA9MG9zlHfExmf3GNOGQz9KoXiY
	Ijg1kt0pMDLiJ4ZexZs1apNBEye1R6kUb62jXLVkKuVw19c3vmv3NXUi5ArMYClQ2A==
X-Gm-Gg: ASbGncudn6O4BAANYqm+eCb87Li3P/smSzUHzmN5ClxXw7AnmpAmC6xRc2A9feai7ek
	hBMlqkk/HqAtTENsXRiBM+YSxSpfj+u6FpPpmUdGo1PSmLqNQU6NxfOZxp97ep76E/51hjUU/D7
	M3YhlNChMKWtrNP4caV/vy5QK0+1S0/QTfHZE+roGQcMW7Pi5q9UUMAnuUhT8xHfFRfqf27lHI6
	Sp+HFiie4L+pch4uvHqbs93kroLJoHO9NEa2cjHyYFFhleSR0P7IYLV9B5QV0LL/NV1oUGIFvQm
	82Y0I5xlTZzxQSkDp7Q8LOc3o4EqTscsVTw4Yy6OqSk7vx8Xk52JWOHjysGSosTPmtqkI0XUdFp
	wv/1zoOnP9LU8O1TSGhHhIEYmqTrzvS/AW2Kz3Ut5gSy/yW0tyY1qnmsi04O+OQb8mz9hqMXBph
	2vrXS3MD//RdM8FjhIg77Ku2uCYYydCU5LVp3Vo348L3uP36AF0PpSr7VfZQU=
X-Google-Smtp-Source: AGHT+IG34UoQT3kUqLvNKu43Fndn2m4sH7w76ErF20Sd8BMOLDE8kvp8ODO7XKQ+MuwlmC5TvMcJ6w==
X-Received: by 2002:a05:6402:2696:b0:641:54ce:1bf9 with SMTP id 4fb4d7f45d1cf-64555ba1ff3mr38828154a12.14.1764616959243;
        Mon, 01 Dec 2025 11:22:39 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm13127899a12.29.2025.12.01.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 11:22:38 -0800 (PST)
Date: Mon, 1 Dec 2025 19:22:35 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 0/2] bpf: fix bpf_d_path() helper prototype
Message-ID: <aS3q-wLcRFuCGuUG@google.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>

On Mon, Dec 01, 2025 at 10:38:11PM +0800, Shuran Liu wrote:
> Hi,
> 
> this series fixes a verifier regression for bpf_d_path() introduced by
> commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking") and adds a small selftest to exercise the helper from an
> LSM program.
> 
> Commit 37cce22dbd51 started distinguishing read vs write accesses
> performed by helpers. bpf_d_path()'s buffer argument was left as
> ARG_PTR_TO_MEM without MEM_WRITE, so the verifier could incorrectly
> assume that the buffer contents are unchanged across the helper call
> and base its optimizations on this wrong assumption.
> 
> In practice this showed up as a misbehaving LSM BPF program that calls
> bpf_d_path() and then does a simple prefix comparison on the returned
> path: the program would sometimes take the "mismatch" branch even
> though both bytes being compared were actually equal.

FTR, I strongly encourage any new BPF LSM implementation to consider
using the newer BPF kfunc alternative instead, being
bpf_path_d_path().

> Patch 1 fixes bpf_d_path()'s helper prototype by marking the buffer
> argument as ARG_PTR_TO_MEM | MEM_WRITE, so that the verifier correctly
> models the write to the caller-provided buffer.

This is the correct thing to do, appreciate you sending through the
fix.

> Patch 2 adds a minimal selftest under tools/testing/selftests/bpf that
> hooks bprm_check_security, calls bpf_d_path() on a binary under /tmp/,
> and verifies that the prefix comparison on the returned path keeps
> working.

Makes sense to add a test for this regression, but please also see my
comments against this patch.

> On my local setup, tools/testing/selftests/bpf does not build fully
> due to unrelated tests using newer helpers. I validated this series by
> manually reproducing the issue with a small LSM program and by
> building and running only the new d_path_lsm test on kernels with and
> without patch 1 applied.
> 
> Thanks,
> Shuran Liu
> 
> Shuran Liu (2):
>   bpf: mark bpf_d_path() buffer as writeable
>   selftests/bpf: add regression test for bpf_d_path()
> 
>  kernel/trace/bpf_trace.c                      |  2 +-
>  .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
>  .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
> 
> -- 
> 2.52.0
> 

