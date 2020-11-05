Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235772A8737
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgKETaD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:30:03 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50953 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731060AbgKETaB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 14:30:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 60AAB5C00A1;
        Thu,  5 Nov 2020 14:30:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 14:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=I06IP8OMpVQGH
        HEecVW9tziaqLhe1IrGmcpFFL3aS9o=; b=cR6iYAy+br7+lDd423zg27fWvLnUM
        kd2z8kqCTMaaiYfA5FR0NjciSy/05qEDKN/5mOR7UNPloSPw2dQbk+u1lJhIkoAL
        pfviUgAFRzgivpLVjLYAXPGKrX71vG20bIr8u1dvPZTkNk4J/22wj6Kvi8kdNgmE
        erFcKdACewkkcfkhqqtZLdPsIxQMobJWZbwjW+hKHRhEehiMK0wmU9Pd0vjYA7q5
        L06gofM3e516gjQSr41Fj6l9Kwn/e7s+9CzKFE7DlfmiFX/NmKeATzOKZHYFbzlz
        NiI3NrT2n3UcHnN3Ga1VjncRLEhkRiMZ1U+9mtboahekEWpGmW0wYMKRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=I06IP8OMpVQGHHEecVW9tziaqLhe1IrGmcpFFL3aS9o=; b=eO+k7zxF
        QobUpQgTXQuSnbhb2h3ms9tNcwVs3UPUjsDu0TvoWFwnoxj1ds3nHkuj15+HJJ19
        F1q0vPx786VQCB/QYThS7varOuupG050OBaW3ji3BCtgLBcOYD0UYdySe1+vPQlw
        qF1o/nwaoB3fvZlyMJH/abqgCx6O0jIub+JTpcytDF3bLBucP+iY0ZhN17VxZlna
        aAokDoJslK4IOSV3rVPlC7r6uXZrQ2gcRAhct8Z/pMlvQhb9f7IxQenNgAvYvxUA
        HJW+fAE+5TjyprH47m6mWGGwRF/22S1yeVXSH5mfo53VrvtT7HSTmu3MNbIWCfgQ
        q7EqiChiekwjbA==
X-ME-Sender: <xms:uFKkXxkG_VcJa6GBVZ7hOjxFUtmdY31SUB8ePphngkyRUtUWULfj1Q>
    <xme:uFKkX80qOF-sL8n-888WjeNHNVaLf9TU-2P5B84R1mYlzzaEOfLHAnm-lXbCANc7Q
    rCHynFk7GW5OwuHXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhf
    eggfdvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeeiledrudekuddr
    uddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:uFKkX3q_ujP_6vobCSpnQdSpjuli5BCjj7HtGYz2fCRLpnZfqhg4Yw>
    <xmx:uFKkXxmP5mOU0d2ggApAhkKz_0bNPRaQCyXvP1P9aoR9O4glryVAbw>
    <xmx:uFKkX_0nC4P56zOQ_v16vEeqo0bH7bX-A9XxFEUEb7nuaXVk3xi7eQ>
    <xmx:uFKkX6Q1BA1b_mxK6n869RJXajOD-M4ES_QYLevrmpratgpv93KIDg>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74DE73280391;
        Thu,  5 Nov 2020 14:29:59 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v3 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Thu,  5 Nov 2020 11:29:21 -0800
Message-Id: <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604604240.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604604240.git.dxu@dxuuu.xyz>
References: <cover.1604604240.git.dxu@dxuuu.xyz>
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

