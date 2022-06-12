Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B64547CBF
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiFLWXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Jun 2022 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiFLWX0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Jun 2022 18:23:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4D2603
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 15:23:22 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNccf-1oOONn1lyV-00P7sO; Mon, 13 Jun 2022 00:22:48 +0200
Message-ID: <f038d6f9-b96b-0749-111c-33ac8939a1c0@i2se.com>
Date:   Mon, 13 Jun 2022 00:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>
Cc:     bpf@vger.kernel.org, jpalus@fastmail.com,
        regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: [BUG] null pointer dereference when loading bpf_preload on Raspberry
 Pi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jj30T8ghvSQPTo/veJ6pqA61fN+atWnJj62zBRCtM6MZPI2H2Ma
 ZEGqld1BX4/3dYCsX4GhvAVMz04HW4H7SWF1S5NSzmniLdAZWK2R+99LJPqj7a3a29wFq2R
 ziHcTce58IuBwifU2kkfwXuM/susOFaRgpD8wCWB2z7DvlBgXRWBi6GyOonFI6zlsoOGgkP
 rKu0TKodmGPlF/k6oMttw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YAN4JjkHQFs=:hI3ZpfELtu+D+pthjqxnUi
 VeubRTuActJdS+7yH8d5z9xTbEZl2qtKG6ondmmulQZFla8VaqzGPYKIJ0jIioWfEB8BCasod
 jCo28euHaRMbcLz7quL/aMjZiDMxhX0i+i0tlfSmfgk8JSM7+GWrlVgXZHiMh21hzEg7yqSnI
 LXRDFUCev3zaPmMj0xInCrZNbejIhSH2qvAsw8+6LuvwD7f7CUHY4VeZjDDjPE5fneKQJLT4Y
 4PQY2IlPKvWWg2enRqsqdOTca/9nFF655INMAcj+c5U79HtdhpoZqWU/njmbjTPlbzmYZYZmy
 7uUymOhu27dI8sH9RmDABP9EHxHgahHdmD4CiXQq1V4knF94fkY2qtwr4WlUKt09lpidEu44T
 3V0qqJwDP9R9Npzwu8xD1m1k5H2PSvikoR8eoRjM9QJnLeV9PetBilaqRbYuGvOfTe6n3LY0K
 lXobo3BX2Fn7qtvEDbUHFW4MBCC1CSdOLIsKcePj9dpDef2BOViGDHUVlQx7SlaVjOvSDgdFi
 u8UZHKEDXccyrESiAfcO998eaRnEoUtfPZWPfsRQsffWpQENF5KvrHSpK/3DTsFa+CL2Jb/Rg
 3tYq8lwfV0ZHJ0N/05V6tdZq+fKaKsnu2gL96+WDn/Wjb31a29T7p8YEnpQViPfccCQ6P5Fz/
 rdSawea2QoV8QfjKDzSZrf+FVR0YwA2CVav89D1oWPx28lRU//nby/0Ws0GO0aiUeHf0/fz87
 PCwanRsGvUb6Hu0e9RnDKDiCz7V72uzhfAuuyH1sY1q5kTp9wakQQ53J8JE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Jan Palus already reported this NULL pointer dereference on bugzilla 
[1], but i want to make sure this is noticed by the right people.

I've i boot my Raspberry Pi 3 B Plus with multi_v7_defconfig and the 
following config settings:

CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_PRELOAD_UMD=m

The kernel (Linux 5.18.3) crashes with a null pointer deference:

[    5.551587] Unable to handle kernel NULL pointer dereference at 
virtual address 00000048
[    5.564467] [00000048] *pgd=39a12835
[    5.572700] Internal error: Oops: 17 [#1] SMP ARM
[    5.581249] Modules linked in: bpf_preload(+)
[    5.589400] CPU: 1 PID: 85 Comm: modprobe Not tainted 5.18.3 #1
[    5.597966] usb 1-1.1: new high-speed USB device number 3 using dwc2
[    5.599251] Hardware name: BCM2835
[    5.616839] PC is at mmiocpy+0xc8/0x334
[    5.624534] LR is at copy_from_bpfptr+0x60/0x80
[    5.632973] pc : [<c06e77e8>]    lr : [<c03fee50>]    psr: 60000013
[    5.643146] sp : f1515b30  ip : f1515b48  fp : f1515b30
[    5.652331] r10: c328e040  r9 : f1515b68  r8 : 00000000
[    5.661506] r7 : c328e040  r6 : 00000002  r5 : 00000048  r4 : 00000002
[    5.672037] r3 : 0000003d  r2 : 00000000  r1 : 00000048  r0 : f1515c08
[    5.682572] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[    5.693670] Control: 10c5383d  Table: 023c406a  DAC: 00000051
[    5.703426] Register r0 information: 2-page vmalloc region starting 
at 0xf1514000 allocated at kernel_clone+0x98/0x27c
[    5.718310] Register r1 information: non-paged memory
[    5.727454] Register r2 information: NULL pointer
[    5.736205] Register r3 information: non-paged memory
[    5.738825] hub 1-1.1:1.0: USB hub found
[    5.745334] Register r4 information: non-paged memory
[    5.753345] hub 1-1.1:1.0: 3 ports detected
[    5.762358] Register r5 information: non-paged memory
[    5.762364] Register r6 information: non-paged memory
[    5.762368] Register r7 information: slab task_struct start c328e040 
pointer offset 0
[    5.800440] Register r8 information: NULL pointer
[    5.809029] Register r9 information: 2-page vmalloc region starting 
at 0xf1514000 allocated at kernel_clone+0x98/0x27c
[    5.823843] Register r10 information: slab task_struct start c328e040 
pointer offset 0
[    5.835847] Register r11 information: 2-page vmalloc region starting 
at 0xf1514000 allocated at kernel_clone+0x98/0x27c
[    5.850796] Register r12 information: 2-page vmalloc region starting 
at 0xf1514000 allocated at kernel_clone+0x98/0x27c
[    5.865664] Process modprobe (pid: 85, stack limit = 0x(ptrval))
[    5.867961] usb 1-1.3: new low-speed USB device number 4 using dwc2
[    5.875679] Stack: (0xf1515b30 to 0xf1516000)
[    5.894419] 5b20:                                     f1515c08 
00000002 00000000 c03fee50
[    5.906750] 5b40: 00000048 c051aa3d 00000000 c0402520 ef80327c 
ef80328c c2001180 f1515c08
[    5.919097] 5b60: c1a45808 00012cc0 00000048 c051aa3d c3022440 
00000001 c2ee9898 ffffffff
[    5.931435] 5b80: 00000000 f1515bb4 00000000 00000000 c2ee9a48 
5beb87ed c22c4c8c 00000000
[    5.943733] 5ba0: 00000001 c328e040 00000000 00012cc0 00000dc0 
00000000 f1515f38 c048fb58
[    5.956089] 5bc0: f1515c00 00000000 c328e040 c217c000 4a389946 
00000001 00012cc0 ef7ff780
[    5.968456] 5be0: 00000000 4a389946 00000005 00000001 00000001 
c328e2c0 c1804d8c c036a868
[    5.980852] 5c00: 00000801 ef7ff780 00000000 00000000 00000000 
00000000 00000000 00000000
[    5.993238] 5c20: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    6.005643] 5c40: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    6.018026] 5c60: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    6.030371] 5c80: 00000000 00000000 00000000 00000000 00000000 
00000000 00000019 5beb87ed
[    6.042719] 5ca0: c2004208 000017a8 00000048 c328e040 ffffffff 
00000000 c328e040 c328e040
[    6.055020] 5cc0: 00000000 c04043ec 00005dd9 7fffffff c2004208 
00000048 c051aa3d 5beb87ed
[    6.067330] 5ce0: 00005df9 000017a8 c328e040 c328e040 ffffffff 
00000000 c328e040 0000017b
[    6.079612] 5d00: 00000000 bf0031e0 00000002 00000004 000017a8 
00000001 00000000 00000000
[    6.091957] 5d20: 00000000 6f6c5f5f 72656461 70616d2e 00000000 
00000000 00000000 00000000
[    6.104254] 5d40: 00000000 00000000 00000000 00000000 c328e040 
c0380594 c1325856 00000001
[    6.116521] 5d60: c23729a0 c051b97c c23729a0 5beb87ed 00000000 
00000000 c200423c c1a4a551
[    6.117969] usb 1-1.1.2: new low-speed USB device number 5 using dwc2
[    6.128707] 5d80: c2372a50 00000001 c1325856 00000124 c2372a50 
c051b97c c2372a50 5beb87ed
[    6.128716] 5da0: 00000000 c22d1980 f1515e6c bf00322c ffffffff 
00000000 c2372a50 00000000
[    6.163743] 5dc0: 00000030 00000000 c2372a50 c0f179f0 c2348280 
ef87f900 c2001180 c328e040
[    6.176062] 5de0: c04897dc 00000013 c0464698 c22d1980 c22d1980 
00000062 00000cc0 c049d584
[    6.188380] 5e00: 00000cc0 c328e040 c22d1980 5beb87ed 00000001 
00000cc0 00000062 bf00a05c
[    6.200720] 5e20: ffffffff c1a4a9e0 c328e040 0000017b 00000000 
c0464698 c2348280 5beb87ed
[    6.213033] 5e40: 00000002 c328e040 bf007280 5beb87ed c22d1980 
bf007280 c328e040 c2348280
[    6.225441] 5e60: 00000000 bf00a0e0 00000001 c2348280 bf0040b7 
bf005860 000017a8 000008a8
[    6.237841] 5e80: 00000000 5beb87ed c328e040 bf00a000 c23481c0 
00000000 c1a4a9e0 c0301f30
[    6.250269] 5ea0: c357a3c0 c357a3c0 00000000 00000000 00000000 
00000000 c03c17f0 c23481c0
[    6.262591] 5ec0: c2001180 00000cc0 c03c17f0 c049d888 00000cc0 
00000000 c23481c0 5beb87ed
[    6.274942] 5ee0: 00000000 bf007040 0002d064 5beb87ed bf007040 
0002d064 c23481c0 c328e040
[    6.287336] 5f00: c0300324 c03c1810 bf007040 0000008f 00000000 
0002d064 00000000 c03c3ce4
[    6.299841] 5f20: f1515f34 7fffffff 00000000 00000002 c353e040 
f151b000 f151d8cf f151d940
[    6.312151] 5f40: f151b000 00003f1c f151e904 f151e760 f151e25c 
00005000 00005150 00002884
[    6.324534] 5f60: 00005241 00000000 00000000 00000000 00002874 
00000024 00000025 0000001b
[    6.336923] 5f80: 00000000 00000017 00000000 5beb87ed 00000000 
bbbecb00 000417d8 00000000
[    6.349310] 5fa0: 0000017b c03000c0 bbbecb00 000417d8 00000000 
0002d064 00000000 0002ec3c
[    6.361662] 5fc0: bbbecb00 000417d8 00000000 0000017b 00042ce0 
00000000 00042c38 00000000
[    6.374053] 5fe0: be8e3a88 be8e3a78 00022cb8 b6cb3ae0 60000010 
00000000 00000000 00000000
[    6.386437]  mmiocpy from copy_from_bpfptr+0x60/0x80
[    6.395558]  copy_from_bpfptr from __sys_bpf+0x78/0x1d30
[    6.404992]  __sys_bpf from bpf_sys_bpf+0x214/0x238
[    6.413982]  bpf_sys_bpf from skel_map_create.constprop.0+0x60/0x80 
[bpf_preload]
[    6.425677]  skel_map_create.constprop.0 [bpf_preload] from 
bpf_load_and_run.constprop.0+0x2c/0x1f8 [bpf_preload]
[    6.440256]  bpf_load_and_run.constprop.0 [bpf_preload] from 
load+0xe0/0x1000 [bpf_preload]
[    6.452929]  load [bpf_preload] from do_one_initcall+0x68/0x170
[    6.463114]  do_one_initcall from do_init_module+0x3c/0x1e0
[    6.472955]  do_init_module from sys_finit_module+0xc8/0xd4
[    6.482802]  sys_finit_module from ret_fast_syscall+0x0/0x54
[    6.492679] Exception stack(0xf1515fa8 to 0xf1515ff0)
[    6.501975] 5fa0:                   bbbecb00 000417d8 00000000 
0002d064 00000000 0002ec3c
[    6.514476] 5fc0: bbbecb00 000417d8 00000000 0000017b 00042ce0 
00000000 00042c38 00000000
[    6.526999] 5fe0: be8e3a88 be8e3a78 00022cb8 b6cb3ae0
[    6.536392] Code: e480e004 e8bd0360 e1b02f82 14d13001 (24d14001)
[    6.546878] ---[ end trace 0000000000000000 ]---

It would be nice to get a hint, how to narrow down or which commit might 
trigger this issue.

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=216105

