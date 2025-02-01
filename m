Return-Path: <bpf+bounces-50278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12BA24BC8
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82991886451
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959661CD1FB;
	Sat,  1 Feb 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fqSBHOzA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAxYG7OO"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656941C548A;
	Sat,  1 Feb 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440717; cv=none; b=ncNpGaIMgavDYc9kIc4DjmfchKb/KObfq8dqjzsGYfBiZZyNxsQHigMzqkyOgFZ3woMjw2AuBij56hHJ66T0YPlTG/IWXI1aYiNW5I1smMjuxnk9GaDXVBn/Rrazc3bjsg08j8915ogOV+v/fcQPmyQf8IcNEV6FaM0A/w6GJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440717; c=relaxed/simple;
	bh=Q5mCq6shSkFpq9lHWiWAJMGvKLBJ8p/R9QS98UXq0vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6FCN9tzV2xdfQ6K+SHjYJHpgqtAkPeiw5Jx5BxUG4cCeo6fOXpR/e3W25Ukku6BWPS23RLPQnjop+gBn+dMw7IFpsDmbbZPWNOz8J9V0PzpCNHmJoHZoxkzM4H4szc+7DB1eU65sGwERe4RtXxhuy2h3Id62geEbq9sXO05F+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fqSBHOzA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAxYG7OO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AA8C2540085;
	Sat,  1 Feb 2025 15:11:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 01 Feb 2025 15:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1738440714; x=1738527114; bh=/OkNhKrEHdGBSK5Yl02y0
	WheMNO2aueSwMxSLHTsoTs=; b=fqSBHOzAWu9J4ppBcbBLvH2eEik7WEDcAm5sz
	ELZ205rzhGGVRO+liNJxxDn8ergBnOyedOocv75BuDXfZ8vfOliATblLEq9JyXzE
	Bh3x25PLvhrtAdhmaQX0RocdusAkiWR6xZDS80Khf8gk2X8MzgGBETC6vOjgbmRn
	dt0FIxrkWtNWtR0IwBWBQecNprTVAjRE1sKyNv5mKXNy8znpY7RsGHIqcDqq/8k4
	S60wlEDTTBgLnsOjzB1Z6T9euPLAnzK2zPYTuGDz0QkhxH06uwsrx6Nf+pWQAySx
	q5avybuS8MpI+TCfCNicnph729ivnTrcV4jnH3dvrDhpuiPSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738440714; x=1738527114; bh=/OkNhKrEHdGBSK5Yl02y0WheMNO2aueSwMx
	SLHTsoTs=; b=KAxYG7OO1FW10eY6lfCTneBYvOsbATOu4h8+QQeYufi7P3KrzCO
	lfzfH7+S5Qt+qjRocn5DxzGsGMKDFNoKP4Y4iDuUHqxPLBoV+J6k1MfSPKVHTKAn
	a2JlOeXt+T05/99/uLkGctSNqDhjAAbtRYKOzfQxgHAybXHs/reOR44oyoEChfs4
	LipKAE3XK/k2bXGijRhqljqwxG/nzqDuBtBQYW7qJ20SdDfrkkYEiBN3ceeo2E89
	XPJYsKFhaMHnkeS8BOEvYI3fNef7TKypip6GzcMdeDOIrw6xS5tSOMl8ZRAdJc8l
	ZootbK8f+OjDDa9TZCaN1w4whNmbgeaDuMw==
X-ME-Sender: <xms:CYCeZ4A4vc9NsFXqCtZQCizuYa5FHw0HymYPrSmZZJrwhZssNeUoVg>
    <xme:CYCeZ6gqStIb90kr3gpQJkoksyOCuPI4MRDep6hOQNkkanpHjd6AQm9KAff6JX98Q
    B9xph3VDLbS8R2kDA>
X-ME-Received: <xmr:CYCeZ7lxJyaPFp3a7Awio_-CMJUJx79Gydv197ft4ef-1NAhWN-vTrmub9bmfGj_lAHCBENq2g5bGksLejERsoxl-ffuxUjsC24n22GESXCpepZWIcq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    dvgefgtefgleehhfeufeekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhksghuihhlugesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    holhhsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CoCeZ-wNZzho4StStjA0HFUKwjQIxbVPgsEVDdjQc1q6HKvGgIs3XA>
    <xmx:CoCeZ9S5NlQ0lB3oKLhXF5alrDoVZ7zZ6ybCz1p3x1Su2DBMAznaiA>
    <xmx:CoCeZ5YzmK6bhS6Wt5uNwFQ01zJV3semZBLT6qcAkSqT7lLUeHM2Gg>
    <xmx:CoCeZ2RMDCqGSRh5X1EKqnCqKx7mJTK20Av0IRyM1UkYkNTIblCeGw>
    <xmx:CoCeZ7ODbYq4lR9dN8OvmVV1NailnhESaGys3tiMkPdBcmn2ysYahdPU>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Feb 2025 15:11:53 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	jolsa@kernel.org
Subject: [PATCH] tools/build: Skip jobserver flgas in -s detection
Date: Sat,  1 Feb 2025 13:11:40 -0700
Message-ID: <40ab531dfb491020ae1cc07d68dd03b0fb1d1fc8.1738440683.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is unnecessarily verbose output:

    $ make -j8 bzImage
    mkdir -p /home/dlxu/dev/linux/tools/objtool && make
      O=/home/dlxu/dev/linux subdir=tools/objtool --no-print-directory -C
      objtool
    mkdir -p /home/dlxu/dev/linux/tools/bpf/resolve_btfids && make
      O=/home/dlxu/dev/linux subdir=tools/bpf/resolve_btfids
      --no-print-directory -C bpf/resolve_btfids
      INSTALL libsubcmd_headers
      INSTALL libsubcmd_headers
      UPD     include/config/kernel.release

The reason this happens is that it seems that make is internally adding
the following flag to $(MAKEFLAGS):

    ---jobserver-auth=fifo:/tmp/GMfifo1880691

This breaks -s detection which searches for 's' in $(short-opts), as any
this entire long flag is treated as a short flag and the presence of any
's' triggers silent=1.

Fix by filtering out such flags so it's still correct to do a substring
search for 's'.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/scripts/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c7..a413f73a7856 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -139,9 +139,9 @@ endif
 # If the user is running make -s (silent mode), suppress echoing of commands
 # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
 ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
+short-opts := $(filter-out ---%,$(firstword -$(MAKEFLAGS)))
 else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
+short-opts := $(filter-out --% ---%,$(MAKEFLAGS))
 endif
 
 ifneq ($(findstring s,$(short-opts)),)
-- 
2.47.1


