Return-Path: <bpf+bounces-26321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E2E89E3FF
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28E71F212C5
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2D158205;
	Tue,  9 Apr 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fynft/bD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE7157E9F;
	Tue,  9 Apr 2024 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692641; cv=none; b=emfuSiIV7VA6/fx48Dh0tMOU8iPXwIiKLrguAtykIGykM8ig1BWQf7o+zrLqfbAkKWUvHmqvhCn8HwEFtSpZLk7JGWFS+3bP3KNC2WDA/2KsNOL+ij0B+jTGl19jO4cyIEmaPOC0+IKoRbp0pX3q6tjk9PmhDhw1tbgAZ5Sgfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692641; c=relaxed/simple;
	bh=vgFGRfe+ULBd+BBGQV7nLcml8meckTIDiJZ9FgZUWyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9/NbCU2qJfhKMA2SyOgyGWJ21ylWR7gvU6uysCENtcxKWBerj5LPDwHeEGc+kHpKD6Gog3mqPQN7na2NJ4KCfrdaWAXHxx2NooIE6gg++FLDjxday2OzzESJ8pT1muHjrYT07mSagXGnBx8ZOfC3aSpvvDZH4diOVL9CLj5MSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fynft/bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7969EC43601;
	Tue,  9 Apr 2024 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712692640;
	bh=vgFGRfe+ULBd+BBGQV7nLcml8meckTIDiJZ9FgZUWyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fynft/bDC8a5cT1kpFmFPlQHMlm/Y8uiA4k/1rVPwdWg+T7YeyA/st4y7cse6qAEB
	 RFSZbS7MnAru04XPnZIREOq6GqPfbNkjPd+PQzAkLhACnIgRWRZ47PMyKw5Z/AXeRu
	 BK8IAydHDa13gsLM1/Va0s5pfZv0CPjc8vwrAkNgjgrID5NoT8xxQQmEDUYIjM/JOi
	 s3PdDtdiTySXYcYFnHuJzpl0gZuN3f3RAo+5advobVGug6UqBHaJa/3/ET4Ff37+al
	 20iqhwm2YwRhJp04JsW5cd84AxXj05ADSQiL3QWRMD33MzWsnlonWU0cIiIERUTnmA
	 NPV+hO7OlVYtQ==
Date: Tue, 9 Apr 2024 16:57:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf <bpf@vger.kernel.org>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <ZhWdneZRZrHg-kZ4@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
 <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
 <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>
 <ZhWMxu8Xq1oAUAoC@x1>
 <1314495ccf0d31babf408eb539fa2eba70e404a0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314495ccf0d31babf408eb539fa2eba70e404a0.camel@gmail.com>

On Tue, Apr 09, 2024 at 10:29:18PM +0300, Eduard Zingerman wrote:
> On Tue, 2024-04-09 at 15:45 -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 09, 2024 at 06:01:08PM +0300, Eduard Zingerman wrote:
> > > On Tue, 2024-04-09 at 07:56 -0700, Alexei Starovoitov wrote:
> > > [...]
> >  
> > > > I would actually go with sorted BTF, since it will probably
> > > > make diff-ing of BTFs practical. Will be easier to track changes
> > 
> > What kind of diff-ing of BTFs from different kernels are you interested
> > in?
> > 
> > in pahole's repository we have btfdiff, that will, given a vmlinux with
> > both DWARF and BTF use pahole to pretty print all types, expanded, and
> > then compare the two outputs, which should produce the same results from
> > BTF and DWARF. Ditto for DWARF from a vmlinux compared to a detached BTF
> > file.
> > 
> > And also now we have another regression test script that will produce
> > the output from 'btftool btf dump' for the BTF generated from DWARF in
> > serial mode, and then compare that with the output from 'bpftool btf
> > dump' for reproducible encodings done using -j 1 ...
> > number-of-processors-on-the-machine. All have to match, all types, all
> > BTF ids.
> > 
> > We can as well use something like btfdiff to compare the output from
> > 'pahole --expand_types --sort' for two BTFs for two different kernels,
> > to see what are the new types and the changes to types in both.
> > 
> > What else do you want to compare? To be able to match we would have to
> > somehow have ranges for each DWARF CU so that when encoding and then
> > deduplicating we would have space in the ID space for new types to fill
> > in while keeping the old types IDs matching the same types in the new
> > vmlinux.
> 
> As far as I understand Alexei, he means diffing two vmlinux.h files
> generated for different kernel versions. The vmlinux.h is generated by
> bpftool using command `bpftool btf dump file <binary-file> format c`.
> The output is topologically sorted to satisfy C compiler, but ordering
> is not total, so vmlinux.h content may vary from build to build if BTF
> type order differs.
> 
> Thus, any kind of stable BTF type ordering would make vmlinux.h stable.
> On the other hand, topological ordering used by bpftool
> (the algorithm is in the libbpf, actually) might be extended with
> additional rules to make the ordering total.

Interesting, the other tool that is in the pahole repo is 'fullcircle',
that given a .o file will generate a compileable file (a vmlinux.h say)
and then build it again to generate DWARF and then compare the original
DWARF with the new onbe.
 
> > While ordering all types we would have to have ID space available from
> > each of the BTF kinds, no?
> > 
> > I haven't looked at Eduard's patches, is that what it is done?
> 
> No, I don't reserve any ID space, the output of 
> `bpftool btf dump file <binary-file> format raw` is not suitable for
> diffing w/o post-processing if some types are added or removed in the
> middle.
 
> I simply add a function to compare two BTF types and a pass that sorts
> all BTF types before finalizing BTF generation.

Ok, so I see that the BTF ids for the types will change, its the
vmlinux.h that is to be compared.

root@x1:~# pahole -F btf --compile | tail -12
struct ncsi_aen_handler {
	unsigned char              type;                 /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        payload;              /*     4     4 */
	int                        (*handler)(struct ncsi_dev_priv *, struct ncsi_aen_pkt_hdr *); /*     8     8 */

	/* size: 16, cachelines: 1, members: 3 */
	/* sum members: 13, holes: 1, sum holes: 3 */
	/* last cacheline: 16 bytes */
};
root@x1:~# pahole -F btf --compile > a.c ; echo 'int main(void) { struct ncsi_aen_handler b = { 1, } ; return b.type ; } ' >> a.c ; gcc -g -o bla -c a.c
root@x1:~# pahole --expand_types ncsi_aen_handler > from_kernel_btf
root@x1:~# pahole --expand_types -C ncsi_aen_handler bla > from_bla_dwarf
root@x1:~# diff -u from_kernel_btf from_bla_dwarf
root@x1:~#

The above is for a super simple struct, no expansions even, now for:

root@x1:~# pahole -F btf --compile > a.c ; echo 'int main(void) { struct task_struct b = { .prio = 12345, } ; return b.prio ; } ' >> a.c ; gcc -g -o bla -c a.c
root@x1:~# pahole --suppress_aligned_attribute --expand_types -C task_struct bla > from_bla_dwarf
root@x1:~# pahole --suppress_aligned_attribute --expand_types task_struct > from_kernel_btf
root@x1:~# diff -u from_kernel_btf from_bla_dwarf
root@x1:~#

I suppressed the align attribute as right now the output from pahole
when it finds the __attribute__ alignment present in DWARF is slightly
different, but equivalent (barring bugs) to when it infers the alignment
and adds it to BTF data, that has no alignment info other than the
member offsets (DWARF has both the member offsets to infer the alignment
_and_ attributes when they are present in the source code, sometimes
even duplicated, which probably is the reason for the difference in
output (albeit the end result should be equivalent)).

root@x1:~# pahole --expand_types task_struct | wc -l
1254
root@x1:~# pahole --expand_types task_struct | tail
	/* XXX last struct has 1 hole, 1 bit hole */

	/* size: 13696, cachelines: 214, members: 265 */
	/* sum members: 13522, holes: 20, sum holes: 158 */
	/* sum bitfield members: 83 bits, bit holes: 2, sum bit holes: 45 bits */
	/* member types with holes: 4, total: 6, bit holes: 2, total: 2 */
	/* paddings: 6, sum paddings: 49 */
	/* forced alignments: 2, forced holes: 2, sum forced holes: 88 */
};

root@x1:~#

I.e. the original BTF doesn't have to be sorted (well, it will keep the
order DWARF does, which, in turn, is another desire of reproducible
builds, it will not have the same output for two kernel releases, but
should be as close as possible) pahole (--sort or --compile) or bpftool
can do it either by plain sorting the types (pahole --sort, used by
btfdiff to compara output from DWARF to output from BTF) or by
generating a compilable source code (pahole --compile, aka
"topologically sorted to satisfy C compiler").
 
> > > > from one kernel version to another. vmlinux.h will become
> > > > a bit more sorted too and normal diff vmlinux_6_1.h vmlinux_6_2.h
> > > > will be possible.
> > > > Or am I misunderstanding the sorting concept?
  
> > > You understand the concept correctly, here is a sample:
  
> > >   [1] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
> > >   [2] INT '__int128' size=16 bits_offset=0 nr_bits=128 encoding=SIGNED
> > >   [3] INT '__int128 unsigned' size=16 bits_offset=0 nr_bits=128 encoding=(none)
> > >   [4] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
> > >   [5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> > >   [6] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> > >   [7] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED

> > The above: so far so good, probably there will not be something that
> > will push what is now BTF id 6 to become 7 in a new vmlinux, but can we
> > say the same for the more dynamic parts, like the list of structs?
 
> > A struct can vanish, that abstraction not being used anymore in the
> > kernel, so its BTF id will vacate and all of the next struct IDs will
> > "fall down" and gets its IDs decremented, no?
 
> Yes, this would happen.

We're on the same page.

> > If these difficulties are present as I mentioned, then rebuilding from
> > the BTF data with something like the existing 'pahole --expand_types
> > --sort' from the BTF from kernel N to compare with the same output for
> > kernel N + 1 should be enough to see what changed from one kernel to the
> > next one?
 
> Yes, this is an option.

Agreed. What I tried in my series was to do as little as possible to
make the serial output be the same as whatever level of paralelism we
have while making the whole process to cost as close to the
unconstrained parallelism that we had in place, i.e. to get a
reproducible build at the lowest cost in terms of code churn (the more
code we touch, the more chances we have of new bugs to be introduced)
and of CPU cycles/memory use, etc.

- Arnaldo

