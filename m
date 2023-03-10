Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086306B366C
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 07:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCJGO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 01:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJGO6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 01:14:58 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE807B114;
        Thu,  9 Mar 2023 22:14:57 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id c18so4720299qte.5;
        Thu, 09 Mar 2023 22:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678428896;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBqxJIszOhL5EdN0lNLCRXRLohkX0FtajrJJ9J49hKU=;
        b=N6huNys3v8xPh9odlb/W+8VtaIeRGR77eCJkr/GX7a76G6N/8RJ4xdejVl1m9LSd6/
         NaZjT2CPQu69iwCUfyPeRUgZmYEA6fUUVh8MDv27B9HYwpX0r7qBDdWzFxDAwYbKQMF5
         tPOwwBso4FebWr6tFvkcN7ct1riS/BN1UZINKi5Rx1V1EhDnWzyGF9wcO2xpmdm5SKXq
         mlzecePhMB1VNT1ceP98Nd/5hVKstpv5iogaQcGIBEt19smpjL8MiKZxnOpW5Nv/zf2a
         rncuCl0B/SPAqhK8opWKFoOBWhFH3PMUq+sje7hh8P68RXUXbIREJAwmdmzL6qhzFKrq
         iYew==
X-Gm-Message-State: AO0yUKUwS1OtHaKNDWVpSBEeoW9KMS9NAehVcRYl+qbUeuoP3qhPb6ju
        5XHt4kCs2uD8lgXvBcp1mkToxmZeBEMjMOMy
X-Google-Smtp-Source: AK7set9lHSB6QNWxpuzaU7Kl5QIyERH33dVtyv5u5/PPgwQDdvdvuKoJBM3A72Yo4EnkkYvlTjAlWg==
X-Received: by 2002:ac8:7c55:0:b0:3bf:b707:e889 with SMTP id o21-20020ac87c55000000b003bfb707e889mr43377049qtv.34.1678428895885;
        Thu, 09 Mar 2023 22:14:55 -0800 (PST)
Received: from maniforge ([2620:10d:c091:400::5:388b])
        by smtp.gmail.com with ESMTPSA id l30-20020ac8459e000000b003b868cdc689sm896468qtn.5.2023.03.09.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 22:14:55 -0800 (PST)
Date:   Fri, 10 Mar 2023 00:14:52 -0600
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf/selftests: Fix send_signal tracepoint tests
Message-ID: <20230310061452.GB1022987@maniforge>
References: <20230310061048.1418400-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310061048.1418400-1-void@manifault.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_NO_BRKTS_PCNT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 10, 2023 at 12:10:48AM -0600, David Vernet wrote:
> The send_signal tracepoint tests are non-deterministically failing in
> CI. The test works as follows:
> 
> 1. Two pairs of file descriptors are created using the pipe() function.
>    One pair is used to communicate between a parent process -> child
>    process, and the other for the reverse direction.
> 
> 2. A child is fork()'ed. The child process registers a signal handler,
>    notifies its parent that the signal handler is registered, and then
>    and waits for its parent to have enabled a BPF program that sends a
>    signal.
> 
> 3. The parent opens and loads a BPF skeleton with programs that send
>    signals to the child process. The different programs are triggered by
>    different perf events (either NMI or normal perf), or by regular
>    tracepoints. The signal is delivered to the child whenever the child
>    triggers the program.
> 
> 4. The child's signal handler is invoked, which sets a flag saying that
>    the signal handler was reached. The child then signals to the parent
>    that it received the signal, and the test ends.
> 
> The perf testcases (send_signal_perf{_thread} and
> send_signal_nmi{_thread}) work 100% of the time, but the tracepoint
> testcases fail non-deterministically because the tracepoint is not
> always being fired for the child.
> 
> There are two tracepoint programs registered in the test:
> 'tracepoint/sched/sched_switch', and
> 'tracepoint/syscalls/sys_enter_nanosleep'. The child never intentionally
> blocks, nor sleeps, so neither tracepoint is guaranteed to be triggered.
> To fix this, we can have the child trigger the nanosleep program with a
> usleep().
> 
> Before this patch, the test would fail locally every 2-3 runs. Now, it
> doesn't fail after more than 1000 runs.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index d63a20fbed33..61cc83fca53c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -64,8 +64,11 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>  		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>  
>  		/* wait a little for signal handler */
> -		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
> +		for (int i = 0; i < 1000000000 && !sigusr1_received; i++) {
>  			j /= i + j + 1;
> +			if (!attr)
> +				ASSERT_EQ(usleep(1), 0, "nanosleep_tp");

As soon as I sent this out, it occurred to me that having an ASSERT_EQ
like this is not a good idea. usleep() could be interrupted by a signal
and return EINTR, and the whole point of this test is to send signals to
the child. Let me resend this as v2 without the ASSERT_EQ.

> +		}
>  
>  		buf[0] = sigusr1_received ? '2' : '0';
>  		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
> -- 
> 2.39.0
> 
