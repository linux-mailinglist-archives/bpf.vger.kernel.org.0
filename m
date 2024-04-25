Return-Path: <bpf+bounces-27786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FC8B1A9E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D44B22803
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 06:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87F3BBE8;
	Thu, 25 Apr 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JcFM/1QU"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A263B791
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025148; cv=none; b=SwnnA9mVIjlMEX3Y6oJpKBN3p5YuRaTzpytnbm4IovGlwkCFEyMR2h4Qxx7Kpx3oC0TqbrPK5Q9/4/vFdYyLV2VHruBFxbjywibvuFj7HK/VK4oxWMhEqGV6FMhvbuMIh12f7QCETkqQZDQNahFKCqP88FvwTD3sIe1QP/V2dfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025148; c=relaxed/simple;
	bh=wQ6wmhJBII5TfVe34bXc8CdIGSn8g0SeEVBO0XkjPQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgFbkzaGty2qIx7ngGHyQzVSmjEezGBzWb0BXcgxJTvzDH2plUiEN9EIbL58LjeOoADzPkCegR3esYF7ymsmLKfHcKJUMrGEon74QphjIwZnuErHT5UhcO8TybtxUbeZMvy7/3FNqtKH1BuoRVjiJN79CEXdsnjfCRQCpaSg+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JcFM/1QU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f455382b-d983-48d7-831d-f2ae4b8757b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714025143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvo7RacTzEL/k6230BbWBsAk5BG+UTuqN9U8VuvRilA=;
	b=JcFM/1QUSn1NfXfE+BfsGB+wiXwS1eHo0liJDsiAQHVbmqU0580NERuBb8PnohcD6Fzgny
	BX+HDTg/rK0iLYlkS9/sq9nNIl5BrpaGOSTQTPbJQNeu1V/DpQD82N8DOAFpA/RJSu53jP
	FpFINrup8DI4tgjDOPXZCrdHQbJ7Qes=
Date: Wed, 24 Apr 2024 23:05:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
References: <20240411131127.73098-1-laoar.shao@gmail.com>
 <CALOAHbCBxGbLH0+1fSTQtt3K8yXX9oG4utkiHn=+dxpKZ+64cw@mail.gmail.com>
 <CAEf4BzbynKkK_sct2WdTrF2F+RJ1tD3F6nYAew+Gq82qokgQGA@mail.gmail.com>
 <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CALOAHbBBDwxBGOrDWqGf2b8bRRii8DnBHCU9cAbp_Sw-Q6XKBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/24/24 10:36 PM, Yafang Shao wrote:
> On Thu, Apr 25, 2024 at 8:34 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Thu, Apr 11, 2024 at 6:51 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>> On Thu, Apr 11, 2024 at 9:11 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>> Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
>>>> added for the new bpf_iter_bits functionality. These kfuncs enable the
>>>> iteration of the bits from a given address and a given number of bits.
>>>>
>>>> - bpf_iter_bits_new
>>>>    Initialize a new bits iterator for a given memory area. Due to the
>>>>    limitation of bpf memalloc, the max number of bits to be iterated
>>>>    over is (4096 * 8).
>>>> - bpf_iter_bits_next
>>>>    Get the next bit in a bpf_iter_bits
>>>> - bpf_iter_bits_destroy
>>>>    Destroy a bpf_iter_bits
>>>>
>>>> The bits iterator can be used in any context and on any address.
>>>>
>>>> Changes:
>>>> - v5->v6:
>>>>    - Add positive tests (Andrii)
>>>> - v4->v5:
>>>>    - Simplify test cases (Andrii)
>>>> - v3->v4:
>>>>    - Fix endianness error on s390x (Andrii)
>>>>    - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
>>>> - v2->v3:
>>>>    - Optimization for u64/u32 mask (Andrii)
>>>> - v1->v2:
>>>>    - Simplify the CPU number verification code to avoid the failure on s390x
>>>>      (Eduard)
>>>> - bpf: Add bpf_iter_cpumask
>>>>    https://lwn.net/Articles/961104/
>>>> - bpf: Add new bpf helper bpf_for_each_cpu
>>>>    https://lwn.net/Articles/939939/
>>>>
>>>> Yafang Shao (2):
>>>>    bpf: Add bits iterator
>>>>    selftests/bpf: Add selftest for bits iter
>>>>
>>>>   kernel/bpf/helpers.c                          | 120 +++++++++++++++++
>>>>   .../selftests/bpf/prog_tests/verifier.c       |   2 +
>>>>   .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++++
>>>>   3 files changed, 249 insertions(+)
>>>>   create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c
>>>>
>>>> --
>>>> 2.39.1
>>>>
>>> It appears that the test case failed on s390x when the data is
>>> a u32 value because we need to set the higher 32 bits.
>>> will analyze it.
>>>
>> Hey Yafang, did you get a chance to debug and fix the issue?
>>
> Hi Andrii,
>
> Apologies for the delay; I recently returned from an extended holiday.
>
> The issue stems from the limitations of bpf_probe_read_kernel() on
> s390 architecture. The attachment provides a straightforward example
> to illustrate this issue. The observed results are as follows:
>
>      Error: #463/1 verifier_probe_read/probe read 4 bytes
>      8897 run_subtest:PASS:obj_open_mem 0 nsec
>      8898 run_subtest:PASS:unexpected_load_failure 0 nsec
>      8899 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>      8900 run_subtest:FAIL:659 Unexpected retval: 2817064 != 512
>
>      Error: #463/2 verifier_probe_read/probe read 8 bytes
>      8903 run_subtest:PASS:obj_open_mem 0 nsec
>      8904 run_subtest:PASS:unexpected_load_failure 0 nsec
>      8905 do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>      8906 run_subtest:FAIL:659 Unexpected retval: 0 != 512
>
> More details can be found at:  https://github.com/kernel-patches/bpf/pull/6872
>
> Should we consider this behavior of bpf_probe_read_kernel() as
> expected, or is it something that requires fixing?

Maybe to guard the result with macros like __s390x__ to differentiate 
s390 vs. arm64/x86_64? There are some examples in prog_tests/* having 
such guards. probe_user.c:#if defined(__s390x__) 
test_bpf_syscall_macro.c:#if defined(__aarch64__) || defined(__s390__) 
xdp_adjust_tail.c:#if defined(__s390x__) xdp_do_redirect.c:#if 
defined(__s390x__)


