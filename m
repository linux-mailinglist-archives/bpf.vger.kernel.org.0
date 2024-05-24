Return-Path: <bpf+bounces-30508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C38CE89B
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55D11C20E04
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6217112EBE1;
	Fri, 24 May 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M9t0BuYi"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5912E1FE
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567853; cv=none; b=apfpGcVsZrojG2iEWFjts008M3jtB2LaS0e2xck66NFyy1T92j6iOxYWlbZ4h+Q91pNi+gWx+OLy0aRPRZuMDECMKYpatTuxREFxFPYsYLpl/Jb0qmrZOUI1jSqmc5uM1OZi/wJ2Lz3ky16Im5SAYrA1yaj2XMVkdPPYLYgKRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567853; c=relaxed/simple;
	bh=TyGA7aM492lwlJYubcwxLFpjajXM+DDLCFMHxU8W2yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZe4Oo1BB2OknLHQeTipFRE6BOnd6rW6tiN3TETeZxySxS6PtV5g6BsDCEZzhVhJd5SRJk4H375E4pHt63vBcSXoigeINn84JCfey1jW7JTsk+QGyEZSidXsRG7tD5DHbEm0WJp/zBfsndLrYC/R2gtbpoCSHN4JD9czTSNCxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M9t0BuYi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716567846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0D8vsxOHJyU/xelzOnJBFSCN9LD7iP5KtQ1Pa/+CIXA=;
	b=M9t0BuYiS6D3URd/AAxNAg/rDepcWVo8bPp7DO1yvp/8X0ykDBtGLrJ9LL9pt4nqviAR0J
	Gtp3l5eqQWH1KMdyi3IgbcxWVPnq+SgiolallbJJ7A5wJ9g8jJoWCeRjDMfhzjWwuZO7JH
	+klDKi1fqMyKYIk514ZIagJJ+mGelR8=
X-Envelope-To: vadfed@meta.com
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <4ed19773-2a26-4652-bd62-0fc0e5c1233e@linux.dev>
Date: Fri, 24 May 2024 17:23:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests: bpf: validate
 CHECKSUM_COMPLETE option
To: Daniel Borkmann <daniel@iogearbox.net>, Vadim Fedorenko
 <vadfed@meta.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240524110659.3612077-1-vadfed@meta.com>
 <20240524110659.3612077-2-vadfed@meta.com>
 <08fda54a-f45e-7140-e5e8-fe2c3542547f@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <08fda54a-f45e-7140-e5e8-fe2c3542547f@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/05/2024 17:18, Daniel Borkmann wrote:
> On 5/24/24 1:06 PM, Vadim Fedorenko wrote:
>> Adjust skb program test to run with checksum validation.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> BPF CI complains :
> 
>    [...]
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/test_skb_pkt_end.c:14:12: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       14 |                 .flags = BPF_F_TEST_SKB_CHECKSUM_COMPLETE,
>          |                          ^
>    /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:1429:42: note: 
> expanded from macro 'BPF_F_TEST_SKB_CHECKSUM_COMPLETE'
>     1429 | #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE        BIT(2)
>          |                                                 ^
>    1 error generated.
>    make: *** [Makefile:654: 
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_skb_pkt_end.test.o] 
> Error 1
>    make: *** Waiting for unfinished jobs....
>    make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
>    Error: Process completed with exit code 2.

Oops, looks like checkpatch.pl was too smart and replaced original
define with BIT() macro, but in one file only. I'll re-send it with
fixes.

