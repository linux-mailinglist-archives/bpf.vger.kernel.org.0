Return-Path: <bpf+bounces-79202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BBD2D46A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2493037899
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2232D7F8;
	Fri, 16 Jan 2026 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebxacMPQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2B61FFE
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548893; cv=pass; b=DjR8wRIpTP1fY7vIkSWhYFkEq30vsALQPGUuTTFnfXmUf8lUwyYWlSaOpcGhme4XJROugj/fEFNu2jXIbnTWGKbinKR1eatwdQjA/HXkCwMV6zgiLZWA0Bk94XvV87ZlQUTl8GcpsGmSnHyOYZEW7QErs5IRq9gIiZfq3Xz4IqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548893; c=relaxed/simple;
	bh=SyMhS5QbwcKkKj77rhNIBpICR2pVeJ+bAsm2RnwaIWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwpLrH19wL8G7krYiLWEhtYIAxmNg2W0C0yk3opDKiibxKzgIIyMTBEPc+aWZnADFNpi+4bym5iEZZr1DdHiZn3DRiBNXg2v0fXtMKVUntApEYPdTZCcDM6eQf6rXALoxOSygGXDXi8/SNauxkGSCGpYbuVE3QNRhsSlwldubE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebxacMPQ; arc=pass smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-66106a2f8d0so1151104eaf.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 23:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768548889; cv=none;
        d=google.com; s=arc-20240605;
        b=VuZefKRaoSJQo/4wsx7lUVWCxsUZpniZBXjCd9ECS9OkvFtDiSrMMDfhKlQch4k5t0
         z/CLfegkBGGBpWXsj6HcQsk10RmSwLSAz+O76WJvltRYBnsSNCvoD7f2CAj0GKCLbRON
         tT+Hr8ejZjjclOWeqDNgYetUeCwo742hOTUlFqGTO4dIwhQpqjqtCDSP9+vkG0K602DV
         zqgxafKI+MEgIFszZXRccQ2yZeQHZXrX4j2HRblZ+5XS4vVFUa9DGFde71NBRaVW5og5
         uNB21rjMo9vkltdor9pD355YbrUhKV0ucPbRV+FN4+cbtyyafq0RWjaCb7u4YDvwBgZ6
         Eh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BhAxLviBcLQS3g2rBMwRxBWgs7dTFQtXoUkJppLhRfE=;
        fh=tO80IZDqCrhwPFeZWIA5evn6CX76GCzQzbZA5XHZqjk=;
        b=fPqXr8kFNjAcqMJ4Rv8Riuzc2mgFRCdJQ/vWZyRK3t5ZiUzE2H++hFfzcdJ3Eg8WwE
         ar3x59+c9FVn63sXrSKSxuS1V/yOa91Cbk2CiggQVaSoNeS3hwR0xYd9q5yoDr1mvelc
         xBMEvaSp6luw6oXwxANnaKb7zYRh3PpElIXcjxflr16t/ay6n1WFuJyVUYAlKMiKii80
         JMSZjGRgMQr2oI8xUA+iKUXAuRu5Hgl7u+rSF8jnyL3G5ocM7q/LeGMdyywEVDulyDVn
         3t+cgBf1d7Ju4yKzSK9XfRGvtd69H8KsiKIVnmhdAkgYk6OzNZLNvj6/wZ9ZqNHJHiE5
         XR0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768548889; x=1769153689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhAxLviBcLQS3g2rBMwRxBWgs7dTFQtXoUkJppLhRfE=;
        b=ebxacMPQ7so/gAQ5DLf2qy3VnAbjkgeU1ituTCKlljsuDcfa3KPcl7cgFBv7qodN5X
         9P3yc/4JkZGG/4baItWasNAi5jwSMjjYdxLEdJhEmJV34vmL7EmXVusRR1qx/xaGRH5a
         afx6Y8GHWzlL1nExSBjHyud+d7wOgR2HWqGAd97XOW7cv6qVZ37HnZsiFvCvCk4GSuf/
         MQWbuND8E5GE+ph2+nUfQxSx4+b621yWu3FoMTxjsdslRjPMh71oP4KzuuT2iGRUr+K2
         egnrLeOJgCAQ1OB6LX9yIMCjFL1xNYHiQQUy9NOqXou+NUH7ByaC37YvxL0QVbpYmZB5
         TDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548889; x=1769153689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhAxLviBcLQS3g2rBMwRxBWgs7dTFQtXoUkJppLhRfE=;
        b=VEz6OM1ij5iBvhimNdcAh+xF+L4bndGLy0Porn1DKpHUnQd91NZA0VEAru3vjs5lJz
         voxag+v4GZp/Bk42kHV/v60vYaqe3+AXE3xZv+Gliim1PLPcrRLg565SbTApPvsG3O9a
         ydDLbOIh25zVegyXSV+6guJKuYf5we1IOwXniOoVPBtsp1pC+pxdmxDglMjiKBE0OPCo
         2w+tWsvoPEixIec3lzZjiLhQVHNweQT4500BTQ0TOLNXAVamVwPq9neEfbX5lDhxcPsO
         6YBTJFlxEvN4T8ilsmAfgOeeztFRHgjcGdpQOt17NLZx2ftwmjqBDRl4AuWPz1VM+WAa
         Xm4g==
X-Gm-Message-State: AOJu0Yyxab8cNN8Du1C2uvNsCCZrqQCUPPp7NLJfWnu9IhOSjc4eCmiA
	g+SYKMad4Aq8FNo3NhVG/raMGO2Z6sYV3X20D9dCfXzE9nG/5Bx3h/h63vBS1L4nv0eHxvLFw97
	XoxGWglCd6IHumwFSv4g6iTmXdPXbbUhOeAkZvdg=
X-Gm-Gg: AY/fxX6Ynk/IAxcvlS7Z9nNoEoqvO6gbosblnPiKpkyKqrndhmcBvIECIfYoeE5c1OL
	TIqs88szdI8YGomqUHcz+C3ZaiwJZQp3E34pVG3+bX96XCys8gab53YTSzOnN1zPk6BNtu4LpqX
	bgSUaAh41Re7wcsH0PpvvYfi1lNhLA+UZJiIwe2CbJwFueZWrWxwXZEW5vsOS5s8a59FODdYlYi
	QT0eriItuWtLvUTCSLlUnML1Ww/rMNxhVaBNpBk4v6kxw7McWau/VAR501Em9nKxXAP1HsPyj71
	NP6gu8CWeBrgAKotbNPbjnDHy3wEtPfw4R7TM+2GVxaKSZOzfqRItVnNa77jUg==
X-Received: by 2002:a05:6820:4510:b0:65d:4d4:e7ad with SMTP id
 006d021491bc7-66117959669mr836591eaf.13.1768548889006; Thu, 15 Jan 2026
 23:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116052245.3692405-1-yonghong.song@linux.dev>
In-Reply-To: <20260116052245.3692405-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Jan 2026 08:34:11 +0100
X-Gm-Features: AZwV_QjIxBbj5AYH3UwJq3vlMRl-SGYEI-vXh-rIXWJX0-CNzLZzmkISXSeWpA0
Message-ID: <CAP01T77Vbe45h9uyqBHJKGnqxKM_PTi2yS1j8=fchMLgTSwL=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix map_kptr test failure
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan 2026 at 06:23, Yonghong Song <yonghong.song@linux.dev> wrote:
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
> Since it is not clear how long queue_work() time takes, a bpf prog
> is added to count the reference after bpf_kfunc_call_test_acquire().
> If the number of references is 2 (for initial ref and the one just
> acquired), all previous maps should have been released. This will
> resolve the above 'retval unexpected error' issue.
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  .../selftests/bpf/prog_tests/map_kptr.c       | 23 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/map_kptr.c  | 18 +++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> index 8743df599567..f372162c0280 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
> @@ -131,6 +131,25 @@ static int kern_sync_rcu_tasks_trace(struct rcu_tasks_trace_gp *rcu)
>         return 0;
>  }
>
> +static void wait_for_map_release(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, lopts);
> +       struct map_kptr *skel;
> +       int ret;
> +
> +       skel = map_kptr__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
> +               return;
> +
> +       do {
> +               ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_ref), &lopts);
> +               ASSERT_OK(ret, "count_ref ret");
> +               ASSERT_OK(lopts.retval, "count_ref retval");
> +       } while (skel->bss->num_of_refs != 2);
> +
> +       map_kptr__destroy(skel);
> +}
> +
>  void serial_test_map_kptr(void)
>  {
>         struct rcu_tasks_trace_gp *skel;
> @@ -148,11 +167,15 @@ void serial_test_map_kptr(void)
>
>                 ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>                 ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               wait_for_map_release();
> +
>                 /* Observe refcount dropping to 1 on bpf_map_free_deferred */
>                 test_map_kptr_success(false);
>
>                 ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
>                 ASSERT_OK(kern_sync_rcu(), "sync rcu");
> +               wait_for_map_release();
> +
>                 /* Observe refcount dropping to 1 on synchronous delete elem */
>                 test_map_kptr_success(true);
>         }
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
> index edaba481db9d..e708ffbe1f61 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr.c
> @@ -487,6 +487,24 @@ int test_map_kptr_ref3(struct __sk_buff *ctx)
>         return 0;
>  }
>
> +int num_of_refs;
> +
> +SEC("syscall")
> +int count_ref(void *ctx)
> +{
> +       struct prog_test_ref_kfunc *p;
> +       unsigned long arg = 0;
> +
> +       p = bpf_kfunc_call_test_acquire(&arg);
> +       if (!p)
> +               return 1;
> +
> +       num_of_refs = p->cnt.refs.counter;
> +
> +       bpf_kfunc_call_test_release(p);
> +       return 0;
> +}
> +
>  SEC("syscall")
>  int test_ls_map_kptr_ref1(void *ctx)
>  {
> --
> 2.47.3
>
>

