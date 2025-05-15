Return-Path: <bpf+bounces-58266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA8AB7AC1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 02:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6245817816B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C41A316A;
	Thu, 15 May 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnJGgJGb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B261FCE
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747270192; cv=none; b=FRUDV+pYFXRMW4ZPKQ9VPKUb+SgvpcOYhmfZfVdEgRAPIsC9PlBztgW1yt8Oc8BncVlFVknldYEKHl+zyB++yEX+NWhexmKiKSiXlOjH7eAda6SHHr26BuwIR8gBafOWlcJ+hAd/eLatXWdvqSR00LHaAaEDgIe7f3CF8FN5xLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747270192; c=relaxed/simple;
	bh=Mxas0JAoF86TWYzcFpThDrKjXVuPDdIClM4MyigyF30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=af/Y2XxoUh7W5opvfM04vvxd6suZ/NSvKoTOaIjEzDqIG+f+ayvBzcRkfmDMuitHeOVsIx3OnOmRubz74FguzIilSeQ+CHyoQsLBsduOH4D9rHuUX7kyPNywjhn//cmDGZG33L0H4bnZ1luxzon+kGvxfddfQYl0ADc/7e4WHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnJGgJGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7AFC4CEE3;
	Thu, 15 May 2025 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747270191;
	bh=Mxas0JAoF86TWYzcFpThDrKjXVuPDdIClM4MyigyF30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mnJGgJGbES4jPIibFGFN9B1lAfZL3mcUm1qOuTQhm5KTeCCncGPDPKSC21EslrwVn
	 2OVFe1JAUBB+KoMtXPg4TNPxQZhbI5KEUcKFCZqmjiq9p2/V8PwkeA1yVJLBHIyM5M
	 PPe8oD4igI02Oeervm6VIGD8tWoNt4imGFwyEY8ApizhOXPgaXBYXCaOjntlOeQ6Nq
	 ruKI0q/dFG38+Y+4lR96lFz9SRklCSqzpBEqadVDswDQdF1zFPqC8IlUe1yGeZaLGF
	 ZQSjXa+hvu/ZQj0Pr6r+Som4k7PDRBk2DZwfkaCnsC/oJDdmBtseUqn8/JdTpcpw3h
	 K55EHxjszHJMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB008380AA66;
	Thu, 15 May 2025 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] s390/bpf: Store backchain even for leaf progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174727022877.2561986.13158166975965047388.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 00:50:28 +0000
References: <20250512122717.54878-1-iii@linux.ibm.com>
In-Reply-To: <20250512122717.54878-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 May 2025 14:26:15 +0200 you wrote:
> Currently a crash in a leaf prog (caused by a bug) produces the
> following call trace:
> 
>      [<000003ff600ebf00>] bpf_prog_6df0139e1fbf2789_fentry+0x20/0x78
>      [<0000000000000000>] 0x0
> 
> This is because leaf progs do not store backchain. Fix by making all
> progs do it. This is what GCC and Clang-generated code does as well.
> Now the call trace looks like this:
> 
> [...]

Here is the summary with links:
  - [bpf-next] s390/bpf: Store backchain even for leaf progs
    https://git.kernel.org/bpf/bpf-next/c/5f55f2168432

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



