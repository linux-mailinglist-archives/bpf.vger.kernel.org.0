Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16A2B539B
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 22:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKPVRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 16:17:51 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54381 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgKPVRt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 16:17:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6B056D38;
        Mon, 16 Nov 2020 16:17:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 16 Nov 2020 16:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Qu8S2T3pVw4yE
        Yxi6pqulgrwimeoqQCtqPxsZtatJAU=; b=e0W/3HeM7MaZhZ11m2ld7VGTWtrS5
        e7BUTcm8/qYG7CVJWLugC4658iMPvjdX2kyemwNqhTqVcUG091vc/wKBtMj2OLNN
        EVvww6y9X+5g32kx7+O71XfipAERJCEdR9g5cSE5u0js0RuKSIRPpyv+FNtjAC3p
        XkhZ79XzymErC+rzRYiAO/bvVJHuXy/R+ryS2JdiZCVpcrzPGB+Mnwf8pzyF/HWw
        N+dnxMDROA1DG10Od2/FOVSx4uEmmsk1rNGWg/joBLMAbMHm+BhFlNfjsByvPcXF
        621njcAYMVBfbdSHz9R1h5+scny86CCAjEs3K5QhiweOiBlN6BZys61ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Qu8S2T3pVw4yEYxi6pqulgrwimeoqQCtqPxsZtatJAU=; b=oLxX6gvW
        +O3o4bD5A3iXwATBrOI8Mqc2pzQKGtUS85piFuvizP5Pnl2GSZZOZ5a9vLvB33Mt
        +77BVlbBxcNt0mziXresxeLmvzgevXm1IFet3JzylyfxzPbKg+QM2x5iCZ/ZDYEi
        QOv9ny1NBZ5Ppcqh3/23zg5sLG71Og9jbK8wE2xdM4XRt9RhC8nJlm7gOpRH7fD5
        WXwIVgw7kMyyBrDVV24KxxyyjYgkGrE+aQzFcIW9XKrAyVZQcoi7tFMOeVg3sdYt
        yStRpIKEvD3BH8MwyH3HsukRRu8xQrIoQ6lW6LcYiPWSXmZymolI8LSuiqmuBt9f
        lUIipcZPDOH8iQ==
X-ME-Sender: <xms:e-yyX2ynqR7O4IyypNjMpUb3I0l3RHd_4htbSWOYF02NtTNVKkvsFg>
    <xme:e-yyXyRtLcJO2KTlKJME1GGyNyBrycjlGtZohg4173ResXvrg7BA7ekNsaQQ5q3v0
    q5_q8VV4pNM971mwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhf
    eggfdvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeeiledrudekuddr
    uddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:e-yyX4Uo9klqerAA29mviAYuU2YTVfS2EKtSSl468tjSMtDkzshGHA>
    <xmx:e-yyX8gqtpvNu_t-l8KLIpvygmTc2485Ks6tAttOLc3Ej3G4ssewPA>
    <xmx:e-yyX4CroxNPFIBctcdfVajs1ZovtJX91ou0ZYe1VW0WqEO_ysP3KA>
    <xmx:fOyyX62_vyS6OzLFTwZbkw7blUTzC1LX71IJLJ9Bfv1o2Jlo3y9Wug>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 013A03280066;
        Mon, 16 Nov 2020 16:17:46 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v6 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Mon, 16 Nov 2020 13:17:31 -0800
Message-Id: <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605560917.git.dxu@dxuuu.xyz>
References: <cover.1605560917.git.dxu@dxuuu.xyz>
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
Based on on-list discussion and some off-list discussion with Alexei,
I'd like to propose the v4-style patch without the `(*out & ~mask)`
bit.

We can't really zero out the rest of the buffer due to ABI issues.
The bpf docs state for bpf_probe_read_user_str():

> In case the string length is smaller than *size*, the target is not
> padded with further NUL bytes.

 lib/strncpy_from_user.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index e6d5fcc2cdf3..de084f04e50d 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -35,17 +35,21 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		goto byte_at_a_time;
 
 	while (max >= sizeof(unsigned long)) {
-		unsigned long c, data;
+		unsigned long c, data, mask;
 
 		/* Fall back to byte-at-a-time if we get a page fault */
 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
 
-		*(unsigned long *)(dst+res) = c;
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
+			mask = zero_bytemask(data);
+			*(unsigned long *)(dst+res) = c & mask;
 			return res + find_zero(data);
 		}
+
+		*(unsigned long *)(dst+res) = c;
+
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
 	}
-- 
2.29.2

