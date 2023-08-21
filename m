Return-Path: <bpf+bounces-8141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88B78215B
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 04:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33E21C204F3
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC09EDD;
	Mon, 21 Aug 2023 02:23:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8AEA1
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 02:23:50 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1174B9C
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 19:23:49 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTbpg4w6zzrSSR;
	Mon, 21 Aug 2023 10:22:19 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 10:23:45 +0800
Message-ID: <13f54b2a-0f52-325a-d138-981fc4896908@huawei.com>
Date: Mon, 21 Aug 2023 10:23:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: bpf: Request to add -mcpu=v4 support for
 ARM/MIPS/NFP/POWERPC/RISCV/S390/SPARC/X86_32
Content-Language: en-US
To: <yonghong.song@linux.dev>, Shubham Bansal <illusionist.neo@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton
	<paulburton@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Luke
 Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Ilya Leoshkevich
	<iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Wang YanQing
	<udknight@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
References: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alright, riscv64 is already being adapted, will be sent soon.

On 2023/8/20 9:41, Yonghong Song wrote:
> Hi,
> 
> A new set of bpf insns have been recently added in llvm with flag
> [-mcpu=v4](https://reviews.llvm.org/D144829). In the kernel,
> x86_64 and arm64 have implemented -mcpu=v4 support:
>    x86_64: 
> https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/
>    arm64: 
> https://lore.kernel.org/bpf/20230815154158.717901-1-xukuohai@huaweicloud.com/
> 
> The following arch's do not have -mcpu=v4 support yet:
>    arm, mips, nfp, powerpc, riscv, sc90, sparc and x86_32
> 
> If you have a chance, could you take a look at what
> x86_64/arm64 does and add support to the above arch'es?
> 
> Thanks!
> 
> Yonghong
> 

