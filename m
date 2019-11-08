Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0BF5BF2
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 00:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfKHXmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 18:42:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:58932 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHXmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 18:42:39 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iTDtk-0002o0-0v; Sat, 09 Nov 2019 00:42:36 +0100
Received: from [178.197.248.27] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iTDtj-0008v1-LY; Sat, 09 Nov 2019 00:42:35 +0100
Subject: Fwd: [Bug 205459] New: mips: bpf: test_bpf failures, eBPF JIT on
 mips32 outputs invalid 64-bit insns
References: <bug-205459-65011@https.bugzilla.kernel.org/>
To:     Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        David Daney <david.daney@cavium.com>
Cc:     bpf@vger.kernel.org, itugrok@yahoo.com
From:   Daniel Borkmann <daniel@iogearbox.net>
X-Forwarded-Message-Id: <bug-205459-65011@https.bugzilla.kernel.org/>
Message-ID: <073db6b1-9f0e-4d2e-78bd-68698a63e608@iogearbox.net>
Date:   Sat, 9 Nov 2019 00:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bug-205459-65011@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25627/Fri Nov  8 11:02:39 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Cc MIPS folks ]

Hassan, James, Paul, others, please take a look. Thanks!

-------- Forwarded Message --------
Subject: [Bug 205459] New: mips: bpf: test_bpf failures, eBPF JIT on mips32 outputs invalid 64-bit insns
Date: Thu, 07 Nov 2019 06:41:21 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: daniel@iogearbox.net

https://bugzilla.kernel.org/show_bug.cgi?id=205459

             Bug ID: 205459
            Summary: mips: bpf: test_bpf failures, eBPF JIT on mips32
                     outputs invalid 64-bit insns
            Product: Networking
            Version: 2.5
     Kernel Version: 5.2.17
           Hardware: Mips32
                 OS: Linux
               Tree: Mainline
             Status: NEW
           Severity: high
           Priority: P1
          Component: Other
           Assignee: stephen@networkplumber.org
           Reporter: itugrok@yahoo.com
         Regression: No

Created attachment 285809
   --> https://bugzilla.kernel.org/attachment.cgi?id=285809&action=edit
EXCEPTION/failures: kernel 5.2.17/mips32 (Debian 10.1)

Summary:
========

Linux 5.2.x added an eBPF JIT for MIPS32 (yay!). Based on discussion of the
original submission (https://www.spinics.net/lists/mips/msg77008.html) I
expected that:

   (1) all tests from module test_bpf.ko would pass, and
   (2) any previously JITed tests (i.e. cBPF) would still be JITed.

However, I can't reproduce the above based on my testing as per the attached
log.

Point (2) doesn't stand since the first ~30 tests are not JITed, but were
previously cBPF JITed for the most part.

As for point (1), the full test set doesn't complete, but errors out early on
with a "Reserved instruction in kernel code[#1]" error. Manually hopping
through some of the tests yields the same error for many:

   #68 ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff jited:1
   #73 ALU_ADD_X: 1 + 2 = 3 jited:1
   #74 ALU_ADD_X: 1 + 4294967294 = 4294967295 jited:1
   #75 ALU_ADD_X: 2 + 4294967294 = 0 jited:1
   #79 ALU_ADD_K: 1 + 2 = 3 jited:1
   (.. and so on ...)

Disassembling the JITed code for test #68 shows incorrect MIPS64 instructions:

   24 03 00 20     li    v1,32
   34 05 ff ff     li    a1,0xffff
   00 05 2c 38     dsll  a1,a1,0x10      <=== MIPS64 insn
   34 a5 ff ff     ori   a1,a1,0xffff
   00 05 2c 38     dsll  a1,a1,0x10      <=== MIPS64 insn
   34 06 ff ff     li    a2,0xffff
   00 06 34 38     dsll  a2,a2,0x10      <=== MIPS64 insn
   34 c6 ff ff     ori   a2,a2,0xffff

Since this was tested in the past, I'm really hoping there's a simple solution
to these problems, or else a case of "operator error". A review by someone more
knowledgeable with the MIPS32 eBPF JIT would be appreciated.

Steps to Reproduce:
===================

   # sysctl net.core.bpf_jit_enable=1
   # modprobe test_bpf
   <Kernel log with "Reserved instruction" exception>


Affected Systems Tested:
========================

   Debian 10.1 on QEMU/malta(mips32_be) [distro kernel 5.2.17-1~bpo10+1
(2019-09-30)]


Kernel Logs:
============

Boot log with test results up to first failure is attached.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
