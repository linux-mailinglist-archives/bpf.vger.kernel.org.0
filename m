Return-Path: <bpf+bounces-53339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44070A5024C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149BA18971B2
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9C924EA94;
	Wed,  5 Mar 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="NEw5t0hH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8Pci5FnV"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B524EA91;
	Wed,  5 Mar 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185233; cv=none; b=UkQv2/7ewKebOuIuP4O0Y5cp6gHzkVHzLIigtyhtBqXZrIbBhEcu+FQXzT3HhhaWnh7AXMJsI7HfNG1k/wNPz+zDqSG09lpSPICFngIlSBQlYUGahPz51NRohOzXfu2e+YHL61KhmpYUMztFWZyICuy2qDYk65IYGS9bTdDsKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185233; c=relaxed/simple;
	bh=ALNDmKMBD9mXTWg2ZSDgD5TqaU58kfSRMxImvMs65hA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJxkzVVxjMmGMrvFO91ATpGCGebpphmc9ijkJEez3G/rWGbHMT5WS60lvS2bpO++6x0yI3AywJDWEcNMpcWZPhkuh3XioVbS+mGTyX5BUJdQ2HudQX8kp7shLIOsEBaZUarSO4a0XTfj+gWt/jPchwtjU2gQ/7hVGYdPII5x1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=NEw5t0hH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8Pci5FnV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 9182413826F7;
	Wed,  5 Mar 2025 09:33:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Mar 2025 09:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185230; x=1741271630; bh=NE5bh1kmLcgI9x0jYIzVg9x+KrpOUoIj
	lroPwL9ii4A=; b=NEw5t0hHy4BO1ftm2Qvb7lPBIzBT82yXQa9VCZv71Xfn3cAv
	DGWrPpB0CGngj5Wo6+y5TBWeQX7Y8hfMRyp+3ZiYyqkzOKGRsXMG7zmKqt/IIwk4
	568CaZy6Y/RjjwgV5lGhcbGno4IWF7m7EDIpnKulDyzT7li3RtwZOieUkgFO1a17
	ScgSjrT77BV/zE3SlewiDlz+gF2bR+pNvSoaOedAd931TVcEG5/uJ9lnLB5vM0H7
	ggMvSaQCDZQ13DL5WzNROmvU2S1WjN8xAswxR2Bwj7MW8jhheoCTcETerc3E39hM
	4g+35XvYAj3UViACmdkcjOeh34jN/OmAhbOfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185230; x=
	1741271630; bh=NE5bh1kmLcgI9x0jYIzVg9x+KrpOUoIjlroPwL9ii4A=; b=8
	Pci5FnVGMmjC7SOzLD4smYLolqas6nkjEuJwWiooFm80rG4Wwx/P9b4roNKxGNRf
	68SAedXjtEXIPUjzQWfJfSc0oMt5THRdj2lHJ2P+q7aE9RsJFkoZvN30u718DJYB
	3zdoExiK7aFNsjJnS+0/3BfIiiG1tKwZqaJEsoEnR9nJ7mkBnqRvStQeZs29P1St
	sUtcv5xvU/Ij3rxu5LNQh26PjWjXnmganAG4muAmYNICx1hK7N5OBcXz1o3qxdov
	DyIqWS4Htjb4ZhdhVDxqEpukf7DHYmJMUfSY9E360AEQDaVo1KCAKWxQi3ZjNXEx
	uGnPiPOycfgFRBA2A9Bxw==
X-ME-Sender: <xms:zmDIZ0dr-kfIrBMZTmyRaqIckJYMf3E2Cce2d6d-dAd9AsihOE-bCg>
    <xme:zmDIZ2OTa2EERuky2Z4egB6ttKrvy4PLL3f99-lujv_R5jaLWGzjCmqhx5KQJGAAp
    ce97y1Dv2KKV41pDfc>
X-ME-Received: <xmr:zmDIZ1gL3dHKuSP0DLczPDKmFiw7KBtbMRx3o7B2RU7lsAjGTwzY8r6ENYP2sCJ0C1XwAavZUtOZKpLLqVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:zmDIZ59QUv2fOia28vdeD9MONjvjveoM1bO1WbQRCsPgNunp5YTmUw>
    <xmx:zmDIZwvyUkHsrQeWO1jB5YZayATKnjPGE8wgMhg8ryV5TBVmI9FFKg>
    <xmx:zmDIZwGN0YKhvOqPjPNegYrpfZXIGbmC6RaJCWxnoqMG99-CNfIRow>
    <xmx:zmDIZ_OAcUU_u55HBB-q-YtqrCeKdiNSK3d0greD62F7YmQAgPvAbw>
    <xmx:zmDIZyLXqDux_b1ANSo5K9O5MPvRdPUWjayvxJPD-w_tg-jamexYj8xf>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:49 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:16 +0100
Subject: [PATCH RFC bpf-next 19/20] trait: Sync linux/bpf.h to tools/ for
 trait registration
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-19-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Now that traits are required to be registered, the benchmarks and
selftests will need to register them.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb37897c039398dd3568cd007586d9b088ddeb32..748ab5a1cbe0d29d890b874aacfc4ee66b082058 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,21 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_REGISTER_TRAIT
+ *	Description
+ *		Register a trait. Docs to make bpf_doc.py not error out.
+ *	Return
+ *		Registered trait key.
+ *
+ * BPF_UNREGISTER_TRAIT
+ *	Description
+ *		Unregister a trait. Needed so services registering traits
+ *		can restart.
+ *		But what happens if a trait is currently being used?
+ *		And to in flight packets?
+ *	Return
+ *		-1 if an error occurred.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +976,8 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_REGISTER_TRAIT,
+	BPF_UNREGISTER_TRAIT,
 	__MAX_BPF_CMD,
 };
 
@@ -1841,6 +1858,15 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_REGISTER_TRAIT command */
+		char		name[BPF_OBJ_NAME_LEN];
+		__u32		flags;
+	} register_trait;
+
+	struct { /* struct used by BPF_UNREGISTER_TRAIT command */
+		__u64		trait;
+	} unregister_trait;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF

-- 
2.43.0


