Return-Path: <bpf+bounces-12737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0037D02CA
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040E928113A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0473D3B5;
	Thu, 19 Oct 2023 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CqTNJDoo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D53D391
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:51:13 +0000 (UTC)
Received: from out-190.mta1.migadu.com (out-190.mta1.migadu.com [IPv6:2001:41d0:203:375::be])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0CCCA
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:51:11 -0700 (PDT)
Message-ID: <16e8546f-9da6-8bac-ad9e-5d38918d0783@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697745069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2J4Oasusyhp2LFkadlAimpdKLPnFnJeRghNdrohws88=;
	b=CqTNJDoo/g34rriKps/fD8ErECUtOj6Xrq/jQDMyhCrYa72Hpi8zKa3WL4MScM4/G9Y1Sj
	HF4kGzlskoVdmhUkgBBWm2kfHDLtdouadrDyGZfB7GdQ0DH+GGDQpCkGlMCFtJnLUh38+I
	onKyOcWJRp2MHnxp2VPK/5+082OseQo=
Date: Thu, 19 Oct 2023 12:51:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 11/11] selftests/bpf/sockopt: Add io_uring support
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org,
 =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 krisman@suse.de, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-12-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231016134750.1381153-12-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/23 6:47 AM, Breno Leitao wrote:
> Expand the sockopt test to use also check for io_uring {g,s}etsockopt
> commands operations.
> 
> This patch starts by marking each test if they support io_uring support
> or not.
> 
> Right now, io_uring cmd getsockopt() has a limitation of only
> accepting level == SOL_SOCKET, otherwise it returns -EOPNOTSUPP. Since
> there aren't any test exercising getsockopt(level == SOL_SOCKET), this
> patch changes two tests to use level == SOL_SOCKET, they are
> "getsockopt: support smaller ctx->optlen" and "getsockopt: read
> ctx->optlen".
> There is no limitation for the setsockopt() part.
> 
> Later, each test runs using regular {g,s}etsockopt systemcalls, and, if
> liburing is supported, execute the same test (again), but calling
> liburing {g,s}setsockopt commands.
> 
> This patch also changes the level of two tests to use SOL_SOCKET for the
> following two tests. This is going to help to exercise the io_uring
> subsystem:
>   * getsockopt: read ctx->optlen
>   * getsockopt: support smaller ctx->optlen

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


