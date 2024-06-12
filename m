Return-Path: <bpf+bounces-31944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E79057D8
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938781C23D2C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66381822DA;
	Wed, 12 Jun 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KGAvvo90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWVZ2jIC"
X-Original-To: bpf@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DD181D08;
	Wed, 12 Jun 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207939; cv=none; b=WXIo34HkA6a+3IsZqr3HvtA5JLdFU94P+1Hy2dJdpuGHPFd0uJPu2qBceYh1wLcNfG1uCVvu0gTtZ0Ho8R1Nx0zfzSuZy7uw3vMZD5VQ6pS13lO7Cfs3GIi2BQAAX1Xq7zPWMMUcdglSZCo7uTnb0KFcTK6yKoZEnzGv2wX0NII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207939; c=relaxed/simple;
	bh=2Z5wN9W0inbqZ97Ehuc3CcPu8Kjqv1M74zO2fI4vjh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iajQkvo5DEAlER9qk7xteDkcN2GTXMqfVwvJuvXdDotyWmvISFS6//FIAWWQjik9Fq2pQfGtWUO3wvxIjHuQC163VMLdaYFAPCgwKmzvm6mZ7vg/OTM7U8WweJ9ZwepoSP7JHgAlyQiDmln0P+KACxEubTl9onIdEZFh0ISk2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KGAvvo90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWVZ2jIC; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 668062CC0175;
	Wed, 12 Jun 2024 11:58:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 12 Jun 2024 11:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207935; x=
	1718215135; bh=rH/enHmFFSCkJWQQx3AT/knRZqgeVvmROxGfjUwJ/WU=; b=K
	GAvvo90/asxnD8xUokIdFyKGZaiyXbj7uiakWGhLcbzaY1DFImh0TCyZl25w9uGV
	aMsM5z5jyBVXzOqYVz7TU4NvigQ7MvSdTgU6cmaNkyoFT6LS1Jhp+5baG4NNMj8I
	Gr0mGns0qbVfFhu67uu0nlJNPzGxKb9ZVk+nKbDzxFYC9BhiyGccuqAl3Sjrtjyw
	oOS1wxJLOw1pMC1Yz0HWznCWzO1POs2MClHDQO05/LfaFX9izlT2JKuDtQXccCNI
	aYrjmK98Md2NDOWSuqdKNFNZ+w3vi4VySI71DT/Ze/IkvJwNsW68XpimZeIiePjj
	sgC93C5mQ8k3VItYkwQOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207935; x=
	1718215135; bh=rH/enHmFFSCkJWQQx3AT/knRZqgeVvmROxGfjUwJ/WU=; b=B
	WVZ2jIC7fEihOXgo6b6jg7XqDr3sEIGXOzj4KVpt6BgmhJm+bdzRYlwZP9eQjanv
	a0AW7yTkMv6KORJX/LT9AMZJT/qpj1Du6eT4zL/lNHzCtSvUlBIfY6jAnYw/IT2R
	nhOFVcm/P2l49vvoKKnyffQpWZHu3yPedUKCToRbcCMUTHt+F2I6gjzkYUBqKggs
	i4fZAuDWa1DA8SpVvn2cefLetbO89p31A8Anl6sTyZZ1i9G47kJbdZ1BLbkPpZS2
	jhISQmRzMYUS8ZBHjaw2x0Pyxg0xUU9kghPPXBgdTxzDKpJXkeC+KILu7+AwRmwu
	G26jVPACrM5q+or2GibUw==
X-ME-Sender: <xms:vsVpZghuupll6NPqnIVYqBMAH-GYUT8EQN4HkNHchNE2UvXvBUn_dw>
    <xme:vsVpZpAlkposkHVKlJmzYGEEAzzAgpn0Es0jHVa5HpTkm3JJTZX-d0r-iMqnfyMNh
    __z6EIBNzrjuyPmBA>
X-ME-Received: <xmr:vsVpZoG2GZaLYmoAEu_u0dI6JlHuhHSmpc_CPzd7dMh6iidquyxxWhCIfoblKtAl_vBI6HTu48oUSms9KPyiI3_VVsglHEO18zcRt5Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepleeiudehhfetffeiud
    dtjefguddtkeduleeuleevkeejiedtfeeuuedtleehvdefnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:vsVpZhQHumTL9BtI9ro5G7BYeMqoNyC4_zSVZdjguoNqu81KLgeFoA>
    <xmx:vsVpZty_RCCnfieGGmNqbR-7Tq4gCEcn94bSABlZEhy7FUnVaGNHAQ>
    <xmx:vsVpZv70W6lrUeP9oghsJFOXkUs1eQB8ND56HH3C7h0NTGyEEcba8Q>
    <xmx:vsVpZqwVCUuk0gs_03UcXuKytmDbDsYyO28ar1t_Z-CQjtYDmrMc7A>
    <xmx:v8VpZizDSBkmpO97HqefRkSO9luDLP5wVN2mV0s_3qIG5Y0PnxlNVKlE>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:58:52 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	daniel@iogearbox.net,
	masahiroy@kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: nathan@kernel.org,
	nicolas@fjasle.eu,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/12] kbuild: bpf: Tell pahole to DECL_TAG kfuncs
Date: Wed, 12 Jun 2024 09:58:25 -0600
Message-ID: <324aac5c627bddb80d9968c30df6382846994cc8.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With [0], pahole can now discover kfuncs and inject DECL_TAG
into BTF. With this commit, we will start shipping said DECL_TAGs
to downstream consumers if pahole supports it.

This is useful for feature probing kfuncs as well as generating
compilable prototypes. This is particularly important as kfuncs
do not have stable ABI.

[0]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=72e88f29c6f7e14201756e65bd66157427a61aaf

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 scripts/Makefile.btf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index bca8a8f26ea4..2597e3d4d6e0 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
 else
 
 # Switch to using --btf_features for v1.26 and later.
-pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
 endif
 
-- 
2.44.0


