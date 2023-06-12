Return-Path: <bpf+bounces-2400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142072C91F
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC0281003
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E571C747;
	Mon, 12 Jun 2023 15:00:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC4AD38
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:00:42 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260112A
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JjsrqlW40ci5h74PU32NelL6tOG3LuwmypQxb6oNNSM=; b=WFJxdFphd46g/SBOz6Jqb9jY5U
	BNBQFD0mDyuHCHSIm2K4VPWBOOCYeChtBtU3yuewN/nQJ50YALRMoWuqsRK17K80YRkHxSn6aHmed
	xPNTKlT0tG5a2hn/5xYYR3ozGCY1w6XXMzF9REXaKmvrct66lxHIT7shI7iqkzhq0+C/tuQXweByq
	CVSqHQSJkT5lUCpdfeyZ5hxYX5WvuSpUYaJi5d22sltCTE5X6M9OAld9UzX3+hL3yY4cXCMWJB6KM
	DEhjdLs26Tx8qrBgOQY6rjtrgu3CGnBUyYskUTURHvJ9W+AlDdS2n4lxVu7vQQH8Mv8DhHmhTh32Q
	bLGUFLsA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8j24-000BR0-GZ; Mon, 12 Jun 2023 17:00:36 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8j24-0001mt-7y; Mon, 12 Jun 2023 17:00:36 +0200
Subject: Re: [PATCH bpf-next v1] selftests/bpf: fix invalid pointer check in
 get_xlated_program()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com,
 dan.carpenter@linaro.org
References: <20230609221637.2631800-1-eddyz87@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f9f4242-6943-5305-20d5-0270aaf506ed@iogearbox.net>
Date: Mon, 12 Jun 2023 17:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230609221637.2631800-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26937/Mon Jun 12 09:24:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/10/23 12:16 AM, Eduard Zingerman wrote:
> Dan Carpenter reported invalid check for calloc() result in
> test_verifier.c:get_xlated_program():
> 
>    ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program()
>    warn: variable dereferenced before check 'buf' (see line 1364)
> 
>    ./tools/testing/selftests/bpf/test_verifier.c
>      1363		*cnt = xlated_prog_len / buf_element_size;
>      1364		*buf = calloc(*cnt, buf_element_size);
>      1365		if (!buf) {
> 
>    This should be if (!*buf) {
> 
>      1366			perror("can't allocate xlated program buffer");
>      1367			return -ENOMEM;
> 
> This commit refactors the get_xlated_program() to avoid using double
> pointer type.

Isn't the small reported fix above sufficient? (Either is fine with me though.)

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/ZH7u0hEGVB4MjGZq@moroto/
> Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   tools/testing/selftests/bpf/test_verifier.c | 26 ++++++++++++---------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 71704a38cac3..c6bc9e26d333 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1341,45 +1341,48 @@ static bool cmp_str_seq(const char *log, const char *exp)
>   	return true;
>   }
>   
> -static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
> +static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
>   {
>   	struct bpf_prog_info info = {};
>   	__u32 info_len = sizeof(info);
> +	__u32 buf_element_size;
>   	__u32 xlated_prog_len;
> -	__u32 buf_element_size = sizeof(struct bpf_insn);
> +	struct bpf_insn *buf;
> +
> +	buf_element_size = sizeof(struct bpf_insn);

Just small nit: the `__u32 buf_element_size = sizeof(struct bpf_insn);` could have
stayed as is.

>   	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
>   		perror("bpf_prog_get_info_by_fd failed");
> -		return -1;
> +		return NULL;
>   	}
>   
>   	xlated_prog_len = info.xlated_prog_len;
>   	if (xlated_prog_len % buf_element_size) {
>   		printf("Program length %d is not multiple of %d\n",
>   		       xlated_prog_len, buf_element_size);
> -		return -1;
> +		return NULL;
>   	}
>   
>   	*cnt = xlated_prog_len / buf_element_size;
> -	*buf = calloc(*cnt, buf_element_size);
> +	buf = calloc(*cnt, buf_element_size);
>   	if (!buf) {
>   		perror("can't allocate xlated program buffer");
> -		return -ENOMEM;
> +		return NULL;
>   	}
>   
>   	bzero(&info, sizeof(info));
>   	info.xlated_prog_len = xlated_prog_len;
> -	info.xlated_prog_insns = (__u64)(unsigned long)*buf;
> +	info.xlated_prog_insns = (__u64)(unsigned long)buf;
>   	if (bpf_prog_get_info_by_fd(fd_prog, &info, &info_len)) {
>   		perror("second bpf_prog_get_info_by_fd failed");
>   		goto out_free_buf;
>   	}
>   
> -	return 0;
> +	return buf;
>   
>   out_free_buf:
> -	free(*buf);
> -	return -1;
> +	free(buf);
> +	return NULL;
>   }
>   
>   static bool is_null_insn(struct bpf_insn *insn)
> @@ -1512,7 +1515,8 @@ static bool check_xlated_program(struct bpf_test *test, int fd_prog)
>   	if (!check_expected && !check_unexpected)
>   		goto out;
>   
> -	if (get_xlated_program(fd_prog, &buf, &cnt)) {
> +	buf = get_xlated_program(fd_prog, &cnt);
> +	if (!buf) {
>   		printf("FAIL: can't get xlated program\n");
>   		result = false;
>   		goto out;
> 


