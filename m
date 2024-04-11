Return-Path: <bpf+bounces-26462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A58A04BA
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 02:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E802828CCDC
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529E4D9FC;
	Thu, 11 Apr 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAQ0t7+c"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC304D9F2
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794169; cv=none; b=HU4QMNxPAx+LX1PlePqVYzD0r01s3LUMHy+09CZ5fvQx9MN4NbNcvQLwnlb42+bRAF4HLrEqXatflPPqnqi8dothnMqFoBNIs6mC25ez1QUrc2/7azdYFcafX/OBXVKtBaBAtmB9cAfuvKgQI2b2hVCqnqMNaXOU1XLC6BfrUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794169; c=relaxed/simple;
	bh=Pn8IkeU9nTMfgXFuiQwGEAdx37sg3l9O65S8c7hdEOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myxnf8v/I/EiNAic4+cLYzHYgwftK71EkazNfMBpCr7mYw9V02c2TmWLlO34ue9SSak0MKw2/kVP6xeIWmvU1atDcYVtu31a9PePNuZz//hW9jZlKRu8J+plZjY4t/blVczCFPqwx+vVXbSUi02koh5eone4giLmAp3VlYVChw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAQ0t7+c; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64fa1c03-26dc-4ec3-a54c-205900950862@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712794165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZExCBe7hwwn4uepO6LLI+cJ3O0djboHnUxsaxIsm90=;
	b=HAQ0t7+cjq8iNyvFLkpOwLJSaefq7J2/YIcVLgMz46XGLoYUgR+Fge0CvoIWMp5sSuxveV
	i1/iybnE3chw5lpInjLx2rQwPVC86Jo86vISqeRX/ChTtJ5F4Zt9DzWqwBZOHCt/2AOk1j
	6YlpFZLzrS6sFV13y0XAqRf6PYf5qng=
Date: Wed, 10 Apr 2024 17:09:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add read_trace_pipe_iter
 function
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20240410140952.292261-1-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240410140952.292261-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/10/24 7:09 AM, Jiri Olsa wrote:
> We have two printk tests reading trace_pipe in non blocking way,
> with the very same code. Moving that in new read_trace_pipe_iter
> function.
>
> Current read_trace_pipe is used from sampless/bpf and needs to
> do blocking read and printf of the trace_pipe data, using new
> read_trace_pipe_iter to implement that.
>
> Both printk tests do early checks for the number of found messages
> and can bail earlier, but I did not find any speed difference w/o
> that condition, so I did not complicate the change more for that.
>
> Some of the samples/bpf programs use read_trace_pipe function,
> so I kept that interface untouched. I did not see any issues with
> affected samples/bpf programs other than there's slight change in
> read_trace_pipe output. The current code uses puts that adds new
> line after the printed string, so we would occasionally see extra
> new line. With this patch we read output per lines, so there's no
> need to use puts and we can use just printf instead without extra
> new line.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Ack with a nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   v2 changes:
>     - call read_trace_pipe_iter callback only in case there's new data
>       read from getline
>
>   .../selftests/bpf/prog_tests/trace_printk.c   | 36 +++--------
>   .../selftests/bpf/prog_tests/trace_vprintk.c  | 36 +++--------
>   tools/testing/selftests/bpf/trace_helpers.c   | 63 ++++++++++++-------
>   tools/testing/selftests/bpf/trace_helpers.h   |  2 +
>   4 files changed, 60 insertions(+), 77 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> index 7b9124d506a5..e56e88596d64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
> @@ -5,18 +5,19 @@
>   
>   #include "trace_printk.lskel.h"
>   
> -#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
> -#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>   #define SEARCHMSG	"testing,testing"
>   
> +static void trace_pipe_cb(const char *str, void *data)
> +{
> +	if (strstr(str, SEARCHMSG) != NULL)
> +		(*(int *)data)++;
> +}
> +
>   void serial_test_trace_printk(void)
>   {
>   	struct trace_printk_lskel__bss *bss;
> -	int err = 0, iter = 0, found = 0;
>   	struct trace_printk_lskel *skel;
> -	char *buf = NULL;
> -	FILE *fp = NULL;
> -	size_t buflen;
> +	int err = 0, found = 0;
>   
>   	skel = trace_printk_lskel__open();
>   	if (!ASSERT_OK_PTR(skel, "trace_printk__open"))
> @@ -35,16 +36,6 @@ void serial_test_trace_printk(void)
>   	if (!ASSERT_OK(err, "trace_printk__attach"))
>   		goto cleanup;
>   
> -	if (access(TRACEFS_PIPE, F_OK) == 0)
> -		fp = fopen(TRACEFS_PIPE, "r");
> -	else
> -		fp = fopen(DEBUGFS_PIPE, "r");
> -	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
> -		goto cleanup;
> -
> -	/* We do not want to wait forever if this test fails... */
> -	fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
> -
>   	/* wait for tracepoint to trigger */
>   	usleep(1);
>   	trace_printk_lskel__detach(skel);
> @@ -56,21 +47,12 @@ void serial_test_trace_printk(void)
>   		goto cleanup;
>   
>   	/* verify our search string is in the trace buffer */
> -	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
> -		if (strstr(buf, SEARCHMSG) != NULL)
> -			found++;
> -		if (found == bss->trace_printk_ran)
> -			break;

The above condition is not covered, but I think it is okay since the test
will run in serial mode.

> -		if (++iter > 1000)
> -			break;
> -	}
> +	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
> +		 "read_trace_pipe_iter");
>   
>   	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
>   		goto cleanup;
>   
>   cleanup:
>   	trace_printk_lskel__destroy(skel);
> -	free(buf);
> -	if (fp)
> -		fclose(fp);
>   }
> diff --git a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
> index 44ea2fd88f4c..2af6a6f2096a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
> @@ -5,18 +5,19 @@
>   
>   #include "trace_vprintk.lskel.h"
>   
> -#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
> -#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>   #define SEARCHMSG	"1,2,3,4,5,6,7,8,9,10"
>   
> +static void trace_pipe_cb(const char *str, void *data)
> +{
> +	if (strstr(str, SEARCHMSG) != NULL)
> +		(*(int *)data)++;
> +}
> +
>   void serial_test_trace_vprintk(void)
>   {
>   	struct trace_vprintk_lskel__bss *bss;
> -	int err = 0, iter = 0, found = 0;
>   	struct trace_vprintk_lskel *skel;
> -	char *buf = NULL;
> -	FILE *fp = NULL;
> -	size_t buflen;
> +	int err = 0, found = 0;
>   
>   	skel = trace_vprintk_lskel__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "trace_vprintk__open_and_load"))
> @@ -28,16 +29,6 @@ void serial_test_trace_vprintk(void)
>   	if (!ASSERT_OK(err, "trace_vprintk__attach"))
>   		goto cleanup;
>   
> -	if (access(TRACEFS_PIPE, F_OK) == 0)
> -		fp = fopen(TRACEFS_PIPE, "r");
> -	else
> -		fp = fopen(DEBUGFS_PIPE, "r");
> -	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
> -		goto cleanup;
> -
> -	/* We do not want to wait forever if this test fails... */
> -	fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
> -
>   	/* wait for tracepoint to trigger */
>   	usleep(1);
>   	trace_vprintk_lskel__detach(skel);
> @@ -49,14 +40,8 @@ void serial_test_trace_vprintk(void)
>   		goto cleanup;
>   
>   	/* verify our search string is in the trace buffer */
> -	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
> -		if (strstr(buf, SEARCHMSG) != NULL)
> -			found++;
> -		if (found == bss->trace_vprintk_ran)
> -			break;
> -		if (++iter > 1000)
> -			break;
> -	}
> +	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
> +		 "read_trace_pipe_iter");
>   
>   	if (!ASSERT_EQ(found, bss->trace_vprintk_ran, "found"))
>   		goto cleanup;
> @@ -66,7 +51,4 @@ void serial_test_trace_vprintk(void)
>   
>   cleanup:
>   	trace_vprintk_lskel__destroy(skel);
> -	free(buf);
> -	if (fp)
> -		fclose(fp);
>   }

[...]

>   ssize_t get_uprobe_offset(const void *addr)
>   {
>   	size_t start, end, base;
> @@ -413,3 +390,43 @@ int read_build_id(const char *path, char *build_id, size_t size)
>   	close(fd);
>   	return err;
>   }
> +
> +int read_trace_pipe_iter(void (*cb)(const char *str, void *data), void *data, int iter)
> +{
> +	size_t buflen, n;
> +	char *buf = NULL;
> +	FILE *fp = NULL;
> +
> +	if (access(TRACEFS_PIPE, F_OK) == 0)
> +		fp = fopen(TRACEFS_PIPE, "r");
> +	else
> +		fp = fopen(DEBUGFS_PIPE, "r");
> +	if (!fp)
> +		return -1;
> +
> +	 /* We do not want to wait forever when iter is specified. */
> +	if (iter)
> +		fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
> +
> +	while ((n = getline(&buf, &buflen, fp) >= 0) || errno == EAGAIN) {
> +		if (n > 0)
> +			cb(buf, data);
> +		if (iter && !(--iter))

"if (iter-- == 1)" should also work. But your code works too.

> +			break;
> +	}
> +
> +	free(buf);
> +	if (fp)
> +		fclose(fp);
> +	return 0;
> +}
> +
[...]

