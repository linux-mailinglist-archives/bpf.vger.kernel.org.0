Return-Path: <bpf+bounces-66935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB1B3B234
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145A61C83C4A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08651C5D72;
	Fri, 29 Aug 2025 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mMbtoxBc"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAA1373
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756442845; cv=none; b=uU6O3dRlBZEDD5j0vCx73jXjU6TpEKh1aNZVWOq/0WUiwexU2hCjDsGh23Q/1rPxZlscc7GKDRQWD6PV1BSvw5bjPZPSl3D11DdvfAyzfmzWRV4kbMDx863aCGFIevbqx6AVRqt6o+Dp8e0eGbW0lZ0hArdMJN0hx96D8EsSqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756442845; c=relaxed/simple;
	bh=CWeRyO+OuTqPwlUUrlyUBM9X1+Rg53uSH89ORHoTxJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTErt9G0cBFV+HY1kigDd7BILPw0Sus4myy9t1lVLNRCeSb7ooA7PqWthfQLFyJq27E/d3RJuG3OFM12YBp+NJ6J1nL9yWI4cAM1DumJwTQ089kgAUuigd9hq3FhWThLUwS94OJWGgpN69RUr3crBg02KO4OoYUMq0L8nTDU238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mMbtoxBc; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e008e5d4-8a38-407e-a90b-eb960e6cc4d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756442840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWeRyO+OuTqPwlUUrlyUBM9X1+Rg53uSH89ORHoTxJY=;
	b=mMbtoxBcBlcLxFDqxj7MckBPlB4cDwKAUcuqHcYbT9Y2tb6+a8aG3+HYefUUcKIRvoJHzC
	LnrqbcuzdiFwaSjoE8tZdNHn0l3LODMr7IeHgrIpjONd9DV4e42QKvt6BtTLfVZHA53WSS
	Hvle/HH7kOdT0V0JKAuzrHcWH37SVPw=
Date: Thu, 28 Aug 2025 21:47:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/1] selftests/bpf: Fix "expression result
 unused" warnings with icecc
Content-Language: en-GB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250829030017.102615-1-iii@linux.ibm.com>
 <20250829030017.102615-2-iii@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250829030017.102615-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/28/25 7:53 PM, Ilya Leoshkevich wrote:
> icecc is a compiler wrapper that distributes compile jobs over a build
> farm [1]. It works by sending toolchain binaries and preprocessed
> source code to remote machines.
>
> Unfortunately using it with BPF selftests causes build failures due to
> a clang bug [2]. The problem is that clang suppresses the
> -Wunused-value warning if the unused expression comes from a macro
> expansion. Since icecc compiles preprocessed source code, this
> information is not available. This leads to -Wunused-value false
> positives.
>
> obj_new_no_struct() and obj_new_acq() use the bpf_obj_new() macro and
> discard the result. arena_spin_lock_slowpath() uses two macros that
> produce values and ignores the results. Add (void) casts to explicitly
> indicate that this is intentional and suppress the warning.
>
> An alternative solution is to change the macros to not produce values.
> This would work today for the arena_spin_lock_slowpath() issue, but in
> the future there may appear users who need them. Another potential
> solution is to replace these macros with functions. Unfortunately this
> would not work, because these macros work with unknown types and
> control flow.
>
> [1] https://github.com/icecc/icecream
> [2] https://github.com/llvm/llvm-project/issues/142614
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


