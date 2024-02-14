Return-Path: <bpf+bounces-22027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FAC85537B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B93D283A25
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213713DB81;
	Wed, 14 Feb 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVxuKU7W"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DF1339B6
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940406; cv=none; b=tez3nnaR7aSYXquvWuphKRGv5b3ITtGv/mO8vGPhTt1GpYotHNghyz5Pukt7exS/KCIy0wFFinaT5PeeEGNSIm29w+PbkjSBzMwDv3xCvPfXcpRRAItOEm13vhynlOs/7f4Addm1/8Q2sMQoDCInTZGpcznkNoecyl/BZaCzbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940406; c=relaxed/simple;
	bh=3EEK9vPCrocdXbGJSXOoQjNwwnoIWsSuEkBFtFgk6/c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QPWd7mtT6rliX2e8yvehqoRZaS38qBkCK+PpITJYcQXKAyyULPWX+nqu71QW19vpfwqajWP5fsw7pCJ5UySaa4KBskD8L34ph5gV3QtvEKqBqOVHVZAcus85E4GywQUgekMAAV5EADcK5fwCSQtNW4/l3BnlvR8tlh5Zv3mUzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVxuKU7W; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707940401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3EEK9vPCrocdXbGJSXOoQjNwwnoIWsSuEkBFtFgk6/c=;
	b=hVxuKU7WYpC65nt1IEgPIXkeQOuy6LDt0g58Id5cK1gj8DI4s4BVsDtVD5Tc7AHTOlyg6/
	eV5x5vGx1o/+eKLFRH7dZIcWSCyHaVkt7RM9GFiCF4StlICvF9cx5geX0RsHhoxZkYu9/P
	joS5MuIwmz1Xrh6X/rPJEFq3gwPqYOA=
Date: Wed, 14 Feb 2024 11:53:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, David Vernet <void@manifault.com>,
 lsf-pc@lists.linux-foundation.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: [LSF/MM/BPF TOPIC] Segmented Stacks for BPF Programs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For each active kernel thread, the thread stack size is 2*PAGE_SIZE ([1]).
Each bpf program has a maximum stack size 512 bytes to avoid
overflowing the thread stack. But nested bpf programs may post
a challenge to avoid stack overflow.

For example, currently we already allow nested bpf
programs esp in tracing, i.e.,
   Prog_A
     -> Call Helper_B
       -> Call Func_C
         -> fentry program is called due to Func_C.
           -> Call Helper_D and then Func_E
             -> fentry due to Func_E
               -> ...
If we have too many bpf programs in the chain and each bpf program
has close to 512 byte stack size, it could overflow the kernel thread
stack.

Another more practical potential use case is from a discussion between
Alexei and Tejun. It is possible for a complex scheduler like sched-ext,
we could have BPF prog hierarchy like below:
                        Prog_1 (at system level)
           Prog_Numa_1    Prog_Numa_2 ...  Prog_Numa_4
        Prog_LLC_1 Prog_LLC_2 ...
      Prog_CPU_1 ...

Basically, the top bpf program (Prog_1) will call Prog_Numa_* programs

through a kfunc to collect information from programs in each numa node.
Each Prog_Numa_* program will call Prog_LLC_* programs to collect
information from programs in each llc domain in that particular
numa node, etc. The same for Prog_LLC_* vs. Prog_CPU_*.
Now we have four level nested bpf programs.

The proposed approach is to allocate stack from heap for
each bpf program. That way, we do not need to worry about
kernel stack overflow. Such an approach is called
segmented stacks ([2]) in clang/gcc/go etc.

Obviously there are some drawbacks for segmented stack approach:
  - some performance degradation, so this approach may not for everyone.
  - stack backtracking,  kernel changes are necessary.

   [1] https://www.kernel.org/doc/html/next/x86/kernel-stacks.html
   [2] https://releases.llvm.org/3.0/docs/SegmentedStacks.html


