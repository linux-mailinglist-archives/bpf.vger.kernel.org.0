Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D35295366
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505260AbgJUUP1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 16:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505114AbgJUUP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 16:15:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF13E2098B;
        Wed, 21 Oct 2020 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603311326;
        bh=lza32zk4geg5fIRx0MFlGMJDr6NBqZMi1MST+xv7P5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1Oob8WORq4yvRbq6p0rcvCHw9b1C+cZ9TeS47OYAiYCmwirX4hcfdkK/yLA/3jYC
         g9LfEv1TiD59BZpmRT7lQUH15Vfn1EoYYN19agjFEsDymV8R3fOlS1fgNi0gzRfMHl
         5Pc7Oqx5J0LMotVsXVSZ/KLGBGFLRaHe5oODaU9w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 195B4403C2; Wed, 21 Oct 2020 17:15:23 -0300 (-03)
Date:   Wed, 21 Oct 2020 17:15:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH dwarves] btf_loader: handle union forward declaration
 properly
Message-ID: <20201021201523.GA2385845@kernel.org>
References: <20201009192607.699835-1-andrii@kernel.org>
 <20201021192530.GS2342001@kernel.org>
 <CAEf4BzaCXKYOeyTN74Zm1gbjyBSmBCi1XpgvqKn8-E+ZusrGeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaCXKYOeyTN74Zm1gbjyBSmBCi1XpgvqKn8-E+ZusrGeA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Oct 21, 2020 at 12:47:30PM -0700, Andrii Nakryiko escreveu:
> On Wed, Oct 21, 2020 at 12:25 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > @@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
> > >
> > >  static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
> > >  {
> > > -     struct class *fwd = class__new(tp->name_off, 0);
> > > +     struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));
 
> *FACEPALM*... This should be btf_kflag(tp) instead. I'll use btfdiff
> on all my patches from now on, sorry about this!

:-)

I'll retest when you resubmit.

One other thing I like to use is 'fullcircle':


<SNIP>
# See how your DW_AT_producer looks like and find the
# right regexp to get after the GCC version string, this one
# seems good enough for Red Hat/Fedora/CentOS that look like:
#
#   DW_AT_producer    : (indirect string, offset: 0x3583): GNU C89 8.2.1 20181215 (Red Hat 8.2.1-6) -mno-sse -mno-mmx
#
# So we need from -mno-sse onwards

CFLAGS=$(readelf -wi $file | grep -w DW_AT_producer | sed -r      's/.*\)( -[[:alnum:]]+.*)+/\1/g')

# Check if we managed to do the sed or if this is something like GNU AS
[ "${CFLAGS/DW_AT_producer/}" != "${CFLAGS}" ] && exit

${pfunct_bin} --compile $file > $c_output
gcc $CFLAGS -c -g $c_output -o $o_output
${codiff_bin} -q -s $file $o_output
<SNIP>


$ pfunct --help |& grep compile
      --compile[=FUNCTION]   Generate compilable source code with types
$

It generates code for all functions in a .o that touch its parameters
and right before those functions it regenerates all the types, so you go
from type information to C code that gets compiled with the same
compiler command line setting (obtained from DW_AT_producer for DWARF)
with type information and then it compares the original type information
with the one generated from the regenerated "original" source code.

Right now it works only with DWARF, because for it we derive the packed
attribute (pahole does that for BTF too) but, unlike bpftool btf it
doesn't add the needed padding for __alignment__ things, and DWARF
provides that info.

I'll work on that eventually and then fullcircle will do it for both
DWARF and for BTF.

- Arnaldo
