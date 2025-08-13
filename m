Return-Path: <bpf+bounces-65515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6570B24948
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25465880588
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A442FE59D;
	Wed, 13 Aug 2025 12:13:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1B2EA46D;
	Wed, 13 Aug 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087206; cv=none; b=clNzvcfZTbi5uZs3s/ZZITJilgoOKVjGIUuJW+Y8m2E2ZUibV9gXCqcltj+oQsZlqB2tegOvPmUmsH4LyXKFUITsJ48SjOxSALk1RRLqE7WBiE+vhV/RynTRyrhrRI0qCxJnqo1vw+wYdzkOO0NRuT27+8FLb+RqZH8L2CEOZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087206; c=relaxed/simple;
	bh=MEsok+D521P7EFylUtWQLvUhqEWC0ipeQtwcspQ/WzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSbaJewdvWh8VZzWiP9ztjcUE3nxuoKW4lrwdGAW3ZPbG4g64MqaqxjDDiNGY4ZAkgBOLiHsD390xZt7OioUkt830M4tN6UE+ZiOGuB0eo8d1SHQjbiQbQftiTp9xYgqaRai/C1I7bMeL9ZuvsmGGkWSu+hcIh6qr6lMveUGBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5E95443C9;
	Wed, 13 Aug 2025 12:13:16 +0000 (UTC)
Message-ID: <95d0aa18-0c09-4b00-824d-3078548ddfcd@ghiti.fr>
Date: Wed, 13 Aug 2025 14:13:16 +0200
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
 <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>
 <DC0H1RZKZ3QR.82P8JXIL5NBJ@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <DC0H1RZKZ3QR.82P8JXIL5NBJ@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeuffefvdelteelteejhfejhedujeetteevtddvvddthfeiteffledvffeggfeiieenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheprhhkrhgtmhgrrhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepm
 hgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Radim,

On 8/12/25 15:09, Radim Krčmář wrote:
> 2025-08-12T13:37:16+02:00, Alexandre Ghiti <alex@ghiti.fr>:
>> @Radim: This is the third similar bug, did you check all assembly code
>> (and bpf) to make sure we don't have anymore left or should I?
> I looked at load/store instructions, including bpf, and focussed on
> patterns where we access non-xlen sized data through an offset.
>
> (Nothing else popped up, but I mostly used grep and cscope as I don't
>   know of any semantic tool, so my confidence levels are low.)


Ok thanks, I don't have any better idea than eye scrubbing so I'll take 
another look to improve our confidence. One good thing is that now I 
don't let them pass in reviews :)

Thanks for noticing this class of bugs!

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

