Return-Path: <bpf+bounces-12738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5987D02FB
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E0E1C20F20
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8F3DFF6;
	Thu, 19 Oct 2023 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hVJSsOgi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC553DFE8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 20:04:49 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282F131
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so24772a91.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697745886; x=1698350686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHSM7lgOK3HTJKxso8W1sPPHXik4YHTdjZ5i3zqRGx4=;
        b=hVJSsOgikFx2v0hDLza9QGjIV8a6tJluJcV/pZEW9BAreZr3dBUcXEAy3rnQt/sGQi
         0db2gX+WccmzYGJP+aj0NWsgRvZgSHh3hSjVXaxZ4z3j0vyCV6pKpauW4vI1WDQGPNjQ
         lipLElDOc/SIyqkGCcFk/oO/tH/RRPL8/o7wGzlbdWg4wwH4m6yDS0ou6RP/wSULDDcw
         XDMn+1NvPWDlI5XfEQQfNccI/IjYR0cqhSrw3m97oQcbeUcUDNIfkHrz8KQtFMnrG/7z
         KYudnlhakY/Ikm8706uLWES7qUFJpX5tkeYrfj528xnocTyIrwTyb2tcOTTs9LuRMV45
         H7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745886; x=1698350686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHSM7lgOK3HTJKxso8W1sPPHXik4YHTdjZ5i3zqRGx4=;
        b=SlIdpt+0vX96cp6bBWnQM4ncCpEBwCU39fnflvl7BlIjUgfgOdGFfCMsV2pFzh23aD
         dtkOw3tPV0HDVcc9Y4LVJaWD5EmMhLELNXep/ZyMfDkTO7J5K8fB5CycJXMD3V6O4fKt
         B8kX+6zDtqrR7eitZCBEHhnkHVoxY1ttBzHeCfdIzZor2NXgoVZf1Go6IIHoMCfMfApm
         w5SW0EMNzxM9GHL2uEGc238IBnBZMrdlL81HENyxMxttjROCgHQ9mZOk9VkZ+NXu5XMS
         1CUYjAnsIXS0uiPtkmWJtQQLJNndJl0BrGwNUCEbKM2wYXuCQkVsayNce7U6GY/HTl62
         YO/A==
X-Gm-Message-State: AOJu0YxXV5aWSeqykseOJzszNAaTo5iL3a5H4LcwVfbJz9GPUqA3T0pw
	fAK8yHj7DYclyA7E03RuZT7lbx8qVb5TTKtzTCG+5g==
X-Google-Smtp-Source: AGHT+IGbCrBvmsRbosyDyHhFgwB9uD9EKZDkSeQTftL9H2qEaLZcX5FXO2SKmc7h7coRIOruRtobPQ==
X-Received: by 2002:a17:90b:1d0e:b0:274:99ed:a80c with SMTP id on14-20020a17090b1d0e00b0027499eda80cmr3295469pjb.3.1697745886045;
        Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jb14-20020a17090b408e00b002774d7e2fefsm157717pjb.36.2023.10.19.13.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 13:04:45 -0700 (PDT)
Message-ID: <e1920ac4-18ad-4b97-a3a3-9604724937d6@kernel.dk>
Date: Thu, 19 Oct 2023 14:04:43 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] net/socket: Break down __sys_getsockopt
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 krisman@suse.de, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-5-leitao@debian.org>
 <1074c1f1-e676-fbe6-04bc-783821d746a1@linux.dev>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1074c1f1-e676-fbe6-04bc-783821d746a1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/23 1:12 PM, Martin KaFai Lau wrote:
> On 10/16/23 6:47?AM, Breno Leitao wrote:
>> diff --git a/net/socket.c b/net/socket.c
>> index 0087f8c071e7..f4c156a1987e 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -2350,6 +2350,42 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
>>   INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>>                                int optname));
>>   +int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>> +               int optname, sockptr_t optval, sockptr_t optlen)
>> +{
>> +    int max_optlen __maybe_unused;
>> +    const struct proto_ops *ops;
>> +    int err;
>> +
>> +    err = security_socket_getsockopt(sock, level, optname);
>> +    if (err)
>> +        return err;
>> +
>> +    ops = READ_ONCE(sock->ops);
>> +    if (level == SOL_SOCKET) {
>> +        err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
>> +    } else if (unlikely(!ops->getsockopt)) {
>> +        err = -EOPNOTSUPP;
>> +    } else {
>> +        if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
>> +                  "Invalid argument type"))
>> +            return -EOPNOTSUPP;
>> +
>> +        err = ops->getsockopt(sock, level, optname, optval.user,
>> +                      optlen.user);
>> +    }
>> +
>> +    if (!compat) {
>> +        max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> 
> The max_optlen was done before the above sk_getsockopt. The bpf CI cannot catch it because it cannot apply patch 5 cleanly. I ran the following out of the linux-block tree:
> 
> $> ./test_progs -t sockopt_sk
> test_sockopt_sk:PASS:join_cgroup /sockopt_sk 0 nsec
> run_test:PASS:skel_load 0 nsec
> run_test:PASS:setsockopt_link 0 nsec
> run_test:PASS:getsockopt_link 0 nsec
> (/data/users/kafai/fb-kernel/linux/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c:111: errno: Operation not permitted) Failed to call getsockopt, ret=-1
> run_test:FAIL:getsetsockopt unexpected error: -1 (errno 1)
> #217     sockopt_sk:FAIL

Does it work with this incremental? I can fold that in, will rebase
anyway to collect acks.


diff --git a/net/socket.c b/net/socket.c
index bccd257e13fe..eb6960958026 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2344,6 +2344,9 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (err)
 		return err;
 
+	if (!compat)
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
 		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
@@ -2358,12 +2361,10 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 				      optlen.user);
 	}
 
-	if (!compat) {
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	if (!compat)
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
-	}
 
 	return err;
 }

-- 
Jens Axboe


