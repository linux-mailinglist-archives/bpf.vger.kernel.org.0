Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2640213BED
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCOix (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jul 2020 10:38:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726035AbgGCOix (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 10:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593787131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A4SNg/veuGUGeQ/9H0uknMrOgPhRtVROAG/gdjJq4Sk=;
        b=ZXXzV4G4rPHaktenP262jIYgfWQlIJWkEMEvW41naVGMq0k2zFLpTeT/0jED0sa+W8eAKv
        LulzAv2xrBBj3wV95L7hURN74hjIqO8ei5K3GM77p6mFBMSVc5TqbR9aHKqwuXbMzhqYFY
        jbj9+sqaSj7gk9QjQr7SqA26jUhzvhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-o9PVE-C9MtiG7FVWoGrILw-1; Fri, 03 Jul 2020 10:38:46 -0400
X-MC-Unique: o9PVE-C9MtiG7FVWoGrILw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20CAE107ACCA;
        Fri,  3 Jul 2020 14:38:45 +0000 (UTC)
Received: from carbon (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33A227BD58;
        Fri,  3 Jul 2020 14:38:39 +0000 (UTC)
Date:   Fri, 3 Jul 2020 16:38:37 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     BPF-dev-list <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Cc:     brouer@redhat.com, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Build errors in tools/testing/selftests/bpf/ at 046cc3dd9a25
Message-ID: <20200703163837.0611d26a@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I' getting this compile error in tools/testing/selftests/bpf/ on
bpf-next git tree with HEAD 046cc3dd9a25 ("bpf: Fix build without
CONFIG_STACKTRACE"):

 $ pwd
 /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf
 $ make 
 Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'
 Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
   INSTALL  headers
   GEN-SKEL [test_progs] bpf_iter_task_stack.skel.h
 libbpf: invalid relo for 'entries' in special section 0xfff2; forgot to initialize global var?..
 Error: failed to open BPF object file: 0
 make: *** [Makefile:372: /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.skel.h] Error 255
 make: *** Deleting file '/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.skel.h'


If I revert c7568114bc56 ("selftests/bpf: Add bpf_iter test with
bpf_get_task_stack()") (Author: Song Liu) then it compiles again.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

More details:

$ clang --version
clang version 10.0.0 (https://github.com/llvm/llvm-project.git 90c78073f73eac58f4f8b4772a896dc8aac023bc)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin

 llc --version
LLVM (http://llvm.org/):
  LLVM version 10.0.0git
  Optimized build.
  Default target: x86_64-unknown-linux-gnu
  Host CPU: ivybridge

  Registered Targets:
    bpf    - BPF (host endian)
    bpfeb  - BPF (big endian)
    bpfel  - BPF (little endian)
    x86    - 32-bit X86: Pentium-Pro and above
    x86-64 - 64-bit X86: EM64T and AMD64


make V=1
(clang  -g -D__TARGET_ARCH_x86 -mlittle-endian -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf -I/home/jbrouer/git/kernel/bpf-next/tools/include/uapi -I/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/usr/include -idirafter /usr/local/include -idirafter /usr/local/stow/llvm-10.0.0-rc2/lib/clang/10.0.0/include -idirafter /usr/include -Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm -c progs/bpf_iter_task_stack.c -o - || echo "BPF obj compilation failed") | llc -mattr=dwarfris -march=bpf -mcpu=v3  -mattr=+alu32 -filetype=obj -o /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.o

/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/tools/sbin/bpftool gen skeleton /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.o > /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.skel.h
libbpf: invalid relo for 'entries' in special section 0xfff2; forgot to initialize global var?..
Error: failed to open BPF object file: 0
make: *** [Makefile:372: /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.skel.h] Error 255
make: *** Deleting file '/home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.skel.h'

