Return-Path: <bpf+bounces-16481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D288018C9
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F73EB21131
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3901EDE;
	Sat,  2 Dec 2023 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="QvGPVhus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKHKI6jO"
X-Original-To: bpf@vger.kernel.org
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC36DD;
	Fri,  1 Dec 2023 16:13:46 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.nyi.internal (Postfix) with ESMTP id E055B580E80;
	Fri,  1 Dec 2023 19:13:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 19:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701476025; x=1701483225; bh=4VH9n7Ku5hozb2YWSefaThME8FC9SFCVYUN
	SDmL4YdM=; b=QvGPVhusvl9uXE5SCEbCr+HKEXCi9wla/7/ufCMQBCxoSKrK4BF
	ZCmC+55SqeuqJxzpSTRdHZbkH/QLj5ldcbNYaed5mc4Ez0+/tJmkoyMP4DZh83D7
	PJbzMnLoc6SJ89R3iXBiAQK8BMZB8kKaKTSG3q/rcbiAgC1h525URljrKDgRjxZK
	CP8uCjNBo+w/oUK6Qk0jVoeodNRn22gfvR0ir5xI7+aMYPZIAWAtbtxfSVpGu7SB
	GQD+3JR0CbkIo6fiqHAwNc3pMpq9pmYrvZ5vthiy4FuSuFNyuy300LjjokylMqKc
	KZpmtqSJwP+3tFMWU8zE1GXc8xfR6xo6YmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701476025; x=1701483225; bh=4VH9n7Ku5hozb2YWSefaThME8FC9SFCVYUN
	SDmL4YdM=; b=cKHKI6jOPonL6KUhmHxbE03zRkA9ocQmetXDH9o3wAJx+sYrwsC
	f407l25U8ohJ/u7e4JfJkPECw3ghM8XssDWQJFKP+NrdvWbGytN9o+dtIJPDwonz
	62cSu9VLUojap9mV0BcBKiJI7ZXceqa5psNR8t5fwRKHXv1MvscUQU9e2eyI2iTU
	tkVW3sdUgpAOvaKwiexBnQn3J+vGy7WxInX82Q1Ma1AsBEa0o2GH/L3B7dXpy949
	aJF5qCzXQydCt3BZPv4naUft40cWBtuB9kniRE45iGiUAmsrI1dgJbJKF59PVMHa
	wDxa+Ni7o7+YHWnm1sk8scZPSbOQEa3w1Yg==
X-ME-Sender: <xms:uXZqZcorrJe8VMMR55X33eungj-zDo12N91ZdqSrp1ObJchR-quI0Q>
    <xme:uXZqZSo91BWIu5kgIZkpZeU1jfOObZmLwS3YUoK9c4CZl-4M3KlKqrn47npNhtrbn
    dkdo5pDUmtIk_8G7A>
X-ME-Received: <xmr:uXZqZRMfasATyq5TDSfP2sbfaSUR6BOPRFbWCDzFeYOB0IgeI9x8dHov8eqGtCHBV9wtE0NaPBsWxTqCM45VFTe6zRgdgiNv2w4UguQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefhudffleefvdefvdevudehfeevjeegkefftdetueettedu
    iefhkedvgfdtgffhveenucffohhmrghinheplhhlvhhmrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:uXZqZT65galu2HulXAFaj4J5ab8hNyR_2kVwHYqZDxCQCzlWJUHfSQ>
    <xmx:uXZqZb5XFX4vvqPe7Yx9mbFZi0r0COsZcBsE1s6bJd_Up_ccqceTpg>
    <xmx:uXZqZTis-QNgtWn9DiJMUk0sSyTGgnrkV71HdDPoZNrkCn1TTsKG0g>
    <xmx:uXZqZSIKYV3vLyhUnYxdSgQ50QaTXKFCYu4TjUz6ppP90FhquipStw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 19:13:43 -0500 (EST)
Date: Fri, 1 Dec 2023 17:13:42 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ndesaulniers@google.com, daniel@iogearbox.net, nathan@kernel.org, 
	ast@kernel.org, andrii@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, devel@linux-ipsec.org, netdev@vger.kernel.org, 
	Jonathan Lemon <jlemon@aviatrix.com>
Subject: Re: [PATCH ipsec-next v3 3/9] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
Message-ID: <n64nphqug6spftbr36tgf32qv5lipvugevyabcvrnefgarut4s@uymc5hm5jsq2>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
 <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
 <CAEf4BzaSDHuqfhGJgh6gvu5t8Vg-q72bp99hfFa0PCQhapJPZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSDHuqfhGJgh6gvu5t8Vg-q72bp99hfFa0PCQhapJPZQ@mail.gmail.com>

On Fri, Dec 01, 2023 at 03:49:30PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 1, 2023 at 12:24 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > === Motivation ===
> >
> > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > writing wrapper to make the verifier happy.
> >
> > Two alternatives to this approach are:
> >
> > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> >    CO-RE on specific structs.
> > 2. Use broader byte-sized writes to write to bitfields.
> >
> > (1) is a bit hard to use. It requires specific and not-very-obvious
> > annotations to bpftool generated vmlinux.h. It's also not generally
> > available in released LLVM versions yet.
> >
> > (2) makes the code quite hard to read and write. And especially if
> > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > to have an inverse helper for writing.
> >
> > === Implementation details ===
> >
> > Since the logic is a bit non-obvious, I thought it would be helpful
> > to explain exactly what's going on.
> >
> > To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_U64
> > (rshift) is designed to mean. Consider the core of the
> > BPF_CORE_READ_BITFIELD() algorithm:
> >
> >         val <<= __CORE_RELO(s, field, LSHIFT_U64);
> >                 val = val >> __CORE_RELO(s, field, RSHIFT_U64);
> 
> nit: indentation is off?

Oops, it's cuz I only deleted the SIGNED check. Will fix.
> 
> >
> > Basically what happens is we lshift to clear the non-relevant (blank)
> > higher order bits. Then we rshift to bring the relevant bits (bitfield)
> > down to LSB position (while also clearing blank lower order bits). To
> > illustrate:
> >
> >         Start:    ........XXX......
> >         Lshift:   XXX......00000000
> >         Rshift:   00000000000000XXX
> >
> > where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bit.
> >
> > After the two operations, the bitfield is ready to be interpreted as a
> > regular integer.
> >
> > Next, we want to build an alternative (but more helpful) mental model
> > on lshift and rshift. That is, to consider:
> >
> > * rshift as the total number of blank bits in the u64
> > * lshift as number of blank bits left of the bitfield in the u64
> >
> > Take a moment to consider why that is true by consulting the above
> > diagram.
> >
> > With this insight, we can how define the following relationship:
> >
> >               bitfield
> >                  _
> >                 | |
> >         0.....00XXX0...00
> >         |      |   |    |
> >         |______|   |    |
> >          lshift    |    |
> >                    |____|
> >               (rshift - lshift)
> >
> > That is, we know the number of higher order blank bits is just lshift.
> > And the number of lower order blank bits is (rshift - lshift).
> >
> 
> Nice diagrams and description, thanks!

Thanks!

> 
> > Finally, we can examine the core of the write side algorithm:
> >
> >         mask = (~0ULL << rshift) >> lshift;   // 1
> >         nval = new_val;                       // 2
> >         nval = (nval << rpad) & mask;         // 3
> >         val = (val & ~mask) | nval;           // 4
> >
> > (1): Compute a mask where the set bits are the bitfield bits. The first
> >      left shift zeros out exactly the number of blank bits, leaving a
> >      bitfield sized set of 1s. The subsequent right shift inserts the
> >      correct amount of higher order blank bits.
> > (2): Place the new value into a word sized container, nval.
> > (3): Place nval at the correct bit position and mask out blank bits.
> > (4): Mix the bitfield in with original surrounding blank bits.
> >
> > [0]: https://reviews.llvm.org/D133361
> > Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > Co-authored-by: Jonathan Lemon <jlemon@aviatrix.com>
> > Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/lib/bpf/bpf_core_read.h | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> > index 1ac57bb7ac55..a7ffb80e3539 100644
> > --- a/tools/lib/bpf/bpf_core_read.h
> > +++ b/tools/lib/bpf/bpf_core_read.h
> > @@ -111,6 +111,40 @@ enum bpf_enum_value_kind {
> >         val;                                                                  \
> >  })
> >
> > +/*
> > + * Write to a bitfield, identified by s->field.
> > + * This is the inverse of BPF_CORE_WRITE_BITFIELD().
> > + */
> > +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({                  \
> > +       void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);       \
> > +       unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);      \
> > +       unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);        \
> > +       unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);        \
> > +       unsigned int rpad = rshift - lshift;                            \
> > +       unsigned long long nval, mask, val;                             \
> > +                                                                       \
> > +       asm volatile("" : "+r"(p));                                     \
> > +                                                                       \
> > +       switch (byte_size) {                                            \
> > +       case 1: val = *(unsigned char *)p; break;                       \
> > +       case 2: val = *(unsigned short *)p; break;                      \
> > +       case 4: val = *(unsigned int *)p; break;                        \
> > +       case 8: val = *(unsigned long long *)p; break;                  \
> > +       }                                                               \
> > +                                                                       \
> > +       mask = (~0ULL << rshift) >> lshift;                             \
> > +       nval = new_val;                                                 \
> > +       nval = (nval << rpad) & mask;                                   \
> > +       val = (val & ~mask) | nval;                                     \
> 
> I'd simplify it to not need nval at all
> 
> val = (val & ~mask) | ((new_val << rpad) & mask);
> 
> I actually find it easier to follow and make sure we are not doing
> anything unexpected. First part before |, we take old value and clear
> bits we are about to set, second part after |, we take bitfield value,
> shift it in position, and just in case mask it out if it's too big to
> fit. Combine, done.
> 
> Other than that, it looks good.

I mostly left it there for the cast. Cuz injecting the `unsigned long
long` cast made the line really long. How about this instead?

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index a7ffb80e3539..7325a12692a3 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -120,8 +120,8 @@ enum bpf_enum_value_kind {
        unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);      \
        unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);        \
        unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);        \
+       unsigned long long mask, val, nval = new_val;                   \
        unsigned int rpad = rshift - lshift;                            \
-       unsigned long long nval, mask, val;                             \
                                                                        \
        asm volatile("" : "+r"(p));                                     \
                                                                        \
@@ -133,9 +133,7 @@ enum bpf_enum_value_kind {
        }                                                               \
                                                                        \
        mask = (~0ULL << rshift) >> lshift;                             \
-       nval = new_val;                                                 \
-       nval = (nval << rpad) & mask;                                   \
-       val = (val & ~mask) | nval;                                     \
+       val = (val & ~mask) | ((nval << rpad) & mask);                  \
                                                                        \
        switch (byte_size) {                                            \
        case 1: *(unsigned char *)p      = val; break;                  \


Thanks,
Daniel

