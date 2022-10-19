Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C556050E9
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJST5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJST5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 15:57:50 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248441D6A79
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 12:57:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 83-20020a630156000000b0046b208f6ae3so9039794pgb.16
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxtLeLxXIzAwKv97mKik5xeIpEYFS2yB3Zq9HvoeakQ=;
        b=nkLjqlk8DnxmcR8xxQwvBupCxH34AMDV6s9GDzcYNK3USfRQUn3v4mysH45AYmcv/O
         k2zobMyVPThx35meEc7hFKuHieHctgQWj7KG8NLoDeJNp5P9AwBpAmJdAOMBMrBNpF+l
         L7gm1ZtAImeLA+PNnsXqx0gDJFEWxGD3LoaN6gfq3xuSJzZ96QHoirPAbURX+gzmJBPE
         pEqQDslLP2WkOYXLe8Zu5MCAzqYeIewoHe1YUpnaXUlH16n7/YBWownTitcOS5qOJqOd
         SX3XulWT7Be+rb3MZGCQ1+8zR7Y7KGYcJciCndGouWc5iWHEUqDEzKeyWQL9RgrMVwz6
         wbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxtLeLxXIzAwKv97mKik5xeIpEYFS2yB3Zq9HvoeakQ=;
        b=qPVmxNhK1fhFkon5IKZ+8Rjsuu2Kc7D6fRgcK9ZzcdrhfV1wl/k9VGWpFTaaGNEyuD
         3xgYoEJ1q0ugVfwt8XPEOksv+Ozq9NkFCGtyLGdMfwIHCBmiYdlarhrfQDySbsdHRDqI
         YlQZlbM8geYugY2b08Gtw2BBSlBCALcD0Ydj1hqyGXS9jtl/9lDTocVZuv/4hxyN11zk
         6Y7aDD8YV6QpFtnUPrcRD6+YRhVfF4TzjFKuOOweRsr5ufln8ABycFZf2dKZ9oSmXVku
         Vhr6Q8TqRm103BbITiqOyyi/pHK6kxpkYDuR9yJS2YV9jsWQbgaZLl1bmkuJ1R7AndZR
         oYqw==
X-Gm-Message-State: ACrzQf0RzAYs+bC+Pd0Up5cIXrmCQwFZeZnYvYdN4s76fVjiylFdbbDx
        7f0S+ZIbjBBPrvx1zAMWXuo6hwc=
X-Google-Smtp-Source: AMsMyM4NLxLrIfJoosAK2D7iaWjpJNivIvjp3ZmEKrH3/3T3+Onexkeq0t7LoDzyG1/nMz0c3HqZ8KQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:4c84:b0:562:ed08:599a with SMTP id
 eb4-20020a056a004c8400b00562ed08599amr10366429pfb.64.1666209469677; Wed, 19
 Oct 2022 12:57:49 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:57:48 -0700
In-Reply-To: <f04cf27b05047cfb2c90db160383e2e9c2c40b93.camel@fb.com>
Mime-Version: 1.0
References: <f04cf27b05047cfb2c90db160383e2e9c2c40b93.camel@fb.com>
Message-ID: <Y1BWvNdHHwHbPXDk@google.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
From:   sdf@google.com
To:     Delyan Kratunov <delyank@meta.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/19, Delyan Kratunov wrote:
> BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
> The failure point in CI [1] is that null_ptr_count is equal to 0,
> which indicates that the program hasn't run yet. This points to the
> kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
> waiting sufficiently.

> Indeed, synchronize_rcu only waits for read-side sections that started
> before the call. If the program execution starts *during* the
> synchronize_rcu invocation (due to, say, preemption), the test won't
> wait long enough.

> As a speculative fix, make the synchornize_rcu calls in a loop until
> an explicit run counter has gone up.

>    [1]:  
> https://github.com/kernel-patches/bpf/actions/runs/3268263235/jobs/5374940791

> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
> v1 -> v2:
> Explicit loop counter and MAX_SYNC_RCU_CALLS guard.

>   .../bpf/prog_tests/task_local_storage.c        | 18 +++++++++++++++---
>   .../bpf/progs/task_local_storage_exit_creds.c  |  3 +++
>   2 files changed, 18 insertions(+), 3 deletions(-)

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c  
> b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 035c263aab1b..99a42a2b6e14 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -39,7 +39,8 @@ static void test_sys_enter_exit(void)
>   static void test_exit_creds(void)
>   {
>   	struct task_local_storage_exit_creds *skel;
> -	int err;
> +	int err, run_count, sync_rcu_calls = 0;
> +	const int MAX_SYNC_RCU_CALLS = 1000;

>   	skel = task_local_storage_exit_creds__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> @@ -53,8 +54,19 @@ static void test_exit_creds(void)
>   	if (CHECK_FAIL(system("ls > /dev/null")))
>   		goto out;

> -	/* sync rcu to make sure exit_creds() is called for "ls" */
> -	kern_sync_rcu();
> +	/* kern_sync_rcu is not enough on its own as the read section we want
> +	 * to wait for may start after we enter synchronize_rcu, so our call
> +	 * won't wait for the section to finish. Loop on the run counter
> +	 * as well to ensure the program has run.
> +	 */
> +	do {
> +		kern_sync_rcu();
> +		run_count = __atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST);
> +	} while (run_count == 0 && ++sync_rcu_calls < MAX_SYNC_RCU_CALLS);

Acked-by: Stanislav Fomichev <sdf@google.com>

Might have been easier to do the following instead?

int sync_rcu_calls = 1000;
do {
} while (run_count == 0 && --sync_rcu_calls);


> +
> +	ASSERT_NEQ(sync_rcu_calls, MAX_SYNC_RCU_CALLS,
> +		   "sync_rcu count too high");
> +	ASSERT_NEQ(run_count, 0, "run_count");
>   	ASSERT_EQ(skel->bss->valid_ptr_count, 0, "valid_ptr_count");
>   	ASSERT_NEQ(skel->bss->null_ptr_count, 0, "null_ptr_count");
>   out:
> diff --git  
> a/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c  
> b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> index 81758c0aef99..41d88ed222ff 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> +++ b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> @@ -14,6 +14,7 @@ struct {
>   	__type(value, __u64);
>   } task_storage SEC(".maps");

> +int run_count = 0;
>   int valid_ptr_count = 0;
>   int null_ptr_count = 0;

> @@ -28,5 +29,7 @@ int BPF_PROG(trace_exit_creds, struct task_struct *task)
>   		__sync_fetch_and_add(&valid_ptr_count, 1);
>   	else
>   		__sync_fetch_and_add(&null_ptr_count, 1);
> +
> +	__sync_fetch_and_add(&run_count, 1);
>   	return 0;
>   }
> --
> 2.37.3
