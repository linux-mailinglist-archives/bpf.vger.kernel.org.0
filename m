Return-Path: <bpf+bounces-33193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4335D9198E6
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2727283B6A
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D8191496;
	Wed, 26 Jun 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOymU0XN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C71332A1
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433231; cv=none; b=i4/FqJIwX0aIxZHR/yHOJJxlDiHM5JhhfyO1QV0BboTuOjplXz9QuyUIUGsZNsD/UDG8GPEnGHr1qB5gJPQ2tNiM9IpVzASinhV1xV90j3Zq3NikwuamAVNBCZynJ2NV9SQPGOEciGFpUZ9tz+AMu3yc81+JWSzxKMs3QgYVKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433231; c=relaxed/simple;
	bh=fM9dtw5d93xkc4X94bE8v50NGehBULulWwuX409U8kE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xml1lbwOtrwiLNZoY+BOLzTeUnCfwQ9zBS8Tu+2GdScq0ndUPEFfYNb6vzw2WbUhTeXgK1QjFRIdMObwpBqPNE4CMW1S+D871qKKBqo6DQ+gBb7hiGVC2+lnbS2O2xq3Ho3BGwADsnm7MdEI4/ZivQBJA8B6MdgZVEmYh+JLXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOymU0XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D056C32786;
	Wed, 26 Jun 2024 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719433230;
	bh=fM9dtw5d93xkc4X94bE8v50NGehBULulWwuX409U8kE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOymU0XNbhDr2m+Xir4UTCg8bhQLXcPEiOKBhWAJm097TQk6bFtMIluaDIt++VoYn
	 OWDjNbIailzX56I1okXRDCVn/PDMpYtj24eSPWRAgzDCaIP7UJFoguL6aQiHwY9tGR
	 riZSBytwklDyOUbZynTQ7uCtLfgunaIp3C0UAFOnhAjmwRsepCg1CGzMeT52438IdX
	 FAoXNn4oCG8ZLfhsjLFPWfFKsyBATHNOXrhS8VDmikwHBJdUoNxAYgeNcIX2T5g2JJ
	 5d4uTgNpIyo734HvCSL4c7vZ5N/9rb6DLCzgjUXPB+/vgiAnjId0fmn53HYKdQxB/Z
	 gZzMQGlc7ds3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C131C43446;
	Wed, 26 Jun 2024 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 1/2] bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171943323030.30235.3618047287559189730.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:20:30 +0000
References: <20240625062857.92760-1-mattbobrowski@google.com>
In-Reply-To: <20240625062857.92760-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 25 Jun 2024 06:28:56 +0000 you wrote:
> Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> a global function as an argument. The adverse effects of this is that
> BPF helpers can continue to make use of this modified
> CONST_PTR_TO_DYNPTR from within the context of the global function,
> which can unintentionally result in out-of-bounds memory accesses and
> therefore compromise overall system stability i.e.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
    https://git.kernel.org/bpf/bpf-next/c/ec2b9a5e11e5
  - [v2,bpf,2/2] bpf: add new negative selftests to cover missing check_func_arg_reg_off() and reg->type check
    https://git.kernel.org/bpf/bpf-next/c/aa293983d202

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



