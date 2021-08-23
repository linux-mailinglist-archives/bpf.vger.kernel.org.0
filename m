Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1853F52D9
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 23:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhHWV0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 17:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232503AbhHWV0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 17:26:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B96386138B;
        Mon, 23 Aug 2021 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629753961;
        bh=/h+lVLzqJiqJn2/EIqDarjFT8L9Llmm0dkjYywU1YPE=;
        h=Date:From:To:Cc:Subject:From;
        b=Ql+Tb8WSjxXRe2SsNo86Wbr2CYhr4p9Pk7w2u+c4hsPpsTbrsDrWcarCJ7W5AzrfM
         5nQDImnFHPBw2x3+9xI+2qQj4DuokjOMCgsVV5VJfS38rX15n3sevxuBaSRfHV8c54
         QIe+nK0IoaJnWk3UNXpMUl6s4juWCvdAdq2Rr2Uk13uRpf/1lBpGyTOHiAT3Hxkr/J
         /C+eq6a3h7BqaYhPJ9xvLmK6J77J1uSTSE0fKUHTdiiFLWUoOCDcq+hVuqVk7CFxba
         sQ8ruEDfrSdtB7AGmZvHq5YyuLb6VpA3rpnqlbw75R1MTe8wsY+YBGQXDQB7QGlv4J
         P1j8TnrAAKnMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7FE44007E; Mon, 23 Aug 2021 18:25:57 -0300 (-03)
Date:   Mon, 23 Aug 2021 18:25:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Mark Wieelard <mjw@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Deepak Kumar Mishra <deepakkumar.mishra@arm.com>,
        Luca Boccassi <bluca@debian.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Sevan Janiyan <venture37@geeklan.co.uk>,
        Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: ANNOUNCE: pahole v1.22 (Multithreaded DWARF Loading, detached BTF
 encoding)
Message-ID: <YSQSZQnnlIWAQ06v@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.22 release of pahole and its friends is out, this time
the main new features are the ability to encode BTF to a
separate file and Multithreaded DWARF loading.

	Lots of cleanups and improvements resulted from preparing for
multithreading. Please see the changes-1.22 file in the source tree and
at the end of this message for a detailed list of improvements.

	Next step is to multithread BTF encoding, but even without that
the time taken tp encode the kernel BTF information now is slashed by
over 50%. The before/after 'perf stat' output for each of the improvements
can be found in the project git commit log messages. 

	The non-cross build set of containers used to test build the
Linux perf tools is now being used to make sure pahole doesn't build
regresses.

	Thanks as well to Andrii for putting in place a CI job for pahole
at https://github.com/libbpf/libbpf/actions/workflows/pahole.yml.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.21.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

- Arnaldo

pahole:

- Allow encoding BTF to a separate BTF file (detached) instead of to a new
  ".BTF" ELF section in the file being encoded (vmlinux usually).

- Introduce -j/--jobs option to specify the number of threads to use. Without
  arguments means one thread per CPU. So far used for the DWARF loader, will
  be used as well for the BTF encoder.

- Show all different types with the same name, not just the first one found.

- Introduce sorted type output (--sort), needed with multithreaded DWARF loading,
  to use with things like 'btfdiff' that expects the output from DWARF and BTF
  types to be comparable using 'diff'.

- Stop assuming that reading from stdin means pretty printing as this broke
  pre-existing scripts, introduce a explicit --prettify command line option.

- Improve type resolution for the --header command line option.

- Disable incomplete CTF encoder, this needs to be done using the external
  libctf library.

- Do not consider the ftrace filter when encoding BTF for kernel functions.

- Add --kabi_prefix to avoid deduplication woes when using _RH_KABI_REPLACE(),

- Add --with_flexible_array to show just types with flexible arrays.

DWARF Loader:

- Multithreaded loading, requires elfutils >= 0.178.

- Lock calls to non-thread safe elfutils' libdw functions (dwarf_decl_file()
  and dwarf_decl_line())

- Change hash table size to one that performs better with current typical
  vmlinux files.

- Allow tweaking the hash table size from the command line.

- Stop allocating memory for strings obtained from libdw, just defer freeing
  the Dwfl handler so that references to its strings can be safely kept.

- Use a frontend cache for the latest lookup result.

- Allow ignoring some DWARF tags when loading for encoding BTF, as BTF doesn't
  have equivalents for things like DW_TAG_inline_expansion and DW_TAG_label.

- Allow ignoring some DWARF tag attributes, such as DW_AT_alignment, not used
  when encoding BTF.

- Do not query for non-C attributes when loading a C language CU (compilation unit).

BTF encoder:

- Preparatory work for multithreaded encoding, the focus for 1.23.

btfdiff:

- Support diffing against a detached BTF file, e.g.: 'btfdiff vmlinux vmlinux.btf'

- Support multithreaded DWARF loading, using the new pahole --sort option to have
  the output from both BTF and DWARF sorted and thus comparable via 'diff'.

Build:

- Support building with libc libraries lacking either obstacks or argp, such
  as Alpine Linux's musl libc.

- Support systems without getconf() to obtain the data cacheline size, such
  as musl libc.

- Add a buildcmd.sh for test builds, tested using the same set of containers
  used for testing the Linux kernel perf tools.

- Enable selecting building with a shared libdwarves library or statically.

- Allow to use the libbpf package found in distributions instead of with the
  accompanying libbpf git submodule.

Cleanups:

- Address lots of compiler warnings accumulated by not using -Wextra, it'll
  be added in the next release after allowing not to use it to build libbpf.

- Address covscan report issues.

Documentation:

- Improve the --nr_methods/-m pahole man page entry.

- Clarify that currently --nr_methods doesn't work together witn -C.

Tests:

  $ export BUILD_TARBALL=http://192.168.100.2/pahole/dwarves-1.22.tar.xz
  $ export BUILD_CMD=buildcmd.sh
  $ time dm -X
     1	3.78 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
     2	5.07 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
     3	5.48 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
     4	5.68 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
     5	5.99 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210625) 10.3.1 20210625 , Alpine clang version 11.1.0
     6	4.27 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
     7	4.27 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
     8	5.07 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
     9	4.67 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    10	4.27 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    11	4.48 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+587+5187cac0)
    12	4.48 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.0 (Red Hat 12.0.0-1.module_el8.5.0+840+21214faf)
    13	4.18 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20210816 releases/gcc-11.2.0-71-g4a414ac2a5 , clang version 11.1.0
    14	4.88 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    15	4.79 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    16	4.18 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    17	4.27 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    18	3.77 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    19	3.97 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    20	4.17 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    21	4.37 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    22	4.48 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    23	4.28 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    24	4.47 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    25	4.37 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    26	4.28 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    27	4.07 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    28	4.27 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    29	4.38 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    30	4.47 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    31	4.37 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    32	4.37 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-2.fc35)
    33	4.08 gentoo-stage3:latest          : Ok   gcc (Gentoo 10.3.0 p1) 10.3.0 
    34	4.07 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    35	4.78 mageia:7                      : Ok   gcc (Mageia 8.4.0-1.mga7) 8.4.0 , clang version 8.0.0 (Mageia 8.0.0-1.mga7)
    36	6.48 openmandriva:cooker           : Ok   gcc (GCC) 11.2.0 20210728 (OpenMandriva) , OpenMandriva 12.0.1-1 clang version 12.0.1 (/builddir/build/BUILD/llvm-project-12.0.1.src/clang 0a7362bac93d0a3bf152ead1b6b3f98c9a9695d5)
    37	4.48 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    38	4.08 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    39	3.87 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    40	3.78 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    41	4.38 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.1.1 20210721 [revision 076930b9690ac3564638636f6b13bbb6bc608aea] , clang version 12.0.1
    42	3.87 oraclelinux:8                 : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1.0.1) , clang version 11.0.0 (Red Hat 11.0.0-1.0.1.module+el8.4.0+20046+39fed697)
    43	3.87 rockylinux:8                  : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+412+05cf643f)
    44	3.97 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    45	4.37 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    46	4.87 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
    47	4.47 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    48	4.27 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
    49  4.37 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-1ubuntu2) 11.2.0 , Ubuntu clang version 12.0.1-1

  $
