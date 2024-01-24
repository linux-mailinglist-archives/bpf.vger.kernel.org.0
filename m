Return-Path: <bpf+bounces-20151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E7839D78
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F61C270A7
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BD154B1;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsvuhQE5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E35A35
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054426; cv=none; b=Eb8qyFw0X6kJFc4kvDwCnMMWxfNGw4rDMJEIWVT3Hlvra6ZmhpjRxKxgMfADKbMMFDpMGakCpThPxlVsmzyuX2HZR2VSEq78hgbl1HadnDMkNcGQuPO1ytwKfS2ea6mdWzqzXIgkBWVxbZu6SuQU/gG/W7OgtKO8YvI1fXV+reg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054426; c=relaxed/simple;
	bh=TwnFTgO6y0IWW40B+IsW5QgfUIidSIyjg5dZ+duymTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PylbeeozDhLKy54QgJEc0wnt8yZsSR+L3L+P6t5wbsWoiwvMzh1Sn6m//RYTppsmJamZ2wMa18O0ne79aS6pfTm/hBAfAMM2v8LcPuel0CdYFqfUxqflQ8s+xQLbahN+/TGQqwMEt3gVLQBlTi7czgaTa32QZARwHx95ntK2bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsvuhQE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B7DC433C7;
	Wed, 24 Jan 2024 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706054426;
	bh=TwnFTgO6y0IWW40B+IsW5QgfUIidSIyjg5dZ+duymTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsvuhQE5m8HrTEFgwVjtM8QFLXUsUvw8FVCe44th9+t8srwISQ/UTZAp8MowC5O4a
	 rlK+DDoDnEFh/o996hDTaoyjiWIhVxcvTnUliDsE9w53qdoWrjGWQPo62hOkigKAZ3
	 T4LzWdl7VX3KgFEqIL4snJD66zWdmTV6sOuKRrMGoDhNUJAfThO6VDkb3TTe4jQbSH
	 RrDv4+AnMdELUBk3AeST/W+GzKJMfsfF7IhxqpRe5W6O1v2nVuk3g/+ei5iIHBt3PW
	 1i2M8ahnMGIHYgXygysACjuCCeUzYjqT2nQDz30QYMrHonI6bagYlFz7vJWsPVZZ7t
	 CLqDzb1eqLRpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBF87DFF760;
	Wed, 24 Jan 2024 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: use r constraint instead of p constraint in selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170605442596.2408.8320587194881741186.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 00:00:25 +0000
References: <20240123181309.19853-1-jose.marchesi@oracle.com>
In-Reply-To: <20240123181309.19853-1-jose.marchesi@oracle.com>
To: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 23 Jan 2024 19:13:09 +0100 you wrote:
> Some of the BPF selftests use the "p" constraint in inline assembly
> snippets, for input operands for MOV (rN = rM) instructions.
> 
> This is mainly done via the __imm_ptr macro defined in
> tools/testing/selftests/bpf/progs/bpf_misc.h:
> 
>   #define __imm_ptr(name) [name]"p"(&name)
> 
> [...]

Here is the summary with links:
  - bpf: use r constraint instead of p constraint in selftests
    https://git.kernel.org/bpf/bpf-next/c/bbc094b30526

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



