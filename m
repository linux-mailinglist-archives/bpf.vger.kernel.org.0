Return-Path: <bpf+bounces-19075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3412824AFA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA591F23550
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B52C878;
	Thu,  4 Jan 2024 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DwNklJpg"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2F2C864
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0593c0e-5dfb-4bc8-a8dd-fbe570fe80a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704407924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkMtO7OMGDyg6R+09zztV2BVqicry/aYqL1e7xDWm5M=;
	b=DwNklJpgVLb683Mtt6WklAiXzFklJjmyJEy/q+Qlx7upKWQsx+a58ljH3pGQgW/eOUxxHM
	qFNCcguN3Eg+o6KHwej/osmNDFNgvr+OzQ/f3XRNVCUxYH8ejov8GneamF4k1fqe1r3ICE
	uWO07P/otTwg6CrPfxMKFgjy3A+MjnA=
Date: Thu, 4 Jan 2024 14:38:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Double the size of test_loader log
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20240102193531.3169422-1-iii@linux.ibm.com>
 <20240102193531.3169422-3-iii@linux.ibm.com>
 <6f05eb0d-4807-4eef-99ba-2bfa9bd334af@linux.dev>
 <958781f9b02cb1d5ef82a0d78d65ecdbb3f26893.camel@linux.ibm.com>
 <3ac01843-9dbf-4c5b-a1ac-9acda8c47f19@linux.dev>
 <CAADnVQ+Y1MXe1WJg+Uv3to9jytL-6_qCdxgFsiB6rdzmwSf_MQ@mail.gmail.com>
 <CAADnVQK-zVo44z1ygPstbParCMB2tSXz=epgooktzLWPW+FkoQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQK-zVo44z1ygPstbParCMB2tSXz=epgooktzLWPW+FkoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/4/24 2:33 PM, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 1:19 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, Jan 3, 2024 at 10:15 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>
>>> Okay, thanks for the explanation. I applied the patch set to
>>> my local env and indeed, with this patch, I can see libbpf returns
>>> an error.
>> How did you repro this?
>> I've tried reverting this patch, but the test in patch 3 still passes
>> for me without errors.
> Took me a long time... I was able to repro with:
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> index 05a329ee45ee..66bdb940a40b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> @@ -36,6 +36,7 @@ l3_%=:
>           \
>   SEC("socket")
>   __description("gotol, large_imm")
>   __success __failure_unpriv __retval(40000)
> +__log_level(1)
>   __naked void gotol_large_imm(void)
>
> and then I finally realized that this patch is fixing
> the case when test_progs runs with -v. Like:
> ./test_progs -t gotol -v

Sorry for replying later. Just taking a nap...
I reproduced the issue when I tried to find out
why unpriv failed with cpuv4 as I cannot remember why.
IIRC, I am using is
   ./test_progs-cpuv4 -v -t gotol

>
> I wish you mentioned this in the commit log.
> Would have saved me a ton of time.

