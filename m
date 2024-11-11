Return-Path: <bpf+bounces-44517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8C29C3FAD
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141B51C219B1
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86719DF7A;
	Mon, 11 Nov 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRsMfHmp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0539194ACC;
	Mon, 11 Nov 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332526; cv=none; b=fPDCWGs6yYOscKnHGMi+8GvTDrr2Dnr67ytxWOPACk+kGf41nJVSJjphJQBXCv7azxIpQhoSzaYCNGgH+JW9q57gWBbc716C+I+QucS6Ye7oK2uitNDcHqOYVJn8SJYj5Pe44dj4ulnlQQnj5T2QXMo5NHI0CXsF35x2KMukFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332526; c=relaxed/simple;
	bh=HwnBbCzGQA5k2S0GLpG3FKZlW8Tufz3sqXCLxcbk4C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1p/60tgSqsWcPPvFonrk3CoEDvk87yafHZ+6u48bLM7UgJWA+j8LFPyM2rOqiXeIq9zGlDbkcGpiwYAQ6TiEBVtNGfTedgtRMh9OGxybj8R3myl8ziEb0xRnhChrWs+uqI+9DHt9Y0UKBtP0MFumDMeXgmPrOS+rV1MEXSnm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRsMfHmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13BAC4CECF;
	Mon, 11 Nov 2024 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332526;
	bh=HwnBbCzGQA5k2S0GLpG3FKZlW8Tufz3sqXCLxcbk4C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRsMfHmppiveXo3ja4g3wA+rBm6Z8NY+IvJ+ZCK/3vYDnR/DTMFA5SxfmzK2FnDjw
	 TjnCQcOK84vt9ZgwwIleAXbGJ2ZAr6CyvGNjmNaRLCzi32Prji9W6Vx4/vrgm2xNpa
	 REsj11cf4oGgrj+MfZgANBDU3m343S3rc/O8rS59DHowZ5XY8lJ/9zZKG01dCFGX9r
	 laeh35flOoIFnQZNvSWJRcQ2YlJepIncmXz4lPzJ1rtxMRYqI7FVJOi+gsEJRtbGGI
	 rDrUIN6tEYEPjZAf7V7qqEYo2LqibnCsiAS1bsa+LTX/rxcn5fK/I+rg623LGmQgjd
	 yDONU7X2FA3xg==
Date: Mon, 11 Nov 2024 10:42:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Mark Wielaard <mark@klomp.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Message-ID: <ZzIJqnFh2WfzHirN@x1>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
 <080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com>
 <ZzH6ZDucO2nm9Y52@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzH6ZDucO2nm9Y52@krava>

Adding Mark to the CC list.

On Mon, Nov 11, 2024 at 01:36:52PM +0100, Jiri Olsa wrote:
> On Mon, Nov 11, 2024 at 12:01:13AM -0800, Eduard Zingerman wrote:
> > On Sun, 2024-11-10 at 03:38 -0800, Eduard Zingerman wrote:
> > 
> > [...]
> > 
> > > Also, it appears there is some bug either in pahole or in libdw's
> > > implementation of dwarf_getlocation(). When I try both your patch-set
> > > and my variant there is a segfault once in a while:
> > > 
> > >   $ for i in $(seq 1 100); \
> > >     do echo "---> $i"; \
> > >        pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detached=/dev/null vmlinux ; \
> > >     done
> > >   ---> 1
> > >   ...
> > >   ---> 71
> > >   Segmentation fault (core dumped)
> > >   ...
> > > 
> > > The segfault happens only when -j (multiple threads) is passed.
> > > If pahole is built with sanitizers
> > > (passing -DCMAKE_C_FLAGS="-fsanitize=undefined,address")
> > > the stack trace looks as follows:
> > 
> > Did some additional research for these SEGFAULTs.
> > Looks like all we are in trouble.
> > 
> > # TLDR
> > 
> > libdw is not supposed to be used in a concurrent context.
> > libdw is a part of elfutils package, the configuration flag
> > making API thread-safe is documented as experimental:
> >   --enable-thread-safety  enable thread safety of libraries EXPERIMENTAL
> > At-least Fedora 40 does not ship elfutils built with this flag set.
> > This colours all current parallel DWARF decoding questionable.
> > 
> > # Why segfault happens
> > 
> > Any references to elfutils source code are for commit [1].
> > The dwarf_getlocation() is one of a few libdw APIs that uses memory
> > allocation internally. The function dwarf_getlocation.c:__libdw_intern_expression
> > iterates over expression encodings in DWARF and allocates
> > a set of objects of type `struct loclist` and `Dwarf_Op`.
> > Pointers to allocated objects are put to a binary tree for caching,
> > see dwarf_getlocation.c:660, the call to eu_tsearch() function.
> > The eu_tsearch() is a wrapper around libc tsearch() function.
> > This wrapper provides locking for the tree,
> > but only if --enable-thread-safety was set during elfutils configuration.
> > The SEGFAULT happens inside tsearch() call because binary tree is malformed, e.g.:
> > 
> >   Thread 8 "pahole" received signal SIGSEGV, Segmentation fault.
> >   [Switching to Thread 0x7fffd9c006c0 (LWP 2630074)]
> >   0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
> >   228	      if (parentp != NULL && RED(DEREFNODEPTR(parentp)))
> >   (gdb) bt
> >   #0  0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
> >   #1  0x00007ffff7c5d466 in __GI___tsearch (...) at tsearch.c:358
> >   #2  __GI___tsearch (...) at tsearch.c:290
> >   #3  0x000000000048f096 in __interceptor_tsearch ()
> >   #4  0x00007ffff7f5c482 in __libdw_intern_expression (...) at dwarf_getlocation.c:660
> >   #5  0x00007ffff7f5cf51 in getlocation (...) at dwarf_getlocation.c:678
> >   #6  getlocation (...) at dwarf_getlocation.c:667
> >   #7  dwarf_getlocation (..._ at dwarf_getlocation.c:708
> >   #8  0x00000000005a2ee5 in parameter.new ()
> >   #9  0x00000000005a0122 in die.process_function ()
> >   #10 0x0000000000597efd in __die__process_tag ()
> >   #11 0x0000000000595ad9 in die.process_unit ()
> >   #12 0x0000000000595436 in die.process ()
> >   #13 0x00000000005b0187 in dwarf_cus.process_cu ()
> >   #14 0x00000000005afa38 in dwarf_cus.process_cu_thread ()
> >   #15 0x00000000004c7b8d in asan_thread_start(void*) ()
> >   #16 0x00007ffff7bda6d7 in start_thread (arg=<optimized out>) at pthread_create.c:447
> >   #17 0x00007ffff7c5e60c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> >   (gdb) p parentp
> >   $1 = (node *) 0x50300079d2a0
> >   (gdb) p *parentp
> >   $2 = (node) 0x0
> > 
> > glibc provides a way to validate binary tree structure.
> > For this misc/tsearch.c has to be changed to define DEBUGGING variable.
> > (I used glibc 2.39 as provided by source rpm for Fedora 40 for experiments).
> > If this is done and custom glibc is used for pahole execution,
> > the following error is reported if '-j' flag is present:
> > 
> >   $ pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detached=/home/eddy/work/tmp/my-new.btf vmlinux 
> >   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: d_sofar == d_total
> >   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: d_sofar == d_total
> >   Aborted (core dumped)
> > 
> > Executing pahole using a custom-built libdw,
> > built with --enable-thread-safety resolves the issue.
> 
> could we use libdw__lock around that? but I guess we use it on other
> places as well..

Right, if you look at the cset where I intrduced libdw__lock (at the end
of this message), its a similar case, probably we should rename it to
libdw__decl_lock and introduce a libdw__getlocation_lock? This way, for
these known to be not thread safe we use libdw in serially while not
having a libdw "big lock" getting too much in the way of pahole's
parallel operation?

I'll take a closer look at Edward's analysis and the code, as well as
conversations I had with Mark Wieelard at the time.

- Arnaldo

$ git show 1caed1c443d4a0dc5
commit 1caed1c443d4a0dc5794f21954be7d5ae0396c90
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Jul 8 16:07:50 2021 -0300

    dwarf_loader: Add a lock around dwarf_decl_file() and dwarf_decl_line() calls
    
    As this ends up racing on a tsearch() call, probably for some libdw
    cache that gets updated/lookedup in concurrent pahole threads (-j N).
    
    This cures the following, a patch for libdw will be cooked up and sent.
    
      (gdb) run -j -I -F dwarf vmlinux > /dev/null
      Starting program: /var/home/acme/git/pahole/build/pahole -j -I -F dwarf vmlinux > /dev/null
      warning: Expected absolute pathname for libpthread in the inferior, but got .gnu_debugdata for /lib64/libpthread.so.0.
      warning: File "/usr/lib64/libthread_db-1.0.so" auto-loading has been declined by your `auto-load safe-path' set to "$debugdir:$datadir/auto-load".
      warning: Unable to find libthread_db matching inferior's thread library, thread debugging will not be available.
      [New LWP 844789]
      [New LWP 844790]
      [New LWP 844791]
      [New LWP 844792]
      [New LWP 844793]
      [New LWP 844794]
      [New LWP 844795]
      [New LWP 844796]
      [New LWP 844797]
      [New LWP 844798]
      [New LWP 844799]
      [New LWP 844800]
      [New LWP 844801]
      [New LWP 844802]
      [New LWP 844803]
      [New LWP 844804]
      [New LWP 844805]
      [New LWP 844806]
      [New LWP 844807]
      [New LWP 844808]
      [New LWP 844809]
      [New LWP 844810]
      [New LWP 844811]
      [New LWP 844812]
      [New LWP 844813]
      [New LWP 844814]
    
      Thread 2 "pahole" received signal SIGSEGV, Segmentation fault.
      [Switching to LWP 844789]
      0x00007ffff7dfa321 in ?? () from /lib64/libc.so.6
      (gdb) bt
      #0  0x00007ffff7dfa321 in ?? () from /lib64/libc.so.6
      #1  0x00007ffff7dfa4bb in ?? () from /lib64/libc.so.6
      #2  0x00007ffff7f5eaa6 in __libdw_getsrclines (dbg=0x4a7f90, debug_line_offset=10383710, comp_dir=0x7ffff3c29f01 "/var/home/acme/git/build/v5.13.0-rc6+", address_size=address_size@entry=8, linesp=linesp@entry=0x7fffcfe04ba0, filesp=filesp@entry=0x7fffcfe04ba8)
          at dwarf_getsrclines.c:1129
      #3  0x00007ffff7f5ed14 in dwarf_getsrclines (cudie=cudie@entry=0x7fffd210caf0, lines=lines@entry=0x7fffd210cac0, nlines=nlines@entry=0x7fffd210cac8) at dwarf_getsrclines.c:1213
      #4  0x00007ffff7f64883 in dwarf_decl_file (die=<optimized out>) at dwarf_decl_file.c:66
      #5  0x0000000000425f24 in tag__init (tag=0x7fff0421b710, cu=0x7fffcc001e40, die=0x7fffd210cd30) at /var/home/acme/git/pahole/dwarf_loader.c:476
      #6  0x00000000004262ec in namespace__init (namespace=0x7fff0421b710, die=0x7fffd210cd30, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:576
      #7  0x00000000004263ac in type__init (type=0x7fff0421b710, die=0x7fffd210cd30, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:595
      #8  0x00000000004264d1 in type__new (die=0x7fffd210cd30, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:614
      #9  0x0000000000427ba6 in die__create_new_typedef (die=0x7fffd210cd30, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:1212
      #10 0x0000000000428df5 in __die__process_tag (die=0x7fffd210cd30, cu=0x7fffcc001e40, top_level=1, fn=0x45cee0 <__FUNCTION__.10> "die__process_unit", conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:1823
      #11 0x0000000000428ea1 in die__process_unit (die=0x7fffd210cd30, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:1848
      #12 0x0000000000429e45 in die__process (die=0x7fffd210ce20, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:2311
      #13 0x0000000000429ecb in die__process_and_recode (die=0x7fffd210ce20, cu=0x7fffcc001e40, conf=0x475600 <conf_load>) at /var/home/acme/git/pahole/dwarf_loader.c:2326
      #14 0x000000000042a9d6 in dwarf_cus__create_and_process_cu (dcus=0x7fffffffddc0, cu_die=0x7fffd210ce20, pointer_size=8 '\b') at /var/home/acme/git/pahole/dwarf_loader.c:2644
      #15 0x000000000042ab28 in dwarf_cus__process_cu_thread (arg=0x7fffffffddc0) at /var/home/acme/git/pahole/dwarf_loader.c:2687
      #16 0x00007ffff7ed6299 in start_thread () from /lib64/libpthread.so.0
      #17 0x00007ffff7dfe353 in ?? () from /lib64/libc.so.6
      (gdb)
      (gdb) fr 2
      1085
      (gdb) list files_lines_compare
      1086    static int
      1087    files_lines_compare (const void *p1, const void *p2)
      1088    {
      1089    const struct files_lines_s *t1 = p1;
      1090    const struct files_lines_s *t2 = p2;
      1091
      1092    if (t1->debug_line_offset < t2->debug_line_offset)
      (gdb)
      1093        return -1;
      1094    if (t1->debug_line_offset > t2->debug_line_offset)
      1095        return 1;
      1096
      1097    return 0;
      1098    }
      1099
      1100    int
      1101    internal_function
      1102    __libdw_getsrclines (Dwarf *dbg, Dwarf_Off debug_line_offset,
      (gdb) list __libdw_getsrclines
      1100    int
      1101    internal_function
      1102    __libdw_getsrclines (Dwarf *dbg, Dwarf_Off debug_line_offset,
      1103                         const char *comp_dir, unsigned address_size,
      1104                         Dwarf_Lines **linesp, Dwarf_Files **filesp)
      1105    {
      1106    struct files_lines_s fake = { .debug_line_offset = debug_line_offset };
      1107    struct files_lines_s **found = tfind (&fake, &dbg->files_lines,
      1108                                            files_lines_compare);
      1109    if (found == NULL)
      (gdb)
      1110        {
      1111          Elf_Data *data = __libdw_checked_get_data (dbg, IDX_debug_line);
      1112          if (data == NULL
      1113              || __libdw_offset_in_section (dbg, IDX_debug_line,
      1114                                            debug_line_offset, 1) != 0)
      1115            return -1;
      1116
      1117          const unsigned char *linep = data->d_buf + debug_line_offset;
      1118          const unsigned char *lineendp = data->d_buf + data->d_size;
      1119
      (gdb)
      1120          struct files_lines_s *node = libdw_alloc (dbg, struct files_lines_s,
      1121                                                    sizeof *node, 1);
      1122
      1123          if (read_srclines (dbg, linep, lineendp, comp_dir, address_size,
      1124                             &node->lines, &node->files) != 0)
      1125            return -1;
      1126
      1127          node->debug_line_offset = debug_line_offset;
      1128
      1129          found = tsearch (node, &dbg->files_lines, files_lines_compare);
      (gdb)
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

