Return-Path: <bpf+bounces-33428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9D91CCC7
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 14:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCDB21D2A
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09D7C6D4;
	Sat, 29 Jun 2024 12:48:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6B92B9BE;
	Sat, 29 Jun 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719665293; cv=none; b=nDl2WeXlm+FDzBJTUCOpT9IrYm0XK6/XSUX3cJEx/ERbDo2JP+luVt/slF+RmyW1raPsGci9xN6CdQbqoa6dl4VqWxuoGc3CjoGdpHCM9Ys2VJemynZJK0Hlx/XzijsDx+zw7bcGZAe2IOvHjevKzYdOT1ck7by3nY4mvC0S7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719665293; c=relaxed/simple;
	bh=eksxv3soLqwNNaIwyq6qM/uW+C8SEtvfywK/NPtrcUY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DyC0UpNXiOqvtT8E4bFL1DnAorh1V1Q6p0ZP1W28XYyFS9L0o5uKA+rwQQQiQYBPRttPrBi6nWsahUVP2npCQeC6vp5aNSYpq9r78K1Mu79V5b2udXQIarN4CQrpYPiGq/DDk0tytqZOi2jV+6WT5zNQ3h3LyfjLLATuAu5DyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.122.216])
	by gateway (Coremail) with SMTP id _____8Bx3+uBAoBmC28LAA--.28821S3;
	Sat, 29 Jun 2024 20:48:01 +0800 (CST)
Received: from [192.168.0.109] (unknown [36.44.122.216])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx68Z+AoBmIVk1AA--.59448S3;
	Sat, 29 Jun 2024 20:48:00 +0800 (CST)
Message-ID: <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
Date: Sat, 29 Jun 2024 20:48:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: oleg@redhat.com
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, bpf@vger.kernel.org,
 chenhuacai@kernel.org, jolsa@kernel.org, kernel@xen0n.name,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, mhiramat@kernel.org, nathan@kernel.org,
 rostedt@goodmis.org, yangtiezhu@loongson.cn
References: <20240627173806.GC21813@redhat.com>
Subject: Re: [PATCH] LoongArch: uprobes: make
 UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN constant
Content-Language: en-US
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20240627173806.GC21813@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Cx68Z+AoBmIVk1AA--.59448S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFyxGF48CFyxuw18trWUGFX_yoW3Kwc_uw
	sxCay8J348Cr40qFn2y3s3Zw4DWF4xWFW5Xr97Zwn7J34UK3WDZ3yFgrn7Za4rKF40gFsI
	9FZ0qa48Zr1avosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOa93UUUUU=

On Thu, 27 Jun 2024 19:38:06 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

...

 > > > +arch_initcall(check_emit_break);
 > > > +
 > >
 > > I wouldn't even bother with this, but whatever.
 >
 > Agreed, this looks a bit ugly. I did this only because I can not test
 > this (hopefully trivial) patch and the maintainers didn't reply.

The LoongArch maintainer Huacai told me offline to reply this thread today.

 > If LoongArch boots at least once with this change, this run-time check
 > can be removed.

I will test it next Monday.

 > And just in case... I didn't dare to make a more "generic" change, but
 > perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined the
 > same way for micro-optimization. In this case __emit_break() should be
 > probably moved into arch/loongarch/include/asm/inst.h.

Yeah. I think so too.

Thanks,
Tiezhu


