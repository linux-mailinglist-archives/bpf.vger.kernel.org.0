Return-Path: <bpf+bounces-16455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD78013E7
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF761C20F36
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334175675F;
	Fri,  1 Dec 2023 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qGpYgkjN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3I5vxLf"
X-Original-To: bpf@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F3EB2;
	Fri,  1 Dec 2023 12:05:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id A7F0C580773;
	Fri,  1 Dec 2023 15:05:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Dec 2023 15:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701461151; x=1701468351; bh=/u3yLH29k8T5r7NJxXWGv9BlZGGVl+1F2ls
	zusvsbJ0=; b=qGpYgkjNlqWggIHiSu4D3RZgSJ3nBcLv5OqMeVZguaCQyi5QNEp
	9cgeMwa9X8sJ3Ttg4uh0ZXAOpEuILMhkgqCRSofFtZAsT3NguXWGTJJPxiwHmjw4
	UwnZ24pzEHzKJ24Rz869muRs25eB97k+q9lK8l7LOEHAs1VyQBu920DxKPzLnGiG
	ofq/PLmKQo4Q58loWslypGUJksj1Vyz3z3/Z4B1FyQgzeTftTkjLasamFTBTGxLP
	XOt+dMB6O6UEO7QYzAsRYmAepXsFt+GDBbaY+O8HrVB0KH+CFaewQqaJ8HbxJi5L
	yzjtAWAABEJoqsVOEX7rmVwt0FhFDTFoqsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701461151; x=1701468351; bh=/u3yLH29k8T5r7NJxXWGv9BlZGGVl+1F2ls
	zusvsbJ0=; b=Z3I5vxLf2sF9upN8LhfnCJPBDEtQYg/Tr9l3XRyFdiPuxKxN2Y7
	ghg4kqphZf5+YkfnbNHwLbsWZL8Iubi4WPmld0ucsGXWWCYpFkt8xgismuAf0RSc
	tC1WUGs0ffZe73UUQDj2n+keugJizzrBPpA3a21fpnZhpfJ9/+qwJs0UmRGIl9zh
	KZCvKN3rbIGzjq03qzMvNwiO8IB9huNIlVXD7qawLbEkj4tH+Pd/nC83sAphOwZs
	z1O6dtu5eG4fPByRtKeBt96owIMuIJnkRltvgjnYopqanbEjbohRcTt5ONjWzoRJ
	qEEkifcAU4d6brV1I7HkPdMv2Oznd5MWlAg==
X-ME-Sender: <xms:nzxqZWUjC9lp9p6jh7fwpomS4my8s8UrkjxESTFi5KjtlmOIbhyCYQ>
    <xme:nzxqZSnsnOqBeegXNad2P5ufA9lN21YsbSAn0yvH7xNWzB0HUvaiFx5_hVy2fZl6h
    IzloH8fI_EjpF8W7A>
X-ME-Received: <xmr:nzxqZaa7KRzdSDXvNQjUhOSjmZkjSzAiqm0sxiJ_nWsG3-NAOIKgsr48CtlDTlgwCFHDv1owU6feqTMxwAV_DSMu2aKbjkbOHNTe8ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhephfduffelfedvfedvveduheefveejgeekffdtteeuteet
    udeihfekvdfgtdfghfevnecuffhomhgrihhnpehllhhvmhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:nzxqZdV1R7IHQVG1uD13WEcP23w4KVAxdyWo7iH3H_UPuPYB96S_Lw>
    <xmx:nzxqZQlO6q7EWBmx-R03AXcYRmis09HJ83070hOriaz7Vqznz8TCJg>
    <xmx:nzxqZSfsETtnVxUqj8VpSjnEOwPoRbchBot0QB__Cux1aSdUq4zOSg>
    <xmx:nzxqZSXU1j-qVCk7LL3oxDwiL4B6NCT3bAv3EFbLN_MSLITWcuso1g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:05:49 -0500 (EST)
Date: Fri, 1 Dec 2023 13:05:47 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ndesaulniers@google.com, 
	andrii@kernel.org, nathan@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	steffen.klassert@secunet.com, antony.antony@secunet.com, alexei.starovoitov@gmail.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
Message-ID: <hoqjfeuhcb36whzorttcpepvsnysmkcxmfteqo34tdhz5r5oqx@vcqcoc2iyoub>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
 <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
 <ib27gbqj6c6ilblugm5kalwyfty6h4zujhvykw4a562uorqzjn@6wxeino6q7vk>
 <CAEf4BzbO80kFyFBCUixJ_NGqjJv79i+6oQXz+-jzRE+MaoRYZA@mail.gmail.com>
 <CAEf4BzYGLVXVUptLym8p4dw4X=XxRErPLuPi=msHrwvXgDbCbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYGLVXVUptLym8p4dw4X=XxRErPLuPi=msHrwvXgDbCbQ@mail.gmail.com>

On Fri, Dec 01, 2023 at 11:13:13AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 1, 2023 at 11:11 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Nov 30, 2023 at 5:33 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > On Tue, Nov 28, 2023 at 07:59:01PM +0200, Eduard Zingerman wrote:
> > > > On Tue, 2023-11-28 at 10:54 -0700, Daniel Xu wrote:
> > > > > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > > > > writing wrapper to make the verifier happy.
> > > > >
> > > > > Two alternatives to this approach are:
> > > > >
> > > > > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> > > > >    CO-RE on specific structs.
> > > > > 2. Use broader byte-sized writes to write to bitfields.
> > > > >
> > > > > (1) is a bit a bit hard to use. It requires specific and
> > > > > not-very-obvious annotations to bpftool generated vmlinux.h. It's also
> > > > > not generally available in released LLVM versions yet.
> > > > >
> > > > > (2) makes the code quite hard to read and write. And especially if
> > > > > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > > > > to have an inverse helper for writing.
> > > > >
> > > > > [0]: https://reviews.llvm.org/D133361
> > > > > From: Eduard Zingerman <eddyz87@gmail.com>
> > > > >
> > > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > > ---
> > > >
> > > > Could you please also add a selftest (or several) using __retval()
> > > > annotation for this macro?
> > >
> > > Good call about adding tests -- I found a few bugs with the code from
> > > the other thread. But boy did they take a lot of brain cells to figure
> > > out.
> > >
> > > There was some 6th grade algebra involved too -- I'll do my best to
> > > explain it in the commit msg for v3.
> > >
> > >
> > > Here are the fixes in case you are curious:
> > >
> > > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> > > index 7a764f65d299..8f02c558c0ff 100644
> > > --- a/tools/lib/bpf/bpf_core_read.h
> > > +++ b/tools/lib/bpf/bpf_core_read.h
> > > @@ -120,7 +120,9 @@ enum bpf_enum_value_kind {
> > >         unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);      \
> > >         unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);        \
> > >         unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);        \
> > > -       unsigned int bit_size = (rshift - lshift);                      \
> > > +       unsigned int bit_size = (64 - rshift);                          \
> > > +       unsigned int hi_size = lshift;                                  \
> > > +       unsigned int lo_size = (rshift - lshift);                       \
> >
> > nit: let's drop unnecessary ()
> >
> > >         unsigned long long nval, val, hi, lo;                           \
> > >                                                                         \
> > >         asm volatile("" : "+r"(p));                                     \
> > > @@ -131,13 +133,13 @@ enum bpf_enum_value_kind {
> > >         case 4: val = *(unsigned int *)p; break;                        \
> > >         case 8: val = *(unsigned long long *)p; break;                  \
> > >         }                                                               \
> > > -       hi = val >> (bit_size + rshift);                                \
> > > -       hi <<= bit_size + rshift;                                       \
> > > -       lo = val << (bit_size + lshift);                                \
> > > -       lo >>= bit_size + lshift;                                       \
> > > +       hi = val >> (64 - hi_size);                                     \
> > > +       hi <<= 64 - hi_size;                                            \
> > > +       lo = val << (64 - lo_size);                                     \
> > > +       lo >>= 64 - lo_size;                                            \
> > >         nval = new_val;                                                 \
> > > -       nval <<= lshift;                                                \
> > > -       nval >>= rshift;                                                \
> > > +       nval <<= (64 - bit_size);                                       \
> > > +       nval >>= (64 - bit_size - lo_size);                             \
> > >         val = hi | nval | lo;                                           \
> >
> > this looks.. unusual. I'd imagine we calculate a mask, mask out bits
> > we are replacing, and then OR with new values, roughly (assuming all
> > the right left/right shift values and stuff)
> >
> > /* clear bits */
> > val &= ~(bitfield_mask << shift);
> 
> we can also calculate shifted mask with just
> 
> bitfield_mask = (-1ULL) << some_left_shift >> some_right_shift;
> val &= ~bitfield_mask;

Yeah I was chatting w/ JonathanL about this and I've got basically that
code ready to send for v3.

Thanks,
Daniel

