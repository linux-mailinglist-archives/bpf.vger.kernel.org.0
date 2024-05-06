Return-Path: <bpf+bounces-28727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590228BD6EF
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B62AB21F08
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673515B97A;
	Mon,  6 May 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ztg7NLjg"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B115B148
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031773; cv=none; b=D92IB6QDpshPoQkvmqPxJZ+RRslLjNj5RXr9NA98R/R5wAhUJZfW89EYlBn8UCf3VhB7tGPZm1FbSFl3pUl4sIHmYf1OlpiagM3/nb82jOHFgFY64nU2KiagQ+LWQPYeIrzEwrsqd2iHvEytB9Ci1x7N+Dyrg7x1XBmNxYUva9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031773; c=relaxed/simple;
	bh=b4sNKwMQNb8FghUUDoixNKfjcJ7qeNHMl1/bkpSJ4z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPTid1MAJdYpPg2XvXrdtA3+oyO/rdEG/EePOXS+xbmiTnMSMSVGwGVFbEK9Z27sToh2vBZQ4rGbPbF+9RaCSVHYoUcnXTo8zXNwBWnbgGMFBXha7PbrHEuUwqM0PN0hg0A65dPpHIA+WNfqYuTBV1sp5ijkgz41ebcx67A9Btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ztg7NLjg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74b4dfa9-f0c0-4b9c-9353-d82b2d74c1ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715031770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tmbtmx6BwwbsNjpsrCojY1mEPjz3KIBXKC+rUt8las=;
	b=Ztg7NLjgPMfY2Cl8TQXjfmFiauL/Y3jgOx6miV85a8/ioTkQ/gj6qZFMo8vU6UqEKxczTM
	52nPVcCdP04DPYr7+nURfzEssWSExph9Ia8ZnSIvL8apZywyk8YiynntSVKXalL/yX7lMq
	+MZNG2zgN+YY/alXhFnOyHg+39jOomA=
Date: Mon, 6 May 2024 14:42:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: disable some `attribute ignored' warnings
 in GCC
Content-Language: en-GB
To: David Faust <david.faust@oracle.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
References: <20240503123213.5380-1-jose.marchesi@oracle.com>
 <a95b1917-80aa-4c81-942d-91f369d31bb2@linux.dev>
 <18123833-2d51-432d-9803-20dd76d7cccd@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <18123833-2d51-432d-9803-20dd76d7cccd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/6/24 12:09 PM, David Faust wrote:
>
> On 5/6/24 11:32 AM, Yonghong Song wrote:
>> On 5/3/24 5:32 AM, Jose E. Marchesi wrote:
>>> This patch modifies selftests/bpf/Makefile to pass -Wno-attributes to
>>> GCC.  This is because of the following attributes which are ignored:
>>>
>>> - btf_decl_tag
>>> - btf_type_tag
>>>
>>>     There are many of these.  At the moment none of these are
>>>     recognized/handled by gcc-bpf.
>>>
>>>     We are aware that btf_decl_tag is necessary for some of the
>>>     selftest harness to communicate test failure/success.  Support for
>>>     it is in progress in GCC upstream:
>>>
>>>     https://gcc.gnu.org/pipermail/gcc-patches/2024-May/650482.html
>>>
>>>     However, the GCC master branch is not yet open, so the series
>>>     above (currently under review upstream) wont be able to make it
>>>     there until 14.1 gets released, probably mid next week.
>> Thanks. It would be great if the patch can be merged soon.
> A small note here - the above series does not itself contain the patch
> to support decl_tag, it is just some prerequisite structural changes and
> the option to prune BTF before emission similar to clang to slim the
> selftest (and other) program sizes down.
>
> The patch to enable decl_tag for functions in BTF, enough for the
> selftest harness, can go up after that. But, it will require some
> approvals from the C front-end maintainers, since it is a new attribute,
> so it may take longer, and may be contentious.

Thanks for the update! Let me know if I can help from llvm/kernel/bpf
perspective.

>
>>>     As for btf_type_tag, more extensive work will be needed in GCC
>>>     upstream to support it in both BTF and DWARF.  We have a WIP big
>>>     patch for that, but that is not needed to compile/build the
>>>     selftests.
>> Thanks. Eduard has implemented in llvm with agreed new format. Since
>> the old phabricator becomes readonly, he will upstream the original
>> patch to llvm-project soon.
[...]

