Return-Path: <bpf+bounces-31658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19C901383
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 23:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D22AB217F6
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 21:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1523D57A;
	Sat,  8 Jun 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="KUW8o2cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="offyt/m9"
X-Original-To: bpf@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E938DFC;
	Sat,  8 Jun 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881388; cv=none; b=tCfFwcyR/DC73ZSJQxUj6GCn4dkUPTjQ9m5KBcSGjNnk+7it592VXyur8t+CXh7XYTTpVBpP/Bf5JM8/JZ9P+EJHnq5tI/YDUJ29fHlBdTRqfozJa+7v61iyN7NE0DP0nUvX0yR9mg26ABowXMNhwddPgDcRzmBZTigY9/X1tkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881388; c=relaxed/simple;
	bh=1FRkFYg7zJUaVztTqTnCYCJuFjfosSHb1IhPIMtuyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzHZFWi91lzXW+eKVr/pH0qzNibwbFF0G+OiUNk/0wDQBR8IUqCnW8zzZMfQ6SLR9fRsSEMbnfuzfFtxXTcg+H9PP5ET2F5YLS0xvjUZqLew0Har5DIFVbAmYkk6QWa0XPfwq156gJI8AJxkNEiMztFAkruRgW6JO6bporuHiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=KUW8o2cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=offyt/m9; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 87B662CC00F7;
	Sat,  8 Jun 2024 17:16:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 08 Jun 2024 17:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881384; x=
	1717888584; bh=dNoqM9yUBbQMzeaSLcHCs4sJAJfrhZjPdHSkRVvF74M=; b=K
	UW8o2cvldfiFYewxTjNGCf3beDdjxES/7DW7sWIf5iMZM3utHXj6A4tAIuPsKINq
	t5sar/wOvWcmc40SSUvxf+zUfOXo/3VvXazS2HNjA9fnRrOJFTMsqKLSRPlMBaKK
	tp/gk3KCbi87GscYNAaBtdZm1d5wGqa3/zCkcEg74Aqh8quLH2WL5Mmy9vDh/pWi
	vQ3AAMNRbW6+bsmZu9pNQq/Up67/dFfJyshM2HDKEhgYgFd7eeMCChsZ3RM1CBqE
	FzjZyysiEDT1SsQ+fTWPYcJl+G8/+Ckb7+FgZb1yM88O2AcHQl35+C7rDrvuNXQT
	smoznf4B4xpQkD+kp9scw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881384; x=
	1717888584; bh=dNoqM9yUBbQMzeaSLcHCs4sJAJfrhZjPdHSkRVvF74M=; b=o
	ffyt/m94C4wDE2RO3ycituRWO3mNoFpHGvFvykeOyDXSaN1fXB9m2KRlS/wYCsK2
	hx3x0mixTVjp0jZRWEts20SL4kNZpb3E4UmDeL3/VnJY4uoRWCWgGBu9gPWEGBJI
	qb4XkD+jvHvP2GvZQr/J96E9BHELCwojWi2opeDhD0pTIKP6xFIO7VuhsusbpPYI
	cCQMVmgBMtun1oHvxYJ8AEvZI9+ktn8TSOvf2MvR1VpPHy/yD7A2cOCK9V8yZ6YY
	8pg7I6d1v4IJ6Q3ttbBqLAbNcOnzNWQd6GSGJ5f5Y7zxGbQOSMVkCUTF5h7wfNXJ
	QpwCu3kSRlnszT3FErV0Q==
X-ME-Sender: <xms:J8pkZiagRD2mzzGmpvohbQiZ_dqG88P8jmvbHA1o2YqHAITmSNNtbA>
    <xme:J8pkZlZwGJ0DUoT-W0GG0FlkCpHzi2Y_VRyL4dlEahx67bGtqohJZoOy5zCXqcVuV
    r142UjKo_81DRBdlw>
X-ME-Received: <xmr:J8pkZs9w_fIHnDtXYdhFSLMwGaxc9ahgKMoKXWn9SBHeFkY62XwvetwER0-z0K5hKDyqsjQwvVRn2yH4_iZ-KMq4Uew_i5Sxv_eIKu90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepleeiudehhfetffeiud
    dtjefguddtkeduleeuleevkeejiedtfeeuuedtleehvdefnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:J8pkZkpu-u6MVMS3Vm4548pBnPv5vQIszLLt5xjOe_5Jxcl5XXhUkw>
    <xmx:J8pkZto1M9QxNQpAxu8uHoPniPx5ev3mR_k_FqeMo39nL3zuFxZtaA>
    <xmx:J8pkZiRmDo6JxVr5thHYKQYaU3F3sDBvS0jEZbUuKVnu4Y5ztl5txg>
    <xmx:J8pkZtpmsz-Rz0nWdNHmhQRfWCsVPoxlHoTsJuQAPAirKQicyURsFA>
    <xmx:KMpkZprjuhLxKLva0MaEseDpzzlNK0X38uGfgDFKNMETAvdJzt6WyWob>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:21 -0400 (EDT)
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
Subject: [PATCH bpf-next v4 01/12] kbuild: bpf: Tell pahole to DECL_TAG kfuncs
Date: Sat,  8 Jun 2024 15:15:57 -0600
Message-ID: <e65d92ed7931999f7046c4115849e14ce1b87105.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
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

[0]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=72e88f29c6f7e14201756e65bd66157427a61aaf

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


