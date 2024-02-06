Return-Path: <bpf+bounces-21288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CBE84AE78
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FDFB23534
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093B128365;
	Tue,  6 Feb 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="axHZ44qt"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C5C74E03
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202081; cv=none; b=mAHB0bEHN3mrfMRl+Q229dMDAKHmV9R22CGqnhxDj0rrup8XfNqMmJUIdg2EYzDD0LdhMbn3xNcUSATDv7orexTxt8QLDiH/o4nWCtE5lmTcXISecPsZFidwv1ItfK+5uL9J7iJP4FzvdorajXnllbPL135+sIMTKG3RW4Q3Pl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202081; c=relaxed/simple;
	bh=k8FwQ5x8ZCtGD3XZqfig5l6zzG/f3PrvyvqYh7H7Yrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmlDuiiVJFMIal5oGwtXSz4lL8+Rm//bBfhdOBDD/iGkfpTyQNvcAWNHFe+SxV22ugoVkrmrBld/lILXyEENYvBj/mfLDdJMHp+aleBmQcOOIjbeqjAkJOSZA+8hcJtYIgL03v3a4iqpkQj9r8Qygp1bPHk7KfDdmV21vrbS420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=axHZ44qt; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39e2ec12-0f38-4fec-90e8-a4e3d6b56a52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707202077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JU7uz7FI5TYvkofj2Xg3Wb9Z22sNhYj4kbRApyOx6eE=;
	b=axHZ44qtFGGiCiGKoE84WOgailystuN46kmW9+v251dRffwEzMIol3AdMv2t8wxOO9DH2m
	J1kuvwjb8XxeuEyBlO1b/l+ajjITNUBtI973mLN/pqepcn9Dj7fHK4mg/KkeWEkJU7kGEm
	wUy+DRyfr/l19VNnI79nDMlIfn77nyE=
Date: Mon, 5 Feb 2024 22:47:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FYI: bpf selftest verif_scale_strobemeta_subprogs failed with
 latest llvm19
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
References: <32bde0f0-1881-46c9-931a-673be566c61d@linux.dev>
 <CAEf4BzZ9L9kUz--+K=D7CubSG8xWCxuw1R6tWxFC=93VbZ4ZUw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZ9L9kUz--+K=D7CubSG8xWCxuw1R6tWxFC=93VbZ4ZUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/5/24 11:30 AM, Andrii Nakryiko wrote:
> On Sun, Feb 4, 2024 at 10:58 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The selftest verif_scale_strobemeta_subprogs failed with latest llvm19 compiler.
>> For example,
>>
>>     $ ./test_progs -n 498
>>     ...
>>     libbpf: prog 'on_event': BPF program load failed: Permission denied
>>     libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
>>     combined stack size of 4 calls is 544. Too large
>>     verification time 1417195 usec
>>     stack depth 24+440+0+32
> Is it a `struct strobe_map_raw map` in read_map_var()? I think we
> should move it to a per-cpu array anyways (not saying we shouldn't fix
> Clang regression), in production we've done this already a while ago
> :)

Yes, moving 'struct strobe_map_raw map' to be a global variable
does work. I just sent a kernel patch to reduce the stack requirement
for jitted code, which fixed this regression.
   https://lore.kernel.org/bpf/20240206063010.1352503-1-yonghong.song@linux.dev/

But let us keep the code as is for now, so we could use it to capture future
potential clang regressions.

>
>>     processed 53561 insns (limit 1000000) max_states_per_insn 18 total_states 1457 peak_states 308 mark_read 146
>>     -- END PROG LOAD LOG --
>>     libbpf: prog 'on_event': failed to load: -13
>>     libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
>>     scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
>>     #498     verif_scale_strobemeta_subprogs:FAIL
>>     Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> The maximum stack size exceeded 512 bytes and caused verification failure.
>>
>> The following llvm patch caused the above regression:
>>     https://github.com/llvm/llvm-project/pull/68882
>>
>> I will do some analysis and try to find a solution to resolve this failure.
>>
>> Thanks,
>>
>> Yonghong
>>
>>

