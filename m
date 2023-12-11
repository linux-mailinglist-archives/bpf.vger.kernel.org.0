Return-Path: <bpf+bounces-17442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D822280DB70
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B484B214FB
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20854679;
	Mon, 11 Dec 2023 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="PsNFQn8o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zmvTlhAL"
X-Original-To: bpf@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92FFE5;
	Mon, 11 Dec 2023 12:20:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id D7FF558093A;
	Mon, 11 Dec 2023 15:20:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Dec 2023 15:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326035; x=
	1702333235; bh=1ORZQIDuXwXnlUl6JXOOGY6ASexrD5pFldnSGT1cA6s=; b=P
	sNFQn8oXBF4WxLnIKPvIqKdou4WF8Dok45+7WCjxB57eFqrDKJJ6M+5WxbhW1TYj
	xi50Rj/n8kod03Dbt9pnccoIOXjSFbsfm6ek1HJcP1Sm+t09KOeKhTccL0JS/SDc
	iaPeG7DytijavrV0NvbM2QQhXGB5isAo8e3pIqxF3nOvMFQt5nv9rqiu4Oaf0ovb
	t1p8Qd7bgVBcIcxC8Aoqt2oZV8WrZZC8WdOsMtQ4lHoMavAKb0HuIST9kqyDRdA5
	BE8yzBHlqpj5IrwW806SGO6bVaL+pS5LIr3OwbtByrSOmj2gEgVh4KETJAd6FqyI
	86Oz3MZNOI+BP3q5loFrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326035; x=
	1702333235; bh=1ORZQIDuXwXnlUl6JXOOGY6ASexrD5pFldnSGT1cA6s=; b=z
	mvTlhALtY1A/UFoakFOytn45ayXt3atCMaRWRrAB99HwW0mBrFZeRQqP5a5Ft9Zf
	H7no+vgo0qk7k3SXgtk94FxoejA08FSudsS0vbFh2ADoWEBnINf/npwE8hQYYSPG
	eDrrxVlV8MBwVrgi9moY3ZNn3I+3h5kCSG/8bq9KSnbX8Kh9yd6MpCsCYnN7AMhZ
	WrvgbNyEfJdSfcbW4Ids93M2KCK5hx8gPFuUJ5sZBxGCf9Bgur5DOCbUS4DJ844d
	6V3f0MFUXLppZN0y8ZDMyCAFQXAX6OqCRyNb0TjzxCLwk+i8Eg5J+b632T3k41KL
	p3HX/gFc/A9Y13mR9iWsA==
X-ME-Sender: <xms:E293ZQliZIutGpfTcdSANOZr-ly87qtKLjDb1S72ram8wrCY6COpDw>
    <xme:E293Zf3vEwACahJj-Y8X7LJMT2Bko1oZLi0iw_Ok3PkTRy3Aq0lVDDqUnIFcDl4lV
    0IfH5_B_s_k3V7aSg>
X-ME-Received: <xmr:E293ZerUtoyD1mk7biiZvEw2WSZHkotoCukRwYImV8UPouQaGd9RbuScUcBkd7tqyz_2XfSYgQ76Ls3lhs2o3yqT1kAlOGh4XCYMmCOrO2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeeigeffteehteffheejkeefjeeuudfgvdekkeetudeghedu
    gffgleffhefgjeevgfenucffohhmrghinheplhhlvhhmrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiih
    ii
X-ME-Proxy: <xmx:E293ZclPvqUhi01rBHoBbXoJmbCehOr3168fBOgKSymQfGcvhcan1w>
    <xmx:E293Ze1SRqUCvQV-9jmBLX-8aw8nIokN7G3kbE6o8ac3tIiw-0D9cg>
    <xmx:E293ZTvZ1AY9OfwAU7dLCZsjWoehW7Z2-f6SOf7IAdxKzUMZJw0GgQ>
    <xmx:E293ZXWiyWzqyk3vLEQ-mPirBy39o5srSD6SBg05_vIFkXoKzmfE7w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:33 -0500 (EST)
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
	eddyz87@gmail.com,
	eyal.birger@gmail.com
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
Subject: [PATCH bpf-next v5 3/9] libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
Date: Mon, 11 Dec 2023 13:20:07 -0700
Message-ID: <4d3dd215a4fd57d980733886f9c11a45e1a9adf3.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


