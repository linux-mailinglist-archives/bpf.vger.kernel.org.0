Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D869584072
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiG1N6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiG1N6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 09:58:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736461EEE6
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 06:58:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so2215788wrh.12
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=G5FonpUVK1WwPexgiDNWi8hqjTS2TA/awvImNSYH0kI=;
        b=LRrdGQpEhCZLHjGWTFUTnUfowaPxj5EkcNpMid6ECYsgoOLqMX+ay33zJB4Jp9bjeB
         1xx3VInX5YIClTen6opunbhPWKDBfTAm0BXLEr4sw4k7bk/R/8zFabi6VF2AqqjEP4W2
         HFY+7j+F1WG/y4qLvdOcQKOz6c9Nom+k459fOFNrTcBqjEpUhyDXtnPkWPTiEIukjdUd
         PiQQX3DwbFSugeWLROS6uYtlrnWeddzxjWdPASAVAF9i4RiLv4is2RLGEditYZenc9xp
         0HvKjzOyPnlyWJ5j6/Gr2qWu+HVRwUUXtOVFfPcmfupnonjl+TiG4MeQa6DfiGgTCdwG
         /IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=G5FonpUVK1WwPexgiDNWi8hqjTS2TA/awvImNSYH0kI=;
        b=KGQqOuLoXBxTkrknCUaL3Xs66tuyqnD4A49XmCdWf4h30B2BhC26hce3sRZ8qMMO17
         DoWLKWSnum24BvCE/ou4UA2izG0zHv1QQRKEJuXY4ZRZnf4SEO2spdm4/6dV/q6kRTUX
         d5brxj+EH/RpfJIxdCZLHWWMTl2chcef+3F1sbaUnRuBZKb8zQsS5Rb/ue3d9KSuSmfn
         jJLxfIkZJHgfOpX0Tt9dcp75frMvtqY6RBo6risOfDToHdt+Gotf9xwfNoR/SrAQ57mN
         9+Kv8mZVNyxiRwQR9u0/c+78cjtRDZ80GiaUK7IhLfWln7Ezp4hAd0FqPmdFGYOzmDJH
         dZ6g==
X-Gm-Message-State: AJIora8juUqlEiz7KLYnn7MqBPPOvSH03dXJiX2jnK0MscUmTxBG2p9M
        E1juA8Yio19FJOlSAKY0sV8=
X-Google-Smtp-Source: AGRyM1tVsssrl4NZc7JoMNlwW5rwsK72ZmBJdG5eZusPDjVRjWLeCmh8yDZL/yXWrfinhojPdabAvA==
X-Received: by 2002:a5d:47ca:0:b0:21e:813f:e8d3 with SMTP id o10-20020a5d47ca000000b0021e813fe8d3mr14910440wrc.416.1659016685748;
        Thu, 28 Jul 2022 06:58:05 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id bd15-20020a05600c1f0f00b003a1980d55c4sm5768843wmb.47.2022.07.28.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:58:05 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 28 Jul 2022 15:58:02 +0200
To:     Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump internal
 send_signal/send_signal_tracepoint timeout
Message-ID: <YuKV6jG4SbwlcoDD@krava>
References: <20220727182955.4044988-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727182955.4044988-1-deso@posteo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 27, 2022 at 06:29:55PM +0000, Daniel Müller wrote:
> The send_signal/send_signal_tracepoint is pretty flaky, with at least
> one failure in every ten runs on a few attempts I've tried it:
>   > test_send_signal_common:PASS:pipe_c2p 0 nsec
>   > test_send_signal_common:PASS:pipe_p2c 0 nsec
>   > test_send_signal_common:PASS:fork 0 nsec
>   > test_send_signal_common:PASS:skel_open_and_load 0 nsec
>   > test_send_signal_common:PASS:skel_attach 0 nsec
>   > test_send_signal_common:PASS:pipe_read 0 nsec
>   > test_send_signal_common:PASS:pipe_write 0 nsec
>   > test_send_signal_common:PASS:reading pipe 0 nsec
>   > test_send_signal_common:PASS:reading pipe error: size 0 0 nsec
>   > test_send_signal_common:FAIL:incorrect result unexpected incorrect result: actual 48 != expected 50
>   > test_send_signal_common:PASS:pipe_write 0 nsec
>   > #139/1   send_signal/send_signal_tracepoint:FAIL
> 
> The reason does not appear to be a correctness issue in the strict
> sense. Rather, we merely do not receive the signal we are waiting for
> within the provided timeout.
> Let's bump the timeout by a factor of ten. With that change I have not
> been able to reproduce the failure in 150+ iterations. I am also sneaking
> in a small simplification to the test_progs test selection logic.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>

I reproduced the fail, can't reproduce anymore with the fix

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>  tools/testing/selftests/bpf/test_progs.c             | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index d71226e..d63a20 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -64,7 +64,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>  		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
>  
>  		/* wait a little for signal handler */
> -		for (int i = 0; i < 100000000 && !sigusr1_received; i++)
> +		for (int i = 0; i < 1000000000 && !sigusr1_received; i++)
>  			j /= i + j + 1;
>  
>  		buf[0] = sigusr1_received ? '2' : '0';
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index c639f2e..3561c9 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1604,11 +1604,8 @@ int main(int argc, char **argv)
>  		struct prog_test_def *test = &prog_test_defs[i];
>  
>  		test->test_num = i + 1;
> -		if (should_run(&env.test_selector,
> -				test->test_num, test->test_name))
> -			test->should_run = true;
> -		else
> -			test->should_run = false;
> +		test->should_run = should_run(&env.test_selector,
> +					      test->test_num, test->test_name);
>  
>  		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
>  		    (test->run_test != NULL && test->run_serial_test != NULL)) {
> -- 
> 2.30.2
> 
