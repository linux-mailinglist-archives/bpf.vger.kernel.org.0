Return-Path: <bpf+bounces-8774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D30789C7D
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704B01C2098B
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8975256;
	Sun, 27 Aug 2023 09:04:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D780B
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 09:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B7C433C8;
	Sun, 27 Aug 2023 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693127077;
	bh=y6B4CMo2bzrCCuPYGklfmEMWK+PNdiefaXdkAiB6EXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hr03HINqXIhQ+zBrth4/64FTbAKYnShVwYXQaMHl+jZayZzUevYD80sggXd4onoiK
	 Dqn56mfbkB5ZfedoR0KJRNb17GBwni2HQ03bDfjDc1sLt+tj9CbMQyxi7fVEevxFhG
	 AhlKtP+fLPWYarORlE7Ocv0Mce3+dtui1Ncz0+fVjM44D0xGr92v0gx3BLmsG1Zn1F
	 xSjdj4bp4ziYWDb5xiBhaYwJNdRpihs28SFn84tgFFad4c9txgIVArwiOCea5M+gaM
	 Nk9vrEj7y2vzABoJThJ5vwAGbhNmYQUp0WFOGN8O+opRR2uqaWLbPFABBFg/Gtlg3S
	 aRifv4kuVS8zw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcaov@gmail.com>
Cc: linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
 bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
 yonghong.song@linux.dev, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: RISC-V uprobe bug (Was: Re: WARNING: CPU: 3 PID: 261 at
 kernel/bpf/memalloc.c:342)
In-Reply-To: <ZOsKukBz8i+h4Y8j@nam-dell>
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us>
 <87v8d19aun.fsf@all.your.base.are.belong.to.us>
 <ZOpAjkTtA4jYtuIa@nam-dell>
 <87cyz8sy4y.fsf@all.your.base.are.belong.to.us>
 <ZOsKukBz8i+h4Y8j@nam-dell>
Date: Sun, 27 Aug 2023 11:04:34 +0200
Message-ID: <87y1hw7t5p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam Cao <namcaov@gmail.com> writes:

> On Sun, Aug 27, 2023 at 10:11:25AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> The default implementation of is_trap_insn() which RISC-V is using calls
>> is_swbp_insn(), which is doing what your patch does. Your patch does not
>> address the issue.
>
> is_swbp_insn() does this:
>
>         #ifdef CONFIG_RISCV_ISA_C
>                 return (*insn & 0xffff) =3D=3D UPROBE_SWBP_INSN;
>         #else
>                 return *insn =3D=3D UPROBE_SWBP_INSN;
>         #endif
>
> ...so it doesn't even check for 32-bit ebreak if C extension is on. My pa=
tch
> is not the same.

Ah, was too quick.

AFAIU uprobes *always* uses c.ebreak when CONFIG_RISCV_ISA_C is set, and
ebreak otherwise. That's the reason is_swbp_insn() is implemented like
that. If that's not the case, there's a another bug, that your patches
addresses.

In that case we need an arch specific set_swbp() implementation together
with your patch.

Guo, thoughts? ...text patching on RISC-V is still a big WIP.

> But okay, if it doesn't solve the problem, then I must be wrong somewhere.

Yes, this bug is another issue.

>> We're taking an ebreak trap from kernel space. In this case we should
>> never look for a userland (uprobe) handler at all, only the kprobe
>> handlers should be considered.
>>=20
>> In this case, the TIF_UPROBE is incorrectly set, and incorrectly (not)
>> handled in the "common entry" exit path, which takes us to the infinite
>> loop.
>
> This change makes a lot of sense, no reason to check for uprobes if excep=
tion
> comes from the kernel.

Ok! I sent a patch proper for this.


Bj=C3=B6rn

