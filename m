Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08C61E6E74
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436918AbgE1WP0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 18:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbgE1WPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 18:15:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B5C08C5C7
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 15:15:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so1016932wrr.10
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tKJbumpGqZmnclq7GbiBdZ50WTcRNhFITifZdyb3Vn0=;
        b=XxGeT0PWKsipxKs2uWbL7Lqp0wuU84JcuIuIulPDd1oOOqYkT9TXK/Ew9+DhA+jCQ5
         IkuHdGptJ7JAnqf2f5m7DSlOacgmk9uk10PYsxexY8u5vCrQJcXojJGLtSrksdFPbXop
         2ft6JlN52c8qrGY8tlnM9HNxKwH0aKSVh8reI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tKJbumpGqZmnclq7GbiBdZ50WTcRNhFITifZdyb3Vn0=;
        b=MtJ1nFFJFW6ktMqz7z//U+gwq6pfMQ0rPftHBHvNnP6m+lqDiTkLYGX5lcx0GmPq60
         lnQ8BTh6vZTR1kF6Laz4+WCFCLJWOCB38w+//VYEKVH6upNT3jYHD+QJqG1yRs7UmH+p
         LpQORo4Jsj+eRrcIkggNswMj7tEdcNa55Cx3b96gkYYbjHzFGOyvGSgPgpXuZBgneKxf
         du6WVGzHNwapBGbUXDjnCHaB63BJaYLsHlUvFqhfqFVdjVdG59W1Ea5eH0aLx5uwyRPz
         rtkl7TlmekFeUe8eLBBvtE1rg2erfYb+ZBXDVxzVaG5Xp/6LeDlzlfsKAWZ92tAtzYko
         KqBw==
X-Gm-Message-State: AOAM533SCpLAm1xXm4Q38hBEdCpDplU28uucZlzFWgB1aaLpm9L8sLI4
        x6dNyxTEQAY0yHQVZPQwLJmV1tocfMg=
X-Google-Smtp-Source: ABdhPJzPsygpU2/euvnkOWcXaG8K1B+p0wpYBvjRGBDK5KK+lfl54o9THeippZCGLR6QpWr1h9V6dQ==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr5357406wrq.196.1590704123185;
        Thu, 28 May 2020 15:15:23 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a16sm7160974wrx.8.2020.05.28.15.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:15:22 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 29 May 2020 00:15:21 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: basic sleepable tests
Message-ID: <20200528221521.GC217782@google.com>
References: <20200528053334.89293-1-alexei.starovoitov@gmail.com>
 <20200528053334.89293-4-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528053334.89293-4-alexei.starovoitov@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 27-May 22:33, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Modify few tests to sanity test sleepable bpf functionality.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: KP Singh <kpsingh@google.com>

> ---
>  tools/testing/selftests/bpf/bench.c             |  2 ++
>  .../selftests/bpf/benchs/bench_trigger.c        | 17 +++++++++++++++++
>  tools/testing/selftests/bpf/progs/lsm.c         |  4 ++--
>  .../testing/selftests/bpf/progs/trigger_bench.c |  7 +++++++
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
>  

[...]

> -SEC("lsm/bprm_committed_creds")
> +SEC("lsm.s/bprm_committed_creds")
>  int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
>  {
>  	__u32 pid = bpf_get_current_pid_tgid() >> 32;
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> index 8b36b6640e7e..9a4d09590b3d 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -39,6 +39,13 @@ int bench_trigger_fentry(void *ctx)
>  	return 0;
>  }
>  
> +SEC("fentry.s/__x64_sys_getpgid")
> +int bench_trigger_fentry_sleep(void *ctx)
> +{
> +	__sync_add_and_fetch(&hits, 1);
> +	return 0;
> +}
> +
>  SEC("fmod_ret/__x64_sys_getpgid")
>  int bench_trigger_fmodret(void *ctx)
>  {
> -- 
> 2.23.0
> 
