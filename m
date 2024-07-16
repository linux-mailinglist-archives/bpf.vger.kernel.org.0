Return-Path: <bpf+bounces-34900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418C9321E9
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CCEB20AB1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D811953A3;
	Tue, 16 Jul 2024 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poX45BcN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C317C200;
	Tue, 16 Jul 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721118849; cv=none; b=rR7Br58WHvOmwQ+3dfibvWLXe3urJmCdLOJ5Hz08elfuhsIQxNpqi6PMXZNGSDtiwJ96CgYk3cjZqm2XzfjKWgUn8M7PxMnVwtL0OoInLRrHzwP+b1IdiRi2CimJjYsrhyRIuay0nDOFO/U57xk7tOhzUjM5GS+GmgIUTMKb8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721118849; c=relaxed/simple;
	bh=eN5SJXM/h5WzuVg+O4VaQqJXzMPxq2eMEmP7BAucE9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeyfR5HdCEtxDdRaEqOZVdnEirVTbzPjyXLz71WKj8ALqeIF4eZfbr3LZKr87PwmRKnOIwQVbrbou1i6imomLXyE4N2r83lzM9y2Ah6T/74bnfUDf4ogrBmm4sopofuOt/7vh6Nx453G+RpI5nlOs5Z0HjA6X4mQPmieaDLxLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poX45BcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9173C4AF12;
	Tue, 16 Jul 2024 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721118849;
	bh=eN5SJXM/h5WzuVg+O4VaQqJXzMPxq2eMEmP7BAucE9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=poX45BcN6huIBRUiugOnTWdsPI0VMSTvmUP1i0VWy6/z8ze/gY8ZHbRd9gj8PplhA
	 GpAMerjWZWZtqJKS9xkaAFSMkvnbbBXiRjs9BWjsL/8qUMo51me/Q2awjKb+sUhXOj
	 ANrBIbApsjv0k4rKmqQUCcQvurGMq8qKBr0+IBdaqIW8dchzCx11RZ+M4R1wouGcFX
	 xnx433W66z8b/4zs3Z9pLXzljkyAXT1C6UT9gSLaVmZeWXjQQ5rOfu38v3SWxqYF8Y
	 7rElvStqXnvnLrQFFR6MyM4SQrIClzhjE7QDEF6lBxnHTrs7q+R2dwZiGz7wBO2tIS
	 xbD5k2uBMSXkg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso6099000e87.0;
        Tue, 16 Jul 2024 01:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxz1z+sW0y3z4zhXuzRj1zd6MgdYupd8TrbOxBi8PKqC/+eUTpxWJsHOEJ8EiTF3/ZZl/fFou9Onw1S+2/JtsMCM6nbMe50rtpX2PpBw/gT+TAPnDNfVUqF6t1i57J5P11TxIzAoMRHjE4QOakTVY28hZpnG3/EV5tWAHFTdbznHH3fCj/jORFZmjUvMg5NABgyAmkyxUa9n4Gy8N0kwGTQFgGQjtUBpKYc5nt0Of74vuMJHrlegJ+w7shYIV5t+H+oA==
X-Gm-Message-State: AOJu0Yxace8GA0tQT0OypPQzaLNl4NH+/N9Gkca6EbYzNZm0ih6V9Hro
	W8xiftavWNQS/Q4gzBJvkq6XhGs8yGnCoDO5XWwC7oThK5CJmGO6P4cP7AY2Yk5o11NAloNMJ2U
	oCj+mnT4KKylbsAX5I9MibgM/qQM=
X-Google-Smtp-Source: AGHT+IEJMEziyjXCZ+o/Kwe/ryELKeCMHEDmr/h4lYHCXz5h03acFXPEX243JN7E+7jHFSE236uANaCB17OJ3QX7F4c=
X-Received: by 2002:a05:6512:15a5:b0:52c:8275:6292 with SMTP id
 2adb3069b0e04-52edf8dcef2mr378100e87.34.1721118847333; Tue, 16 Jul 2024
 01:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613133711.2867745-1-zhengyejian1@huawei.com> <20240613133711.2867745-3-zhengyejian1@huawei.com>
In-Reply-To: <20240613133711.2867745-3-zhengyejian1@huawei.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jul 2024 17:33:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaLc6aDK85qQtPHoCkQSGyL-TxXjpgJTfehe2Q1=jMSA@mail.gmail.com>
Message-ID: <CAK7LNAQaLc6aDK85qQtPHoCkQSGyL-TxXjpgJTfehe2Q1=jMSA@mail.gmail.com>
Subject: Re: [PATCH 2/6] kallsyms: Emit symbol at the holes in the text
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mcgrof@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nicolas@fjasle.eu, kees@kernel.org, james.clark@arm.com, 
	kent.overstreet@linux.dev, yhs@fb.com, jpoimboe@kernel.org, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:36=E2=80=AFPM Zheng Yejian <zhengyejian1@huawei.=
com> wrote:
>
> When a weak type function is overridden, its symbol will be removed
> from the symbol table, but its code will not be removed. Besides,
> due to lacking of size for kallsyms, kernel compute function size by
> substracting its symbol address from its next symbol address (see
> kallsyms_lookup_size_offset()). These will cause that size of some
> function is computed to be larger than it actually is, just because
> symbol of its following weak function is removed.
>
> This issue also causes multiple __fentry__ locations to be counted in
> the some function scope, and eventually causes ftrace_location() to find
> wrong __fentry__ location. It was reported in
> Link: https://lore.kernel.org/all/20240607115211.734845-1-zhengyejian1@hu=
awei.com/
>
> Peter suggested to change scipts/kallsyms.c to emit readily
> identifiable symbol names for all the weak junk, eg:
>
>   __weak_junk_NNNNN
>
> The name of this kind symbol needs some discussion, but it's temporarily
> called "__hole_symbol_XXXXX" in this patch:
> 1. Pass size info to scripts/kallsyms  (see mksysmap());
> 2. Traverse sorted function symbols, if one function address plus its
>    size less than next function address, it means there's a hole, then
>    emit a symbol "__hole_symbol_XXXXX" there which type is 't'.
>
> After this patch, the effect is as follows:
>
>   $ cat /proc/kallsyms | grep -A 3 do_one_initcall
>   ffffffff810021e0 T do_one_initcall
>   ffffffff8100245e t __hole_symbol_XXXXX
>   ffffffff810024a0 t __pfx_rootfs_init_fs_context
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>



With my quick test, "t__hole_symbol_XXXXX" was encoded
into the following 10-byte stream.

.byte 0x09, 0x94, 0xbf, 0x18, 0xf3, 0x3d, 0xce, 0xd1, 0xd1, 0x58



Now "t__hole_symbol_XXXXX" is the most common symbol name.
However, 10 byte is consumed for every instance of
"t__hole_symbol_XXXXX".

This is much less efficient thanI had expected,
although I did not analyze the logic of this inefficiency.







> ---
>  scripts/kallsyms.c      | 101 +++++++++++++++++++++++++++++++++++++++-
>  scripts/link-vmlinux.sh |   4 +-
>  scripts/mksysmap        |   2 +-
>  3 files changed, 102 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 6559a9802f6e..5c4cde864a04 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -35,6 +35,7 @@
>  struct sym_entry {
>         struct sym_entry *next;
>         unsigned long long addr;
> +       unsigned long long size;
>         unsigned int len;
>         unsigned int seq;
>         unsigned int start_pos;
> @@ -74,6 +75,7 @@ static int token_profit[0x10000];
>  static unsigned char best_table[256][2];
>  static unsigned char best_table_len[256];
>
> +static const char hole_symbol[] =3D "__hole_symbol_XXXXX";
>
>  static void usage(void)
>  {
> @@ -130,8 +132,16 @@ static struct sym_entry *read_symbol(FILE *in, char =
**buf, size_t *buf_len)
>         size_t len;
>         ssize_t readlen;
>         struct sym_entry *sym;
> +       unsigned long long size =3D 0;
>
>         errno =3D 0;
> +       /*
> +        * Example of expected symbol format:
> +        * 1. symbol with size info:
> +        *    ffffffff81000070 00000000000001d7 T __startup_64
> +        * 2. symbol without size info:
> +        *    0000000002a00000 A text_size
> +        */
>         readlen =3D getline(buf, buf_len, in);
>         if (readlen < 0) {
>                 if (errno) {
> @@ -145,9 +155,24 @@ static struct sym_entry *read_symbol(FILE *in, char =
**buf, size_t *buf_len)
>                 (*buf)[readlen - 1] =3D 0;
>
>         addr =3D strtoull(*buf, &p, 16);
> +       if (*buf =3D=3D p || *p++ !=3D ' ') {
> +               fprintf(stderr, "line format error: unable to parse addre=
ss\n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       if (*p =3D=3D '0') {
> +               char *str =3D p;
>
> -       if (*buf =3D=3D p || *p++ !=3D ' ' || !isascii((type =3D *p++)) |=
| *p++ !=3D ' ') {
> -               fprintf(stderr, "line format error\n");
> +               size =3D strtoull(str, &p, 16);
> +               if (str =3D=3D p || *p++ !=3D ' ') {
> +                       fprintf(stderr, "line format error: unable to par=
se size\n");
> +                       exit(EXIT_FAILURE);
> +               }
> +       }
> +
> +       type =3D *p++;
> +       if (!isascii(type) || *p++ !=3D ' ') {
> +               fprintf(stderr, "line format error: unable to parse type\=
n");
>                 exit(EXIT_FAILURE);
>         }
>
> @@ -182,6 +207,7 @@ static struct sym_entry *read_symbol(FILE *in, char *=
*buf, size_t *buf_len)
>                 exit(EXIT_FAILURE);
>         }
>         sym->addr =3D addr;
> +       sym->size =3D size;
>         sym->len =3D len;
>         sym->sym[0] =3D type;
>         strcpy(sym_name(sym), name);
> @@ -795,6 +821,76 @@ static void sort_symbols(void)
>         qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
>  }
>
> +static int may_exist_hole_after_symbol(const struct sym_entry *se)


The return type should be bool.



> +{
> +       char type =3D se->sym[0];
> +
> +       /* Only check text symbol or weak symbol */
> +       if (type !=3D 't' && type !=3D 'T' &&
> +           type !=3D 'w' && type !=3D 'W')
> +               return 0;
> +       /* Symbol without size has no hole */
> +       return se->size !=3D 0;
> +}
> +
> +static struct sym_entry *gen_hole_symbol(unsigned long long addr)
> +{
> +       struct sym_entry *sym;
> +       static size_t len =3D sizeof(hole_symbol);
> +
> +       /* include type field */
> +       sym =3D malloc(sizeof(*sym) + len + 1);
> +       if (!sym) {
> +               fprintf(stderr, "unable to allocate memory for hole symbo=
l\n");
> +               exit(EXIT_FAILURE);
> +       }
> +       sym->addr =3D addr;
> +       sym->size =3D 0;
> +       sym->len =3D len;
> +       sym->sym[0] =3D 't';
> +       strcpy(sym_name(sym), hole_symbol);
> +       sym->percpu_absolute =3D 0;
> +       return sym;
> +}
> +
> +static void emit_hole_symbols(void)
> +{
> +       unsigned int i, pos, nr_emit;
> +       struct sym_entry **new_table;
> +       unsigned int new_cnt;
> +
> +       nr_emit =3D 0;
> +       for (i =3D 0; i < table_cnt - 1; i++) {
> +               if (may_exist_hole_after_symbol(table[i]) &&
> +                   table[i]->addr + table[i]->size < table[i+1]->addr)
> +                       nr_emit++;
> +       }
> +       if (!nr_emit)
> +               return;
> +
> +       new_cnt =3D table_cnt + nr_emit;
> +       new_table =3D malloc(sizeof(*new_table) * new_cnt);


Do you need to allocate another huge table?

You can use realloc() to append the room for nr_emit
if you iterate the table in the reverse order.







> +       if (!new_table) {
> +               fprintf(stderr, "unable to allocate memory for new table\=
n");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       pos =3D 0;
> +       for (i =3D 0; i < table_cnt; i++) {
> +               unsigned long long addr;
> +
> +               new_table[pos++] =3D table[i];
> +               if ((i =3D=3D table_cnt - 1) || !may_exist_hole_after_sym=
bol(table[i]))
> +                       continue;
> +               addr =3D table[i]->addr + table[i]->size;
> +               if (addr < table[i+1]->addr)
> +                       new_table[pos++] =3D gen_hole_symbol(addr);
> +       }
> +       free(table);
> +       table =3D new_table;
> +       table_cnt =3D new_cnt;
> +}
> +
>  static void make_percpus_absolute(void)
>  {
>         unsigned int i;
> @@ -854,6 +950,7 @@ int main(int argc, char **argv)
>         if (absolute_percpu)
>                 make_percpus_absolute();
>         sort_symbols();
> +       emit_hole_symbols();
>         if (base_relative)
>                 record_relative_base();
>         optimize_token_table();
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 518c70b8db50..8e1373902bfe 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -189,11 +189,11 @@ kallsyms_step()
>  }
>
>  # Create map file with all symbols from ${1}
> -# See mksymap for additional details
> +# See mksysmap for additional details
>  mksysmap()
>  {
>         info NM ${2}
> -       ${NM} -n "${1}" | sed -f "${srctree}/scripts/mksysmap" > "${2}"
> +       ${NM} -nS "${1}" | sed -f "${srctree}/scripts/mksysmap" > "${2}"
>  }
>
>  sorttable()
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index c12723a04655..7a4415f21143 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>  # sed script to filter out symbols that are not needed for System.map,
> -# or not suitable for kallsyms. The input should be 'nm -n <file>'.
> +# or not suitable for kallsyms. The input should be 'nm -nS <file>'.
>  #
>  # System.map is used by module-init tools and some debugging
>  # tools to retrieve the actual addresses of symbols in the kernel.
> --
> 2.25.1
>
>


--=20
Best Regards
Masahiro Yamada

