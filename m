Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1D41A0E8
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhI0VAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 17:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236800AbhI0VAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 17:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 285DB60F41;
        Mon, 27 Sep 2021 20:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632776355;
        bh=J9GwwOqbDTb3GFzzouVtkGrRIyt3XCZwvORUUDmymuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUNFBzor5T7UYGvrP5XofBZkpf+gJQ8iOPWznVreV5s9wtTFEJLfNn/kvPC3yWoCx
         wy8Oec8BuHq3yZQWXty/TfGsI7AGLDSnXJiImgergt9M596dNXx1YLCruj2Oo70lRy
         IL/Nmj+W15uiyxYKFGRbF6ngFUTGnbqndycF64/RrtWi0rRYx5jUXNuI3tGLLEXimZ
         qGYPEF0EOJOyrUuiY+r+1S4eGZhXOO6AXwUQ7nvvOW1T3KBaglht30/n5XZ+b+nYJH
         PGuW3sNYy1LnIuIUf/37q3vodtsfj8riSgRH57zy0SNTcZ2si0QPEY/l0gkVQ/I8nU
         YJJlT+xQjX2gg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BD29410A1; Mon, 27 Sep 2021 17:59:12 -0300 (-03)
Date:   Mon, 27 Sep 2021 17:59:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 0/2] generate BTF_KIND_TAG types from
 DW_TAG_LLVM_annotation dwarf tags
Message-ID: <YVIwoJHMd0gkRf2O@kernel.org>
References: <20210922021321.2286360-1-yhs@fb.com>
 <YVIsKZTWlDugv3Yz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVIsKZTWlDugv3Yz@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Sep 27, 2021 at 05:40:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 21, 2021 at 07:13:21PM -0700, Yonghong Song escreveu:
> > LLVM has implemented btf_tag attribute ([1]) which intended
> > to provide a "string" tag for struct/union or its member, var,
> > a func or its parameter. Such a "string" tag will be encoded
> > in dwarf. For non-BPF target like x86_64, pahole needs to
> > convert those dwarf btf_tag annotations to BTF so kernel
> > can utilize these "string" tags for bpf program verification, etc.
> >         
> > Patch 1 enhanced dwarf_loader to encode DW_TAG_LLVM_annotation
> > tags into internal data structure and Patch 2 will encode
> > such information to BTF with BTF_KIND_TAGs.
> > 
> >  [1] https://reviews.llvm.org/D106614
> 
> Applied both locally, now building HEAD llvm/clang to test everything,

⬢[acme@toolbox pahole]$ pahole -JV t.o
Found per-CPU symbol 'g' at address 0x0
Found 1 per-CPU variables!
Found 1 functions!
File t.o:
[1] INT int size=4 nr_bits=32 encoding=SIGNED
[2] PTR (anon) type_id=3
[3] STRUCT t size=8
	a type_id=1 bitfield_size=1 bits_offset=0
	b type_id=1 bitfield_size=0 bits_offset=32
[4] TAG tag1 type_id=3 component_idx=0
[5] TAG tag2 type_id=3 component_idx=1
[6] TAG tag1 type_id=3 component_idx=-1
[7] TAG tag2 type_id=3 component_idx=-1
[8] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
[9] FUNC foo type_id=8
[10] TAG tag2 type_id=9 component_idx=1
[11] TAG tag1 type_id=9 component_idx=-1
search cu 't.c' for percpu global variables.
Variable 'g' from CU 't.c' at address 0x0 encoded
[12] VAR g type=1 linkage=1
[13] TAG tag1 type_id=12 component_idx=-1
[14] DATASEC .data..percpu size=4 vlen=1
	type=12 offset=0 size=4
⬢[acme@toolbox pahole]$ pahole -JV --skip_encoding_btf_tag t.o
Found per-CPU symbol 'g' at address 0x0
Found 1 per-CPU variables!
Found 1 functions!
File t.o:
[1] INT int size=4 nr_bits=32 encoding=SIGNED
[2] PTR (anon) type_id=3
[3] STRUCT t size=8
	a type_id=1 bitfield_size=1 bits_offset=0
	b type_id=1 bitfield_size=0 bits_offset=32
[4] FUNC_PROTO (anon) return=1 args=(2 a1, 1 a2)
[5] FUNC foo type_id=4
search cu 't.c' for percpu global variables.
Variable 'g' from CU 't.c' at address 0x0 encoded
[6] VAR g type=1 linkage=1
[7] DATASEC .data..percpu size=4 vlen=1
	type=6 offset=0 size=4
⬢[acme@toolbox pahole]$ clang -v
clang version 14.0.0 (https://github.com/llvm/llvm-project f7e82e4fa849376ea9226220847a098dc92d74a0)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/11
Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/11
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
⬢[acme@toolbox pahole]$

And the usual:

⬢[acme@toolbox pahole]$ pahole -J vmlinux
⬢[acme@toolbox pahole]$ btfdiff vmlinux
⬢[acme@toolbox pahole]$

So applied, pushing out to the tmp.master branch so that libbpf's CI can
have a go at it, then after the next run I'll push to master, thanks!

- Arnaldo
