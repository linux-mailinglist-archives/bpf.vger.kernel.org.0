Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AE352714
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhDBHsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 03:48:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30397 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233901AbhDBHss (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 03:48:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBXHJ34wNz9ty2d;
        Fri,  2 Apr 2021 09:48:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DZrnQE_mi35K; Fri,  2 Apr 2021 09:48:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBXHJ2DY7z9ty2c;
        Fri,  2 Apr 2021 09:48:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A7DB8BB5D;
        Fri,  2 Apr 2021 09:48:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iF9utbFYpilL; Fri,  2 Apr 2021 09:48:45 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB49D8B78C;
        Fri,  2 Apr 2021 09:48:44 +0200 (CEST)
To:     bpf <bpf@vger.kernel.org>, iii@linux.ibm.com
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: selftests/bpf - Error: failed to open BPF object file: Endian
 mismatch
Message-ID: <21e66a09-514f-f426-b9e2-13baab0b938b@csgroup.eu>
Date:   Fri, 2 Apr 2021 09:48:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm having hard time cross-building bpf selftests on an x86 for a powerpc target.

[root@PC-server-ldb bpf]# make CROSS_COMPILE=ppc-linux- ARCH=powerpc V=1
/root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/host-tools/sbin/bpftool gen skeleton 
/root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/atomic_bounds.o > 
/root/gen_ldb/linux-powerpc/tools/testing/selftests/bpf/atomic_bounds.skel.h
libbpf: elf: endianness mismatch in atomic_bounds.
Error: failed to open BPF object file: Endian mismatch

[root@PC-server-ldb bpf]# file atomic_bounds.o
atomic_bounds.o: ELF 64-bit MSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped

Seems like the just-built host bpftool doesn't take into account target's endianness.

I see the patch https://github.com/torvalds/linux/commit/313e7f6f ("selftest/bpf: Use -m{little, 
big}-endian for clang") in bpf selftest to enable cross-compilation, but it seems it is not enough.

What should I do to get bpftool work with the target's endianness ?

Thanks
Christophe
