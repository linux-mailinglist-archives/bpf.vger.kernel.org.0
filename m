Return-Path: <bpf+bounces-75539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01844C88168
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 05:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A89C34E1DA
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 04:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F676026;
	Wed, 26 Nov 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXTARXXr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E901F9C0
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764132411; cv=none; b=k9M66UKhwCaxRe03KfHNLHa6HGRtJahyLZSI0trzFIyq4gDG9m26C+TcbWc5RdoZIDzQEN28VnC8e3vF5e3ePtj+R7UAEu7GUdYfqplzC0GJppMG9Ktg7HeZ8Xt1QMkX9dZ6wbLnZzjUQgwm5bPk5tnC9NPeRgLDg1UsGDZI0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764132411; c=relaxed/simple;
	bh=tt/Ga6UnAMSH8IhfxSndjJwg6wPQIlafxvTh2/gRQ5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkeMWvYmJPkOU8K4Bh98YoAdpXVhYGaXW98wLr5B6XPPZz9HhnJzVtAR4mN1gPNc74lJEgDMf0CTHDdLF8fJdilvDGqY6yh/R1La5qqb4Y5PPn4k3EtgvKbu8qIJoC1IaSIWBL5aPwTXRg59gpy5csDp+6yD8aoXCrohGt62Yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXTARXXr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso10601051a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 20:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764132408; x=1764737208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQYPQRqt1yK/2FvgKgQe85pBjXJI+Nah2YQasXB8Ji4=;
        b=cXTARXXr+L95it5vC6jpyV04Aunqarpw0KmJL1Mdz3YKDwrw1XecIFequ+6Jryq221
         v470BxFHL1FDnL+hSlV2S3UFi7EFkjG+8LTSbxwSEvneZAINyZDNzx+bVozFL7wgXzU8
         aKMwiadePCAbLTcCXPmQQ7QSboig86NWkq1mZlnw1pAgQMeTe4aJF8eBDPDTtF8Xj5ph
         xzD7QS8hFdvJQmERI1DXO2sxXRNlis9gWRqiYnD9vEPAbmzm60dMH3TEZVHdcnQGuKeF
         7sLuhGqz+eEstwKX9YZyDEJ6NujlEANeCRrMr4XbHEyYtMW8OjEIe3DU8uv4nHmb5+rk
         5Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764132408; x=1764737208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oQYPQRqt1yK/2FvgKgQe85pBjXJI+Nah2YQasXB8Ji4=;
        b=PJ2c8CLE/fV2uWnlM7zFnQAenzEoFZGTJMgUWJYpfJlrtSIZq87wCuxyZYtGZXYhls
         qwCc6W5T5l7KRe5rr5dUdsg9qia1hQ1HjWnUHnnO/oBt7Y9PIr9xbh6J00vmlJAk3kk1
         d5+L7AG/eFUEYsjOMNt2LNMrY26VW3tOSIvOXCKAaX+A5q1PBF4tT+uNmdjtgtCrT/xn
         WFYkvs3amBs0r9QipDYEkI+PUrF/AZjyXCVFTE01r1df+T7ryIVVWZg1DnPEwFDO4D4t
         H1OCpyzeTuFjpqUbZfEqmHkK0mkqCW4PZYAAORtyMHDOPGpkEJU5Hc2QNKriEnipYIf9
         6qmg==
X-Forwarded-Encrypted: i=1; AJvYcCVCEDHLpeqH7v8JZWYBeZsPRFVFJEGQYmMqJfBU1uICmo6JrSTzxHkN2WjLDNbKw9zuB5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGdXQqKCa/ZIIPha260/anC3WeHiH6YhN/J7fK5g7/PlyUAam
	uzIVchAxC7xOUJZeNElAoeMU5C5HmL9A8iFT1WVAcca9fBODeO+Wg8y2WuskbZ/wGKBDIbxQvZm
	1JkFoUjnqya+vDp6jO0Ft29bhTYYqFCk=
X-Gm-Gg: ASbGncvo6XP7TptU5fQ5GYHF0Ljoe2ZIdwKGGtueVoYHv+qo5zT3MuU/ZRKYgFdujnI
	Bi8NJjNOiNd4RtERPlrtjIjETkw8Cp+I9wV70cXhkI3/Q6EoGVwBo2pZuF6oqppO+mVEUTvJWTV
	LLWDx4FIVX5yUHbPtYJ8ghY/WyDsvTVI6YpSEeZrxIkmY7McScYlaCy/LjYDcMmgQtS+6Q81HA4
	KGNC/M2rqxJ3wNtEkcRbaw8p6Ga9XzLAxVVVu/Xlh2e08avjdw+4DbEccJYJ1WjzhozIzl1Yppi
	Oz2wOxM=
X-Google-Smtp-Source: AGHT+IGD5WDlneM7iQoHkTXqh5DbnTBUVX41uF6gfd1jAYC53K1qvO8hGT1ia9KuCVfCuqTLrQiZ0qvqGVjxmJc4GPg=
X-Received: by 2002:a17:907:7f8a:b0:b72:6143:60c2 with SMTP id
 a640c23a62f3a-b76718c19d4mr1955667366b.51.1764132407282; Tue, 25 Nov 2025
 20:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev> <20251126012656.3546071-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251126012656.3546071-5-ihor.solodrai@linux.dev>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 26 Nov 2025 12:46:35 +0800
X-Gm-Features: AWmQ_blIBbe18K3HEnKfmyw5sJBXad4ljn_Uex7OoQyzqHMdEirB6qJ8G6zJY88
Message-ID: <CAErzpmvaHxLdooTsHt=YKbz9NDw+LXB8462kRrkzbdp-zJ-=2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] resolve_btfids: change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 9:29=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Currently resolve_btfids updates .BTF_ids section of an ELF file
> in-place, based on the contents of provided BTF, usually within the
> same input file, and optionally a BTF base.
>
> This patch changes resolve_btfids behavior to enable BTF
> transformations as part of its main operation. To achieve this
> in-place ELF write in resolve_btfids is replaced with generation of
> the following binaries:
>   * ${1}.btf with .BTF section data
>   * ${1}.distilled_base.btf with .BTF.base section data (for modules)
>   * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}
>
> The execution of resolve_btfids and consumption of its output is
> orchestrated by scripts/gen-btf.sh introduced in this patch.
>
> The rationale for this approach is that updating ELF in-place with
> libelf API is complicated and bug-prone, especially in the context of
> the kernel build. On the other hand applying objcopy to manipulate ELF
> sections is simpler and more reliable.
>
> There are two distinct paths for BTF generation and resolve_btfids
> application in the kernel build: for vmlinux and for kernel modules.
>
> For the vmlinux binary a .BTF section is added in a roundabout way to
> ensure correct linking (details below). The patch doesn't change this
> approach, only the implementation is a little different.
>
> Before this patch it worked like follows:
>
>   * pahole consumed .tmp_vmlinux1 [1] and added .BTF section with
>     llvm-objcopy [2] to it
>   * then everything except the .BTF section was stripped from .tmp_vmlinu=
x1
>     into a .tmp_vmlinux1.bpf.o object [1], later linked into vmlinux
>   * resolve_btfids was executed later on vmlinux.unstripped [3],
>     updating it in-place
>
> After this patch gen-btf.sh implements the following:
>
>   * pahole consumes .tmp_vmlinux1 and produces a **detached** file
>     with raw BTF data
>   * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
>     (potentially modified) .BTF, and .BTF_ids sections data
>   * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
>     BTF output of resolve_btfids
>   * .BTF_ids data gets embedded into vmlinux.unstripped in
>     link-vmlinux.sh by objcopy --update-section
>
> For the kernel modules creating special .bpf.o file is not necessary,
> and so embedding of sections data produced by resolve_btfids is
> straightforward with the objcopy.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n115
> [2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c#n1835
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n285
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  MAINTAINERS                     |   1 +
>  scripts/Makefile.modfinal       |   5 +-
>  scripts/gen-btf.sh              | 166 ++++++++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh         |  42 ++------
>  tools/bpf/resolve_btfids/main.c | 124 ++++++++++++++++++------
>  5 files changed, 272 insertions(+), 66 deletions(-)
>  create mode 100755 scripts/gen-btf.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48aabeeed029..5cd34419d952 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4672,6 +4672,7 @@ F:        net/sched/act_bpf.c
>  F:     net/sched/cls_bpf.c
>  F:     samples/bpf/
>  F:     scripts/bpf_doc.py
> +F:     scripts/gen-btf.sh
>  F:     scripts/Makefile.btf
>  F:     scripts/pahole-version.sh
>  F:     tools/bpf/
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 542ba462ed3e..86f843995556 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -38,9 +38,8 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>        cmd_btf_ko =3D                                                    =
 \
>         if [ ! -f $(objtree)/vmlinux ]; then                            \
>                 printf "Skipping BTF generation for %s due to unavailabil=
ity of vmlinux\n" $@ 1>&2; \
> -       else                                                            \
> -               LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) =
$(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> -               $(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;             \
> +       else    \
> +               $(objtree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlin=
ux $@; \
>         fi;
>
>  # Same as newer-prereqs, but allows to exclude specified extra dependenc=
ies
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> new file mode 100755
> index 000000000000..102f8296ae9e
> --- /dev/null
> +++ b/scripts/gen-btf.sh
> @@ -0,0 +1,166 @@
> +#!/bin/sh
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
> +       echo "Usage: $0 [--btf_base <file>] <target ELF file>"
> +       exit 1
> +}
> +
> +BTF_BASE=3D""
> +
> +while [ $# -gt 0 ]; do
> +       case "$1" in
> +       --btf_base)
> +               BTF_BASE=3D"$2"
> +               shift 2
> +               ;;
> +       -*)
> +               echo "Unknown option: $1" >&2
> +               usage
> +               ;;
> +       *)
> +               break
> +               ;;
> +       esac
> +done
> +
> +if [ $# -ne 1 ]; then
> +       usage
> +fi
> +
> +ELF_FILE=3D"$1"
> +shift
> +
> +is_enabled() {
> +       grep -q "^$1=3Dy" ${objtree}/include/config/auto.conf
> +}
> +
> +info()
> +{
> +       printf "  %-7s %s\n" "${1}" "${2}"
> +}
> +
> +case "${KBUILD_VERBOSE}" in
> +*1*)
> +       set -x
> +       ;;
> +esac
> +
> +if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
> +       exit 0
> +fi
> +
> +gen_btf_data()
> +{
> +       info BTF "${ELF_FILE}"
> +       btf1=3D"${ELF_FILE}.btf.1"
> +       ${PAHOLE} -J ${PAHOLE_FLAGS}                    \
> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
> +               --btf_encode_detached=3D${btf1}           \
> +               "${ELF_FILE}"
> +
> +       info BTFIDS "${ELF_FILE}"
> +       RESOLVE_BTFIDS_OPTS=3D""
> +       if is_enabled CONFIG_WERROR; then
> +               RESOLVE_BTFIDS_OPTS+=3D" --fatal_warnings "

In POSIX sh, +=3Dis undefined[1], and I encountered the following error:

./scripts/gen-btf.sh: 90: RESOLVE_BTFIDS_OPTS+=3D --fatal_warnings : not fo=
und

We should use the following syntax instead:

RESOLVE_BTFIDS_OPTS=3D"${RESOLVE_BTFIDS_OPTS} --fatal_warnings "

[1] https://www.shellcheck.net/wiki/SC3024

Thanks,
Donglin
> +       fi
> +       if [ -n "${KBUILD_VERBOSE}" ]; then
> +               RESOLVE_BTFIDS_OPTS+=3D" -v "

Ditto

Thanks,
Donglin
> +       fi
> +       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_OPTS}        \
> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
> +               --btf ${btf1} "${ELF_FILE}"
> +}
> +
> +gen_btf_o()
> +{
> +       local btf_data=3D${ELF_FILE}.btf.o
> +
> +       # Create ${btf_data} which contains just .BTF section but no symb=
ols. Add
> +       # SHF_ALLOC because .BTF will be part of the vmlinux image. --str=
ip-all
> +       # deletes all symbols including __start_BTF and __stop_BTF, which=
 will
> +       # be redefined in the linker script.
> +       info OBJCOPY "${btf_data}"
> +       echo "" | ${CC} -c -x c -o ${btf_data} -
> +       ${OBJCOPY} --add-section .BTF=3D${ELF_FILE}.btf \
> +               --set-section-flags .BTF=3Dalloc,readonly ${btf_data}
> +       ${OBJCOPY} --only-section=3D.BTF --strip-all ${btf_data}
> +
> +       # Change e_type to ET_REL so that it can be used to link final vm=
linux.
> +       # GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> +       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +               et_rel=3D'\0\1'
> +       else
> +               et_rel=3D'\1\0'
> +       fi
> +       printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 =
seek=3D16 status=3Dnone
> +}
> +
> +embed_btf_data()
> +{
> +       info OBJCOPY "${ELF_FILE}"
> +
> +       ${OBJCOPY} \
> +               --add-section .BTF=3D${ELF_FILE}.btf                     =
 \
> +               --add-section .BTF.base=3D${ELF_FILE}.distilled_base.btf =
 \
> +               ${ELF_FILE}
> +
> +       # a module might not have a .BTF_ids section
> +       if [ -f "${ELF_FILE}.btf_ids" ]; then
> +               ${OBJCOPY} --update-section .BTF_ids=3D${ELF_FILE}.btf_id=
s ${ELF_FILE}
> +       fi
> +}
> +
> +cleanup()
> +{
> +       rm -f "${ELF_FILE}.btf.1"
> +       rm -f "${ELF_FILE}.btf"
> +       if [ "${BTFGEN_MODE}" =3D=3D "module" ]; then

In POSIX sh, =3D=3D in place of =3D is undefined[2], and I encountered the =
following
error:

./scripts/gen-btf.sh: 143: [: module: unexpected operator

we should use =3D instead.

[2] https://www.shellcheck.net/wiki/SC3014

Thanks,
Donglin
> +               rm -f "${ELF_FILE}.distilled_base.btf"
> +               rm -f "${ELF_FILE}.btf_ids"
> +       fi
> +}
> +trap cleanup EXIT
> +
> +BTFGEN_MODE=3D"vmlinux"
> +if [ -n "${BTF_BASE}" ]; then
> +       BTFGEN_MODE=3D"module"
> +fi
> +
> +gen_btf_data
> +
> +case "${BTFGEN_MODE}" in
> +vmlinux)
> +       gen_btf_o
> +       ;;
> +module)
> +       embed_btf_data
> +       ;;
> +esac
> +
> +exit 0
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 433849ff7529..728f82af24f6 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -105,34 +105,6 @@ vmlinux_link()
>                 ${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldl=
ibs}
>  }
>
> -# generate .BTF typeinfo from DWARF debuginfo
> -# ${1} - vmlinux image
> -gen_btf()
> -{
> -       local btf_data=3D${1}.btf.o
> -
> -       info BTF "${btf_data}"
> -       LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> -
> -       # Create ${btf_data} which contains just .BTF section but no symb=
ols. Add
> -       # SHF_ALLOC because .BTF will be part of the vmlinux image. --str=
ip-all
> -       # deletes all symbols including __start_BTF and __stop_BTF, which=
 will
> -       # be redefined in the linker script. Add 2>/dev/null to suppress =
GNU
> -       # objcopy warnings: "empty loadable segment detected at ..."
> -       ${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc=
,readonly \
> -               --strip-all ${1} "${btf_data}" 2>/dev/null
> -       # Change e_type to ET_REL so that it can be used to link final vm=
linux.
> -       # GNU ld 2.35+ and lld do not allow an ET_EXEC input.
> -       if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> -               et_rel=3D'\0\1'
> -       else
> -               et_rel=3D'\1\0'
> -       fi
> -       printf "${et_rel}" | dd of=3D"${btf_data}" conv=3Dnotrunc bs=3D1 =
seek=3D16 status=3Dnone
> -
> -       btf_vmlinux_bin_o=3D${btf_data}
> -}
> -
>  # Create ${2}.o file with all symbols from the ${1} object file
>  kallsyms()
>  {
> @@ -204,6 +176,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; the=
n
>  fi
>
>  btf_vmlinux_bin_o=3D
> +btfids_vmlinux=3D
>  kallsymso=3D
>  strip_debug=3D
>  generate_map=3D
> @@ -224,11 +197,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_=
DEBUG_INFO_BTF; then
>  fi
>
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> -       if ! gen_btf .tmp_vmlinux1; then
> +       if ! scripts/gen-btf.sh .tmp_vmlinux1; then
>                 echo >&2 "Failed to generate BTF for vmlinux"
>                 echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
>                 exit 1
>         fi
> +       btf_vmlinux_bin_o=3D.tmp_vmlinux1.btf.o
> +       btfids_vmlinux=3D.tmp_vmlinux1.btf_ids
>  fi
>
>  if is_enabled CONFIG_KALLSYMS; then
> @@ -281,14 +256,9 @@ fi
>
>  vmlinux_link "${VMLINUX}"
>
> -# fill in BTF IDs
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> -       info BTFIDS "${VMLINUX}"
> -       RESOLVE_BTFIDS_ARGS=3D""
> -       if is_enabled CONFIG_WERROR; then
> -               RESOLVE_BTFIDS_ARGS=3D" --fatal_warnings "
> -       fi
> -       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
> +       info OBJCOPY ${btfids_vmlinux}
> +       ${OBJCOPY} --update-section .BTF_ids=3D${btfids_vmlinux} ${VMLINU=
X}
>  fi
>
>  mksysmap "${VMLINUX}" System.map
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 7f5a9f7dde7f..4faf16b1ba6b 100644
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
> @@ -429,14 +431,6 @@ static int elf_collect(struct object *obj)
>                         obj->efile.idlist       =3D data;
>                         obj->efile.idlist_shndx =3D idx;
>                         obj->efile.idlist_addr  =3D sh.sh_addr;
> -               } else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
> -                       /* If a .BTF.base section is found, do not resolv=
e
> -                        * BTF ids relative to vmlinux; resolve relative
> -                        * to the .BTF.base section instead.  btf__parse_=
split()
> -                        * will take care of this once the base BTF it is
> -                        * passed is NULL.
> -                        */
> -                       obj->base_btf_path =3D NULL;
>                 }
>
>                 if (compressed_section_fix(elf, scn, &sh))
> @@ -570,6 +564,19 @@ static int load_btf(struct object *obj)
>         obj->base_btf =3D base_btf;
>         obj->btf =3D btf;
>
> +       if (obj->base_btf) {
> +               err =3D btf__distill_base(obj->btf, &base_btf, &btf);
> +               if (err) {
> +                       pr_err("FAILED to distill base BTF: %s\n", strerr=
or(errno));
> +                       goto out_err;
> +               }
> +
> +               btf__free(obj->btf);
> +               btf__free(obj->base_btf);
> +               obj->btf =3D btf;
> +               obj->base_btf =3D base_btf;
> +       }
> +
>         return 0;
>
>  out_err:
> @@ -777,8 +784,6 @@ static int sets_patch(struct object *obj)
>
>  static int symbols_patch(struct object *obj)
>  {
> -       off_t err;
> -
>         if (__symbols_patch(obj, &obj->structs)  ||
>             __symbols_patch(obj, &obj->unions)   ||
>             __symbols_patch(obj, &obj->typedefs) ||
> @@ -789,20 +794,67 @@ static int symbols_patch(struct object *obj)
>         if (sets_patch(obj))
>                 return -1;
>
> -       /* Set type to ensure endian translation occurs. */
> -       obj->efile.idlist->d_type =3D ELF_T_WORD;
> +       return 0;
> +}
>
> -       elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
> +static int dump_raw_data(const char *out_path, const void *data, u32 siz=
e)
> +{
> +       int fd, ret;
>
> -       err =3D elf_update(obj->efile.elf, ELF_C_WRITE);
> -       if (err < 0) {
> -               pr_err("FAILED elf_update(WRITE): %s\n",
> -                       elf_errmsg(-1));
> +       fd =3D open(out_path, O_WRONLY | O_CREAT | O_TRUNC, 0640);
> +       if (fd < 0) {
> +               pr_err("Couldn't open %s for writing\n", out_path);
> +               return fd;
> +       }
> +
> +       ret =3D write(fd, data, size);
> +       if (ret < 0 || ret !=3D size) {
> +               pr_err("Failed to write data to %s\n", out_path);
> +               close(fd);
> +               unlink(out_path);
> +               return -1;
> +       }
> +
> +       close(fd);
> +       pr_debug("Dumped %lu bytes of data to %s\n", size, out_path);
> +
> +       return 0;
> +}
> +
> +static int dump_raw_btf_ids(struct object *obj, const char *out_path)
> +{
> +       Elf_Data *data =3D obj->efile.idlist;
> +       int fd, err;
> +
> +       if (!data || !data->d_buf) {
> +               pr_debug("%s has no BTF_ids data to dump\n", obj->path);
> +               return 0;
> +       }
> +
> +       err =3D dump_raw_data(out_path, data->d_buf, data->d_size);
> +       if (err)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int dump_raw_btf(struct btf *btf, const char *out_path)
> +{
> +       const void *raw_btf_data;
> +       u32 raw_btf_size;
> +       int fd, err;
> +
> +       raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
> +       if (raw_btf_data =3D=3D NULL) {
> +               pr_err("btf__raw_data() failed\n");
> +               return -1;
>         }
>
> -       pr_debug("update %s for %s\n",
> -                err >=3D 0 ? "ok" : "failed", obj->path);
> -       return err < 0 ? -1 : 0;
> +       err =3D dump_raw_data(out_path, raw_btf_data, raw_btf_size);
> +       if (err)
> +               return -1;
> +
> +       return 0;
>  }
>
>  static const char * const resolve_btfids_usage[] =3D {
> @@ -823,12 +875,13 @@ int main(int argc, const char **argv)
>                 .funcs    =3D RB_ROOT,
>                 .sets     =3D RB_ROOT,
>         };
> +       char out_path[PATH_MAX];
>         bool fatal_warnings =3D false;
>         struct option btfid_options[] =3D {
>                 OPT_INCR('v', "verbose", &verbose,
>                          "be more verbose (show errors, etc)"),
>                 OPT_STRING(0, "btf", &obj.btf_path, "BTF data",
> -                          "BTF data"),
> +                          "input BTF data"),
>                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
>                            "path of file providing base BTF"),
>                 OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
> @@ -844,6 +897,9 @@ int main(int argc, const char **argv)
>
>         obj.path =3D argv[0];
>
> +       if (load_btf(&obj))
> +               goto out;

I think I can add the BTF sorting function here based on your patch.

Thanks,
Donglin
> +
>         if (elf_collect(&obj))
>                 goto out;
>
> @@ -853,23 +909,37 @@ int main(int argc, const char **argv)
>          */
>         if (obj.efile.idlist_shndx =3D=3D -1 ||
>             obj.efile.symbols_shndx =3D=3D -1) {
> -               pr_debug("Cannot find .BTF_ids or symbols sections, nothi=
ng to do\n");
> -               err =3D 0;
> -               goto out;
> +               pr_debug("Cannot find .BTF_ids or symbols sections, skip =
symbols resolution\n");
> +               goto dump_btf;
>         }
>
>         if (symbols_collect(&obj))
>                 goto out;
>
> -       if (load_btf(&obj))
> -               goto out;
> -
>         if (symbols_resolve(&obj))
>                 goto out;
>
>         if (symbols_patch(&obj))
>                 goto out;
>
> +       strcpy(out_path, obj.path);
> +       strcat(out_path, ".btf_ids");
> +       if (dump_raw_btf_ids(&obj, out_path))
> +               goto out;
> +
> +dump_btf:
> +       strcpy(out_path, obj.path);
> +       strcat(out_path, ".btf");

Do we need to add .btf files to the .gitignore file?

Thanks,
Donglin

> +       if (dump_raw_btf(obj.btf, out_path))
> +               goto out;
> +
> +       if (obj.base_btf) {
> +               strcpy(out_path, obj.path);
> +               strcat(out_path, ".distilled_base.btf");
> +               if (dump_raw_btf(obj.base_btf, out_path))
> +                       goto out;
> +       }
> +
>         if (!(fatal_warnings && warnings))
>                 err =3D 0;
>  out:
> --
> 2.52.0
>

