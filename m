Return-Path: <bpf+bounces-75841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FCC995C0
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 23:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D713A3D5C
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05D8283FE3;
	Mon,  1 Dec 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4t6DIrJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE0279DC3
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627389; cv=none; b=LHjWT/C3JiLk5hgTDWBcfXB5OYQ5gsTVPphq0b+JDsCJ5CrISBNcfAzXQTy8KYELwKx87N3Fg5HEXA40civYGBf23qpJmdZAM5WzJkrsUApaQh9+D6hLksQ379O6zYFZy39fo2o/9SmS6oZzDLmTIFmSyVBceWw9r9jzQN9A1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627389; c=relaxed/simple;
	bh=UANTJ9prjAOLmAhB2BRuWafk1FsbmYtvreo0sbNU5z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swQiZY/InF8MM14mnn2tr+5GPbkUseW6Pp+mCEBlvirjyFPSPLpSzawPLdHZw4GBKrT+v/GMmYgJRXNV3QG1l60XBORMxWAMD5hHTE39c0ZsJVMyczXwVoDauvUVPy9jaBD3bsSvOg0+e+DfYxP1PTlOF313NWPaw1eMfZzQid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4t6DIrJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295548467c7so55423035ad.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764627385; x=1765232185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmTDU1yutPapGGMqicm0y3igMZLnZ6HVLLwLttQPajU=;
        b=P4t6DIrJwo5h6e0EzUCj7jFtVSZvqPBv7k+9nar1oDE9TPPuRTpUalwSGl2ujETfTu
         6tloHPY/vwS9UXABfme5WxMfSR4toXKUTB7fimCJuPLH7PAcVUO7NgRfRNJuv2pzfWZ2
         fx6pdezz6sryn+FrD+JMQeCh2cCKnjDRhUt28aolaSU8OurFwWf4iA5YbAeiykdW8q2Q
         ZL9oi8zG+DBTp5XWnipF2LjEP0IooGNJvtwvnUMzL/36ocnwiK/cMMXm83/ekbpmRoEy
         iU0ooQWxyGTPu5tuvTQRyA2JeW4CwAWlg0iEGld9xP2YbAmr31Y2gQWAAvpqCkjiy9z1
         ye4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764627385; x=1765232185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmTDU1yutPapGGMqicm0y3igMZLnZ6HVLLwLttQPajU=;
        b=V50HEqeqgqSD0hKoBLRU2EmZ+wYsekNBh4wFWXWwO6Vqd6hZcyrIf4EYOQDoj+rtLC
         3EqK2NERrL2M0u+Rw6YKcO03TIIUau92CShvYi5IXob2G7R4I56vFLoB6zC2COga34qR
         3rTDFXku2+U0PIpMw2giMdJkJ1HOuAwacJ+vO0+F4MvSB9+u7y3FtVzeCGNAUA3AsM1l
         c4eajJDHPJ6Z+XbMfpALarwNKyzxJEBdRPz7auPh60yI0Uwy2tl15MO8pw7kDY5vawix
         alAzjaaEGVIeHBm9ioEB7LHdzLNn6sqjKAV+nbUY23juRTUMKi7ItSCGEFAxmFT11YCS
         XxQg==
X-Forwarded-Encrypted: i=1; AJvYcCXvt7NiOFpRt1qoWwpeIUV/fDVl8ikD8ncrXvjVzDsml4rHEs/h4TJkkMGIA34BEo52XXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13bPBsSk0VXctbuVTSeLUIrNEcZ0SpCO+9PlhVRk9+dy2rVaP
	ZAH2x3kzSI8dfzjbq3zAdA8FQx/RIdcYuMleu5t9KaHJq1m9wxcMMm9LXOVLunl8SBqIwZ3h176
	wB9xTJrKd2QnkPDNaXsTjXtiX59++Dbg=
X-Gm-Gg: ASbGncuFmPPmTQWYzYhZlrT5xGaTue7trqHan3euGO4mpaiwqqtA9zW/8QKzBnJK6fB
	bHqFoWmJcBh6g9kt+QeTk3XQrBMws3/6vVpkijQUkcq7s6KZUA1BUCX+eCKEb8Z5eWwc14+vDTu
	v2hf1ofiX6Ckr+ZG3jaaAWIhin8eQv27Au8dZ9/6pyfbZ750x4u3gIF1ETmaSkl5GciItCM93I8
	4Z7l3jhL1AHOOT5rLyLVs4ERgJvT1j5/JSn4ZCYzFFA0C6FzHTRBnzed9kAmYbzWgRP6f0siDal
	d48ZjW37JrQ=
X-Google-Smtp-Source: AGHT+IHJonU412I7f/JNw79vOqJqutwP0n+3EczJg91StGLd5pArOCgHU+a6Q32Xj7+OaRUxQ4P4A3BeStvEnWoZ0lM=
X-Received: by 2002:a17:903:903:b0:295:a1a5:bae9 with SMTP id
 d9443c01a7336-29b6be86b48mr380351715ad.8.1764627384453; Mon, 01 Dec 2025
 14:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev> <20251127185242.3954132-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251127185242.3954132-5-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Dec 2025 14:16:11 -0800
X-Gm-Features: AWmQ_bmWg6fCHhn0HD4vXKJ3af5X_5LGHopBhTlMCANtxVWkk5lw1M6mvAxVkCk
Message-ID: <CAEf4BzbuHChnpoAGm1EJt6tVbW7yruV14BCD0iMeJmNt1OyEiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] resolve_btfids: change in-place update
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
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 10:53=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
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
>   * ${1}.distilled_base.btf with .BTF.base section data (for
>     out-of-tree modules)
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
>   * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
>     raw BTF data
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
> With this patch an ELF file becomes effectively read-only within
> resolve_btfids, which allows to delete elf_update() call and satelite
> code (like compressed_section_fix [4]).
>
> Endianness handling of .BTF_ids data is also changed. Previously the
> "flags" part of the section was bswapped in sets_patch() [5], and then
> Elf_Type was modified before elf_update() to signal to libelf that
> bswap may be necessary. With this patch we explicitly bswap entire
> data buffer on load and on dump.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n115
> [2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c#n1835
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scri=
pts/link-vmlinux.sh#n285
> [4] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
> [5] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/
>
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
> index 542ba462ed3e..3862fdfa1267 100644
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
> +               $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlin=
ux $@; \
>         fi;
>

[...]

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

please double-check what pahole version has --btf_encode_detached, we
might need to change minimal supported pahole version because of this

pw-bot: cr


> +               "${ELF_FILE}"
> +
> +       info BTFIDS "${ELF_FILE}"
> +       RESOLVE_BTFIDS_OPTS=3D""
> +       if is_enabled CONFIG_WERROR; then
> +               RESOLVE_BTFIDS_OPTS+=3D" --fatal_warnings "
> +       fi
> +       if [ -n "${KBUILD_VERBOSE}" ]; then
> +               RESOLVE_BTFIDS_OPTS+=3D" -v "
> +       fi
> +       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_OPTS}        \
> +               ${BTF_BASE:+--btf_base ${BTF_BASE}}     \
> +               --btf ${btf1} "${ELF_FILE}"
> +}
> +

[...]

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

use fopen() and fwrite() instead of low-level syscalls? for write()
it's "expected" that it might be interrupted and not complete a full
write, so you'd need to handle that in a loop properly. With fwrite()
I think all this is handled internally, so I'd stick to fopen()'s FILE
abstraction and fwrite().

> +               pr_err("Failed to write data to %s\n", out_path);
> +               close(fd);
> +               unlink(out_path);
> +               return -1;
> +       }

[...]

> +static int dump_raw_btf(struct btf *btf, const char *out_path)
> +{
> +       const void *raw_btf_data;
> +       u32 raw_btf_size;
> +       int fd, err;
> +
> +       raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);
> +       if (raw_btf_data =3D=3D NULL) {

nit: !raw_btf_data, it's C

[...]

> @@ -844,6 +879,11 @@ int main(int argc, const char **argv)
>                 usage_with_options(resolve_btfids_usage, btfid_options);
>
>         obj.path =3D argv[0];
> +       strcpy(out_path, obj.path);
> +       path_len =3D strlen(out_path);

Eduard already suggested using snprintf() later in the code, I'd say
use snprintf() here as well instead of strcpy(). When working with
fixed-sized buffers, snprintf() is the most ergonomic way to deal with
that and not trigger unnecessary compiler warnings about possible
truncations, out of buffer writes, and stuff like that.

> +
> +       if (load_btf(&obj))
> +               goto out;
>
>         if (elf_collect(&obj))
>                 goto out;

[...]

