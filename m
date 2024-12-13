Return-Path: <bpf+bounces-46890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2D9F16A4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E928F18854E5
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD471EE001;
	Fri, 13 Dec 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nnXeVRdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dK0V1RWZ"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319531EBA07;
	Fri, 13 Dec 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119065; cv=none; b=GDT7QwDRf3uigEucxcUh8YdmysK+9ZXxjdfiwiPQUzdpRnrZhTypNe96Ges987FX4dAiWe2fmKgQWBPd1dLptUFkjJw64CdvSfSklsRXsAbbME3Bm9EoUtpyO/Qq5lpaY/0/EzpkAYc4RiBdkxITzkOcVqez76lfU3Fj50WGQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119065; c=relaxed/simple;
	bh=tAAynOgtZtlFkCkrwaGsM2mIo2CndZ5AEk90qkm05n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpaQAy6cCy5EEjX9mcChKaDTzKu45xvXVTeH5XLmtKci3wb40QXiO2jZJcNDZqzTNxWdJ7TLsrLaaq5TPhp7y2lsax+gpaTWHAKTCls2LMWGdUZV/Nv84koD6tpQCjlxn9YuxzRDyH+j1DbaZZNyPhKDXMOI3F99BFH3EZDeV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=nnXeVRdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dK0V1RWZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28AD3114017B;
	Fri, 13 Dec 2024 14:44:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 14:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734119062; x=1734205462; bh=QyIVSVicPg3sInkc7prdx
	/5YLLMGHH7HWskpw0v1Eu0=; b=nnXeVRdM01SppE6I91Thb1RDiUZeFRF7VTYbs
	TT0RqS5Tkd6zL49X59dQLd0whkdjmENrBz1HQq5al5w5UHfGeotgJpfwtZRoHIc7
	oERSsqJI90Umaegd+DbBwuirG8acQxo0AdO7jqX4LtCB+C5xajmjkM3OB9VPh1c/
	D3o/pU1QT6D8d0gtzEfTeBSKgo88GtMRCEmkEPpemA5DuVg3ZnNEqPI5ym5IyRyq
	04sc3APbHkRhTii1Jyok65TDFiOkp7xEJiZUgjbqAcDi6XUBh3pLnPM9etoZ5h4Z
	4bmnUTaXolVHCnXdRf4RUHiqdmWGi/FKsYPkARMNXnsE1CWWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734119062; x=1734205462; bh=QyIVSVicPg3sInkc7prdx/5YLLMGHH7HWsk
	pw0v1Eu0=; b=dK0V1RWZ9VI1vmIxWIA7uGebLOJHSM9cDuNVuJ8XiomZ+O3kZ2v
	IHKq4LghBSCMwnCKVObxCWgDNfaa5ACtzFG+ytb+JacvkU78AHprAFDOQ5/Ap967
	e3mv1oEQxV8JohdUPX/zCmZnxfr9mzy5XgdM/tXAI3hG8ukhE6SZOx1uq0gAB0fQ
	g89iHll+D+PbdfWcrtfLJUJGLJcbYXjx9eXhCwTcIzenLMUF3I8EpOG0n1ISXHAS
	4Zy/Crn+bOVH6HhxWs8j9rLtXwl3uIgOsD4fjLGHgtMfGJbzJtPKJMDzFs+Ha5fa
	ow6DnuRExO6fSzmBU3jDT3IXuhKvO4wVAdw==
X-ME-Sender: <xms:lY5cZ33Pco6STwGN7pEzIriJJi9b_L2ZKH0FNeHp2TSjzG1rp93piA>
    <xme:lY5cZ2HCfsK_HN9u38W-HB3innLW-AXIsTMv8IbnDXohWEsO6O8NI1aaQ_8yOnCBu
    6z3PUWqOJ5ViTF_Fg>
X-ME-Received: <xmr:lY5cZ35BaPlk8oNAA1z8ZUyNVY3-NIfKpcTX4SLyB4gICHfEXl8P4L8GUbJR21iAJqjRYseHBO0R9psPKpuRrqmLMx5G_Vtgb__5hjXV2Niuk7R0V4-W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfe
    ehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepie
    dtkefgudevteevvefguefhgeeikeelgeehfedtkefffeejgfetteefueekgfeknecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthho
    peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    ughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhtoh
    hnhiesphhhvghnohhmvgdrohhrghdprhgtphhtthhopehtohhkvgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:lY5cZ82CRsUcpbSHSRe0PsF7ZglvSSOkHisAN1KIh5pw8fOoLz3tKQ>
    <xmx:lY5cZ6Gjye9jZ15jXlF7GQ_zcz1nri6fNbwATkDW_dT5m83wCGFPdQ>
    <xmx:lY5cZ9_tLzl8qqNISb-cJ0IQPi_cUDxOE0U37hxeCqNQf4L_9yQriA>
    <xmx:lY5cZ3kzUIeGsDeVqTSTNMuAEp7zkU6knsdX_-wKxc_Q_xHbrRTEFw>
    <xmx:lo5cZ4aFwkhJ1vf0OhUoHT5o191VU0YpG7J3-rK3LRRuNH3dEB7B5MXi>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 14:44:20 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	qmo@kernel.org
Cc: andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org,
	martin.lau@linux.dev
Subject: [PATCH bpf-next v5 0/4] bpftool: btf: Support dumping a single type from file
Date: Fri, 13 Dec 2024 12:44:08 -0700
Message-ID: <cover.1734119028.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some projects, for example xdp-tools [0], prefer to check in a minimized
vmlinux.h rather than the complete file which can get rather large.

However, when you try to add a minimized version of a complex struct (eg
struct xfrm_state), things can get quite complex if you're trying to
manually untangle and deduplicate the dependencies.

This commit teaches bpftool to do a minimized dump of a single type by
providing an optional root_id argument.

Example usage:

    $ ./bpftool btf dump file ~/dev/linux/vmlinux | rg "STRUCT 'xfrm_state'"
    [12643] STRUCT 'xfrm_state' size=912 vlen=58

    $ ./bpftool btf dump file ~/dev/linux/vmlinux root_id 12643 format c
    #ifndef __VMLINUX_H__
    #define __VMLINUX_H__

    [..]

    struct xfrm_type_offload;

    struct xfrm_sec_ctx;

    struct xfrm_state {
            possible_net_t xs_net;
            union {
                    struct hlist_node gclist;
                    struct hlist_node bydst;
            };
            union {
                    struct hlist_node dev_gclist;
                    struct hlist_node bysrc;
            };
            struct hlist_node byspi;
    [..]

[0]: https://github.com/xdp-project/xdp-tools/blob/master/headers/bpf/vmlinux.h

=== Changelog ===

Changes in v5:
* Update bash-completion to support repeating root_id
* Update man page to mention root_id NAND map key/value/kv/all

Changes in v4:
* Support multiple instances of root_id

Changes in v3:
* Make `root_id` a top level btf-dump argument rather than attached to `file`
* Update bash completion script
* Refactor root_type_ids checking to after btf handle creation
* Update help messages and fix existing man page inconsistency

Changes in v2:
* Add early error check for invalid BTF ID

Daniel Xu (4):
  bpftool: man: Add missing format argument to command description
  bpftool: btf: Validate root_type_ids early
  bpftool: btf: Support dumping a specific types from file
  bpftool: bash: Add bash completion for root_id argument

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  9 +++-
 tools/bpf/bpftool/bash-completion/bpftool     |  7 ++-
 tools/bpf/bpftool/btf.c                       | 51 ++++++++++++++++++-
 3 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.46.0


