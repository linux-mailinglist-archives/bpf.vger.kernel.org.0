Return-Path: <bpf+bounces-79480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79CD3B615
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3316C30208E0
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CF37A4AF;
	Mon, 19 Jan 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLjDWbAZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3229D269;
	Mon, 19 Jan 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848335; cv=none; b=le40CTHAH+MQGJO6ZNEMi4bCWkkvsOSY37eepHYd87IB543mhOXEtn9ata0kwqwOz4zsPbR0T8DqJQe6ch4p9s0a7dCgEcT70JvhuZSSUkDxUDqrFR6DLYp/y3bpkzpYvzumiIDFnZrxKS0/7ogw03VNViGKgMvUTizbHMHTqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848335; c=relaxed/simple;
	bh=jxu3eTAwyA2NAtvN2VNWTO4OGoQkK4jbDsTaUMknlus=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D5DspOPq7NQzc6XaEXaTi/mfLKTGRKhqA054KLJPuVirtnfjy3WbjroXpP7wywgF013C8GLaqvsneziP+kO75Z5ZgJRy2Em1GXN+23SnkgBf6T7MovBBIQezCfvGDBm+s3hR6NO1KxYaHG3lsgaBKmt50D5XGFwJ9mj4Y99OQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLjDWbAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93C6C116C6;
	Mon, 19 Jan 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848335;
	bh=jxu3eTAwyA2NAtvN2VNWTO4OGoQkK4jbDsTaUMknlus=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aLjDWbAZdWltMpcE4zLG1u/iOOMI+ZSMLlNhrJjHget/74Dcqrt8yJ5KfW8SQ2/C/
	 gknsRai814YABrFEGJZPKfyOZ6DB9si2gCySknq4CVl72xp1H6ahTlQ4bptnZNU2xT
	 3XdxO1gkcPr+o/qrL9SNoiYTRID6RKtVlv+nbjbA6v/7VjcItwNT61BdZQclR1+6/O
	 jO41R6ZZSRxD1pHF0tC8RkXrA5i+GEBhMNbpXQuntauAeKK+KSI/Ko58LfWrB60G+e
	 AA3pWRlH+UJ3a3wCNPzPfHkY367j2Dlst7rZ2Qil4kQBF9bAorBk8gZYCZBJFQ1mQx
	 ZQ3eDNygL4EWA==
Content-Type: multipart/mixed; boundary="===============7696574795954163466=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d40ab992df9466e9d09c1132deda3b362de58b3b22f938cf4beae7d6398bf18@mail.kernel.org>
In-Reply-To: <20260119032424.10781-12-piliu@redhat.com>
References: <20260119032424.10781-12-piliu@redhat.com>
Subject: Re: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,linux-arm-kernel@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:34 +0000 (UTC)

--===============7696574795954163466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..922d58abbbd6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1587,6 +1587,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> +	select KEXEC_BPF if DEBUG_INFO_BTF && BPF_SYSCALL
                          ^^^

Should this condition also include KEEP_DECOMPRESSOR?

In kernel/Kconfig.kexec, KEXEC_BPF has:

    depends on DEBUG_INFO_BTF && BPF_SYSCALL && KEEP_DECOMPRESSOR

Since Kconfig's select statement forces a symbol's value without visiting
the dependencies, this select will enable KEXEC_BPF even when
KEEP_DECOMPRESSOR is not set, creating an inconsistent configuration.

KEEP_DECOMPRESSOR defaults to n and nothing selects it, so this appears
to be a missing condition in the select statement.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============7696574795954163466==--

