Return-Path: <bpf+bounces-16341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C355F800111
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 02:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182B5B2119E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A766187F;
	Fri,  1 Dec 2023 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="iFG2UTmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4JAUDbt"
X-Original-To: bpf@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDDD50;
	Thu, 30 Nov 2023 17:33:44 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.nyi.internal (Postfix) with ESMTP id 9CEAD580A5A;
	Thu, 30 Nov 2023 20:33:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 30 Nov 2023 20:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701394421; x=1701401621; bh=jf
	qYqY018jdffj6zz+dnM/tM+okukGD8jcdyViM8tLU=; b=iFG2UTmmYzmIB4IoIc
	nRRmjJw9ay21fZLZfnHBcmxVZCkud4yQJ+V9Auwh19vxjk5IoliLkrjmAanvRp9e
	ILdJ8v4jD4l+IXTgw0YXlWdwIRAeYzXhMWrfnjpjiB2Q6hEOkcnz+0HNk5N55d/k
	efHhKzvnCQvHUaSLxPUxMp4hT/DY6XxGq9JM8N4v8aCA6coqclgEsg3+LqsIH3sp
	e3mtVu0eBzGZTErTmJguLh6BDlls9iALhKiLf1VW0lJCfOads73lg+IGVAJseXML
	AtANjKgh5WvRiZ4WlfzH+l09eNHsmjvikUOOw8XBvOJL2LHVSwgp8nDSZsWNL3I7
	ZTYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701394421; x=1701401621; bh=jfqYqY018jdff
	j6zz+dnM/tM+okukGD8jcdyViM8tLU=; b=E4JAUDbt3CWm62uu3AwTKuhYnxZSm
	s8urrS3AHDstYIGUMr9sE0iQiTKfsGSSgy50QWr1EfyV2qjlVid/jObea8rfMlb5
	Mh1hnFHOUzkSzcGiUKzzSI7IQow1lbAB8jkxRdNyS3lga63GM3YraUghVDqwxg9c
	5ycJzB8zd62g7ScwwDWsnYtd1vBr7Yx/HwxHuYEQbGwyOf+dBqGxnhYwAXoyp4Os
	ej6Khe8SWeNp1+iX0JZ9Wi0FF1UWDHNKQn8I8gEEwmyaoAYRlCLDAa8aUvqyqMDz
	e1odz7Ai4fpIS2SEHEpqI6h1iTNx70pB4qvNHwy3ghWl3xZoDHbFmqHng==
X-ME-Sender: <xms:9DdpZU5etkdH4ZXQ60PrOr3NIHj5E27P2bu01_51Cy0Ytzpke_u8TQ>
    <xme:9DdpZV5XPj2jVzk8INysCRHEPVDUecPYVOSYzoC3SPonXb5bEXmzdhdwnQpCzbK5s
    5hpPbsPD3u-jiexFQ>
X-ME-Received: <xmr:9DdpZTf_ERyiUhaNYMJRCGfI_l9WgIEGjOhsjfgX0paBc7bXii-GH1ZEb43zCNunDvOCNu4_X-QSB87vJVlTybxrhVdBaU5mOzPZMxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepfedtffeuudehheduhf
    eggfefjeelhfetgeeiteevieeiheefvdehudeifedvfedunecuffhomhgrihhnpehllhhv
    mhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:9TdpZZKAjFzcl7y16F2sPH0omwvoIR1mu1XGirVrq79w5v9Qn9Dgjg>
    <xmx:9TdpZYKuMQKWr9UGNG01Q0IsmPpouXO2oGcqwCkpDleStxaLmJamAg>
    <xmx:9TdpZay1rq7twixNaFHkPcIMydkV9HTttjlZUzvCt3Dgq-KUNnHUVQ>
    <xmx:9TdpZdjZIRrrCzJsxX_2iYBD2MKNQtm0l3dyxtD8McE5RoTvlgT3QA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 20:33:39 -0500 (EST)
Date: Thu, 30 Nov 2023 18:33:37 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ndesaulniers@google.com, andrii@kernel.org, nathan@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, trix@redhat.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
Message-ID: <ib27gbqj6c6ilblugm5kalwyfty6h4zujhvykw4a562uorqzjn@6wxeino6q7vk>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
 <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>

On Tue, Nov 28, 2023 at 07:59:01PM +0200, Eduard Zingerman wrote:
> On Tue, 2023-11-28 at 10:54 -0700, Daniel Xu wrote:
> > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > writing wrapper to make the verifier happy.
> > 
> > Two alternatives to this approach are:
> > 
> > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> >    CO-RE on specific structs.
> > 2. Use broader byte-sized writes to write to bitfields.
> > 
> > (1) is a bit a bit hard to use. It requires specific and
> > not-very-obvious annotations to bpftool generated vmlinux.h. It's also
> > not generally available in released LLVM versions yet.
> > 
> > (2) makes the code quite hard to read and write. And especially if
> > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > to have an inverse helper for writing.
> > 
> > [0]: https://reviews.llvm.org/D133361
> > From: Eduard Zingerman <eddyz87@gmail.com>
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> Could you please also add a selftest (or several) using __retval()
> annotation for this macro?

Good call about adding tests -- I found a few bugs with the code from
the other thread. But boy did they take a lot of brain cells to figure
out.

There was some 6th grade algebra involved too -- I'll do my best to
explain it in the commit msg for v3.


Here are the fixes in case you are curious:

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 7a764f65d299..8f02c558c0ff 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -120,7 +120,9 @@ enum bpf_enum_value_kind {
        unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);      \
        unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);        \
        unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);        \
-       unsigned int bit_size = (rshift - lshift);                      \
+       unsigned int bit_size = (64 - rshift);                          \
+       unsigned int hi_size = lshift;                                  \
+       unsigned int lo_size = (rshift - lshift);                       \
        unsigned long long nval, val, hi, lo;                           \
                                                                        \
        asm volatile("" : "+r"(p));                                     \
@@ -131,13 +133,13 @@ enum bpf_enum_value_kind {
        case 4: val = *(unsigned int *)p; break;                        \
        case 8: val = *(unsigned long long *)p; break;                  \
        }                                                               \
-       hi = val >> (bit_size + rshift);                                \
-       hi <<= bit_size + rshift;                                       \
-       lo = val << (bit_size + lshift);                                \
-       lo >>= bit_size + lshift;                                       \
+       hi = val >> (64 - hi_size);                                     \
+       hi <<= 64 - hi_size;                                            \
+       lo = val << (64 - lo_size);                                     \
+       lo >>= 64 - lo_size;                                            \
        nval = new_val;                                                 \
-       nval <<= lshift;                                                \
-       nval >>= rshift;                                                \
+       nval <<= (64 - bit_size);                                       \
+       nval >>= (64 - bit_size - lo_size);                             \
        val = hi | nval | lo;                                           \
        switch (byte_size) {                                            \
        case 1: *(unsigned char *)p      = val; break;                  \


Thanks,
Daniel

