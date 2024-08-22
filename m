Return-Path: <bpf+bounces-37870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4695BA00
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD80B227D6
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4F1C9ED9;
	Thu, 22 Aug 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv1OfbBx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C62D05E;
	Thu, 22 Aug 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340252; cv=none; b=eDSHNgscMoXUC0LbTLAFuQZ49I4h8K32bLJm5MO/sX2llD0i/s4pTjn4O1UQN246Etnql5t31TEDysNst0FIM8pga4G86fEhGFQkRq/BhRRsGcd0ucJlIsAz/kpVidJagFPNvBbtrX+8H8/krOcR4hmYezlj34Oewc/ViqLpTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340252; c=relaxed/simple;
	bh=4LZv/BJEoWC8UWgNZTx9Z6qebcb3bzk7+S9DRJe0KRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD+vtU817s3afGHq9D65Lx9/ntwbPv7Mfi/gNYf9BIO5ZetTZKwYMoX0GmkBjGnr0OGId52nyuJjaqwMhbs13vKbnq1x5KWPdkuRtJlYk2cSxXxKEanmXpUMAYBCV2aOHARIZbvT0wf3DKz+eseCS/tdo/k9qQFJgCVZDosZRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv1OfbBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22CBC4AF0B;
	Thu, 22 Aug 2024 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724340252;
	bh=4LZv/BJEoWC8UWgNZTx9Z6qebcb3bzk7+S9DRJe0KRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv1OfbBxvfhc1+e1mTkfSZr6W01Xh0MIcH5EsMZX0S/YKyCEVHR816ZY15YvdHLfK
	 fie9Xqjo81HD5t7Af7/hkve/4WqnzJ6dfZUZ04wCRS3vIwkkqad+/EIIKxLHj17x28
	 sGj0Khj9CH5i1CJlz34y7vLt3AXqq39EWRa0DY3Iu2N1FxeXK6rSMH8cWoQQY49o4X
	 LBbzpmMQ2uPfCFQQTThmKpB0t7IcmQc3HaB6b0mTRJaLZRkGHO7OrNsxu4JaulLvd9
	 LKdEx7zbNQaXNv4GTfHZYN5ULPwV/RAMVSxBU2fn5BNDoRcWeiwIZfe+lj02Ie4PU6
	 ggk8gtV4KOcSQ==
Date: Thu, 22 Aug 2024 12:24:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: dwarves@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <ZsdYGOS7Yg9pS2BJ@x1>
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>

On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> (Add pahole maintainer and mailing list)
> 
> Hi Arnaldo,
> 
> We're running into kernel build failure on 32-bit (both full 32-bit and
> 32-bit userspace on 64-bit kernel) because pahole crashed due to virtual
> memory exhaustion[1]. As a workaround we currently limit pahole's
> parallel job count to 1 on such system[2]:
> 
> On Tue, 20 Aug 2024 10:59:50AM +0200, Jiri Slaby wrote:
> [...]
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index b75f09f3f424..f7de8e922bce 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -12,7 +12,9 @@ endif
> >  
> >  pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
> >  
> > +ifeq ($(CONFIG_PAHOLE_CLASS),ELF64)
> >  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> > +endif
> >  
> >  pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> >  
> > diff --git a/scripts/pahole-class.sh b/scripts/pahole-class.sh
> > new file mode 100644
> > index 000000000000..d15a92077f76
> > --- /dev/null
> > +++ b/scripts/pahole-class.sh
> > @@ -0,0 +1,21 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Usage: $ ./pahole-class.sh pahole
> > +#
> > +# Prints pahole's ELF class, such as ELF64
> > +
> > +if [ ! -x "$(command -v "$@")" ]; then
> > +	echo 0
> > +	exit 1
> > +fi
> > +
> > +PAHOLE="$(which "$@")"
> > +CLASS="$(readelf -h "$PAHOLE" 2>/dev/null | sed -n 's/.*Class: *// p')"
> > +
> > +# Scripts like scripts/dummy-tools/pahole
> > +if [ -n "$CLASS" ]; then
> > +	echo "$CLASS"
> > +else
> > +	echo ELF64
> > +fi
> > -- 
> 
> This helped lowered the memory usage enough so pahole no longer crash:
> 
> On Wed, Aug 21, 2024 at 09:29:57AM GMT, Jiri Slaby wrote:
> > On 21. 08. 24, 8:40, Jiri Slaby wrote:
> > >  From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c20:
> > > Run on 64bit:
> > > pahole -j32 -> 4.102 GB
> > > pahole -j16 -> 3.895 GB
> > > pahole -j1 -> 3.706 GB
> > > 
> > > On 32bit (the same vmlinux):
> > > pahole -j32 -> 2.870 GB (crash)
> > > pahole -j16 -> 2.810 GB
> > > pahole -j1 -> 2.444 GB
> 
> Jiri (Slaby) in the meanwhile has also proposed structure packing to
> further reduce memory usage. (Note: I think the numbers below are from a
> 64-bit machine)

That is interesting, packing pahole data structures ;-) :-)

Also a coincidence is that I did some packing on what is in the next
branch:

3ef508ad94012933 dwarf_loader: Make 'struct dwarf_tag' more compact by getting rid of 'struct dwarf_off_ref
70febc8858588348 core: Reorganize 'struct class_member' to save 8 bytes
76bcb88a67556468 core: Make tag->recursivity_level a uint8_t
b8b9e04d177d8eb7 core: Make tag->top_level a single bit flag
539acefcdd5b0f71 core: Make tag->has_btf_type_tag a single bit flag
dba2c2c1aa5dfa05 core: Make tag->visited a single bit flag
7409cfadcae0253b core: Shrink 'struct namespace' a bit by using a hole in its embedded 'tag'

Also I did more work to reduce the number of allocations:

cbecc3785266f0c5 dwarf_loader: Do just one alloc for 'struct dwarf_tag + struct tag'

With it we get:

⬢[acme@toolbox pahole]$ pahole -C class_member build/libdwarves.so.1.0.0 
struct class_member {
	struct tag                 tag;                  /*     0    32 */

	/* XXX last struct has 1 bit hole */

	const char  *              name;                 /*    32     8 */
	uint32_t                   bit_offset;           /*    40     4 */
	uint32_t                   bit_size;             /*    44     4 */
	uint32_t                   byte_offset;          /*    48     4 */
	int                        hole;                 /*    52     4 */
	size_t                     byte_size;            /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int8_t                     bitfield_offset;      /*    64     1 */
	uint8_t                    bitfield_size;        /*    65     1 */
	uint8_t                    bit_hole;             /*    66     1 */
	uint8_t                    bitfield_end:1;       /*    67: 0  1 */
	uint8_t                    visited:1;            /*    67: 1  1 */
	uint8_t                    is_static:1;          /*    67: 2  1 */
	uint8_t                    has_bit_offset:1;     /*    67: 3  1 */
	uint8_t                    accessibility:2;      /*    67: 4  1 */
	uint8_t                    virtuality:2;         /*    67: 6  1 */
	uint32_t                   alignment;            /*    68     4 */
	uint64_t                   const_value;          /*    72     8 */

	/* size: 80, cachelines: 2, members: 18 */
	/* member types with bit holes: 1, total: 1 */
	/* last cacheline: 16 bytes */
};

⬢[acme@toolbox pahole]$

And also the dwarf_tag, that is allocated for each tag coming from DWARF
got smaller:

⬢[acme@toolbox pahole]$ pahole -C dwarf_tag build/libdwarves.so.1.0.0 
struct dwarf_tag {
	struct hlist_node          hash_node;            /*     0    16 */
	Dwarf_Off                  type;                 /*    16     8 */
	Dwarf_Off                  id;                   /*    24     8 */
	union {
		Dwarf_Off          abstract_origin;      /*    32     8 */
		Dwarf_Off          containing_type;      /*    32     8 */
	};                                               /*    32     8 */
	Dwarf_Off                  specification;        /*    40     8 */
	struct {
		_Bool              type:1;               /*    48: 0  1 */
		_Bool              abstract_origin:1;    /*    48: 1  1 */
		_Bool              containing_type:1;    /*    48: 2  1 */
		_Bool              specification:1;      /*    48: 3  1 */
	} from_types_section;                            /*    48     1 */

	/* XXX last struct has 4 bits of padding */
	/* XXX 1 byte hole, try to pack */

	uint16_t                   decl_line;            /*    50     2 */
	uint32_t                   small_id;             /*    52     4 */
	const char  *              decl_file;            /*    56     8 */

	/* size: 64, cachelines: 1, members: 9 */
	/* sum members: 63, holes: 1, sum holes: 1 */
	/* member types with bit paddings: 1, total: 4 bits */
};

⬢[acme@toolbox pahole]$

I stumbled on this limitation as well when trying to build the kernel on
a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
created a swapfile and it managed to proceed, a bit slowly, but worked
as well.

Please let me know if what is in the 'next' branch of:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Works for you, that will be extra motivation to move it to the master
branch and cut 1.28.

Thanks!

- Arnaldo
 
> > From https://bugzilla.suse.com/show_bug.cgi?id=1229450#c21:
> > (In reply to Jiri Slaby from comment #20)
> > > | |   |   ->24.01% (954,816,480B) 0x489B4AB: UnknownInlinedFun
> > (dwarf_loader.c:959)
> > 
> > So given this struct class_member is the largest consumer, running pahole on
> > pahole. The below results in 4.102 GB -> 3.585 GB savings.
> > 
> > --- a/dwarves.h
> > +++ b/dwarves.h
> > @@ -487,14 +487,14 @@ int cu__for_all_tags(struct cu *cu,
> >   */
> >  struct tag {
> >         struct list_head node;
> > +       const char       *attribute;
> > +       void             *priv;
> >         type_id_t        type;
> >         uint16_t         tag;
> > +       uint16_t         recursivity_level;
> >         bool             visited;
> >         bool             top_level;
> >         bool             has_btf_type_tag;
> > -       uint16_t         recursivity_level;
> > -       const char       *attribute;
> > -       void             *priv;
> >  };
> > 
> >  // To use with things like type->type_enum ==
> > perf_event_type+perf_user_event_type
> > @@ -1086,17 +1086,17 @@ static inline int function__inlined(const struct
> > function *func)
> >  struct class_member {
> >         struct tag       tag;
> >         const char       *name;
> > +       uint64_t         const_value;
> >         uint32_t         bit_offset;
> >         uint32_t         bit_size;
> >         uint32_t         byte_offset;
> >         int              hole;
> >         size_t           byte_size;
> > +       uint32_t         alignment;
> >         int8_t           bitfield_offset;
> >         uint8_t          bitfield_size;
> >         uint8_t          bit_hole;
> >         uint8_t          bitfield_end:1;
> > -       uint64_t         const_value;
> > -       uint32_t         alignment;
> >         uint8_t          visited:1;
> >         uint8_t          is_static:1;
> >         uint8_t          has_bit_offset:1;
> >--
> 
> What do you think?
> 
> IIUC pahole's memory usage is largely tied to the number of entries in
> vmlinux/kmodule DWARF, and there probably isn't much we could do about
> that.
> 
> Shung-Hsi
> 
> 1: https://bugzilla.suse.com/show_bug.cgi?id=1229450
> 2: https://lore.kernel.org/all/20240820085950.200358-1-jirislaby@kernel.org/

