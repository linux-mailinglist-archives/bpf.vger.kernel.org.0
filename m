Return-Path: <bpf+bounces-18523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A98181B568
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD961C23758
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9646E585;
	Thu, 21 Dec 2023 12:00:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9B6BB3D;
	Thu, 21 Dec 2023 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Swprt3Wtwz4f3jZR;
	Thu, 21 Dec 2023 19:59:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DAB961A0552;
	Thu, 21 Dec 2023 19:59:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB3xw26KIRl_5H6EA--.61666S2;
	Thu, 21 Dec 2023 19:59:58 +0800 (CST)
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault
To: Thomas Gleixner <tglx@linutronix.de>, bpf <bpf@vger.kernel.org>
Cc: syzbot <syzbot+72aa0161922eba61b50e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bp@alien8.de, bp@suse.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, Jann Horn
 <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>
References: <000000000000c84343060a850bd0@google.com> <87jzqb1133.ffs@tglx>
 <CAG48ez06TZft=ATH1qh2c5mpS5BT8UakwNkzi6nvK5_djC-4Nw@mail.gmail.com>
 <87r0jwquhv.ffs@tglx>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e24b125c-8ff4-9031-6c53-67ff2e01f316@huaweicloud.com>
Date: Thu, 21 Dec 2023 19:59:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87r0jwquhv.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB3xw26KIRl_5H6EA--.61666S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1kGryUCFWDXr13ZFW3Awb_yoWkKFcEq3
	42934kurZ7uF42yr1xtr4a9r1rtw4kArWFq398ArWavFnIva9xG395trZ3Ww4UGwnagFZ3
	JFW5Z3srKrnI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Thomas,

On 12/9/2023 5:01 AM, Thomas Gleixner wrote:
> diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
> index 6993f026adec..8e846833aa37 100644
> --- a/arch/x86/mm/maccess.c
> +++ b/arch/x86/mm/maccess.c
> @@ -3,6 +3,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/kernel.h>
>  
> +#include <uapi/asm/vsyscall.h>
> +
>  #ifdef CONFIG_X86_64
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  {
> @@ -15,6 +17,9 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
>  	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
>  		return false;
>  
> +	if ((vaddr & PAGE_MASK) == VSYSCALL_ADDR)
> +		return false;
> +
>  	/*
>  	 * Allow everything during early boot before 'x86_virt_bits'
>  	 * is initialized.  Needed for instruction decoding in early

Tested-by: Hou Tao <houtao1@huawei.com>

Could you please post a formal patch for the fix ? The patch fixes the
oops when using bpf_probe_read_kernel() or similar bpf helpers [1] to
read from vsyscall address and you can take my tested-by tag if it is
necessary.

[1]:
https://lore.kernel.org/bpf/CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com/


