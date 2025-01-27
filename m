Return-Path: <bpf+bounces-49885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9AA1DD92
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 21:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E6F1650E0
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE65195FEC;
	Mon, 27 Jan 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSFwSkcN"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948518E756
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011081; cv=none; b=cs6XEphKF87g2gATuqJ7YLwQtkKDz4A1V1i58sSN3G/+eb6L0ZTh6WNjzV73dM4UZkw01pys9yzNV1L8vG8Y1bR9So8036h6h51gLNKdJO5Pi7aDpLa2ZIWJfALwBwQz82m2/qZJ9pzrq05gy20XEA1aoYIwbhoDdQ97Pt08YGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011081; c=relaxed/simple;
	bh=OVO7YwMMYFQSf6bO8E55LBXw4BlLAwgfmdVioaw0KQQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sk0uEuQL8v3KuKlUBLlLuULZdjjnw/FqluSA3I690Od4uqOhc9kgMYkfQwipS91qyrADeIOacADC8ahFeOA8cmjscsmjsNM1M/CNz+Lkixsp6ijmKMxh658rXI1yNty1mHY0NUHsjk2XPEJM5uW33bc0/JP+acc9/Id5H3qGxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSFwSkcN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6decc31d-838f-4caa-957c-9230a970d01e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738011067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00qEdsPMOlTic0OaMrv66fEynTV0bQHKlOysQaZVg7s=;
	b=uSFwSkcNPQw5a7CWlVGCJMy+3FdtWrUJu4+4LYrVrjCEWJlUvxg9mV/FE3rlK1XrkSB6u9
	sXUvjr3NY2HbhIJ9EzN3yi5nEsZhjqwI5aPi1UPtC4PKKnwW8k7G5l2pL0vdqA/taF6f/J
	TrGr9r+PnL/WlfQe7A4UKEYU05IgPus=
Date: Mon, 27 Jan 2025 12:51:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
 <4bc39acd-e7ce-44e1-b7c7-ffbeb1ecb4f1@oracle.com>
Content-Language: en-US
In-Reply-To: <4bc39acd-e7ce-44e1-b7c7-ffbeb1ecb4f1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/22/25 2:13 AM, Alan Maguire wrote:
 > On 22/01/2025 02:53, Ihor Solodrai wrote:
 >> This patch series extends BPF Type Format (BTF) to support arbitrary
 >> __attribute__ encoding.
 >>
 >> Setting the kind_flag to 1 in BTF type tags and decl tags now changes
 >> the meaning for the encoded tag, in particular with respect to
 >> btf_dump in libbpf.
 >>
 >> If the kflag is set, then the string encoded by the tag represents the
 >> full attribute-list of an attribute specifier [1].
 >>
 >> This feature will allow extending tools such as pahole and bpftool to
 >> capture and use more granular type information, and make it easier to
 >> manage compatibility between clang and gcc BPF compilers.
 >>
 >
 > sounds good! So presumably pahole will then have a "full_attribute" or
 > similar BTF feature that will only do full attribute encoding for
 > kernels that expect the kind flag to be set? Otherwise we'll run the
 > risk of generating invalid BTF for older kernels with newer pahole
 > (since those older kernels will fail to verify tags with a kind flag 
set).

Hi Alan. Sorry I missed this message on the first pass.

Yes, this BTF extension enables pahole to encode any __attribute__ in
BTF. There is already a use case for that, which led me to this patch
series: expressing bpf_arena tags in vmlinux.h.

As to "full_attribute"-like feature in pahole, my intuition is that
it's a significant chunk of work, and it might not be necessary in the
near future. But with these changes in BTF it at least becomes a
possibility. And you're right, it will have to be an optional feature.

 >
 > Thanks!
 >
 > Alan
 >
 >> [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
 >>
 >> Ihor Solodrai (5):
 >>   libbpf: introduce kflag for type_tags and decl_tags in BTF
 >>   libbpf: check the kflag of type tags in btf_dump
 >>   selftests/bpf: add a btf_dump test for type_tags
 >>   bpf: allow kind_flag for BTF type and decl tags
 >>   selftests/bpf: add a BTF verification test for kflagged type_tag
 >>
 >>  Documentation/bpf/btf.rst                     |  27 +++-
 >>  kernel/bpf/btf.c                              |   7 +-
 >>  tools/include/uapi/linux/btf.h                |   3 +-
 >>  tools/lib/bpf/btf.c                           |  87 +++++++---
 >>  tools/lib/bpf/btf.h                           |   3 +
 >>  tools/lib/bpf/btf_dump.c                      |   5 +-
 >>  tools/lib/bpf/libbpf.map                      |   2 +
 >>  tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
 >>  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
 >>  tools/testing/selftests/bpf/test_btf.h        |   6 +
 >>  10 files changed, 234 insertions(+), 77 deletions(-)
 >>
 >

