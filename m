Return-Path: <bpf+bounces-54689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488FCA7050F
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6856B3A5852
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DA25BAD7;
	Tue, 25 Mar 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpabP0Fy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF125A2DD;
	Tue, 25 Mar 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916458; cv=none; b=UFUYFdsd6Zn+yjoWpjZ7XPPnXg2vuQRuusWRSZzrDjvMAde4XcQiq16C8t1FIeo1C7G41PAfJW/MaUcCDqyD/9fJ3JT5/MnQd5lMYt/lFQn7b/kfCFZr4/YBmwFY7E308bMda+fZhAzbqAsCf3g/wj26KuMUmf44pTQNTuebFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916458; c=relaxed/simple;
	bh=kBSdYtzA9BOEoK+BTjkYPoIMn3M4gtTS4Y3w0W6TsA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPV1dBZ9eG4YN2MPces4zQvMpfcyMzrx86xm/3+k/gkiuNs4HWWlTvFu4Lh8YvExMORxmyg6jMl9Cm69c5X4GtxEC5ynbb5ZVor52Noh4zoVOZKffTNtAQQQWBvCQGkpw08Np2g7rpPsuxTZO8FZ079VJb8RCoUhZjZX8SWEq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpabP0Fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C778C4CEE4;
	Tue, 25 Mar 2025 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916458;
	bh=kBSdYtzA9BOEoK+BTjkYPoIMn3M4gtTS4Y3w0W6TsA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XpabP0FyMI9754psd6hZwF0ek3DOl/IO725jDQA5BgN7MLEuyyiCnSZYyED+qmPa7
	 pulPx2PzAWLlCekAgRiczGkGK4ngc8Y7BeqySZF1FDpZhwobAzuPKfanNP+BSrIPrv
	 YjI1YsVHLcYb00nVG9HNIr8IyQzCkl1yvKj9y1EyCnIgTahWZkHM+Tw/cGGIYb13mu
	 Qiv66lchO+3/SKpFO3a9Eaka9OBV8tWpPWXq+kXDSw1WcKh50yX448ckeyII15HUdg
	 dFE6dnotAIsR2fQ23rv2hvSbD+JZuNa2mCTFaaNn0Tt07ZcDbI3fkQyvCCZfQb3BsZ
	 S3tnsdhkSpX5Q==
Message-ID: <a5cccd3a-ff63-4adc-aec1-ad61a58a4b25@kernel.org>
Date: Tue, 25 Mar 2025 15:27:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on
 linux-next-20250324
To: Tomas Glozar <tglozar@redhat.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com,
 williams@redhat.com, rostedt@goodmis.org
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net>
 <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org>
 <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
 <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> My commits sets BPFTOOL to bpftool since otherwise, the feature check
> would fail, as BPFTOOL wouldn't be defined, since it is not passed to
> the feature detection make call.


Sorry I don't understand the issue, why not simply rename the variable
that you introduced in tools/build/feature/Makefile at the same time, as
well? That should solve it, no? This way you don't have to export it
from the rtla Makefiles. Or am I missing something?


2025-03-25 16:09 UTC+0100 ~ Tomas Glozar <tglozar@redhat.com>
> út 25. 3. 2025 v 15:59 odesílatel Tomas Glozar <tglozar@redhat.com> napsal:
>> Shouldn't the selftests always test the in-tree bpftool instead of the
>> system one? Let's say there is a stray BPFTOOL environmental variable.
>> In that case, the tests will give incorrect, possibly false negative
>> results, if the user is expecting selftests to test what is in the
>> kernel tree. If it is intended to also be able to test with another


I think this was the intent.


>> version of bpftool, we can work around the problem by removing the
>> BPFTOOL definition from tools/scripts/Makefile.include and exporting
>> it from the rtla Makefiles instead, to make sure the feature tests see
>> it. The problem with that is, obviously, that future users of the
>> bpftool feature check would have to do the same, or they would always
>> fail, unless the user sets BPFTOOL as an environment variable
>> themselves.
> 
> Or the selftests and other users could use another variable, like
> BPFTOOL_TEST or BPFTOOL_INTERNAL. Not sure what you BPF folks think
> about that. I believe assuming BPFTOOL refers to the system bpftool
> (just like it does for all the other tools) is quite reasonable.


The variable name needs to change either for rtla + probe, or for all
BPF utilities relying on it, indeed. As far as I can see, this is the
sched_ext and runqslower utilities as well as the selftests for bpf,
sched_ext, and hid. I'd argue that the variable has been in use in the
Makefiles for these tools and selftests for a while, and renaming it
might produce errors for anyone already using it to pass a specfic
version of bpftool to try.


> The reason why I opted to use the system bpftool is that bpftool
> itself has a lot of dependencies


Note: Not that many dependencies, most of them are optional. For
bootstrap bpftool we pass -lelf, -lz, sometimes -lzstd.

Quentin

