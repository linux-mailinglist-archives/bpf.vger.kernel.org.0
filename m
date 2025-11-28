Return-Path: <bpf+bounces-75676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F911C90E6B
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 06:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14623A726C
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B64288C96;
	Fri, 28 Nov 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="grSjPLCW"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFF1FC8
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764309178; cv=none; b=Lh7wvn0ELC308g6wW19pRLCjwYsU/KR8bbxeQtXSKuF/LAbKxFClibFcXB5r8Ap4Gm1NWz1hySNiZTUJQl3LQW6Dm06eTXYNItzBvrtbh5vDvkWGZ9Yl0E5QqMTyTwxMrLtkQgiXAGZw7lwy8jkicZJx534CNguf42QgX+M6JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764309178; c=relaxed/simple;
	bh=RQVF1+JFrUDP7pWYGElPnvlQaxwGVSjjir5Air3+jxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvwK2vj8/h5ulNEdj6GCUTbJxaXCKFbaV7a82gRh1W2U6SeKUuI3ZZAWKtmucdBBu5uPWEbcftfR8/KdFV5Mw2j+n4ZpwpoeW6WyyJdkKHzemheGS+DlqhdHPr/0mBT6ZkSafI7IKaeVf1KEhOSGUlAcmN1nc5Z1oUoKZdrvnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=grSjPLCW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bba5017e-a590-480b-ae48-17ae45e44e48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764309173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeK+WWIuGM5Ij6R+DCWdy+dRvgTRhpUvIDcR9SzI3VY=;
	b=grSjPLCWd8k6WDkTLuZ+zD73d/pcfAdLPYtBp722Kn9FsBVX8KgjwXD5hVp2LTyzWmrl/V
	EulG/P7+YmdQCaNrTqJ5no/ZJm0FRXcY8TKw6KIufKzwmHPtzc//TM9sesBtOiZxLVWBei
	lF0U8uLWBw6MYC8bloWXqR3IQSissDw=
Date: Thu, 27 Nov 2025 21:52:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
 <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAErzpmvsgSDe-QcWH8SFFErL6y3p3zrqNri5-UHJ9iK2ChyiBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/27/25 7:20 PM, Donglin Peng wrote:
> On Fri, Nov 28, 2025 at 2:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index bac22265e7ff..ec7e2a7721c7 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>>  include ../../../scripts/Makefile.include
>>
>>  CXX ?= $(CROSS_COMPILE)g++
>> +OBJCOPY ?= $(CROSS_COMPILE)objcopy
>>
>>  CURDIR := $(abspath .)
>>  TOOLSDIR := $(abspath ../../..)
>> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                  \
>>         $$(call msg,BINARY,,$$@)
>>         $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
>>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>> +       $(Q)if [ -f $$@.btf_ids ]; then \
>> +               $(OBJCOPY) --update-section .BTF_ids=$$@.btf_ids $$@; \
> 
> I encountered a resolve_btfids self-test failure when enabling the
> BTF sorting feature, with the following error output:
> 
> All error logs:
> resolve_symbols:PASS:resolve 0 nsec
> test_resolve_btfids:PASS:id_check 0 nsec
> test_resolve_btfids:PASS:id_check 0 nsec
> test_resolve_btfids:FAIL:id_check wrong ID for T (7 != 5)
> #369     resolve_btfids:FAIL
> 
> The root cause is that prog_tests/resolve_btfids.c retrieves type IDs
> from btf_data.bpf.o and compares them against the IDs in test_progs.
> However, while the IDs in test_progs are sorted, those in btf_data.bpf.o
> remain in their original unsorted state, causing the validation to fail.
> 
> This presents two potential solutions:
> 1. Update the relevant .BTF.* section datas in btf_data.bpf.o, including
>     the .BTF and .BTF.ext sections
> 2. Modify prog_tests/resolve_btfids.c to retrieve IDs from test_progs.btf
>     instead. However, I discovered that test_progs.btf is deleted in the
>     subsequent code section.
> 
> What do you think of it?

Within resolve_btfids it's clear that we have to update (sort in this
case) BTF first, and then resolve the ids based on the changed BTF.

As for the test, we should probably change it to become closer to an
actual resolve_btfids use-case. Maybe even replace or remove it.

resolve_btfids operates on BTF generated by pahole for
kernel/module. And the .BTF_ids section makes sense only in kernel
space AFAIU (might be wrong, let me know if I am).

And in this test we are using BTF produced by LLVM for a BPF program,
and then create a .BTF_ids section in a user-space app (test_progs /
resolve_btfids.test.o), although using proper kernel macros.

By the way, the test was written more than 5y ago [1], so it might be
outdated too.

I think the behavior that we care about is already indirectly tested
by bpf_testmod module tests, with custom BPF kfuncs and BTF_ID_*
declarations etc. If resolve_btfids is broken, those tests will fail.

But it's also reasonable to have some tests targeting resolve_btfids
app itself, of course. This one doesn't fit though IMO.

I'll try to think of something.

[1] https://lore.kernel.org/bpf/20200703095111.3268961-10-jolsa@kernel.org/


> 
> Thanks,
> Donglin
> 
>> +       fi
>> +       $(Q)rm -f $$@.btf_ids $$@.btf
>>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>>                    $(OUTPUT)/$(if $2,$2/)bpftool
>>
>> --
>> 2.52.0
>>


