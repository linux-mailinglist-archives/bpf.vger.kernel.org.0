Return-Path: <bpf+bounces-26227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71B89CEEC
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 01:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55A3287946
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B83143890;
	Mon,  8 Apr 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFiNjI2o"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF0376E4
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618700; cv=none; b=Ghf+YhR0axcguPF/97uyOudH+k9l+r+MQHModvyRqYpN3wMRSkKoGG3oDNhtthFFDAicB9sUvOruKbeYxpW43lxDDndcFpoID8GeCLBGpi5pdLdpjCadwJpIxAXQwq1GE9K9x4sSOqdXziS6RlBjRiCS2frQIn9prCgD/0Wl1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618700; c=relaxed/simple;
	bh=m02HYx5NzLzzr/70S4Rpa2JYMlZBWYYZDwmc9MM6Lxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZ5lLlhiBV0xpXGXHt9Q/4eOPBPtUxgCquY+0RNVkDTedPtPfjEEhSijvxb++t4G/8zQdhSFxMlHoOBq3MK74Ter/XBfrlu64SC1YZgmcyNZitGVC1lGz0Y9gZWMrGGBx/QFcf7ie+qLgZuUKdcxRwYcTcSdo1g4ThiT+FCzWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFiNjI2o; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <192149e0-34cb-43aa-9eea-cd4caa03d284@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712618696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXC8i1bm/63/ZN7AuDuGJcSpUov56WF1xe5Ir/5ysX0=;
	b=iFiNjI2oIp8TlFA92RAUHMJfeMP8SNJ5TzEDeslGeJgLo+TeIR3Cu2C0+GmqRErHrICfDP
	YdqQ7MyabUAQuZQ7Yh0Qb8afs2gPYkhAZ01eCwI8+NUi+yTi7pVOSHMbJhg6rf5jT+cyjg
	ZAGlPbJrch1BvMI6G6Owr/x108+PxS8=
Date: Mon, 8 Apr 2024 16:24:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
 <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2f9f84be1366ca68b1123dd2f3fd06034e1bd3a4.1712539403.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/24 6:36 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
> 3rd one.
> 
> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
> some subtests of test_sockmap will fail.
> 
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 024a0faafb3b..4f32a5eb3864 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   		struct timeval timeout;
>   		fd_set w;
>   
> -		fcntl(fd, fd_flags);
> +		fcntl(fd, F_SETFL, fd_flags);

Should it just error out here if fcntl did fail (unlikely?) ...

>   		/* Account for pop bytes noting each iteration of apply will
>   		 * call msg_pop_data helper so we need to account for this
>   		 * by calculating the number of apply iterations. Note user
> @@ -678,6 +678,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>   					perror("recv failed()");
>   					goto out_errno;
>   				}
> +				fd_flags = fcntl(fd, F_GETFL);
> +				if (fd_flags & O_NONBLOCK)

... then no need to test fd_flags here?

pw-bot: cr

> +					continue;
>   			}
>   
>   			s->bytes_recvd += recv;


