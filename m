Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A932A8B1E
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbgKFAGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:06:48 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39703 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730895AbgKFAGs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:06:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EB725C023A;
        Thu,  5 Nov 2020 19:06:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 19:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=I06IP8OMpVQGH
        HEecVW9tziaqLhe1IrGmcpFFL3aS9o=; b=dyyKjHHYy0SXxfOKyKevrBKXkPpi7
        yn0HCtr7+o4rAOlj5fnXeSrcWLqVbdlzBnghACK6SDcwL2bJWHZe90sGxQAhk4Zg
        3FK8jCoF+9cHwGa1XGjTN9iiG4rYup3PYbtn1yyT5S6T6p26yKu/r42BwBXSN7i5
        Y58rY5t+QESP2YCStFlWoH7y+47nMEi6MD5JgOANuiaZofPIez0MLIAYZBkL/Hso
        tG4yIXGparkt/XLM8X62WlYJUTqYe/SnrKccvK8XCLSfthcEMBjMpvNLOYVkbjFU
        MSiM2dz38XF1QQ9MuZRyibsfezv4TM8SVejMu+y3UHKeT2m50RDAe/CKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=I06IP8OMpVQGHHEecVW9tziaqLhe1IrGmcpFFL3aS9o=; b=iaLmV4G0
        1HkuMOMXHLl4b/85puHi2MnVPW15/393AJH63gdBwEx2nYgnqNQaxneNFcbEtKQD
        wsmfO1UG+trCX8oQFkvCQ97br+yq1sGqF6AbpT6Wa2ffg2d54tNEKrh+Wl+Nk0wJ
        +dNwiLDZnIeWNvUEkVKjFmV58KI46psDcBx+a/DkPzshV1f1nv8a+T6dAlrIIxzG
        /idsvYcsB66YuV0jUFWlcS5L+sjCfDlzY/ZjM2knG/m9fT8yzzvb/++8aFRfMj3t
        DLBgucFRZ+ZdTGzb92iKkad9mkClJ1Glq8EqNBKbnt2cMKBL76NrDaz7i9h9MIgh
        TMd9tQLwKB77jA==
X-ME-Sender: <xms:l5OkXxKinpNJ29kM-7Xe71mNWJUb4ubrn8WHXa06Jqv-ZXOlCj0Jpg>
    <xme:l5OkX9JJtawq6o4TEEyGbxory7CcoY-KBKTkAWnQi61IdoNLo4_C_oG8ceDJiv38O
    8RrJySFSV8isTeJ8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:l5OkX5tye4o2HwXKN-cmsbLTc7RfwCwrVkJerxcypn7anBpx_TPzrw>
    <xmx:l5OkXyZ6TjWQU4euifepsymRT8wUMJ41GNDeezZ3ymp7IiJiggYqvw>
    <xmx:l5OkX4bqc__cGJRX_0ullIH5mBpWL29Rt2YqczJQLpAu4izsq0h7ow>
    <xmx:l5OkX3yyK_ktGhcZg5dkvHN-1iBaBZCg_2-FJpt6y7krJMP17ewYTg>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 427D63280261;
        Thu,  5 Nov 2020 19:06:46 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v4 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Thu,  5 Nov 2020 16:06:34 -0800
Message-Id: <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604620776.git.dxu@dxuuu.xyz>
References: <cover.1604620776.git.dxu@dxuuu.xyz>
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
index e6d5fcc2cdf3..82a67dde136b 100644
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
 		}
+
+		*(unsigned long *)(dst+res) = c;
+
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
2.28.0

