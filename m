Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D852353155
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhDBWor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhDBWoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 18:44:46 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FDC061788
        for <bpf@vger.kernel.org>; Fri,  2 Apr 2021 15:44:45 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FBw970ZWnzQjgh
        for <bpf@vger.kernel.org>; Sat,  3 Apr 2021 00:44:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=felix-maurer.de;
        s=MBO0001; t=1617403481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7pE67o75myXAPGBAQzbf1XwjvSdb9nQVY2TvdeRCw+k=;
        b=odQtc0+FKtaoYiOEapXFP4lku1XkZ9t2AvouX8b6o+wvcH8ayXgTmbMZnZ0qLyKtikQekX
        YmPMfFDAQDzM4M0cg/SmVxhQ4Fkux74HLoz5QnratYjiYS71zshTfe722ZBjMb/osUafYU
        m63qqqFGHEF2bRkhxO7IJvHYy+VkzhnJ5OTkYYDlxCDI0lAS84eDHkSRVfawANZiQN7OrW
        PY+fJcGjzYYIz/qp20miieSrZ4StTgvhYM9kQ6sqAkhkCYnpQqqmc79REJI98ZEmiS5fUz
        9AYCekCAUqrlodQespIX2q9qz119imj1P1bmUlsYgvD1xgm9WlnltlUAo36hWw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id kt0cn8uHDAJC for <bpf@vger.kernel.org>;
        Sat,  3 Apr 2021 00:44:39 +0200 (CEST)
To:     bpf@vger.kernel.org
From:   Felix Maurer <felix@felix-maurer.de>
Subject: libbpf: failed to find BTF ID for ksym
Message-ID: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
Date:   Sat, 3 Apr 2021 00:44:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.80 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1485917BD
X-Rspamd-UID: 5dc44d
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I am working on a tracing tool for which I need know the address of some 
kernel data structures. The tool should be CO-RE and I am using libbpf 
(through the libbpf-rs Rust bindings, but this is not the issue I 
assume). However, I am having trouble to use ksyms with libbpf.

To get the address of the data structure (in my case 
skbuff_fclone_cache), I use an extern ksym declaration in my BPF code 
like this:

extern struct kmem_cache *skbuff_fclone_cache __ksym;

This compiles just fine, opening the compiled bytecode with libbpf also 
works. From the debug log[1], it can be seen that the extern is 
identified. However, loading the object fails with the following error:

libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: extern (ksym) 'skbuff_fclone_cache': failed to find BTF ID in 
kernel BTF(s).
libbpf: failed to load object 'skbuffTime_bpf'
libbpf: failed to load BPF skeleton 'skbuffTime_bpf': -22

I found, that libbpf has a check if it needs to load the BTF information 
or /proc/kallsyms. In my case, it loads the BTF information and cannot 
find the ksym in there. Searching in the BTF from the running kernel 
(bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep 
"skbuff_fclone_cache") indeed gives no results. However, it can be found 
in kallsyms (cat /proc/kallsyms | grep "skbuff_fclone_cache" gives one 
result). Therefore, a resolution of the ksym with kallsyms will probably 
work but is not even attempted.

Now, I am not really sure where the root cause of the issue can be 
found. Should the ksym be present in the BTF information (i.e., the 
issue comes from building the kernel) or is the BPF object file broken 
(i.e., an issue with clang) or is the identification of the ksym wrong 
(i.e., the issue is in the libbpf loading code). Or something completely 
different? Does anyone have a hint on what goes wrong here?

Some version information:
I am running Ubuntu 20.04, the kernel version is 5.8.0-45-generic (from 
HWE). The kernel has been build on the system to enable BTF; otherwise, 
the configuration is identical to the Ubuntu upstream. It has been 
compiled with gcc 9.3.0 and pahole v1.17. I am compiling the BPF code 
with clang 10.0.0 and tested with different libbpf versions from the 
GitHub mirror (0.2, 0.3, and 99bc17633).

Thank you already for taking a look at my issue!

Best regards,
Felix Maurer



[1]: Full libbpf opening debug log:
libbpf: loading object 'skbuffTime_bpf' from buffer
libbpf: elf: section(3) fexit/kmem_cache_alloc, size 176, link 0, flags 
6, type=1
libbpf: sec 'fexit/kmem_cache_alloc': found program 'kmem_cache_alloc' 
at insn offset 0 (0 bytes), code size 22 insns (176 bytes)
libbpf: elf: section(4) .relfexit/kmem_cache_alloc, size 32, link 26, 
flags 0, type=9
libbpf: elf: section(5) fexit/kmem_cache_alloc_node, size 176, link 0, 
flags 6, type=1
libbpf: sec 'fexit/kmem_cache_alloc_node': found program 
'kmem_cache_alloc_node' at insn offset 0 (0 bytes), code size 22 insns 
(176 bytes)
libbpf: elf: section(6) .relfexit/kmem_cache_alloc_node, size 32, link 
26, flags 0, type=9
libbpf: elf: section(7) license, size 4, link 0, flags 3, type=1
libbpf: license of skbuffTime_bpf is GPL
libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=1
libbpf: elf: section(17) .BTF, size 4419, link 0, flags 0, type=1
libbpf: elf: section(19) .BTF.ext, size 440, link 0, flags 0, type=1
libbpf: elf: section(26) .symtab, size 263040, link 1, flags 0, type=2
libbpf: looking for externs among 10960 symbols...
libbpf: collected 1 externs total
libbpf: extern (ksym) #0: symbol 10959, name skbuff_fclone_cache
libbpf: map 'events': at sec_idx 8, offset 0.
libbpf: map 'events': found type = 4.
libbpf: map 'events': found key_size = 4.
libbpf: map 'events': found value_size = 4.
libbpf: sec '.relfexit/kmem_cache_alloc': collecting relocation for 
section(3) 'fexit/kmem_cache_alloc'
libbpf: sec '.relfexit/kmem_cache_alloc': relo #0: insn #2 against 
'skbuff_fclone_cache'
libbpf: prog 'kmem_cache_alloc': found extern #0 'skbuff_fclone_cache' 
(sym 10959) for insn #2
libbpf: sec '.relfexit/kmem_cache_alloc': relo #1: insn #14 against 'events'
libbpf: prog 'kmem_cache_alloc': found map 0 (events, sec 8, off 0) for 
insn #14
libbpf: sec '.relfexit/kmem_cache_alloc_node': collecting relocation for 
section(5) 'fexit/kmem_cache_alloc_node'
libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #0: insn #2 against 
'skbuff_fclone_cache'
libbpf: prog 'kmem_cache_alloc_node': found extern #0 
'skbuff_fclone_cache' (sym 10959) for insn #2
libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #1: insn #14 against 
'events'
libbpf: prog 'kmem_cache_alloc_node': found map 0 (events, sec 8, off 0) 
for insn #14
