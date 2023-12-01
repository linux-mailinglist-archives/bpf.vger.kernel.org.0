Return-Path: <bpf+bounces-16460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81267801454
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB4B281D6B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B66584CB;
	Fri,  1 Dec 2023 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YOE8nYUp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uVUpr5Ra"
X-Original-To: bpf@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F10DD;
	Fri,  1 Dec 2023 12:23:58 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id E613058098F;
	Fri,  1 Dec 2023 15:23:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 15:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462237; x=
	1701469437; bh=c0SQUBYYwJzTTCGOT+Ez9K+x+hF2I698/lffpVW1VHI=; b=Y
	OE8nYUpixcpzmPMxMxOt4wxQ0E+uKI2F8N1A6+Es6IGnOIfEZDCaySPB7pvY4Lun
	1YFNZbQlkgNdbqT0hqFG8QOT6OY0XwLURyfzy6aL+4fuSUWfxpcpgVkzFAArhXHh
	wijPHaVuT5oTxdy+uN4ts6OrCCseD7T+MrnjswaSWDgOy3SQQwkNnD4ytrt6oPgb
	vDVlQ826Z/1ey17zD0BXZOjI1z1nf3aZcZ6JaMj4aHpP2STegI2I2qFAxaN05nuk
	8LkWlVLye8I9WCfxgLV4F+ovRylzG6PQNZwjI4UVX3dSEOFFFfQRHR1iCxqrd+nl
	kuQpdgsucmnFOouzjtl6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462237; x=
	1701469437; bh=c0SQUBYYwJzTTCGOT+Ez9K+x+hF2I698/lffpVW1VHI=; b=u
	VUpr5RaeyZAcr8XiX/cUJd6y/eQ2sCZA2Cb5ZPhbUdWP2uTdzvS4MBxJbWZUlSGB
	W+G9tOZmC70vPeUBvKHp1Zn5FifuzhdwqwHOF2RjR1GmsB3PwR9ADWjSd8M90nXl
	mO9o3l0VWQRKq68GyzC5/VWgKrCKcyE1Q8FEsHPJUxEkdtdV0ND3MhHWy8o5nOX3
	4hc1lRE94yUDhU9Lnk0mGHUf22ktlmvYwLrL7MvkmQi+ijtdIa/uhyNXD0OhnLVd
	6p4zNBQ0JJK6xOpZTMbcrXXMA6ek7hEcdDAwuwuJYdt+SmLmSayMp/BMxjQEJCD2
	I9RjQ2n0QvzgIewr27UBg==
X-ME-Sender: <xms:3UBqZRslVxYXHKZeWFfT3xIZrPYAz95LDZsdnizbcey93EMBv0TTKQ>
    <xme:3UBqZacqS7VQ3ZJIALIOAW_xVP8eyHW2tFxkNjPUi3Y06h4FZcOPLwLBeCctii4I-
    syZWjovxXNIAz-cdQ>
X-ME-Received: <xmr:3UBqZUyLp9Qw_K6BE8ovgh7t_LkngFsgz84G9CWvdxbitKx3mxaRNNVnu8aADuKh8mcx3Mv31uTVY7mTUre6eoRdHNMGZSwUzcckQ9VYQEzDDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeeigeffteehteffheejkeefjeeuudfgvdekkeetudeghedu
    gffgleffhefgjeevgfenucffohhmrghinheplhhlvhhmrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:3UBqZYMDcKmt08JG9XyUs-6Z0FayOZGM24-qam0ukKVpAfal_7KIaQ>
    <xmx:3UBqZR_14No7y8bFEVonX9PmSd0EgerSp_PF-rjzOkejVsCUzmuKVw>
    <xmx:3UBqZYXUfKnwN5xd_hd20aZQXpG6ug81B8LVpv5mt-Oxu_GL7y860A>
    <xmx:3UBqZdvow0Q2osEWvHvEvp_G4H2DzgsYsI7D0kS4nCyBezNslK1fzw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:55 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ndesaulniers@google.com,
	daniel@iogearbox.net,
	nathan@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
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
Subject: [PATCH ipsec-next v3 3/9] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
Date: Fri,  1 Dec 2023 13:23:14 -0700
Message-ID: <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
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

With this insight, we can how define the following relationship:

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

        mask = (~0ULL << rshift) >> lshift;   // 1
        nval = new_val;                       // 2
        nval = (nval << rpad) & mask;         // 3
        val = (val & ~mask) | nval;           // 4

(1): Compute a mask where the set bits are the bitfield bits. The first
     left shift zeros out exactly the number of blank bits, leaving a
     bitfield sized set of 1s. The subsequent right shift inserts the
     correct amount of higher order blank bits.
(2): Place the new value into a word sized container, nval.
(3): Place nval at the correct bit position and mask out blank bits.
(4): Mix the bitfield in with original surrounding blank bits.

[0]: https://reviews.llvm.org/D133361
Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Co-authored-by: Jonathan Lemon <jlemon@aviatrix.com>
Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/bpf_core_read.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 1ac57bb7ac55..a7ffb80e3539 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -111,6 +111,40 @@ enum bpf_enum_value_kind {
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
+	unsigned int rpad = rshift - lshift;				\
+	unsigned long long nval, mask, val;				\
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
+	nval = new_val;							\
+	nval = (nval << rpad) & mask;					\
+	val = (val & ~mask) | nval;					\
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


