Return-Path: <bpf+bounces-5852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1A7620B5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A156281853
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD825932;
	Tue, 25 Jul 2023 17:57:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB925905
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 17:57:56 +0000 (UTC)
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 10:57:54 PDT
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7937C10F7
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 10:57:54 -0700 (PDT)
Message-ID: <87fa06c9-d8a9-fda4-d069-6812605aa10b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690307790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHcSrzVLuqg7vsezDCAcR+Ts57qI809p7b33W2KdD0w=;
	b=whGT7e5egGQVoPWhvX97cwbVVw3dUoUz9IAVmNp7vYZqlB+Qk/L3M6BbtJSM+iNCmYDXgK
	jKslWJg5b1CpTf7FDTiy7k4Hy4bYDt2Re8klOcz0zUt9+2NcBzW8FJE+zR7yw7KCaf2/tn
	hhr3zdTjr6IvqR+0PIGG8BC9rKzDqEY=
Date: Tue, 25 Jul 2023 10:56:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, Breno Leitao <leitao@debian.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 leit@meta.com, bpf@vger.kernel.org, ast@kernel.org
References: <20230724142237.358769-1-leitao@debian.org>
 <20230724142237.358769-3-leitao@debian.org> <ZL61cIrQuo92Xzbu@google.com>
 <ZL+VfRiJQqrrLe/9@gmail.com> <ZMAAMKTaKSIKi1RW@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZMAAMKTaKSIKi1RW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/23 10:02 AM, Stanislav Fomichev wrote:
> On 07/25, Breno Leitao wrote:
>> On Mon, Jul 24, 2023 at 10:31:28AM -0700, Stanislav Fomichev wrote:
>>> On 07/24, Breno Leitao wrote:
>>>> Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
>>>> level is SOL_SOCKET. This is leveraging the sockptr_t infrastructure,
>>>> where a sockptr_t is either userspace or kernel space, and handled as
>>>> such.
>>>>
>>>> Function io_uring_cmd_getsockopt() is inspired by __sys_getsockopt().
>>>
>>> We probably need to also have bpf bits in the new
>>> io_uring_cmd_getsockopt?

I also think this inconsistency behavior should be avoided.

>>
>> It might be interesting to have the BPF hook for this function as
>> well, but I would like to do it in a following patch, so, I can
>> experiment with it better, if that is OK.
> 
> We are not using io_uring, so fine with me. However, having a way to bypass
> get/setsockopt bpf might be problematic for some other heavy io_uring
> users.
> 
> Lemme CC a bunch of Meta folks explicitly. I'm not sure what that state
> of bpf support in io_uring.

We have use cases on the "cgroup/{g,s}etsockopt". It will be a surprise when the 
user moves from the syscall {g,s}etsockopt to SOCKET_URING_OP_*SOCKOPT and 
figured that the bpf handling is skipped.


