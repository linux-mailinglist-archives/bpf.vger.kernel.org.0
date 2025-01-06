Return-Path: <bpf+bounces-47963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B588A0292C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69021885CDC
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70B1581F2;
	Mon,  6 Jan 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mit8vCOV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C98148316;
	Mon,  6 Jan 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176814; cv=none; b=RnOsR5sriyT8dhyzNW/mwvkDyK0Cq7qQle4frbB4I0VfElN5lLWGfEHWME2DJcWtBqz29ubHGgX8/PvFefMZ/jcn8gvscAkk91WpqjwOfIioOWWKLFkmrBwdWh5lpaaFdMZa/ccntX/iOLR3dsB+C3eYrhKP9j50E5RHDpL40Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176814; c=relaxed/simple;
	bh=hEMKm74vg0wq29jtKDyRe2CIO78LELrTIB2/0ImxA0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4THAhIiwq7a8ajX1ClTegOZbGbHCmkzTtaMDuokV7rJHQmItF5d6oW5G2qQudBJlyx5nRhhPwdppENAoW89ZatK11BBDToj0edtHcHRUb0pnGwb55Ib+7jOPGLR8udJOIsQu1CtIIQJ0O+kWyNIF2ejtgNJt1hosdO9hpr7e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mit8vCOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225FAC4CED6;
	Mon,  6 Jan 2025 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736176814;
	bh=hEMKm74vg0wq29jtKDyRe2CIO78LELrTIB2/0ImxA0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mit8vCOV3QMSR5IbFpIFZUFaJRzX3bnkscrAMbnjTa2ccKPbPUPKqXKBXPxk9BOEy
	 TPHfVIBDKrbp/VqUQVc7uR+i7LjdSnWkYYfT2QrseUfzdbY8PwuEREiTDtJwAsJf5o
	 qeVZ699QZDoJSUY+2UyG+g8wgUGep+Ab1WQ3SGeQJGc5XBeJJ9xL7Ke9oJZ76NSPm+
	 bElxJDZNtRFUXetz3xXeMNfoYJxyFRsKSPTLgIzQjWxtLbTKH8Hfj/gEkzzwNwKm1Y
	 /DVmIxzi39VBCGoVTe8r8UnbHVgMiAQVKVNgde4AtLxNVQtNQCPse2Yb6VJ5cfIh4H
	 4vouhG98krurw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B40380A976;
	Mon,  6 Jan 2025 15:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/tests: Add 32 bits only mong conditional jump
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173617683527.3528921.14302782907248949406.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 15:20:35 +0000
References: <609f87a2d84e032c8d9ccb9ba7aebef893698f1e.1736154762.git.christophe.leroy@csgroup.eu>
In-Reply-To: <609f87a2d84e032c8d9ccb9ba7aebef893698f1e.1736154762.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: johan.almbladh@anyfinetworks.com, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  6 Jan 2025 10:15:31 +0100 you wrote:
> Commit f1517eb790f9 ("bpf/tests: Expand branch conversion JIT test")
> introduced "Long conditional jump tests" but due to those tests making
> use of 64 bits DIV and MOD, they don't get jited on powerpc/32,
> leading to the Long conditional jump test being skiped for unrelated
> reason.
> 
> Add 4 new tests that are restricted to 32 bits ALU so that the jump
> tests can also be performed on platforms that do no support 64 bits
> operations.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf/tests: Add 32 bits only mong conditional jump tests
    https://git.kernel.org/bpf/bpf-next/c/2532608530ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



