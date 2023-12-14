Return-Path: <bpf+bounces-17889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19D813DF6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEF51C21D41
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BC6E2BE;
	Thu, 14 Dec 2023 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qw1HvdCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDZ1H6Gk"
X-Original-To: bpf@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741F66AA2;
	Thu, 14 Dec 2023 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id A3EC43200AC7;
	Thu, 14 Dec 2023 17:56:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 14 Dec 2023 17:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594602; x=
	1702681002; bh=j9Ha1GrnJezE3gDkgIKe3fTLm5nM7RqyU/VzWdgR9ds=; b=q
	w1HvdCMhxFqoIWiBQ7RqO5XhjutACfA9pn5Sp3DAShbPXJmO/iOY4ZnKwx49xeoz
	sCs4mI27pihMqKGADLlYZBit+2QJpRkD5i3V2rm4T2Ln975py8J4PZB9YROndd79
	00l9fIi4zcjmLPc0jOsSXh8dzWZVeCAwJD8F8IxVreFOBvsjQd1/XiPA+y1z6Bo2
	dPcA/m+CxMEONWV7KxNaBVpzCByBRCTn+c8GyiYgXJDS4nJlCMK3E5K8u8959xqO
	ax0eg5iveTRk2G0Q8g9u/XOJkBFimGobyC79Vi6zdC62yA9lviD+xmJdMpDpYUOM
	kAuHii98CtC4AhnU7Hsxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594602; x=
	1702681002; bh=j9Ha1GrnJezE3gDkgIKe3fTLm5nM7RqyU/VzWdgR9ds=; b=Z
	DZ1H6Gk/IvJofYnIfaaitzCwf/JQXlJ/MlPeBGwXS/8TWgRkNQxP/njPMK+lOWpc
	3vtTx4MFuz0Nbe4fQG2vvlVYuBbC3pk10tbRTSrBy2czyM+8BcWPAv9QjmJSoKCB
	awmLoaYH5lUqSL0hbUCUjx0CkfFAiBIZ2EhdUcWlJE3aqATESwhMlvVurxsrkCZ1
	3VSxH6zgI+pbT6J1NKOz5kxB5+go/ITKRxn5yY5wlI6LbuFNDMOjshjSCXEZrLPL
	02kOPKJK9c7jpUuPo/jaNUzAAB5+nnZB8B0d+N4nJmfo+r9kWD+GmTN2TsDCSmQZ
	muTIB/u/JHDRKyfpOO/RQ==
X-ME-Sender: <xms:KYh7Zes3LzkLt3NgW61R1Rf3MhmFtVzDndKai34jSk6fd72u2ifgHg>
    <xme:KYh7ZTcN8mOcpVdJJOqzpdN5rOhiSR5dIl_2PUAPlUVWRkoMYYXp5UErV9upTW6pV
    JBoJoNHVrDxcXq6Jg>
X-ME-Received: <xmr:KYh7ZZxiA959vEJnTRFQbAy5hTmnOaiiXAnwqkpROf2L2hrh-066Q3iNdugMBhiIU3NdAuJheGc7QHcb4kulxYYV_LytjB-zAKhK3WvKD1Hi9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Koh7ZZOQvAYpW8D9a2qzSuE7prjDVf9BuwPthkD_WCcUtAUUfGgBLQ>
    <xmx:Koh7Ze9k9UV_CLTtYSTOmc1uIsTWY6E_YteMm1dwZyrBjRZ1gJ3LvA>
    <xmx:Koh7ZRVQZREUylOIDJ7E_-27qbzSDZBJxKJK17eUbEL_xpLOGAJF_w>
    <xmx:Koh7ZeM0DDul-3JuICpLVygcKnNr57Vt3GutdwwJktETj_Yehghizg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:56:40 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: hawk@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	davem@davemloft.net,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: xdp: Register generic_kfunc_set with XDP programs
Date: Thu, 14 Dec 2023 15:56:25 -0700
Message-ID: <d07d4614b81ca6aada44fcb89bb6b618fb66e4ca.1702594357.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702594357.git.dxu@dxuuu.xyz>
References: <cover.1702594357.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering generic_kfunc_set with XDP programs enables some of the
newer BPF features inside XDP -- namely tree based data structures and
BPF exceptions.

The current motivation for this commit is to enable assertions inside
XDP bpf progs. Assertions are a standard and useful tool to encode
intent.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3be5742d6f1..b0b485126a76 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2630,6 +2630,7 @@ static int __init kfunc_init(void)
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
-- 
2.42.1


