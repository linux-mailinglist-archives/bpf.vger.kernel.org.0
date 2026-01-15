Return-Path: <bpf+bounces-78991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628EDD22F4E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 08:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C584300AC9A
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0032D0DA;
	Thu, 15 Jan 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxu/0b9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897B32AAC7
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463722; cv=none; b=D7yOqaUPBv3ZtCKkVpcxnskAccwuRouHCkIhb3AtvP03qloRq0BWcNQXaSz+8JVQAAvtFjIdJSfa+PhkVFY/MFBP61sO2cHcAlfxfCYaNExK1POayls3lZJzGKSmvvxII4wBXk2uOvbK82KE62gSrv0Z7+nq5PCWpRcRo3OUjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463722; c=relaxed/simple;
	bh=om7HWFSCcurUmG6Mdx+2OBk3oT41KbwfSRYe/GiyAWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOANGz7AJE5xg7/nR3gasZOaXDKdHDyhGhVWl3gDbwztgqycWOqPb787jqPTEZNlgWqVRF8l5p/wqmHH8JsHcX+5+WI6T/JymntGZLnpITtZxWMrAIW0Wu3ISDqMueZ9jyBQaa3KNvBOpl9AJHA11zPQL20GdYQSUiGeYkrzStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxu/0b9E; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so299855f8f.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 23:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768463719; x=1769068519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kKO78bOkK71SeHcqc9Sc94UOqPxLObVPuU/Z//5QLXI=;
        b=mxu/0b9E/YvVWDRcZm99N37i0EAHJJGHXj66RWHGYUCshUMeYfWAwt9VktVGG82j84
         z+AE/ihGXeSXBVVBx1PWmf6HteRwoxTxwKPqiWTnKL5E0YlCn26n3M/TxrkhWr4n5C7A
         6uYlEY1zbOauRvXwed31caAKjZb+Snrw0KYs7YcKxRh8JxDmb6O/tg89Ma+KyfQ2BzkU
         LjE3uwDuZ8oq86IxDV5YYmuuoUI1LjrVMBWyyNnXoATvv5gQh0m5xvTtwOllwCbb8aNL
         G6RaDO7eh41C7pgABV0RRjAtrtsP9fpP3yloo/kC1ZF2pcEwcA77OOfNADM9JSr8cwhF
         /R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768463719; x=1769068519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKO78bOkK71SeHcqc9Sc94UOqPxLObVPuU/Z//5QLXI=;
        b=QabeTeYL1P78yl8SFBRighze36mMTTukBsg8cvriVMP3Gp6+8nsbMKpVc/uGXs5KFD
         gGVaI1rLNvBidOarYouIauOXs1sVSSeaoKnHQ9J9G/4+DR2O0TuqTEkOK89gtcHDr8QC
         X6qqTp7D9vG31vuXySUFgJWkgToGklzC0pDaMZlMlrO662KwC2u/jLKx2cB5pkKWHBcu
         UE+iqZDwk8IGTaNiczu6e8nmMM1VCVfz/CRxxw6X9Qk5qXyFzDybKFMBQOagEu8ppm64
         Xt26lQ6xr0D8gQZ+9Osmf7+2IK5aRIwrX9D8+rVfAJXtktVdsYEGqaiVRcV2z7HtI5m4
         fY9w==
X-Gm-Message-State: AOJu0YzXdzyV1m/5MUMSZzdhxdTkfXaq6JAKwKtAlJmDmYIaUz2riGfU
	Y0u7Xuhuy9HkaCsivAKQKDFoHPk7PhXNxUDnj8TlKnObptn1jk9T3Tbm1OKUUJvxCg3Awcjdaml
	g72XvJoU67sqr24LZ91Bv4rmSzSWQn+W2auku
X-Gm-Gg: AY/fxX69y8s7XVPO2Bfl6GOJ20WRDm0B1F2rQi05oIEVAjON4fg6q+X1bZUepvLLqEM
	CJx5e7KUiAQ21hz3cZ9AW/vP5peFU1RCDcSQEt4QbjNJnjxGvAVVHVa96I+rskzkZum4DZgsw9c
	X9IVGPiPJaq2Qll/JPZaZrc2t0Y5syFK583W/X5Ar1qNXvWRa6UBxU7CjFZqR09DDhuNpfkiaYY
	QD5M0MfNSRPVsOsugy95bQI0uVy+WvKKzCQGFO6IaOnqYwaSRifGTft0F46usitSmbOq9lvv29l
	bq2LWKFQ9vwlBXuPaUs/8zKvbJov
X-Received: by 2002:a05:6000:4301:b0:431:8f8:7f24 with SMTP id
 ffacd0b85a97d-4342c535b7bmr7202529f8f.39.1768463719264; Wed, 14 Jan 2026
 23:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115061319.2895636-1-yonghong.song@linux.dev>
In-Reply-To: <20260115061319.2895636-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 15 Jan 2026 08:54:42 +0100
X-Gm-Features: AZwV_QgTZDgey5kb1xz_G5IHC7YNoRQpYKwJeDQil9DsOT5tQyZ0c2BYnI5guiE
Message-ID: <CAP01T75HfwbrZkRouGiuhfbFqMS4-LXh-nQ7ho=rJ-DZ44vCDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_kptr test failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 07:16, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> On my arm64 machine, I get the following failure:
>   ...
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:specs_alloc 0 nsec
>   serial_test_map_kptr:PASS:rcu_tasks_trace_gp__open_and_load 0 nsec
>   ...
>   test_map_kptr_success:PASS:map_kptr__open_and_load 0 nsec
>   test_map_kptr_success:PASS:test_map_kptr_ref1 refcount 0 nsec
>   test_map_kptr_success:FAIL:test_map_kptr_ref1 retval unexpected error: 2 (errno 2)
>   test_map_kptr_success:PASS:test_map_kptr_ref2 refcount 0 nsec
>   test_map_kptr_success:FAIL:test_map_kptr_ref2 retval unexpected error: 1 (errno 2)
>   ...
>   #201/21  map_kptr/success-map:FAIL
>
> In serial_test_map_kptr(), before test_map_kptr_success(), one
> kern_sync_rcu() is used to have some delay for freeing the map.
> But in my environment, one kern_sync_rcu() seems not enough and
> caused the test failure.
>
> In bpf_map_free_in_work() in syscall.c, the queue time for
>   queue_work(system_dfl_wq, &map->work)
> may be longer than expected. This may cause the test failure
> since test_map_kptr_success() expects all previous maps having been freed.
>
> In stead of one kern_sync_rcu() before test_map_kptr_success(),
> I added two more kern_sync_rcu() to have a longer delay and
> the test succeeded.
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

This is still not a proper fix, right? Maybe two works in this case,
but it isn't guaranteed to be enough either.
RCU gp wait won't have any synchronization with when wq items are executed.
I forgot why I used kern_sync_rcu() originally, but I feel the right
way to fix this would be to count when all maps have finished their
bpf_map_free through an fexit hook. Thoughts?

>  tools/testing/selftests/bpf/prog_tests/map_kptr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> index 8743df599567..f9cfc4d3153c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> @@ -148,11 +148,15 @@ void serial_test_map_kptr(void)
>
>                 ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>                 ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>                 /* Observe refcount dropping to 1 on bpf_map_free_deferred */
>                 test_map_kptr_success(false);
>
>                 ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>                 ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               ASSERT_OK(kern_sync_rcu(), "sync rcu");
>                 /* Observe refcount dropping to 1 on synchronous delete elem */
>                 test_map_kptr_success(true);
>         }
> --
> 2.47.3
>
>

