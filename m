Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4A3600B2
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 06:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhDOEBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 00:01:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57962 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229450AbhDOEBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 00:01:51 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxPcmTundgzikIAA--.11464S3;
        Thu, 15 Apr 2021 12:01:24 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [QUESTION] Will the pahole tar source code with corresponding libbpf
 submodule codes be released as well in the future?
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2de4aad5-fa9e-1c39-3c92-9bb9229d0966@loongson.cn>
Date:   Thu, 15 Apr 2021 12:01:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxPcmTundgzikIAA--.11464S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UGr1UKFyxJFyfAr15XFb_yoW5XFy8pF
        Z3J3Z5tr45Kw4FyrWkA34xWr4YqrZ5tr4aqa4Skr4UCrZ8Xa1xWan2vF43urZxAwn8Jay2
        qF17CF4UCFy8Wr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(1) tools/bpf/bpftool build failed due to the following reason:

Error: failed to load BTF from /boot/vmlinux-5.12.0-rc2: No such file or 
directory
make: *** [Makefile:158: vmlinux.h] Error 2

(2) When set CONFIG_DEBUG_INFO_BTF=y, failed to generate BTF for vmlinux
due to pahole is not available

BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
make: *** [Makefile:1197: vmlinux] Error 1

(3) When build pahole from tar.gz source code, it still failed
due to no libbpf submodule.

loongson@linux:~$ wget 
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/snapshot/pahole-1.21.tar.gz
loongson@linux:~$ tar xf pahole-1.21.tar.gz
loongson@linux:~$ cd pahole-1.21
loongson@linux:~/pahole-1.21$ mkdir build
loongson@linux:~/pahole-1.21$ cd build/
loongson@linux:~/pahole-1.21/build$ cmake -D__LIB=lib ..
-- The C compiler identification is GNU 10.2.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Checking availability of DWARF and ELF development libraries
-- Looking for dwfl_module_build_id in elf
-- Looking for dwfl_module_build_id in elf - found
-- Found dwarf.h header: /usr/include
-- Found elfutils/libdw.h header: /usr/include
-- Found libdw library: /usr/lib/mips64el-linux-gnuabi64/libdw.so
-- Found libelf library: /usr/lib/mips64el-linux-gnuabi64/libelf.so
-- Checking availability of DWARF and ELF development libraries - done
-- Found ZLIB: /usr/lib/mips64el-linux-gnuabi64/libz.so (found version 
"1.2.11")
CMake Error at CMakeLists.txt:60 (message):
   The submodules were not downloaded! GIT_SUBMODULE was turned off or 
failed.
   Please update submodules and try again.

-- Configuring incomplete, errors occurred!
See also "/home/loongson/pahole-1.21/build/CMakeFiles/CMakeOutput.log".

(4) I notice that the pahole git source code can build successful because
it will clone libbpf automatically:

-- Submodule update
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for 
path 'lib/bpf'
Cloning into '/home/loongson/pahole/lib/bpf'...
Submodule path 'lib/bpf': checked out 
'986962fade5dfa89c2890f3854eb040d2a64ab38'
-- Submodule update - done

(5) So Will the pahole tar source code with corresponding libbpf 
submodule codes
be released as well in the future? just like bcc:
https://github.com/iovisor/bcc/releases
https://github.com/iovisor/bcc/commit/708f786e3784dc32570a079f2ed74c35731664ea

Thanks,
Tiezhu

