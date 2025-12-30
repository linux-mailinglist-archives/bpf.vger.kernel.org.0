Return-Path: <bpf+bounces-77493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B9CE86E0
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 01:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A6983002866
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 00:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4922DAFD2;
	Tue, 30 Dec 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V/kepN0w"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26E26FD9B
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055155; cv=none; b=T9gnI+DwgRfRPfCdcq6TehjBlDhjf11LyKOOGHZJdMD61BjfYaoyrz6hidj5EqUqsY/kEUsLZPubPWOPAIjSXq0fhEMGxF4kj6/44ps2k6Racg9Ql2VCKaO6u7c5l53f2H4B2M47OSTl39R1PIHp8/9xCPpEpUWvuBkdLxHKujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055155; c=relaxed/simple;
	bh=M659sPQOvLFV3BCNl2JNSqVo70RbarX3ZoyjC4Zq7TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO6Noq6vFd+593AFd4KKrns4e5YDWWEzxozOrTk9M56u5BaPa6eRtCmPmfJePuQgkpZ7jN1I6mby8CycnDvxbRmuBMdylOzm/yWexQy0kAshjGOVZQ7+TJDU2B5bo4fChZ3eAbnJASB+87QW0oLoEbPVTddkXAVr3iUglZk5Z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V/kepN0w; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b87701b-98fb-4089-a201-a7b402e338f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767055139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZ0rl7I7lmxVmU7BSgSJMbbK8yhJOkLk5WHhD4BsSKs=;
	b=V/kepN0wVe1uWodF7oFrqjGXy1/bNW12dC1/UJGo4V/nRgLeZSWWXZe3qrgYe5QdleXvX0
	NaMWbXZ9y8By/0cnQcn90AyBtR0EdKba7MFnvYauwwbQbkESmzo0cOkp63nvWcprYxYMT7
	G1EMocwkA9vnE4UBD7S7sphnbwBVMww=
Date: Mon, 29 Dec 2025 16:38:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1] module: Fix kernel panic when a symbol st_shndx is
 out of bounds
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20251224005752.201911-1-ihor.solodrai@linux.dev>
 <9edd1395-8651-446b-b056-9428076cd830@linux.dev>
 <af906e9e-8f94-41f5-9100-1a3b4526e220@linux.dev>
 <20251229212938.GA2701672@ax162>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20251229212938.GA2701672@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/29/25 1:29 PM, Nathan Chancellor wrote:
> Hi Ihor,
> 
> On Mon, Dec 29, 2025 at 12:40:10PM -0800, Ihor Solodrai wrote:
>> I think the simplest workaround is this one: use objcopy from binutils
>> instead of llvm-objcopy when doing --update-section.
>>
>> There are just 3 places where that happens, so the OBJCOPY
>> substitution is going to be localized.
>>
>> Also binutils is a documented requirement for compiling the kernel,
>> whether with clang or not [1].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst?h=v6.18#n29
> 
> This would necessitate always specifying a CROSS_COMPILE variable when
> cross compiling with LLVM=1, which I would really like to avoid. The
> LLVM variants have generally been drop in substitutes for several
> versions now so some groups such as Android may not even have GNU
> binutils installed in their build environment (see a recent build
> fix [1]).
> 
> I would much prefer detecting llvm-objcopy in Kconfig (such as by
> creating CONFIG_OBJCOPY_IS_LLVM using the existing check for
> llvm-objcopy in X86_X32_ABI in arch/x86/Kconfig) and requiring a working
> copy (>= 22.0.0 presuming the fix is soon merged) or an explicit opt
> into GNU objcopy via OBJCOPY=...objcopy for CONFIG_DEBUG_INFO_BTF to be
> selectable.

I like the idea of opt into GNU objcopy, however I think we should
avoid requiring kbuilds that want CONFIG_DEBUG_INFO_BTF to change any
configuration (such as adding an explicit OBJCOPY= in a build command).

I drafted a patch (pasted below), introducing BTF_OBJCOPY which
defaults to GNU objcopy. This implements the workaround, and should be
easy to update with a LLVM version check later after the bug is fixed.

This bit:

@@ -391,6 +391,7 @@ config DEBUG_INFO_BTF
        depends on PAHOLE_VERSION >= 122
        # pahole uses elfutils, which does not have support for Hexagon relocations
        depends on !HEXAGON
+       depends on $(success,command -v $(BTF_OBJCOPY))

Will turn off DEBUG_INFO_BTF if relevant GNU objcopy happens to not be
installed.

However I am not sure this is the right way to fail here. Because if
the kernel really does need BTF (which is effectively all kernels
using BPF), then we are breaking them anyways just downstream of the
build.

An "objcopy: command not found" might make some pipelines red, but it
is very clear how to address.

Thoughts?


From 7c3b9cce97cc76d0365d8948b1ca36c61faddde3 Mon Sep 17 00:00:00 2001
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Date: Mon, 29 Dec 2025 15:49:51 -0800
Subject: [PATCH] BTF_OBJCOPY

---
 Makefile                             |  6 +++++-
 lib/Kconfig.debug                    |  1 +
 scripts/gen-btf.sh                   | 10 +++++-----
 scripts/link-vmlinux.sh              |  2 +-
 tools/testing/selftests/bpf/Makefile |  4 ++--
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 18adf5502244..b7797a85b8c2 100644
--- a/Makefile
+++ b/Makefile
@@ -534,6 +534,9 @@ CLIPPY_DRIVER	= clippy-driver
 BINDGEN		= bindgen
 PAHOLE		= pahole
 RESOLVE_BTFIDS	= $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
+# Always use GNU objcopy when manipulating BTF sections to work around
+# a bug in llvm-objcopy: https://github.com/llvm/llvm-project/issues/168060
+BTF_OBJCOPY	= $(CROSS_COMPILE)objcopy
 LEX		= flex
 YACC		= bison
 AWK		= awk
@@ -627,7 +630,8 @@ export CLIPPY_CONF_DIR := $(srctree)
 export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
 export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
-export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
+export CPP AR NM STRIP OBJCOPY OBJDUMP READELF LEX YACC AWK INSTALLKERNEL
+export PAHOLE RESOLVE_BTFIDS BTF_OBJCOPY
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD TAR
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS KBUILD_PROCMACROLDFLAGS LDFLAGS_MODULE
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 60281c4f9e99..ec9e683244fa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -391,6 +391,7 @@ config DEBUG_INFO_BTF
 	depends on PAHOLE_VERSION >= 122
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
+	depends on $(success,command -v $(BTF_OBJCOPY))
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on requires pahole v1.22 or later, which will convert
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 06c6d8becaa2..6ae671523edd 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -97,9 +97,9 @@ gen_btf_o()
 	# be redefined in the linker script.
 	info OBJCOPY "${btf_data}"
 	echo "" | ${CC} ${CLANG_FLAGS} -c -x c -o ${btf_data} -
-	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+	${BTF_OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
-	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+	${BTF_OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
 
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
@@ -114,16 +114,16 @@ gen_btf_o()
 embed_btf_data()
 {
 	info OBJCOPY "${ELF_FILE}.BTF"
-	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF ${ELF_FILE}
+	${BTF_OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF ${ELF_FILE}
 
 	# a module might not have a .BTF_ids or .BTF.base section
 	local btf_base="${ELF_FILE}.BTF.base"
 	if [ -f "${btf_base}" ]; then
-		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
+		${BTF_OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
 	local btf_ids="${ELF_FILE}.BTF_ids"
 	if [ -f "${btf_ids}" ]; then
-		${OBJCOPY} --update-section .BTF_ids=${btf_ids} ${ELF_FILE}
+		${BTF_OBJCOPY} --update-section .BTF_ids=${btf_ids} ${ELF_FILE}
 	fi
 }
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e2207e612ac3..4ad04d31f8bc 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -266,7 +266,7 @@ vmlinux_link "${VMLINUX}"
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	info OBJCOPY ${btfids_vmlinux}
-	${OBJCOPY} --update-section .BTF_ids=${btfids_vmlinux} ${VMLINUX}
+	${BTF_OBJCOPY} --update-section .BTF_ids=${btfids_vmlinux} ${VMLINUX}
 fi
 
 mksysmap "${VMLINUX}" System.map
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f28a32b16ff0..e998cac975c1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,7 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
-OBJCOPY ?= $(CROSS_COMPILE)objcopy
+BTF_OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -657,7 +657,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
 		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(OBJCOPY) --update-section .BTF_ids=$$@.BTF_ids $$@)
+		$(BTF_OBJCOPY) --update-section .BTF_ids=$$@.BTF_ids $$@)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
-- 
2.47.3




> 
>> Patching llvm-objcopy would be great, it should be done. But we are
>> still going to be stuck with making sure older LLVMs can build the kernel.
>> So even if they backport the fix to v21, it won't help us much, unfortunately.
> 
> 21.1.8 was the last planned 21.x release [2] so I think it is unlikely
> that a 21.1.9 would be released for this but we won't know until it is
> merged into main. Much agreed on handling the old versions.
> 
> [1]: https://lore.kernel.org/20251218175824.3122690-1-cmllamas@google.com/
> [2]: https://discourse.llvm.org/t/llvm-21-1-8-released/89144
> 
> Cheers,
> Nathan


