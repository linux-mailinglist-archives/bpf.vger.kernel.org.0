Return-Path: <bpf+bounces-64914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1FB185CC
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BDFA87C1A
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4528CF64;
	Fri,  1 Aug 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUalUtem"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7228C87E;
	Fri,  1 Aug 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065794; cv=none; b=JCji3udxtHARPM6gAGhCJ7ypG84YEyWsxp6DECKPHnGUQo2+pu4lPuV5EUjrlsqcsfhgAHNZpolT1ApVRcAA0xnY0dkY8YZ8RpV8JKQ6bTG2yVHUub6b6lC9w/oYqD3K7t2VtXPd9PlW5S84UG25bDbsHfKlAsmLxbCioUkIiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065794; c=relaxed/simple;
	bh=IxVnmA/66Ivgx/vn2+/QIYuiaXylBMGDjN6i0YCSXxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i9v87FwaMhcWQupmBFWp9w5qyWCJjOSVFCPjRV7IXv5ncDW6NL0cSiG8kYInQcRsuB+pyBm9XEpJHsGMGmemN7efPx5P8nDs9Ef6g0TIUNEEaVTSYK6+QXWZGdEycAQyX902YX78v4E5MxYm3nODOMPmM4WtgXB5nQWROhe58sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUalUtem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D4C4CEE7;
	Fri,  1 Aug 2025 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754065794;
	bh=IxVnmA/66Ivgx/vn2+/QIYuiaXylBMGDjN6i0YCSXxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HUalUtemtv0yPC4/vv/LH2sZllOmkSGA2IwkjeF/DqVvoLByFc70JD0iDJ5Gi+fMf
	 JzmSHrevNrQVL1JnY1W3fJ7R67cjwXiAq0wBHN7tf3pil5j3KjL60+jGoIkIV1Ij/H
	 /srwvjMytHNkjj9t51BrfFoR7pUJLbNy3TdErZbkqLfgXUY+Er3FA/ZbtQ1nc4SeVv
	 AvvssTYezUJ756C0kyfHGWWebuwbWvZ/ree9rGZyHK9mUoLbEo4iORc/qXgyVRcl07
	 ZPRJ2jAPkt6YClXWCPG98UZANV+WGV7f8Jn/QwRUELBSS9CNrCOlWaIY2Sik+QFDL2
	 PnzwJmNJ8w5mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB194383BF63;
	Fri,  1 Aug 2025 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/4] bpf: Check flow_dissector ctx accesses are
 aligned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175406580976.3993724.623782984870385125.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 16:30:09 +0000
References: 
 <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 ppenkov@google.com, fw@strlen.de

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 1 Aug 2025 11:47:23 +0200 you wrote:
> flow_dissector_is_valid_access doesn't check that the context access is
> aligned. As a consequence, an unaligned access within one of the exposed
> field is considered valid and later rejected by
> flow_dissector_convert_ctx_access when we try to convert it.
> 
> The later rejection is problematic because it's reported as a verifier
> bug with a kernel warning and doesn't point to the right instruction in
> verifier logs.
> 
> [...]

Here is the summary with links:
  - [bpf,1/4] bpf: Check flow_dissector ctx accesses are aligned
    https://git.kernel.org/bpf/bpf/c/ead3d7b2b6af
  - [bpf,2/4] bpf: Check netfilter ctx accesses are aligned
    https://git.kernel.org/bpf/bpf/c/9e6448f7b1ef
  - [bpf,3/4] bpf: Improve ctx access verifier error message
    https://git.kernel.org/bpf/bpf/c/f914876eec9e
  - [bpf,4/4] selftests/bpf: Test for unaligned flow_dissector ctx access
    https://git.kernel.org/bpf/bpf/c/3fea6d121b56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



