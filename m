Return-Path: <bpf+bounces-27353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852B8AC5EA
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C70283483
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DD4CE13;
	Mon, 22 Apr 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPo9Rpsj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1118039
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772079; cv=none; b=nPvdhkc870D6I3cdezubnP9pZSQt6tMBLjiXbxFAcFLQZf7CEHEXwZkQ2rPSdtxLNW9ktdkEZKMccw6heNAZc+ZO5xiCt2roXzdK+mR7umd0MYOII66iWXslPoaVXy+KaJYAmw/lj3QvU9boBLL7FYym5GvLXrn9hKrcQGftrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772079; c=relaxed/simple;
	bh=/16RRmP8vrEMF16YCRcA6I/D1DoA0HUvD9/wBIAxg/k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJj9hkuyrAg3yMDj58v/W+BYohf1OLQP91cUEveM+1HhJRdRkBoc4ZKnzX38xiK1bfO6gtbPRdQDURSqdFRBpZJuy+FwqYzCySa1Un3ddiv5tN+A+ewTKmtSvJPKUGvVsN3O3O+rOyUeOO8QcRaH/K5dnpW5vg9nhm5+me958wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPo9Rpsj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41a7820620dso1824165e9.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713772076; x=1714376876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2S4WfAugcjhntaE+gvl3noQjLCxnDR+DsT/4XqE7j4=;
        b=JPo9RpsjzHhHDV5zCWvqJk4WcgT33BhdItDwnyJNW/WSysFs/iorAZEU/ShIWIT7nk
         djUPApr/YTrqZYtS8cUtItX3uYKoc+EsXUj6Bstg5YcfbU/AMp8sIV/9/A/gvhh9QZrf
         YPYF0LojQ2al/nE4tf5OyUjr2JlOAvi3MT5ej4M+HkITrBNiBd/uOKsfZ1b+5QlpyZVn
         JUF6/slna7Liizk1jQqLWvrNmKL+FjdZBn3rHzBizvHWxVCkAPv1RejjpsuYDWoZhAF7
         UhAwP/QZRtBZZBE4tJGH6IQueCgIgqjkmOmiYrnZ3+Xwf4Y3bIZViUPl0J/sRVxAoUbe
         ApXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772076; x=1714376876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2S4WfAugcjhntaE+gvl3noQjLCxnDR+DsT/4XqE7j4=;
        b=VXkIF1ohvookMtUlg67dfX5isZzD4lvWqi4uh2L9A6LTRKlxaUHFRciFaHNuxzWYPD
         tzKs2O+MKYil0kSo+d80vOI5ZSgFTyUg9K/eOeCJCYcngQFWKyuSzChafLdJZBZrOWqF
         W+Fn3LV5aeHLTuD1+oDfrrAsPaKVrnw5E3K3q0shG46EX4LMGszTNzJEp29eBpzk+dLj
         cYiSpCdQmpycPAwUVeDHvzcsf4ZN6dxAIbruFsZ7HFL4cEfG/bbFOA7VD0RUHm0QHvVe
         CvvTBrtmEa1yEFpmSt3I8JdaXOJibCIgR1sXwXmc7yCR3HVXbpxBZkCexZ4TW6rA/JSv
         s1ww==
X-Gm-Message-State: AOJu0YxZUbSfrAhgmsr/QoWQayk80ygxufMbx+CPW8Fa7nzS7jk66IrO
	TNbhLmUFH/ZaKUecce1ruaIH6hyU4341dP5CSucR6Pj3SZT2/+Gm
X-Google-Smtp-Source: AGHT+IF+T4x9Fz2i63eXtnUUTC+oqotLhV+OQST3yXM+zeUeHNgavYPCbkXud28lhCoMDIgHOqBD+A==
X-Received: by 2002:a05:600c:354f:b0:419:f31e:267c with SMTP id i15-20020a05600c354f00b00419f31e267cmr4033344wmq.7.1713772076016;
        Mon, 22 Apr 2024 00:47:56 -0700 (PDT)
Received: from krava ([83.240.60.87])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b0041a652a501fsm1855752wmr.13.2024.04.22.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:47:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Apr 2024 09:47:53 +0200
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net,
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev,
	miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, djwillia@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
Message-ID: <ZiYWKbDKp2zHBz6S@krava>
References: <20240421234336.542607-1-sidchintamaneni@vt.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421234336.542607-1-sidchintamaneni@vt.edu>

On Sun, Apr 21, 2024 at 07:43:36PM -0400, Siddharth Chintamaneni wrote:
> This patch is to prevent deadlocks when multiple bpf
> programs are attached to queued_spin_locks functions. This issue is similar
> to what is already discussed[1] before with the spin_lock helpers.
> 
> The addition of notrace macro to the queued_spin_locks
> has been discussed[2] when bpf_spin_locks are introduced.
> 
> [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/#r
> [2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-mbp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c
> 
> Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---
>  kernel/locking/qspinlock.c                    |  2 +-
>  .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..4d46538d8399 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
>   *   queue               :         ^--'                             :
>   */
> -void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)

we did the same for bpf spin lock helpers, which is fine, but I wonder
removing queued_spin_lock_slowpath from traceable functions could break
some scripts (even though many probably use contention tracepoints..)

maybe we could have a list of helpers/kfuncs that could call spin lock
and deny bpf program to load/attach to queued_spin_lock_slowpath
if it calls anything from that list

>  {
>  	struct mcs_spinlock *prev, *next, *node;
>  	u32 old, tail;
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> index a222df765bc3..822ee6c559bc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> @@ -28,10 +28,34 @@ static void test_bpf_spin_lock(bool is_spin_lock)
>  	tracing_failure__destroy(skel);
>  }
>  
> +static void test_queued_spin_lock(void)
> +{
> +	struct tracing_failure *skel;
> +	int err;
> +
> +	skel = tracing_failure__open();
> +	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.test_queued_spin_lock, true);
> +
> +	err = tracing_failure__load(skel);
> +	if (!ASSERT_OK(err, "tracing_failure__load"))
> +		goto out;
> +
> +	err = tracing_failure__attach(skel);
> +	ASSERT_ERR(err, "tracing_failure__attach");

the test is broken, fentry program won't load with notrace function

[root@qemu bpf]# ./test_progs -n 391/3
test_queued_spin_lock:PASS:tracing_failure__open 0 nsec
libbpf: prog 'test_queued_spin_lock': failed to find kernel BTF type ID of 'queued_spin_lock_slowpath': -3
libbpf: prog 'test_queued_spin_lock': failed to prepare load attributes: -3
libbpf: prog 'test_queued_spin_lock': failed to load: -3
libbpf: failed to load object 'tracing_failure'
libbpf: failed to load BPF skeleton 'tracing_failure': -3
test_queued_spin_lock:FAIL:tracing_failure__load unexpected error: -3 (errno 3)
#391/3   tracing_failure/queued_spin_lock_slowpath:FAIL
#391     tracing_failure:FAIL

jirka

> +
> +out:
> +	tracing_failure__destroy(skel);
> +}
> +
>  void test_tracing_failure(void)
>  {
>  	if (test__start_subtest("bpf_spin_lock"))
>  		test_bpf_spin_lock(true);
>  	if (test__start_subtest("bpf_spin_unlock"))
>  		test_bpf_spin_lock(false);
> +	if (test__start_subtest("queued_spin_lock_slowpath"))
> +		test_queued_spin_lock();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
> index d41665d2ec8c..2d2e7fc9d4f0 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> @@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
>  {
>  	return 0;
>  }
> +
> +SEC("?fentry/queued_spin_lock_slowpath")
> +int BPF_PROG(test_queued_spin_lock, struct qspinlock *lock, u32 val)
> +{
> +	return 0;
> +}
> -- 
> 2.43.0
> 

