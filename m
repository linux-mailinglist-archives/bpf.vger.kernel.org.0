Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC12AFD32
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgKLBcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41073 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbgKKWqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 17:46:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 198FB638;
        Wed, 11 Nov 2020 17:46:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 11 Nov 2020 17:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JB1VBqITSKhPX
        sfUHzxUXkMo7GYuI0H/W3InHGhrcyk=; b=FZqM56GKkg2GCPlbMg3q8u+T9Az+t
        gpirqbGJBKtYgwu1V51EYkZcjDMQalXcufXU1zD8S2GJbbv06JXWvv4OrEwMgxpu
        cJlX5oxhpLzBrB2FC+WEfP+uYww3RhFcUX5oh4LZxXbBADpMuOfF1l3/H9fhhkYU
        RSg6RHDK3yVM659FSxEeh6S7KfyzvfHeooS3UvEXE9nwM3WugIwYxrjDqjFxTrKF
        1bMQs6/Zel4vDnD4d5iOHWnADyxwnB46nPN+0Xa9POFKoDOg5MomazLhVUx9YXFm
        aq7xjaowxPB66KrEyYCiuRcT3rThngwNaTJnKmqhfUdbFufR2OcyqrQsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JB1VBqITSKhPXsfUHzxUXkMo7GYuI0H/W3InHGhrcyk=; b=Y7iH9vFS
        tpwfKsdEayadu45on3j5hG/YDoswnVmEGzG2NXWEEdxhLUb52mhgNXlCFBgpiZE/
        Fa5wVnmgZiFo339m/EVuubuOjtNFmbz29Z2pUFYF4+VyGUMDJ//3KwV+mtkKpa2C
        xLnnqcI+cg90pblb2vfqwUxf1SJwelAig/jTlYAzjkynkzNa1TpeuLT9RV0K8gkn
        EIhCEJ725OobPC/siONBU77D6rcXLpbnJuVaGWYJj6E0DIlwW+k8n3B6t+acnqgj
        HXZNXvLVXg87QI5Wd4OhxtwPTGLdivk5/KEBfZea4GsYALbwDR1FMTCCuF0SVt+L
        whya2eBzv6fObQ==
X-ME-Sender: <xms:y2msXydB13THWVXyYqqKxsuTn1tLTS81NymqXJO9pc30Mq3Rr2oq2g>
    <xme:y2msX8PjGU733wq4f7QvppGu66fBJTrHIOgKPSi-Bi0BkanxZkGyVeqYA1wOhJkmz
    sbaPZLfYAMZWdKR0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:y2msXziEy4zoMhKb28Od8-kN07Nm2j2h4piQkYXntu9f5luybjcxeg>
    <xmx:y2msX_8H9YO3zPxei2J9-rTRB4RMk6BzwpqjXVRCAsIOP_JgYpMGkw>
    <xmx:y2msX-tF2xGSepwuaOikA6Cq2W-s3JrRTdyTTsyKNYcBCsNFUF6YSQ>
    <xmx:y2msXwUpxdlZcVX-OrDM42bLdjGmjbiiBN4sWUniCDQ-us5NocLKaA>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id B61CC3063080;
        Wed, 11 Nov 2020 17:46:34 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Wed, 11 Nov 2020 14:45:54 -0800
Message-Id: <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605134506.git.dxu@dxuuu.xyz>
References: <cover.1605134506.git.dxu@dxuuu.xyz>
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

This commit has strncpy start copying a byte at a time if a NUL is
spotted.

Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 lib/strncpy_from_user.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index e6d5fcc2cdf3..83180742e729 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -40,12 +40,11 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		/* Fall back to byte-at-a-time if we get a page fault */
 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
 
+		if (has_zero(c, &data, &constants))
+			goto byte_at_a_time;
+
 		*(unsigned long *)(dst+res) = c;
-		if (has_zero(c, &data, &constants)) {
-			data = prep_zero_mask(c, data, &constants);
-			data = create_zero_mask(data);
-			return res + find_zero(data);
-		}
+
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
2.29.2

