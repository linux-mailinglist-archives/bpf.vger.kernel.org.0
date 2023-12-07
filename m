Return-Path: <bpf+bounces-16991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B64808153
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 08:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84041C20D54
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6614291;
	Thu,  7 Dec 2023 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3BnKA7H"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB7128;
	Wed,  6 Dec 2023 23:04:01 -0800 (PST)
Message-ID: <8b173550-c077-4506-ba7d-51d1a51344b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701932639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=od2iBZ+DhosKBwmyqP6nyM1tm8diqGtlq9CWOlRdPRg=;
	b=q3BnKA7HBUpa+L67WxI0hukeTxFT74uBMq5lYa9bbsjMxjoCIGnZb6O/cT5bkDMTZ2GdIt
	DDIco1FPNu8W6uq+eBnQo9dqUqs0POdaQxrBo6q29WDeeNmXop9kytQFIvYGhsxKvhxZFb
	I+7vj2Mjd8nRmBOGbmcQoM6XAPsWZcU=
Date: Wed, 6 Dec 2023 23:03:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v1] test_bpf: Rename second ALU64_SMOD_X
 to ALU64_SMOD_K
Content-Language: en-GB
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231207040851.19730-1-yangtiezhu@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207040851.19730-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/6/23 11:08 PM, Tiezhu Yang wrote:
> Currently, there are two test cases with same name
> "ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
> the second one should be ALU64_SMOD_K because its
> code is BPF_ALU64 | BPF_MOD | BPF_K.
>
> Before:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
>
> After:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_K: -7 % 2 = -1 jited:1 4 PASS
>
> Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>



