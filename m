Return-Path: <bpf+bounces-49331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0367A17689
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 05:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE47318835E2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 04:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C1925A3;
	Tue, 21 Jan 2025 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="G5OKWgIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHA1YrPY"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AEC45979;
	Tue, 21 Jan 2025 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434130; cv=none; b=rqQwLPkAeP3/fewP8Twz1VJ3rfFLzOj87qvHefqqIVSyvgcX/cpxRvtTcGhLZ5nOpomrv+nr/NrHGRQeP1LMFUsbe4LBaXuaX4CV2/BfUlkvvuwx84xbi1Ln5CXMCaghSPmxYygINrO9XZ6AnCNiFVzuFBnnblA3J/k4fDzuUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434130; c=relaxed/simple;
	bh=lCfRqpWzuMZujFZShQOZDbGeVUrsywbdtwi215buqbs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lYY2+PIjLHCsKhUt2jlvNEkPM7dkdB31sT7IUavSLGCVvshyjEXN6gyf5MuYNqjMQkPYy1MwRV1YIjHlM3gmWKGtqHCePlq+7nIIPmkgwg1UNp4QxmhlQO5g0jrAHWlccgBY/Tqu5dKdXsFrexnnAx+mBpxyrS5EJeN9XhJ0c38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=G5OKWgIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHA1YrPY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DA1211401CA;
	Mon, 20 Jan 2025 23:35:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Jan 2025 23:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1737434127; x=1737520527; bh=21HB76OBIiKme0LcFSfhy
	Qqla8eDvukUY0J6sp+JmkU=; b=G5OKWgIrF/xSaGbPLGLm6WdVtK8dcrpjVqXHI
	kolPkXIgrm/GfCvfLIUGUzO+WIUP1Ci+a8WZa+Yymo+duOwypFgEg5ataU1Pv6+h
	jQY5Hqa/xrBZ1xBVbEcLpf9CE+Op4O+0Bipc0AhCwZYSJ//lWjIY1h9cv2xOEzhD
	ezXzmnonao9u2aLWUVp7+Y/9cnOdGxMvGdXL42VvZmqpphYjoxWb0UR4M02/nUlW
	uYenug+MSKVCIbJu5D1dbccHkexssiEw54ZcoND6OvoDA1yaIruaP6Wvanrli+LJ
	/+CL6b0tBQlwzqcpbfmSpIPMuWgadL/4nWSM4OE2uAD+Ah+vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737434127; x=1737520527; bh=21HB76OBIiKme0LcFSfhyQqla8eDvukUY0J
	6sp+JmkU=; b=WHA1YrPYjUmZLPNj9t8di97nHPpVRmsM0D4S5+KwAqhJoDaf7CV
	PQcFmXgnK+4/F4mWc1lob6DRZzj3hKHUG120Ju7HxEeGDk8r4ytyMPWyl6HTJeGq
	HVQFs2YN/VA5BLuXF2yN6MxynZ69x5+tKZq3dmm2FPNnrLe3LntCmlSWs15qkQnY
	RhdZ6t7qXPwXYKnDOv0/XQtyKCc7TB3XwS/F4o4ogQXmP7zzcajUsktpAcezlPRq
	ZcgmvgwSnyyGQSDTAQsX4EuTsnJY/28F9T6bk4fJ9c1fcgA4nIkZ1AAc3lTf7VxC
	QxLBfL0zUGCKkgvhCCn31ylLNB71/NDad6A==
X-ME-Sender: <xms:DiSPZ3r3jkDeMxqmqUVMt1ULvmPwxlqiS4beMfjoqXh-2OUSCVnmNw>
    <xme:DiSPZxoXpSeWZ2FwAfuwUiCY4IaXK8FJUJNV6MvFSlguI3k4T7vT5D9hUUs6sM2Aq
    NiPLZcUilreHfgY0w>
X-ME-Received: <xmr:DiSPZ0OKZAN0qSS8GjFRQXiQQlhiHdm6i3Ba7NzgaV0rWPrzPfPL7_vNpDBpZ19TWyb6NlPr3IChomYn8yJsXxNbqAYMmK55iNQ-wFXqQ6hgL3VebvKr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeiff
    fgledvffeitdeljedvteeffeeivdefheeiveevjeduieeigfetieevieffffenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuh
    hurdighiiipdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DiSPZ658rpol8HEbhgKzA2JcXhZr5HY_Om9STbnzGnatZVWk-c8iMw>
    <xmx:DiSPZ24u-7AqDOr-nHE5-zBk5ycIjvUUHiSJO9Tu3qa0YWgL0hfB7Q>
    <xmx:DiSPZyg1-LjaXbsWnSBOc4ejYRalC2ZlI79ALpvk9smqsNV-rs265Q>
    <xmx:DiSPZ44j7uSucbC8x0vEBoONKWcc7x-Fn7iZdd8w-xgrphPWP9HoQQ>
    <xmx:DySPZ8kXc215Bv7R3YcHFdmeqzVJP205HBy04Dgs9XjQoKmsnPOFwOlU>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 23:35:25 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf: Omit inlined bounds checks for null elided map lookups
Date: Mon, 20 Jan 2025 21:35:09 -0700
Message-ID: <cover.1737433945.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up the null elision patchset with a corresponding codegen
change. When the lookup is known to be inbounds, the inlined lookup can
skip the bounds check.

See final commit for the JIT diff.

Daniel Xu (3):
  bpf: verifier: Store null elision decision in insn_aux_data
  bpf: map: Thread null elision metadata to map_gen_lookup
  bpf: arraymap: Skip boundscheck during inlining when possible

 include/linux/bpf.h          |  2 +-
 include/linux/bpf_verifier.h |  4 ++++
 kernel/bpf/arraymap.c        | 35 ++++++++++++++++++++++-------------
 kernel/bpf/hashtab.c         | 14 ++++++++++----
 kernel/bpf/verifier.c        |  6 ++++--
 net/xdp/xskmap.c             |  4 +++-
 6 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.47.1


