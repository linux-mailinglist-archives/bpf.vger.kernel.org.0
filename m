Return-Path: <bpf+bounces-60091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7513AD28CF
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1BF16B4D4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046921A457;
	Mon,  9 Jun 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/DBebs5"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6E78F36
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504645; cv=none; b=VURM1/6jcrTt8iYwMIYtbpRg92FlqmwMS4W7mN+MNqob42vWqcuWwvt6sYxcpLZoKTZgy+BBWk+5xyvteydLVax5/G9yzOFlcWyHXuv9hkz5R+MtROSPUhZZ+CSK/gF2+tD7s0VxmUqp1BqNue6EW2fivKfs0VHJbXhH5j7vKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504645; c=relaxed/simple;
	bh=75z942fuAvdtuSuzwbVWnEAZEoXOtdiMeRPGrwp6Gco=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X6P84QZ1lEO7wEYoFFXzLdSxMLsxnsErrl9KX8zBFPFqimnGSI49A807yOR9nAUFEFvRrw9xnpdVZa8YXyvmCIt4WRlFueqXYaNPH/FvPEfCW/IPAfuI/h2ohMDEipfoxk4KqweZuAxBoJmzNcHaMNB/OONuYe6jd48JrgZ5w70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/DBebs5; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c17b2e6c-3626-4d69-8784-01b13a9e2851@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749504640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=75z942fuAvdtuSuzwbVWnEAZEoXOtdiMeRPGrwp6Gco=;
	b=W/DBebs5kOMyaUDr3OGYMU6jmw3qHxbK1a47fodPRmdgHkJJ8YHoR/TEHlxTdQnlayYcch
	cO/hO0eDXOY3if1vsQ5NDjJKRg4aVCaf9Mg7QsxyeS0sQbn/xj5m5oxD3ZjmEgA4lkr2i0
	zvxB5NbLe3W47STfX3YS41v54CP4bqY=
Date: Mon, 9 Jun 2025 14:30:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Kernel Team <kernel-team@meta.com>, kernel-ci@meta.com,
 Alexei Starovoitov <ast@kernel.org>, tj@kernel.org, mkutsevol@meta.com,
 scottbpc@meta.com, jakehillion@meta.com, mykolal@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: BPF CI update: veristat-scx job
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi everyone.

In effort to improve testing of both BPF subsystem and sched-ext
project [1], a new testing workflow has been added to BPF CI:
veristat-scx.

veristat-kernel and veristat-meta jobs have been running for a while
now, and veristat-scx is basically adding more test cases using
sched-ext BPF programs as input.

For those who aren't aware, veristat [2] is a command line tool that
can be used to load BPF object files into the kernel and check
verification results, among other things. It's source code is at
./tools/testing/selftests/bpf/veristat.c

On BPF CI, veristat-${target} job takes BPF object files (determined
by ${target}) as input, and runs veristat on them against the kernel
under testing. In addition to checking whether BPF program is accepted
by the verifier, the CI job also collects verifier performance stats,
and compares them to the baseline *failing* if a significant
regression is detected.

See an example of successful job run here:
https://github.com/kernel-patches/bpf/actions/runs/15543439297/job/43761685117

[1] https://github.com/sched-ext/scx
[2] https://github.com/libbpf/veristat

