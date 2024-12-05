Return-Path: <bpf+bounces-46150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08BC9E532E
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922A01881507
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED511D9A7D;
	Thu,  5 Dec 2024 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhViAYFF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7A1946B3;
	Thu,  5 Dec 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396291; cv=none; b=bhOB48C8NHjNWp+pA0QKIYzVXiTSkhZbEKAIftaJh3EQBA/NxT520j8Z+uM8iPdyyW7QT/MzTK+ctb8Mtv1f3HpfXDNYrMI/1ccImVXDq/bsonwTWngU//+ibafQ130oGlkrBgFBTXh1s+22qjFVz8TjBelJzMhRpqSG6xgb3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396291; c=relaxed/simple;
	bh=MVmQMcPvNEaVVYwIF1i3tIOOdUpAF8VYZi+0spu0B2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAs7ovnLBNxC6/AcXcPATo/b5dXAYb25mSzqkAxgBSwjTq3OEU3aMlQ1sTkLMdJTY03USyNdi70rdiIAvDhWRNMaidSdC2RASxJkO810t958sXQhrLY0kIUrUETLPkvGObzXqJEH+qKlb0ZADv+fc58stxJP7H5hkavIoUb0djw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhViAYFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C6C4CED1;
	Thu,  5 Dec 2024 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396290;
	bh=MVmQMcPvNEaVVYwIF1i3tIOOdUpAF8VYZi+0spu0B2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZhViAYFFrurwPt5gYzwq6w7bquoGfK70T16wGPwmxUIdYzMYrg8k2bGJ0+njHoCaA
	 HD1aDMRNLMkpBVQ57R/O8lZ/plVaA++m3qyIABf2a8jrCuswrICkzUSf5lps2GD/lr
	 yall6iGoxLUO7NdoliE7Z8VZdPQJgAbSfvEICA/WGBN5J6kiH/tk2aRTCkL9YgLUa0
	 BEay8N/P2GohhGVurY9fZux7VBqJK4D5l61eZf4Xbe511cY8p/bwMlDL8xOV5cvRTL
	 UuWG+9PwYyzS1LyIjhyOokAYPh30Dmqv7cGb8PDe564pu2cruDaIfOnQusk9G/XM/C
	 FPVpN7a3lUUoQ==
Message-ID: <2d092d36-4c51-4312-be31-747674c6397f@kernel.org>
Date: Thu, 5 Dec 2024 10:58:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix failure with static linkage
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mahe Tardy <mahe.tardy@gmail.com>
References: <20241204213059.2792453-1-leo.yan@arm.com>
 <Z1DLYCha0-o1RWkF@google.com>
 <bf5da4d3-c317-4616-ac68-0d49bb5815c2@kernel.org>
 <Z1DW1aJ4rYlMI6S1@google.com>
 <d4d5e80d-1a95-4ef7-a83f-1303563a91eb@kernel.org>
 <20241205102310.GA2899345@e132581.arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241205102310.GA2899345@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-05 10:23 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> On Wed, Dec 04, 2024 at 10:55:32PM +0000, Quentin Monnet wrote:
> 
> [...]
> 
>>>>> I was about to report exactly the same. :)
>>>>
>>>> Thank you both. This has been reported before [0] but I didn't find the
>>>> time to look into a proper fix.
>>>>
>>>> The tricky part is that static linkage works well without libzstd for
>>>> older versions of elfutils [1], but newer versions now require this
>>>> library. Which means that we don't want to link against libzstd
>>>> unconditionally, or users trying to build bpftool may have to install
>>>> unnecessary dependencies. Instead we should add a new probe under
>>>> tools/build/feature (Note that we already have several combinations in
>>>> there, libbfd, libbfd-liberty, libbfd-liberty-z, and I'm not sure what's
>>>> the best approach in terms of new combinations).
>>>
>>> I think you can use pkg-config if available.
>>>
>>>   $ pkg-config --static --libs libelf
>>>   -lelf -lz -lzstd -pthread
>>
>> That's another dependency that I'd like to avoid if I can :)
> 
> Seems to me, pkg-config is the right tool for doing such kind thing -
> not only it is nature for local building, it is also friendly for build
> system (e.g. buildroot, OpenEmbedded / Yocto).  Though I have no deep
> knowledge for building.


pkg-config would be nice but is not always installed by default. We've
been handling build options without it so far, if we can fix the current
issue without struggling too much with probes I'd just as well avoid
adding a build dependency.


> I am a bit confused why this issue is related to build features libbfd,
> libbfd-liberty, libbfd-liberty-z.  Should not the issue is related to
> libelf?  build/feature has several libelf checking, maybe we can add new
> one libelf-zstd?


Apologies, I was the one getting confused. You're correct, this affects
libelf and not libbfd, and yes libelf-zstd is likely the way to go.

Thank you,
Quentin


