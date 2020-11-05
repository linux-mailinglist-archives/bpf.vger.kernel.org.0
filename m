Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9852A7568
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 03:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbgKEC0K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 21:26:10 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38473 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgKEC0I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 21:26:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AA01F5C0196;
        Wed,  4 Nov 2020 21:26:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Nov 2020 21:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Jg0fjrJsxf5md
        rs5PcyEWR+0hj8wkkuXo6wpkjxI3eo=; b=Meiy97Q/qyIzMPuHXK6PlCOOxTID8
        exUHj9DpPM4Qb6q/td43JQLeD+qhEB3taWqs4t/mSeMQQYZXIe+fnhbq5PB4GOFT
        HXd7lir+b+WXH0aaBKfIwGMrkjUe4OaMznT/KxK0FIhIiHtzbPd1zvt55Lx10Y4D
        +52RejQ5vgduuY3kOv90ZSSjaVmQwXQgNMqNz7r71wwMLkGEfVWkEj9BztRPKQXK
        CorvGBpt2f5tNfQYRccMDak1tPWCATOpLW+YnX36KJo3xmww8KAkVaZ3vNBza6Nn
        6shfC++Qu878fHHwBSs4UTxvqkyxxiSwTXWwWti60oiU/Mg396B5yld8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Jg0fjrJsxf5mdrs5PcyEWR+0hj8wkkuXo6wpkjxI3eo=; b=pIqwjl0K
        h+XWfQPisO/g8gQUFrjE7SrdCQv/cYtVz9LQ/96SdCg3qSEvs35raS0RGOzUq3co
        /71mU3SxWa24xPYE6ZS7etrx3vCcOoDI0iMKhcEiORlxbrX61wcDP4km9PIUV5k1
        NI03mZkEAKySZNNYpstcfkhD22CPu/4GKiQsWyPeUtwBX/l9NqpwLtiek+fFgWL7
        MK/pNWAXV4a4H0XDalbiAlkJscWUM0YWeM5axmpiYuw90USqyZ0QWGa0XLpnTx09
        CXslF8N7eynwT2vzhvcsUlNEmgCP3RulTcSPFpGonB1GoABtKTCaDcyxWTJooK+7
        ujeAjQ1gI0odVw==
X-ME-Sender: <xms:v2KjX2HCIo5sWWaHKiLou7RbueVz9ORgsqtveiCsoW3D_x51lCAoow>
    <xme:v2KjX3UF0lY0wsMEAlhdnsDXAjJ0YsHUzTmm1D29qNRoUVn_GxrLsenMZiGNARKAO
    Yw559BXxftbL7tMGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:v2KjXwLJjx0CL0LC4nA9VmEu3dh1d9eMK55JOp7MCX-NYRZ5Ydfr1w>
    <xmx:v2KjXwHOixOg91A8TgkMHkCvMcLh4KPr1DrJWyYvJqd_sqVY_Nkiow>
    <xmx:v2KjX8Vgy_CL7SwrnS9Yfj6NZGdMBjSvSse7TeMJvg6zkMp5ioDiSw>
    <xmx:v2KjXzSnngJcIsLVyzAeqQJuYwI2WLwd65-DJAF4AF_010lX6OUS7A>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6209328037B;
        Wed,  4 Nov 2020 21:26:06 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Wed,  4 Nov 2020 18:25:37 -0800
Message-Id: <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604542786.git.dxu@dxuuu.xyz>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
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

Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers")
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

