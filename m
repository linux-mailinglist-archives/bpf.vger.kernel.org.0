Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A311297B7D
	for <lists+bpf@lfdr.de>; Sat, 24 Oct 2020 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461515AbgJXIcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Oct 2020 04:32:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35076 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460277AbgJXIcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Oct 2020 04:32:05 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Oct 2020 04:32:05 EDT
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 915D572CCE7;
        Sat, 24 Oct 2020 11:23:19 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8357B7CF99C; Sat, 24 Oct 2020 11:23:19 +0300 (MSK)
Date:   Sat, 24 Oct 2020 11:23:19 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: tools/bpf: Compilation issue on powerpc: unknown type name
 '__vector128'
Message-ID: <20201024082319.GA24131@altlinux.org>
References: <20201023230641.xomukhg3zrhtuxez@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023230641.xomukhg3zrhtuxez@altlinux.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Sat, Oct 24, 2020 at 02:06:41AM +0300, Vitaly Chikunov wrote:
> Hi,
> 
> Commit f143c11bb7b9 ("tools: bpf: Use local copy of headers including
> uapi/linux/filter.h") introduces compilation issue on powerpc:
>  
>   builder@powerpc64le:~/linux$ make -C tools/bpf V=1
>   make: Entering directory '/usr/src/linux/tools/bpf'
>   gcc -Wall -O2 -D__EXPORTED_HEADERS__ -I/usr/src/linux/tools/include/uapi -I/usr/src/linux/tools/include -DDISASM_FOUR_ARGS_SIGNATURE -c -o bpf_dbg.o /usr/src/linux/tools/bpf/bpf_dbg.c
>   In file included from /usr/include/asm/sigcontext.h:14,
> 		   from /usr/include/bits/sigcontext.h:30,
> 		   from /usr/include/signal.h:291,
> 		   from /usr/src/linux/tools/bpf/bpf_dbg.c:51:
>   /usr/include/asm/elf.h:160:9: error: unknown type name '__vector128'
>     160 | typedef __vector128 elf_vrreg_t;
> 	|         ^~~~~~~~~~~
>   make: *** [Makefile:67: bpf_dbg.o] Error 1
>   make: Leaving directory '/usr/src/linux/tools/bpf'

__vector128 is defined in arch/powerpc/include/uapi/asm/types.h;
while include/uapi/linux/types.h does #include <asm/types.h>,
tools/include/uapi/linux/types.h doesn't, resulting to this
compilation error.


-- 
ldv
