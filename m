Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D383A4B07
	for <lists+bpf@lfdr.de>; Sat, 12 Jun 2021 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFKW4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 18:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKW4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 18:56:14 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CBEC061574;
        Fri, 11 Jun 2021 15:54:16 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3E236C022; Sat, 12 Jun 2021 00:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623452053; bh=b/wKmTLtZMb6738rNPnCgttwW7AQAjEbRhc+FB/wM+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSi+8IBCJ/TwgGJowfm3mMWHByV7oyprYOaN2E2075WhbjtMGfsWsR2Okz5pZ0c0p
         Z3vOjuJ9rP1gFsK4UV1vof5ZyL+trc/NmbvhkCF3qENXn/owYgqPgJmBWzMfk458Nk
         Pn293hKAPt3G3G/T5JHi+YLKkSqOZnR0gT9zXnbPh8WNPnnasscDhchUQd1vrDN0fe
         mFg4B8GdLFBKYMsklTpDT478nlt+iOCKQ/rP7aAzUuwtTPGz9nxPWC9Qd7k8nPC6lj
         c9agrW/lm1qd7NuQ7llPciJXyjjAxZ0s1c11iWFlCY1mrdXng6Sr8e4qk2LNu5ZGbB
         d/vcb2fXozazA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id DF492C01F;
        Sat, 12 Jun 2021 00:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1623452052; bh=b/wKmTLtZMb6738rNPnCgttwW7AQAjEbRhc+FB/wM+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4rypFhjSSnuJe3cuZiKBXlgf0W71STLJOhqN39IRHbcswfj7v9tzQY0EE+M4XGKrc
         PcJqIJG/Y8n2kk1PeE3VZB5igO4ZAn7XAFJCQERBwsDvesVe9tgzoiYBbM9dgHUZtY
         nvP/BsybNliI36OThIEPMlAWtGBJ+uVwS3BFu80Nn+4QQyEz9j1f1pLFSyyUk6hCjU
         HzdKy9xHNS1ILu4GLlgr1/rwHCNSFZJnTCaGpgTIbZly50Zm0isJCJzPEB9hjW5eoY
         yTllXnLWS/ZF4HxEobfsDV3U37tZ73WKthPapFzKrQs+XwFSeJX8+9pcTxxoJtcBFs
         UZ3qvcKPcIHWQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e62f006a;
        Fri, 11 Jun 2021 22:54:06 +0000 (UTC)
Date:   Sat, 12 Jun 2021 07:53:51 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        dwarves@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Jiri Olsa <jolsa@kernel.org>, siudin@fb.com,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] CMakeLists.txt: enable SHARED and STATIC lib
 creation
Message-ID: <YMPpfzNCSE8DxvOA@codewreck.org>
References: <cover.1623091959.git.deepakkumar.mishra@arm.com>
 <70cb7cb534af9850dc5fe3c4b9f4366ce7dc6316.1623091959.git.deepakkumar.mishra@arm.com>
 <YMJMdQvCWHd5J0M1@kernel.org>
 <CAEf4BzZEmLbKtUMkbV4+3rDFrSwP9Eu-tO_GvYRgRvdsQqrWTQ@mail.gmail.com>
 <YMPA1T0Cuo7xw/Sp@kernel.org>
 <CAEf4BzYwf0fO5Y9pVKPg3TOwMcq-HneG-BGU8M+oAjMyhXBwQA@mail.gmail.com>
 <9b4bcb2372f00c9ffa1b3d5d30a84755d8a3896c.camel@debian.org>
 <49ebd74aac20b3896996c3b1fdcc14e35c7a05ec.camel@debian.org>
 <8471df5c1e5aa52bedb032b2fcb3b6ce7722de6b.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8471df5c1e5aa52bedb032b2fcb3b6ce7722de6b.camel@debian.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Luca Boccassi wrote on Fri, Jun 11, 2021 at 11:45:25PM +0100:
> Actually that was my mistake, used the wrong build tree (sorry, it's
> late!). I can however reproduce the issue in a chroot running the
> libbpf CI script. Still looking.

with the ci script I get

$ /usr/lib64/ccache/cc -DDWARVES_MAJOR_VERSION=1 -DDWARVES_MINOR_VERSION=21 -D_GNU_SOURCE -Ddwarves_EXPORTS -I/path/to/pahole/build -I/path/to/pahole -I/path/to/pahole/lib/include -I/path/to/pahole/lib/bpf/include/uapi -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -DNDEBUG -fPIC -MD -MT CMakeFiles/dwarves.dir/btf_encoder.c.o -MF CMakeFiles/dwarves.dir/btf_encoder.c.o.d -o CMakeFiles/dwarves.dir/btf_encoder.c.o -c /path/to/pahole/btf_encoder.c
/path/to/pahole/btf_encoder.c: In function ‘btf_encoder__add_float’:
/path/to/pahole/btf_encoder.c:224:22: warning: implicit declaration of function ‘btf__add_float’; did you mean ‘btf__add_var’? [-Wimplicit-function-declaration]
  224 |         int32_t id = btf__add_float(encoder->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
      |                      ^~~~~~~~~~~~~~
      |                      btf__add_var



with btf__add_float defined in .../pahole/lib/bpf/src/btf.h
and btf_encoder.c including linux/btf.h


changing btf_loader.c to include bpf/btf.h instead fixes the issue for me:

diff --git a/btf_loader.c b/btf_loader.c
index 75ec674b3b3e..272c73bca7fe 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -20,7 +20,7 @@
 #include <string.h>
 #include <limits.h>
 #include <libgen.h>
-#include <linux/btf.h>
+#include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <zlib.h>
 


-- 
Dominique
