Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884AB1CDF0B
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEKPaa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 11:30:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:56218 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgEKPaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 May 2020 11:30:30 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYANv-0004eg-Dr; Mon, 11 May 2020 17:30:27 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYANv-000RLA-5w; Mon, 11 May 2020 17:30:27 +0200
Subject: Re: bpf_iter build breakage ([bpf-next:master] BUILD REGRESSION
 b4563facdcae55c83039d5efcc3b45a63da14d2f)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     ast@fb.com, bpf@vger.kernel.org, yhs@fb.com
References: <5eb7cca0.uAcHv05yEvyTrNMt%lkp@intel.com>
 <35f29d56-c0cb-ca56-646b-d3338a38fd2b@iogearbox.net>
 <CAADnVQ+mrJa=TUL0UmsN3G2mM7=6GDdeUH_FkCtC15NSb8y6iQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a6843c5b-1995-87bb-0e65-b64581124cf3@iogearbox.net>
Date:   Mon, 11 May 2020 17:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+mrJa=TUL0UmsN3G2mM7=6GDdeUH_FkCtC15NSb8y6iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25809/Mon May 11 14:16:55 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/20 8:55 AM, Alexei Starovoitov wrote:
> On Sun, May 10, 2020 at 11:28 PM Daniel Borkmann <daniel@iogearbox.net>
> wrote:
> 
>> Yonghong, ptal, thanks.
> 
> Not a breakage. Just ignore it.

Lets see whether kbuild-bot will be stuck in `BUILD REGRESSION` on bpf-next
master then. Otherwise we'd need to check with kbuild-bot folks to manually
fix it.

>> -------- Forwarded Message --------
>> Subject: [bpf-next:master] BUILD REGRESSION
>> b4563facdcae55c83039d5efcc3b45a63da14d2f
>> Date: Sun, 10 May 2020 17:42:56 +0800
>> From: kbuild test robot <lkp@intel.com>
>> To: BPF build status <bpf@iogearbox.net>
>>
>> tree/branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git  master
>> branch HEAD: b4563facdcae55c83039d5efcc3b45a63da14d2f  bpf, runqslower:
>> include proper uapi/bpf.h
>>
>> Error/Warning in current branch:
>>
>> kernel/bpf/bpf_iter.c:148:15-20: ERROR: invalid reference to the index
>> variable of the iterator on line 133
>>
>> Error/Warning ids grouped by kconfigs:
>>
>> recent_errors
>> `-- x86_64-allyesconfig
>>       `--
>> kernel-bpf-bpf_iter.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
>>
>> elapsed time: 483m
>>
>> configs tested: 101
>> configs skipped: 1
>>
>> arm                                 defconfig
>> arm                              allyesconfig
>> arm                              allmodconfig
>> arm                               allnoconfig
>> arm64                            allyesconfig
>> arm64                               defconfig
>> arm64                            allmodconfig
>> arm64                             allnoconfig
>> sparc                            allyesconfig
>> m68k                             allyesconfig
>> i386                              allnoconfig
>> i386                             allyesconfig
>> i386                                defconfig
>> i386                              debian-10.3
>> ia64                             allmodconfig
>> ia64                                defconfig
>> ia64                              allnoconfig
>> ia64                             allyesconfig
>> m68k                             allmodconfig
>> m68k                              allnoconfig
>> m68k                           sun3_defconfig
>> m68k                                defconfig
>> nios2                               defconfig
>> nios2                            allyesconfig
>> openrisc                            defconfig
>> c6x                              allyesconfig
>> c6x                               allnoconfig
>> openrisc                         allyesconfig
>> nds32                               defconfig
>> nds32                             allnoconfig
>> csky                             allyesconfig
>> csky                                defconfig
>> alpha                               defconfig
>> alpha                            allyesconfig
>> xtensa                           allyesconfig
>> h8300                            allyesconfig
>> h8300                            allmodconfig
>> xtensa                              defconfig
>> arc                                 defconfig
>> arc                              allyesconfig
>> microblaze                       allyesconfig
>> sh                               allmodconfig
>> sh                                allnoconfig
>> microblaze                        allnoconfig
>> mips                             allyesconfig
>> mips                              allnoconfig
>> mips                             allmodconfig
>> parisc                            allnoconfig
>> parisc                              defconfig
>> parisc                           allyesconfig
>> parisc                           allmodconfig
>> powerpc                             defconfig
>> powerpc                          allyesconfig
>> powerpc                          rhel-kconfig
>> powerpc                          allmodconfig
>> powerpc                           allnoconfig
>> i386                 randconfig-a006-20200510
>> i386                 randconfig-a005-20200510
>> i386                 randconfig-a003-20200510
>> i386                 randconfig-a001-20200510
>> i386                 randconfig-a004-20200510
>> i386                 randconfig-a002-20200510
>> x86_64               randconfig-a016-20200510
>> x86_64               randconfig-a012-20200510
>> x86_64               randconfig-a015-20200510
>> x86_64               randconfig-a013-20200510
>> x86_64               randconfig-a014-20200510
>> x86_64               randconfig-a011-20200510
>> i386                 randconfig-a012-20200510
>> i386                 randconfig-a016-20200510
>> i386                 randconfig-a014-20200510
>> i386                 randconfig-a011-20200510
>> i386                 randconfig-a013-20200510
>> i386                 randconfig-a015-20200510
>> x86_64               randconfig-a005-20200510
>> x86_64               randconfig-a003-20200510
>> x86_64               randconfig-a001-20200510
>> riscv                            allyesconfig
>> riscv                             allnoconfig
>> riscv                               defconfig
>> riscv                            allmodconfig
>> s390                             allyesconfig
>> s390                              allnoconfig
>> s390                             allmodconfig
>> s390                                defconfig
>> sparc                               defconfig
>> sparc64                             defconfig
>> sparc64                           allnoconfig
>> sparc64                          allyesconfig
>> sparc64                          allmodconfig
>> um                               allmodconfig
>> um                                allnoconfig
>> um                               allyesconfig
>> um                                  defconfig
>> x86_64                                   rhel
>> x86_64                               rhel-7.6
>> x86_64                    rhel-7.6-kselftests
>> x86_64                         rhel-7.2-clear
>> x86_64                                    lkp
>> x86_64                              fedora-25
>> x86_64                                  kexec
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 

