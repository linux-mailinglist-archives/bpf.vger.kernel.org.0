Return-Path: <bpf+bounces-44973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189A9CF2FD
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5218BB3403E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8991D47DC;
	Fri, 15 Nov 2024 16:33:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E991E18E047;
	Fri, 15 Nov 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688427; cv=none; b=XW19uidLmj3jWBURP5EGsKZCogItlcu/Qb+o5vAbxIPl0AnBAIj0ac5Z40M/5QlCcc9XIxeF0/B9ZF8wmi/QG/fX9u66MktKAC7FCwl2xINFEW0AMsvWXqkNbGi85kqm25rTAR2pTl7PEOtVLPTACD6h+Ypf02dt7H4ipXAchsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688427; c=relaxed/simple;
	bh=LWFChiepHfjiCg/7dWHFOZF3rLF7gY1u8jVuWTKeAXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MyPAy1EL5ld+xiWkfR46fUMZYfPjFNq9czFGhO+kXoM3tGvBTNBylzQ1zx4RPyjYn9C+8pC1I/dtLCFYm3QqN85QhdsmB1IQFhZq8+GshyOi7IW2svL8byRPASdZM0Okge0Pc7Q2sutYkEAJtllQZNvbC+h2AwJBkxlayamQRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl [82.217.174.174])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by gnu.wildebeest.org (Postfix) with ESMTPSA id A1EAA303C2A0;
	Fri, 15 Nov 2024 17:26:09 +0100 (CET)
Received: by r6.localdomain (Postfix, from userid 1000)
	id 2F470340511; Fri, 15 Nov 2024 17:26:09 +0100 (CET)
Message-ID: <1c5596cb29bbafecda69737ce097dd1e8714eb9f.camel@klomp.org>
Subject: elfutils thread-safety (Was: [PATCH dwarves 3/3] dwarf_loader:
 Check DW_OP_[GNU_]entry_value for possible parameter matching)
From: Mark Wielaard <mark@klomp.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa
 <olsajiri@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song	
 <yonghong.song@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, Arnaldo
 Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	kernel-team@fb.com, Song Liu <song@kernel.org>,
 elfutils-devel@sourceware.org
Date: Fri, 15 Nov 2024 17:26:09 +0100
In-Reply-To: <ZzIJqnFh2WfzHirN@x1>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
	 <20241108180524.1198900-1-yonghong.song@linux.dev>
	 <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
	 <080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com>
	 <ZzH6ZDucO2nm9Y52@krava> <ZzIJqnFh2WfzHirN@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Flag: NO

Hi Arnaldo,

On Mon, 2024-11-11 at 10:42 -0300, Arnaldo Carvalho de Melo wrote:
> Adding Mark to the CC list.

And CC elfutils-devel so this gets more exposure to the people working
on elfutils thread-safety. For those missing some context the whole
thread is here:
https://lore.kernel.org/dwarves/ZzIJqnFh2WfzHirN@x1/T/#u

pahole source code can be found here:
https://git.kernel.org/pub/scm/devel/pahole/pahole.git
(See the README for build instructions.)

> On Mon, Nov 11, 2024 at 01:36:52PM +0100, Jiri Olsa wrote:
> > On Mon, Nov 11, 2024 at 12:01:13AM -0800, Eduard Zingerman wrote:
> > > On Sun, 2024-11-10 at 03:38 -0800, Eduard Zingerman wrote:
> > >=20
> > > [...]
> > >=20
> > > > Also, it appears there is some bug either in pahole or in libdw's
> > > > implementation of dwarf_getlocation(). When I try both your patch-s=
et
> > > > and my variant there is a segfault once in a while:
> > > >=20
> > > >   $ for i in $(seq 1 100); \
> > > >     do echo "---> $i"; \
> > > >        pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_en=
code_detached=3D/dev/null vmlinux ; \
> > > >     done
> > > >   ---> 1
> > > >   ...
> > > >   ---> 71
> > > >   Segmentation fault (core dumped)
> > > >   ...
> > > >=20
> > > > The segfault happens only when -j (multiple threads) is passed.
> > > > If pahole is built with sanitizers
> > > > (passing -DCMAKE_C_FLAGS=3D"-fsanitize=3Dundefined,address")
> > > > the stack trace looks as follows:
> > >=20
> > > Did some additional research for these SEGFAULTs.
> > > Looks like all we are in trouble.
> > >=20
> > > # TLDR
> > >=20
> > > libdw is not supposed to be used in a concurrent context.
> > > libdw is a part of elfutils package, the configuration flag
> > > making API thread-safe is documented as experimental:
> > >   --enable-thread-safety  enable thread safety of libraries EXPERIMEN=
TAL
> > > At-least Fedora 40 does not ship elfutils built with this flag set.
> > > This colours all current parallel DWARF decoding questionable.

Unfortunately true. The good news is that there is a serious effort to
complete the work so that --enable-thread-safety can be turned on by
default, but that work isn't complete yet. Which is why we currently
have it marked as EXPERIMENTAL.

It would be really nice if people did try it out though and reported
any remaining issues.
https://sourceware.org/bugzilla/enter_bug.cgi?product=3Delfutils or sent
email to elfutils-devel@sourceware.org

> > > # Why segfault happens
> > >=20
> > > Any references to elfutils source code are for commit [1].
> > > The dwarf_getlocation() is one of a few libdw APIs that uses memory
> > > allocation internally. The function dwarf_getlocation.c:__libdw_inter=
n_expression
> > > iterates over expression encodings in DWARF and allocates
> > > a set of objects of type `struct loclist` and `Dwarf_Op`.
> > > Pointers to allocated objects are put to a binary tree for caching,
> > > see dwarf_getlocation.c:660, the call to eu_tsearch() function.
> > > The eu_tsearch() is a wrapper around libc tsearch() function.
> > > This wrapper provides locking for the tree,
> > > but only if --enable-thread-safety was set during elfutils configurat=
ion.
> > > The SEGFAULT happens inside tsearch() call because binary tree is mal=
formed, e.g.:
> > >=20
> > >   Thread 8 "pahole" received signal SIGSEGV, Segmentation fault.
> > >   [Switching to Thread 0x7fffd9c006c0 (LWP 2630074)]
> > >   0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
> > >   228	      if (parentp !=3D NULL && RED(DEREFNODEPTR(parentp)))
> > >   (gdb) bt
> > >   #0  0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c=
:228
> > >   #1  0x00007ffff7c5d466 in __GI___tsearch (...) at tsearch.c:358
> > >   #2  __GI___tsearch (...) at tsearch.c:290
> > >   #3  0x000000000048f096 in __interceptor_tsearch ()
> > >   #4  0x00007ffff7f5c482 in __libdw_intern_expression (...) at dwarf_=
getlocation.c:660
> > >   #5  0x00007ffff7f5cf51 in getlocation (...) at dwarf_getlocation.c:=
678
> > >   #6  getlocation (...) at dwarf_getlocation.c:667
> > >   #7  dwarf_getlocation (..._ at dwarf_getlocation.c:708
> > >   #8  0x00000000005a2ee5 in parameter.new ()
> > >   #9  0x00000000005a0122 in die.process_function ()
> > >   #10 0x0000000000597efd in __die__process_tag ()
> > >   #11 0x0000000000595ad9 in die.process_unit ()
> > >   #12 0x0000000000595436 in die.process ()
> > >   #13 0x00000000005b0187 in dwarf_cus.process_cu ()
> > >   #14 0x00000000005afa38 in dwarf_cus.process_cu_thread ()
> > >   #15 0x00000000004c7b8d in asan_thread_start(void*) ()
> > >   #16 0x00007ffff7bda6d7 in start_thread (arg=3D<optimized out>) at p=
thread_create.c:447
> > >   #17 0x00007ffff7c5e60c in clone3 () at ../sysdeps/unix/sysv/linux/x=
86_64/clone3.S:78
> > >   (gdb) p parentp
> > >   $1 =3D (node *) 0x50300079d2a0
> > >   (gdb) p *parentp
> > >   $2 =3D (node) 0x0
> > >=20
> > > glibc provides a way to validate binary tree structure.
> > > For this misc/tsearch.c has to be changed to define DEBUGGING variabl=
e.
> > > (I used glibc 2.39 as provided by source rpm for Fedora 40 for experi=
ments).
> > > If this is done and custom glibc is used for pahole execution,
> > > the following error is reported if '-j' flag is present:
> > >=20
> > >   $ pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_=
detached=3D/home/eddy/work/tmp/my-new.btf vmlinux=20
> > >   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion fa=
iled: d_sofar =3D=3D d_total
> > >   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion fa=
iled: d_sofar =3D=3D d_total
> > >   Aborted (core dumped)
> > >=20
> > > Executing pahole using a custom-built libdw,
> > > built with --enable-thread-safety resolves the issue.
> >=20
> > could we use libdw__lock around that? but I guess we use it on other
> > places as well..
>=20
> Right, if you look at the cset where I intrduced libdw__lock (at the end
> of this message), its a similar case, probably we should rename it to
> libdw__decl_lock and introduce a libdw__getlocation_lock? This way, for
> these known to be not thread safe we use libdw in serially while not
> having a libdw "big lock" getting too much in the way of pahole's
> parallel operation?

The trouble with a "big lock" is that it is easy to create a big
deadlock, especially given that libdw provides various callbacks which
are then run under the big lock and must be careful to not call back
into libdw trying to reacquire the big lock.

So you are currently only using that libdw__lock around the
dwarf_decl_file/line calls?

Is there a pahole tesstsuite which exercises the -j parallel option?

Are you trying to check thread-safety of pahole with any tools like
valgrind helgrind?

Thanks,

Mark

> $ git show 1caed1c443d4a0dc5
> commit 1caed1c443d4a0dc5794f21954be7d5ae0396c90
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Jul 8 16:07:50 2021 -0300
>=20
>     dwarf_loader: Add a lock around dwarf_decl_file() and dwarf_decl_line=
() calls
>    =20
>     As this ends up racing on a tsearch() call, probably for some libdw
>     cache that gets updated/lookedup in concurrent pahole threads (-j N).
>    =20
>     This cures the following, a patch for libdw will be cooked up and sen=
t.
>    =20
>       (gdb) run -j -I -F dwarf vmlinux > /dev/null
>       Starting program: /var/home/acme/git/pahole/build/pahole -j -I -F d=
warf vmlinux > /dev/null
>       warning: Expected absolute pathname for libpthread in the inferior,=
 but got .gnu_debugdata for /lib64/libpthread.so.0.
>       warning: File "/usr/lib64/libthread_db-1.0.so" auto-loading has bee=
n declined by your `auto-load safe-path' set to "$debugdir:$datadir/auto-lo=
ad".
>       warning: Unable to find libthread_db matching inferior's thread lib=
rary, thread debugging will not be available.
>       [New LWP 844789]
>       [New LWP 844790]
>       [New LWP 844791]
>       [New LWP 844792]
>       [New LWP 844793]
>       [New LWP 844794]
>       [New LWP 844795]
>       [New LWP 844796]
>       [New LWP 844797]
>       [New LWP 844798]
>       [New LWP 844799]
>       [New LWP 844800]
>       [New LWP 844801]
>       [New LWP 844802]
>       [New LWP 844803]
>       [New LWP 844804]
>       [New LWP 844805]
>       [New LWP 844806]
>       [New LWP 844807]
>       [New LWP 844808]
>       [New LWP 844809]
>       [New LWP 844810]
>       [New LWP 844811]
>       [New LWP 844812]
>       [New LWP 844813]
>       [New LWP 844814]
>    =20
>       Thread 2 "pahole" received signal SIGSEGV, Segmentation fault.
>       [Switching to LWP 844789]
>       0x00007ffff7dfa321 in ?? () from /lib64/libc.so.6
>       (gdb) bt
>       #0  0x00007ffff7dfa321 in ?? () from /lib64/libc.so.6
>       #1  0x00007ffff7dfa4bb in ?? () from /lib64/libc.so.6
>       #2  0x00007ffff7f5eaa6 in __libdw_getsrclines (dbg=3D0x4a7f90, debu=
g_line_offset=3D10383710, comp_dir=3D0x7ffff3c29f01 "/var/home/acme/git/bui=
ld/v5.13.0-rc6+", address_size=3Daddress_size@entry=3D8, linesp=3Dlinesp@en=
try=3D0x7fffcfe04ba0, filesp=3Dfilesp@entry=3D0x7fffcfe04ba8)
>           at dwarf_getsrclines.c:1129
>       #3  0x00007ffff7f5ed14 in dwarf_getsrclines (cudie=3Dcudie@entry=3D=
0x7fffd210caf0, lines=3Dlines@entry=3D0x7fffd210cac0, nlines=3Dnlines@entry=
=3D0x7fffd210cac8) at dwarf_getsrclines.c:1213
>       #4  0x00007ffff7f64883 in dwarf_decl_file (die=3D<optimized out>) a=
t dwarf_decl_file.c:66
>       #5  0x0000000000425f24 in tag__init (tag=3D0x7fff0421b710, cu=3D0x7=
fffcc001e40, die=3D0x7fffd210cd30) at /var/home/acme/git/pahole/dwarf_loade=
r.c:476
>       #6  0x00000000004262ec in namespace__init (namespace=3D0x7fff0421b7=
10, die=3D0x7fffd210cd30, cu=3D0x7fffcc001e40, conf=3D0x475600 <conf_load>)=
 at /var/home/acme/git/pahole/dwarf_loader.c:576
>       #7  0x00000000004263ac in type__init (type=3D0x7fff0421b710, die=3D=
0x7fffd210cd30, cu=3D0x7fffcc001e40, conf=3D0x475600 <conf_load>) at /var/h=
ome/acme/git/pahole/dwarf_loader.c:595
>       #8  0x00000000004264d1 in type__new (die=3D0x7fffd210cd30, cu=3D0x7=
fffcc001e40, conf=3D0x475600 <conf_load>) at /var/home/acme/git/pahole/dwar=
f_loader.c:614
>       #9  0x0000000000427ba6 in die__create_new_typedef (die=3D0x7fffd210=
cd30, cu=3D0x7fffcc001e40, conf=3D0x475600 <conf_load>) at /var/home/acme/g=
it/pahole/dwarf_loader.c:1212
>       #10 0x0000000000428df5 in __die__process_tag (die=3D0x7fffd210cd30,=
 cu=3D0x7fffcc001e40, top_level=3D1, fn=3D0x45cee0 <__FUNCTION__.10> "die__=
process_unit", conf=3D0x475600 <conf_load>) at /var/home/acme/git/pahole/dw=
arf_loader.c:1823
>       #11 0x0000000000428ea1 in die__process_unit (die=3D0x7fffd210cd30, =
cu=3D0x7fffcc001e40, conf=3D0x475600 <conf_load>) at /var/home/acme/git/pah=
ole/dwarf_loader.c:1848
>       #12 0x0000000000429e45 in die__process (die=3D0x7fffd210ce20, cu=3D=
0x7fffcc001e40, conf=3D0x475600 <conf_load>) at /var/home/acme/git/pahole/d=
warf_loader.c:2311
>       #13 0x0000000000429ecb in die__process_and_recode (die=3D0x7fffd210=
ce20, cu=3D0x7fffcc001e40, conf=3D0x475600 <conf_load>) at /var/home/acme/g=
it/pahole/dwarf_loader.c:2326
>       #14 0x000000000042a9d6 in dwarf_cus__create_and_process_cu (dcus=3D=
0x7fffffffddc0, cu_die=3D0x7fffd210ce20, pointer_size=3D8 '\b') at /var/hom=
e/acme/git/pahole/dwarf_loader.c:2644
>       #15 0x000000000042ab28 in dwarf_cus__process_cu_thread (arg=3D0x7ff=
fffffddc0) at /var/home/acme/git/pahole/dwarf_loader.c:2687
>       #16 0x00007ffff7ed6299 in start_thread () from /lib64/libpthread.so=
.0
>       #17 0x00007ffff7dfe353 in ?? () from /lib64/libc.so.6
>       (gdb)
>       (gdb) fr 2
>       1085
>       (gdb) list files_lines_compare
>       1086    static int
>       1087    files_lines_compare (const void *p1, const void *p2)
>       1088    {
>       1089    const struct files_lines_s *t1 =3D p1;
>       1090    const struct files_lines_s *t2 =3D p2;
>       1091
>       1092    if (t1->debug_line_offset < t2->debug_line_offset)
>       (gdb)
>       1093        return -1;
>       1094    if (t1->debug_line_offset > t2->debug_line_offset)
>       1095        return 1;
>       1096
>       1097    return 0;
>       1098    }
>       1099
>       1100    int
>       1101    internal_function
>       1102    __libdw_getsrclines (Dwarf *dbg, Dwarf_Off debug_line_offse=
t,
>       (gdb) list __libdw_getsrclines
>       1100    int
>       1101    internal_function
>       1102    __libdw_getsrclines (Dwarf *dbg, Dwarf_Off debug_line_offse=
t,
>       1103                         const char *comp_dir, unsigned address=
_size,
>       1104                         Dwarf_Lines **linesp, Dwarf_Files **fi=
lesp)
>       1105    {
>       1106    struct files_lines_s fake =3D { .debug_line_offset =3D debu=
g_line_offset };
>       1107    struct files_lines_s **found =3D tfind (&fake, &dbg->files_=
lines,
>       1108                                            files_lines_compare=
);
>       1109    if (found =3D=3D NULL)
>       (gdb)
>       1110        {
>       1111          Elf_Data *data =3D __libdw_checked_get_data (dbg, IDX=
_debug_line);
>       1112          if (data =3D=3D NULL
>       1113              || __libdw_offset_in_section (dbg, IDX_debug_line=
,
>       1114                                            debug_line_offset, =
1) !=3D 0)
>       1115            return -1;
>       1116
>       1117          const unsigned char *linep =3D data->d_buf + debug_li=
ne_offset;
>       1118          const unsigned char *lineendp =3D data->d_buf + data-=
>d_size;
>       1119
>       (gdb)
>       1120          struct files_lines_s *node =3D libdw_alloc (dbg, stru=
ct files_lines_s,
>       1121                                                    sizeof *nod=
e, 1);
>       1122
>       1123          if (read_srclines (dbg, linep, lineendp, comp_dir, ad=
dress_size,
>       1124                             &node->lines, &node->files) !=3D 0=
)
>       1125            return -1;
>       1126
>       1127          node->debug_line_offset =3D debug_line_offset;
>       1128
>       1129          found =3D tsearch (node, &dbg->files_lines, files_lin=
es_compare);
>       (gdb)
>    =20
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>


