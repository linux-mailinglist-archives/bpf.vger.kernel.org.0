Return-Path: <bpf+bounces-61906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77238AEEA1D
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4993B06F6
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B754243387;
	Mon, 30 Jun 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yo08uiH/"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689EA22D7B5
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322147; cv=none; b=Not4lMLnXpHQSlncglnNZl2uldrBB8T90Y/qipnTDI9ELmSpxrMXmzKkkETFC8N5/+3Xcx4o3Y/a748ZSWcJ2rK/OPn7gemmajjpGPNOdKvd4knLGWqQTAITJBEDa+Zq3B0hDjCCUq0/mnMuU4dS+sWD/lMuUs4ZXlJqL2AQD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322147; c=relaxed/simple;
	bh=k189ImaTSlmI9ImLhngM9xR9ua9bmyA/7znzYmm997U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC7o8GgSihurH71guej/Gh3xhfhaHAnoXSBUIDV1qhMbHld6futRAk07X7zxooE6NP/LR1W9pZc2Yh30O/xS/GBcTMcUI3bCvgkM7a+b7JHilP4+zHT6hAxjwf451I1wpUA5LjcIE0bTSkCWYWBBudMPX3XOYRmkcOwIxbCX4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yo08uiH/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1daf0625-1518-4a75-b215-e6170b17ee56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751322143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56wihOXZbbSXAMpXckuhuHcl/N23LVlJJtHCY22s9R8=;
	b=Yo08uiH/OXAIWegt7xs1s88/tAzGEodPv5paD5Gccv4KEDTQTuDZl8t2bVQDxHE6RF9ILI
	Z2+oaBzjLMskdNwBrmtAdcvA/z8iTmV3ip366MLoafy/rA4Ns1i3PnlgsWzrJT6JPcjtcS
	DdEEBikvNJcIqQXI5jh1M4W94tdf8lA=
Date: Mon, 30 Jun 2025 15:22:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix
 cgroup_xattr/read_cgroupfs_xattr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20250627191221.765921-1-song@kernel.org>
 <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
 <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com>
 <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev>
 <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
 <9583e9fd-72aa-4d83-ac1b-6aaf018c418a@linux.dev>
 <CAADnVQLcYZWjBVqAXR4QgpzubZ1R_5sWi0TmGs8dFDu+FNc3xg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQLcYZWjBVqAXR4QgpzubZ1R_5sWi0TmGs8dFDu+FNc3xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/30/25 3:11 PM, Alexei Starovoitov wrote:
> On Mon, Jun 30, 2025 at 2:49 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>>>
>>> The offending commit is only in /master and in /for-next branches,
>>> while /for-next is there for linux-next only.
>>
>> Alexei, for-next contains offending commit, but does not have Song's
>> fix. Right now it's the only base branch on BPF CI that uses the temp
>> patch.
> 
> ok. updated /for-next
> 
>> We do run tests on for-next, so I suppose the patch should remain in
>> ci/diffs until it's committed into for-next?
> 
> It's news to me that we run BPF CI on /for-next.
> I thought we only do it on /master and /net.

Currently we have 4 base branches, for which CI runs on push:
   * bpf = bpf/master
   * bpf-next = bpf-next/master
   * bpf-net = bpf-next/net
   * for-next = bpf-next/for-next

I added bpf-net and for-next in March, but Manu opened a PR [1] for
that last year, so it looks like we planned to do it a while ago.

The netdev is done via PR from [2] on github side, not managed by KPD.

[1] https://github.com/linux-netdev/testing-bpf-ci/tree/to-test
[2] https://github.com/kernel-patches/vmtest/pull/286

