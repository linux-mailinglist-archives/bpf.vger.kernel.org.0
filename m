Return-Path: <bpf+bounces-46891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD29F16A6
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2CA1885696
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EF61F03EB;
	Fri, 13 Dec 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JOsaka5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhFt5R1L"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BF1EE03C;
	Fri, 13 Dec 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119068; cv=none; b=J0aCpZzbLVBDTxcajLNNegN4BsFet4WBilwLv3Ganp3J0vIJzGdnxR4GQvQvJXf2N1ggNrGGEgmFEtkaodnO4RglXi2YkQjfN3IqXwbp/R24vi+0q/3I5oauHrr3addPXftjmm16us2QV6lriG/H6YqS/z9BNmsmGqhr+RYXne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119068; c=relaxed/simple;
	bh=xxjFD9Hj5YUqHTUhy0eKOIT14MQBXPozrxJ0m5PQGsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYvbV6AXQGp0DLqXScBfSFsVi4VoLd+E76HIkk9dBbLdbNRmG+PBRJghZYOqAyuVvKAZGm4MEHk8xB8diKVAE7Dp+tytzKpkzj07X5I+bNy+MQ6fI7ceY1N2kd/VX3duf1JWws0aIwngKukjC/C1nAOUsU/tCA9k8RUq2D7/vLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JOsaka5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhFt5R1L; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F0DE1140189;
	Fri, 13 Dec 2024 14:44:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Dec 2024 14:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734119065; x=
	1734205465; bh=sYAU7uN4FLAT86HvspuDCpL7NoZlksxeDfGgZHhfGGw=; b=J
	Osaka5hL8/qq5YUR1Dsl8XQ0kpQHXYW0tG600SKzhaUidV5YWdwdl0ciTeF/jmNh
	2KcP4kXxdMbkjOHyY2pDy63uUyVjyWbzZdjU7DVjo5nDFEYcsQPVWLKo1Egftvp8
	Zl/Hf30DgtUVkVd0JZ2l+B1dpC5JAAUxL2jsCIoExT6WOWQ+3KReDnefu6mXkkJS
	HI0zEZ0P4VuX9DovbOlINNCpQpPe3HVihYt4v0AYTBy4kwHg9FA9svge5ISxjtSh
	YFKs/UuDB1xZsQUtP9rc+2Bp58Pvlj61ZPWhZI5LDr7Ix2t5/I3MsG3CJtMZ13Eq
	uaVhAjt4yvEXpmlTT9MDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734119065; x=1734205465; bh=s
	YAU7uN4FLAT86HvspuDCpL7NoZlksxeDfGgZHhfGGw=; b=UhFt5R1LWaGkG1QUd
	So6uaQjOZUwJIa9rMwFw4qtSGlhxnjwHKUlkhS3CVd3g6oqsj9xljfocjaGl8/zO
	W/Gnalt0CqlqsuFenms/JXS4yS4r2VDbTOduBq2+Gc8KJmERNXYqOTIAM0mhptfO
	7yudobKH2Q0I2YQoICtYIxlPsnXr7fBiljTljUjaOY1n9iOHB1LLfE+AHbKHsrPh
	Gs14CRjJG8Fy0RTm9Lq6IwfAmXTNamKlawyB71jYgdqYNcKLl0MfBuxBpCW72QGE
	+FpVuyiPMIuzQL+kCU6vPziJwwhxepI83AEFVHMZW86Fb8fb+9hQ/wOJM9VyzJEI
	x8FaQ==
X-ME-Sender: <xms:mI5cZ01JbNGQ03cthjCkCbuC08x8EV9PfITALHJJ-G9lNTEqPnUCUA>
    <xme:mI5cZ_F_6BXOZKn-mxyG4uRjzCWqesshPIGzpRsRw75QNvvscKT5feeKdHvGP988h
    xNyY1_JpIY2H5nyBQ>
X-ME-Received: <xmr:mI5cZ85XfR6eQ3ioDDiRZeee7GSblKbYTCZrBvFzCSoMVv_d9uWy_sK1bmwk5XTiP9fcBWsATjxiCwGPv2xp_W-8r3M0lXVATQttVpQNn3kXa0d3MEhj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    hqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    grrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjees
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthho
    pehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mI5cZ93iDHNifhMQmjK7Anilt__R3L8ufjOvgUrq9sK7Fcf_DuB7Qg>
    <xmx:mI5cZ3HqTpYuMqx4-IpL5yVLK4RuyxFGwK9QgSUWeWsW2WAr5gswDA>
    <xmx:mI5cZ2_0TYUk1PbyT3XTAetMPYMhzl92ARnkk6GzkRm1V-KjBG48iQ>
    <xmx:mI5cZ8levtYQ6di6Esk3YKD7_qxz1TmHrDCJL_CyvhMTZAfFjfEJ_A>
    <xmx:mY5cZ1-tHI_UbGjMq8dulzxaN-eL1_ATuJtX6woCgZ-RtF0VOPrzCFQZ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 14:44:22 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	qmo@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v5 1/4] bpftool: man: Add missing format argument to command description
Date: Fri, 13 Dec 2024 12:44:09 -0700
Message-ID: <140402f22fc377fba4c34376b7e1d2eba2c276b1.1734119028.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734119028.git.dxu@dxuuu.xyz>
References: <cover.1734119028.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command description was missing the optional argument. Add it there
for consistency with the rest of the commands.

Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index 3f6bca03ad2e..245569f43035 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -43,7 +43,7 @@ bpftool btf { show | list } [id *BTF_ID*]
     that hold open file descriptors (FDs) against BTF objects. On such kernels
     bpftool will automatically emit this information as well.
 
-bpftool btf dump *BTF_SRC*
+bpftool btf dump *BTF_SRC* [format *FORMAT*]
     Dump BTF entries from a given *BTF_SRC*.
 
     When **id** is specified, BTF object with that ID will be loaded and all
-- 
2.46.0


