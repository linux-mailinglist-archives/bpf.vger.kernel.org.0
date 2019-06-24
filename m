Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3774FF04
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 04:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFXCFB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jun 2019 22:05:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:38790 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfFXCFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Jun 2019 22:05:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 17:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,410,1557212400"; 
   d="scan'208";a="163444402"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2019 17:59:28 -0700
Subject: Re: [selftests/bpf] 69d96519db:
 kernel_selftests.bpf.test_socket_cookie.fail
To:     Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        bpf <bpf@vger.kernel.org>, lkp@01.org
References: <20190621084040.GU7221@shao2-debian>
 <20190621161039.GF1383@mini-arch>
 <CAEf4Bzaajc27=YyMaOa8UFRz=xE7y6E+qLbPBPbvLADO2peXQg@mail.gmail.com>
 <20190621222745.GH1383@mini-arch>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f3aa0dc2-c959-1166-8b09-84781363f0e0@intel.com>
Date:   Mon, 24 Jun 2019 08:59:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621222745.GH1383@mini-arch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/22/19 6:27 AM, Stanislav Fomichev wrote:
> On 06/21, Andrii Nakryiko wrote:
>> )
>>
>> On Fri, Jun 21, 2019 at 9:11 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
>>> On 06/21, kernel test robot wrote:
>>>> FYI, we noticed the following commit (built with gcc-7):
>>>>
>>>> commit: 69d96519dbf0bfa1868dc8597d4b9b2cdeb009d7 ("selftests/bpf: convert socket_cookie test to sk storage")
>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>
>>>> in testcase: kernel_selftests
>>>> with following parameters:
>>>>
>>>>        group: kselftests-00
>>>>
>>>> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>
>>>>
>>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>>
>>>> # selftests: bpf: test_socket_cookie
>>>> # libbpf: failed to create map (name: 'socket_cookies'): Invalid
>>>> # argument
>>> Another case of old clang trying to create a map that depends on BTF?
>>> Should we maybe switch those BTF checks in the kernel to return
>>> EOPNOTSUPP to make it easy to diagnose?
>> For older compilers that don't generate DATASEC/VAR, you'll see a clear message:
>>
>> libbpf: DATASEC '.maps' not found.
>>
>> So this must be something else. I just confirmed with clang version
>> 7.0.20180201 that for ./test_socket_cookie that's the first line
>> that's emitted on failure.
> Thanks for checking, I also took a look at the attached kernel_selftests.xz,
> here is what it has:
> 2019-06-21 11:58:35 ln -sf /usr/bin/clang-6.0 /usr/bin/clang
> 2019-06-21 11:58:35 ln -sf /usr/bin/llc-6.0 /usr/bin/llc
> ...
> # BTF libbpf test[1] (test_btf_haskv.o): SKIP. No ELF .BTF found
> # BTF libbpf test[2] (test_btf_nokv.o): SKIP. No ELF .BTF found
> ...
> # Test case #0 (btf_dump_test_case_syntax): test_btf_dump_case:71:FAIL
> # failed to load test BTF: -2
> # Test case #1 (btf_dump_test_case_ordering): test_btf_dump_case:71:FAIL
> # failed to load test BTF: -2
> ...
>
> And so on. So there is clearly an old clang that doesn't emit any
> BTF. And I also don't see your recent abd29c931459 before 69d96519dbf0 in
> linux-next, that's why it doesn't complain about missing/corrupt BTF.
>
> We need to convince lkp people to upgrade clang, otherwise, I suppose,
> we'll get more of these reportings after your recent df0b77925982 :-(

Thanks for the clarification, we'll upgrade clang asap.

Best Regards,
Rong Chen


>
>>>> # libbpf: failed to load object './socket_cookie_prog.o'
>>>> # (test_socket_cookie.c:149: errno: Invalid argument) Failed to load
>>>> # ./socket_cookie_prog.o
>>>> # FAILED
>>>> not ok 15 selftests: bpf: test_socket_cookie
>>>>
>>>>
>>>>
>>>>
>>>> To reproduce:
>>>>
>>>>          # build kernel
>>>>        cd linux
>>>>        cp config-5.2.0-rc2-00598-g69d9651 .config
>>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
>>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
>>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
>>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
>>>>        make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
>>>>
>>>>
>>>>          git clone https://github.com/intel/lkp-tests.git
>>>>          cd lkp-tests
>>>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>>>
>>>>
>>>>
>>>> Thanks,
>>>> Rong Chen
>>>>
>> <mega snip>
