Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC02B6F94
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 21:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgKQUF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 15:05:58 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47855 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbgKQUF6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 15:05:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A4D24B92;
        Tue, 17 Nov 2020 15:05:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 Nov 2020 15:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=eSrCn2HpzgXUZ
        DlHfeI/vnOmvS5w6Z6yLr13Z/fL+Og=; b=AHxtWFtfXAKfEvwWOflAJeZiEwwAo
        zYsKXfL/mvWHpySnPzJeAvWWUQIlyTQ1jnJkUI+tBjJOkyamfdpRJYy9Shx7+Wic
        EFILX7wL2hsWfTmpQrhBWljuz4SCyyuPxGZ5x19zNchAzX8nBlabZqfgJanL17wj
        Nju1m+2Ax/HI4ysrPp9tBAlQdf63A1CA97BmIYmcQqlogf2wJ5VOkoTgqNe2PZ5/
        xs5HRBbZi1ZGAV6gkmA8KeaqA5XUR8QRLAR2ACZRq6iG3+moRNrPyq5rz4X7h08T
        8gqfjDEszpk0gLy//B6ghkhLNa5Lohw9M6TjL5QZzMdj6wg1cj97fYbtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eSrCn2HpzgXUZDlHfeI/vnOmvS5w6Z6yLr13Z/fL+Og=; b=H5Pn+6Ow
        /DfWfGJeBrz45PCJ//gYnDNnovIV/ichQAKJAeuKT2jxvjUl1+VV7cEhxX8QcRqF
        ILCeNVL6Gi/CzqwBGOJzJW/tssYqSZVMYGFS+yyGfiy1RBkAAPXotyE1HxlSLdhA
        KRLQGJ5/wdc9aHtYdRFf7xsf98EbokWzABiGb+oq+ZxLnBORwfdEytf2kY00zETd
        UHwKvl2GMzEGVltHsDeRof4ecqrE4b4QnllE8pe/ejGdu0ubmSvvpKJS1Ji3iYK8
        d1T/UJjkohWb7i0j5hQHdA/r/j4PBeeSpTThLeuGpvNDqc4VSrIsjGMA0WgYg/0p
        qUtYybgdoYnHBA==
X-ME-Sender: <xms:JC20XwmMq4FMhX5pLUNexaS4vyUleXkslwvZnfqk-58Mos6F82g9og>
    <xme:JC20X_3RHIQzpGs_-gJbO8KEzTmRpnfujaTDCoFH1bBrKBmT6PPH3JavMOmruMBQp
    bhrVd_I03g3I6FEZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeffedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfekudelkefhteevhf
    eggfdvgeefjeefgfeuvddutdfhgffghfehtdeuueetfeeinecukfhppeeiledrudekuddr
    uddthedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JC20X-oOixfV-2b2XotLwmpXMJ74fALnHuzrSllW41P_5u2-Rs_gaw>
    <xmx:JC20X8kBN-YOYr7nZHccp3pMWO2KonJKIXhIkPfTBwh8oWuVToHBTg>
    <xmx:JC20X-0clqD25adipt6Em2LN6m62OY2rTJzJGatEsna6zI-G_dKZfQ>
    <xmx:JC20X4oFKMNSjLkDuwupmqUpmxVLCieGU50EoyUncxMqMlz_R6CIcw>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35CA83064AB3;
        Tue, 17 Nov 2020 15:05:55 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
Date:   Tue, 17 Nov 2020 12:05:45 -0800
Message-Id: <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605642949.git.dxu@dxuuu.xyz>
References: <cover.1605642949.git.dxu@dxuuu.xyz>
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
As mentioned in the v6 discussion, I didn't think it would make a lot
of sense to put a comment in kernel/bpf/hashtab.c:alloc_htab_elem .
I opted to add the comment to bpf_probe_read_user_str_common() b/c it
seems like the next best place. Just let me know if you want it
somewhere else.

 kernel/trace/bpf_trace.c | 10 ++++++++++
 lib/strncpy_from_user.c  | 19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5113fd423cdf..048c655315f1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -181,6 +181,16 @@ bpf_probe_read_user_str_common(void *dst, u32 size,
 {
 	int ret;
 
+	/*
+	 * NB: We rely on strncpy_from_user() not copying junk past the NUL
+	 * terminator into `dst`.
+	 *
+	 * strncpy_from_user() does long-sized strides in the fast path. If the
+	 * strncpy does not mask out the bytes after the NUL in `unsafe_ptr`,
+	 * then there could be junk after the NUL in `dst`. If user takes `dst`
+	 * and keys a hash map with it, then semantically identical strings can
+	 * occupy multiple entries in the map.
+	 */
 	ret = strncpy_from_user_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index e6d5fcc2cdf3..122d8d0e253c 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -35,17 +35,32 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		goto byte_at_a_time;
 
 	while (max >= sizeof(unsigned long)) {
-		unsigned long c, data;
+		unsigned long c, data, mask;
 
 		/* Fall back to byte-at-a-time if we get a page fault */
 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
 
-		*(unsigned long *)(dst+res) = c;
+		/*
+		 * Note that we mask out the bytes following the NUL. This is
+		 * important to do because string oblivious code may read past
+		 * the NUL. For those routines, we don't want to give them
+		 * potentially random bytes after the NUL in `src`.
+		 *
+		 * One example of such code is BPF map keys. BPF treats map keys
+		 * as an opaque set of bytes. Without the post-NUL mask, any BPF
+		 * maps keyed by strings returned from strncpy_from_user() may
+		 * have multiple entries for semantically identical strings.
+		 */
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

