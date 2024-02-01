Return-Path: <bpf+bounces-20945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0ED845646
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632DF1F21DC1
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CB15D5B3;
	Thu,  1 Feb 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WqJBI7BU"
X-Original-To: bpf@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC215CD73
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787085; cv=none; b=rMmxkxeeyUUY91Gp4CvE+f6VK2Ge6nTWpbXsjX6Y8O+OQ9E7eucdlm4hNaqByiNulAbu1pyD8smJPvF0jg8su9/BaQZ1SQT5BMX5Xi3atefl2pVan1N8NBAWcB0xBA5SWFVu3ct9OB9mxUVK0YftqlO1gDYOvwyxEME73K5EZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787085; c=relaxed/simple;
	bh=Y43K/9Pr3/J8pQcr6auVY9urd1fE9ip+x6T1JXZeiuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=axS38hLA4Q3CkU2amA+A27H8aAFbPxLnTz6V++si50gLtRovduQosgiXTgt/Zlp8icpRecSulgbqpjWOiu1w1vYQFkAmgLQBSe7dMnoEpizMGicRvi6UEaHMVWrDDXCrWhcCXZXtQqieGq5Z5fJZj4zSoDtYwx121gxxvFEMuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WqJBI7BU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240201113120euoutp01bb15946b48c4b77c02a8004a9de934b9~vuc6Dr7N80232002320euoutp01T
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 11:31:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240201113120euoutp01bb15946b48c4b77c02a8004a9de934b9~vuc6Dr7N80232002320euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706787080;
	bh=wQ0RO1zhNPtAJDp+vpA11gjRu7eZ5H9BUbR2r8jxAJg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WqJBI7BUqlsQWq4Nl5Vbm8WSh+YyvYXFd/Y7Nm4F4SOyS+1tb2pcYKwEYN7pl6ww7
	 Ex49vc1woFrv7ESyyhIz6Q4yanew77f3qZfqBQH2dtftAlbMLskeGxFDnGpxu0uvib
	 otK/+gjlfOR7CE9Hrz1qTlKoKajO3dzxiezlLi28=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240201113120eucas1p10dcc6b1b835492224c4a86b115a06ffa~vuc50RlLF2368023680eucas1p1L;
	Thu,  1 Feb 2024 11:31:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 03.3B.09814.7018BB56; Thu,  1
	Feb 2024 11:31:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240201113119eucas1p2da4ad2b5b7549c5fb99e540531411c2a~vuc5cxAS32810128101eucas1p2T;
	Thu,  1 Feb 2024 11:31:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240201113119eusmtrp11e8a64689c0d3b7776afca799a2da318~vuc5cI-wg2587625876eusmtrp1N;
	Thu,  1 Feb 2024 11:31:19 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-88-65bb81078e1c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.13.09146.7018BB56; Thu,  1
	Feb 2024 11:31:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240201113119eusmtip28cd4f02af464816248dc207c234d9b95~vuc45F0fP0033700337eusmtip2Y;
	Thu,  1 Feb 2024 11:31:19 +0000 (GMT)
Message-ID: <a5fafb40-0782-4b85-a9fd-7fda886dd70a@samsung.com>
Date: Thu, 1 Feb 2024 12:31:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf
	<bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel
	Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD1292WLaa6lGI/C4HQKAYPQKNmEwiI8WhMRBOMRDSRxn4BIhRs
	QYT4A0woUDzw1goKIlCwCCWcLWioR0W0avGoaMQYVERRjiKnIO2i8u+9mXnzZiZD4jwNS0jG
	ypKQXCaJE7GdifoHY09XkRkGFFAxCOiRiSs4bRt760QP3TOx6eKiXzg9WHIM0B36fDbdWqQE
	9IPCRXRdy0unDRxxhtXKFve8eoOLVVYLLq6pyGGLh2o8d7IinYOkKC72MJL7B0c5x+S2WFmJ
	rzyPaL61EemgebEKkCSk1sIXhiQVcCZ5lAZA2/gJgiG2GWK8gjNkCEBz7j0nFeA4FINaPcYk
	ygAsnz4PGDIA4DHdZ7a9iksFw5eTWsyOCWoJrOp5y2LiLrDtcjdhx26UF+zqvOTo6kptg3pd
	DrBjnBLAzu5rDi2f2gJLH+sdY+CUFoOtp62ORmxqNVT1qRxmHCoMtulGWIzYCzb05TsEkOon
	4Z13zTgz9yao7GuYxa6w11Q7u48HbD97nGAEWQAWTnRhDMkDMP1LJ2CqAuE78zjbfjOc8oVV
	en8mHAqL82sJ5pQLoLXPhRliATxTfxFnwlyYreQx1T5Qbbr1z7b1mQXPAyL1nLuo5+yvnrOO
	+r9vISAqgAAlK+KjkWKNDKX4KSTximRZtN+BhPgaMPNM7VMmWyMo6x3wMwKMBEYASVzE55Z7
	NiEeVypJTUPyhP3y5DikMAJ3khAJuEulXohHRUuS0EGEEpH8bxYjOcJ0rKF6bLT/0u22Ol2Q
	948X9Zll06bQj5Wnks5+n5fYW8F6zu/I8Aa1aTeb9BkTI4cKOO4/WfcHKk0dAst3dOd6pIdm
	cnIqxdjYnhUd8fioz8rmkJSSEXNXeHZLeMzyT++7Y6Ie+X4ILBHzKkPzz2mfiPbs59EpIRe2
	RhwOkz7xtihPZu711y3zkF8dXTuw/lpWwEbXUm5BA0Fj6/lf1+3YIdx6yBymL+Z2D5cK7xua
	tD2vA+8Kg2QGHMu08Q3zd2keLrak3tjWb963Pe1DgXuUyms4NdZnbAXIlhZJqqvcXTb+vjA/
	URhUrpyK+2SaF/UsddqyGxFugma3hQfPba5tPCMiFDGS1ctxuULyByYM7ya7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7rsjbtTDe6eUbP4/ns2s8WXn7fZ
	LT4fOc5msXjhN2aLT0ubGC0u75rDZnFwYRujxbEFYhZb915ld+D0aLxxg83jxbWbzB5dNy4x
	e2xa1cnm8XmTXABrlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
	Zllqkb5dgl5G994brAXX5CpWvD7J0sC4R7KLkZNDQsBE4tOaXUxdjFwcQgJLGSVONjxhhkjI
	SJyc1sAKYQtL/LnWxQZR9J5R4sbjU0wgCV4BO4mrf9aA2SwCKhLrX9xmhYgLSpyc+YQFxBYV
	kJe4f2sGO4gtLOAlsWtjJyOIzSwgLnHryXywXhEBN4llZ3YxgyxgFljDJLHxzC2wQUICVRJ3
	Dl0Ds9kEDCW63oJcwcnBKeAncXLjd1aIQWYSXVu7oIbKS2x/O4d5AqPQLCR3zEKybxaSlllI
	WhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjMRtx35u3sE479VHvUOMTByMhxglOJiV
	RHhXyu1MFeJNSaysSi3Kjy8qzUktPsRoCgyMicxSosn5wFSQVxJvaGZgamhiZmlgamlmrCTO
	61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAJHmueN6L8mmHJmw9nGYi5bZg64NUGS2pXcuXTN3+
	8EmxZWruoZcatUEWDx08k65t2PQpt8RRm/f8tKCm2iD9Nh3FLy5fgraKxYl4Lee9yxqiszzW
	ZdGsd0WM97SYL6eoXz3xTGylYcnfE4tuzeQ1/uA+4bTF9zPZjN/PSHK+X3Cr33zpUov/DNKv
	bxyR/HHb+ovkR9YZN4125t579W71yvmXtpxa0nDoQ/4edn2P1VeWbpZZvcaSc7+l4QpZv9ab
	MjypXPUP/zZE9rLOOGJhsEMkt/HBo+6MZexZXEL/j5roccfe1xFpU+88XzbrkJsws8SbrvIj
	U6Qu7W7/v1HsSEFJ6knNAOYHi9alK38V3afEUpyRaKjFXFScCAB14NLfTQMAAA==
X-CMS-MailID: 20240201113119eucas1p2da4ad2b5b7549c5fb99e540531411c2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240201113119eucas1p2da4ad2b5b7549c5fb99e540531411c2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240201113119eucas1p2da4ad2b5b7549c5fb99e540531411c2a
References: <20240201142348.38ac52d5@canb.auug.org.au>
	<yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
	<CGME20240201113119eucas1p2da4ad2b5b7549c5fb99e540531411c2a@eucas1p2.samsung.com>

Dear All,

On 01.02.2024 04:55, Daniel Xu wrote:
> Hi Stephen,
>
> Thanks for the report.
>
> On Thu, Feb 01, 2024 at 02:23:48PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the bpf-next tree, today's linux-next build (powerpc
>> pseries_le_defconfig) produced these runtime warnings in my qemu boot
> I can't quite find that config in-tree. Mind giving me a pointer?
>
>> tests:
>>
>>    ipip: IPv4 and MPLS over IPv4 tunneling driver
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set+0x68/0x74
>>    Modules linked in:
>>    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-03380-gd0c0d80c1162 #2
>>    Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
>>    NIP:  c0000000003bfbfc LR: c00000000209ba3c CTR: c00000000209b9a4
>>    REGS: c0000000049bf960 TRAP: 0700   Not tainted  (6.8.0-rc2-03380-gd0c0d80c1162)
>>    MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 00000000
>>    CFAR: c0000000003bfbb0 IRQMASK: 0
>>    GPR00: c00000000209ba3c c0000000049bfc00 c0000000015c9900 000000000000001b
>>    GPR04: c0000000012bc980 000000000000019a 000000000000019a 0000000000000133
>>    GPR08: c000000002969900 0000000000000001 c000000002969900 c000000002969900
>>    GPR12: c00000000209b9a4 c000000002b60000 c0000000000110cc 0000000000000000
>>    GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>    GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd250
>>    GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1060
>>    GPR28: 0000000000000000 0000000000000007 c0000000020c10a8 c000000002968f80
>>    NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>>    LR [c00000000209ba3c] cubictcp_register+0x98/0xc8
>>    Call Trace:
>>    [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>>    [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>>    [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>>    [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
>>    --- interrupt: 0 at 0x0
>>    Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bfff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0121
>>    ---[ end trace 0000000000000000 ]---
>>    NET: Registered PF_INET6 protocol family
> [...]
>
>> Exposed (and maybe caused) by commit
>>
>>    6e7769e6419f ("bpf: treewide: Annotate BPF kfuncs in BTF")
>>
> My guess is the config does not enable CONFIG_DEBUG_INFO_BTF which
> causes compilation to use the dummy definitions for BTF_KFUNCS_START().
>
> I think there's probably a few ways to fix it. This untested diff should
> work if I am guessing correctly. There's probably a cleaner way to do
> this.  I'll take a closer look in the morning.

I've observed this issue while testing today's linux-next on ARM64 bit 
boards. The below patch fixes (or hides?) this warning. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 0fe4f1cd1918..e24aabfe8ecc 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -227,7 +227,7 @@ BTF_SET8_END(name)
>   #define BTF_SET_END(name)
>   #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
>   #define BTF_SET8_END(name)
> -#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
> +#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
>   #define BTF_KFUNCS_END(name)
>
>   #endif /* CONFIG_DEBUG_INFO_BTF */
>
>
> Thanks,
> Daniel

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


