Return-Path: <bpf+bounces-43898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1B9BBA5C
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B033E1C204F3
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED01C07D3;
	Mon,  4 Nov 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsndbPlX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077D98286A
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737895; cv=none; b=lxd8TjvTL4vUjzfxaWEWMCC9ZG6lX9d964/75/ukd6/8QENMoVBSgbdySYk2CVdgTF5iZyREWLllj1uuMAolXbO+DscN2nFH/cNiXB+azbsp9K5Gb+aGVDqurMYljX799045nqr/POMa9Ao10/o1i8t98PVHTx7x731PTkG/1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737895; c=relaxed/simple;
	bh=yb8Jj2RBrpWDSM+rfoFSsasiNGMe2lUxrdXE7bT0ymE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJ7VL9ECy3OMk1Bo+uoY3tuaILtsU5PUtPB1T/lCW+i2Nz3g3RXh+CvXHal6VSq40sPDBRpzOuzC6/sRcqMpNWfyZ/eyAf3bkOkOnIHk4jAamUt/OUVj+o94TGNPYiY2CMT07Qp539S47xUzy0/qii66SVqNT9KtZbPto57RoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsndbPlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D62C4CECE;
	Mon,  4 Nov 2024 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737894;
	bh=yb8Jj2RBrpWDSM+rfoFSsasiNGMe2lUxrdXE7bT0ymE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QsndbPlXu4U/4ny79GbiV9De7TNyTi4khgmmZy5zGrtv6ZcJZzeZLFGF/mSMLrAm9
	 TImjcjpTsolyhYrBGYVGsn/MnXWtcOFSe10JUK5X93whMuczmZHiFjC+GAFRMmrMdG
	 6biTq4tF+w48RA4qN3NPd4r7uIsXZ96cPvRi3mWVEBvOXOev4QIiKJjEEhmi4TSuoO
	 MDbl7Yk4ZhGLRnB0XkoLfnb1/fIFAbE+oTQBysi/U8VRlSIHajBEezFPFNPSr/DgI6
	 4tcqz+a3CpgXcOK+DPtD6vXo5wowIQq8fuClIhPai81dhT1yEVe4m0BAOBpNN3w1SS
	 /4LCDcgIiyZUg==
Message-ID: <6dc74cb9-2a99-4fa7-a731-802852770d4d@kernel.org>
Date: Mon, 4 Nov 2024 17:31:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: remove test_skb_cgroup_id.sh
 from TEST_PROGS
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, bjorn@kernel.org,
 Ihor Solodrai <ihor.solodrai@pm.me>, Geliang Tang <geliang@kernel.org>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
 <172715882926.3893391.17604218740773697669.git-patchwork-notify@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <172715882926.3893391.17604218740773697669.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrii,

(+cc Geliang who reported me the issue)

On 24/09/2024 08:20, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
> 
> On Mon, 16 Sep 2024 19:59:22 +0000 you wrote:
>> test_skb_cgroup_id.sh was deleted in
>> https://git.kernel.org/bpf/bpf-next/c/f957c230e173
>>
>> It has to be removed from TEST_PROGS variable in
>> tools/testing/selftests/bpf/Makefile, otherwise install target fails.
>>
>> Link:
>> https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=@pm.me/

It looks like the two patches here are fixing issues that are on v6.12
as well: I'm on top of net-next, and I can see these issues. They are
fixed by these two patches that can be applied without conflicts.

In these patches, we can find references to the commits that introduced
the issues:

- Patch 1: f957c230e173 ("selftests/bpf: convert test_skb_cgroup_id_user
to test_progs")

- Patch 2: 844f7315e77a ("selftests/bpf: Use auto-dependencies for test
objects")

The two commits are in v6.12-rc1. Could it eventually be possible to
apply these two patches (with Fixes tags?) in the 'bpf' tree instead of
the 'bpf-next' one please?

> Here is the summary with links:
>   - [bpf-next,1/2] selftests/bpf: remove test_skb_cgroup_id.sh from TEST_PROGS
>     https://git.kernel.org/bpf/bpf-next/c/e4c139a63aff

Just in case, it looks like the history has been rewritten. The last ref
seems to be:

  d002b922c4d5 ("selftests/bpf: Remove test_skb_cgroup_id.sh from
TEST_PROGS")

>   - [bpf-next,2/2] selftests/bpf: set vpath in Makefile to search for skels
>     https://git.kernel.org/bpf/bpf-next/c/494c3a797257

... and:

  fd4a0e67838c ("selftests/bpf: Set vpath in Makefile to search for skels")

Thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


