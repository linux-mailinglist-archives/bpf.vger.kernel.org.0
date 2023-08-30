Return-Path: <bpf+bounces-9008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622478E28E
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09A81C20960
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C288BF3;
	Wed, 30 Aug 2023 22:49:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65D7490
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 22:49:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A83CFF;
	Wed, 30 Aug 2023 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=J9+c6lHcxjXQTF5hwF7rOA41PnMBLRCg0uifQFKOozw=; b=p67pKYTcd9ysaiO1NOxyqmdqwT
	6sfOPBCdPTHJ4l50G+v/B+lCZD9TN8qp3AUA1u7AXr9xqUyAWcUZVK+T/GkiVApyT8JD0JALfe23z
	PuVSBB/B5FH+WQi/OeleSSkB/J7SlRcs/lUMl5zMP1aTInjUCPqiiiAxgLBHKleV41wKNNJTr3HPd
	meQqjx555TPI992mdYHY9OtVOEKrnQw0+SWGUHeEYQVa8q+LNiEXtB/Dq8HIZetwjW8mKONExBh6n
	uczMCLpRzyZpSmrg+UxccWGNOfdbMn/+ck2WMfUS7OxiM5sRtlj5Pq+NDvjWkqG7uorAoCkp15ccG
	hbsSkKjw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbTyz-0000Ow-MJ; Thu, 31 Aug 2023 00:48:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbTyz-000QfR-D9; Thu, 31 Aug 2023 00:48:17 +0200
Subject: Re: [PATCH bpf-next v3 0/3] bpf, riscv: use BPF prog pack allocator
 in BPF JIT
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: bjorn@kernel.org, puranjay12@gmail.com,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 pulehui@huawei.com, Conor Dooley <conor.dooley@microchip.com>,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-ac1c6e6a-8f27-4539-83bb-6c10ff4d264e@palmer-ri-x1c9>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9e31c290-f1f0-ecfd-c68b-51f8d706db2c@iogearbox.net>
Date: Thu, 31 Aug 2023 00:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <mhng-ac1c6e6a-8f27-4539-83bb-6c10ff4d264e@palmer-ri-x1c9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27016/Wed Aug 30 09:37:04 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/30/23 3:54 PM, Palmer Dabbelt wrote:
> On Wed, 30 Aug 2023 01:18:46 PDT (-0700), daniel@iogearbox.net wrote:
>> On 8/29/23 12:06 PM, Björn Töpel wrote:
>>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>>
>>>> Changes in v2 -> v3:
>>>> 1. Fix maximum width of code in patches from 80 to 100. [All patches]
>>>> 2. Add checks for ctx->ro_insns == NULL. [Patch 3]
>>>> 3. Fix check for edge condition where amount of text to set > 2 * pagesize
>>>>     [Patch 1 and 2]
>>>> 4. Add reviewed-by in patches.
>>>> 5. Adding results of selftest here:
>>>>     Using the command: ./test_progs on qemu
>>>>     Without the series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>>     With this series: Summary: 336/3162 PASSED, 56 SKIPPED, 90 FAILED
>>>>
>>>> Changes in v1 -> v2:
>>>> 1. Implement a new function patch_text_set_nosync() to be used in bpf_arch_text_invalidate().
>>>>     The implementation in v1 called patch_text_nosync() in a loop and it was bad as it would
>>>>     call flush_icache_range() for every word making it really slow. This was found by running
>>>>     the test_tag selftest which would take forever to complete.
>>>>
>>>> Here is some data to prove the V2 fixes the problem:
>>>>
>>>> Without this series:
>>>> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
>>>> test_tag: OK (40945 tests)
>>>>
>>>> real    7m47.562s
>>>> user    0m24.145s
>>>> sys     6m37.064s
>>>>
>>>> With this series applied:
>>>> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
>>>> test_tag: OK (40945 tests)
>>>>
>>>> real    7m29.472s
>>>> user    0m25.865s
>>>> sys     6m18.401s
>>>>
>>>> BPF programs currently consume a page each on RISCV. For systems with many BPF
>>>> programs, this adds significant pressure to instruction TLB. High iTLB pressure
>>>> usually causes slow down for the whole system.
>>>>
>>>> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
>>>> It packs multiple BPF programs into a single huge page. It is currently only
>>>> enabled for the x86_64 BPF JIT.
>>>>
>>>> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.
>>>>
>>>> This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.
>>>> This series needs a patch[3] from the ARM64 series to work.
>>>>
>>>> ======================================================
>>>> Performance Analysis of prog pack allocator on RISCV64
>>>> ======================================================
>>>>
>>>> Test setup:
>>>> ===========
>>>>
>>>> Host machine: Debian GNU/Linux 11 (bullseye)
>>>> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
>>>> u-boot-qemu Version: 2023.07+dfsg-1
>>>> opensbi Version: 1.3-1
>>>>
>>>> To test the performance of the BPF prog pack allocator on RV, a stresser
>>>> tool[4] linked below was built. This tool loads 8 BPF programs on the system and
>>>> triggers 5 of them in an infinite loop by doing system calls.
>>>>
>>>> The runner script starts 20 instances of the above which loads 8*20=160 BPF
>>>> programs on the system, 5*20=100 of which are being constantly triggered.
>>>> The script is passed a command which would be run in the above environment.
>>>>
>>>> The script was run with following perf command:
>>>> ./run.sh "perf stat -a \
>>>>          -e iTLB-load-misses \
>>>>          -e dTLB-load-misses  \
>>>>          -e dTLB-store-misses \
>>>>          -e instructions \
>>>>          --timeout 60000"
>>>>
>>>> The output of the above command is discussed below before and after enabling the
>>>> BPF prog pack allocator.
>>>>
>>>> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The rootfs
>>>> was created using Bjorn's riscv-cross-builder[5] docker container linked below.
>>>>
>>>> Results
>>>> =======
>>>>
>>>> Before enabling prog pack allocator:
>>>> ------------------------------------
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>             4939048      iTLB-load-misses
>>>>             5468689      dTLB-load-misses
>>>>              465234      dTLB-store-misses
>>>>       1441082097998      instructions
>>>>
>>>>        60.045791200 seconds time elapsed
>>>>
>>>> After enabling prog pack allocator:
>>>> -----------------------------------
>>>>
>>>> Performance counter stats for 'system wide':
>>>>
>>>>             3430035      iTLB-load-misses
>>>>             5008745      dTLB-load-misses
>>>>              409944      dTLB-store-misses
>>>>       1441535637988      instructions
>>>>
>>>>        60.046296600 seconds time elapsed
>>>>
>>>> Improvements in metrics
>>>> =======================
>>>>
>>>> It was expected that the iTLB-load-misses would decrease as now a single huge
>>>> page is used to keep all the BPF programs compared to a single page for each
>>>> program earlier.
>>>>
>>>> --------------------------------------------
>>>> The improvement in iTLB-load-misses: -30.5 %
>>>> --------------------------------------------
>>>>
>>>> I repeated this expriment more than 100 times in different setups and the
>>>> improvement was always greater than 30%.
>>>>
>>>> This patch series is boot tested on the Starfive VisionFive 2 board[6].
>>>> The performance analysis was not done on the board because it doesn't
>>>> expose iTLB-load-misses, etc. The stresser program was run on the board to test
>>>> the loading and unloading of BPF programs
>>>>
>>>> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
>>>> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gmail.com/
>>>> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/
>>>> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
>>>> [5] https://github.com/bjoto/riscv-cross-builder
>>>> [6] https://www.starfivetech.com/en/site/boards
>>>>
>>>> Puranjay Mohan (3):
>>>>    riscv: extend patch_text_nosync() for multiple pages
>>>>    riscv: implement a memset like function for text
>>>>    bpf, riscv: use prog pack allocator in the BPF JIT
>>>
>>> Thank you! For the series:
>>>
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
>>> Tested-by: Björn Töpel <bjorn@rivosinc.com>
>>>
>>> @Alexei @Daniel This series depends on a core BPF patch from the Arm
>>>                  series [3].
>>>
>>> @Palmer LMK if you have any concerns taking the RISC-V text patching
>>>          stuff via the BPF tree.
>>
>> Palmer, did the riscv PR already go to Linus?
> 
> Not yet, I usually send on Friday mornings -- and I also generally send two, as there's some stragglers/fixes for the second week.  I'm fine taking it (Bjorn just poked me), can someone provide a base commit? Bjorn says it depends on something in Linus' tree, so I'll just pick it up as a straggler for next week.

Okay, sgtm.

> Also, do you mind sending an Ack?

Björn / Puranjay, just to clarify since the arm64 series did not land, you are referring
to this one as a dependency [0], right? Meaning, you'd route [0] + this series via riscv
PR to Linus then during this merge win.

If yes, could one of you send the complete 4-patch series with the prior Acks from [0] + this
series collected to both bpf+riscv list (with the small request to extend the commit desc
in [0] a bit to better document implications of the change itself for other JITs)? After a
final look and if BPF CI goes through we can then ack as well and unblock the routing.

Thanks,
Daniel

   [0] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/

