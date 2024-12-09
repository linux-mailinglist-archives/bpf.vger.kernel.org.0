Return-Path: <bpf+bounces-46433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84909EA311
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B875B166B96
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9918B495;
	Mon,  9 Dec 2024 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HBniydiw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hx8+x14t"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD4226189;
	Mon,  9 Dec 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787908; cv=none; b=j+Kfb9wrEVTelTw2UL9iZfs2cffcpY5XyVipgnnI7JnLCbbk0qxxiitc9eDIUPH92nbav3hzOHkHtyebhGMtThGqpgBsb+OB06ok9xu+/MGfAtEseMGO03U+aGGzrR6YhPU8zB8IY9fS9Lb40XSE/uDRqU72lW9kIQ8/5skDD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787908; c=relaxed/simple;
	bh=fOnBXHIAuJzE69Hz+Tu/sV6nKrtFajTIcLJ7FIXBo/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYBtNNluv3ozxWbyPg0raUJKHI4XQ94tHO4VQQEwz1ZS5RPUXtdCZL6sogHvl62+fhCC4SvjpLa75SZS4x5BLdeFA3sVe5Z/OeWxom4jrIet05aNvTv1okdD0YL0t4cMnS9+iNl/Yn9DulrBLF9IGz5DpW1hSkazh+FQuN0zI/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HBniydiw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hx8+x14t; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BA752540143;
	Mon,  9 Dec 2024 18:45:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 09 Dec 2024 18:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1733787905; x=1733874305; bh=cvkcFxFnEzqNudK34KaNb
	KjEuuWQ+WuBmDyvs2JoXoI=; b=HBniydiwb2yl3TUam+pW5JjwCxko8Um/aknJK
	30ce7RXqHCYyPL6OvuvNpyF/2UmnsXsATYs1VnKbsr5U2K4BC+eUvxHgX5fNeRGy
	pjBPX0XpR1Ij64ZWt8rdLrRjipPB5g54mh7Pn+E6vLKOOvC30E8fubnP3XwOwNGN
	floseDOymAd6JvIML7PkZyZph85nbc7lOZAKicpr7vA2eJEpUDoIfHlAJf7uN/ri
	Fx1zs0Hr8tSeOFnzB0lAL/Dl5uXIovLwkOZrmTQ3MVSokUFEYv1OWOqMfZdTEWv9
	e5DQSoSbg/J5MAuvGBYyutn8oB5hI8gujVimAtJe8kczIZggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733787905; x=1733874305; bh=cvkcFxFnEzqNudK34KaNbKjEuuWQ+WuBmDy
	vs2JoXoI=; b=Hx8+x14tJBg99IVN6qtVcSU3vrJ2M4lN1kYWFsiF+NcvE+8aX7f
	Zk1kuWwM1XGZIGk58MW9w6Cfk/0a6x/hiZZIh8N7uE9KrRRS5xrLV+GIDwhadWBi
	1ecT3V/yNyawJuikcOfanQpQIC+FpE4Gdnur3tOShOXcEvIyOIdw1IvpR3nxfPtu
	p1NOGStwYGHh3iekLhf1nXAkjknuqURWH89rEFZ6aPUdi/KCn4c1inmbC0K/z2OT
	gcFiJ5GJGfePKDmrkUOLWdGDFuvkxbXCL0hjAbOFmVbl7BWtAwx3hMjKFm8/N9Yg
	qZ20K+a9HioQNqfZnLNYbZxBTBMJWFUTQYw==
X-ME-Sender: <xms:AIFXZ9OzkGOJK-LDl3FyeSxOfiL6ITZCXqyiyfJnvyw3_XCd2lqpEA>
    <xme:AIFXZ_8-pm6lB7vn_H5cgx7usbKft0GaFhfIjw22Te6Vx0VBSAoxZ9FyY_qoCX9NK
    DPEQWK7tKhPxmRvPw>
X-ME-Received: <xmr:AIFXZ8RE1qUl7XmxD5c0Q2AFUvxu1zsZyypBerECOacrreF5bbeIgE12U4Fg2i1NLso8vE-RVXo6IIh0Tbnziu-GbU1dVcyJzCtr-LdXzxRuuS7KqHfL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeitd
    ekgfduveetveevgfeuhfegieekleegheeftdekffefjefgteetfeeukefgkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhht
    ohhnhiesphhhvghnohhmvgdrohhrghdprhgtphhtthhopehtohhkvgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:AYFXZ5vLlr_YItdHbLSrgv__s-mVQi_VxiMrLEPwCEHPh5DJQF_xSg>
    <xmx:AYFXZ1e3SWcCWwOFZmVB1doZLDXu0pXW1cobVC-AKCZmNxmi9jbC2w>
    <xmx:AYFXZ13WNSx1Nn-Nvk12pnAGZOaULvcZwkZrYptTCnUpwD9CDi2AwA>
    <xmx:AYFXZx9l3efe3HBI2BiMeSq9MOMW-zNAfGg82cfCnXuf3GFpp4bUYg>
    <xmx:AYFXZ_uGqYIceT28LYqJT9LsVJWNubKekQojh5MNph6OowzeUOXqaL-F>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:45:04 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	qmo@kernel.org
Cc: antony@phenome.org,
	toke@kernel.org,
	martin.lau@linux.dev
Subject: [PATCH bpf-next v3 0/4] bpftool: btf: Support dumping a single type from file
Date: Mon,  9 Dec 2024 16:44:31 -0700
Message-ID: <cover.1733787798.git.dxu@dxuuu.xyz>
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
  bpftool: btf: Support dumping a single type from file
  bpftool: bash: Add bash completion for root_id argument

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 ++--
 tools/bpf/bpftool/bash-completion/bpftool     |  7 ++--
 tools/bpf/bpftool/btf.c                       | 33 ++++++++++++++++++-
 3 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.46.0


