Return-Path: <bpf+bounces-57736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C9AAF49F
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC8D1BC5AD1
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DD21D3C0;
	Thu,  8 May 2025 07:23:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D1BA38
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689026; cv=none; b=bzHY82ep/AIYw2mPYJZyZswhEYfhDgyoKlASci2CgU7ReagybmX2tGAB1l3JPltEYLEd4/lxH2mYaGHsUyUUGMpLG2hcSEWh5ywvKBFKjstnSqF7azKZSTGHXQB3+k8sJaRWGMi5MOngAa2HfVvnS5yPazlLjC6GIzD1TZbJ2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689026; c=relaxed/simple;
	bh=uxEJgpAIcnMz4m79HdcG4tZeIh8mWO6tOl6TBasb0l0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z1JnhZSvFY0KTpT11zzdmLa5r5/alhEO3h7HYbLnXYXaRECsJ9/R9QL0e7hen7IysEfDwk2kyx42EDhNPlu2+jDyqHJ6lLrkxbum31/ex8gnFiVYptL0ezLKfHkNUXocSGOvp30PGCl6LM7TOXBrT2W8qObYHcFcIkRyaUJ/WFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx32v1WxxoS2vZAA--.29221S3;
	Thu, 08 May 2025 15:23:34 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxPcXyWxxo0n28AA--.19136S3;
	Thu, 08 May 2025 15:23:31 +0800 (CST)
Subject: Re: [QUESTION] Loongarch bpf selftest liburandom_read.so build error
To: Vincent Li <vincent.mc.li@gmail.com>, loongarch@lists.linux.dev,
 bpf <bpf@vger.kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
References: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8f375e63-c4d5-b9cc-64c4-7563ba5c2763@loongson.cn>
Date: Thu, 8 May 2025 15:23:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDxPcXyWxxo0n28AA--.19136S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1fJr48trWUCw45Aw4UJrc_yoW8Ww4UpF
	W8XFZ5tFZ29FWFyr97KayUWw1rKr48Wa4YqF1293s3ArnxJFnF9ws2yF9I9FyUG3sayw40
	vF10kr9rGFy5JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
	UUU==

On 05/08/2025 05:30 AM, Vincent Li wrote:
> Hi,
>
> I tried to build kernel 6.15-rc5 bpf selftests on Loongarch machine
> running Fedora, the bpf test programs seems built ok, but I got
> liburandom_read.so build error below:
>
>   LIB      liburandom_read.so
>
> /usr/bin/ld: cannot find crtbeginS.o: No such file or directory
>
> /usr/bin/ld: cannot find -lstdc++: No such file or directory
>
> /usr/bin/ld: cannot find -lgcc: No such file or directory
>
> /usr/bin/ld: cannot find -lgcc_s: No such file or directory
>
> clang: error: linker command failed with exit code 1 (use -v to see invocation)
>
> make: *** [Makefile:253:
> /usr/src/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1
>
> Am I missing  gcc tools for Fedora loongarch?

This is related with the cmake option when compiling Clang:

   "-DLLVM_HOST_TRIPLE=loongarch64-redhat-linux"

You can native compile and update your Clang like this:

git clone https://github.com/llvm/llvm-project.git
mkdir -p llvm-project/llvm/build && cd llvm-project/llvm/build
cmake .. -G "Ninja" \
          -DCMAKE_BUILD_TYPE=Release \
          -DLLVM_BUILD_RUNTIME=OFF \
          -DLLVM_ENABLE_PROJECTS="clang;lldb" \
          -DCMAKE_INSTALL_PREFIX=/usr/local/llvm \
          -DLLVM_TARGETS_TO_BUILD="BPF;LoongArch" \
          -DLLVM_HOST_TRIPLE=loongarch64-redhat-linux
ninja -j4
sudo rm -rf /usr/local/llvm && sudo ninja install
export PATH=/usr/local/llvm/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/llvm/lib:$LD_LIBRARY_PATH

or install the fedora 42 and then use this software repo:

https://mirrors.wsyu.edu.cn/fedora/linux/F42/rawhide/Everything/loongarch64/iso/

Thanks,
Tiezhu


