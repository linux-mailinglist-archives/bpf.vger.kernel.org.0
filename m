Return-Path: <bpf+bounces-26710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB158A3E9F
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D671F21790
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 21:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87256B6F;
	Sat, 13 Apr 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="guA0T/K0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TN9PY7j4"
X-Original-To: bpf@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23F55E4F;
	Sat, 13 Apr 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713042795; cv=none; b=djBOzK2oiAuIeI50yqHqXyGWznsWLiVXNfwu6J9VOqatWTCfKhfbNZMH+tNzkhy5Tp6eKpSyqNjK+wrHFB1G4YEQnKVsCN4/3XVTgB41ysmNc4ua8FT1zoUWusw4JvJZwL28VZJ31tRD0/dGwjqGsgb1aKvhqx9aQt+apbPSFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713042795; c=relaxed/simple;
	bh=TnwOVpWbbZtVgN6LqfHmT/tXLz+PEvXIlov2jxXkZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/3scqmaZ6jdDQ1sHSeCWKQ6fD4/cHfJ4y5iJSRllKhKsFiOy0A4KeN2MLTmmsb1+cqW260HkWqqt/vZj3yeg0UeZwnPS6oZFU6UjtGUA6Kj4dS1gXNir1XBnycJAbEkEdZk3sQcf3+/43ij0SrhrQp7Nt8qNkrR4BdK2ReQnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=guA0T/K0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TN9PY7j4; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 97C6A1C000FC;
	Sat, 13 Apr 2024 17:13:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 13 Apr 2024 17:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713042790; x=
	1713129190; bh=Vb15qo2kI4aLnF/tBRyhuoRFKr8FftX5ce1CP89OW5U=; b=g
	uA0T/K0knLMUDBpeID1XaHLwE8KWxFh3IA1WuTTYxaU8BwBoU7ojFg5GNgLkFmKr
	GZkM0GPL5bR6TwDNuEv2+hIuxIp+Esl9QUYLttl/cVDSi933aInI098BCHMAYZAh
	fBw90obEnQAxq6Kxrkz1kgLwoKmjvukKlHj5FIs3qZZyPYJCfyFGeESpS2ij4pLZ
	jeTj03eZfUG/Oqr6CHZn1AwcXwNcu+49iUgW8eYrXU0reumTUtqtTAWvtEz3t5Xj
	8ROAm3i/efb9VsS3oBd/vWVqQMpipooKO373OoJQ3ioWpoTW+fMKiZQPzXBxDFAc
	A6NXvMAAvbmoyzPfwiXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713042790; x=
	1713129190; bh=Vb15qo2kI4aLnF/tBRyhuoRFKr8FftX5ce1CP89OW5U=; b=T
	N9PY7j4Ukliqeit4AbbaRTLSFafwV8onDZt0Zdr3TbHJ5gkut289ZW7owF5hx9TA
	ESfPTPoGmejr3gZEjFM3c/FTgOn0aVmrEy//CcRqoCv+hhmu5nv3spRIggwl3d5+
	bQ3LVH/WLdxR1aZBT664afNLuM8bkZcMlwNXaGu5KHnNIiwZA9KmuEbsugw9YKki
	w7Y3SWDmFpJCi7VTycdOsWKj7mRO1eZ88b9yqPZWxlFqQBv1a9Re4fxKlRSL2452
	5Iv9l9gxx12cT6EerssCOLc3kUB8Xv71CxfDfvtwgV0xr0Gavp0Q+EeIxQi3LZGe
	gu6dm/Dp68cXreZRHZm+A==
X-ME-Sender: <xms:ZfUaZpdf_FkMdWq7Hj9dDmpiUov3W-4AvmmOvJbJKax3IBbimApjpQ>
    <xme:ZfUaZnN5gGc61wlcUaUOLDC9dWaIlvlfymvr6d_syqHFad-d6NsbARnjlr7CR60h5
    9j1gDdxwzgutKNyMlk>
X-ME-Received: <xmr:ZfUaZihgNSZZWY7GVr35g1vrCy1j4rfKLlscKpfrUnESo8RxgY08xCuBdznXEIEFTaJUJlkvHHq0V45Fi_rvG6Vmn-c9Aj773w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiiedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefsuhgv
    nhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrg
    htthgvrhhnpeevieehjedtveevueeujedtveehtddugfeukeeffeettddttddtleehudeh
    feetleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hquggvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:ZfUaZi9N4dIuMKmXboXHJn4HzuNciX7Z_vuXzQNpgU_1A2DFH7RhfA>
    <xmx:ZfUaZlvb3Vq_QvwtO7GykOa6fvrENAu_kW0oLirDkv3Tw8eyiEz6Kw>
    <xmx:ZfUaZhHEVKZHB-4s42Qe0iwVAxKjyowFQQkpH7qbEQaW1rwsWYvwCw>
    <xmx:ZfUaZsNSiOprSaW91OgAvkD-TOzeMEPo944lCHcE6H0XBhk7vcPDDg>
    <xmx:ZvUaZu-y0umC8Jq7uWXAykzTB8mxiDeB1hNf95nkdZYtzPAWv0s7pfd4>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Apr 2024 17:13:07 -0400 (EDT)
From: Quentin Deslandes <qde@naccy.de>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 1/2] libbpf: fix misaligned array closing bracket
Date: Sat, 13 Apr 2024 23:12:57 +0200
Message-ID: <20240413211258.134421-2-qde@naccy.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413211258.134421-1-qde@naccy.de>
References: <20240413211258.134421-1-qde@naccy.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btf_dump_array_data(), libbpf will call btf_dump_dump_type_data() for
each element. For an array of characters, each element will be
processed the following way:
- btf_dump_dump_type_data() is called to print the character
- btf_dump_data_pfx() prefixes the current line with the proper number
  of indentations
- btf_dump_int_data() is called to print the character
- After the last character is printed, btf_dump_dump_type_data() calls
  btf_dump_data_pfx() before writing the closing bracket

However, for an array containing characters, btf_dump_int_data() won't
print any '\0' and subsequent characters. This leads to situations where
the line prefix is written, no character is added, then the prefix is
written again before adding the closing bracket:

(struct sk_metadata){
    .str_array = (__u8[14])[
        'H',
        'e',
        'l',
        'l',
        'o',
                ],

This change solves this issue by printing the '\0' character, which
has two benefits:
- The bracket closing the array is properly aligned
- It's clear from a user point of view that libbpf uses '\0' as a
  terminator for arrays of characters.

Signed-off-by: Quentin Deslandes <qde@naccy.de>
---
 tools/lib/bpf/btf_dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4d9f30bf7f01..6a37e8517435 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1929,6 +1929,7 @@ static int btf_dump_int_data(struct btf_dump *d,
 			if (d->typed_dump->is_array_terminated)
 				break;
 			if (*(char *)data == '\0') {
+				btf_dump_type_values(d, "'\\0'");
 				d->typed_dump->is_array_terminated = true;
 				break;
 			}
-- 
2.44.0


