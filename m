Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D513B362E81
	for <lists+bpf@lfdr.de>; Sat, 17 Apr 2021 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhDQIQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Apr 2021 04:16:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1364 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQIQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Apr 2021 04:16:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FMmBL3B3mz9vBnD;
        Sat, 17 Apr 2021 10:16:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KdXChgWPk-BP; Sat, 17 Apr 2021 10:16:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FMmBL21vRz9vBnC;
        Sat, 17 Apr 2021 10:16:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 312848B777;
        Sat, 17 Apr 2021 10:16:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id efFKgaQ79CvE; Sat, 17 Apr 2021 10:16:27 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BFFF8B75B;
        Sat, 17 Apr 2021 10:16:24 +0200 (CEST)
Subject: Re: [PATCH bpf-next 1/2] bpf: Remove bpf_jit_enable=2 debugging mode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Will Deacon <will@kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, paulburton@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-mips@vger.kernel.org, grantseltzer@gmail.com,
        Xi Wang <xi.wang@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Luke Nelson <luke.r.nels@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        KP Singh <kpsingh@kernel.org>, iecedge@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Yonghong Song <yhs@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>, tsbogend@alpha.franken.de,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Wang YanQing <udknight@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, bpf <bpf@vger.kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20210415093250.3391257-1-Jianlin.Lv@arm.com>
 <9c4a78d2-f73c-832a-e6e2-4b4daa729e07@iogearbox.net>
 <d3949501-8f7d-57c4-b3fe-bcc3b24c09d8@isovalent.com>
 <CAADnVQJ2oHbYfgY9jqM_JMxUsoZxaNrxKSVFYfgCXuHVpDehpQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0dea05ba-9467-0d84-4515-b8766f60318e@csgroup.eu>
Date:   Sat, 17 Apr 2021 10:16:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ2oHbYfgY9jqM_JMxUsoZxaNrxKSVFYfgCXuHVpDehpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 16/04/2021 à 01:49, Alexei Starovoitov a écrit :
> On Thu, Apr 15, 2021 at 8:41 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2021-04-15 16:37 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
>>> On 4/15/21 11:32 AM, Jianlin Lv wrote:
>>>> For debugging JITs, dumping the JITed image to kernel log is discouraged,
>>>> "bpftool prog dump jited" is much better way to examine JITed dumps.
>>>> This patch get rid of the code related to bpf_jit_enable=2 mode and
>>>> update the proc handler of bpf_jit_enable, also added auxiliary
>>>> information to explain how to use bpf_jit_disasm tool after this change.
>>>>
>>>> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
>>
>> Hello,
>>
>> For what it's worth, I have already seen people dump the JIT image in
>> kernel logs in Qemu VMs running with just a busybox, not for kernel
>> development, but in a context where buiding/using bpftool was not
>> possible.
> 
> If building/using bpftool is not possible then majority of selftests won't
> be exercised. I don't think such environment is suitable for any kind
> of bpf development. Much so for JIT debugging.
> While bpf_jit_enable=2 is nothing but the debugging tool for JIT developers.
> I'd rather nuke that code instead of carrying it from kernel to kernel.
> 

When I implemented JIT for PPC32, it was extremely helpfull.

As far as I understand, for the time being bpftool is not usable in my environment because it 
doesn't support cross compilation when the target's endianess differs from the building host 
endianess, see discussion at 
https://lore.kernel.org/bpf/21e66a09-514f-f426-b9e2-13baab0b938b@csgroup.eu/

That's right that selftests can't be exercised because they don't build.

The question might be candid as I didn't investigate much about the replacement of "bpf_jit_enable=2 
debugging mode" by bpftool, how do we use bpftool exactly for that ? Especially when using the BPF 
test module ?

