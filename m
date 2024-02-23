Return-Path: <bpf+bounces-22543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6C86081A
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C341B24275
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1660B651;
	Fri, 23 Feb 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h2MXFqEw"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C66FA8;
	Fri, 23 Feb 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650609; cv=none; b=VHklDQi5AgjL1COngpZzzmA8NhiHCPfa5prYyMzfuKWs1NQnvkQrvdA/ijQ6dX/mFlJObZIFXNFoEWIPKLrBojrcUqFANvi6EwCrzXew1amWOTmffXUEeRk6j/y04pP9SFA6esbaacL6eSysG/qk+9uVMMMH9UrC9LWmM7Zg2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650609; c=relaxed/simple;
	bh=9BliyxV5UypkRqVKkRhlc0tLlQN8R0mBGtiNxzdTx7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUeXvYheLnp1zHCTDRpn4EktDzMIXuHmLohkSHxNNGlupKfuZJ0NYCsdaGy+ADGXQLYs23HxnvFweQoIz93O9VPkEeu19ja3AVRz98m+2R6LMZwf/tOWhzCJtuB6MheS2pFlLFzEw6nN+RJ3dSwuM3LdtsbHJRHQFjcXjuHLrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h2MXFqEw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9BliyxV5UypkRqVKkRhlc0tLlQN8R0mBGtiNxzdTx7k=; b=h2MXFqEw0M3WAbnd2IJa2IppmE
	fVLBz+aXxtrxqccq/KVGb1DOc2NmtnMoSc0d6ikKHN7VPiU6/+BP0DtfijoEgJd6byCCfmanJkbRW
	WpC30SqMt4HGGPg/yD8tZhmDe+8vAJE4fXsEXSZSTZWhOS2KqTEBWDeVzAb7pf7EkaTpw4+bK4XM/
	fhU/IjGM81bFoXLvELDe6O6ppChN4XdQ//Bfpwl7ZivI7dl0Uneypwmgaw00reYyl/x7fguDyWSAp
	4LmI80avmet4AiWE5xBbVkq96CnPthIW9YCIfqAy8B4hqDhu/SXWqWEu9JGbZ4AsAI7oRvr5vMzet
	bTPLf4ZA==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rdK48-002WHW-N1; Fri, 23 Feb 2024 02:09:29 +0100
Message-ID: <85cdc364-e19f-625a-16e4-4efc6451fc7d@igalia.com>
Date: Thu, 22 Feb 2024 22:09:20 -0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
 Jann Horn <jannh@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 "luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <87r0jwquhv.ffs@tglx>
 <c4c422ac-d017-9944-7d03-76ad416b19a4@igalia.com>
 <CAADnVQ+9vTBj9GgxotLF0_oV7cNFRebmcq_DNUm+cRJHQXCz1Q@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAADnVQ+9vTBj9GgxotLF0_oV7cNFRebmcq_DNUm+cRJHQXCz1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 13:04, Alexei Starovoitov wrote:
> [...]
> The fix is bpf and net trees and probably will be sent to Linus today
> as part of net PR.

Thanks a lot Alexei!

So, for completeness / archiving, the patch was now split in 2 and the
links are:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=ee0e39a63b7
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=32019c659ec

Cheers,


Guilherme

