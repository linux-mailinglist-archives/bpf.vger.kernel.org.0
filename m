Return-Path: <bpf+bounces-16636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032AE804088
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259791C20889
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124B35EF2;
	Mon,  4 Dec 2023 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="mSqkINcQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nx00iUpT"
X-Original-To: bpf@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2E01BC;
	Mon,  4 Dec 2023 12:57:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 3CEA658045D;
	Mon,  4 Dec 2023 15:57:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Dec 2023 15:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723420; x=
	1701730620; bh=frFWRgIM/BeMgIIvESHMUoKVQK0r3Pl2bvU4ZuSshRc=; b=m
	SqkINcQHxbWSUBUJzPxK8wksAFZ+b5OXhV4a/ZwNfWXPYFyuAk1Rh+Al8G+WEjh8
	F4dfDce1gwAViusNsDX3iarLdX5vmKvAN4bVpaJ+tayuTocuXFUoqCKt1E4Sq6zN
	HjOWNEOLmIMCd3HFIOQI5vGPqtld8OAqLdEyyelfBoloSKd+7zpO4SxzLt5Er+Rc
	zF2x2s2u1JpiX+r01GwBREN86b4o1bl1PC2RW//ejGIkLs4dDSzxGV/V2nZ1x53+
	9shbaXQnbIJpj743DimxJ0vNzJSMsNAzQ55EznkrCCviTA0UMkTFjWa605ToSmOg
	nr2b7piRQGQsEo7pITZwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723420; x=
	1701730620; bh=frFWRgIM/BeMgIIvESHMUoKVQK0r3Pl2bvU4ZuSshRc=; b=n
	x00iUpTzWbiSsyAoM77a2vxQPTLImeX/GE4aSA9MNIoLeMkDoPLeA1QwesW2Dclk
	KCpuwzGYg/eFz4KNtDV3l6nZ4Rpo7FEbgoZvLg886oZ8qEszarMeMCCZqD4g1hL/
	WEqhI62m5+aR3FHDOOOsyWwQH15ksykVswpldm+FcnSdX3AilNFH6WZSV4srqISo
	vQFqicMePoZmNZCTueXltWV4HeDqBCrwW1c7swhNc2VU9yy5HjFq78SFOoTv1RL1
	ITxheXrM/WtsZaqQX07efy/0V7J/nnbaI/plaNgO5Kp67yJxUG9geGmp2dkTHF/N
	GleKFo46Qsi6G+0YWwvPw==
X-ME-Sender: <xms:HD1uZSuvAwmLqoFfRsLUW74S_BIYsCXRUQ9kZ3dQIAVIhGwoEmqI1g>
    <xme:HD1uZXdTjDNjHDwB9NIIfboUADdTi7jtHKUW_zZ0fzaaaJwUqSMcfMx1VOGsN6wsv
    YJdpTvpmizsic2G1w>
X-ME-Received: <xmr:HD1uZdzL0CC76muk3eo-7_4JNmcuB1kRyi0ImMQM6m6ehAVn0ZFdGWbNLHjjqCBCXUv-AvbnfusEIzB2ID8Qlvdzsa91UqU86jk9BoCUuIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeeigeffteehteffheejkeefjeeuudfgvdekkeetudeghedu
    gffgleffhefgjeevgfenucffohhmrghinheplhhlvhhmrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:HD1uZdPgwYv5otBFGGrHiIuaVH8rZ2gTbUiuJGkQQ3o3d9dMEd_rRg>
    <xmx:HD1uZS8QUiosJX7oU3wh8RjF6gbxEfycGXOD9wupcEmaejpZde2Yhg>
    <xmx:HD1uZVW6te2HxlC1UxIyFc4qjiux01RopI3koyBWnNi7TGH5f8Ve1g>
    <xmx:HD1uZeu6TnnzOoXJ-HNYP2J0bzSQRahniOP9xORwfBH7zuOeGYyLOg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:58 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	nathan@kernel.org,
	andrii@kernel.org,
	ndesaulniers@google.com,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	trix@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Jonathan Lemon <jlemon@aviatrix.com>
Subject: [PATCH bpf-next v4 04/10] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
Date: Mon,  4 Dec 2023 13:56:24 -0700
Message-ID: <d213a6438f7f5db1014f6b41213b71851736d3bc.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

=== Motivation ===

Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
writing wrapper to make the verifier happy.

Two alternatives to this approach are:

1. Use the upcoming `preserve_static_offset` [0] attribute to disable
   CO-RE on specific structs.
2. Use broader byte-sized writes to write to bitfields.

(1) is a bit hard to use. It requires specific and not-very-obvious
annotations to bpftool generated vmlinux.h. It's also not generally
available in released LLVM versions yet.

(2) makes the code quite hard to read and write. And especially if
BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
to have an inverse helper for writing.

=== Implementation details ===

Since the logic is a bit non-obvious, I thought it would be helpful
to explain exactly what's going on.

To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_U64
(rshift) is designed to mean. Consider the core of the
BPF_CORE_READ_BITFIELD() algorithm:

        val <<= __CORE_RELO(s, field, LSHIFT_U64);
        val = val >> __CORE_RELO(s, field, RSHIFT_U64);

Basically what happens is we lshift to clear the non-relevant (blank)
higher order bits. Then we rshift to bring the relevant bits (bitfield)
down to LSB position (while also clearing blank lower order bits). To
illustrate:

        Start:    ........XXX......
        Lshift:   XXX......00000000
        Rshift:   00000000000000XXX

where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bit.

After the two operations, the bitfield is ready to be interpreted as a
regular integer.

Next, we want to build an alternative (but more helpful) mental model
on lshift and rshift. That is, to consider:

* rshift as the total number of blank bits in the u64
* lshift as number of blank bits left of the bitfield in the u64

Take a moment to consider why that is true by consulting the above
diagram.

With this insight, we can now define the following relationship:

              bitfield
                 _
                | |
        0.....00XXX0...00
        |      |   |    |
        |______|   |    |
         lshift    |    |
                   |____|
              (rshift - lshift)

That is, we know the number of higher order blank bits is just lshift.
And the number of lower order blank bits is (rshift - lshift).

Finally, we can examine the core of the write side algorithm:

        mask = (~0ULL << rshift) >> lshift;              // 1
        val = (val & ~mask) | ((nval << rpad) & mask);   // 2

1. Compute a mask where the set bits are the bitfield bits. The first
   left shift zeros out exactly the number of blank bits, leaving a
   bitfield sized set of 1s. The subsequent right shift inserts the
   correct amount of higher order blank bits.

2. On the left of the `|`, mask out the bitfield bits. This creates
   0s where the new bitfield bits will go. On the right of the `|`,
   bring nval into the correct bit position and mask out any bits
   that fall outside of the bitfield. Finally, by bor'ing the two
   halves, we get the final set of bits to write back.

[0]: https://reviews.llvm.org/D133361
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Co-developed-by: Jonathan Lemon <jlemon@aviatrix.com>
Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/bpf_core_read.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 1ac57bb7ac55..7325a12692a3 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -111,6 +111,38 @@ enum bpf_enum_value_kind {
 	val;								      \
 })
 
+/*
+ * Write to a bitfield, identified by s->field.
+ * This is the inverse of BPF_CORE_WRITE_BITFIELD().
+ */
+#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({			\
+	void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);	\
+	unsigned int byte_size = __CORE_RELO(s, field, BYTE_SIZE);	\
+	unsigned int lshift = __CORE_RELO(s, field, LSHIFT_U64);	\
+	unsigned int rshift = __CORE_RELO(s, field, RSHIFT_U64);	\
+	unsigned long long mask, val, nval = new_val;			\
+	unsigned int rpad = rshift - lshift;				\
+									\
+	asm volatile("" : "+r"(p));					\
+									\
+	switch (byte_size) {						\
+	case 1: val = *(unsigned char *)p; break;			\
+	case 2: val = *(unsigned short *)p; break;			\
+	case 4: val = *(unsigned int *)p; break;			\
+	case 8: val = *(unsigned long long *)p; break;			\
+	}								\
+									\
+	mask = (~0ULL << rshift) >> lshift;				\
+	val = (val & ~mask) | ((nval << rpad) & mask);			\
+									\
+	switch (byte_size) {						\
+	case 1: *(unsigned char *)p      = val; break;			\
+	case 2: *(unsigned short *)p     = val; break;			\
+	case 4: *(unsigned int *)p       = val; break;			\
+	case 8: *(unsigned long long *)p = val; break;			\
+	}								\
+})
+
 #define ___bpf_field_ref1(field)	(field)
 #define ___bpf_field_ref2(type, field)	(((typeof(type) *)0)->field)
 #define ___bpf_field_ref(args...)					    \
-- 
2.42.1


