Return-Path: <bpf+bounces-8324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E07784DA7
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEC21C20B95
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4239D;
	Wed, 23 Aug 2023 00:08:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353C7E;
	Wed, 23 Aug 2023 00:08:55 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF3184;
	Tue, 22 Aug 2023 17:08:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D32223200961;
	Tue, 22 Aug 2023 20:08:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 22 Aug 2023 20:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1692749329; x=1692835729; bh=ElmqIHyLQj
	N5GfSxGvXyXp9lQjutb3ygeQl4KNzMCT8=; b=CHGns7qv427DQoRJwYnml3AjT3
	Xk1Q+g8ATOOQabaPRqOWsygwQmllcbSAIjOVXprYsr+my7REVox5+NjPtV4beptf
	OlHXRzN9kgmJQXAT8FNVIqDAE5KHGr3psuouQbpdeum1RF5NuSPU6pfGZGbqMigd
	egKoepBiUV9pJUsh2RU2TqX5M88MvZOccE+Qhabbwh1rJt17gyiWZkFOJE7O8v19
	kpwNZXFSac7Y4WSt/d7yh1LgkHTYYwoFeyruDrMyoKjdi6pFwG1Vy0dHM2N3Zrcv
	KTQMK7kSmQyYKSnVKivFI+5Oci5rC+Y/kiDqXBEif2NsfNIA87L/qaL7rS1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1692749329; x=1692835729; bh=ElmqIHyLQjN5GfSxGvXyXp9lQjut
	b3ygeQl4KNzMCT8=; b=o+QLoJJm2FYYteCTxt76IIi/GqPJKg5Sa4kTSUQc4nmm
	9qQbttNTFRjgQAvSuIdmNdj1feH438kp36ARFnKE6SQzeBT/FbYOU74r1qFoIVop
	Q0uYdYV5HhaIGHTs2gaF++y+yUa34cBqvSmgHuHSAjk2ydEtFBRyIhbnrR8KvGCz
	RFXv8nggHq6cxN50WBZP4mXpfQadrCCTmLS1p3FGVvlS5SD5eMPyaukv1Gz953py
	UkaXl8P/38DxyuUTcLkxMoxyTsvCHiYejZAWsDXKbH2z+zH+3QyVVJpSKKv7MTl3
	4YCUyiLYbi7E2jDVL6bWTi5hl5IK6jLlz2Nc5yW/BQ==
X-ME-Sender: <xms:EU7lZOMdNgkG53H_r3lseIq5tBlhLdFRG3p8VrNT9-Ar9EalXEHa7Q>
    <xme:EU7lZM_HHjoHk1C3WUToRguiXc3-uKQRHM8W1N3bZmwZYHpdXBymdxuRyjMkF62Hj
    TgGoAGlzBY3PiE-4g>
X-ME-Received: <xmr:EU7lZFRl0xK1iWw_bjaItp9qAZAHqXE0p0iwF3XVgLVQxV6Cwhrxg1MG50JsZewqecsjBNpFlisQGztwVyrorroVtIFbjvS6duBGy0qHedoyeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffegjeduheelgfdtudekie
    ejgfegheehjefgieejveevteeiveeukefgheekjeenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:EU7lZOsIX3dwuXvVBhdub_38iikmt_su2NLLCIym2m60ErgQdEnzAg>
    <xmx:EU7lZGeyYXQhKETSDcgDs72Us6sDln2y4IfgvRzleTZdaB3q4TAO8w>
    <xmx:EU7lZC0cvJ3xmVsdS2g6KkmVuVX1CUR6QijmpHMcduHxcU-kwJ5QdA>
    <xmx:EU7lZKEmGMTLE0Ovs1yBM63iBSBfWCbbj5pwZXorq8nxZ4DHofTVRw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 20:08:48 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 0/2] Improve prog array uref semantics
Date: Tue, 22 Aug 2023 18:08:29 -0600
Message-ID: <cover.1692748902.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset changes the behavior of TC and XDP hooks during attachment
such that any BPF_MAP_TYPE_PROG_ARRAY that the prog uses has an extra
uref taken.

The goal behind this change is to try and prevent confusion for the
majority of use cases. The current behavior where when the last uref is
dropped the prog array map is emptied is quite confusing. Confusing
enough for there to be multiple references to it in ebpf-go [0][1].

Completely solving the problem is difficult. As stated in c9da161c6517
("bpf: fix clearing on persistent program array maps"), it is
difficult-to-impossible to walk the full dependency graph b/c it is too
dynamic.

However in practice, I've found that all progs in a tailcall chain
share the same prog array map. Knowing that, if we take a uref on any
used prog array map when the program is attached, we can simplify the
majority use case and make it more ergonomic.

I'll be the first to admit this is not a very clean solution. It does
not fully solve the problem. Nor does it make overall logic any simpler.
But I do think it makes a pretty big usability hole slightly smaller.

I've done some basic testing using a repro program [3] I wrote to debug
the original issue that eventually led me to this patchset. If we wanna
move forward with this approach, I'll resend with selftests.

[0]: https://github.com/cilium/ebpf/blob/01ebd4c1e2b9f8b3dd4fd2382aa1092c3c9bfc9d/doc.go#L22-L24
[1]: https://github.com/cilium/ebpf/blob/d1a52333f2c0fed085f8d742a5a3c164795d8492/collection.go#L320-L321
[2]: https://github.com/danobi/tc_tailcall_repro


Daniel Xu (2):
  net: bpf: Make xdp and cls_bpf use bpf_prog_put_dev()
  bpf: Take a uref on BPF_MAP_TYPE_PROG_ARRAY maps during dev attachment

 include/linux/bpf.h  |  1 +
 kernel/bpf/devmap.c  |  8 ++++----
 kernel/bpf/syscall.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
 net/core/dev.c       | 16 +++++++--------
 net/sched/cls_bpf.c  |  4 ++--
 5 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.41.0


