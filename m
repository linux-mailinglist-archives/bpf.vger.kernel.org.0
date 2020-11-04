Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E401E2A5CB2
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 03:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgKDCaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 21:30:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60075 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729188AbgKDCap (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Nov 2020 21:30:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 64B6B5C00CC;
        Tue,  3 Nov 2020 21:30:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 03 Nov 2020 21:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=WE7yAH2aWA3fpPsJ2XJxmxiCEv
        3IiFflvFYkvVNFDuQ=; b=H4Wk1mVfzFJCSyX9lNHb20rXl9RDucaXdEQwfD9toY
        K56XkJANQhatj1b0723ffSKBoWmz+FsmPSDLtAUjnyWx0Yq45rzoH4gLZlirmdnk
        gx2CBlux45P0XiIQt20worGPYPyHDjtPDNn275e7EJ8G+5c0oa9xISXuNkOdVhKn
        E50fD52uQTEDzqr546PntIiCkn50wcJZiK+vl39lHVKVbi3eEqTcPrlBmD3hp2i4
        Mr3wtDwleuxyDcNVgav1rcmDe4f9zMo6Gu5HjnrUmHkJiMrpfxdErpV1tUx8tLDZ
        937YLNgxJg6EeQtNhv7LdGu5OfgDQV3kTH0E8z+UywkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WE7yAH2aWA3fpPsJ2
        XJxmxiCEv3IiFflvFYkvVNFDuQ=; b=Rb7WTGEEavUFi1ld6gc9+wCoTe+pPrZKg
        jPKgaJNW5m/C1/RSM+jrRT/xdCJQ+Q7cpzDYNteaoYfE+Us1fN8HRaNVAMgsxUrD
        hxQGhWSaFA6eyyklm0PA8gd+LGPKcSw7G3DvQVL3g3uasB2z80FOLs/JiJPmB7bw
        1f13/lVDP20Fnk6DulUl8qdho5QvYmGlhdEJ/pHs7ZU5xu7X28zbpbBq3jvkRSnu
        2ZEqTHv1QPAdxeVXWpm/7nVeSQq3XbMvdZ9vRIj80kvgXxC8BbSaQxpe7iGiETq+
        9g+lywL7L0HPuWFVYFD/j8pHJwp99tqfTQsclMoeAbT2fKLViehrg==
X-ME-Sender: <xms:UxKiX1r8s8NvGSWgtdgteEil4xsUnV-zKQJvRxIuwXxx8b5WMNDHJQ>
    <xme:UxKiX3pqSf8KYK5QrS5Ri09g1LA5xb5s3sAu3N3w1PyYDG3qfzlsu6Bp-SsNK_sYQ
    FQkQ7MTxGJdXPzVqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucfkphepieelrddukedurddutdeh
    rdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:UxKiXyNKxJNTe52tze373PLkoVhd9MsdjU7yatjbH8ZsaLyS_yFxNQ>
    <xmx:UxKiXw5vVjzMHrSaSHZlCYlVSnrNAOWY1JU9sIhgV12aUczQq48l0g>
    <xmx:UxKiX06hvxn9YXPm3YD3G5mWcgklw3zhom1y0IehvtU7BeJpJ9o-OQ>
    <xmx:VBKiX0FK9NVJQHc5qrgMFwxdbRSC-jCmERmvZuKHfIFq4PTmcV1sVQ>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C67B3064687;
        Tue,  3 Nov 2020 21:30:43 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Tue,  3 Nov 2020 18:29:43 -0800
Message-Id: <eb78270e61e4d2e8ece047430d8397e000ef8569.1604456921.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

do_strncpy_from_user() may copy some extra bytes after the NUL
terminator into the destination buffer. This usually does not matter for
normal string operations. However, when BPF programs key BPF maps with
strings, this matters a lot.

A BPF program may read strings from user memory by calling the
bpf_probe_read_user_str() helper which eventually calls
do_strncpy_from_user(). The program can then key a map with the
resulting string. BPF map keys are fixed-width and string-agnostic,
meaning that map keys are treated as a set of bytes.

The issue is when do_strncpy_from_user() overcopies bytes after the NUL
terminator, it can result in seemingly identical strings occupying
multiple slots in a BPF map. This behavior is subtle and totally
unexpected by the user.

This commit uses the proper word-at-a-time APIs to avoid overcopying.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 lib/strncpy_from_user.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index e6d5fcc2cdf3..d084189eb05c 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -35,17 +35,22 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		goto byte_at_a_time;
 
 	while (max >= sizeof(unsigned long)) {
-		unsigned long c, data;
+		unsigned long c, data, mask, *out;
 
 		/* Fall back to byte-at-a-time if we get a page fault */
 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
 
-		*(unsigned long *)(dst+res) = c;
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
+			mask = zero_bytemask(data);
+			out = (unsigned long *)(dst+res);
+			*out = (*out & ~mask) | (c & mask);
 			return res + find_zero(data);
+		} else  {
+			*(unsigned long *)(dst+res) = c;
 		}
+
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
2.28.0

