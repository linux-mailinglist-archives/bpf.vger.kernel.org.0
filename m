Return-Path: <bpf+bounces-65422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E020EB22602
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F0A3B01C7
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A712ED85B;
	Tue, 12 Aug 2025 11:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682041A9FB8;
	Tue, 12 Aug 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998644; cv=none; b=l9x4UcDOKGW7RaFYVxFSiE1y77GtwSfdAJj0jbtWul//jDmIA5K5rERPa1JXSnEU3syQZ+wF0q9tTrLbQeUfjOQhQXzQ/f98ODPRtEGUwvYo06E1oob3lx4U/L04J7uyd1P8GE7zDqmqzwr8pigBs/lZoffAzQqJ0lH0TKsV2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998644; c=relaxed/simple;
	bh=XlM/RUVI+Jg9aI65pMmHBvuvy9C0U8zH8a4AW1mwCtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdqUiPBlzznIxQmzPPrP7MOHcvNFW0ABgoQ0Y9OxB82PL4VnTcbLAVk3G76U2tkxUpdozA2qpsnAGrk5L3mkUwWCQDUwslB0FE9ZhG/hJKDkWJ/MOzYtnxwgF+994pp2igkQGNduPv2Fwo13cqArHhvxyh5FnOV1QSYytXzjEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4911841C06;
	Tue, 12 Aug 2025 11:37:16 +0000 (UTC)
Message-ID: <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>
Date: Tue, 12 Aug 2025 13:37:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsgdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheprhhkrhgtmhgrrhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Radim,

On 8/12/25 11:02, Radim Krčmář wrote:
> Hello,
>
> These patches are related to a recently queued series [1] that fixes the
> same bugs in normal code.  That series finishes with a patch that would
> have exposed the BPF bugs, but luckily it won't get merged until v6.18.
>
> I don't know enough about BPF to verify that it emits the correct code
> now, so any pointers are welcome.
>
> 1: https://lore.kernel.org/linux-riscv/20250725165410.2896641-3-rkrcmar@ventanamicro.com/
>
> Radim Krčmář (2):
>    riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
>    riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
>
>   arch/riscv/net/bpf_jit_comp64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>

Both patches look good so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Since this only touches riscv and I have a bunch of fixes pending, I 
propose to take those patches through the riscv tree, I'll just wait for 
Björn to confirm it is correct.

@Radim: This is the third similar bug, did you check all assembly code 
(and bpf) to make sure we don't have anymore left or should I?

Thanks,

Alex


