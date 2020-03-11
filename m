Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A998182364
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgCKUlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 16:41:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45596 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgCKUlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 16:41:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so1975514pfg.12
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qpa1ydIOzDUTpsGi5IPp+gSn48RQbDGe4SB+T/cgd3g=;
        b=mMfcOVqX4yLBJ3puIqRsTeZLffxuuNdRWfYk2/ykIiNVuPz76ykKRYyFXqF1A+YZFv
         auHUsb2WtOtkb1rTUq2nAqM+I0cJvjiQ+aiU6xdGbm5EvPsW7Bpezq5117Pg++Ji58+7
         fdHwTgEMZ+70Be51wfv5JW5iAGMiWFpFtsWF6cA/2IzCQnyCj4ylXGR6LgQlU3/Vv3TI
         VU71HYR5Oo5W9RwOWJsoqzlF96NKIhWKEhGcJOtmtP8xIk8FujwP01DANEDRkynLWxRz
         5tMB42/egokMsf8hNy4Hn798CbMG7lTukK6rWV2oJGwqAzVliFkkpWnwZlCm5pUvI82L
         GXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qpa1ydIOzDUTpsGi5IPp+gSn48RQbDGe4SB+T/cgd3g=;
        b=JXVok/Ljdr0ayDJ5SMthbG3Ulcd9UGcKy16cAsFP8bnzeW3iak17czdjhGluMXktfX
         K5gpFkaRz+PT3GjunwXZqdQJlBzAgfsWbcrS+zf5x4nkK/e+vUKLirzKf9NJaPZ/K9CI
         Avgogh0g8P3RqZxqCATDMstF9ck6iDWsa8l7YPTNXdphE2cBEahqzq5IjDJ4wE9rXxA4
         PS1VAUen+GqLTRiirLmusHiTnVNNC08VwqUlH+GM/BjiBx+Y4OobKQ8/ox3v42/jJDVm
         Wul+JXbrTIIhH4V2bp2QC/aQDk7x8Rbs6eoBAsa5diI6EOaq83c4daBQWyMpZfcXTy9V
         KMGg==
X-Gm-Message-State: ANhLgQ2lKTR2dSoJCQrCbFiieaEDtY7hDK5FDmTu14swANOFrjg58XN5
        NahgAR+vpKM95vVXqlACKJabPw==
X-Google-Smtp-Source: ADFU+vts/jbToWeO1FO+3qu+EsGm1u0RQQgngoO/ykW7oDYajl7N9xgwwAWnCVZMypVTJ09BCc9bKw==
X-Received: by 2002:a63:8048:: with SMTP id j69mr4513295pgd.410.1583959267734;
        Wed, 11 Mar 2020 13:41:07 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id b64sm33440937pfa.94.2020.03.11.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 13:41:07 -0700 (PDT)
Date:   Wed, 11 Mar 2020 13:41:06 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, sdf@google.com, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: make tcp_rtt test more robust to
 failures
Message-ID: <20200311204106.GA2125642@mini-arch.hsd1.ca.comcast.net>
References: <20200311191513.3954203-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311191513.3954203-1-andriin@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/11, Andrii Nakryiko wrote:
> Switch to non-blocking accept and wait for server thread to exit before
> proceeding. I noticed that sometimes tcp_rtt server thread failure would
> "spill over" into other tests (that would run after tcp_rtt), probably just
> because server thread exits much later and tcp_rtt doesn't wait for it.
> 
> Fixes: 8a03222f508b ("selftests/bpf: test_progs: fix client/server race in tcp_rtt")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../selftests/bpf/prog_tests/tcp_rtt.c        | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> index f4cd60d6fba2..d235eea0de27 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
> @@ -188,7 +188,7 @@ static int start_server(void)
>  	};
>  	int fd;
>  
> -	fd = socket(AF_INET, SOCK_STREAM, 0);
> +	fd = socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0);
>  	if (fd < 0) {
>  		log_err("Failed to create server socket");
>  		return -1;
> @@ -205,6 +205,7 @@ static int start_server(void)
>  
>  static pthread_mutex_t server_started_mtx = PTHREAD_MUTEX_INITIALIZER;
>  static pthread_cond_t server_started = PTHREAD_COND_INITIALIZER;
> +static volatile bool server_done = false;
>  
>  static void *server_thread(void *arg)
>  {
> @@ -222,23 +223,22 @@ static void *server_thread(void *arg)
>  
>  	if (CHECK_FAIL(err < 0)) {
>  		perror("Failed to listed on socket");
> -		return NULL;
> +		return ERR_PTR(err);
>  	}
>  
> -	client_fd = accept(fd, (struct sockaddr *)&addr, &len);
> +	while (!server_done) {
> +		client_fd = accept(fd, (struct sockaddr *)&addr, &len);
> +		if (client_fd == -1 && errno == EAGAIN)
> +			continue;
> +		break;
> +	}
>  	if (CHECK_FAIL(client_fd < 0)) {
>  		perror("Failed to accept client");
> -		return NULL;
> +		return ERR_PTR(err);
>  	}
>  
> -	/* Wait for the next connection (that never arrives)
> -	 * to keep this thread alive to prevent calling
> -	 * close() on client_fd.
> -	 */
> -	if (CHECK_FAIL(accept(fd, (struct sockaddr *)&addr, &len) >= 0)) {
> -		perror("Unexpected success in second accept");
> -		return NULL;
> -	}
> +	while (!server_done)
> +		usleep(50);
>  
>  	close(client_fd);
>  
> @@ -249,6 +249,7 @@ void test_tcp_rtt(void)
>  {
>  	int server_fd, cgroup_fd;
>  	pthread_t tid;
> +	void *server_res;
>  
>  	cgroup_fd = test__join_cgroup("/tcp_rtt");
>  	if (CHECK_FAIL(cgroup_fd < 0))
> @@ -267,6 +268,11 @@ void test_tcp_rtt(void)
>  	pthread_mutex_unlock(&server_started_mtx);
>  
>  	CHECK_FAIL(run_test(cgroup_fd, server_fd));
> +
> +	server_done = true;

[..]
> +	pthread_join(tid, &server_res);
> +	CHECK_FAIL(IS_ERR(server_res));

I wonder if we add (move) close(server_fd) before pthread_join(), can we
fix this issue without using non-blocking socket? The accept() should
return as soon as server_fd is closed so it's essentially your
'server_done'.

> +
>  close_server_fd:
>  	close(server_fd);
>  close_cgroup_fd:
> -- 
> 2.17.1
> 
