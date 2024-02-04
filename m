Return-Path: <bpf+bounces-21168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED4849089
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31081F2217A
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181625575;
	Sun,  4 Feb 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UpCK5J4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+5kFjRt"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB32C697;
	Sun,  4 Feb 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080813; cv=none; b=Bf//zMmU7Q+hKm01PYCrwwGVFcTou4UNqeWA4l3i8s7DAnJIcf6ksjEsO8rSezwIeecoPPvg0nUiiBJaPRnVqJHPlolCEjVtWTMih53/9WZp+LqxGOL8ZBXvZSJnoIYLg9PWSXadgdIOvvQsEO+QCLEw36K/kdeNlHXWUVbAHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080813; c=relaxed/simple;
	bh=NITE3fXCxmz6inqylAbpuLy1NnudrR7Xh5aJmakNCSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=laJTUcho06msqNSf2fBaL4q0NSjcyy62XyVwaHK3nxCPTHhBx8uAV9foX2XWEtcsJOE+ZBrcRYrXBEmbDdkiV7EKJOcr+JECKBB5tGdDNej7J2c3oqan8MEdjvXRvj3G0DPJO11RiiWIFJxgDqr6s1eORzKK1T12bbp4aacz7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=UpCK5J4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+5kFjRt; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 322083200A7A;
	Sun,  4 Feb 2024 16:06:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Feb 2024 16:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707080808; x=1707167208; bh=Vmlk2shLBNaJQiu3F7Uia
	uOWXFbhtVDGsu5iEKGc7NY=; b=UpCK5J4byE50PZP5uEGDMgjSwyBOxPB5mtapU
	zrtIlAlZGIYSViGFu+zxHEeG7NfnDdjQQ+M4xYd5Z1bOTmQodNSIddrroRSVZoyZ
	MjtQ9XTspCgRlyGqBzFrAbXxiRsLD3ZpD9/7shCzfRZtbS3Esqc+8kf2hRg4MqPF
	xMG399ms7C58Iz+lbPbIeBQC5K4WWVp4O6VezzDj+PTbUD+SLSMgLR46I86KXuWe
	pqq1Gu2m5rEOuF4Ebvz5NKhmYlS9DfGtygYP1Czgb651ZdP4iJNYkk64YLsdXXHk
	lkl8RoV0r/3LETV0XwtNPFD3YjSvgbj6CWvTaOqIt4GSESWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707080808; x=1707167208; bh=Vmlk2shLBNaJQiu3F7UiauOWXFbh
	tVDGsu5iEKGc7NY=; b=v+5kFjRtzVN3RGYLZx9B0kjl5JPaPcvjc9StFkbmW/4E
	g5l1a2TnUDvf08/49b8F05HsodksJFY7p07S/niQocIabEyd3ZaBGpdO6/cf7nkZ
	xExMPRzWtdb25PDfJ9mrjdIg3xXCPtB3EppCS8wwynUOY8Hogxfue1DR25bJTs2j
	D9AlN8yiDjvWZTcKPG5KAfV5FgJE8smMLw8mfsqyvNwtDtaMgpjn5lFErNyqr+N6
	RIgiWYphmOjzOgWhJsZ8qYZLH1QSIxJTgggPfC2dYoRgqZZcKLn/rjVgRF8MkPzD
	qGRM/zDRiyPw5s3NGdZHfvKHkdKCZA7zEj50efB7HQ==
X-ME-Sender: <xms:aPy_ZTCct1RvSicDyj4foPY2vDXh6cwsUOHg5pEwdVwaFApgx1mwug>
    <xme:aPy_ZZi8tuxPSsdq0wEGeEEINYCmSxvMG8mM2XWvmPEY_f0cGYxO3gdxew3ZrEsfJ
    oChfwZnZf__N_ygWg>
X-ME-Received: <xmr:aPy_Zek0v5pYq9kR0-j_ZWZP07mSUPz9-yi06FD3vDt1B8N36vGSn-o1KPah5Dz5hR_MaK1bFiPlalWfAozoT1aAk9BQ4rMwSBWdTKQu7mS5AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepteefheetvdeugedtiedtfe
    duhedufeejteefjeffjeeugfehtdehveelvedufeejnecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:aPy_ZVxJosbymUtB9t-mxYDIuEdNVz01qZ_ZsfeZpSMe2J9Z8GW0oA>
    <xmx:aPy_ZYSoFQYhBeaR5vjIvJjluYX5lWCrMbn-me5OCUuYJ3-ZokGCtg>
    <xmx:aPy_ZYb0NV_GYbNFGPyGNUDbFh7igEJUU0h8xUL6wzVwGZ6VuQalIA>
    <xmx:aPy_ZePfkFwMMgyHbSUNTNx5zB0-isuj-RKmdKkY0uNtzA3I-lR7Zg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 16:06:47 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com
Subject: [PATCH bpf-next v2 0/2] bpf, bpftool: Support dumping kfunc prototypes from BTF
Date: Sun,  4 Feb 2024 14:06:33 -0700
Message-ID: <cover.1707080349.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset enables dumping kfunc prototypes from bpftool. This is
useful b/c with this patchset, end users will no longer have to manually
define kfunc prototypes. For the kernel tree, this also means we can
drop kfunc prototypes from:

        tools/testing/selftests/bpf/bpf_kfuncs.h
        tools/testing/selftests/bpf/bpf_experimental.h

Example usage:

        $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux

        $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
        extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
        extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
        extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;

Note that this patchset is only effective after the enabling pahole [0]
change is merged and the resulting feature enabled with
--btf_features=decl_tag_kfuncs.

[0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/

=== Changelog ===

From v1:
* Add __weak annotation
* Use btf_dump for kfunc prototypes
* Update kernel bpf_rdonly_cast() signature

Daniel Xu (2):
  bpf: Have bpf_rdonly_cast() take a const pointer
  bpftool: Support dumping kfunc prototypes from BTF

 kernel/bpf/helpers.c    |  4 ++--
 tools/bpf/bpftool/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.42.1


