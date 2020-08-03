Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96DA23ABB4
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHCReL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 13:34:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:46874 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgHCReL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 13:34:11 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2eLg-0006rP-4R; Mon, 03 Aug 2020 19:34:08 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2eLf-000F0x-Ub; Mon, 03 Aug 2020 19:34:07 +0200
Subject: Re: [PATCH v5 bpf-next 3/4] bpf: Add kernel module with user mode
 driver that populates bpffs.
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20200802222950.34696-1-alexei.starovoitov@gmail.com>
 <20200802222950.34696-4-alexei.starovoitov@gmail.com>
 <33d2db5b-3f81-e384-bed8-96f1d7f1d4c7@iogearbox.net>
Message-ID: <430839eb-2761-0c1a-4b99-dffb07b9f502@iogearbox.net>
Date:   Mon, 3 Aug 2020 19:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <33d2db5b-3f81-e384-bed8-96f1d7f1d4c7@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25893/Mon Aug  3 17:01:47 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/3/20 7:15 PM, Daniel Borkmann wrote:
> On 8/3/20 12:29 AM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Add kernel module with user mode driver that populates bpffs with
>> BPF iterators.
>>
>> $ mount bpffs /my/bpffs/ -t bpf
>> $ ls -la /my/bpffs/
>> total 4
>> drwxrwxrwt  2 root root    0 Jul  2 00:27 .
>> drwxr-xr-x 19 root root 4096 Jul  2 00:09 ..
>> -rw-------  1 root root    0 Jul  2 00:27 maps.debug
>> -rw-------  1 root root    0 Jul  2 00:27 progs.debug
>>
>> The user mode driver will load BPF Type Formats, create BPF maps, populate BPF
>> maps, load two BPF programs, attach them to BPF iterators, and finally send two
>> bpf_link IDs back to the kernel.
>> The kernel will pin two bpf_links into newly mounted bpffs instance under
>> names "progs.debug" and "maps.debug". These two files become human readable.
>>
>> $ cat /my/bpffs/progs.debug
>>    id name            attached
>>    11 dump_bpf_map    bpf_iter_bpf_map
>>    12 dump_bpf_prog   bpf_iter_bpf_prog
>>    27 test_pkt_access
>>    32 test_main       test_pkt_access test_pkt_access
>>    33 test_subprog1   test_pkt_access_subprog1 test_pkt_access
>>    34 test_subprog2   test_pkt_access_subprog2 test_pkt_access
>>    35 test_subprog3   test_pkt_access_subprog3 test_pkt_access
>>    36 new_get_skb_len get_skb_len test_pkt_access
>>    37 new_get_skb_ifindex get_skb_ifindex test_pkt_access
>>    38 new_get_constant get_constant test_pkt_access
>>
>> The BPF program dump_bpf_prog() in iterators.bpf.c is printing this data about
>> all BPF programs currently loaded in the system. This information is unstable
>> and will change from kernel to kernel as ".debug" suffix conveys.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> [...]
>> diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
>> new file mode 100644
>> index 000000000000..b8ba5a9398ed
>> --- /dev/null
>> +++ b/kernel/bpf/preload/Kconfig
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +menuconfig BPF_PRELOAD
>> +    bool "Preload BPF file system with kernel specific program and map iterators"
>> +    depends on BPF
>> +    help
>> +      This builds kernel module with several embedded BPF programs that are
>> +      pinned into BPF FS mount point as human readable files that are
>> +      useful in debugging and introspection of BPF programs and maps.
>> +
>> +if BPF_PRELOAD
>> +config BPF_PRELOAD_UMD
>> +    tristate "bpf_preload kernel module with user mode driver"
>> +    depends on CC_CAN_LINK
>> +    depends on m || CC_CAN_LINK_STATIC
>> +    default m
>> +    help
>> +      This builds bpf_preload kernel module with embedded user mode driver.
>> +endif
> [...]
> When I applied this set locally to run build & selftests I noticed that the above
> kconfig will appear in the top-level menuconfig. This is how it looks in menuconfig:
> 
>    │ ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ │
>    │ │                                           General setup  --->                                                                                      │ │
>    │ │                                       [*] 64-bit kernel                                                                                            │ │
>    │ │                                           Processor type and features  --->                                                                        │ │
>    │ │                                           Power management and ACPI options  --->                                                                  │ │
>    │ │                                           Bus options (PCI etc.)  --->                                                                             │ │
>    │ │                                           Binary Emulations  --->                                                                                  │ │
>    │ │                                           Firmware Drivers  --->                                                                                   │ │
>    │ │                                       [*] Virtualization  --->                                                                                     │ │
>    │ │                                           General architecture-dependent options  --->                                                             │ │
>    │ │                                       [*] Enable loadable module support  --->                                                                     │ │
>    │ │                                       -*- Enable the block layer  --->                                                                             │ │
>    │ │                                           IO Schedulers  --->                                                                                      │ │
>    │ │                                       [ ] Preload BPF file system with kernel specific program and map iterators  ----                             │ │
>    │ │                                           Executable file formats  --->                                                                            │ │
>    │ │                                           Memory Management options  --->                                                                          │ │
>    │ │                                       [*] Networking support  --->                                                                                 │ │
>    │ │                                           Device Drivers  --->                                                                                     │ │
>    │ │                                           File systems  --->                                                                                       │ │
>    │ │                                           Security options  --->                                                                                   │ │
> [...]
> 
> I assume the original intention was to have it under 'general setup' on a similar level for
> the JIT settings, or is this intentional to have it at this high level next to 'networking
> support' and others?

Hm, my config has:

CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=y

I'm getting the following 3 warnings and build error below:

root@tank:~/bpf-next# make -j8 > /dev/null
arch/x86/hyperv/hv_apic.c: In function ‘hv_send_ipi_mask_allbutself’:
arch/x86/hyperv/hv_apic.c:236:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  }
  ^
make[3]: *** No rule to make target 'kernel/bpf/preload/./../../tools/lib/bpf/bpf.c', needed by 'kernel/bpf/preload/./../../tools/lib/bpf/bpf.o'.  Stop.
make[3]: *** Waiting for unfinished jobs....
kernel/bpf/preload/iterators/iterators.c: In function ‘main’:
kernel/bpf/preload/iterators/iterators.c:50:2: warning: ignoring return value of ‘dup’, declared with attribute warn_unused_result [-Wunused-result]
   dup(debug_fd);
   ^~~~~~~~~~~~~
kernel/bpf/preload/iterators/iterators.c:53:2: warning: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Wunused-result]
   read(from_kernel, &magic, sizeof(magic));
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/preload/iterators/iterators.c:85:2: warning: ignoring return value of ‘read’, declared with attribute warn_unused_result [-Wunused-result]
   read(from_kernel, &magic, sizeof(magic));
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [kernel/bpf/preload] Error 2
make[1]: *** [kernel/bpf] Error 2
make: *** [kernel] Error 2
make: *** Waiting for unfinished jobs....
[...]

Have you seen the target error before, what am I missing?

Thanks,
Daniel
