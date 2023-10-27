Return-Path: <bpf+bounces-13473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E67DA0F1
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BF6B21497
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F43B7AA;
	Fri, 27 Oct 2023 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="U2jKeIKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tf3bKV08"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CD3D968
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:46:56 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7033ED42;
	Fri, 27 Oct 2023 11:46:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 52AA05C011D;
	Fri, 27 Oct 2023 14:46:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 14:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1698432409; x=
	1698518809; bh=nP9Y4w8cEDkdbu0SQUaqN73Z1uHj1qUJsMQXhKfpDYE=; b=U
	2jKeIKWZhpAFnKOEGisP3X2OTwULVu6uA00edpE2BKVpMbdUps02uL6KvPu8t1Zz
	ceav99cysXwJvpeDVn5yMgf6VqsVPHYmiVBln+ykCseBQCkMl0Mu5Wl3ebOVXTr8
	2AmIlJfhCVlPbasmzGWByRF7OU8gXW6qx0ZuUOuTrT+bK9fOsMCbXp28ML7fuO7j
	VYa+8BxQzcoUG1nmULUXR2Fe3IeowljW/Rbu8/Ek0xVJNPwOR2ZQ8X9Iofho47oG
	5ywhpbvMvpDvRuu4ByQGfp6Z76w1m9touFaZ3l+atBmI5WlJZfntNuUP3T8n0VjR
	1MFUBXqZyPp3fajyPdJ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432409; x=
	1698518809; bh=nP9Y4w8cEDkdbu0SQUaqN73Z1uHj1qUJsMQXhKfpDYE=; b=T
	f3bKV0890z9hGcvgfMP91KTCiXB/N9i249HareWwHbWX0MdFjIz/WB8QxTJnUi4+
	x4prYMZdCeSxrjNauRaJBGX2qWcMLbg2+bpP3Ku6U7A3bRCgcZEIcuLEl7WTCr5D
	gx6ctfdYoAaz1VCVtM/zA1IwvETmayWOohytR3rukueUjkH0oYB79JArSxqTpina
	NmwUca17hHFNaxXqBOXxwIzXZf0FeCiBwXfDcLapOS5d78ua525RJzi/ZjqqxN27
	uk1ns0O9W9fL9ltEhAHgtnFvHThr7uZ/YrGTOJ8skYcyUdoI4rzIW+6WcHg2z1/D
	+zawDQN9TrcofAo+wG6UA==
X-ME-Sender: <xms:mQU8ZW-Gs1aCFD8KdTdSol0NiBKfVnLKKK0ogcP9cCTmCNlxPovQ4w>
    <xme:mQU8ZWsTgq0VnF7hkw8jUsi9CReCdSSOidmTMxm5xq4byHdCokv301HTS_g84zKLm
    eWfppM_2banJv5S4w>
X-ME-Received: <xmr:mQU8ZcC-2GXvNA-s9QqfKe74Df2aN0-OJl-RHiG6w7DpdMJcRxD5QyKjfov3hi5-DVB96IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:mQU8ZecjjbbvPzmCdUFvzIRGzToUvcM4x-qncAWpXGIEFsOE1Yf_zw>
    <xmx:mQU8ZbOXkS_ajVakM-gxnx6xY3NrB2gsoXLlzr7TiWU1O8te1wC9BQ>
    <xmx:mQU8ZYkFM6NrG35quR7FKvZUaAWpI85LXFx5alPBA1LnirVkEU-9EQ>
    <xmx:mQU8ZUzL2ne0A_NZZV2lE-EM5c_xg0Rjxk5jvnxp83kc7FNqcYV5eA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:48 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [RFC bpf-next 5/6] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date: Fri, 27 Oct 2023 12:46:21 -0600
Message-ID: <111a64c3e6ccda6b8a2826491715d4e8a645e384.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to vmlinux.h definitions seems to make the verifier very
unhappy with bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

It looks like disabling CO-RE relocations seem to make the error go
away.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..ec7e04e012ae 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_PRESERVE_ACCESS_INDEX
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
2.42.0


