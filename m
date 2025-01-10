Return-Path: <bpf+bounces-48600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0CEA09E3A
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1688E16BB53
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AB21766F;
	Fri, 10 Jan 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cUF29OPL"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927A212B18
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548928; cv=none; b=mSGHC7eSEA4dlqPjGf040v1Rc01m2Z94scx74G14tp5nHc/P8PQmDES1wO5oyBtYjaG+0Tln8Hk8w+fUW6kjx8hHlRyOvJ4RsiJcO4XeMrcAkbzjfikTO3Bpm5u6zQ82jvfZDV95gpUCJxKkw84zIHsOnaEVAL5uDLi0IySrtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548928; c=relaxed/simple;
	bh=acFrwJl5f/7dNQIe8rDcHEzhm6Kbcllm3VOvmvZGeAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHE3qmSS78v3d7u0J2iJAklh+EkfBcHZRcmjeoVRkyqOZCSGpW+ZyJUXpxLZAsCk19Bd573OIOlQKiKzlAfDfKTtZdwo2BFTfi2O5rO/sK7z2nXcYHZbAoTDu/58/O/KAXR/f0F1vZpruYSmMv0VWnD0SWrOmBzwKnybwlD37ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cUF29OPL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id BEC6D203D5F4;
	Fri, 10 Jan 2025 14:42:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BEC6D203D5F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736548926;
	bh=pbtY5fKoynfDmU2q2iOuqDK4qXdn5++su6pPjHFuMDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cUF29OPLs0QZJOkIHJ8XX21BE1yZz9zz4dBvEWsavbN2/V5qtRUYtkhEHeEGgjKGn
	 r1Hc0aZROu5lPnqdhhORScZ+mZ5v6Zy9o2fZEy5ySradMg0HzIZ4NrTGfkmQtDBuqX
	 uVMHUOijOMU60mlNMVytVuGHh0IqTnNgU++7zq+w=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bpf@vger.kernel.org, nkapron@google.com, teknoraver@meta.com,
 roberto.sassu@huawei.com, paul@paul-moore.com, code@tyhicks.com,
 flaniel@linux.microsoft.com
Subject: Re: [PATCH 07/14] bpf: Implement BPF_LOAD_FD subcommand handler
In-Reply-To: <2025011010-unglue-latch-34ea@gregkh>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
 <20250109214617.485144-8-bboscaccy@linux.microsoft.com>
 <2025011010-unglue-latch-34ea@gregkh>
Date: Fri, 10 Jan 2025 14:41:58 -0800
Message-ID: <87ldvi47gp.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Greg,

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 09, 2025 at 01:43:49PM -0800, Blaise Boscaccy wrote:
>> The new LOAD_FD subcommand keys off of a sysfs entry file descriptor
>> and a file descriptor pointing to a raw elf object file.
>
> A sysfs file descriptor?  That feels very odd and is not how sysfs
> should be used, as it's only for text files and binary pass-through
> stuff.
>

Yeah, libbpf has a feature where it can load multiple independent
ebpf programs from a single object file. It parses the whole object file
and then for each program, calls BPF_PROG_LOAD. I was trying to mimic that
flow here, by having a single call to BPF_LOAD_FD and allowing
userspace to repeatedly call BPF_PROG_LOAD as needed referencing that
result. 

bpffs would probably be a more appropriate choice for this. The purpose
of the PoC was mostly to test whether or not kernel relocs where even doable
and if there was any support for it upstream. The interface could
definitely use some polishing.

I'm also not sure how pervasive that use case is in the wild and if it is
more of a premature optimization here than anything. Alternatively, it
may be acceptable to combine BPF_LOAD_FD and BPF_PROG_LOAD into a single
operation and reparse/relocate for each discrete program load and then
remove all this.  

>> +static void bpf_loader_show_fdinfo(struct seq_file *m, struct file *filp)
>> +{
>> +	int i;
>> +	struct bpf_obj *obj = filp->private_data;
>> +
>> +	for (i = 0; i < obj->nr_programs; i++)
>> +		seq_printf(m, "program: %s\n", obj->progs[i].name);
>
> So what file is printing this out in sysfs?

There are two file descriptors passed into BPF_LOAD_FD, this uses the
first one (bpffs_fd).

> Where is the
> Documentation/ABI/ entry for it?
>

That's still a TODO and an oversight on my part.

> confused,
>
> greg k-h


Thanks for the feedback.

-blaise

