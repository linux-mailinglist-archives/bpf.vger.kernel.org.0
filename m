Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91152388B
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbiEKQRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbiEKQRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 12:17:37 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989B3EB92;
        Wed, 11 May 2022 09:17:32 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nop1i-000Ajc-RB; Wed, 11 May 2022 18:17:26 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nop1i-0003tN-Ja; Wed, 11 May 2022 18:17:26 +0200
Subject: Re: [PATCH] bpf.h: fix clang compiler warning with
 unpriv_ebpf_notify()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>
References: <20220509203623.3856965-1-mcgrof@kernel.org>
 <YnvdOAaYmhNiA5WN@bombadil.infradead.org>
 <CAADnVQLCvjqphpJDkz-5bpJLs3k_PRH1JcwehCRLrWYvsA9ENw@mail.gmail.com>
 <YnvflsM1t5vL/ViP@bombadil.infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3e3ed3d1-937b-a715-376d-43a8b7485f68@iogearbox.net>
Date:   Wed, 11 May 2022 18:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YnvflsM1t5vL/ViP@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26538/Wed May 11 10:06:03 2022)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/22 6:08 PM, Luis Chamberlain wrote:
> On Wed, May 11, 2022 at 09:03:13AM -0700, Alexei Starovoitov wrote:
>> On Wed, May 11, 2022 at 8:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> On Mon, May 09, 2022 at 01:36:23PM -0700, Luis Chamberlain wrote:
>>>> The recent commit "bpf: Move BPF sysctls from kernel/sysctl.c to BPF core"
>>>> triggered 0-day to issue an email for what seems to have been an old
>>>> clang warning. So this issue should have existed before as well, from
>>>> what I can tell. The issue is that clang expects a forward declaration
>>>> for routines declared as weak while gcc does not.
>>>>
>>>> This can be reproduced with 0-day's x86_64-randconfig-c007
>>>> https://download.01.org/0day-ci/archive/20220424/202204240008.JDntM9cU-lkp@intel.com/config
>>>>
>>>> And using:
>>>>
>>>> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
>>>> Compiler will be installed in /home/mcgrof/0day
>>>> make --keep-going HOSTCC=/home/mcgrof/0day/clang/bin/clang CC=/home/mcgrof/0day/clang/bin/clang LD=/home/mcgrof/0day/clang/bin/ld.lld HOSTLD=/home/mcgrof/0day/clang/bin/ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=x86_64-linux-gnu- --jobs=24 W=1 ARCH=x86_64 SHELL=/bin/bash kernel/bpf/syscall.o
>>>>    DESCEND objtool
>>>>    CALL    scripts/atomic/check-atomics.sh
>>>>    CALL    scripts/checksyscalls.sh
>>>>    CC      kernel/bpf/syscall.o
>>>> kernel/bpf/syscall.c:4944:13: warning: no previous prototype for function 'unpriv_ebpf_notify' [-Wmissing-prototypes]
>>>> void __weak unpriv_ebpf_notify(int new_state)
>>>>              ^
>>>> kernel/bpf/syscall.c:4944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>>> void __weak unpriv_ebpf_notify(int new_state)
>>>> ^
>>>> static
>>>>
>>>> Fixes: 2900005ea287 ("bpf: Move BPF sysctls from kernel/sysctl.c to BPF core")
>>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>>> ---
>>>>
>>>> Daniel,
>>>>
>>>> Given what we did fore 2900005ea287 ("bpf: Move BPF sysctls from
>>>> kernel/sysctl.c to BPF core") where I had pulled pr/bpf-sysctl a
>>>> while ago into sysctl-next and then merged the patch in question,
>>>> should I just safely carry this patch onto sysctl-next? Let me know
>>>> how you'd like to proceed.
>>>>
>>>> Also, it wasn't clear if putting this forward declaration on
>>>> bpf.h was your ideal preference.
>>>
>>> After testing this on sysctl-testing without issues going to move this
>>> to sysctl-next now.
>>
>> Hmm. No.
>> A similar patch should be in tip already. You have to wait
>> for it to go through Linus's tree and back to whatever tree you use.
> 
> I'm a bit confused, the patch in question which my patch fixes should only
> be in my sysctl-next tree at this point, not in Linus's tree.

Borislav was planning to route it via tip tree, maybe confusion was that the
fix in the link below is from Josh:

https://lore.kernel.org/bpf/CAADnVQKjfQMG_zFf9F9P7m0UzqESs7XoRy=udqrDSodxa8yBpg@mail.gmail.com/

But I presume this is routed as fix to Linus, so should land in both sysctl
and bpf tree at some point after re-sync.

Thanks,
Daniel
