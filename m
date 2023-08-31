Return-Path: <bpf+bounces-9047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B478EC67
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CDC1C20A6A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF69466;
	Thu, 31 Aug 2023 11:46:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC948462
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 11:46:24 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660DC5
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tWjbYYOshhMOpizMiwYH3iIC5gzyMAdEilmfEe7X10o=; b=qVGi7q1o/vyk1zXAHDA858SwX/
	OkuwFwrDgqhF2HEjkvhO56lNOmiCMhyIZHZ3sCmG6gkzXvomhRzZ530RRRQAjsmDvrYqIDszGWwHY
	7da5vFq5ltYKmx48oZlXSu5nEeABcq5XxEcZZAw1j+9bHKyvIQ6FsntYFo7YBw0w6bOD8iVoC/K8t
	trk2dPsTsDvlfGXrxBtLqCv4vftHdMwAV3jsj33ctUSqPTcdyoMiuDEWPhLr2IZSuKw4bhNdLBdC6
	LAC1E4gsYzcE8fA8RdcfcbPop8xHTekIOEQ7IqxN7LmrPfK0YqG5RHlTC2/LCgVI8Yq3EzjZnkB97
	IGWuwHnw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbg7m-000OL0-Eq; Thu, 31 Aug 2023 13:46:10 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbg7m-000TVH-88; Thu, 31 Aug 2023 13:46:10 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix d_path test
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
References: <20230831110020.290102-1-jolsa@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c157270-52e9-774e-6641-bdd32ab69ddf@iogearbox.net>
Date: Thu, 31 Aug 2023 13:46:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230831110020.290102-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 1:00 PM, Jiri Olsa wrote:
> Recent commit [1] broken d_path test, because now filp_close is not called
> directly from sys_close, but eventually later when the file is finally
> released.
> 
> As suggested by Hou Tao we don't need to re-hook the bpf program, but just
> instead we can use sys_close_range to trigger filp_close synchronously.
> 
> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> Suggested-by: Hou Tao <houtao@huaweicloud.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   tools/testing/selftests/bpf/prog_tests/d_path.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index 911345c526e6..81e34a4a05d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -90,7 +90,11 @@ static int trigger_fstat_events(pid_t pid)
>   	fstat(indicatorfd, &fileStat);
>   
>   out_close:
> -	/* triggers filp_close */
> +	/* sys_close no longer triggers filp_close, but we can
> +	 * call sys_close_range instead which still does
> +	 */
> +#define close(fd) close_range(fd, fd, 0)
> +

The BPF CI selftest build says:

     [...]
     TEST-OBJ [test_progs] lookup_key.test.o
     TEST-OBJ [test_progs] migrate_reuseport.test.o
     TEST-OBJ [test_progs] user_ringbuf.test.o
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c: In function ‘trigger_fstat_events’:
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:96:19: error: implicit declaration of function ‘close_range’ [-Werror=implicit-function-declaration]
      96 | #define close(fd) close_range(fd, fd, 0)
         |                   ^~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/d_path.c:98:2: note: in expansion of macro ‘close’
      98 |  close(pipefd[0]);
         |  ^~~~~
     TEST-OBJ [test_progs] task_pt_regs.test.o
     [...]

Perhaps #include <linux/close_range.h> missing ?

>   	close(pipefd[0]);
>   	close(pipefd[1]);
>   	close(sockfd);
> @@ -98,6 +102,8 @@ static int trigger_fstat_events(pid_t pid)
>   	close(devfd);
>   	close(localfd);
>   	close(indicatorfd);
> +
> +#undef close
>   	return ret;
>   }
>   
> 


