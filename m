Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C09529D91
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 11:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiEQJL6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiEQJKn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 05:10:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B4529E
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 02:10:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B95BB67373; Tue, 17 May 2022 11:10:11 +0200 (CEST)
Date:   Tue, 17 May 2022 11:10:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "Harris, James R" <james.r.harris@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Thaler <dthaler@microsoft.com>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Joe Stringer <joe@cilium.io>
Subject: Re: LSF/MM session: eBPF standardization
Message-ID: <20220517091011.GA18723@lst.de>
References: <20220503140449.GA22470@lst.de> <20220510081657.GA12910@lst.de> <CAADnVQKBbh6T0-cs0WB2bsapg0wbb9Zu1az==CHD19sxeD5o_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKBbh6T0-cs0WB2bsapg0wbb9Zu1az==CHD19sxeD5o_g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 07:39:34PM -0700, Alexei Starovoitov wrote:
> Turns out that clang -mcpu=v1,v2,v3 are not exactly correct.
> We've extended ISA more than three times.
> For example when we added more atomics insns in
> https://lore.kernel.org/bpf/20210114181751.768687-1-jackmanb@google.com/
> 
> The corresponding llvm diff didn't add a new -mcpu flavor.
> There was no need to do it.

.. because all uses of these new instructions are through builtins
that wouldn't other be available, yes.

> Also llvm flags can turn a subset of insns on and off.
> Like llvm can turn on alu32, but without <,<= insns.
> -mcpu=v3 includes both. -mcpu=v2 are only <,<=.
> 
> So we need a plan B.

Yes.

> How about using the commit sha where support was added to the verifier
> as a 'version' of the ISA ?
> 
> We can try to use a kernel version, but backports
> will ruin that picture.
> Looks like upstream 'commit sha' is the only stable number.

Using kernel release hashes is a pretty horrible interface, especially
for non-kernel users.  I also think the compilers and other tools
would really like some vaguely meaninfuly identifiers.

> Another approach would be to declare the current ISA as
> 1.0 (or bpf-isa-may-2022) and
> in the future bump it with every new insn.

I think that is a much more reasonable starting position.  However, are
we sure the ISA actually evolves linearly?  As far as I can tell support
for full atomics only exists for a few JITs so far.

So maybe starting with a basedline, and then just have name for
each meaningful extension (e.g. the full atomics as a start) might be
even better.  For the Linux kernel case we can then also have a user
interface where userspace programs can query which extensions are
supported before loading eBPF programs that rely on them instead of
doing a roundtrip through the verifier.

> >  - we need to decide to do about the legacy BPF packet access
> >    instrutions.  Alexei mentioned that the modern JIT doesn't
> >    even use those internally any more.
> 
> I think we need to document them as supported in the linux kernel,
> but deprecated in general.
> The standard might say "implementation defined" meaning that
> different run-times don't have to support them.

Yeah.  If we do the extensions proposal above we could make these
a specific extension as well.

> [...]
> I don't think it's worth documenting all that.
> I would group all undefined/underflow/overflow as implementation
> defined and document only things that matter.

Makese sense.

> > Discussion on where to host a definitive version of the document:
> >
> >  - I think the rough consensus is to just host regular (hopefully
> >    low cadence) documents and maybe the latest gratest at a eBPF
> >    foundation website.  Whom do we need to work with at the fundation
> >    to make this happen?
> 
> foundation folks cc-ed.

I'd be rally glad if we could kick off this ASAP.  Feel free to contact
me privately if we want to keep it off the list.

> >  - as idea it was brought up to write a doument with the minimal
> >    verification requirements required for any eBPF implementation
> >    independent of the program type.  Again I can volunteer to
> >    draft a documentation, but I need input on what such a consensus
> >    would be.  In this case input from the non-Linux verifier
> >    implementors (I only know the Microsoft research one) would
> >    be very helpful as well.
> 
> The verifier is a moving target.

Absolutely.

> I'd say minimal verification is the one that checks that:
> - instructions are formed correctly
> - opcode is valid
> - no reserved bits are used
> - registers are within range (r11+ are not used)
> - combination of opcode+regs+off+imm is valid
> - simple things like that

Sounds good.  One useful thing for this would be an opcode table
with all the optional field usage in machine readable format.

Jim who is on CC has already built a nice table off all opcodes based
on existing material that might be a good starting point.
