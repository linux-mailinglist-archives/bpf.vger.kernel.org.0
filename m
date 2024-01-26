Return-Path: <bpf+bounces-20416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A273783E0E4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580481F258EE
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D85200A6;
	Fri, 26 Jan 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="j5kwiYjO"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3D200D8
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291487; cv=none; b=I0D182TXPFMI3wkfnmozc3Uqo/PlNW9vHMiRQM7SFXBDg9ODkQ7PVaRPQeUhk8g6nFqgDwrqSBv9d7lxN3RQpHwQlXAhUpFFmCl3c4atsUsBUa0kULacpWAQN8SAyWUEs5//uv7XYpKznpoXppyLIOpQ+dpsQX4eAF4XrBIujZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291487; c=relaxed/simple;
	bh=/tC2RsHbyUMnCyIuDOwjZ3gbLszTz7OAxJPID07Bptk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ma39wHs8IWx73rmxZydKgBkW9UEXJAftYN/Ti+CvyJzyk0wArsxP10mIaBmBfxl3j6hOvbL2IvPxEFUUGJRTV/4Lmh9Q2sYvuHBHKZhwYKfHdK1mORMdGbWmeeGnaQ4hlOGDSqqKYc6r1FK9TEkEOKE/0kwcJiFxvDQd5VY96S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=j5kwiYjO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uVkexDVtu88M2+1CsfAPV0juwep30EvqlAY6ORFlOnc=; b=j5kwiYjODdLjyviWoBzT2pTDV7
	APQAEQyG78b2WCVChK+KpmcfAhQoRyi5yr8Z0trae4BPmoZ9StS/GVIqx+r9m36+8NSM9vjx3LMAe
	9gRSNA8yiauDbv2YzIeVUCOh+k74SBqXLyfPFm923nC2XN9LCvrznEbgZL54IhV3cf711JyTfLeGC
	IhG5lJiNxdz2XrDyCU3xc6yCkihCYakfpAoJbgoG5obZIRVtUwh0Syu1Vf18EteWOB+BlcPSxe6VQ
	6XSHq0ZA75c1DKgw3RGEYACgBOgj97+s2cJe4r/ffMOq6PNywPyOWdQJa6uTtBoMsazYfMajSbtzM
	53RNidoQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rTQMN-0008kX-31; Fri, 26 Jan 2024 18:51:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rTQMM-00043e-QZ; Fri, 26 Jan 2024 18:51:22 +0100
Subject: Re: [PATCH bpf-next v2] bpftool: add support for split BTF to gen
 min_core_btf
To: Bryce Kahle <bryce.kahle@datadoghq.com>, bpf@vger.kernel.org
Cc: quentin@isovalent.com, ast@kernel.org
References: <CALvGib94ovYOdwx4+qCc14WverUU1=X-LrRK9sNgajG1+0MYpg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4b1ad4ce-f92a-ce30-e26e-1dce38710489@iogearbox.net>
Date: Fri, 26 Jan 2024 18:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvGib94ovYOdwx4+qCc14WverUU1=X-LrRK9sNgajG1+0MYpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27166/Fri Jan 26 10:46:50 2024)

On 1/26/24 6:19 PM, Bryce Kahle wrote:
> Enables a user to generate minimized kernel module BTF.
> 
> If an eBPF program probes a function within a kernel module or uses
> types that come from a kernel module, split BTF is required. The split
> module BTF contains only the BTF types that are unique to the module.
> It will reference the base/vmlinux BTF types and always starts its type
> IDs at X+1 where X is the largest type ID in the base BTF.
> 
> Minimization allows a user to ship only the types necessary to do
> relocations for the program(s) in the provided eBPF object file(s). A
> minimized module BTF will still not contain vmlinux BTF types, so you
> should always minimize the vmlinux file first, and then minimize the
> kernel module file.
> 
> Example:
> 
> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
> 
> Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>

Looks like the patch got whitespace damaged, could you try sending with
git-send-email?

Thanks,
Daniel

