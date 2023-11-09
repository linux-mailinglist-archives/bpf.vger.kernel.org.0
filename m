Return-Path: <bpf+bounces-14546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7147E6277
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 03:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5255B20EA5
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 02:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FBD539D;
	Thu,  9 Nov 2023 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gYkPpvsm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B84C8F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 02:58:31 +0000 (UTC)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584A2590
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 18:58:30 -0800 (PST)
Message-ID: <ec34f1d5-2b57-4f0f-9edd-070bb98a2b6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699498708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XGpJflvS4VE8yMlQyZQk5A2Se1pOKneOEM3xI4Q4P4=;
	b=gYkPpvsmQmYX4+eA2V/Sjsmg5U0ZNqacrfVnjl+wXhl0JwbV6dSJnh1+FoAOhtDA4KLKgA
	pf3n7FhFr+TygW/QzmAq34DFDiLTRLf+X6DOw7309wXe47wh6Q52Ni5Zfv6eTHCCpKfnBp
	Akm4iRBkznyIJXbx3d5GgrNuamb7KI0=
Date: Wed, 8 Nov 2023 18:58:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf selftest pyperf180.c compilation failure with latest last
 llvm18 (in development)
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
References: <3e3a8a30-dde0-43a1-981e-2274962780ef@linux.dev>
 <ba9076bfb983ef96ca78d584ca751b1fef3a06b9.camel@gmail.com>
 <CAADnVQKvKbLi0rfhEr5jWwaR=wQJZFfassuWa2=w4H56CToeUg@mail.gmail.com>
 <98d0330ecb6b3b1a366de5395dbef7ab7758288a.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <98d0330ecb6b3b1a366de5395dbef7ab7758288a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/8/23 5:20 PM, Eduard Zingerman wrote:
> On Wed, 2023-11-08 at 12:05 -0800, Alexei Starovoitov wrote:
> [...]
>> The algorithm doesn't look simple.
>> Even if we change llvm to do this, it's not clear whether
>> the verifier will be able to consume such code.
> Actually, I don't think that trampoline jumps could cause any trouble.
>
>> imo it's too much effort to address a non-issue.
>> I'd just adjust the pyperf180.c test.
> Ok, I'll drop this. Thank you for taking a look.

Thanks Eduard for doing analysis for this! I will send
a patch soon to fix selftest failure issue.


