Return-Path: <bpf+bounces-34445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E892D8A7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051691F2494B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151D19645C;
	Wed, 10 Jul 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dz8MlVv3"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFD10A09
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638015; cv=none; b=YMSyZf9ptybGYw9O46TsnIrKJDwHyJyWyohozyChTpdBOUv9V2hZZ+8VYPC0PwIWcW/8uO/oHFMVJ4Oc2zq87lwMNVPVkTNEFPPBEWkXB1hbwkEVyf4jYcy+QXhSya+QgUPBRyT9UzB9G6VIGFtFO/gyqOx30dh0fz+0q/BOfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638015; c=relaxed/simple;
	bh=p+ZkMcqKWbzkh9thPGaFNC8WavSCVQ3ab9T+H8HfwNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuLlp+ezy41VvbWKb2IrbzvB2mvgFc0EMA3cZUeKcjesEgmfZ9o799vTFGCtQ7dOQ87o+ILjRd4ynzQf3q/SUSBh/ZrP7BQgIxcpTsThiRiXCO1T6NIeirP0LP1NDLcNnmBuxyI4Nk57tLD64yupG8Oi5F17Mpkc0qLdaXHsEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dz8MlVv3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720638010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmskPw26zRkr4mOkmnTBZRznoZHa4/dEE3tbclocXx8=;
	b=dz8MlVv3PChUs0Xj2nGCPQ1qxexBHLEDdoBsiQvdP/wjGGZ5ass9UhFj6gKwIZacsC9BOa
	kCC1t2F/nMKeQcHfA3+sYBE/wNZHsj0br7zt6KjMl/tcadaVpl5SmhOb1WtGqN1jmPN1OR
	7ndcdvDSIZJ6n8YEGZ9eB/dSIy8YqVU=
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
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: sdf@fomichev.me
Message-ID: <905c79ee-bad1-491d-b10b-12fa97ac00d7@linux.dev>
Date: Wed, 10 Jul 2024 12:00:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/9] selftests/bpf: Add ASSERT_OK_FD macro
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
 <ded75be86ac630a3a5099739431854c1ec33f0ea.1720515893.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ded75be86ac630a3a5099739431854c1ec33f0ea.1720515893.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/24 2:16 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a new dedicated ASSERT macro ASSERT_OK_FD to test whether a socket
> FD is valid or not. It can be used to replace macros ASSERT_GT(fd, 0, ""),
> ASSERT_NEQ(fd, -1, "") or statements (fd < 0), (fd != -1).
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/test_progs.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 0ba5a20b19ba..4f7b91c25b1e 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -377,6 +377,14 @@ int test__join_cgroup(const char *path);
>   	___ok;								\
>   })
>   
> +#define ASSERT_OK_FD(fd, name) ({					\
> +	static int duration = 0;					\
> +	int ___fd = (fd);						\
> +	bool ___ok = ___fd >= 0;					\
> +	CHECK(!___ok, (name), "unexpected fd: %d\n", ___fd);		\

printing errno should be useful.

> +	___ok;								\
> +})
> +
>   #define SYS(goto_label, fmt, ...)					\
>   	({								\
>   		char cmd[1024];						\


