Return-Path: <bpf+bounces-75832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19115C98EC4
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5383634594A
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335724DD09;
	Mon,  1 Dec 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8LWgURM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5636D513
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618966; cv=none; b=KpG4n8Y1lIEXSMLXYiOyXjb983hhcvIMnhvEHX1NYYTQu+H8g9aHlo+KDoulGCuKamSjUo1OlWPVo2U/MiK4OorR/ZQcKJ1ecxqB8XHF+hvcmGTnX65MO5cTZPXXIfyGEKnwgRx0J3D9QbhmgCaKMZxrpqznwpBAeYWee0dM4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618966; c=relaxed/simple;
	bh=LNH6oNIk77WewtFm857TvpveEQzFGXZtgb26zxVrlMM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UDFNXnI2dQOjBz1guuav6TjXjWZptbPDXCq+L3CHQhE6DvmvIgCxasJ8+cmx8xYqWWUEfoUM06CsHXBBEePgrHYsZv09QzIgc1Rx+YujGOecTT48GJIhiZ8E8i/IjnenNOsU6M0x74ii10rtP6Q4hWMm4tRIBIk457y9S64iS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8LWgURM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso6462502a91.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 11:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764618963; x=1765223763; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HpYgccVuLsPOnrybaVT24pkjckCWo05GuZ81lLz+wXs=;
        b=m8LWgURMw9WMoe0++86dnWGKS7HoA2MSELCo1ZcYb3/Ctkh3Li+QDkHG4JAFj0rT4j
         eHSyY3w7az1HunnltG5qGUkwts6wrRs65JAUBLMisWH7eKenbkAM/DWP7NXO7s5DmJYM
         CY+RYj1cX1WK8AuDe6iytra24LaMl3xgFY3VSlYMm7iFKd7YQEsb4lpKJCEhreC3PEFJ
         C3w3bHe9iftSqs0dBlzofbakFIZVt8HJWbg2ukRM1iB/KLJagXfKn30UpeL1LSkmCQAU
         vHmSKIr5fFee0IZE0p13sCtaVlJIOaPOVXKSjsnhVz8E9wbaFzRWE0CcWulR3KObL54E
         d1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764618963; x=1765223763;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpYgccVuLsPOnrybaVT24pkjckCWo05GuZ81lLz+wXs=;
        b=hUpdezfYLTe8j7jRRL3PIBUqQXzjpOnk+w+IMXvS+gtwvBkNwOZu3KyWt2tR+c+cSW
         v5bhZ4ZaZbBOfVfidgcFW6Jbtom4UOubrjDxrJfHtPAoXH8SsFiNXvAtLhZ+7u7DyocV
         YP2QlcFPngTfreiRxgiDOZcrAcVMlq/vIrN9UUFokhVXp1SI29XLBkp06xx4yyyW4c+J
         5/xsniFgqWwTW4EoERovbRU7Jn1tllIxCbb1t1RVIYaD0M8m3PSThRDjwOk/TJ7iZLDv
         eGmJJTnlE+keTdcW2aqcgN7d2ybNRK6o9Z14izaDaLuJ8eRX3Q2yJB9my/U+5w4WH01p
         jrPg==
X-Gm-Message-State: AOJu0YzrFtoczETIDuL9PzGUK3MFYh0MbL3QY32br8KzoO8gblyvDbU6
	H7QPhbvBPYdu6FF6ubV7ap70AoPPlzFqg3hvb/BNKbhv29ybZscmbgGJ
X-Gm-Gg: ASbGnctxqb0Mh3zx2s+OkMRtbACkQKYnDsRoVo/UcsX+49DzRoCuuoNtIbSfgx3VHnR
	UnZeVIH9gXefOPkHjGtXJTH4wZrPR2rfLmmJldNZD+wKhvk5RgYfxrGPtBHe9cseYPnuCtw3YgP
	JKZXq2X3GYhaS8BOUdMY/dxsAoIAmKih6R1O/OcKWf/N6Htl7P2wz1q4ZXmw84ZEFdPzSRLX/v3
	kWrz4FfmSmyJE76fUZhIZwjc/+Xmzh6wHj5wBplvd+WHVccQjikae02IUFvMrcZCFUJzm5cgRqJ
	n2CjXRh3fbPonG7K3LjYjx+fHz7JZgrdlPyKfIfs4ULPx8kta7Kes30JB+v7wG5qlV5YCNHOkKm
	6vcubnvW+wzKwAHNIFQLrp36bGo9Tcm5kNv08CWg9z7cCiLPEKOQMdj6RPU0TUAJEa+5iVCdVmX
	cn7Cg2kRMaSzKor01ljmbf6gvklhX0Xwafspr3
X-Google-Smtp-Source: AGHT+IE+gF4nBad0gtsHFewSsT3kYpEWgHRxOhrRxF9Q/ZZJOQBUih9XOX1uHPX8wU2GBId0wrAK/A==
X-Received: by 2002:a17:90b:4a4f:b0:341:761c:3330 with SMTP id 98e67ed59e1d1-34733f11c1emr35698889a91.23.1764618962404;
        Mon, 01 Dec 2025 11:56:02 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a2c1:e629:f1e2:84c8? ([2620:10d:c090:500::6:79eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475fef52besm10450090a91.3.2025.12.01.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 11:56:01 -0800 (PST)
Message-ID: <de6d1c8f581fb746ad97b93dbfb054ae7db6b5d8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Nathan Chancellor	 <nathan@kernel.org>, Nicolas Schier
 <nicolas.schier@linux.dev>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt	 <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>,
 Donglin Peng	 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Mon, 01 Dec 2025 11:55:58 -0800
In-Reply-To: <20251127185242.3954132-5-ihor.solodrai@linux.dev>
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
	 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 10:52 -0800, Ihor Solodrai wrote:
> Currently resolve_btfids updates .BTF_ids section of an ELF file
> in-place, based on the contents of provided BTF, usually within the
> same input file, and optionally a BTF base.
>=20
> This patch changes resolve_btfids behavior to enable BTF
> transformations as part of its main operation. To achieve this
> in-place ELF write in resolve_btfids is replaced with generation of
> the following binaries:
>   * ${1}.btf with .BTF section data
>   * ${1}.distilled_base.btf with .BTF.base section data (for
>     out-of-tree modules)
>   * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}

Nit: use ${1}.BTF / ${1}.BTF.base / ${1}.BTF_ids, so that each file is
     named by it's corresponding section?

>=20
> The execution of resolve_btfids and consumption of its output is
> orchestrated by scripts/gen-btf.sh introduced in this patch.
>=20
> The rationale for this approach is that updating ELF in-place with
> libelf API is complicated and bug-prone, especially in the context of
> the kernel build. On the other hand applying objcopy to manipulate ELF
> sections is simpler and more reliable.

Nit: more context needed, as is the statement raises questions but not
     answers them.

>=20
> There are two distinct paths for BTF generation and resolve_btfids
> application in the kernel build: for vmlinux and for kernel modules.
>=20
> For the vmlinux binary a .BTF section is added in a roundabout way to
> ensure correct linking (details below). The patch doesn't change this
> approach, only the implementation is a little different.
>=20
> Before this patch it worked like follows:
>=20
>   * pahole consumed .tmp_vmlinux1 [1] and added .BTF section with
>     llvm-objcopy [2] to it
>   * then everything except the .BTF section was stripped from .tmp_vmlinu=
x1
>     into a .tmp_vmlinux1.bpf.o object [1], later linked into vmlinux
>   * resolve_btfids was executed later on vmlinux.unstripped [3],
>     updating it in-place
>=20
> After this patch gen-btf.sh implements the following:
>=20
>   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
>     raw BTF data
>   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
>     (potentially modified) .BTF, and .BTF_ids sections data
>   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
>     BTF output of resolve_btfids
>   * .BTF_ids data gets embedded into vmlinux.unstripped in
>     link-vmlinux.sh by objcopy --update-section
>=20
> For the kernel modules creating special .bpf.o file is not necessary,
> and so embedding of sections data produced by resolve_btfids is
> straightforward with the objcopy.
>=20
> With this patch an ELF file becomes effectively read-only within
> resolve_btfids, which allows to delete elf_update() call and satelite
> code (like compressed_section_fix [4]).
>=20
> Endianness handling of .BTF_ids data is also changed. Previously the
> "flags" part of the section was bswapped in sets_patch() [5], and then
> Elf_Type was modified before elf_update() to signal to libelf that
> bswap may be necessary. With this patch we explicitly bswap entire
> data buffer on load and on dump.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n115
> [2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c#n1835
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n285

Nit: these links are moving target, should refer to a commit or a tag.

> [4] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
> [5] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  MAINTAINERS                          |   1 +
>  scripts/Makefile.modfinal            |   5 +-
>  scripts/gen-btf.sh                   | 167 ++++++++++++++++++++
>  scripts/link-vmlinux.sh              |  42 +-----
>  tools/bpf/resolve_btfids/main.c      | 218 +++++++++++++++++----------
>  tools/testing/selftests/bpf/Makefile |   5 +
>  6 files changed, 317 insertions(+), 121 deletions(-)
>  create mode 100755 scripts/gen-btf.sh

Since resolve_btfids is now responsible for distilled base generation,
does Makefile.btf need modification to remove "--btf_features=3Ddistilled_b=
ase"?

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48aabeeed029..5cd34419d952 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4672,6 +4672,7 @@ F:	net/sched/act_bpf.c
>  F:	net/sched/cls_bpf.c
>  F:	samples/bpf/
>  F:	scripts/bpf_doc.py
> +F:	scripts/gen-btf.sh
>  F:	scripts/Makefile.btf
>  F:	scripts/pahole-version.sh
>  F:	tools/bpf/
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 542ba462ed3e..3862fdfa1267 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -38,9 +38,8 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>        cmd_btf_ko =3D 							\
>  	if [ ! -f $(objtree)/vmlinux ]; then				\
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinu=
x\n" $@ 1>&2; \
> -	else								\
> -		LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHO=
LE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
> +	else	\
> +		$(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
>  	fi;
> =20
>  # Same as newer-prereqs, but allows to exclude specified extra dependenc=
ies
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> new file mode 100755
> index 000000000000..2dfb7ab289ca
> --- /dev/null
> +++ b/scripts/gen-btf.sh
> @@ -0,0 +1,167 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> +#
> +# This script generates BTF data for the provided ELF file.
> +#
> +# Kernel BTF generation involves these conceptual steps:
> +#   1. pahole generates BTF from DWARF data
> +#   2. resolve_btfids applies kernel-specific btf2btf
> +#      transformations and computes data for .BTF_ids section
> +#   3. the result gets linked/objcopied into the target binary
> +#
> +# How step (3) should be done differs between vmlinux, and
> +# kernel modules, which is the primary reason for the existence
> +# of this script.
> +#
> +# For modules the script expects vmlinux passed in as --btf_base.
> +# Generated .BTF, .BTF.base and .BTF_ids sections become embedded
> +# into the input ELF file with objcopy.
> +#
> +# For vmlinux the input file remains unchanged and two files are produce=
d:
> +#   - ${1}.btf.o ready for linking into vmlinux
> +#   - ${1}.btf_ids with .BTF_ids data blob
> +# This output is consumed by scripts/link-vmlinux.sh
> +
> +set -e
> +
> +usage()
> +{
> +	echo "Usage: $0 [--btf_base <file>] <target ELF file>"
> +	exit 1
> +}
> +
> +BTF_BASE=3D""
> +
> +while [ $# -gt 0 ]; do
> +	case "$1" in
> +	--btf_base)
> +		BTF_BASE=3D"$2"
> +		shift 2
> +		;;
> +	-*)
> +		echo "Unknown option: $1" >&2
> +		usage
> +		;;
> +	*)
> +		break
> +		;;
> +	esac
> +done
> +
> +if [ $# -ne 1 ]; then
> +	usage
> +fi
> +
> +ELF_FILE=3D"$1"
> +shift
> +
> +is_enabled() {
> +	grep -q "^$1=3Dy" ${objtree}/include/config/auto.conf
> +}
> +
> +info()
> +{
> +	printf "  %-7s %s\n" "${1}" "${2}"
> +}
> +
> +case "${KBUILD_VERBOSE}" in
> +*1*)
> +	set -x
> +	;;
> +esac
> +
> +if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
> +	exit 0
> +fi
> +
> +gen_btf_data()
> +{
> +	info BTF "${ELF_FILE}"
> +	btf1=3D"${ELF_FILE}.btf.1"
> +	${PAHOLE} -J ${PAHOLE_FLAGS}			\
> +		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
> +		--btf_encode_detached=3D${btf1}		\
> +		"${ELF_FILE}"
> +
> +	info BTFIDS "${ELF_FILE}"
> +	RESOLVE_BTFIDS_OPTS=3D""
> +	if is_enabled CONFIG_WERROR; then
> +		RESOLVE_BTFIDS_OPTS+=3D" --fatal_warnings "
> +	fi
> +	if [ -n "${KBUILD_VERBOSE}" ]; then
> +		RESOLVE_BTFIDS_OPTS+=3D" -v "
> +	fi
> +	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_OPTS}	\
> +		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
> +		--btf ${btf1} "${ELF_FILE}"
> +}
> +
> +gen_btf_o()
> +{
> +	local btf_data=3D${ELF_FILE}.btf.o
> +
> +	# Create ${btf_data} which contains just .BTF section but no symbols. A=
dd
> +	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> +	# deletes all symbols including __start_BTF and __stop_BTF, which will
> +	# be redefined in the linker script.
> +	info OBJCOPY "${btf_data}"
> +	echo "" | ${CC} -c -x c -o ${btf_data} -
> +	${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf \
> +		--set-section-flags .BTF=3Dalloc,readonly ${btf_data}
> +	${OBJCOPY} --only-section=3D.BTF --strip-all ${btf_data}
> +
> +	# Change e_type to ET_REL so that it can be used to link final vmlinux.
> +	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> +	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +		et_rel=3D'\0\1'
> +	else
> +		et_rel=3D'\1\0'
> +	fi
> +	printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 seek=
=3D16 status=3Dnone
> +}
> +
> +embed_btf_data()
> +{
> +	info OBJCOPY "${ELF_FILE}"
> +	${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf ${ELF_FILE}
> +
> +	# a module might not have a .BTF_ids or .BTF.base section
> +	local btf_base=3D"${ELF_FILE}.distilled_base.btf"
> +	if [ -f "${btf_base}" ]; then
> +		${OBJCOPY} --add-section .BTF.base=3D${btf_base} ${ELF_FILE}
> +	fi
> +	local btf_ids=3D"${ELF_FILE}.btf_ids"
> +	if [ -f "${btf_ids}" ]; then
> +		${OBJCOPY} --update-section .BTF_ids=3D${btf_ids} ${ELF_FILE}
> +	fi
> +}
> +
> +cleanup()
> +{
> +	rm -f "${ELF_FILE}.btf.1"
> +	rm -f "${ELF_FILE}.btf"
> +	if [ "${BTFGEN_MODE}" =3D "module" ]; then
> +		rm -f "${ELF_FILE}.distilled_base.btf"
> +		rm -f "${ELF_FILE}.btf_ids"
> +	fi
> +}
> +trap cleanup EXIT
> +
> +BTFGEN_MODE=3D"vmlinux"
> +if [ -n "${BTF_BASE}" ]; then
> +	BTFGEN_MODE=3D"module"
> +fi
> +
> +gen_btf_data
> +
> +case "${BTFGEN_MODE}" in
> +vmlinux)
> +	gen_btf_o
> +	;;
> +module)
> +	embed_btf_data
> +	;;
> +esac
> +
> +exit 0
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 433849ff7529..5bea8795f96d 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -105,34 +105,6 @@ vmlinux_link()
>  		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
>  }
> =20
> -# generate .BTF typeinfo from DWARF debuginfo
> -# ${1} - vmlinux image
> -gen_btf()
> -{
> -	local btf_data=3D${1}.btf.o
> -
> -	info BTF "${btf_data}"
> -	LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> -
> -	# Create ${btf_data} which contains just .BTF section but no symbols. A=
dd
> -	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
> -	# deletes all symbols including __start_BTF and __stop_BTF, which will
> -	# be redefined in the linker script. Add 2>/dev/null to suppress GNU
> -	# objcopy warnings: "empty loadable segment detected at ..."
> -	${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,reado=
nly \
> -		--strip-all ${1} "${btf_data}" 2>/dev/null
> -	# Change e_type to ET_REL so that it can be used to link final vmlinux.
> -	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> -	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> -		et_rel=3D'\0\1'
> -	else
> -		et_rel=3D'\1\0'
> -	fi
> -	printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 seek=
=3D16 status=3Dnone
> -
> -	btf_vmlinux_bin_o=3D${btf_data}
> -}
> -
>  # Create ${2}.o file with all symbols from the ${1} object file
>  kallsyms()
>  {
> @@ -204,6 +176,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; the=
n
>  fi
> =20
>  btf_vmlinux_bin_o=3D
> +btfids_vmlinux=3D
>  kallsymso=3D
>  strip_debug=3D
>  generate_map=3D
> @@ -224,11 +197,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_=
DEBUG_INFO_BTF; then
>  fi
> =20
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> -	if ! gen_btf .tmp_vmlinux1; then
> +	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then

Nit: maybe pass output file names as parameters for get-btf.sh?

>  		echo >&2 "Failed to generate BTF for vmlinux"
>  		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
>  		exit 1
>  	fi
> +	btf_vmlinux_bin_o=3D.tmp_vmlinux1.btf.o
> +	btfids_vmlinux=3D.tmp_vmlinux1.btf_ids
>  fi
> =20
>  if is_enabled CONFIG_KALLSYMS; then
> @@ -281,14 +256,9 @@ fi
> =20
>  vmlinux_link "${VMLINUX}"
> =20
> -# fill in BTF IDs
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> -	info BTFIDS "${VMLINUX}"
> -	RESOLVE_BTFIDS_ARGS=3D""
> -	if is_enabled CONFIG_WERROR; then
> -		RESOLVE_BTFIDS_ARGS=3D" --fatal_warnings "
> -	fi
> -	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
> +	info OBJCOPY ${btfids_vmlinux}
> +	${OBJCOPY} --update-section .BTF_ids=3D${btfids_vmlinux} ${VMLINUX}
>  fi

Nit: Maybe do this in get-btf.sh as for modules?
     To avoid checking for CONFIG_DEBUG_INFO_BTF in two places.

> =20
>  mksysmap "${VMLINUX}" System.map
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index c60d303ca6ed..b8df6256e29e 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -71,9 +71,11 @@
>  #include <fcntl.h>
>  #include <errno.h>
>  #include <linux/btf_ids.h>
> +#include <linux/kallsyms.h>
>  #include <linux/rbtree.h>
>  #include <linux/zalloc.h>
>  #include <linux/err.h>
> +#include <linux/limits.h>
>  #include <bpf/btf.h>
>  #include <bpf/libbpf.h>
>  #include <subcmd/parse-options.h>
> @@ -124,6 +126,7 @@ struct object {
> =20
>  	struct btf *btf;
>  	struct btf *base_btf;
> +	bool distilled_base;
> =20
>  	struct {
>  		int		 fd;
> @@ -308,42 +311,16 @@ static struct btf_id *add_symbol(struct rb_root *ro=
ot, char *name, size_t size)
>  	return btf_id;
>  }
> =20
> -/* Older libelf.h and glibc elf.h might not yet define the ELF compressi=
on types. */
> -#ifndef SHF_COMPRESSED
> -#define SHF_COMPRESSED (1 << 11) /* Section with compressed data. */
> -#endif
> -
> -/*
> - * The data of compressed section should be aligned to 4
> - * (for 32bit) or 8 (for 64 bit) bytes. The binutils ld
> - * sets sh_addralign to 1, which makes libelf fail with
> - * misaligned section error during the update:
> - *    FAILED elf_update(WRITE): invalid section alignment
> - *
> - * While waiting for ld fix, we fix the compressed sections
> - * sh_addralign value manualy.
> - */
> -static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
> +static void bswap_32_data(void *data, u32 nr_bytes)
>  {
> -	int expected =3D gelf_getclass(elf) =3D=3D ELFCLASS32 ? 4 : 8;
> +	u32 cnt, i;
> +	u32 *ptr;
> =20
> -	if (!(sh->sh_flags & SHF_COMPRESSED))
> -		return 0;
> +	cnt =3D nr_bytes / sizeof(u32);
> +	ptr =3D data;
> =20
> -	if (sh->sh_addralign =3D=3D expected)
> -		return 0;
> -
> -	pr_debug2(" - fixing wrong alignment sh_addralign %u, expected %u\n",
> -		  sh->sh_addralign, expected);
> -
> -	sh->sh_addralign =3D expected;
> -
> -	if (gelf_update_shdr(scn, sh) =3D=3D 0) {
> -		pr_err("FAILED cannot update section header: %s\n",
> -			elf_errmsg(-1));
> -		return -1;
> -	}
> -	return 0;
> +	for (i =3D 0; i < cnt; i++)
> +		ptr[i] =3D bswap_32(ptr[i]);
>  }
> =20
>  static int elf_collect(struct object *obj)
> @@ -364,7 +341,7 @@ static int elf_collect(struct object *obj)
> =20
>  	elf_version(EV_CURRENT);
> =20
> -	elf =3D elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> +	elf =3D elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL);
>  	if (!elf) {
>  		close(fd);
>  		pr_err("FAILED cannot create ELF descriptor: %s\n",
> @@ -427,21 +404,20 @@ static int elf_collect(struct object *obj)
>  			obj->efile.symbols_shndx =3D idx;
>  			obj->efile.strtabidx     =3D sh.sh_link;
>  		} else if (!strcmp(name, BTF_IDS_SECTION)) {
> +			/*
> +			 * If target endianness differs from host, we need to bswap32
> +			 * the .BTF_ids section data on load, because .BTF_ids has
> +			 * Elf_Type =3D ELF_T_BYTE, and so libelf returns data buffer in
> +			 * the target endiannes. We repeat this on dump.
> +			 */
> +			if (obj->efile.encoding !=3D ELFDATANATIVE) {
> +				pr_debug("bswap_32 .BTF_ids data from target to host endianness\n");
> +				bswap_32_data(data->d_buf, data->d_size);
> +			}
>  			obj->efile.idlist       =3D data;
>  			obj->efile.idlist_shndx =3D idx;
>  			obj->efile.idlist_addr  =3D sh.sh_addr;
> -		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
> -			/* If a .BTF.base section is found, do not resolve
> -			 * BTF ids relative to vmlinux; resolve relative
> -			 * to the .BTF.base section instead.  btf__parse_split()
> -			 * will take care of this once the base BTF it is
> -			 * passed is NULL.
> -			 */
> -			obj->base_btf_path =3D NULL;
>  		}
> -
> -		if (compressed_section_fix(elf, scn, &sh))
> -			return -1;
>  	}
> =20
>  	return 0;
> @@ -545,6 +521,13 @@ static int symbols_collect(struct object *obj)
>  	return 0;
>  }
> =20
> +static inline bool is_envvar_set(const char *var_name)
> +{
> +	const char *value =3D getenv(var_name);
> +
> +	return value && value[0] !=3D '\0';
> +}
> +
>  static int load_btf(struct object *obj)
>  {
>  	struct btf *base_btf =3D NULL, *btf =3D NULL;
> @@ -571,6 +554,20 @@ static int load_btf(struct object *obj)
>  	obj->base_btf =3D base_btf;
>  	obj->btf =3D btf;
> =20
> +	if (obj->base_btf && is_envvar_set("KBUILD_EXTMOD")) {

This is a bit ugly, maybe use a dedicated parameter instead of
checking environment variable?

> +		err =3D btf__distill_base(obj->btf, &base_btf, &btf);
> +		if (err) {
> +			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
> +			goto out_err;
> +		}
> +
> +		btf__free(obj->btf);
> +		btf__free(obj->base_btf);
> +		obj->btf =3D btf;
> +		obj->base_btf =3D base_btf;
> +		obj->distilled_base =3D true;
> +	}
> +
>  	return 0;
> =20
>  out_err:
> @@ -744,24 +741,6 @@ static int sets_patch(struct object *obj)
>  			 */
>  			BUILD_BUG_ON((u32 *)set8->pairs !=3D &set8->pairs[0].id);
>  			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> -
> -			/*
> -			 * When ELF endianness does not match endianness of the
> -			 * host, libelf will do the translation when updating
> -			 * the ELF. This, however, corrupts SET8 flags which are
> -			 * already in the target endianness. So, let's bswap
> -			 * them to the host endianness and libelf will then
> -			 * correctly translate everything.
> -			 */
> -			if (obj->efile.encoding !=3D ELFDATANATIVE) {
> -				int i;
> -
> -				set8->flags =3D bswap_32(set8->flags);
> -				for (i =3D 0; i < set8->cnt; i++) {
> -					set8->pairs[i].flags =3D
> -						bswap_32(set8->pairs[i].flags);
> -				}
> -			}
>  			break;
>  		case BTF_ID_KIND_SYM:
>  		default:
> @@ -778,8 +757,6 @@ static int sets_patch(struct object *obj)
> =20
>  static int symbols_patch(struct object *obj)
>  {
> -	off_t err;
> -
>  	if (__symbols_patch(obj, &obj->structs)  ||
>  	    __symbols_patch(obj, &obj->unions)   ||
>  	    __symbols_patch(obj, &obj->typedefs) ||
> @@ -790,20 +767,77 @@ static int symbols_patch(struct object *obj)
>  	if (sets_patch(obj))
>  		return -1;
> =20
> -	/* Set type to ensure endian translation occurs. */
> -	obj->efile.idlist->d_type =3D ELF_T_WORD;
> +	return 0;
> +}
> =20
> -	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
> +static int dump_raw_data(const char *out_path, const void *data, u32 siz=
e)
> +{
> +	int fd, ret;
> =20
> -	err =3D elf_update(obj->efile.elf, ELF_C_WRITE);
> -	if (err < 0) {
> -		pr_err("FAILED elf_update(WRITE): %s\n",
> -			elf_errmsg(-1));
> +	fd =3D open(out_path, O_WRONLY | O_CREAT | O_TRUNC, 0640);
> +	if (fd < 0) {
> +		pr_err("Couldn't open %s for writing\n", out_path);
> +		return fd;
> +	}
> +
> +	ret =3D write(fd, data, size);
> +	if (ret < 0 || ret !=3D size) {
> +		pr_err("Failed to write data to %s\n", out_path);
> +		close(fd);
> +		unlink(out_path);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	pr_debug("Dumped %lu bytes of data to %s\n", size, out_path);
> +
> +	return 0;
> +}
> +
> +static int dump_raw_btf_ids(struct object *obj, const char *out_path)
> +{
> +	Elf_Data *data =3D obj->efile.idlist;
> +	int fd, err;
> +
> +	if (!data || !data->d_buf) {
> +		pr_debug("%s has no BTF_ids data to dump\n", obj->path);
> +		return 0;
> +	}
> +
> +	/*
> +	 * If target endianness differs from host, we need to bswap32 the
> +	 * .BTF_ids section data before dumping so that the output is in
> +	 * target endianness.
> +	 */
> +	if (obj->efile.encoding !=3D ELFDATANATIVE) {
> +		pr_debug("bswap_32 .BTF_ids data from host to target endianness\n");
> +		bswap_32_data(data->d_buf, data->d_size);
> +	}
> +
> +	err =3D dump_raw_data(out_path, data->d_buf, data->d_size);
> +	if (err)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int dump_raw_btf(struct btf *btf, const char *out_path)
> +{
> +	const void *raw_btf_data;
> +	u32 raw_btf_size;
> +	int fd, err;
> +
> +	raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
> +	if (raw_btf_data =3D=3D NULL) {
> +		pr_err("btf__raw_data() failed\n");
> +		return -1;
>  	}
> =20
> -	pr_debug("update %s for %s\n",
> -		 err >=3D 0 ? "ok" : "failed", obj->path);
> -	return err < 0 ? -1 : 0;
> +	err =3D dump_raw_data(out_path, raw_btf_data, raw_btf_size);
> +	if (err)
> +		return -1;
> +
> +	return 0;
>  }
> =20
>  static const char * const resolve_btfids_usage[] =3D {
> @@ -824,6 +858,7 @@ int main(int argc, const char **argv)
>  		.funcs    =3D RB_ROOT,
>  		.sets     =3D RB_ROOT,
>  	};
> +	char out_path[PATH_MAX];
>  	bool fatal_warnings =3D false;
>  	struct option btfid_options[] =3D {
>  		OPT_INCR('v', "verbose", &verbose,
> @@ -836,7 +871,7 @@ int main(int argc, const char **argv)
>  			    "turn warnings into errors"),
>  		OPT_END()
>  	};
> -	int err =3D -1;
> +	int err =3D -1, path_len;
> =20
>  	argc =3D parse_options(argc, argv, btfid_options, resolve_btfids_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -844,6 +879,11 @@ int main(int argc, const char **argv)
>  		usage_with_options(resolve_btfids_usage, btfid_options);
> =20
>  	obj.path =3D argv[0];
> +	strcpy(out_path, obj.path);
> +	path_len =3D strlen(out_path);
> +
> +	if (load_btf(&obj))
> +		goto out;
> =20
>  	if (elf_collect(&obj))
>  		goto out;
> @@ -854,23 +894,37 @@ int main(int argc, const char **argv)
>  	 */
>  	if (obj.efile.idlist_shndx =3D=3D -1 ||
>  	    obj.efile.symbols_shndx =3D=3D -1) {
> -		pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
> -		err =3D 0;
> -		goto out;
> +		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resol=
ution\n");
> +		goto dump_btf;
>  	}
> =20
>  	if (symbols_collect(&obj))
>  		goto out;
> =20
> -	if (load_btf(&obj))
> -		goto out;
> -
>  	if (symbols_resolve(&obj))
>  		goto out;
> =20
>  	if (symbols_patch(&obj))
>  		goto out;
> =20
> +	out_path[path_len] =3D '\0';
> +	strcat(out_path, ".btf_ids");

Nit: here and below use snprintf() to check for 'out_path' overflow.

> +	if (dump_raw_btf_ids(&obj, out_path))
> +		goto out;
> +
> +dump_btf:
> +	out_path[path_len] =3D '\0';
> +	strcat(out_path, ".btf");
> +	if (dump_raw_btf(obj.btf, out_path))
> +		goto out;
> +
> +	if (obj.base_btf && obj.distilled_base) {
> +		out_path[path_len] =3D '\0';
> +		strcat(out_path, ".distilled_base.btf");
> +		if (dump_raw_btf(obj.base_btf, out_path))
> +			goto out;
> +	}
> +
>  	if (!(fatal_warnings && warnings))
>  		err =3D 0;
>  out:
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index bac22265e7ff..ec7e2a7721c7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>  include ../../../scripts/Makefile.include
> =20
>  CXX ?=3D $(CROSS_COMPILE)g++
> +OBJCOPY ?=3D $(CROSS_COMPILE)objcopy
> =20
>  CURDIR :=3D $(abspath .)
>  TOOLSDIR :=3D $(abspath ../../..)
> @@ -716,6 +717,10 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			=
\
>  	$$(call msg,BINARY,,$$@)
>  	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
>  	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
> +	$(Q)if [ -f $$@.btf_ids ]; then \
> +		$(OBJCOPY) --update-section .BTF_ids=3D$$@.btf_ids $$@; \
> +	fi
> +	$(Q)rm -f $$@.btf_ids $$@.btf
>  	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>  		   $(OUTPUT)/$(if $2,$2/)bpftool
> =20

