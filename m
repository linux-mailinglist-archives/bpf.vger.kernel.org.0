Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E31297981
	for <lists+bpf@lfdr.de>; Sat, 24 Oct 2020 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758509AbgJWXMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 19:12:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42390 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbgJWXME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 19:12:04 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 19:12:03 EDT
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9A93E72CCE7;
        Sat, 24 Oct 2020 02:06:42 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 31D504A4AE9;
        Sat, 24 Oct 2020 02:06:42 +0300 (MSK)
Date:   Sat, 24 Oct 2020 02:06:41 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: tools/bpf: Compilation issue on powerpc: unknown type name
 '__vector128'
Message-ID: <20201023230641.xomukhg3zrhtuxez@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Commit f143c11bb7b9 ("tools: bpf: Use local copy of headers including
uapi/linux/filter.h") introduces compilation issue on powerpc:
 
  builder@powerpc64le:~/linux$ make -C tools/bpf V=1
  make: Entering directory '/usr/src/linux/tools/bpf'
  gcc -Wall -O2 -D__EXPORTED_HEADERS__ -I/usr/src/linux/tools/include/uapi -I/usr/src/linux/tools/include -DDISASM_FOUR_ARGS_SIGNATURE -c -o bpf_dbg.o /usr/src/linux/tools/bpf/bpf_dbg.c
  In file included from /usr/include/asm/sigcontext.h:14,
		   from /usr/include/bits/sigcontext.h:30,
		   from /usr/include/signal.h:291,
		   from /usr/src/linux/tools/bpf/bpf_dbg.c:51:
  /usr/include/asm/elf.h:160:9: error: unknown type name '__vector128'
    160 | typedef __vector128 elf_vrreg_t;
	|         ^~~~~~~~~~~
  make: *** [Makefile:67: bpf_dbg.o] Error 1
  make: Leaving directory '/usr/src/linux/tools/bpf'


