Return-Path: <bpf+bounces-51794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0267A39151
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD116E96E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41D1487E9;
	Tue, 18 Feb 2025 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TUtegg/u"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026B18FDD2
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849414; cv=none; b=oLF24g5aGzobfBpgpMaRqqRNDpbzJiMLN1wBg1CDKhgBmQ1rM6a9HStRgdVTld6g/8PupTT6noISogP+8czQCCLfGdl/H9S49tkM6dpzFEVdO55ZSDRanYUxBNG5ua4AeIGYwd6ZluDaT+iJ6djjvvgV9ukPvG0+q8ch9j0dHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849414; c=relaxed/simple;
	bh=jVExHpaa03FaxdoczbSVNC4uHPSZli4ciXcFyDn8qZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOT5SzA//dSXFq+dDB/8uKKcEuxKKTn9g3+gPR4oCf9wbBNRBT18kfjAhxcLz93Krcj9j+IrXN5IEPxqSsAitKUQs8DzIWodfGiI/VSFznUPsfa96usGfQ5XGOPzNc4XrshOzwXdzkaqldf/suC9Afu6TiQ5dqpUt6pm1eDTKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TUtegg/u; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a49fb92c-417f-4966-8a09-89a6cf448d6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739849409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yH3XtxKNRKBEU5CuuTPLJOyYuzTX8Xhu9It8pdV8/A=;
	b=TUtegg/uJMMtn+IRVauN10015m/B3Mm4+JWhXni7ArnwFyhHLBtQhW7NS4SZJPKr1xthwX
	xrwkrSlRdsI2Zwvysw1+wgaRMFATrbJUbl3+RMhc1tgfwFl+6MSn/OdnkSQDI6cmkQsyVZ
	ESlGgPCf3F2deNZGOLV/LTbJoPM0Jyg=
Date: Tue, 18 Feb 2025 11:29:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>,
 kernel-patches-bot@fb.com
References: <20250217154318.76145-1-leon.hwang@linux.dev>
 <20250217154318.76145-3-leon.hwang@linux.dev>
 <CAADnVQJ3XHgTVVT9=wtNtCNaERpiYnL-c9=kDART_9cejwBSqw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJ3XHgTVVT9=wtNtCNaERpiYnL-c9=kDART_9cejwBSqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 18/2/25 11:01, Alexei Starovoitov wrote:
> On Mon, Feb 17, 2025 at 7:44 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> When a freplace program fails to attach to a target, the error message
>> lacks details, making debugging difficult. This patch enhances error
>> reporting by providing a log that explains why the attachment failed.
> 
> Agree that it lacks details...
> 
>> For example, if a freplace program tries to attach to a static function,
>> the log now includes:
>>
>> libbpf: prog 'new_test_pkt_access': failed to attach to freplace: -EINVAL
>> libbpf: prog 'new_test_pkt_access': attach log: subprog_tail() is not a global function
> 
> ... but adding to uapi for a minor usability improvement...
> not a long term path that is worth taking.
> Especially since freplace is special. Users don't interact with it
> directly. The interaction is typically done through libraries.
> So this extra verbosity won't help users directly, but will
> help people who write libraries. Nice, but no.

What if libbpf allows users to interact with it directly?

As for cilium/ebpf library, it will be able to provide the error message
to users like:

create link: subprog_tail() is not a global function

instead of:

create link: invalid argument

Thanks,
Leon


