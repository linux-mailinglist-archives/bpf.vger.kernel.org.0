Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2862C26B2
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgKXNCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 08:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387663AbgKXNCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 08:02:07 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70565206D9;
        Tue, 24 Nov 2020 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606222925;
        bh=QrNWO/2xSwsQTIdswkIGJmMsNb/AzHcwSSH0g91IGKU=;
        h=Date:From:To:Cc:Subject:From;
        b=nWeucA42a81B3oxU7Xc+KYRFsziZuMtJnHHl7+J9hTgRdEUlgRwtez7CQg/6KNqr+
         fkoXm7CpD7PNfpZAHccPpoHNtLbuiPdnLxLxZ7ua46jw1yGK/X4YzBZ89QdQi1ywxZ
         Mg52ofscWinIpOL3F2aD92MN+D084UpJI+zyWzVE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0873440E29; Tue, 24 Nov 2020 10:02:03 -0300 (-03)
Date:   Tue, 24 Nov 2020 10:02:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Hao Luo <haoluo@google.com>, Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Cermak <mcermak@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wieelard <mjw@redhat.com>
Subject: ANNOUNCE: pahole v1.19 (Split BTF for kmodules, DWARF bug
 workarounds, speedups, --packed)
Message-ID: <20201124130202.GA5391@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.19 release of pahole and its friends is out, available at
the usual places:

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.19.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.19.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.19.tar.sign

Best Regards,

- Arnaldo
 
v1.19:

- Support split BTF, where a main BTF file, vmlinux, can be used to find types
  and then a kernel module, for instance, can have just what is unique to it.

  For instance, looking for a type in the main vmlinux BTF info:

    $ pahole wmi_notify_handler
    pahole: type 'wmi_notify_handler' not found
    $

  If we look at the 'wmi' module BTF info that is in:

    $ ls -la /sys/kernel/btf/wmi
    -r--r--r--. 1 root root 2866 Nov 18 13:35 /sys/kernel/btf/wmi
    $

    $ pahole /sys/kernel/btf/wmi -C wmi_notify_handler
    typedef void (*wmi_notify_handler)(u32, void *);
    $

  '--btf_base=/sys/kernel/btf/vmlinux' was automatically added in this last
  example, an option that was also introduced in this version where types used in
  the wmi.ko module but present in vmlinux can be found so that there is no
  duplicity of types.

- Update libbpf to get the split BTF support and use some of its functions to
  load BTF and speed up DWARF loading and BTF encoding.

- Support cross-compiled ELF binaries with different endianness

- Support showing typedefs for anonymous types, like structs, unions and enums,
  see the "Align enumerators" entry below for an example, another:

    $ pahole rwlock_t
    typedef struct {
            arch_rwlock_t              raw_lock;             /*     0     8 */

            /* size: 8, cachelines: 1, members: 1 */
            /* last cacheline: 8 bytes */
    } rwlock_t;
    $

- Align enumerators:

    $ pahole ZSTD_strategy
    typedef enum {
            ZSTD_fast    = 0,
            ZSTD_dfast   = 1,
            ZSTD_greedy  = 2,
            ZSTD_lazy    = 3,
            ZSTD_lazy2   = 4,
            ZSTD_btlazy2 = 5,
            ZSTD_btopt   = 6,
            ZSTD_btopt2  = 7,
            } ZSTD_strategy;
    $

- Workaround bugs in the generation of DWARF records for functions in some gcc
  versions that were causing breakage in the encoding of BTF:

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060 "Missing DW_AT_declaration=1 in dwarf data"

- Ignore zero-sized ELF symbols instead of erroring out.

- Handle union forward declaration properly in the BTF loader.

- Introduce --numeric_version for use in scripts and Makefiles:

    $ pahole --version
    v1.19
    $ pahole --numeric_version
    119
    $

  To avoid things like this in the kernel's scripts/link-vmlinux.sh:

    pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')

- Try sole pfunct argument as a function name, just like pahole with type names:

    $ pfunct tcp_v4_rcv
    int tcp_v4_rcv(struct sk_buff * skb);
    $

- Speed up pfunct using some of the load techniques used in pahole.

- Discard CUs after BTF encoding as they're not used anymore, greatly reducing
  memory usage and speeding up vmlinux BTF encoding.

- Revamp how per-CPU variables are encoded in BTF.

- Include BTF info for static functions.

- Use BTF's string APIs for strings management, greatly improving performance
  over the tsearch().

- Increase size of DWARF lookup hash table, shaving off about 1 second out of
  about 20 seconds total for Linux BTF dedup.

- Stop BTF encoding when errors are found in some DWARF CU.

- Implement --packed, to show just packed structures, for instance, here are
  the top 5 packed data structures in the Linux kernel:

  $ pahole --sizes --packed | sort -k2 -nr | head -5
  e820_table	64004	0
  boot_params	4096	0
  efi_variable	2084	0
  snd_soc_tplg_pcm	912	0
  ntb_info_regs	800	0
  $

  And here is one of them:

  $ pahole efi_variable
  struct efi_variable {
  	efi_char16_t               VariableName[512];    /*     0  1024 */
  	/* --- cacheline 16 boundary (1024 bytes) --- */
  	efi_guid_t                 VendorGuid;           /*  1024    16 */
  	long unsigned int          DataSize;             /*  1040     8 */
  	__u8                       Data[1024];           /*  1048  1024 */
  	/* --- cacheline 32 boundary (2048 bytes) was 24 bytes ago --- */
  	efi_status_t               Status;               /*  2072     8 */
  	__u32                      Attributes;           /*  2080     4 */

  	/* size: 2084, cachelines: 33, members: 6 */
  	/* last cacheline: 36 bytes */
  } __attribute__((__packed__));
  $

- Fix bug in distros such as OpenSUSE:15.2 where DW_AT_alignment isn't defined.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
