Return-Path: <bpf+bounces-5910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE0762DC0
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E259281C05
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348F8F7D;
	Wed, 26 Jul 2023 07:34:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9F8801
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 07:34:00 +0000 (UTC)
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807230E5;
	Wed, 26 Jul 2023 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1690356834; bh=XcZL0UiYpctgNqxRKPIYWTpapEbyjnHQl0vSOz4L+S8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sOFrT84lpq+9LFYaPO2jYEMW81bGQf13vrHET4eYePr+RwYlbrJSUcH9eaexSChJQ
	 4wSQirGWca2fWQHRgQJEUVD5B45iQFYUA2hbyUXlbRRpH++ZHJyzMejXyP2QkjprAj
	 Egqz3rcEluWWukUlPtXMQj1BRiwDvlHYga7QDbVw=
Received: from [100.100.34.13] (unknown [220.248.53.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2B45D60112;
	Wed, 26 Jul 2023 15:33:54 +0800 (CST)
Message-ID: <504c5fc7-57d3-f36a-b9e7-801d7e40bc60@xen0n.name>
Date: Wed, 26 Jul 2023 15:33:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: eBPF: Restrict bpf_probe_read{, str}() only to
 archs where they work
Content-Language: en-US
To: zhaochenguang <zhaochenguang@kylinos.cn>, chenhuacai@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230726062902.566312-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/26 14:29, zhaochenguang wrote:
> When we run nettrace on LoongArch, there is a problem that
> ERROR: failed to load kprobe-based eBPF
> ERROR: failed to load kprobe-based bpf
> 
> Because ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE dose not exist,
> so we enable it.
> 
> The patch reference upstream id 0ebeea8ca8a4d1d453ad299aef0507dab04f6e8d.

The description is a bit hard to follow. Rephrasing a bit:

"Currently nettrace does not work on LoongArch due to missing 
bpf_probe_read{,str}() support, with the error message:

     ERROR: failed to load kprobe-based eBPF
     ERROR: failed to load kprobe-based bpf

According to commit 0ebeea8ca8a4d ("bpf: Restrict bpf_probe_read{, 
str}() only to archs where they work"), we only need to select 
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to add said support, 
because LoongArch does have non-overlapping address ranges for kernel 
and userspace."

Also, the patch subject does not make sense. Looking at precedents such 
as commit 66633abd0642f ("MIPS/bpf: Enable bpf_probe_read{, str}() on 
MIPS again") and commit d195b1d1d1196 ("powerpc/bpf: Enable 
bpf_probe_read{, str}() on powerpc again"), we can instead re-title the 
commit as "LoongArch/bpf: Enable bpf_probe_read{, str}() on LoongArch". 
(No "again" because commit 0ebeea8ca8a4d actually predated the LoongArch 
port.)

> 
> Signed-off-by: zhaochenguang <zhaochenguang@kylinos.cn>
> ---
>   arch/loongarch/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 903096bd87f8..4a156875e9cc 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -11,6 +11,7 @@ config LOONGARCH
>   	select ARCH_ENABLE_MEMORY_HOTREMOVE
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>   	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE

Please keep the list in alphabetical order by moving this one line above.

>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_INLINE_READ_LOCK if !PREEMPTION
>   	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


