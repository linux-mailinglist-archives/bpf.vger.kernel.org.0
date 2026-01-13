Return-Path: <bpf+bounces-78695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC95D18960
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F8E830031BD
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5838E12A;
	Tue, 13 Jan 2026 11:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78938BF7D
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305203; cv=none; b=NX59fDlP/qi++UASSxgI72o4Yxhr2q4L+GRSibBiJucWx5t5la1GuvtpMXM+t5hImjiytUNEN1ETFMORoLNwCAeNg6eUBYrNpEIQYWfOdDDj0TjlpqKuSbKP7vYLW60yo6/heioNOXZxxeaZvJi3xTRj4goZrQjn1VmGBn8Z6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305203; c=relaxed/simple;
	bh=r94U2BljHIQ/CbHj0gKFJ+IHhqU32rDOQupNAfYNt+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5fpmAvZ5QloB5UPQTX0giWIumNeD2jgPX0o3EmDxDW9eFl7OElAYPE+dfR033isEz43TPF224TodeyvIvHSkF9Ltcv5uuhYSP4WFPmO5+vQMllGdwMjMrbp2ivve2kShZ3dxmz5wtcAgak2fXI6knYMpCNRwXOMpSM8NkoaqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
X-Spam-Action: no action
X-Spam-Score: 0.01
Received: from [192.168.2.144]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_CHACHA20_POLY1305_SHA256
	(over submission+TLS, TLS-1.3, envelope from "david@davidv.dev")
	; Tue, 13 Jan 2026 12:53:18 +0100
Message-ID: <b07a7008-a093-4a31-8096-1d5c33890c9d@davidv.dev>
Date: Tue, 13 Jan 2026 12:53:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Usage of kfuncs in tracepoints
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
References: <f5e6c1e4-f2f2-4982-a796-e3a49c522bbf@davidv.dev>
 <3735a372-1641-4a37-a7e2-54b7533caf83@oracle.com>
 <bb6a3ada-ddcf-417d-82c7-f86cde6ed4f7@davidv.dev>
 <793831f1-a8ea-4e0b-a0e8-c86c30b1ab2f@redhat.com>
Content-Language: en-US
From: David <david@davidv.dev>
In-Reply-To: <793831f1-a8ea-4e0b-a0e8-c86c30b1ab2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/01/2026 09:05, Viktor Malik wrote:
> On 1/12/26 20:08, David wrote:
>> On 12/01/2026 19:03, Alan Maguire wrote:
>>
>>> I think you need to add "__ksym __weak";" here i.e.
>> This change let me load the program, however, libbpf cannot find a
>> kernel image at
>> /sys/kernel/btf/vmlinux, because /sys/kernel/btf is not populated on my
>> system.
>>
>> My kernel _is_ built with CONFIG_DEBUG_INFO_BTF=y, is there something
>> else I need to do
>>    to get this path populated?
> Did you try rebuilding from scratch (with `make clean`) after enabling
> CONFIG_DEBUG_INFO_BTF? If the sources were already built without debug
> info, they will not be automatically rebuilt just by adding the config
> option.
>
I thought the change took place because `make vmlinux` took a while,
but after a clean build, it does work.

>> Because this path is missing, libbpf reports:
>>
>> ```
>> kernel BTF is missing at '/sys/kernel/btf/vmlinux', was
>> CONFIG_DEBUG_INFO_BTF enabled?
>> ```
>>
>> But I see from strace that it tries a few fallback paths.
>> In the meantime, I copied my kernel into /boot/vmlinux-6.18.2 so libbpf
>> can find it, but
>> now the loader says
>>
>> ```
>> calling kernel function is not supported without CONFIG_DEBUG_INFO_BTF
>> ```
> While libbpf may try other fallback paths to find BTF, using kfuncs
> requires the kernel to find that kfunc in BTF and kernel will only use
> the system BTF (the one from /sys/kernel/vmlinux/btf).
>
This is good to know, thanks. I've removed the /boot/ file from my system.
>> Can I not use `bpf_strstr` on a tracepoint? To validate, I tried a
>> `raw_tp` but
>> had the same result.
> There shouldn't be any issue using bpf_strstr from tracepoints (or any
> other program type).
>
> Viktor
>
Do you happen to know how to generate the kfunc headers with bpftool?
Even a new bpftool build from the newest commit,
ad5d76e5c6b622e5ed05fecfa68029bae949d408, does not generate headers:

```
$ ./bpftool btf dump file ~/git/linux-6.18.2/vmlinux | grep strstr
[28376] FUNC 'bpf_strstr' type_id=28354 linkage=static
[60023] FUNC 'strstr' type_id=60022 linkage=static
$ ./bpftool btf dump file ~/git/linux-6.18.2/vmlinux format c  | grep -c 
strstr
0
```

Could this be related to my host's kernel being older than 6.18?

For now, I'll generate my files from `kernel/bpf/helpers.c`, but it'd be
great if I could use bpftool.

David


