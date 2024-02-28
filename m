Return-Path: <bpf+bounces-22914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8F86B86F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD2328909A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37606FCE0;
	Wed, 28 Feb 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJjVfSii"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BA5E08C;
	Wed, 28 Feb 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149165; cv=none; b=T/qc6Wj/dBqZq+Ehs1pRmAKqCNPuBwcDKUtad5l44GSF3nittbX5CrjXGRli5EvYsUbUzvXIV4f0lZLmaHEQpTTFwlz2tQBhPQVQs6vId6/NcTIbYP7oY+KFaexJ1T7L7NQCd/LF5+abZP42rHsN/ZLzdmo8RUOnZW4ghIU7pwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149165; c=relaxed/simple;
	bh=gFHujCPhXxiKRFVHgKtx1CZM8LTurcNBRJLLjFO5tro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EKNYEGh9Sze/hFVvsjLKReBuUlTZ4iCId6R/uWpFS5J/a+LhG0oRmKA9mucyplaH9/5rNLr+L0sstdC8XOWdkWbDrmLn9tnceEoUzyf9jxRWkD0f3X8XBpN2dNNspWEjyX9VRmKCSyRdF8mf3o0uS9GBZOC5VZBd4YnMTtVQ3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJjVfSii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA20C433F1;
	Wed, 28 Feb 2024 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709149165;
	bh=gFHujCPhXxiKRFVHgKtx1CZM8LTurcNBRJLLjFO5tro=;
	h=Date:From:To:Cc:Subject:From;
	b=JJjVfSiiEwXxcn1BwJ/l6j32/p53Yb5rJKllPhc6i1rXgHPREu0NZAPMWNmxgrbHN
	 wf1E0qX7PIFErQGr0CkPS9PygeNtGKdCt4pbA5NwdIoDm4We7N9vhjPq1JLx/uQpdV
	 EZU6coEAxmr1GkBbl+OBVVpnNhSuJV7XJbmMphcGoL6rYy2BChnX1d3jD5QDVWwoz/
	 0WWNNQDM61QH2ibJ5GBnFyRr+zTsxxy2PnwMOPWDywJ7Vp3fI7coi/eMdtMNgBCU/X
	 h16sD+UMqdTRq+rnlH+Q+4ni4Bqld6uxQgkNgYPgRwqBi7fXQ/mZpdSCSdesY9SLT4
	 6EaAPLl/DoCxw==
Date: Wed, 28 Feb 2024 16:39:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Jan Engelhardt <jengelh@inai.de>,
	Domenico Andreoli <domenico.andreoli@linux.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Viktor Malik <vmalik@redhat.com>,
	Eduard Zingerman <eddyz87@gmail.com>, J B <jb.1234abcd@gmail.com>
Subject: ANNOUNCE: pahole v1.26 (more holes, --bpf_features, --contains_enum)
Message-ID: <YbC5MC+h+PkDZten@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

Hi,
 
	The v1.26 release of pahole and its friends is out, showing more
holes (the ones in contained types) the ability to express the BTF
features to encode, to simplify the addition of new BTF features in the
Linux kernel build infrastructure, a way to find the enumeration with
some enumerator and various fixes.

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.sign

	Thanks a lot to all the contributors and distro packagers, you're on the
CC list, I appreciate a lot the work you put into these tools,

Best Regards,

- Arnaldo

pahole:

- When expanding types using 'pahole -E' do it for union and struct typedefs and for enums too.

  E.g: that 'state' field in 'struct module':

    $ pahole module | head
    struct module {
            enum module_state          state;                /*     0     4 */

            /* XXX 4 bytes hole, try to pack */

            struct list_head           list;                 /*     8    16 */
            char                       name[56];             /*    24    56 */
            /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
            struct module_kobject      mkobj;                /*    80    96 */
            /* --- cacheline 2 boundary (128 bytes) was 48 bytes ago --- */
    $

  now gets expanded:

    $ pahole -E module | head
    struct module {
            enum module_state {
                    MODULE_STATE_LIVE     = 0,
                    MODULE_STATE_COMING   = 1,
                    MODULE_STATE_GOING    = 2,
                    MODULE_STATE_UNFORMED = 3,
            } state; /*     0     4 */

            /* XXX 4 bytes hole, try to pack */

    $

- Print number of holes, bit holes and bit paddings in class member types.

  Doing this recursively to show how much waste a complex data structure has
  is something that still needs to be done, there were the low hanging fruits
  on the path to having that feature.

  For instance, for 'struct task_struct' in the Linux kernel we get this
  extra info:

    --- task_struct.before.c      2024-02-09 11:38:39.249638750 -0300
    +++ task_struct.after.c       2024-02-09 16:19:34.221134835 -0300
    @@ -29,6 +29,12 @@

          /* --- cacheline 2 boundary (128 bytes) --- */
          struct sched_entity        se;                   /*   128   256 */
    +
    +     /* XXX last struct has 3 holes */
    +
          /* --- cacheline 6 boundary (384 bytes) --- */
          struct sched_rt_entity     rt;                   /*   384    48 */
          struct sched_dl_entity     dl;                   /*   432   224 */
    +
    +       /* XXX last struct has 1 bit hole */
    +
          /* --- cacheline 10 boundary (640 bytes) was 16 bytes ago --- */
          const struct sched_class  * sched_class;         /*   656     8 */
          struct rb_node             core_node;            /*   664    24 */
    @@ -100,6 +103,9 @@
          /* --- cacheline 35 boundary (2240 bytes) was 16 bytes ago --- */
          struct list_head           tasks;                /*  2256    16 */
          struct plist_node          pushable_tasks;       /*  2272    40 */
    +
    +     /* XXX last struct has 1 hole */
    +
          /* --- cacheline 36 boundary (2304 bytes) was 8 bytes ago --- */
          struct rb_node             pushable_dl_tasks;    /*  2312    24 */
          struct mm_struct *         mm;                   /*  2336     8 */
    @@ -172,6 +178,9 @@
          /* XXX last struct has 4 bytes of padding */

          struct vtime               vtime;                /*  2744    48 */
    +
    +     /* XXX last struct has 1 hole */
    +
          /* --- cacheline 43 boundary (2752 bytes) was 40 bytes ago --- */
          atomic_t                   tick_dep_mask;        /*  2792     4 */

    @@ -396,9 +405,12 @@
          /* --- cacheline 145 boundary (9280 bytes) --- */
          struct thread_struct       thread __attribute__((__aligned__(64))); /*  9280  4416 */

    +       /* XXX last struct has 1 hole, 1 bit hole */
    +
          /* size: 13696, cachelines: 214, members: 262 */
          /* sum members: 13518, holes: 21, sum holes: 162 */
          /* sum bitfield members: 82 bits, bit holes: 2, sum bit holes: 46 bits */
          /* member types with holes: 4, total: 6, bit holes: 2, total: 2 */
          /* paddings: 6, sum paddings: 49 */
          /* forced alignments: 2, forced holes: 2, sum forced holes: 88 */
     };

- Introduce --contains_enumerator=ENUMERATOR_NAME:

  E.g.:

      $ pahole --contains_enumerator S_VERSION
      enum file_time_flags {
             S_ATIME   = 1,
             S_MTIME   = 2,
             S_CTIME   = 4,
             S_VERSION = 8,
      }
      $

  The shorter form --contains_enum is also accepted.

- Fix pretty printing when using DWARF, where sometimes the class (-C) and a specified "type_enum",
  may not be present on the same CU, so wait till both are found.

  Now this example that reads the 'struct perf_event_header' and 'enum perf_event_type'
  from the DWARF info in ~/bin/perf to pretty print records in the perf.data file works
  just like when using type info from BTF in ~/bin/perf:

      $ pahole -F dwarf -V ~/bin/perf \
                --header=perf_file_header \
                --seek_bytes '$header.data.offset' \
                --size_bytes='$header.data.size' \
                -C 'perf_event_header(sizeof,type,type_enum=perf_event_type,filter=type==PERF_RECORD_MMAP2)' \
                --prettify perf.data --count 1
      pahole: sizeof_operator for 'perf_event_header' is 'size'
      pahole: type member for 'perf_event_header' is 'type'
      pahole: type enum for 'perf_event_header' is 'perf_event_type'
      pahole: filter for 'perf_event_header' is 'type==PERF_RECORD_MMAP2'
      pahole: seek bytes evaluated from --seek_bytes=$header.data.offset is 0x3f0
      pahole: size bytes evaluated from --size_bytes=$header.data.size is 0xd10
      // type=perf_event_header, offset=0xc20, sizeof=8, real_sizeof=112
      {
            .header = {
                    .type = PERF_RECORD_MMAP2,
                    .misc = 2,
                    .size = 112,
            },
            .pid = 1533617,
            .tid = 1533617,
            .start = 94667542700032,
            .len = 90112,
            .pgoff = 16384,{
                    .maj = 0,
                    .min = 33,
                    .ino = 35914923,
                    .ino_generation = 26870,
            },{
                    .build_id_size = 0,
                    .__reserved_1 = 0,
                    .__reserved_2 = 0,
                    .build_id = { 33, 0, 0, 0, -85, 4, 36, 2, 0, 0, 0, 0, -10, 104, 0, 0, 0, 0, 0, 0 },
            },
            .prot = 5,
            .flags = 2,
            .filename = "/usr/bin/ls",
      },
      $

DWARF loader:

- Add support for DW_TAG_constant, first seen in Go DWARF.

- Fix loading DW_TAG_subroutine_type generated by the Go compiler, where it may
  have a DW_AT_byte_size. Go DWARF. And pretty print it as if
  it was from C, this helped in writing BPF programs to attach to Go binaries, using
  uprobes.

BTF loader:

- Fix loading of 32-bit signed enums.

BTF encoder:

- Add 'pahole --btf_features' to allow consumers to specify an opt-in set of
  features they want to use in BTF encoding.

  Supported features are a comma-separated combination of

          encode_force    Ignore invalid symbols when encoding BTF.
          var             Encode variables using BTF_KIND_VAR in BTF.
          float           Encode floating-point types in BTF.
          decl_tag        Encode declaration tags using BTF_KIND_DECL_TAG.
          type_tag        Encode type tags using BTF_KIND_TYPE_TAG.
          enum64          Encode enum64 values with BTF_KIND_ENUM64.
          optimized_func  Encode representations of optimized functions
                          with suffixes like ".isra.0" etc
          consistent_func Avoid encoding inconsistent static functions.
                          These occur when a parameter is optimized out
                          in some CUs and not others, or when the same
                          function name has inconsistent BTF descriptions
                          in different CUs.

  Specifying "--btf_features=all" is the equivalent to setting all of the
  above.  If pahole does not know about a feature specified in
  --btf_features it silently ignores it.

  The --btf_features can either be specified via a single comma-separated
  list
          --btf_features=enum64,float

  ...or via multiple --btf_features values

          --btf_features=enum64 --btf_features=float

  These properties allow us to use the --btf_features option in the kernel
  scripts/pahole_flags.sh script to specify the desired set of BTF
  features.

  If a feature named in --btf_features is not present in the version of
  pahole used, BTF encoding will not complain.  This is desired because it
  means we no longer have to tie new features to a specific pahole
  version.

  Use --btf_features_strict to change that behaviour and bail out if one of
  the requested features isn't present.

  To see the supported features, use:

    $ pahole --supported_btf_features
    encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func
    $

btfdiff:

- Parallelize loading BTF and DWARF, speeding up a bit.

- Do type expansion to cover "private" types and enumerations.

