Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CB281D8A
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 23:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBVVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 17:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 17:21:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B4D206DD;
        Fri,  2 Oct 2020 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601673677;
        bh=JxXwRo2eZLSKELVd1pxzEID/Qqp+oS0AgTh1YeB/Yuc=;
        h=Date:From:To:Cc:Subject:From;
        b=XL1YqCPdOV9OGqikxEAnbmnO+y1uhCzrSaApKVz9YkStseWCuCiuANMXQxWS5nLal
         MTLyd61unC21UiY9Y7wyB2olrhNM6w+snis+5JeVo7LLAU4WId8YrYdAakObRsX3Y1
         hCkUGesQ/5biCySp+7VT4FSAO2nJFfLDvkGHcQJg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 47EC8403AC; Fri,  2 Oct 2020 18:21:15 -0300 (-03)
Date:   Fri, 2 Oct 2020 18:21:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hao Luo <haoluo@google.com>, Tom de Vries <tdevries@suse.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        David Seifert <soap@gentoo.org>,
        Pavel Borzenkov <pavel.borzenkov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Martin Cermak <mcermak@redhat.com>
Subject: ANNOUNCE: pahole v1.18 (raw data pretty printer, BTF global vars)
Message-ID: <20201002212115.GB127275@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.18 release of pahole and its friends is out, available at
the usual places:

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.18.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.18.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.18.tar.sign

Best Regards,

v1.18:

- Use type information to pretty print raw data from stdin, all
  documented in the man pages, further information in the csets.

  TLDRish: this almost completely deciphers a perf.data file:

  $ pahole ~/bin/perf --header=perf_file_header \
         -C 'perf_file_attr(range=attrs),perf_event_header(range=data,sizeof,type,type_enum=perf_event_type+perf_user_event_type)' < perf.data

  What the above command line does:

  This will state that a 'struct perf_file_header' is available in BTF or DWARF
  in the ~/bin/perf file and that at the start of stdin it should be used to decode
  sizeof(struct perf_file_header) bytes, pretty printing it according to its members.

  Furthermore, that header can be referenced later in the command line, for instance
  that 'range=data' means that in the header, it expects a 'range' member in 
  'struct perf_file_header' to be used:

    $ pahole ~/bin/perf --header=perf_file_header < perf.data
    {
            .magic = 3622385352885552464,
            .size = 104,
            .attr_size = 136,
            .attrs = {
                    .offset = 296,
                    .size = 136,
            },
            .data = {
                    .offset = 432,
                    .size = 14688,
            },
                    .event_types = {
                    .offset = 0,
                    .size = 0,
            },
            .adds_features = { 376537084, 0, 0, 0 },
    },
    $

  That 'range' field is expected to have 'offset' and 'size' fields, so that
  it can go on decoding a number of 'struct perf_event_header' entries.

  That 'sizeof' in turn expects that in 'struct perf_event_header' there is a
  'size' field stating how long that particular record is, one can also use
  'sizeof=some_other_member_name'.

  This supports variable sized records and then the 'type' field expects there
  is a 'struct perf_event_type' member named 'type' (again, type=something_else
  may be used. Finally, the value in the 'type' field is used to lookup an entry
  in the set formed by the two enumerations specified in the 'type_enum=' argument.

  If we look at these enums we'll see that its entries have names that can be,
  when lowercased, point to structs containing the layout for the variable sized
  record, which allows it to cast and produce the right pretty printed output.

  I.e. using the kernel BTF info we get:

  $ pahole perf_event_type
  enum perf_event_type {
  	PERF_RECORD_MMAP = 1,
  	PERF_RECORD_LOST = 2,
  	PERF_RECORD_COMM = 3,
  	PERF_RECORD_EXIT = 4,
  	PERF_RECORD_THROTTLE = 5,
  	PERF_RECORD_UNTHROTTLE = 6,
  	PERF_RECORD_FORK = 7,
  	PERF_RECORD_READ = 8,
  	PERF_RECORD_SAMPLE = 9,
  	PERF_RECORD_MMAP2 = 10,
  	PERF_RECORD_AUX = 11,
  	PERF_RECORD_ITRACE_START = 12,
  	PERF_RECORD_LOST_SAMPLES = 13,
  	PERF_RECORD_SWITCH = 14,
  	PERF_RECORD_SWITCH_CPU_WIDE = 15,
  	PERF_RECORD_NAMESPACES = 16,
  	PERF_RECORD_KSYMBOL = 17,
  	PERF_RECORD_BPF_EVENT = 18,
  	PERF_RECORD_CGROUP = 19,
  	PERF_RECORD_TEXT_POKE = 20,
  	PERF_RECORD_MAX = 21,
  };
  $

  That is the same as in ~/bin/perf, and, if we get one of these and ask for
  that struct:

  $ pahole -C perf_record_mmap ~/bin/perf
  struct perf_record_mmap {
  	struct perf_event_header   header;               /*     0     8 */
  	__u32                      pid;                  /*     8     4 */
  	__u32                      tid;                  /*    12     4 */
  	__u64                      start;                /*    16     8 */
  	__u64                      len;                  /*    24     8 */
  	__u64                      pgoff;                /*    32     8 */
  	char                       filename[4096];       /*    40  4096 */
  
  	/* size: 4136, cachelines: 65, members: 7 */
  	/* last cacheline: 40 bytes */
  };
  $

  Many other options were introduced to work with this, including --count,
  --skip, etc, look at the man page for details.

- Store percpu variables in vmlinux BTF. This can be disabled when debugging
  kernel features being developed to use it.

- pahole now should be segfault free when handling gdb test suit DWARF
  files, including ADA, FORTRAN, rust and dwp compressed files, the
  later being just flatly refused, that got left for v1.19.

- Bail out on partial units for now, avoiding segfaults and providing warning
  to user, hopefully will be addressed in v1.19.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
