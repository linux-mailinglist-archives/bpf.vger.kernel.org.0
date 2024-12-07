Return-Path: <bpf+bounces-46349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BE9E8049
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0882518841F9
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD81474BF;
	Sat,  7 Dec 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4FCpqOK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268AAECF;
	Sat,  7 Dec 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733581984; cv=none; b=qW7eKVPBTVxJYrWscqF/+9xv6dRCVJqf8xbsboFNSF7GAIb9TXxdTYD3v3rAxViI7iJVnrA0zcWKAPiTjWy+jTMQcrwkVMRTcVzGClFqB7pXH79YuW6+5RpXnqIYNy3s4rNoSS+RTYXLibtIhA3N44g0ynZY6A71NUI4ImxORcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733581984; c=relaxed/simple;
	bh=A+wcKv7PGP2QN83cnqM8XjpwyUzscFbwcDfV3Kry5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uqJP+r1N2+BNsHNDZggK4mOUHLiVK/rTmiTkAltRhCUY4PEmRGG8Yk5sqC8o/vOqP8sECZC36484XtpCI4nHQdGc8lEM8+OwGH7NefwyDciEP/tTN9sCa/VOw6yCZ87L9OXrU8A6UonZfVKkq+qQs0asClt0zDpY6b9aSmj04vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4FCpqOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04898C4CECD;
	Sat,  7 Dec 2024 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733581983;
	bh=A+wcKv7PGP2QN83cnqM8XjpwyUzscFbwcDfV3Kry5lI=;
	h=Date:From:To:Cc:Subject:From;
	b=W4FCpqOKGQ515PZo+rHz3oJzAZxxVGB9jeqtWjCfDbZRJriJtF89Loj7kH54lMpvd
	 w156Y6RoOqqlYMKOG+Y9E65xhhzh8Frn1yf6Tbe2iObmcKuo+5ldJiD3MUtc0l+lJ4
	 8PJy9ysCOcsajtiqUF0nEvdkRiqmyWPatnb2MxnIyOD4XsKOoCBV2TpCwYlmcGQcrO
	 m1okKozclRlErt7GtH5nzYCM70FI0Ex1t//mXJBa6AvqJ4iymUmRAsu8hk8J/KL1JD
	 rjmKtKuSSA/Q0qm8W/dw30YNp/WOR1z8IhSzHFwIB1cXdqmGdvEwGafWPUVjoJWVM+
	 gHxBUwO3mR56Q==
Date: Sat, 7 Dec 2024 11:33:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Viktor Malik <vmalik@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Miguel Ojeda <ojeda@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Song Liu <song@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Tom Stellard <tstellar@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willy Tarreau <w@1wt.eu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: ANNOUNCE: pahole v1.28 (flex arrays, bpf_fastcall, global vars, btf
 endianness, distilled BTF base, reg tests)
Message-ID: <Z1RcnB8WD8wZphcr@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
 
	The v1.28 release of pahole and its friends is out, supporting
optionally encoding BTF for all global variables, enhanced pretty
printing of flexible arrays, distilled BTF base, bpf_fastcall BTF decl
tags, and a growing suite of regression tests.

Main git repo:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.28.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.28.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.28.tar.sign

	We'll then try to release v1.29 shortly after Linus releases
v6.13, and so on.
 
	Alan Maguire accepted to co-maintain pahole and as soon as he
gets a kernel.org account he'll be able to help me in processing
patches, that we expect to continue with the current fashion of being
tested and reviewed by as many developers as possible, its greatly
appreciated and a good way for us to keep this codebase in shape.

	We have added 121 non-merge commits, with 
30 files changed, 2806 insertions(+), 939 deletions(-).

	Thanks a lot to all the contributors and distro packagers,
you're on the CC list, we appreciate a lot the work you put into these
tools,

Best Regards,

- Arnaldo

pahole:

- Various improvements to reduce the memory footprint of pahole, notably when
  doing BTF encoding.

- Show flexible arrays statistics, it detects them at the end of member types,
  in the middle, etc. This should help with the efforts to spot problematic
  usage of flexible arrays in the kernel sources, examples:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=6ab5318f536927cb

- Introduce --with_embedded_flexible_array option.

- Add '--padding N' to show only structs with N bytes of padding.

- Add '--padding_ge N' to show only structs with at least N bytes of padding.

- Introduce --running_kernel_vmlinux to find a vmlinux that matches the
  build-id of the running kernel, e.g.:

    $ pahole --running_kernel_vmlinux
    /usr/lib/debug/lib/modules/6.11.7-200.fc40.x86_64/vmlinux
    $ rpm -qf /usr/lib/debug/lib/modules/6.11.7-200.fc40.x86_64/vmlinux
    kernel-debuginfo-6.11.7-200.fc40.x86_64
    $

  This is a shortcut to find the right vmlinux to use for the running kernel
  and helps with regression tests.

pfunct:

- Don't stop at the first function that matches a filter, show all of them.

BTF Encoder:
    
- Allow encoding data about all global variables, not just per CPU ones.
    
  There are several reasons why type information for all global variables to be
  useful in the kernel, including drgn without DWARF, __ksym BPF programs return
  type.

  This is non-default, experiment with it using 'pahole --btf-features=+global_var'

- Handle .BTF_ids section endianness, allowing for cross builds involving
  machines with different endianness to work.

  For instance, encoding BTF info on a s390 vmlinux file on a x86_64 workstation.

- Generate decl tags for bpf_fastcall for eligible kfuncs.

- Add "distilled_base" BTF feature to split BTF generation.

- Use the ELF_C_READ_MMAP mode with libelf, reducing peak memory utilization.

BTF Loader:

- Allow overiding /sys/kernel/btf/vmlinux with some other file, for testing,
  via the PAHOLE_VMLINUX_BTF_FILENAME environment variable.

DWARF loader:

- Allow setting the list of compile units produced from languages to skip via
  the PAHOLE_LANG_EXCLUDE environment variable.

- Serialize access to elfutils dwarf_getlocation() to avoid elfutils internal
  data structure corruption when running multithreaded pahole.

- Honour --lang_exclude when merging LTO built CUs.

- Add the debuginfod client cache directory to the vmlinux search path.

- Print the CU's language when a tag isn't supported.

- Initial support for the DW_TAG_GNU_formal_parameter_pack,
  DW_TAG_GNU_template_parameter_pack, DW_TAG_template_value_param and
  DW_TAG_template_type_param DWARF tags.

- Improve the parameter parsing by checking DW_OP_[GNU_]entry_value, this
  makes some more functions to be made eligible by the BTF encoder, for instance
  the perf_event_read() in the 6.11 kernel.

Core:

- Use pahole to help in reorganizing its data structures to reduce its memory
  footprint.

Regression tests:

- Introduce a tests/ directory for adding regression tests, run it with:

  $ tests/tests

  Or run the individual tests directly.

- Add a regression test for the reproducible build feature that establishes
  as a baseline a detached BTF file without asking for a reproducible build and
  then compares the output of 'bpftool btf dump file' for this file with the one
  from BTF reproducible build encodings done with a growing number or threads.

- Add a regression test for the flexible arrays features, checking if the various
  comments about flexible arrays match the statistics at the final of the pahole
  pretty print output.

- Add a test that checks if pahole fails when running on a BTF system and BTF was
  requested, previously it was falling back to DWARF silently.

- Add test validating BTF encoding, reasons we skip functions: DWARF functions
  that made it into BTF match signatures, functions we say we skipped, we did
  indeed skip them in BTF encoding and that it was correct to skip these
  functions.

- Add regression test for 'pahole --prettify' that uses perf to record a simple
  workload and then pretty print the resulting perf.data file to check that what
  is produced are the expected records for such a file.

Link: https://lore.kernel.org/all/Z0jVLcpgyENlGg6E@x1/
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

