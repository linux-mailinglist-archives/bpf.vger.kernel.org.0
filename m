Return-Path: <bpf+bounces-39069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C196E440
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45311C23B7E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA981A4B83;
	Thu,  5 Sep 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmJKvd4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7216BE15;
	Thu,  5 Sep 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568837; cv=none; b=BBhrdNfWbsTEvBr+/U82j+JCC5d4qHXGiwpdDxSU77ypDC+JQ2CowjUb9IXBdrRr6r82fQ08FEwwnEX3xlTG0cPwsqB2RpnAU540SELEy62Keek9jTVqXVfDg025RFf/UJH7VR1kXnXpLjFD8CPFQ1ZSgrgtY0ncjbeT9huyCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568837; c=relaxed/simple;
	bh=zOrrtfFvivuHEZdzB17fOmVuewChT53qRtKV17FWskQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HexlQhALInp4RME+YspF7bm3pkUG4rrxK3cYe3R+UEv9IsZdYok0DK6VPwzimdhWL/JaWFt2DgPxQuN1mHhTADUin24i88nvr7OIzZRm84Hn+infFnKJ2sal4fo2j6ulJOGmpHOYPgvmkQIBs2Y8gw1oSbywIANgVe50w3u2vX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmJKvd4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA4C4CEC3;
	Thu,  5 Sep 2024 20:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725568836;
	bh=zOrrtfFvivuHEZdzB17fOmVuewChT53qRtKV17FWskQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmJKvd4j5IIQaPhL3Ftrjx9CBm1GwhhLnzPaQuFM9ogupXvBJXt84pQsHp59UEObV
	 kZRyA4MwwFvRND96NO8agahkGI4wCfplTaIMAOKfHFzJ5Eaq46YQijGAokYzBpmFCS
	 J5VRd/aePAW1pDcykshOVSf+sBybU8xWMKAN8zgmsIAbYMOI51KTFDCmlBxgPBQbs9
	 FNdWEIz/wz9SrKDE0oCe9/pp48caqdAdE3T4oStS/kAzvuYB6f/QSnhEp6ZfDHNdKd
	 gomS2OR0gEU+3uA5g93WuFCRWBBSBdL4RlC8s7o7JNx4jqmzXqoxmTkNV0iEXGX9J5
	 SuHJdrJnnfRAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 727193806654;
	Thu,  5 Sep 2024 20:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use type_may_be_null() helper for
 nullable-param check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172556883729.1838815.11480197558494188207.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 20:40:37 +0000
References: <20240905055233.70203-1-shung-hsi.yu@suse.com>
In-Reply-To: <20240905055233.70203-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: eddyz87@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 void@manifault.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Sep 2024 13:52:32 +0800 you wrote:
> Commit 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for
> test runs") does bitwise AND between reg_type and PTR_MAYBE_NULL, which
> is correct, but due to type difference the compiler complains:
> 
>   net/bpf/bpf_dummy_struct_ops.c:118:31: warning: bitwise operation between different enumeration types ('const enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
>     118 |                 if (info && (info->reg_type & PTR_MAYBE_NULL))
>         |                              ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use type_may_be_null() helper for nullable-param check
    https://git.kernel.org/bpf/bpf-next/c/1ae497c78f01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



