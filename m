Return-Path: <bpf+bounces-35172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF509938195
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD0C1C211CB
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740713213D;
	Sat, 20 Jul 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDCGrYkF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889B1803D;
	Sat, 20 Jul 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721484932; cv=none; b=MtQD4Ydi5j6eqE+cFnmZXVIhPvWhtz9QVoZFiTYtBjnu+FBgCPzndwrkPu0Fge34PAK30RRSho8wIfNr6TvdLqxyx1ii99iw43SrVJ0ZqEwj3m/hUoVJPRUbA3XQmJd6NCg1Fz5y0ZwXeyKds3JMG2osjjXI2WHH7H/HAsz22ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721484932; c=relaxed/simple;
	bh=siC36GPXr2aNokMak0PbQR2qdcyg1ve7YXRSuhNJEbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8Oe46zKeR+NJbdPeYu8tDYnTBPUgHCWCddy0/dYljAJ08ipwqRcGI0szj8RftLK+QJEtDLnKTKc+4F0YKkqey3NUVab5k/W8hnrYVnnYWzu8fq1JG4/RTBOrCANeYXu4uFtZkiLEjtcqSItmoZX8IUDSNruYFard82WicOC57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDCGrYkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7A8C4AF1A;
	Sat, 20 Jul 2024 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721484931;
	bh=siC36GPXr2aNokMak0PbQR2qdcyg1ve7YXRSuhNJEbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RDCGrYkFHBvehj29UDRcl3t1EHsB51xf7GFo5CKB+uCbnDQtMfOicE33zGH7obU16
	 jVTtgFsRzB3DbZepcD2yJrIKvGGKY/+bb8sS+JmtXmlmXTRV6VdHtLMMfmnOa1q8+C
	 HrWen2hKhk2s0Je4ox5loQTIQviQ3g0ZK3c24Soc84jYZj0UYDa4aEQ33k7A2nUTGa
	 b+aRyZ9coYkE58bdz9EiXRzyaHFOWkWs0Wkt6VRBWOeLEadXb7ny85sg+jbP2vt4YR
	 SrtG4gsnkQGC2WvKsrbktxEE5pFxP7rJdHBytYr/64QJTDQdpZRvJdNKjfgL1frJK4
	 XqHQrYOlg0dKA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eefe705510so32541641fa.1;
        Sat, 20 Jul 2024 07:15:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWN2s3ZU59witQd+ggejld4+vvkziMR48itbPD/bsFvcHN1xryuvWDakoeosFiOmFEMGM26xTdnNFrCvVjkGW2H5uN+XOTXpuQZIBHnICcI948MqQVd5evPzproUsBktPPXTKibTiqmPVrITavOOBoIluLTPLVWszou24iMkro2xiwrIrVAQFm4twDY51h+S7CReVM9Q4P0EWWu+59x/8xmgmbcBNIXVqO6fgA38xFY99hAcK5+1nLhN6DLO7vqZ1YJ6A==
X-Gm-Message-State: AOJu0YxJ79+BXvmXwNfA6BMPh8UFzbiaJS0NBjhT+eJx+H8dNP0BM/ea
	AezwwVg0Q/F/ZbyPFZObNCOsR8qEHKiNLn3lgeiRrSM0c8/r5PNiFd5dv0Vd1GdSX+GCCsK3wDS
	BBg8iSlO60v848GO3Kg8n13zpAfw=
X-Google-Smtp-Source: AGHT+IEhxz5OQdjF+IMtXBi+my/g5+ok7BZORmWpYKrgQ6H3SidmmywUXep47MVnf2ny1Eir5dgtPfQ95aC55PC0NSg=
X-Received: by 2002:a2e:9816:0:b0:2eb:f472:e7d3 with SMTP id
 38308e7fff4ca-2ef16733722mr18077141fa.6.1721484929979; Sat, 20 Jul 2024
 07:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613133711.2867745-1-zhengyejian1@huawei.com>
 <20240613133711.2867745-3-zhengyejian1@huawei.com> <CAK7LNAQaLc6aDK85qQtPHoCkQSGyL-TxXjpgJTfehe2Q1=jMSA@mail.gmail.com>
 <c87eeb9c-5f54-480c-17c2-01339416b1b9@huawei.com>
In-Reply-To: <c87eeb9c-5f54-480c-17c2-01339416b1b9@huawei.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Jul 2024 23:14:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiR5z9hPRG932T7YjRWqkX_qZ7WKmbxx7iTo2w5YJojQ@mail.gmail.com>
Message-ID: <CAK7LNARiR5z9hPRG932T7YjRWqkX_qZ7WKmbxx7iTo2w5YJojQ@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 12:45=E2=80=AFPM Zheng Yejian <zhengyejian1@huawei.=
com> wrote:
>
> On 2024/7/16 16:33, Masahiro Yamada wrote:
> > On Thu, Jun 13, 2024 at 10:36=E2=80=AFPM Zheng Yejian <zhengyejian1@hua=
wei.com> wrote:
> >>
> >> When a weak type function is overridden, its symbol will be removed
> >> from the symbol table, but its code will not be removed. Besides,
> >> due to lacking of size for kallsyms, kernel compute function size by
> >> substracting its symbol address from its next symbol address (see
> >> kallsyms_lookup_size_offset()). These will cause that size of some
> >> function is computed to be larger than it actually is, just because
> >> symbol of its following weak function is removed.
> >>
> >> This issue also causes multiple __fentry__ locations to be counted in
> >> the some function scope, and eventually causes ftrace_location() to fi=
nd
> >> wrong __fentry__ location. It was reported in
> >> Link: https://lore.kernel.org/all/20240607115211.734845-1-zhengyejian1=
@huawei.com/
> >>
> >> Peter suggested to change scipts/kallsyms.c to emit readily
> >> identifiable symbol names for all the weak junk, eg:
> >>
> >>    __weak_junk_NNNNN
> >>
> >> The name of this kind symbol needs some discussion, but it's temporari=
ly
> >> called "__hole_symbol_XXXXX" in this patch:
> >> 1. Pass size info to scripts/kallsyms  (see mksysmap());
> >> 2. Traverse sorted function symbols, if one function address plus its
> >>     size less than next function address, it means there's a hole, the=
n
> >>     emit a symbol "__hole_symbol_XXXXX" there which type is 't'.
> >>
> >> After this patch, the effect is as follows:
> >>
> >>    $ cat /proc/kallsyms | grep -A 3 do_one_initcall
> >>    ffffffff810021e0 T do_one_initcall
> >>    ffffffff8100245e t __hole_symbol_XXXXX
> >>    ffffffff810024a0 t __pfx_rootfs_init_fs_context
> >>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> >
> >
> >
> > With my quick test, "t__hole_symbol_XXXXX" was encoded
> > into the following 10-byte stream.
> >
> > .byte 0x09, 0x94, 0xbf, 0x18, 0xf3, 0x3d, 0xce, 0xd1, 0xd1, 0x58
> >
> >
> >
> > Now "t__hole_symbol_XXXXX" is the most common symbol name.
> > However, 10 byte is consumed for every instance of
> > "t__hole_symbol_XXXXX".
> >
> > This is much less efficient thanI had expected,
> > although I did not analyze the logic of this inefficiency.
> >
> Hi, Masahiro!
>
> In my local test, "t__hole_symbol_XXXXX" was finally encoded
> into just one byte. See "kallsyms_token_table" in the .tmp_vmlinux.kallsy=
ms2.S:
>
>    kallsyms_token_table:
>          [...]
>          .asciz  "t__hole_symbol_XXXXX"
>          .asciz  "hole_symbol_XXXXX"
>          .asciz  "e_symbol_XXXXX"
>          .asciz  "XXXXX"
>          .asciz  "XXX"
>          .asciz  "e_symbol_"
>          .asciz  "ymbol_"
>          .asciz  "ymb"
>          .asciz  "hol"
>          .asciz  "ol_"
>          .asciz  "pfx"
>          .asciz  "pf"
>          .asciz  "e_s"
>          .asciz  "ym"
>          .asciz  "t__"
>          .asciz  "_s"
>          .asciz  "ol"
>          .asciz  "__"
>          .asciz  "XX"
>
> But it would still takes up several tokens due to substrings of
> "t__hole_symbol_XXXXX" would also become the most common ones.
> After this patch, the number of "t__hole_symbol_XXXXX" will be ~30% of th=
e total.
>
> >
> >
> >
> >
> >
> >
> >> ---
> >>   scripts/kallsyms.c      | 101 ++++++++++++++++++++++++++++++++++++++=
+-
> >>   scripts/link-vmlinux.sh |   4 +-
> >>   scripts/mksysmap        |   2 +-
> >>   3 files changed, 102 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> >> index 6559a9802f6e..5c4cde864a04 100644
> >> --- a/scripts/kallsyms.c
> >> +++ b/scripts/kallsyms.c
> >> @@ -35,6 +35,7 @@
> >>   struct sym_entry {
> >>          struct sym_entry *next;
> >>          unsigned long long addr;
> >> +       unsigned long long size;
> >>          unsigned int len;
> >>          unsigned int seq;
> >>          unsigned int start_pos;
> >> @@ -74,6 +75,7 @@ static int token_profit[0x10000];
> >>   static unsigned char best_table[256][2];
> >>   static unsigned char best_table_len[256];
> >>
> >> +static const char hole_symbol[] =3D "__hole_symbol_XXXXX";
> >>
> >>   static void usage(void)
> >>   {
> >> @@ -130,8 +132,16 @@ static struct sym_entry *read_symbol(FILE *in, ch=
ar **buf, size_t *buf_len)
> >>          size_t len;
> >>          ssize_t readlen;
> >>          struct sym_entry *sym;
> >> +       unsigned long long size =3D 0;
> >>
> >>          errno =3D 0;
> >> +       /*
> >> +        * Example of expected symbol format:
> >> +        * 1. symbol with size info:
> >> +        *    ffffffff81000070 00000000000001d7 T __startup_64
> >> +        * 2. symbol without size info:
> >> +        *    0000000002a00000 A text_size
> >> +        */
> >>          readlen =3D getline(buf, buf_len, in);
> >>          if (readlen < 0) {
> >>                  if (errno) {
> >> @@ -145,9 +155,24 @@ static struct sym_entry *read_symbol(FILE *in, ch=
ar **buf, size_t *buf_len)
> >>                  (*buf)[readlen - 1] =3D 0;
> >>
> >>          addr =3D strtoull(*buf, &p, 16);
> >> +       if (*buf =3D=3D p || *p++ !=3D ' ') {
> >> +               fprintf(stderr, "line format error: unable to parse ad=
dress\n");
> >> +               exit(EXIT_FAILURE);
> >> +       }
> >> +
> >> +       if (*p =3D=3D '0') {
> >> +               char *str =3D p;
> >>
> >> -       if (*buf =3D=3D p || *p++ !=3D ' ' || !isascii((type =3D *p++)=
) || *p++ !=3D ' ') {
> >> -               fprintf(stderr, "line format error\n");
> >> +               size =3D strtoull(str, &p, 16);
> >> +               if (str =3D=3D p || *p++ !=3D ' ') {
> >> +                       fprintf(stderr, "line format error: unable to =
parse size\n");
> >> +                       exit(EXIT_FAILURE);
> >> +               }
> >> +       }
> >> +
> >> +       type =3D *p++;
> >> +       if (!isascii(type) || *p++ !=3D ' ') {
> >> +               fprintf(stderr, "line format error: unable to parse ty=
pe\n");
> >>                  exit(EXIT_FAILURE);
> >>          }
> >>
> >> @@ -182,6 +207,7 @@ static struct sym_entry *read_symbol(FILE *in, cha=
r **buf, size_t *buf_len)
> >>                  exit(EXIT_FAILURE);
> >>          }
> >>          sym->addr =3D addr;
> >> +       sym->size =3D size;
> >>          sym->len =3D len;
> >>          sym->sym[0] =3D type;
> >>          strcpy(sym_name(sym), name);
> >> @@ -795,6 +821,76 @@ static void sort_symbols(void)
> >>          qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
> >>   }
> >>
> >> +static int may_exist_hole_after_symbol(const struct sym_entry *se)
> >
> >
> > The return type should be bool.
> >
>
> Yes!
>
> >
> >
> >> +{
> >> +       char type =3D se->sym[0];
> >> +
> >> +       /* Only check text symbol or weak symbol */
> >> +       if (type !=3D 't' && type !=3D 'T' &&
> >> +           type !=3D 'w' && type !=3D 'W')
> >> +               return 0;
> >> +       /* Symbol without size has no hole */
> >> +       return se->size !=3D 0;
> >> +}
> >> +
> >> +static struct sym_entry *gen_hole_symbol(unsigned long long addr)
> >> +{
> >> +       struct sym_entry *sym;
> >> +       static size_t len =3D sizeof(hole_symbol);
> >> +
> >> +       /* include type field */
> >> +       sym =3D malloc(sizeof(*sym) + len + 1);
> >> +       if (!sym) {
> >> +               fprintf(stderr, "unable to allocate memory for hole sy=
mbol\n");
> >> +               exit(EXIT_FAILURE);
> >> +       }
> >> +       sym->addr =3D addr;
> >> +       sym->size =3D 0;
> >> +       sym->len =3D len;
> >> +       sym->sym[0] =3D 't';
> >> +       strcpy(sym_name(sym), hole_symbol);
> >> +       sym->percpu_absolute =3D 0;
> >> +       return sym;
> >> +}
> >> +
> >> +static void emit_hole_symbols(void)
> >> +{
> >> +       unsigned int i, pos, nr_emit;
> >> +       struct sym_entry **new_table;
> >> +       unsigned int new_cnt;
> >> +
> >> +       nr_emit =3D 0;
> >> +       for (i =3D 0; i < table_cnt - 1; i++) {
> >> +               if (may_exist_hole_after_symbol(table[i]) &&
> >> +                   table[i]->addr + table[i]->size < table[i+1]->addr=
)
> >> +                       nr_emit++;
> >> +       }
> >> +       if (!nr_emit)
> >> +               return;
> >> +
> >> +       new_cnt =3D table_cnt + nr_emit;
> >> +       new_table =3D malloc(sizeof(*new_table) * new_cnt);
> >
> >
> > Do you need to allocate another huge table?
> >
> > You can use realloc() to append the room for nr_emit
> > if you iterate the table in the reverse order.
> >
>
> Yes, it would be much better. If it turns out to be the
> "emit hole symbol" solution, I'll change it to that in the next version,
> actually, I forgot to mark this series as "RFC".


"__hole_symbol_XXXXX" is too much.

You can use the empty symbol type/name as a special case
to represent the hole.


--=20
Best Regards
Masahiro Yamada

