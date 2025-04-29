Return-Path: <bpf+bounces-56911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129BCAA06AB
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FC116EA7E
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025129DB6C;
	Tue, 29 Apr 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjfyCoz7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F61EEAA
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745917800; cv=none; b=FxmtnF8qPPK4VAU/rNVthmuC8YBuyJ2DODnqmz4UD7mLu8tDx1ul4Dsg8x5RL7L4/e0oeAzc66LJtShjfvw/DDWZ/S2yKNWTOztS8wssef5uVK6Cui82Y+LyNwqTLAHZ4CnRlF8rQsDdG6LEka7ASQHFiX53WmCWkrqZCt0RIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745917800; c=relaxed/simple;
	bh=7q9mNQeZXb9iEnvAilVRy53M8pyLwTJXIc8Q5X1aKWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNLYarJpc6b1NR7ypwFbxBcNMWM6xA6OaA4Y36SS4TMp2Z8p0748go8/wbsMhoczgCGXptKd/4mLnxSZ+Pey3O6Wd7jSdHbPeYZhOhlmIzXatoM7tBWitmFkdwBOAHfQmh8AyH9vj3aaDEycfR1njo3wHJMfLetZZqFtfkb21yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjfyCoz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDAEC4CEE3;
	Tue, 29 Apr 2025 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745917799;
	bh=7q9mNQeZXb9iEnvAilVRy53M8pyLwTJXIc8Q5X1aKWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BjfyCoz7kSO64V4cocoAWeVR6Ocs8wAhPBWNgBw4ec6glETtT05mKYbTSNyZKvB7O
	 4Tcefg4e+4DoyVRxD+FcmCs7Xos36HDGHC7GIb9fWJ4LAfnlepxhAoVV+84EzsH2mA
	 kPd0OA+6l1EMCnA1P5zcI7PFR6eVqGpenixrlgI68AB4MGQmG8mRclSq+D+TnKsGYX
	 ehMOqGGTHAR5LihwK1biGoJBB0a7pLbquZbz3nier8nUxi+zrxvp4fnXx+4b6PoSWc
	 bsq425Vmcc4/283RFu9kwUXxjzxhh4ERoEWxIfGEnGtw0DD73NPEORLorwSoSt0/+L
	 /W2sjxVYJopaA==
Message-ID: <b9aa1802-73bf-4044-84c7-3b98399b1d1b@kernel.org>
Date: Tue, 29 Apr 2025 10:09:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree"
 EINVAL on older kernels
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Kenta Tada <tadakentaso@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>,
 Mahesh Bandewar <maheshb@google.com>, Minh-Anh Nguyen
 <minhanhdn@google.com>, Sagarika Sharma <sharmasagarika@google.com>,
 XuanYao Zhang <xuanyao@google.com>
References: <20250428211536.1651456-1-zhuyifei@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250428211536.1651456-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-04-28 21:15 UTC+0000 ~ YiFei Zhu <zhuyifei@google.com>
> If cgroup_has_attached_progs queries an attach type not supported
> by the running kernel, due to the kernel being older than the bpftool
> build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.
> 
> Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
> attach types"), this EINVAL would be ignored by the function, allowing
> the function to only consider supported attach types. The commit
> changed so that, instead of querying all attach types, only attach
> types from the array `cgroup_attach_types` is queried. The assumption
> is that because these are only cgroup attach types, they should all
> be supported. Unfortunately this assumption may be false when the
> kernel is older than the bpftool build, where the attach types queried
> by bpftool is not yet implemented in the kernel. This would result in
> errors such as:
> 
>   $ bpftool cgroup tree
>   CgroupPath
>   ID       AttachType      AttachFlags     Name
>   Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid argument
> 
> This patch restores the logic of ignoring EINVAL from prior to that patch.
> 
> Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types")
> Reported-by: Sagarika Sharma <sharmasagarika@google.com>
> Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

