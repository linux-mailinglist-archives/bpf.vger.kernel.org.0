Return-Path: <bpf+bounces-7734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598177BDC6
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A71328117C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653FC8E0;
	Mon, 14 Aug 2023 16:18:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A85C139
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 16:18:05 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487FA12E
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:18:03 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6418c1239c5so18431936d6.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692029882; x=1692634682;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6pghZcCVmSXG7aFJ1PmYcrKWfTMAcd8O51fDjdEqXY=;
        b=C7+H1FwyeEebLZ1mznGzgtACv8sJMwR/2Hf4Py6kGnHH35zzVGjo4o786ZrA4kDos4
         YF4kYtVuw0hu7BDgbibYPHBNPRTZArGepN/YDw6W8w1MxZCIYb2mnu8g4pXgFp9hHobt
         I+51rqIPZYu8x5XoibugU9WKVGpFhh6IMokViSsbnJN9YD4hwptW0Yqzf8OCSE+sycxs
         94qNc00iQ+96p6/0T9lJrANtx10hd6eqVNyKC+L36F86tGa6kWOsi6mCVTSHKffPqam9
         Xf2KMB1uDHcAPTjdWTQP8P/KcBDjhmh69gkcb5Fm8LtgXCK0orTtHgs6OZ0F9GRSlSzF
         VElg==
X-Gm-Message-State: AOJu0Yy7zCtU8b/+L/etiCrXXs0V/WQyio7gkwc1UTrMsiY1p7pwE6cK
	jP+gCaSQsNTuUfrrn6iSiRD5U0jZ1+CFlA==
X-Google-Smtp-Source: AGHT+IEBm0gaVL+UiqRDA2jxrKxIJgbxCGHDXvwhJcVLqJGJkPjzn/riy+kyyz70ZvQwcD47zJUKSA==
X-Received: by 2002:a0c:e1d3:0:b0:641:8cb7:b089 with SMTP id v19-20020a0ce1d3000000b006418cb7b089mr10995856qvl.27.1692029882104;
        Mon, 14 Aug 2023 09:18:02 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:93a1])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf084000000b006301d31e315sm3479721qvk.10.2023.08.14.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:18:01 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:17:59 -0500
From: David Vernet <void@manifault.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
Message-ID: <20230814161759.GF542801@maniforge>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge>
 <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 02:36:04PM -0700, Watson Ladd wrote:
> Dear David,

Hi Watson,

> Thank you very much for your lengthy and kind email. I agree that we

And thank you for offering your time and expertise as a reviewer of the
document.

> should punt on contentious points and aim to standardize what has
> already been implemented across a wide range of implementations. Most
> of my issues are with the format and presentation of the text, and I
> think the content changes it would take are pretty noncontenous. I

Ack, sounds good. Just FYI, I realize (and appreciate) that you are
fulfilling your role as a reviewer, as you offered to do at IETF117.
That said, even just as a reviewer, it can often be easier to discuss
proposed changes if there are accompanying patches which illustrate your
intent. For example, moving the Maps section further up the document,
etc. This is not strictly necessary, especially if you're just reviewing
the document, but I do think it would help to ground some of the
discussions. For what it's worth, this is more the "Linux kernel way",
but I'm not sure if this is the norm for IETF.

> don't really have any insight into what the content should be, and I'm
> sure that for those who live and breath BPF every day, much of what I
> am confused about is indeed obvious.

There is a difference between something being obvious and being well
specified, so your review is appreciated either way.

> Concretely I think the following would help improve the
> understandability of the document:
> * After the register paragraph, describe the memory. As I understand

Just FYI, we are going to be moving the register paragraph to a separate
ABI document, as it really belongs in an ABI (Informational) document
than a Proposed Standard for the ISA.

> it it is a 64 bit, byte addressed, flat space, and maps are just
> special regions in it. Maybe I'm wrong. There's some stuff about types
> in the big space of instructions that maybe makes me think I am wrong.

I think it's OK to specify that it's a 64 bit, byte addressed flat
space, so folks can feel free to submit a patch to that effect. My only
worry is that it may set a precedent that we'll have to explain a lot of
other architectural details in the ISA standard, where they don't really
belong. Take a look at how ARM [0] does this, for example. There is an
entirely separate document [1] on the AArch64 memory model, and for good
reason. It describes the hierarchical model of page tables on ARM, what
the memory model is when there's no MMU, how device memory works, etc.

[0]: https://www.arm.com/architecture/learn-the-architecture/a-profile
[1]: https://developer.arm.com/documentation/102376/latest/

So while I don't disagree that it should be non-controversial and would
help clarify the programming environment for the instructions, I want to
make sure that folks are OK with us adding this, but not necessarily
expounding on all of the details and implications. Hopefully this should
be fine, as it's been the norm for other ISAs (e.g. RISC-V) as well.

FWIW, I think this applies to maps as well. It's definitely something we
need to expand on at some point, but the possibility for scope creep is
high.

This is what's there now:

> =========================  ======  ===  =========================================  ===========  ==============
> opcode construction        opcode  src  pseudocode                                 imm type     dst type
> =========================  ======  ===  =========================================  ===========  ==============
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst = imm64                                integer      integer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst = map_by_fd(imm)                       map fd       map
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst = map_val(map_by_fd(imm)) + next_imm   map fd       data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst = var_addr(imm)                        variable id  data pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst = code_addr(imm)                       integer      code pointer
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst = map_by_idx(imm)                      map index    map
> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst = map_val(map_by_idx(imm)) + next_imm  map index    data pointer
> =========================  ======  ===  =========================================  ===========  ==============
>
> where
>
> * map_by_fd(imm) means to convert a 32-bit file descriptor into an address of a map (see `Maps`_)
> * map_by_idx(imm) means to convert a 32-bit index into an address of a map
> * map_val(map) gets the address of the first value in a given map
> * var_addr(imm) gets the address of a platform variable (see `Platform Variables`_) with a given id
> * code_addr(imm) gets the address of the instruction at a specified relative offset in number of (64-bit) instructions
> * the 'imm type' can be used by disassemblers for display
> * the 'dst type' can be used for verification and JIT compilation purposes
>
> Maps
> ~~~~
>
> Maps are shared memory regions accessible by eBPF programs on some
> platforms. A map can have various semantics as defined in a separate
> document, and may or may not have a single contiguous memory region,
> but the 'map_val(map)' is currently only defined for maps that do have
> a single contiguous memory region.

There are a lot of caveats here about the semantics of maps, whether
they do or don't have a contiguous memory region, etc. There likely
isn't a single definition of a "map memory region" that will apply to
all maps. For example, there is a BPF_MAP_TYPE_PERCPU_ARRAY map, which
in contrast with BPF_MAP_TYPE_ARRAY, need not be a contiguous memory
region and could instead leverage however percpu memory is implemented
on the platform. In my personal opinion, what Dave wrote here is rather
ideal in that it's giving the reader some context on what maps are,
without over prescribing them. With that in mind, are you ok with
leaving the maps section as is (modulo moving it as you suggested
below), with the intention being that we'll fill in the details on the
various types of cross-platform maps when we write the proposed standard
on cross-platform map types?

> * Say this is a 2's complement architecture

Hmmm, so, I realize that others have suggested this as well (e.g. Will
pointed out in [2] that he agrees that we should include this), but to
be honest I'm still not quite following why this is something that folks
feel should be included.

[2]: https://lore.kernel.org/all/CADx9qWiJCQyLdz5rG33K2iWtsgXQ65K3aiwQiEsjSwY2ofNy1Q@mail.gmail.com/

The RISC-V standard does indeed specify that signed types are
represented with two's complement, but as far as I know that is the
exception rather than the rule. As Jose explained in [3], it's more
common for ISA specifications to specify how numerical immediates are
encoded in stored instructions rather than dictating how signedness is
represented across the entire architecture.

[3]: https://lore.kernel.org/bpf/871qhe7des.fsf@gnu.org

The ARM64 ISA [4] aligns with what Jose said as well. The Intel and AMD
x86_64 ISAs specify that certain instructions perform two's-complement
negation, but as far as I know they don't dictate the type semantics for
the entire architecture.

[4]: https://developer.arm.com/documentation/ddi0602/latest

The reason that I think it may be prudent to leave this off is that I
don't think we really gain anything by specifying it. I expect that
we'll include this in the psABI document, but it seems unnecessarily
constraining to dictate two's complement in the PS _ISA document_. At
the end of the day I expect our goal will be source-code compatibility
rather than binary compatibility, and while it's entirely possible that
we'll never see it, I think it would be prudent to give platforms the
flexibility to implement signedness in other ways if they have a reason
to do so.

Case in point, while it's not an ISA standard, section 6.2.6
("Representations of types") of the C standard specifies the following:

> 1 The representations of all types are unspecified except as stated in this subclause.
> 2 Except for bit-fields, objects are composed of contiguous sequences of one or more bytes, the number,
> order, and encoding of which are either explicitly specified or implementation-defined.
> ...
> For signed integer types, the bits of the object representation shall be divided into three groups:
> value bits, padding bits, and the sign bit. There need not be any padding bits; signed char shall
> not have any padding bits. There shall be exactly one sign bit. Each bit that is a value bit shall have
> the same value as the same bit in the object representation of the corresponding unsigned type (if
> there are M value bits in the signed type and N in the unsigned type, then M <= N). If the sign bit is
> zero, it shall not affect the resulting value. If the sign bit is one, the value shall be modified in
> one of the following ways:
>
> — the corresponding value with sign bit 0 is negated (sign and magnitude);
> — the sign bit has the value −(2M) (two's complement);
> — the sign bit has the value −(2M − 1) (ones' complement).

In my opinion, the intention of the standard to not over-specify should
apply here as well.

> * I finally understand why the code fields have their low nybble zero.
> We should maybe say this.

Hmmm, sorry, I'm not quite following this part. Could you please clarify
which encoding / section you're referring to specifically?

> * Explicitly call out after 5.2 that there is no memory model yet

I'm not fundamentally opposed to this, though I'll share my subjective
opinion that specifying the absence of something seems unnecessary for a
standard. It seems like it would fit better in an Informational
document? Not sure.

> * Pull up section 5.3.1 to the top, or figure out some way to punt it
> to an extension. Maybe introduce maps up top then explain how they are
> indexed here.

I'm fine with this be reworked if you think it would clarify things.
Please feel free to submit patches that reformats in a way that you
think is clearer. Or Will, or someone else, etc :-)

> For extensions if I think I understand the conversation at IETF 117,
> it's easy to add more calls to the host system as functions. It's a

I'll give a bit of background here on the Linux side. It's easy to add
what we call kfuncs [5], which are host-system / main-kernel functions
that can be called from BPF. These have no UAPI guarantees, so we can
safely add them without having to worry about supporting them forever /
indefinitely. In contrast, we no longer add [6] helper functions because
they do come with UAPI requirements, and thus with much more significant
potential long-term overhead.

[5]: https://www.kernel.org/doc/html/latest/bpf/kfuncs.html
[6]: https://man7.org/linux/man-pages/man7/bpf-helpers.7.html

More on this below.

> lot more of a difficulty to add more instructions, but in the wide
> encoding space there is room. We could definitely say that. The memory

To the point above about helpers vs. kfuncs, I think there's a
nontrivial amount of subtlety we'll have to capture. And at the risk of
being a broken record, I don't think we necessarily want to try and
capture all of the nuances of the difficulty in adding instructions,
certain types of host-system functions, etc, in the ISA document. What I
feel does belong in the ISA document would be a very clear prescription
for how the ISA can be _extended_. The difficulty in extending the ISA
should hopefully be self-evident from that.

In contrast, the [I] architecture and framework document seems like a
more appropriate place to go into details on platform-specific
host-system functions vs. helpers, etc. We also have plans to implement
another proposed standard on the cross-platform helper functions:

* [PS] cross-platform helper functions, e.g., for manipulation of maps,

and I'm sure we'll also describe how that PS can be extended in that
document.

Please let me know if I've misunderstood your suggestion.

> model should only modify the behavior of environments with races, so
> if things aren't racy, nothing changes. That should work, but maybe I

Just to be clear, I think you mean the memory _consistency_ model,
correct? But yes, if you're running in e.g. a uniprocessor environment,
we shouldn't have to worry about any of that. As I said in the prior
email, I definitely agree with you that we'll need to formally define
all of this in a subsequent extension of the document, but think that
we'll be OK with sidestepping it for now. It sounds like we're on the
same page for this one?

> don't understand what other extensions that people would want to add.
> Verification might be an extension, but probably not in the sense we
> need to worry about it here?

Hmmm, I don't expect that verification would ever be relevant to
extending the ISA. There may be some platforms that don't implement
verification at all. Verification will likely be relegated to:

* [I] verifier expectations and building blocks for allowing safe
  execution of untrusted BPF programs,

from our charter, and will likely also be mentioned in the architecture
and framework informational doc.

I expect that future extensions would be something like adding a fence
instruction, etc were we to decide to go that route.

> I hope the above is helpful: as always my ignorance can completely
> negate the value of the concrete suggestion, but I do hope it
> highlights areas that could use some TLC.

Your input is very much appreciated, and I don't disagree with you that
the doc could (as with any document) always be further improved.

Just as a friendly suggestion, as I said above, if you feel strongly
about these proposals I expect that it would be easier to incorporate
them by submitting patches with the proposed changes rather than simply
describing the perceived gaps. That's not a hard requirement by any
means, and I appreciate you volunteering your time to review the
document regardless. Just a suggestion for greasing the wheels.

Kind regards,
David

