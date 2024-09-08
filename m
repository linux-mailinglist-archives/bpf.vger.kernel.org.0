Return-Path: <bpf+bounces-39200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BA9707B3
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 15:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846E61C20FE5
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A9166F0F;
	Sun,  8 Sep 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrWxzYhI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D9166F03
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725801059; cv=none; b=FRpPRJjE0qnOGpSXEw8vzanTHUH0o4MTmJf3SiifwUus1wky17YRYu5kp9fL/B2T9fT/1bJEmqOrfguZ8ahGqDwZw8HZXA+KZK4X0hQmny9yP1S62yaDHBTpW15DvfVX3fCNk/WfiqUP6sxRRbvrV3xsb8/h496BDKObPoVBPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725801059; c=relaxed/simple;
	bh=ClQHgLl08GO0wEsncxoNvrRCt8I4NxKUSd02bjrpk80=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8BiHP0xQHU80hz3xl69OOQjuhVp06XC2VYJsjv/LbIJVpVUhnIMAlmupUQ83Ma1EUnfNqafXoLmTaW4SKhBATfbJY0tZ0xJQK1+E2HLEhjNAkys/GuGW9yPDjkeWJSqsOIc+1iJyaUA4zjAVqpzgmB1d+KK8vGBaYpcbGLDNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrWxzYhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4759DC4CEC3;
	Sun,  8 Sep 2024 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725801058;
	bh=ClQHgLl08GO0wEsncxoNvrRCt8I4NxKUSd02bjrpk80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrWxzYhIemP+snTm+2pkJRFzdFnZqJ3ITEB57Y7JJTCwFhwQQe63FOz8I/OjdFid5
	 YDv00bTcJjN4xYetsAaGpt6bYfKhlZqUWjkMgYqZVrFBfNcGzDuE5qX28qH/wCX55n
	 mSo0aC1dKoMyEWa6kYMKVlM+3++pzGuUu/oCQXKMGiQYutCsGERd/twjxXRHBrXKUE
	 FUIIb0zfGn7oHTW0UTrkRAM4pFirKWwweUAyuFsr+Lz3lJo9FmBWRI19//3rJs0/Zg
	 VqCmkJ02uxuJnlz5wueKHt7x13hVZWDpBkpDe1rC6BUm2lt6Xk4s0aAVOBjV9AGwmx
	 bHHY9fF6MLYsg==
Date: Sun, 8 Sep 2024 22:10:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Abhishek Dubey <adubey@linux.ibm.com>,
 naveen@kernel.org, hbathini@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, mhiramat@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 RESEND] powerpc: Replace kretprobe code with rethook
 on powerpc
Message-Id: <20240908221053.ad2ed73bf42db9273aac419c@kernel.org>
In-Reply-To: <172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au>
References: <20240830113131.7597-1-adubey@linux.ibm.com>
	<172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Sep 2024 21:52:52 +1000
Michael Ellerman <patch-notifications@ellerman.id.au> wrote:

> On Fri, 30 Aug 2024 07:31:31 -0400, Abhishek Dubey wrote:
> > This is an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> > Replace kretprobe with rethook on x86") to powerpc.
> > 
> > Rethook follows the existing kretprobe implementation, but separates
> > it from kprobes so that it can be used by fprobe (ftrace-based
> > function entry/exit probes). As such, this patch also enables fprobe
> > to work on powerpc. The only other change compared to the existing
> > kretprobe implementation is doing the return address fixup in
> > arch_rethook_fixup_return().
> > 
> > [...]
> 
> Applied to powerpc/next.
> 
> [1/1] powerpc: Replace kretprobe code with rethook on powerpc
>       https://git.kernel.org/powerpc/c/19f1bc3fb55452739dd3d56cfd06c29ecdbe3e9f

Thanks, and sorry for late reply, but I don't have any objection.

> 
> cheers


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

