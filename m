Return-Path: <bpf+bounces-6158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C2766369
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A491C217A4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330085244;
	Fri, 28 Jul 2023 04:49:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFB23AE
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 04:49:50 +0000 (UTC)
Received: from out-120.mta1.migadu.com (out-120.mta1.migadu.com [IPv6:2001:41d0:203:375::78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6211F3AB7
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:49:49 -0700 (PDT)
Message-ID: <940426b4-4b1f-b006-c7a9-d64a650b27e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690519786; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTkI/7q8Lo8zuYoY7t73auHwbzs10OTQq453iqKTCWQ=;
	b=iNe09zY5I77cWWsavYa26xMFFE8MXPBgDt/WQUrqg3zN0lEKBdp7ap3GZX8zCUNwYmL7wk
	sBJDvQanh1zk2eUfBU6pCqZaM9Ll/b+WfvUSy8Ju/xjdz2x0aVcqkSvNjX0KDa7jAa0zEJ
	EeyP1NUyNhlHBXfbh4Gzsoev9GvYooQ=
Date: Thu, 27 Jul 2023 21:49:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5 10/17] selftests/bpf: Add a cpuv4 test runner
 for cpu=v4 testing
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011250.3718252-1-yonghong.song@linux.dev>
 <CAADnVQLUejc9+ZbS04a336vhww+HYok7U2Uuc=Gjuxb7sa=UhA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLUejc9+ZbS04a336vhww+HYok7U2Uuc=Gjuxb7sa=UhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 7:18 PM, Alexei Starovoitov wrote:
> On Thu, Jul 27, 2023 at 6:13 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> -# Silence some warnings when compiled with clang
>>   ifneq ($(LLVM),)
>> +# Silence some warnings when compiled with clang
>>   CFLAGS += -Wno-unused-command-line-argument
>> +# Check whether cpu=v4 is supported or not by clang
>> +ifneq ($(shell $(CLANG) --target=bpf -mcpu=help 2>&1 | grep 'v4'),)
>> +CLANG_CPUV4 := 1
>> +endif
>>   endif
> 
> Gating cpu=v4 testing by LLVM=1 is unnecessary.
> The kernel can be built by GCC, but we should still build
> test_progs-cpuv4 when clang supports it.
> 
> Please consider a follow up.

Agree. Will do a follow-up for cpu-v4 not depending on LLVM=1.

> 
> I've applied the set, since the rest looks great!

