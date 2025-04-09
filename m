Return-Path: <bpf+bounces-55504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1DA81B98
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 05:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC62C8889CC
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 03:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3981DF73C;
	Wed,  9 Apr 2025 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="G9vvWjxI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTqvM5EK"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC181DED56;
	Wed,  9 Apr 2025 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169698; cv=none; b=kSjjEhUglY4AGnfKnJlgO90HAqMzAhh/8aSd/zt2d+WTcW7WY0OtAiAZaOSa8HpgB/6Py9/d43FtMUWixpNaECoTRJFNjT/aEl2p7OVH9zl3d+SgbZA2YJzxd1QyCnRSSdrBvOnmjZHxnea/6zhYmPYQXk46onj/Z2o1jLXnso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169698; c=relaxed/simple;
	bh=BM4ucfaSCyd4h7/irKImxABUrQPrN5JfhG7BMBvF5CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEa9BD69BbK0sAjw++mty1g9Z7s7zQpmOQWkwePZi3Go1iIEoHxZ2wCwJQDU6SAOKyXtp7gNSavgQE0+7qpzDArA5ZiF7oS50baTb3RoSTp9/XqdXt3nfiy3zVl/RRE1R4H1RvZc1Q80kyqGJEGP+mItw0SJLXTsHFrcupP4tGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=G9vvWjxI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTqvM5EK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B2611140256;
	Tue,  8 Apr 2025 23:34:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 23:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169694; x=
	1744256094; bh=2ofeAZF/8FfFJRWxnBMYkuk948swu1mQfL37VFkVNsQ=; b=G
	9vvWjxIifheFzjsi2gV0DgWF+FF6GHgo0arJ9XU9hj/xMZDdkWcq0zBan0zq4dpu
	SPQTHQ1It/QpcUI7KxoeaasCvW+Sumrt7bJG//Sg3cjPoxL8h1UARvI7GJKunkYI
	ENqRlP61agSm6kZoxqM92bCc6/hQtA8oUYFpUNt7Vg5MHthixpAVvjgPHyWSO9HQ
	t96opSRvZ6XInoJ1eFxdan8VfJEwi3BRjieDh5MHPuyvoV30h6zm0yBDjwm94hy/
	Yts63b2iH+f/Qfry7nswLCcM2NyHqOHyWV5iXrynhVhuV9Tdna92QbtuYPYEm0Og
	YOyzcs2VhpY5pWKsm3+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169694; x=1744256094; bh=2
	ofeAZF/8FfFJRWxnBMYkuk948swu1mQfL37VFkVNsQ=; b=NTqvM5EKESJ8UFvgn
	DhLjznY1MB2qjsj2QgaW47y9tdzijCJmZMMQeGZvviiahKyjIvfSyNDZ/RRlO8CG
	QPPBQ+seHOtZ2v+iTm9TRAvGWloFAkdaHt3cBOBnIkJdJSuI3+RvpZC5l7V6H7xi
	yHu6o87K3Z9tnu/v5y48kB5zN+5EKoI2U5ZqQBWncKpEmD5Uf2hBJivC7r2NxTCc
	Y1XAS/qEK+AOENN/0mfJiRTc9N4vFeYc59OcW64S5SuFeXtpq4uNQ5vRzC7Jwqoj
	KdWUAOp3RuL7CTMPYvTwRKIlJf/mAo5XM5Ik4u9C1PpuLjqj2uhZMbSO+MOcs2O0
	8XHtA==
X-ME-Sender: <xms:3er1Z8_LLHCAaZWJO_jeWMAt89rFPXOmjDu3B8iWq5IJCRPk23WfTw>
    <xme:3er1Z0vd-K4JJi7S686Ae88e7SoAl7NMYgf9qlW005nBl8DlnGjrRjjer9H3HFdSe
    RQD9Ce_bEVbcMnvew>
X-ME-Received: <xmr:3er1ZyDzSxmGGdzHqzHB6No9EoVW3nWoc5W18aXttWa8jo5fwrStiOmThmqTKAzR-XpzgHsQoEzJe9LvEkkHQW5oUm0PySVyPtb0HEbkoF3Jxg9mcXaq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehnrghmhhihuhhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegr
    lhgvgigrnhguvghrrdhshhhishhhkhhinheslhhinhhugidrihhnthgvlhdrtghomhdprh
    gtphhtthhopehjohhlshgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehirhhoghgv
    rhhssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrse
    hinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:3er1Z8ewKCiOfm0iulUCFgENgfY_4pvaK_AYYEg59e1_tbWpQU3kcg>
    <xmx:3er1ZxPT3W0kbZtoOuAODPQXA6YbDVVgUseUKYZ2yH-IEj5Sdrb7oA>
    <xmx:3er1Z2mNgKOCjQkMk9O3mHpuxDz7kcN0ffOJWXF8XhGZpzc-lp57Ag>
    <xmx:3er1ZzsdMvqkdV7gqOzseyqSg7nLHZqm0Rloc_QQou7jVqDmkFl5SQ>
    <xmx:3ur1Z0JHDrFaNPku6zEWs-zypWWDJxrwLJs6ZughU-0cW5ypVI7_fLtE>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:52 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: namhyung@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	acme@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC bpf-next 09/13] perf: Export perf_snapshot_branch_stack static key
Date: Tue,  8 Apr 2025 21:34:04 -0600
Message-ID: <7503bb384aaeaf9a3b6f68c5347fd73f8e561cc6.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the static call so that the modularized BPF verifier can run
static_call_query() against it.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0bb21659e252..b0449209275f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14644,3 +14644,4 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
 #endif /* CONFIG_CGROUP_PERF */
 
 DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
+EXPORT_STATIC_CALL_GPL(perf_snapshot_branch_stack);
-- 
2.47.1


