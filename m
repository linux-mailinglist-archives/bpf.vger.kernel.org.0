Return-Path: <bpf+bounces-66034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C045B2CD55
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C621A1C24AB6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF52D24B0;
	Tue, 19 Aug 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AOFY0fy8"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8A52F99
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633133; cv=none; b=DtJSpOhR0NFUaB6Vo4KAcfkVu8IrDUSQVcMEZABT+PcU1i76Zk0x5d4+SIm8IMvnUBeMl+15dcpykAdqIqSzbg4TFiPngPbWQKR0GUo/YcAqqnfc2CMGZYMeKUCJZyu4+/DZg34R2iUFbadIg5Vv9DQ/sZLGLUouVlB1xasoxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633133; c=relaxed/simple;
	bh=uaT5O8+gH40OBP1k8JO+8K7fEf6thBZsopWOAgvWGIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFeMTGgWuUk+4R/9vksBbYBuLNr91Y08NyFmJ7378J5zoTZxr0/NmaEUF6fCGqjbmgYaJZF1ONnguXtc+NAakx760rmrJ7uSlUWC3xqfjBZFDm6tdoxPXAqBbdxZh+JfVy4+0DPoO7fOBo00YkE2SlmQgVytG7JJwzOYgIQrqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AOFY0fy8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755633128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiIJaIurNs+d0wpVmpnQe7JGyakHNwZCGwlLVvllqGo=;
	b=AOFY0fy8b+J4w2Sz1K6yMWTww3B1VaCi/oU4JySA336aFTWeN3WV7o2nxuOs/l8cpbHIYL
	BG8iS3jKdQY/yQ/fpSaeSkFI0bEsfKPGjVj6sBus90jZcECifLpHnvSmm2UNunNlMPc2d6
	9p2Xnksc+DE2i6yd/eYbBGJ8ZqdukT0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,  David Rientjes
 <rientjes@google.com>,  Matt Bobrowski <mattbobrowski@google.com>,  Song
 Liu <song@kernel.org>,  Kumar Kartikeya Dwivedi <memxor@gmail.com>,
  Alexei Starovoitov <ast@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: BPF OOM
In-Reply-To: <CAJuCfpG1+bnFwpc4bxut_5tFtFc-s7+u2YF-suefoXq2-NijJw@mail.gmail.com>
	(Suren Baghdasaryan's message of "Mon, 18 Aug 2025 21:08:27 -0700")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<CAJuCfpG1+bnFwpc4bxut_5tFtFc-s7+u2YF-suefoXq2-NijJw@mail.gmail.com>
Date: Tue, 19 Aug 2025 12:52:01 -0700
Message-ID: <87a53v2iou.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Suren Baghdasaryan <surenb@google.com> writes:

> On Mon, Aug 18, 2025 at 10:01=E2=80=AFAM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
>>
>> This patchset adds an ability to customize the out of memory
>> handling using bpf.
>>
>> It focuses on two parts:
>> 1) OOM handling policy,
>> 2) PSI-based OOM invocation.
>>
>> The idea to use bpf for customizing the OOM handling is not new, but
>> unlike the previous proposal [1], which augmented the existing task
>> ranking policy, this one tries to be as generic as possible and
>> leverage the full power of the modern bpf.
>>
>> It provides a generic interface which is called before the existing OOM
>> killer code and allows implementing any policy, e.g. picking a victim
>> task or memory cgroup or potentially even releasing memory in other
>> ways, e.g. deleting tmpfs files (the last one might require some
>> additional but relatively simple changes).
>>
>> The past attempt to implement memory-cgroup aware policy [2] showed
>> that there are multiple opinions on what the best policy is.  As it's
>> highly workload-dependent and specific to a concrete way of organizing
>> workloads, the structure of the cgroup tree etc, a customizable
>> bpf-based implementation is preferable over a in-kernel implementation
>> with a dozen on sysctls.
>
> s/on/of ?

Fixed, thanks.

