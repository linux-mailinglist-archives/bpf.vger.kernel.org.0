Return-Path: <bpf+bounces-46799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313489F021D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1BE284315
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A72207A;
	Fri, 13 Dec 2024 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="CqWi3+cA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlrUESvI"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220F433C4;
	Fri, 13 Dec 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053073; cv=none; b=Em6HC6UDikjeLtJbBK/UI4hHcGK8vurO1y5EeA6uihQdLQ1ufbVCq9hzh6aLN8xF+JGq03CbpIXJkOlkVMAGmjFaqU9fxUwC55IeU0qQJiQ3MCdNTPz6wK8I+50HNbazCit997Uo/sKLVxU2oZlKZUcsRRqDqK7Sgg+p/1vXjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053073; c=relaxed/simple;
	bh=DMj8oz7LHIUdKAXDrcfbaa9O2UYoJNiIJrmR9GnBc+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob8I6+LHkorlYZ3jISYjrDvDDxQOhZPM5m/9JKyateQewcyTBc/jNwFxv+jjXNSY9/+A7mNWRj7wslPJ4Mfg6H2OhX/sMmZtDAHo6TAKCWtCN7JIx7sBYUMLUcIFABZ1DqhFQOxpv6MAclPk2VSfzYPJaafxx8iIJx/ixQbF8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=CqWi3+cA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlrUESvI; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2955B138419E;
	Thu, 12 Dec 2024 20:24:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 20:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1734053070; x=1734139470; bh=E5Sp6tXkXVhQ1LkD9VoAX
	V6ROMUbLC7PmVSWPittQHo=; b=CqWi3+cAM56KCNQ5HfzS5ocjxknuxc+dn0NLV
	RdU2zjzRW2bxpGeZlpz1ZqpZo8X37o3aqiMcbnDNU/wOUr8LX82OFwPPMynXcgW7
	vZE+SA/X0PBnq0jmkqNVpSmOn7ztPfKqhjLSnsWnDvKro1soCKTOXBwG0B5gXw2R
	Ni8vHZu30G3l0Tz5+YY1EuUxPbQYXMi6mwUOPXIMBFRsKZia8tK0KTxkN46QCMwX
	GwimkDB2h7rRutv3MOKRibKZeeDgbpp2EJgdJFID4T8a9KSSO+mubVIimYo+OxCy
	W6MIFJrQAGIt4/kf+gRSFflO2my2Q8MyL41//hyOaVh4vxnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734053070; x=1734139470; bh=E5Sp6tXkXVhQ1LkD9VoAXV6ROMUbLC7PmVS
	WPittQHo=; b=QlrUESvIbM4T9mVIG3sqqCXfbxhWiynLvHQFqklO41NfpZERjdz
	a9Ow3SvEaNcG5lRlKUZjB4j0FnupJxiT8XbO/qpRJdsKqXBflJnQ7LUeFLHiNxLB
	H57MvCEPKaobAmgrFmA8TKvDi2d1V7mMgsmrHtHW5ToAMBuJgBUiZhpqWaKuP/Ib
	l79/Ho2fhiBmJSZr1echem0IrWUjBhZR8XUV1PZeqMhGgATtnSRPjrScZtX7Y3Ub
	TadzhKX9JkkhyOp3aMMFKqSSPtQIK2+upvekNdLNCCmsXT9ISicccxe5hwbVm4qW
	mMEDLIsNQUZHPh+sl1/0nkIjxaP2VwuASAQ==
X-ME-Sender: <xms:zYxbZ6CbEPyud1lww-pbgqYic2HLnUVYeqhCoruuD8IEIEoaG55hWQ>
    <xme:zYxbZ0gfWr48AcV6ftl1fLEYmo71E-D2902TfhqJ3yeUiZbW-Uqej-BUVWJzRerIT
    tUyFwYuzb8Om2CfXA>
X-ME-Received: <xmr:zYxbZ9lZOkJeuZytNe1rXXkNWzylaZTArQ3OWw8QCDkqh2FIXoZMg8gV2JoP5KVIe1eBF8F-_j59x5kr2iOwOvdldrHZMO0DkeXbiCtOtEwD8nxCMd38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhe
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhi
    vghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeitd
    ekgfduveetveevgfeuhfegieekleegheeftdekffefjefgteetfeeukefgkeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgu
    rhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonh
    ihsehphhgvnhhomhgvrdhorhhgpdhrtghpthhtohepthhokhgvsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:zYxbZ4yjgObJvbylTXQ7OOq-PJLcCZGvxdTBzM6E8kayg6sjU1woNg>
    <xmx:zYxbZ_QuCSHASTjqaUFrB8_UTfccQMnbwLGv7mJqlRQkXIEYURvgCA>
    <xmx:zYxbZzbS7rI_enaUUzAxwsLPuhLu_0nJoE-rL8qm2bdiBTnqxJjJRA>
    <xmx:zYxbZ4SW8dCFH3O-C-LtS1Zm5IKedp8ncEAjx3QOMYkJ_DgMq9-2Gw>
    <xmx:zoxbZ6Fqh5PIh5m5F7szA3Hza1FYl4Nkuo5b2HPrlfDddFkjs1UH1I_0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 20:24:28 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	qmo@kernel.org
Cc: andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org,
	martin.lau@linux.dev
Subject: [PATCH bpf-next v4 0/4] bpftool: btf: Support dumping a single type from file
Date: Thu, 12 Dec 2024 18:24:12 -0700
Message-ID: <cover.1734052995.git.dxu@dxuuu.xyz>
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

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  8 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  7 ++-
 tools/bpf/bpftool/btf.c                       | 51 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.46.0


