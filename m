Return-Path: <bpf+bounces-21169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAB84908C
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42D81C21476
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44CD2C1BA;
	Sun,  4 Feb 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GKTUL29a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkLT99Zl"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7370A286A2;
	Sun,  4 Feb 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080816; cv=none; b=cP/r783w02q4SkaoMKG/GIVwqmV1jtilYbA8IgTKw5J7ZPLZLJ8RZ6ZSJuFZ1oDVdfkmZlx2UJTl6cu+l7p6LqRYdtYhSSoXPgpxTY1zJ9zKoLDfmV2TZbAyw/Go61u5MnhbVZH0cFzikV7PS8l2dgDszpkpiVOVP4MVxmbcFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080816; c=relaxed/simple;
	bh=gFwS6vxiBgvT11yXjGHqr4yJHWdE/1x2NVikNGRS9H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncqxbJQycGfGTRwa2VMe4vApUg8FD0S1OBaNfPtcBfh+V3WZUaWfsvCLhJco8EujcG3EohcMfCnd2kNMQqOk7rQBEvgKPItp2GpqOnSHNCF5/jzD0ve0i3aZDfrdDOvaYU83xBK2BF0iZ4R96XurWfjkBeB7+Kzf5DSPpYNqLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=GKTUL29a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkLT99Zl; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 3C6103200A20;
	Sun,  4 Feb 2024 16:06:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 04 Feb 2024 16:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707080811; x=
	1707167211; bh=7eOp9MN6MrBcOuvpFREhe6SLoBsf9aJYXjA+m/qLJE4=; b=G
	KTUL29apt61ZrpFR70Qf+Uuf9FuqZ9k4Buify7qqK8AlcXRltsYDO/mlmaliCwYM
	IWNrlFqcXlvzC+7J4PUOnqEzEdQSqs9TSl9mwtELv7VvtOnwrmOCaNcLl3KqqwL4
	V1fD6sYzKjUi888XV+qWdgI/cF4BHeg9GsI6VSPP7b7eYJvU/07qxwg0QWKLOach
	sBlUOM68DyoEpB9sp6fBhIlX1diBetShqJn57puxapBtyRiSRX4rpoOL9/lxHxfQ
	VndPwaYTyEZedqb3/bJJKPD62OLqBrYA3FYr42ezkEZud7hCG0igGiEn9c3FMdV5
	2D1KwSp9RNFoo8RZFzdTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707080811; x=
	1707167211; bh=7eOp9MN6MrBcOuvpFREhe6SLoBsf9aJYXjA+m/qLJE4=; b=b
	kLT99Zlfu9ovowCv4Uw7ncLKddYd5DLh2nMuZ4KunauBexyD+DNR5jE/31Oc9djL
	9QD/UbpbEC6hDPHpenPXTYFkZ2xheSeFWFpregRd1wODOcY03IEPlv3VRH7HucI/
	PgzPWTFqv42nHcIjjp29MWHjDw8kLiey/STVka6qD0KT+5o9y77nHvSUxVHw0/Rh
	VqUnxTwp5CXgjW1sDq6PL19Vl9lb5dINbryy/d5UPLWXKkgH+MA/S2MCur7YLqip
	vLA47Q7/uwi1C3DUGPOUSJOe3U5IQdwDXWn6Gn19eLvbbmr4aCxMhoFC2Glt5fJ0
	S8f9Kad9oZQDxP8Toch2Q==
X-ME-Sender: <xms:a_y_ZR90cIksqrfKs17tlZNNWJIn8DKkPv9kXaXV4z1TKvUzjbqEUw>
    <xme:a_y_ZVtnv8PkAcYirXLkrWjNxIS3hLWwA6OGUj8pesaPlSvhhwhIGFFPRkMRGPrSn
    bMr7-122b1XpbIimA>
X-ME-Received: <xmr:a_y_ZfAbn3hy_iwVg1GCajBYeAJ-tzODxAp4k5msyY8l4KmUIthWI6oR0dcChzglxfRJNYLl9WoXWl0cJBmQjK_D2y74DndD6gkx_DEfNTYAaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:a_y_ZVfx-3Tp-z5PBb6cz2xCLBwC1kSH-0rknmHTwQKRMIItF_gBlw>
    <xmx:a_y_ZWOwkVROnSWafN5zNYRbTEFZPiEQKbAbZfxbBBk9K25Uk_edFA>
    <xmx:a_y_ZXmoq9x90lqOEzys2wfgaAtrhpDnfk2ox_k_SmnsP1mD4v7bwA>
    <xmx:a_y_ZTtephBR6kPYh7r7aJ7NKE3OcJH53KqRGzc5eyAAxZzPJm86tA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 16:06:50 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const pointer
Date: Sun,  4 Feb 2024 14:06:34 -0700
Message-ID: <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707080349.git.dxu@dxuuu.xyz>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is now
exporting a const arg version of bpf_rdonly_cast(). This causes the
following conflicting type error when generating kfunc prototypes from
BTF:

In file included from skeleton/pid_iter.bpf.c:5:
/home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) __ksym __weak;
             ^
./vmlinux.h:135625:14: note: previous declaration is here
extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __ksym;

This is b/c the kernel defines bpf_rdonly_cast() with non-const arg.
Since const arg is more permissive and thus backwards compatible, we
change the kernel definition as well to avoid conflicting type errors.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..3503949b4c1b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2484,9 +2484,9 @@ __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 	return obj;
 }
 
-__bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
+__bpf_kfunc void *bpf_rdonly_cast(const void *obj__ign, u32 btf_id__k)
 {
-	return obj__ign;
+	return (void *)obj__ign;
 }
 
 __bpf_kfunc void bpf_rcu_read_lock(void)
-- 
2.42.1


