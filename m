Return-Path: <bpf+bounces-50156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A5A234A2
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4AB18877EF
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA291F03EE;
	Thu, 30 Jan 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Womg4p6g"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CE1946C8
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264952; cv=none; b=Kgt/TD3MSOeuUW1lVLV59CPrdN/EzkHLarLy5BDIq9kylujA4b0+KTUNyMSOIpOUhtG9F56XdQdX8s2Zw/3OBPo0VUz4/8JlcEDlUZA1TkMhYqCf2nkN3HzhF166dKFqEroBfJ8pHk+onaC9VvqUCAY0hho1jiEuuDdqx89ETys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264952; c=relaxed/simple;
	bh=/aXGolVDaF89KuwFQW6YStqg8fmce1uptGjA3T/4oR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHC9XWmvg5a+sExcu3eDsH/dUjFPhOCarXNxhYV9S7s5CMMoWXXK7rTmhAhxnoJfr/oWzVtNHBmfPigkumflSFSjw5ieKeQ33flOyO2hIIgFexAcMPQJuUSSk14NibB34GkHoaSQe3yCMbmsDUHPv8wuX0UoGlJhyR8TARiIPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Womg4p6g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id C67FA2050D86;
	Thu, 30 Jan 2025 11:22:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C67FA2050D86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738264951;
	bh=1Wxtgc+rWjpEWpro0orsbTWfBz150ZJKvr8BwpGNbJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Womg4p6gNQ4DpkA25AF+Cv3TeyZNWNACETAqpm08u8/VB/79lvowIhiANf8NzFXMH
	 Nu2TDt7EyERk/JpVl1+nEVVUIcoCxrbXEMZURirZ2CV85k8+7kPzrslyMktEvbCHrx
	 KKeRZtO+ep2G9bk96EJmHp1A5t9DVDBYcgZh84CU=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, gregkh@linuxfoundation.org, paul@paul-moore.com,
 code@tyhicks.com, flaniel@linux.microsoft.com,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net,
 john.fastabend@gmail.com
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
In-Reply-To: <Z5rSIaXf4Fm5jeRf@pop-os.localdomain>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <Z5rSIaXf4Fm5jeRf@pop-os.localdomain>
Date: Thu, 30 Jan 2025 11:22:24 -0800
Message-ID: <874j1gf6of.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cong Wang <xiyou.wangcong@gmail.com> writes:

> Hello Blaise,
>

Hi!

> On Thu, Jan 09, 2025 at 01:43:42PM -0800, Blaise Boscaccy wrote:
>> 
>> This is a proof-of-concept, based off of bpf-next-6.13. The
>> implementation will need additional work. The goal of this prototype was
>> to be able load raw elf object files directly into the kernel and have
>> the kernel perform all the necessary instruction rewriting and
>> relocation calculations. Having a file descriptor tied to a bpf program
>> allowed us to have tighter integration with the existing LSM
>> infrastructure. Additionally, it opens the door for signature and provenance
>> checking, along with loading programs without a functioning userspace.
>> 
>> The main goal of this RFC is to get some feedback on the overall
>> approach and feasibility of this design.
>> 
>> A new subcommand BPF_LOAD_FD is introduced. This subcommand takes a file
>> descriptor to an elf object file, along with an array of map fds, and a
>> sysfs entry to associate programs and metadata with. The kernel then
>> performs all the relocation calculations and instruction rewriting
>> inside the kernel. Later BPF_PROG_LOAD can reference this sysfs entry
>> and load/attach previously loaded programs by name. Userspace is
>> responsible for generating and populating maps.
>> 
>> CO-RE relocation support already existed in the kernel. Support for
>> everything else, maps, externs, etc., was added. In the same vein as
>> 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
>> this prototype directly uses code from libbpf.
>> 
>> One of the challenges encountered was having different elf and btf
>> abstractions utilized in the kernel vs libpf. Missing btf functionality
>> was ported over to the kernel while trying to minimize the number of
>> changes required to the libpf code. As a result, there is some code
>> duplication and obvious refactoring opportunities. Additionally, being
>> able to directly share code between userspace and kernelspace in a
>> similar fashion to relo_core.c would be a TODO.
>
> I recently became aware of this patchset through Alexei's reference
> in another thread, and I apologize for my delayed involvement.
>
> Upon reviewing your proposed changes, I have concerns about the scope
> of the kernel modifications. This implementation appears to introduce
> substantial code changes to the kernel (estimated at approximately
> 1,000+ lines, though a git diff stat wasn't provided).
>

Yes, it ended up way bigger than I anticipated. The ultimate goal of
that was to be able to conditionally compile parts of libbpf directly
into the kernel and unify the btf and elf libraries. That refactoring
work was way out of scope for a PoC. 

> If the primary objective is eBPF program signing, I would like to
> propose an alternative approach: a two-phase signing mechanism that
> eliminates the need for kernel modifications. My solution leverages
> the existing eBPF infrastructure, particularly the BPF LSM framework.
> So the fundamental architectural difference between these two approaches
> is pretty much kernel-based versus userspace implementation, which has
> been extensively discussed and debated within the kernel community.
>

Code signing, secure system design and supply-chain attack mitigations
are some active research areas that we are exploring. BPF programs have
some interesting ramifications on those topics. Attacks that were
previously demonstrated in CVE-2021-3444 are an area of interest as
well. 

> I have also developed a proof-of-concept implementation, which is
> available for review at: https://github.com/congwang/ebpf-2-phase-signing
>

Sweet, I'll take a look. It sounds super interesting! At a quick
glance, it looks like your approach would probably benefit from John's
suggestions for early-boot un-unloadable bpf programs. 

What are your use cases for signature verification if you don't mind me
asking?

> I welcome your thoughts and feedback on this alternative approach.
>
> Thanks!

-blaise

