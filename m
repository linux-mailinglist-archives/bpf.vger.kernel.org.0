Return-Path: <bpf+bounces-46558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CF9EBAB8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A29188820C
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA177226872;
	Tue, 10 Dec 2024 20:20:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED986350;
	Tue, 10 Dec 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862005; cv=none; b=RbN7vPECj7yWfO6I0Xrf5kMs4vBMl8JTqWkCFAe74dN3JDnZNOUOLck6u9QlFd1lnHowoPukVrCnEpjukXmJR10vcUZ3ufrdHGb/COqwE7dLb9gWFLOFaEP0jwYCAu5uqq3qvGsQyqBuDQ4ijWwFnISzYsy+YCOnFqC9AhcNxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862005; c=relaxed/simple;
	bh=QuvlPEfuI08Zfl7OY+g6c4LJQzeO/J17GsTwpq4H5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2+1b9QHJTpwou7aNPQhFjpyPuM/1LaMphAzjWqZW+BlUal4cXba+SgP2WXhTjlJiMxBmTcsCbtBb8/C8HJdxmaRPBwIpfybuu8R/aKbzlekIpEoDET/S6ckldBrGthwO+2HnecL5LGljfpUHTwOmvqH9GY6yeYP70u5LBFCPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E7C1063;
	Tue, 10 Dec 2024 12:20:30 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6223F5A1;
	Tue, 10 Dec 2024 12:20:01 -0800 (PST)
Date: Tue, 10 Dec 2024 20:19:59 +0000
From: Leo Yan <leo.yan@arm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
Message-ID: <20241210201959.GA144421@e132581.arm.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
 <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
 <CAEf4BzY-WBs6HmrQBUtq-wCWSUUFruvvw9Fuheb3TfCmqbpj8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY-WBs6HmrQBUtq-wCWSUUFruvvw9Fuheb3TfCmqbpj8A@mail.gmail.com>

Hi Andrii,

On Tue, Dec 10, 2024 at 10:26:22AM -0800, Andrii Nakryiko wrote:

[...]

> > The tricky part is that static linkage works well without libzstd for
> > older versions of elfutils [1], but newer versions now require this
> > library. Which means that we don't want to link against libzstd
> > unconditionally, or users trying to build bpftool may have to install
> > unnecessary dependencies. Instead we should add a new probe under
> > tools/build/feature (Note that we already have several combinations in
> > there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
> > the best approach in terms of new combinations).
> >
> 
> So what's the conclusion here? Do we apply this as a fix, or someone
> needs to add more feature probing?

I am working on a new build feature.  Based on that, it will refine for
perf build and bpftool build.  Once get ready, I will send out for
review.

Thanks,
Leo

