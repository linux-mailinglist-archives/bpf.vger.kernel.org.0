Return-Path: <bpf+bounces-26571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4194C8A1E83
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F951F29281
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E98139D11;
	Thu, 11 Apr 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhpHPKnB"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837613958F
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859068; cv=none; b=JA7hZO+6QG3PRoDngmco5YDyFGBIbqlHFVLPew1HhkoT3n7te9xf2tOANBzC3d50z6P2TMyzck0a174YI5G5kBC9Wl88u1BwRpUvqYq5tYD+TxXNzQzkIr2gNP6+1OxlHZ9LLoMYyNdXSLMO6V68QaLYJeqmUQZPlPzUCAR/MOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859068; c=relaxed/simple;
	bh=Un1X4Awdlcl5O0s/Mp6g/huZu7KIX8C978fCTpZt848=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snKVYzVllqi/T/qzDCqZJPVXt7rPHrJ9Y/VGdaICJn+qykr+toKrMqUtEZin+6gVHo+ZKtkQ6boFoh6ifKUMmpT5gvas6YxcIw81K6u98b0gyxSzY6qOm3TmaDgiT5L3DxsLSXWP2Cw02TRHa4iY3p4MXpBEmD1s6Zy2MDjRMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhpHPKnB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712859062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuPsWMYO5T1HxiMlvFvVkgrqm02LlJEm/ffWXLbh23s=;
	b=NhpHPKnBVcMk+vGramEV7kXPCMJCKr20/SDHVRIHwP5acC3xOlcCrQYCubVb1f2V1mu6ck
	rtPx2B0v3l+9QPn4K2UYfc+N0a5sx3mOzZ/1kOo17NZiIow1ZWwSklGbS5/okvoiEzrH2k
	dEUkj+JGaQOlpRfNdUectpu4Ajq8+JQ=
Date: Thu, 11 Apr 2024 11:10:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
 <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/24 10:18 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
> 
> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> some subtests of test_sockmap fail.
> 
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 024a0faafb3b..4feed253fca2 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   		struct timeval timeout;
>   		fd_set w;
>   
> -		fcntl(fd, fd_flags);
> +		if (fcntl(fd, F_SETFL, fd_flags))
> +			goto out_errno;
> +
>   		/* Account for pop bytes noting each iteration of apply will
>   		 * call msg_pop_data helper so we need to account for this
>   		 * by calculating the number of apply iterations. Note user
> @@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   					perror("recv failed()");
>   					goto out_errno;
>   				}
> +				continue;

 From looking at it again, there is a select() earlier, so it should not hit 
EWOULDBLOCK.

Patch 2 looks good. Only patch 2 is applied. Thanks.

>   			}
>   
>   			s->bytes_recvd += recv;


