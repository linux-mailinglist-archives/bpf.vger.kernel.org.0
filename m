Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4C1C8532
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgEGI4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 04:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgEGI4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 04:56:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A3C061A10
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 01:56:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so5867445wma.4
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hLWaQUTnJ7f7DgBuYKSFC32i9PCp8zzauvLXWUcYmNc=;
        b=N8WW7vEdih/4X6y8BA9cfZcTgB+tDYkRfBKAbgsvVDJg7ZGE9p3rrq/03IkuDkT6Ev
         6MyjgkRjsN/k9awGsZMiNiGQ/KKKYg9n+kFg3rIithm+DTExseBN/yUN4j89GmrQDcN4
         wbFm4iX1j1+3h/M3EQyXzLbTuY5vQr5J+1z00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hLWaQUTnJ7f7DgBuYKSFC32i9PCp8zzauvLXWUcYmNc=;
        b=nL5B+ynofKVWou/IM+PQ/8MTg1tSqQT2Pv2+VUEYtDTJkrZshGolQCRQ9IAFLyNDkR
         gBsbXqDZywSZiVMG2mdv46gVfvTP8rmXUDA66Vm14KsDtaPTT4bBF//bkDNKpJwovIv7
         wPvQtH+yqbeb3PUhJjLphWZ/wFqI5JlSBQ1BBvNVKlTjPByzUcrL5SyWev9jrq0+eHKS
         C7ZbRSME6sbPq3rJIvjEX4DlPjGWsYMzmSAw7Xu2YxGec32OoqpHw+ZTyC8jOyrtc9O1
         kzIjitHiUWNYkMkcuwQWanS0sE3Gsjvxr3OFghy+U9607R3NoeepXhR2VbP8aS5EP4as
         qxPg==
X-Gm-Message-State: AGi0PuZvxhDhW46Gwmwj/ZJ3LTTIzmDfCHuqvZbnatclHn7Y3x7nl+Y3
        pi4UtWbyL/96VvceMnYWrv1+ng==
X-Google-Smtp-Source: APiQypIarRKCDwwq9BJ7HIOIQBZ5gaFvnSebCKJDXnJg51HpGccvWC6okg6H+MBNXtWjjLEoH7mqFw==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr9612793wmh.6.1588841774781;
        Thu, 07 May 2020 01:56:14 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 17sm6740090wmo.2.2020.05.07.01.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 01:56:14 -0700 (PDT)
Date:   Thu, 7 May 2020 10:55:50 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     lmb@cloudflare.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, ast@kernel.org
Subject: Re: [bpf-next PATCH 05/10] bpf: selftests, improve test_sockmap
 total bytes counter
Message-ID: <20200507105550.35adc82f@toad>
In-Reply-To: <158871187408.7537.17124775242608386871.stgit@john-Precision-5820-Tower>
References: <158871160668.7537.2576154513696580062.stgit@john-Precision-5820-Tower>
        <158871187408.7537.17124775242608386871.stgit@john-Precision-5820-Tower>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 05 May 2020 13:51:14 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> The recv thread in test_sockmap waits to receive all bytes from sender but
> in the case we use pop data it may wait for more bytes then actually being
> sent. This stalls the test harness for multiple seconds. Because this
> happens in multiple tests it slows time to run the selftest.
> 
> Fix by doing a better job of accounting for total bytes when pop helpers
> are used.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a81ed5d..36aca86 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -502,9 +502,10 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>  		 * paths.
>  		 */
>  		total_bytes = (float)iov_count * (float)iov_length * (float)cnt;
> -		txmsg_pop_total = txmsg_pop;
>  		if (txmsg_apply)
> -			txmsg_pop_total *= (total_bytes / txmsg_apply);
> +			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
> +		else
> +			txmsg_pop_total = txmsg_pop * cnt;
>  		total_bytes -= txmsg_pop_total;
>  		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
>  		if (err < 0)
> @@ -638,9 +639,13 @@ static int sendmsg_test(struct sockmap_options *opt)
>  
>  	rxpid = fork();
>  	if (rxpid == 0) {
> +		iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
>  		if (opt->drop_expected)
>  			exit(0);
>  
> +		if (!iov_buf) /* zero bytes sent case */
> +			exit(0);

You probably want to call _exit() from the child to prevent flushing
stdio buffers twice.

> +
>  		if (opt->sendpage)
>  			iov_count = 1;
>  		err = msg_loop(rx_fd, iov_count, iov_buf,
> 

