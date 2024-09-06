Return-Path: <bpf+bounces-39120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5496F3C0
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385B4B2671D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFC1CCB57;
	Fri,  6 Sep 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VP/NAXLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50111CBE89
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623734; cv=none; b=XgMZDFhMepDlcktee5yCniY+X35GKd1vEAaXpwhCOxLaGQSXi2pv4etoCKi/uPoJW+p1jfQc1FbQxgDhngxZ9juHh0hII7sRbdJMY+ouVA8MOyyyzzWASpjc+a08rXQLM/OIEo5zEk3vWyYJ9FZjQWGUaBaMfhlt55He1TezLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623734; c=relaxed/simple;
	bh=Fvu9r01oFMF84lbgsdSxY18MARRItmras5jBF9BXqMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o4ZDD+FXg/7hoa1AHID5aIUnDagprfBorat9sz0F9FDuvIaNlFk+1m7NNh68HkqOAxgtJn4vPKy/1p0PBimEbw2AK+OIKRTLU1CQ1eWPVDViHphhDJotnCN7Sj/5GMrIF4Ot2cuOp1UhxVYG3GSrqqU9DJj3IsBESFaWnSYI3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VP/NAXLL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725623729;
	bh=obi7msVGRlzoEz1W/jzDgo3xBNxggqpVSzexlh/yX3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VP/NAXLL0mtBCAWdRfKmUH59hbI0XQ5671PkHvQLfDTtWGcoeBpUZkW8e9dSfJQyy
	 RjvV4yICu1kdthGqFFfhhw1omASPsfivaHmVS4m5JY3l8z9Rx6fpZxb25MOjfwgvyS
	 dP8YM5ZBew5Bz8egnOGqV4fczan7fXvjczp2djiTvuCZhcIHXYnIywqAq0tPJqGBE6
	 XEw9cT+krVH+3inXLYUKaxgNkIgQaQkFB53LAMSAXXeN1Cgi1pXKENN4Ldz0hRQpkG
	 iEnB8SzRn8mtuAG2JCqzMS5r/hzO7x6y9xc2vnvZU+HEPlP9GV7hzHCI+M78dn/qSq
	 tHrX6yAQqM/WQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0ZRj3N1Vz4wnw;
	Fri,  6 Sep 2024 21:55:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Abhishek Dubey <adubey@linux.ibm.com>
Cc: naveen@kernel.org, hbathini@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, mhiramat@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20240830113131.7597-1-adubey@linux.ibm.com>
References: <20240830113131.7597-1-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 RESEND] powerpc: Replace kretprobe code with rethook on powerpc
Message-Id: <172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au>
Date: Fri, 06 Sep 2024 21:52:52 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 07:31:31 -0400, Abhishek Dubey wrote:
> This is an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86") to powerpc.
> 
> Rethook follows the existing kretprobe implementation, but separates
> it from kprobes so that it can be used by fprobe (ftrace-based
> function entry/exit probes). As such, this patch also enables fprobe
> to work on powerpc. The only other change compared to the existing
> kretprobe implementation is doing the return address fixup in
> arch_rethook_fixup_return().
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Replace kretprobe code with rethook on powerpc
      https://git.kernel.org/powerpc/c/19f1bc3fb55452739dd3d56cfd06c29ecdbe3e9f

cheers

