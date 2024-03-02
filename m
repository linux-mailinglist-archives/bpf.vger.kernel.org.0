Return-Path: <bpf+bounces-23253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BA86F1CE
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD68AB22932
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF422C86A;
	Sat,  2 Mar 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p9Ssb6+q"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514E72BB12
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402964; cv=none; b=eTFYowgC4Wm5WI7NTKt+XFZqKG6WoCJXtD1AinII1CSJ2hJ09mZBHFikyjBztesyDk1JBevUcqpQqzkMwRWhLx4DBo2jydga8yE4tXWC5UIFavcAwxroRsJjaM9lYJKkHK6ch4/+/Z0wqMZnCHEKhRnbVgDYPE7Mee/9JOZjwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402964; c=relaxed/simple;
	bh=FU/QoHhtyAxcZ4mjSjKgf0gjq7NkU2ZbECBmB3zef5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpYq+18KBmz4g5qbyX4ICniQ1QImm+O014CgnWd36qM1AqfKXIP0ZAIqtjnMCESzpABLxL0NUxTNk8cu51AMsdpZYPUwExk7mLXB3bnap2/kv4cTjvpbW6DOFUM5KdgNYHg2ZnegFT1woK/kvYwrQpi2k3ToLU86SPC7wvZf288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p9Ssb6+q; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef878388-ecef-45ff-a33a-d7b2e18d5220@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709402960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgPk+rTxpwWNQqzbhXb+NEtPGoKxdfgxofmyHTrXzyo=;
	b=p9Ssb6+q75aDDRXy/EedCObSwLFirqYarxxnaXMkGnv+UYPAuaFmxAizFSvnsOPhHPH2Q9
	3kgMaIKSZBZiSUP7inPqcNWIf5dA0Z+AQ6bJFk5NiKngw2focF1iCH6rMJhaDyY6A2XOis
	EgGtHPhjhPfIfG1nvZBJm36yGMkeSck=
Date: Sat, 2 Mar 2024 10:09:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linux-next:master 5519/11156]
 kernel/bpf/bpf_struct_ops.c:247:16: warning: bitwise operation between
 different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type')
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <sinquersw@gmail.com>
Cc: Thinker Li <thinker.li@gmail.com>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
References: <202403010423.0vNdUDBW-lkp@intel.com>
 <CAFVMQ6QYvHfc_=cpOddWgoWDTRt3GHG5+LLB3NoFFRRiCMWDLw@mail.gmail.com>
 <73e0fa99-7dff-4cb9-bfed-fd3368e54542@gmail.com>
 <CAADnVQJUZZXusOS3h9fnUUoFQ7=o5iJDDANaUqNBheuhHrUXeg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJUZZXusOS3h9fnUUoFQ7=o5iJDDANaUqNBheuhHrUXeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/1/24 10:27 AM, Alexei Starovoitov wrote:
> On Fri, Mar 1, 2024 at 10:26 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>> For BPF,
>>
>> We have a lot of code mixing bpf_type_flag and bpf_reg_type in bpf.
>> They cause the warning messages described in the message following.
>> Do we want to fix them all, or keep them as they are?
>>
>> They can be fixed by merging two enum types or casting here and there if
>> we want. Any other idea?
> We probably should add -Wno-enum-enum-conversion to kernel/bpf/Makefile instead.

The warnings are only triggered with latest llvm19 development branch.
The warnings are triggered in many subsystems, bpf, mm, etc.
The following commandline can workaround the issue:
    make LLVM=1 -j KCFLAGS=-Wno-enum-enum-conversion
There is a discussion how to fix it here:
   https://github.com/ClangBuiltLinux/linux/issues/2002
No conclusion yet.


