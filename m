Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A3D3613D3
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOVDL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 17:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234879AbhDOVDK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 17:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618520566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGHsaDaUpiruomI8+2Hlw2Ap8tFFUdJWgJGhYkehwNM=;
        b=JHH5YGsC3e8QLINbMIBlPdFYtYenIKBFDO9xFwosAIRtvq6B8tTvE7pCNt4vL3xAMWsyl4
        YUila7XgWG5mswSAXFCDp8eKtPuXMfp4NET/wamflCuIcDXOINNeDZC94feEB7AEMDvXuf
        ZOIC/lIpSioZXIv/xjnQK1QWMugPAng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-jBkJnf1aPXSSMKUKZ7sn5A-1; Thu, 15 Apr 2021 17:02:42 -0400
X-MC-Unique: jBkJnf1aPXSSMKUKZ7sn5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB651005582;
        Thu, 15 Apr 2021 21:02:41 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2903D9CA0;
        Thu, 15 Apr 2021 21:02:41 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8D4A6102; Thu, 15 Apr 2021 18:02:38 -0300 (-03)
Date:   Thu, 15 Apr 2021 18:02:38 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [QUESTION] Will the pahole tar source code with corresponding
 libbpf submodule codes be released as well in the future?
Message-ID: <20210415210238.GB21027@redhat.com>
References: <2de4aad5-fa9e-1c39-3c92-9bb9229d0966@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de4aad5-fa9e-1c39-3c92-9bb9229d0966@loongson.cn>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Apr 15, 2021 at 12:01:23PM +0800, Tiezhu Yang escreveu:
> (1) tools/bpf/bpftool build failed due to the following reason:
> 
> Error: failed to load BTF from /boot/vmlinux-5.12.0-rc2: No such
> file or directory
> make: *** [Makefile:158: vmlinux.h] Error 2
> 
> (2) When set CONFIG_DEBUG_INFO_BTF=y, failed to generate BTF for vmlinux
> due to pahole is not available
> 
> BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
> Failed to generate BTF for vmlinux
> Try to disable CONFIG_DEBUG_INFO_BTF
> make: *** [Makefile:1197: vmlinux] Error 1
> 
> (3) When build pahole from tar.gz source code, it still failed
> due to no libbpf submodule.


You're getting the tarball from the wrong place, you should get it from:

https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.xz

Please read the announcement:

https://lore.kernel.org/bpf/YHRiXNX1JUF2Az0A@kernel.org/

- Arnaldo

 
> loongson@linux:~$ wget https://git.kernel.org/pub/scm/devel/pahole/pahole.git/snapshot/pahole-1.21.tar.gz
> loongson@linux:~$ tar xf pahole-1.21.tar.gz
> loongson@linux:~$ cd pahole-1.21
> loongson@linux:~/pahole-1.21$ mkdir build
> loongson@linux:~/pahole-1.21$ cd build/
> loongson@linux:~/pahole-1.21/build$ cmake -D__LIB=lib ..
> -- The C compiler identification is GNU 10.2.1
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Check for working C compiler: /usr/bin/cc - skipped
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Checking availability of DWARF and ELF development libraries
> -- Looking for dwfl_module_build_id in elf
> -- Looking for dwfl_module_build_id in elf - found
> -- Found dwarf.h header: /usr/include
> -- Found elfutils/libdw.h header: /usr/include
> -- Found libdw library: /usr/lib/mips64el-linux-gnuabi64/libdw.so
> -- Found libelf library: /usr/lib/mips64el-linux-gnuabi64/libelf.so
> -- Checking availability of DWARF and ELF development libraries - done
> -- Found ZLIB: /usr/lib/mips64el-linux-gnuabi64/libz.so (found
> version "1.2.11")
> CMake Error at CMakeLists.txt:60 (message):
>   The submodules were not downloaded! GIT_SUBMODULE was turned off
> or failed.
>   Please update submodules and try again.
> 
> -- Configuring incomplete, errors occurred!
> See also "/home/loongson/pahole-1.21/build/CMakeFiles/CMakeOutput.log".
> 
> (4) I notice that the pahole git source code can build successful because
> it will clone libbpf automatically:
> 
> -- Submodule update
> Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered
> for path 'lib/bpf'
> Cloning into '/home/loongson/pahole/lib/bpf'...
> Submodule path 'lib/bpf': checked out
> '986962fade5dfa89c2890f3854eb040d2a64ab38'
> -- Submodule update - done
> 
> (5) So Will the pahole tar source code with corresponding libbpf
> submodule codes
> be released as well in the future? just like bcc:
> https://github.com/iovisor/bcc/releases
> https://github.com/iovisor/bcc/commit/708f786e3784dc32570a079f2ed74c35731664ea
> 
> Thanks,
> Tiezhu

