Return-Path: <bpf+bounces-21172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E381F8490A4
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B96C1C21564
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D32BD1C;
	Sun,  4 Feb 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZwyUQTx"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB628E09
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082018; cv=none; b=XPndeJOpZS3+XY3xIVqDAElp3gfPgv2RxSqAtAQ2zQt/zSa1+0jjdH3mI529/qmeq42N6ZcBsQi0P2qx0cy6Ia5mA7E0ks2DfyTv+fTRvQeDOsP1tGxtfAM4y3+ZiIatRR+FH8ObMtDLCoHqmEFMHhtfnxs0DTLecBSFtUanMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082018; c=relaxed/simple;
	bh=5590Po7QmymR257h0aQaIHBnPvVSP40SzQMeB7DwK20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0f/CcEAVDSyG+xdzTwDobpjpu0CksgbYisJOyz9D4Eg/xbKTBjJfznbWWUwmEPNM3I3vG2/ZPohy7W1jQ98lwubSgzzBfM8+DB5BSjaTq71WfRhKVPAGco5GdGs2WYHsFfFHxRthOCCWSIA3XDAFcpAfeuuH7gbiN1ItsjulW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZwyUQTx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5913c58-abbe-46bd-a439-99a61130e8fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707082014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bpzhRePpVHQ7VLDapovbINbs6CfyNKYhXcwI98wrH0=;
	b=sZwyUQTxVcjrsoofGYPjpcOgJd/NeIGGcWK21aRGJqH8eY0GHT/kCd5zc4XDSYq5KkOMok
	pRA5bnsbbwP4/8C913Bil4UdlqgaCx+60Ilw4GDgaf++cBD9omw5P1va6asud05SaWkN5X
	AD0MV9OAzmguhxsNUyS8SMt984NeFWE=
Date: Sun, 4 Feb 2024 13:26:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add test for static
 subprog call in lock cs
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Barret Rhoden <brho@google.com>,
 David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
References: <20240204120206.796412-1-memxor@gmail.com>
 <20240204120206.796412-3-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204120206.796412-3-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 4:02 AM, Kumar Kartikeya Dwivedi wrote:
> Add selftests for static subprog calls within bpf_spin_lock critical
> section, and ensure we still reject global subprog calls. Also test the
> case where a subprog call will unlock the caller's held lock, or the
> caller will unlock a lock taken by a subprog call, ensuring correct
> transfer of lock state across frames on exit.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

LGTM with possible verifier message rewording from "function calls are
not allowed while holding a lock" to "global function calls are not
allowed ...".

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   .../selftests/bpf/prog_tests/spin_lock.c      |  2 +
>   .../selftests/bpf/progs/test_spin_lock.c      | 65 +++++++++++++++++++
>   .../selftests/bpf/progs/test_spin_lock_fail.c | 44 +++++++++++++
>   3 files changed, 111 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> index 18d451be57c8..6a4962ca0e5e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> +++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
> @@ -48,6 +48,8 @@ static struct {
>   	{ "lock_id_mismatch_innermapval_kptr", "bpf_spin_unlock of different lock" },
>   	{ "lock_id_mismatch_innermapval_global", "bpf_spin_unlock of different lock" },
>   	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
> +	{ "lock_global_subprog_call1", "function calls are not allowed while holding a lock" },
> +	{ "lock_global_subprog_call2", "function calls are not allowed while holding a lock" },
>   };
>   
>   static int match_regex(const char *pattern, const char *string)
[...]

