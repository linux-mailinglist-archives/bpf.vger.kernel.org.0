Return-Path: <bpf+bounces-22513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6890985FEC9
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87A728AB64
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20880154C12;
	Thu, 22 Feb 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HASjmVFi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F486154C0A
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621828; cv=none; b=QiNvKtAZNw92growieXucOmyu9A9lL1EHmtw+MKn+oyHEG4y5VjimUO5IlwuWtI+YSBVefE5BDcs+wYscco5M3NA0nYovwebd4iyAbSoOdcdmMjdpPsSVh/4bBRUbn7JArP6v76+mlGwdmr06auXfrhlLB24ql0UgwD0FkXJJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621828; c=relaxed/simple;
	bh=Rhwhz7jsGNO0oJ1Se2MLogzAyHEVft051Mtb2GDNp2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ou6NNYzXCBoQy6N1hSjk8jrOLmcibzDtZAh76drqFdkPx2UKQTrb6o7/EvPZ2Ryf+YSJecf8zFJ9+Tndps9eBsdXpLTcP7Dcpvx2TxwzYVl9jjpJXMxnpVw8hXD+T5hvHRshztB1lHfBFXXbncMOzR8j30Hebuchrn5bbKAubSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HASjmVFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2092CC433B2;
	Thu, 22 Feb 2024 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708621828;
	bh=Rhwhz7jsGNO0oJ1Se2MLogzAyHEVft051Mtb2GDNp2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HASjmVFiSDquQW7dkSwpgbeK1ZF/WpoESj/SXxY55kjkfY9HrLwacrvwqoq3F5XOK
	 U59JFjPxo8k/s1pRZYOW6tueY8KOhns9AP8HA/6sc8DT1HTo4qODpkNJbkPlH9qgge
	 y2p8NyNs5SzGvO73N66GnJS0YAbk6zyV3ruiRJ/9k0H2CEBmMQKPrh0i8Zsk2tQvhs
	 bizCoSkRwt6OGqGFnoo0Xp4Pn1Gz8xvtutiW27Z6ED9sIPMFvciu32vdmO/+RiS6tA
	 ZjdRyUxihfyi4LB8qYJ7CI+Oq+072kKTyneUmuYg7lcCgiQtUbqug8tw2eKI1EV+Ym
	 JhRNITYTcZitA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C870C04E32;
	Thu, 22 Feb 2024 17:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Fix typos in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170862182804.10220.17463455691219845000.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 17:10:28 +0000
References: <20240221173535.16601-1-dthaler1968@gmail.com>
In-Reply-To: <20240221173535.16601-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Feb 2024 09:35:35 -0800 you wrote:
> * "BPF ADD" should be "BPF_ADD".
> * "src" should be "src_reg" in several places.  The latter is the field name
>   in the instruction.  The former refers to the value of the register, or the
>   immediate.
> * Add '' around field names in one sentence, for consistency with the rest
>   of the document.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: Fix typos in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/c1bb68f6b2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



