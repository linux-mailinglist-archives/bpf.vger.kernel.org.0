Return-Path: <bpf+bounces-76070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D4CA4A35
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD39A301DD9F
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8222F4A19;
	Thu,  4 Dec 2025 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kogMvnBd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB12D9EDC
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867437; cv=none; b=sgPJEK9d3yF1mDdI0ZrOUILcnMXADAtYbionJooT/ic/4rmfDQvLlwcnCP0jKnKFeDhBh/wX13wAEXj2Rrt7YlPNYuwj/vjA8HKrp/rEs/KLNasp05XrKcvAwZmOpIDZfRtm4jqq8Shr12QtpT1sINoa4fBKWu+J4chO7FwR5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867437; c=relaxed/simple;
	bh=WSKdq065b2bg73RM1QC2NTW8lum4CtJkGrY3bRl3HOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZ0G6Wbh/7+5tQgqg7ZvG/n4mjLmS7t8tsjMfxZylDyw8tAK0FWE69DVq2HLYGGAz+dSHtnef3lFSxVg/eSevvNgk51u36/75nBFQVVumGpB3kZQbeOoXQfLii3vEFe5mIR1fhPjvNCf4Z0wZgZy4N8S0QrJNXL0Fvf5ovGUZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kogMvnBd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1150841b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764867434; x=1765472234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EnUWeXvFFHXpuOQ6+JecJx8npA3az8WGZnGGOoeYLF4=;
        b=kogMvnBdvpoy+L+0S+JCe6Q8DESzu+83VfuGKWfMEY0KEh29YNDtqyV3dEOxNyRhCl
         RI6gjn1Y5X84MV8DHgw8UtIh5G+zlDbO9xbA0w137zZI+432UifmfD/KexU8u/Gdtzn3
         R5Q7oYkeSZ4aUTHc7A3JaQTAlpZpMF/3e7RyE6+Ona5TVS9CAkGPzd88P6gQ7Ekj7e8J
         Ma9oKAJzRjVXkha3lgecsQSjE5F1BEi2WFCY/X2K2uecB9RUWQk756+p39s/PZBYpF4e
         S16gDG4P5wjbsviY2wLhvZwwBiJPe/gucrdw7o3DEzAdCUicKge3AcwOeHhK+QD3K03j
         KVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764867434; x=1765472234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnUWeXvFFHXpuOQ6+JecJx8npA3az8WGZnGGOoeYLF4=;
        b=ss836PDN1O5GURH/DqwF2nxIwWjZSSNy0uvWLiMgRMYYMqV4BULAqQI63LrRt1CAjY
         t0zrPsace2YGWoQn5LTTV7LhVW9Y2acLj1u6KyDek7EgjaUrarz1nPVWoVCJ726FZsxT
         0Em2gRlgUVD1Ots6e/C0RpU1fcKgol+y9YNTVNQcm5UsVdRRamVQKUTwnAkSik2FqmR8
         9YALDLxrHWW/Xne4Ax8x1mKvkYshYb4zwU+kRAKs1GAUin8KZ3vEKit97Al0mNMY/e47
         ruP//kGU42i2eq4aiu6wMBIY0Gmhx7e2oyi/vX05XlmzdTUDRO1XMrboCJm6EiM3IoNk
         uDDg==
X-Gm-Message-State: AOJu0YzHgCWvVA1FxQggAo2X1hiJonzBHox7W3EsIrKttp2uRUanUxN7
	pGHMMVCQLIL8rw7l/HsRQJ7hV4bhm9fwLVFx5QcyFObs3L6C4N/AOaJn
X-Gm-Gg: ASbGncvF0TmzmUAIY+PR4vR4CLSyehB2H1NzPMkTXtMonSs/sA+LDtJIGt3wqhmIXkJ
	Fmz15pjC94LroNejIwUv24+rIRvaj9aLCCEQkt0fdldIrmOEPpNCru1RkFAXZS67ks9n+oEjaqJ
	L7dyL1INHqnkAgI+Iaz7v3T/g0G8JATEf3Vx3xxeIYki1uGDEfHIPBs711Yy2wYSZHJnqn29YG7
	2cQlJS43k1hCS2hZ5QUIBKiAnjcQ/0r5GCGGjQ3ZJo8ZLA8i815n5BelbMgY9NSpP5pBUWwiMG9
	2nQQzMKlk7KeqAQDqA5AFVSNdoeZeBCwdNLZV0FiZSYDYu8S/4+4Zp0V7vhuEETOTNBZE//sCH1
	CwsDo/3BBOElOPT3aYIEOz/AZE2P79iZqo1uBvjJSpfXy5/WlNPrfn7JPvz2DagqKfEP/3Hos2Y
	4rBUyBJRv+
X-Google-Smtp-Source: AGHT+IF7o9Xkrwh1Q5jY/q1AfwqBvYJDkH2k5V4PWh3n2d3yb+SjiWfalDpR+niZEkUQ/19jdkludQ==
X-Received: by 2002:a05:6a20:958e:b0:35e:4f06:4fbb with SMTP id adf61e73a8af0-363f5cd9260mr8699858637.2.1764867433592;
        Thu, 04 Dec 2025 08:57:13 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a2364693sm2301391a12.26.2025.12.04.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:57:13 -0800 (PST)
Message-ID: <763200e4f55197da44789b97fd5379ae8bf32c08.camel@gmail.com>
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
Date: Thu, 04 Dec 2025 08:57:10 -0800
In-Reply-To: <e8aacbc8-3702-42e9-b5f0-cfcd71df072e@linux.dev>
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
	 <20251127185242.3954132-5-ihor.solodrai@linux.dev>
	 <de6d1c8f581fb746ad97b93dbfb054ae7db6b5d8.camel@gmail.com>
	 <e8aacbc8-3702-42e9-b5f0-cfcd71df072e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 21:13 -0800, Ihor Solodrai wrote:
> On 12/1/25 11:55 AM, Eduard Zingerman wrote:
> > On Thu, 2025-11-27 at 10:52 -0800, Ihor Solodrai wrote:
> > > Currently resolve_btfids updates .BTF_ids section of an ELF file
> > > in-place, based on the contents of provided BTF, usually within the
> > > same input file, and optionally a BTF base.
> > >=20
>=20
> Hi Eduard, thank you for the review.
>=20
> > > This patch changes resolve_btfids behavior to enable BTF
> > > transformations as part of its main operation. To achieve this
> > > in-place ELF write in resolve_btfids is replaced with generation of
> > > the following binaries:
> > >   * ${1}.btf with .BTF section data
> > >   * ${1}.distilled_base.btf with .BTF.base section data (for
> > >     out-of-tree modules)
> > >   * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}
> >=20
> > Nit: use ${1}.BTF / ${1}.BTF.base / ${1}.BTF_ids, so that each file is
> >      named by it's corresponding section?
>=20
> Sure, makes sense.
>=20
> >=20
> > >=20
> > > The execution of resolve_btfids and consumption of its output is
> > > orchestrated by scripts/gen-btf.sh introduced in this patch.
> > >=20
> > > The rationale for this approach is that updating ELF in-place with
> > > libelf API is complicated and bug-prone, especially in the context of
> > > the kernel build. On the other hand applying objcopy to manipulate EL=
F
> > > sections is simpler and more reliable.
> >=20
> > Nit: more context needed, as is the statement raises questions but not
> >      answers them.
>=20
> Would you like to see more details about why using libelf is complicated?
> I don't follow what's unclear here, sorry...

The claim here is: "libelf API is complicated and bug-prone ... in
context of the kernel build". This is a very vague wording.
The decision to rely on objcopy/linker comes from a specific needs
outlined by Andrii in an off-list discussion. It will be good to have
this context captured in the commit message, instead of bluntly
stating that libelf is bug-prone.

> > > There are two distinct paths for BTF generation and resolve_btfids
> > > application in the kernel build: for vmlinux and for kernel modules.
> > >=20
> > > For the vmlinux binary a .BTF section is added in a roundabout way to
> > > ensure correct linking (details below). The patch doesn't change this
> > > approach, only the implementation is a little different.
> > >=20
> > > Before this patch it worked like follows:
> > >=20
> > >   * pahole consumed .tmp_vmlinux1 [1] and added .BTF section with
> > >     llvm-objcopy [2] to it
> > >   * then everything except the .BTF section was stripped from .tmp_vm=
linux1
> > >     into a .tmp_vmlinux1.bpf.o object [1], later linked into vmlinux
> > >   * resolve_btfids was executed later on vmlinux.unstripped [3],
> > >     updating it in-place
> > >=20
> > > After this patch gen-btf.sh implements the following:
> > >=20
> > >   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
> > >     raw BTF data
> > >   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
> > >     (potentially modified) .BTF, and .BTF_ids sections data
> > >   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copyin=
g
> > >     BTF output of resolve_btfids
> > >   * .BTF_ids data gets embedded into vmlinux.unstripped in
> > >     link-vmlinux.sh by objcopy --update-section
> > >=20
> > > For the kernel modules creating special .bpf.o file is not necessary,
> > > and so embedding of sections data produced by resolve_btfids is
> > > straightforward with the objcopy.
> > >=20
> > > With this patch an ELF file becomes effectively read-only within
> > > resolve_btfids, which allows to delete elf_update() call and satelite
> > > code (like compressed_section_fix [4]).
> > >=20
> > > Endianness handling of .BTF_ids data is also changed. Previously the
> > > "flags" part of the section was bswapped in sets_patch() [5], and the=
n
> > > Elf_Type was modified before elf_update() to signal to libelf that
> > > bswap may be necessary. With this patch we explicitly bswap entire
> > > data buffer on load and on dump.
> > >=20
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/=
scripts/link-vmlinux.sh#n115
> > > [2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_e=
ncoder.c#n1835
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/=
scripts/link-vmlinux.sh#n285
> >=20
> > Nit: these links are moving target, should refer to a commit or a tag.
>=20
> Acked
>=20
> >=20
> > > [4] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.=
org/
> > > [5] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.co=
m/
> > >=20
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > ---
> > >  MAINTAINERS                          |   1 +
> > >  scripts/Makefile.modfinal            |   5 +-
> > >  scripts/gen-btf.sh                   | 167 ++++++++++++++++++++
> > >  scripts/link-vmlinux.sh              |  42 +-----
> > >  tools/bpf/resolve_btfids/main.c      | 218 +++++++++++++++++--------=
--
> > >  tools/testing/selftests/bpf/Makefile |   5 +
> > >  6 files changed, 317 insertions(+), 121 deletions(-)
> > >  create mode 100755 scripts/gen-btf.sh
> >=20
> > Since resolve_btfids is now responsible for distilled base generation,
> > does Makefile.btf need modification to remove "--btf_features=3Ddistill=
ed_base"?
>=20
> Yes, good catch.
>=20
> >=20
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 48aabeeed029..5cd34419d952 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4672,6 +4672,7 @@ F:	net/sched/act_bpf.c
> > >  F:	net/sched/cls_bpf.c
> > >  F:	samples/bpf/
> > >  F:	scripts/bpf_doc.py
> > > +F:	scripts/gen-btf.sh
> > >  F:	scripts/Makefile.btf
> > >  F:	scripts/pahole-version.sh
> > >  F:	tools/bpf/
> > > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > > index 542ba462ed3e..3862fdfa1267 100644
> > > --- a/scripts/Makefile.modfinal
> > > +++ b/scripts/Makefile.modfinal
> > > @@ -38,9 +38,8 @@ quiet_cmd_btf_ko =3D BTF [M] $@
> > >        cmd_btf_ko =3D 							\
> > >  	if [ ! -f $(objtree)/vmlinux ]; then				\
> > >  		printf "Skipping BTF generation for %s due to unavailability of vm=
linux\n" $@ 1>&2; \
> > > -	else								\
> > > -		LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_=
PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> > > -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
> > > +	else	\
> > > +		$(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
> > >  	fi;
> > > =20
> > >  # Same as newer-prereqs, but allows to exclude specified extra depen=
dencies
> > > diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> > > new file mode 100755
> > > index 000000000000..2dfb7ab289ca
> > > --- /dev/null
> > > +++ b/scripts/gen-btf.sh
> > > @@ -0,0 +1,167 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> > > +#
> > > +# This script generates BTF data for the provided ELF file.
> > > +#
> > > +# Kernel BTF generation involves these conceptual steps:
> > > +#   1. pahole generates BTF from DWARF data
> > > +#   2. resolve_btfids applies kernel-specific btf2btf
> > > +#      transformations and computes data for .BTF_ids section
> > > +#   3. the result gets linked/objcopied into the target binary
> > > +#
> > > +# How step (3) should be done differs between vmlinux, and
> > > +# kernel modules, which is the primary reason for the existence
> > > +# of this script.
> > > +#
> > > +# For modules the script expects vmlinux passed in as --btf_base.
> > > +# Generated .BTF, .BTF.base and .BTF_ids sections become embedded
> > > +# into the input ELF file with objcopy.
> > > +#
> > > +# For vmlinux the input file remains unchanged and two files are pro=
duced:
> > > +#   - ${1}.btf.o ready for linking into vmlinux
> > > +#   - ${1}.btf_ids with .BTF_ids data blob
> > > +# This output is consumed by scripts/link-vmlinux.sh
> > > +
> > > +set -e
> > > +
> > > +usage()
> > > +{
> > > +	echo "Usage: $0 [--btf_base <file>] <target ELF file>"
> > > +	exit 1
> > > +}
> > > +
> > > +BTF_BASE=3D""
> > > +
> > > +while [ $# -gt 0 ]; do
> > > +	case "$1" in
> > > +	--btf_base)
> > > +		BTF_BASE=3D"$2"
> > > +		shift 2
> > > +		;;
> > > +	-*)
> > > +		echo "Unknown option: $1" >&2
> > > +		usage
> > > +		;;
> > > +	*)
> > > +		break
> > > +		;;
> > > +	esac
> > > +done
> > > +
> > > +if [ $# -ne 1 ]; then
> > > +	usage
> > > +fi
> > > +
> > > +ELF_FILE=3D"$1"
> > > +shift
> > > +
> > > +is_enabled() {
> > > +	grep -q "^$1=3Dy" ${objtree}/include/config/auto.conf
> > > +}
> > > +
> > > +info()
> > > +{
> > > +	printf "  %-7s %s\n" "${1}" "${2}"
> > > +}
> > > +
> > > +case "${KBUILD_VERBOSE}" in
> > > +*1*)
> > > +	set -x
> > > +	;;
> > > +esac
> > > +
> > > +if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
> > > +	exit 0
> > > +fi
> > > +
> > > +gen_btf_data()
> > > +{
> > > +	info BTF "${ELF_FILE}"
> > > +	btf1=3D"${ELF_FILE}.btf.1"
> > > +	${PAHOLE} -J ${PAHOLE_FLAGS}			\
> > > +		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
> > > +		--btf_encode_detached=3D${btf1}		\
> > > +		"${ELF_FILE}"
> > > +
> > > +	info BTFIDS "${ELF_FILE}"
> > > +	RESOLVE_BTFIDS_OPTS=3D""
> > > +	if is_enabled CONFIG_WERROR; then
> > > +		RESOLVE_BTFIDS_OPTS+=3D" --fatal_warnings "
> > > +	fi
> > > +	if [ -n "${KBUILD_VERBOSE}" ]; then
> > > +		RESOLVE_BTFIDS_OPTS+=3D" -v "
> > > +	fi
> > > +	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_OPTS}	\
> > > +		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
> > > +		--btf ${btf1} "${ELF_FILE}"
> > > +}
> > > +
> > > +gen_btf_o()
> > > +{
> > > +	local btf_data=3D${ELF_FILE}.btf.o
> > > +
> > > +	# Create ${btf_data} which contains just .BTF section but no symbol=
s. Add
> > > +	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip=
-all
> > > +	# deletes all symbols including __start_BTF and __stop_BTF, which w=
ill
> > > +	# be redefined in the linker script.
> > > +	info OBJCOPY "${btf_data}"
> > > +	echo "" | ${CC} -c -x c -o ${btf_data} -
> > > +	${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf \
> > > +		--set-section-flags .BTF=3Dalloc,readonly ${btf_data}
> > > +	${OBJCOPY} --only-section=3D.BTF --strip-all ${btf_data}
> > > +
> > > +	# Change e_type to ET_REL so that it can be used to link final vmli=
nux.
> > > +	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> > > +	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> > > +		et_rel=3D'\0\1'
> > > +	else
> > > +		et_rel=3D'\1\0'
> > > +	fi
> > > +	printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 se=
ek=3D16 status=3Dnone
> > > +}
> > > +
> > > +embed_btf_data()
> > > +{
> > > +	info OBJCOPY "${ELF_FILE}"
> > > +	${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf ${ELF_FILE}
> > > +
> > > +	# a module might not have a .BTF_ids or .BTF.base section
> > > +	local btf_base=3D"${ELF_FILE}.distilled_base.btf"
> > > +	if [ -f "${btf_base}" ]; then
> > > +		${OBJCOPY} --add-section .BTF.base=3D${btf_base} ${ELF_FILE}
> > > +	fi
> > > +	local btf_ids=3D"${ELF_FILE}.btf_ids"
> > > +	if [ -f "${btf_ids}" ]; then
> > > +		${OBJCOPY} --update-section .BTF_ids=3D${btf_ids} ${ELF_FILE}
> > > +	fi
> > > +}
> > > +
> > > +cleanup()
> > > +{
> > > +	rm -f "${ELF_FILE}.btf.1"
> > > +	rm -f "${ELF_FILE}.btf"
> > > +	if [ "${BTFGEN_MODE}" =3D "module" ]; then
> > > +		rm -f "${ELF_FILE}.distilled_base.btf"
> > > +		rm -f "${ELF_FILE}.btf_ids"
> > > +	fi
> > > +}
> > > +trap cleanup EXIT
> > > +
> > > +BTFGEN_MODE=3D"vmlinux"
> > > +if [ -n "${BTF_BASE}" ]; then
> > > +	BTFGEN_MODE=3D"module"
> > > +fi
> > > +
> > > +gen_btf_data
> > > +
> > > +case "${BTFGEN_MODE}" in
> > > +vmlinux)
> > > +	gen_btf_o
> > > +	;;
> > > +module)
> > > +	embed_btf_data
> > > +	;;
> > > +esac
> > > +
> > > +exit 0
> > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > index 433849ff7529..5bea8795f96d 100755
> > > --- a/scripts/link-vmlinux.sh
> > > +++ b/scripts/link-vmlinux.sh
> > > @@ -105,34 +105,6 @@ vmlinux_link()
> > >  		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
> > >  }
> > > =20
> > > -# generate .BTF typeinfo from DWARF debuginfo
> > > -# ${1} - vmlinux image
> > > -gen_btf()
> > > -{
> > > -	local btf_data=3D${1}.btf.o
> > > -
> > > -	info BTF "${btf_data}"
> > > -	LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> > > -
> > > -	# Create ${btf_data} which contains just .BTF section but no symbol=
s. Add
> > > -	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip=
-all
> > > -	# deletes all symbols including __start_BTF and __stop_BTF, which w=
ill
> > > -	# be redefined in the linker script. Add 2>/dev/null to suppress GN=
U
> > > -	# objcopy warnings: "empty loadable segment detected at ..."
> > > -	${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,r=
eadonly \
> > > -		--strip-all ${1} "${btf_data}" 2>/dev/null
> > > -	# Change e_type to ET_REL so that it can be used to link final vmli=
nux.
> > > -	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> > > -	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> > > -		et_rel=3D'\0\1'
> > > -	else
> > > -		et_rel=3D'\1\0'
> > > -	fi
> > > -	printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 se=
ek=3D16 status=3Dnone
> > > -
> > > -	btf_vmlinux_bin_o=3D${btf_data}
> > > -}
> > > -
> > >  # Create ${2}.o file with all symbols from the ${1} object file
> > >  kallsyms()
> > >  {
> > > @@ -204,6 +176,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX;=
 then
> > >  fi
> > > =20
> > >  btf_vmlinux_bin_o=3D
> > > +btfids_vmlinux=3D
> > >  kallsymso=3D
> > >  strip_debug=3D
> > >  generate_map=3D
> > > @@ -224,11 +197,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CON=
FIG_DEBUG_INFO_BTF; then
> > >  fi
> > > =20
> > >  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> > > -	if ! gen_btf .tmp_vmlinux1; then
> > > +	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
> >=20
> > Nit: maybe pass output file names as parameters for get-btf.sh?
>=20
> I don't see a point in that. The script and callsite will become
> more complicated, but what is the benefit?

In order to avoid implicit naming conventions.  Hence, the reader of
the script code has clear understanding about in and out parameters.

> >=20
> > >  		echo >&2 "Failed to generate BTF for vmlinux"
> > >  		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
> > >  		exit 1
> > >  	fi
> > > +	btf_vmlinux_bin_o=3D.tmp_vmlinux1.btf.o
> > > +	btfids_vmlinux=3D.tmp_vmlinux1.btf_ids
> > >  fi
> > > =20
> > >  if is_enabled CONFIG_KALLSYMS; then
> > > @@ -281,14 +256,9 @@ fi
> > > =20
> > >  vmlinux_link "${VMLINUX}"
> > > =20
> > > -# fill in BTF IDs
> > >  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> > > -	info BTFIDS "${VMLINUX}"
> > > -	RESOLVE_BTFIDS_ARGS=3D""
> > > -	if is_enabled CONFIG_WERROR; then
> > > -		RESOLVE_BTFIDS_ARGS=3D" --fatal_warnings "
> > > -	fi
> > > -	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
> > > +	info OBJCOPY ${btfids_vmlinux}
> > > +	${OBJCOPY} --update-section .BTF_ids=3D${btfids_vmlinux} ${VMLINUX}
> > >  fi
> >=20
> > Nit: Maybe do this in get-btf.sh as for modules?
> >      To avoid checking for CONFIG_DEBUG_INFO_BTF in two places.
>=20
> IIRC we can't do that, because we have to update .BTF_ids after all
> the linking steps. I'll double check.
>=20
> >=20
> > > =20
> > >  mksysmap "${VMLINUX}" System.map
> > > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfi=
ds/main.c
> > > index c60d303ca6ed..b8df6256e29e 100644
> > > --- a/tools/bpf/resolve_btfids/main.c
> > > +++ b/tools/bpf/resolve_btfids/main.c
> > > @@ -71,9 +71,11 @@
> > >  #include <fcntl.h>
> > >  #include <errno.h>
> > >  #include <linux/btf_ids.h>
> > > +#include <linux/kallsyms.h>
> > >  #include <linux/rbtree.h>
> > >  #include <linux/zalloc.h>
> > >  #include <linux/err.h>
> > > +#include <linux/limits.h>
> > >  #include <bpf/btf.h>
> > >  #include <bpf/libbpf.h>
> > >  #include <subcmd/parse-options.h>
> > > @@ -124,6 +126,7 @@ struct object {
> > > =20
> > >  	struct btf *btf;
> > >  	struct btf *base_btf;
> > > +	bool distilled_base;
> > > =20
> > >  	struct {
> > >  		int		 fd;
> > > @@ -308,42 +311,16 @@ static struct btf_id *add_symbol(struct rb_root=
 *root, char *name, size_t size)
> > >  	return btf_id;
> > >  }
> > > =20
> > > -/* Older libelf.h and glibc elf.h might not yet define the ELF compr=
ession types. */
> > > -#ifndef SHF_COMPRESSED
> > > -#define SHF_COMPRESSED (1 << 11) /* Section with compressed data. */
> > > -#endif
> > > -
> > > -/*
> > > - * The data of compressed section should be aligned to 4
> > > - * (for 32bit) or 8 (for 64 bit) bytes. The binutils ld
> > > - * sets sh_addralign to 1, which makes libelf fail with
> > > - * misaligned section error during the update:
> > > - *    FAILED elf_update(WRITE): invalid section alignment
> > > - *
> > > - * While waiting for ld fix, we fix the compressed sections
> > > - * sh_addralign value manualy.
> > > - */
> > > -static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr =
*sh)
> > > +static void bswap_32_data(void *data, u32 nr_bytes)
> > >  {
> > > -	int expected =3D gelf_getclass(elf) =3D=3D ELFCLASS32 ? 4 : 8;
> > > +	u32 cnt, i;
> > > +	u32 *ptr;
> > > =20
> > > -	if (!(sh->sh_flags & SHF_COMPRESSED))
> > > -		return 0;
> > > +	cnt =3D nr_bytes / sizeof(u32);
> > > +	ptr =3D data;
> > > =20
> > > -	if (sh->sh_addralign =3D=3D expected)
> > > -		return 0;
> > > -
> > > -	pr_debug2(" - fixing wrong alignment sh_addralign %u, expected %u\n=
",
> > > -		  sh->sh_addralign, expected);
> > > -
> > > -	sh->sh_addralign =3D expected;
> > > -
> > > -	if (gelf_update_shdr(scn, sh) =3D=3D 0) {
> > > -		pr_err("FAILED cannot update section header: %s\n",
> > > -			elf_errmsg(-1));
> > > -		return -1;
> > > -	}
> > > -	return 0;
> > > +	for (i =3D 0; i < cnt; i++)
> > > +		ptr[i] =3D bswap_32(ptr[i]);
> > >  }
> > > =20
> > >  static int elf_collect(struct object *obj)
> > > @@ -364,7 +341,7 @@ static int elf_collect(struct object *obj)
> > > =20
> > >  	elf_version(EV_CURRENT);
> > > =20
> > > -	elf =3D elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> > > +	elf =3D elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL);
> > >  	if (!elf) {
> > >  		close(fd);
> > >  		pr_err("FAILED cannot create ELF descriptor: %s\n",
> > > @@ -427,21 +404,20 @@ static int elf_collect(struct object *obj)
> > >  			obj->efile.symbols_shndx =3D idx;
> > >  			obj->efile.strtabidx     =3D sh.sh_link;
> > >  		} else if (!strcmp(name, BTF_IDS_SECTION)) {
> > > +			/*
> > > +			 * If target endianness differs from host, we need to bswap32
> > > +			 * the .BTF_ids section data on load, because .BTF_ids has
> > > +			 * Elf_Type =3D ELF_T_BYTE, and so libelf returns data buffer in
> > > +			 * the target endiannes. We repeat this on dump.
> > > +			 */
> > > +			if (obj->efile.encoding !=3D ELFDATANATIVE) {
> > > +				pr_debug("bswap_32 .BTF_ids data from target to host endianness\=
n");
> > > +				bswap_32_data(data->d_buf, data->d_size);
> > > +			}
> > >  			obj->efile.idlist       =3D data;
> > >  			obj->efile.idlist_shndx =3D idx;
> > >  			obj->efile.idlist_addr  =3D sh.sh_addr;
> > > -		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
> > > -			/* If a .BTF.base section is found, do not resolve
> > > -			 * BTF ids relative to vmlinux; resolve relative
> > > -			 * to the .BTF.base section instead.  btf__parse_split()
> > > -			 * will take care of this once the base BTF it is
> > > -			 * passed is NULL.
> > > -			 */
> > > -			obj->base_btf_path =3D NULL;
> > >  		}
> > > -
> > > -		if (compressed_section_fix(elf, scn, &sh))
> > > -			return -1;
> > >  	}
> > > =20
> > >  	return 0;
> > > @@ -545,6 +521,13 @@ static int symbols_collect(struct object *obj)
> > >  	return 0;
> > >  }
> > > =20
> > > +static inline bool is_envvar_set(const char *var_name)
> > > +{
> > > +	const char *value =3D getenv(var_name);
> > > +
> > > +	return value && value[0] !=3D '\0';
> > > +}
> > > +
> > >  static int load_btf(struct object *obj)
> > >  {
> > >  	struct btf *base_btf =3D NULL, *btf =3D NULL;
> > > @@ -571,6 +554,20 @@ static int load_btf(struct object *obj)
> > >  	obj->base_btf =3D base_btf;
> > >  	obj->btf =3D btf;
> > > =20
> > > +	if (obj->base_btf && is_envvar_set("KBUILD_EXTMOD")) {
> >=20
> > This is a bit ugly, maybe use a dedicated parameter instead of
> > checking environment variable?
>=20
> Disagree. I intentionally tried to avoid adding options to
> resolve_btfids, because it's not intendend for general CLI usage (as
> opposed to pahole, for example). IMO the interface should be as simple
> as possible.
>=20
> If we add an option, we still have to check for the env variable
> somewhere, and then pass the argument through. Why? Just checking an
> env var when it matters is simpler.
>=20
> I don't think we want or expect resolve_btfids to run outside of the
> kernel or selftests build.

This comes to personal opinion, of-course.
So, in my personal opinion, obfuscating a command line tool interface
with it being parameterized by both environment variables and command
line parameters is rarely justified.  In this particular case it will
only make life a tad harder for someone debugging resolve_btfids by
copy-pasting command from make output.

Hence, I find this piece of code ugly.

[...]

