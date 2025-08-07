Return-Path: <bpf+bounces-65231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5DFB1DCFF
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 20:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2151D188C03C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD31271A84;
	Thu,  7 Aug 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PERlr31y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95A35959;
	Thu,  7 Aug 2025 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591147; cv=none; b=oplSpBzxcMZdt+MzPFtbeWMbzIce9c55W6Nqoh6GetL7sFxbfiLNDXBlgkuce1zyztIRrojmZwjpSmWo3UmdUJ36cZCYbpuoMU+dirxzz/3UaUEOK8Awt8CUvIoacPCm6lW7bC3wJxWdBcaNjBxr8r8A6tIOtOPG0Gv9BbNPngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591147; c=relaxed/simple;
	bh=OHO6xVgW3Pw/rD/Z9iMH+AsmXVHleO02+C54j6OEd5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvI16CIcOh0CHLDStpqMhBTBL0nW3Y3PZ5GQVcnVit8DNddW1TX2qHDhm7ZGvAFjXtTTqOqdZrAZkc+7BpRheZv5Oako1ousXAuxVfuwiq9hFELBp/4a+vr2gYlWJ63a99yIf4qmjh6uydnWu7JxXDpoM2aDccL0XRqyq5IWaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PERlr31y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F3EC4CEED;
	Thu,  7 Aug 2025 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591146;
	bh=OHO6xVgW3Pw/rD/Z9iMH+AsmXVHleO02+C54j6OEd5E=;
	h=From:To:Cc:Subject:Date:From;
	b=PERlr31yZKL3r3r5LIfjmt/IDg7C2S8OxTXlQWMVN8o12cfZqQUHh2JIpavoyQNYP
	 +H+P0S9hhwhYSVVYbhehcFT9NkE6ovnnCwLntlzumP0K+o7FuiDZCjd+b5Qwe2Leod
	 uV7krlomx822WAgt+56rGgxuTBeB0BYA51o2ZMPAgk/xWy5o52MRlG9gT0jUJyeLc3
	 lAIm4qW0gy05cgpoBlhFM6Ps/NnCyBK0mMqYEPBNRDAC2Xk6DfyKoEJislabQpTxye
	 qjIKBZ+1CI1v/4N+gcyx8hKkbcIpX9BEq4pFh4SLV7MwzjlbiIhNqLv+T5wFUm9uuO
	 RRCqJQ3397VBg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org
Subject: [RFC 0/4] BTF archive with unmodified pahole+toolchain
Date: Thu,  7 Aug 2025 15:25:34 -0300
Message-ID: <20250807182538.136498-1-acme@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	I've finally managed to act on some idea I shared with a few
folks while in Montreal, namely using unmodified pahole to generate BTF
for each .o right after it is produced, i.e. with this patch:

  acme@number:~/git/linux$ git diff
  diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
  index 1d581ba5df66f2b5..ad9e788910636715 100644
  --- a/scripts/Makefile.lib
  +++ b/scripts/Makefile.lib
  @@ -240,7 +240,7 @@ cmd_ld_single = $(if $(objtool-enabled)$(is-single-obj-m), ; $(LD) $(ld_flags) -
   endif
   
   quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
  -      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
  +      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< && ${PAHOLE} --btf_encode ${PAHOLE_FLAGS} $@ \
                  $(cmd_ld_single) \
                  $(cmd_objtool)
   
  acme@number:~/git/linux$

A kernel built with this ends up with a vmlinux with a .BTF section that
has all the .o .BTF sections concatenated.

This (the series of .BTF concatenated by the unmodified linker) somehow
survives the pre-existing pahole call to generate BTF from DWARF and we
end up with this "BTF archive".

With the minimal set of changes in this series:

 tools/lib/bpf/btf.c | 91 ++++++++++++++++++++++++++++++++++++++-------
 tools/lib/bpf/btf.h |  3 ++
 2 files changed, 81 insertions(+), 13 deletions(-)

With the first patch being just a trivial error handling simplification,
we end up being able to get the same vmlinux.h result from bpftool built
with this libbpf:

  acme@number:~/git/bpf-next$ tools/bpf/bpftool/bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive format c >
  +from_archive_combined+dedup_in_libbpf
  acme@number:~/git/bpf-next$ tools/bpf/bpftool/bpftool btf dump file ../build/v6.16.0+/vmlinux format c >
  +from_unmodified_pahole_DWARF2BTF+dedup_in_libbpf
  acme@number:~/git/bpf-next$ diff -u from_archive_combined+dedup_in_libbpf from_unmodified_pahole_DWARF2BTF+dedup_in_libbpf | head
  acme@number:~/git/bpf-next$ wc -l from_archive_combined+dedup_in_libbpf from_unmodified_pahole_DWARF2BTF+dedup_in_libbpf
   161588 from_archive_combined+dedup_in_libbpf
   161588 from_unmodified_pahole_DWARF2BTF+dedup_in_libbpf
   323176 total
  acme@number:~/git/bpf-next$

If we use completely unmodified libbpf, bpftool, etc, the "BTF archive"
in the resulting vmlinux .BTF ELF section is still consumable, but just
the first "CU" (the first .o .BTF ELF section) is visible, the one for
init/main.o:

acme@number:~/git/linux$ bpftool version
bpftool v7.5.0
using libbpf v1.5
features: llvm, skeletons
acme@number:~/git/linux$

acme@number:~/git/bpf-next$ bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive format c | wc -l
11361
acme@number:~/git/linux$ bpftool btf dump file ../build/v6.16.0+/init/main.o format c | wc -l
11361
acme@number:~/git/linux$

Furthermore:

acme@number:~/git/linux$ bpftool btf dump file ../build/v6.16.0+/init/main.o format c > a
acme@number:~/git/linux$ bpftool btf dump file ~/vmlinux-v6.16.0+.btf_archive format c > b
acme@number:~/git/linux$

Each patch has extra explanations of the process.

This is complementary to today's series from Alan Maguire, as we can use
the one liner for the kernel build process to test his series without
requiring installing a toolchain that generates BTF for each .o file
that will result in vmlinux.

Next steps on my side are to:

1. change pahole for when it receives --format_path=btf check if
btf__is_archive(btf) is true, then just replace the current vmlinux .BTF
contents with the raw data in this just loaded BTF, short circuiting
the whole process.

2. the kernel build process should be changed to allow one to ask for
just BTF, not DWARF, and if so, using the above method, strip the DWARF
info after using it to generate BTF.

Then when compilers are producing BTF, we switch to that, falling back
to the above method when a compiler is known to generate buggy BTF.

And also to use in CIs, to compare the output generated by the various
methods in the various components.

3. In 2 we can even use the same scheme we use for parallelizing DWARF
loading when loading all the BTF archive members concatenated in vmlinux
to dedup them.

BTW, this is the size of a vmlinux ELF .BTF section with an BTF archive:

acme@number:~/git/linux$ readelf -SW ../build/v6.16.0+/vmlinux | grep BTF
  [15] .BTF        PROGBITS   ffffffff82ff2000  21f2000 16db5976 00   A  0   0  1
  [16] .BTF_ids    PROGBITS   ffffffff99da8000 18fa8000   001238 00   A  0   0  1
acme@number:~/git/linux$

~365 MiB

While the DWARF for that file is at:

  [44] .debug_aranges    PROGBITS  0000000000000000 1aa00000   03bfb0 00      0   0 16
  [45] .debug_info       PROGBITS  0000000000000000 1aa3bfb0 1154b512 00      0   0  1
  [46] .debug_abbrev     PROGBITS  0000000000000000 2bf874c2   81492f 00      0   0  1
  [47] .debug_line       PROGBITS  0000000000000000 2c79bdf1  1ec4abd 00      0   0  1
  [48] .debug_frame      PROGBITS  0000000000000000 2e6608b0   3fd470 00      0   0  8
  [49] .debug_str        PROGBITS  0000000000000000 2ea5dd20   59bbe8 01  MS  0   0  1
  [50] .debug_line_str   PROGBITS  0000000000000000 2eff9908   02de43 01  MS  0   0  1
  [51] .debug_loclists   PROGBITS  0000000000000000 2f02774b  2683cbb 00      0   0  1
  [52] .debug_rnglists   PROGBITS  0000000000000000 316ab406   4f875b 00      0   0  1

>>> 0x1154b512 + 0x81492f + 0x1ec4abd + 0x3fd470 + 0x59bbe8
341563734

~325 MiB

But then BTF, when dedup'ed gets down to:

acme@number:~/git/linux$ readelf -SW ../build/v6.16.0+.no-btf_archive/vmlinux | grep BTF
  [15] .BTF              PROGBITS        ffffffff82fef000 21ef000 64fb32 00   A  0   0  1
  [16] .BTF_ids          PROGBITS        ffffffff8363f000 283f000 001238 00   A  0   0  1
acme@number:~/git/linux$ 

~6.3 MiB

And also BTF has some info generated from other sources besides DWARF,
like kfuncs, per cpu, etc.

Also an observation: for distros the optimal way to produce BTF _and_
DWARF seems to be is the one we have now, don't bother generating .BTF
for all .o, just generate DWARF and at the end generate BTF from it 8-)

For developers not needing DWARF and not caring about reproducible
builds then there are other clever tricks to use like go on adding each
generated BTF using the technique in this patchset, i.e. using
btf__add_btf() and trowing away the just generated BTF to then at the end
do the btf__archive_dedup() (also introduced in this patchset) to have
the end result dropped to disk. But I'm getting carried away, sry.

There are many other details that need to be double checked but I think
the current status is good enough for experimentation.

Cheers,

- Arnaldo

Arnaldo Carvalho de Melo (4):
  libbpf: Simplify error handling removing needless repeated err checks
  libbpf: Check if there is extra data at the end of a BTF
  libbpf: Add support for detecting and dedup'ing a BTF archive
  libbpf: Check if an ELF .BTF section is an archive and combine/dedup

 tools/lib/bpf/btf.c | 91 ++++++++++++++++++++++++++++++++++++++-------
 tools/lib/bpf/btf.h |  3 ++
 2 files changed, 81 insertions(+), 13 deletions(-)

-- 
2.50.1


