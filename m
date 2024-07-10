Return-Path: <bpf+bounces-34454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DA92D8F2
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18EB1F2127D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D2197A8B;
	Wed, 10 Jul 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DszdcQQk"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD8195FE0
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639211; cv=none; b=iLjJW0ER0UJNEpm4driIcciouX0I57PmGtuZnC4VvtMzunNYZDzuX0DGiy4IJPY/tjFY95jbke4tCHU6r83xvQhq+hllQkzWA5sigdZ6n6cdvZmyXsYehD4hCQ+7kaMgXSNfOmgFB2rngbkel9nGvf+AjJylABThHBSCfLHXYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639211; c=relaxed/simple;
	bh=BfanisFktnx85mYrXJZ8YFLEdSXcmltzUt9njfEYULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fq8mfH4DbsKyAonQONsvDIaNxGGeX8UKlcpgnhQiYWxyJiMMr4nMUXPn4/ieIIosGv3SCg5fdr+9PBTOnRcCWKjXJN2Ywiqqn3w2XeP0xOryY9JuojTx2DfkaaqOXSqfToxcMwiN4tqYcoPojR5vTtAYdSbl92iltFt/82+XAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DszdcQQk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720639208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLJ5ATAqz/y4Ra7yzYieViCehNhy4FtQIvxsS01J7VU=;
	b=DszdcQQk7MZN6uQYIR2MtMHdo52dvqT53alAnaWIdmNE2osoTtp3vDwED2shSi6lLJeR3s
	31tXQmd1OCBDyEwkiFDtqRb3e3j2shEnEDB4T+ZHTX2/ZDvEEDQRM+mcu9T6QJ3ZI3vb+5
	yTqq42W+7UbCm8BKfzYS9U9QfkNSdjI=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: sdf@fomichev.me
Message-ID: <9d3251b3-af0d-40f8-ba92-2b676799da55@linux.dev>
Date: Wed, 10 Jul 2024 12:20:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 7/9] selftests/bpf: Add
 connect_fd_to_addr_str helper
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
 <96f04aa5677d628ad5eae1981565b24bf94c9d77.1720515893.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <96f04aa5677d628ad5eae1981565b24bf94c9d77.1720515893.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/24 2:16 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to connect_fd_to_fd() helper to connect from a client fd to a
> server fd, this patch adds a new helper connect_fd_to_addr_str() to connect
> from a client fd to a server address. It accepts the server address string
> "addr_str", together with the server family, type and port, as parameters
> instead of using a "server_fd" like connect_fd_to_fd().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 21 +++++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  3 +++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index e0cba4178e41..9758e707b859 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -388,6 +388,27 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
>   	return 0;
>   }
>   
> +int connect_fd_to_addr_str(int client_fd, int family, int type,

Similar to the comment in the earlier revision on the existing 
connect_to_fd_opts. The "int type" is redundant of "int client_fd".

and where is the "int type" arg actually used in this new function?

Beside, is it more useful for patch 8 to add connect_to_addr_str() which calls 
socket()/client_socket(), connect(), and then return the client_fd instead?

Something like this?

int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
			const struct network_helper_opts *opts)

Patch 1-6 is applied with the mentioned minor changes. Thanks.


> +			   const char *addr_str, __u16 port,
> +			   const struct network_helper_opts *opts)
> +{
> +	struct sockaddr_storage addr;
> +	socklen_t len;
> +
> +	if (!opts)
> +		opts = &default_opts;
> +
> +	if (settimeo(client_fd, opts->timeout_ms))
> +		return -1;
> +
> +	if (make_sockaddr(family, addr_str, port, &addr, &len)) {
> +		log_err("Failed to make server addr");
> +		return -1;
> +	}
> +
> +	return connect_fd_to_addr(client_fd, &addr, len, false);
> +}
> +
>   int make_sockaddr(int family, const char *addr_str, __u16 port,
>   		  struct sockaddr_storage *addr, socklen_t *len)
>   {


