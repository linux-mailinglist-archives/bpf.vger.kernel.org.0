Return-Path: <bpf+bounces-46437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8029EA31A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E4281CA7
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA0223C77;
	Mon,  9 Dec 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="pdV1nIPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okweNhns"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3222616C;
	Mon,  9 Dec 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787920; cv=none; b=jTmY+GUbXZ5ijmah7dfd5oI3XlH0QGk7fS9TqIKC70qunuAvvWzuhZ8x70dOMuAxkcXcBi18ziSnqjNsdtNpGHYhS0JolgZCqAEn7UQ9Jouvgrkgzvgy0cGOBKKMHO2CP1fYIbtoeeW3Zds3Jl5Ot4BmYyxWUtNKU5HuahX0Vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787920; c=relaxed/simple;
	bh=QuBBOqOn9skmD/yQ2slK+O2S+eRa5jWm0OTerYyplK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRTpZQkP6zYP5ToOh3OhcXmct3cF0Rs8fNDsfbhezYeTv5AneK3LAcRWe7dwoR4q8AE3h9d7/Gv5MmZJy0zp6xMeXnAiLPMAjlYx8/wz5XaeR1g6NscrvHF/8dLejEoIIGZ5pJo6W1x4SmU9MS6enpb1/OkCaFnBEDkHT/mc1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=pdV1nIPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okweNhns; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 73AC311400D8;
	Mon,  9 Dec 2024 18:45:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 09 Dec 2024 18:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1733787917; x=
	1733874317; bh=4P+JI44Oh/HBRFwdfuPqepgrqtXY6Ln0AAuCdeRjQbA=; b=p
	dV1nIPuVnh8ppli9DSWMbDmHlHmPkCQZtD2uit28R8rPqUFG0ULAd44q7de0mbrw
	6MP0dKwUYIVzax2HSjlIJ6otczqMYkN7RNuvL09totK3N2I3y8Ex14h5M10ydi5U
	1grKt2fc9WtA1Er6F7NDaoKHe7Qc7Lgq7+PIMAO1UjNZn1w69MJMRSoZII4u6R84
	PpghPxAdq0+bvbuaV5d3VOAHoVZu8YMhEp6w7/fR0fPjE6ZcfLqSeAT5XN5xWqZc
	erJ+txTeGNYhH/arDMc0UeMc/bcGVtYG8ORkjUqiDilyzzv0QIZyMVF2IH1V51Dq
	B6AIh6nQO5Wjg/mrDpP6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733787917; x=1733874317; bh=4
	P+JI44Oh/HBRFwdfuPqepgrqtXY6Ln0AAuCdeRjQbA=; b=okweNhnsujrC22NFI
	txQvvrIqUZxlBYUcoRj2A826Kzce8T9X/xKHw2Hr56jBjjOe/9Yhbb99ch0jxp7y
	5s7u+ibKCkfEp0LNOsi+qD2GjXJU1d9SDQQ4uOj7BlaGXiA0qUqno1LJ4WJeygyL
	w1F5wZLST6mZpfYhk9+wuUSdT3pv9OTPlWEkOAbCT07sLZJ4XJ5De/FZJ/d5dCRy
	f6uW/nIVZ5Gi0I8GIEqdVAApnD84+qen95id8dbXM+sWXNDOloMjteiQf5uRzjKm
	0s5zlWmGnSWuznMAOiQVEzlV/dkNTN6cqDDPcOYghjq9S4RlHW4YfpjT9W94NUJ6
	nnyqQ==
X-ME-Sender: <xms:DYFXZ8M3pG5V8jc-zXcGFyl4sCNag3eDXLvrV5-I7yI6FK3HmEhULA>
    <xme:DYFXZy8Mv28fqdCoHaJr7CU05Af8MoOT4bc2eLP4_qzzFqU1s2FFY70wv0nW5HIWJ
    q6xvNrYfExJjfsrDw>
X-ME-Received: <xmr:DYFXZzTC_i1WmnZFO4ti608I3YaGVzOKe6taM3Moou65DsSf_S9y2VmxTTfPzV4WNEhOuahjnq5wO9GtH279mRtONd_x4s5gVvj2bHCId2Hc4VddwYGq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
    pdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DYFXZ0vUxtzsdmooBp8Mnld_IiydEIjjXCLGhGs79yItrIVD66o0vQ>
    <xmx:DYFXZ0eKy55T9MxshNMyLpT0cSeEcHE6D4tUueN5BKkGQ3wE2t09bQ>
    <xmx:DYFXZ41GQAcdWo5ZW6LUlAQJrAi0gaiq6VvpbDA6mk3Jf4B0Gb1pOQ>
    <xmx:DYFXZ49JWpiMm_zEthqdiMg2OK92uaCBcGPwKpJk7rD2Vt925LCAVg>
    <xmx:DYFXZzClxJtMn-aNvoEoGb8vSoij5hz6ZHfL19r2zHSaNhufTQMFG-x2>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:45:15 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v3 4/4] bpftool: bash: Add bash completion for root_id argument
Date: Mon,  9 Dec 2024 16:44:35 -0700
Message-ID: <e9fa6a9395ea50d2b2a584f10a71ff777da875b8.1733787798.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1733787798.git.dxu@dxuuu.xyz>
References: <cover.1733787798.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the bash completion script with the new root_id
argument.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/bash-completion/bpftool | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 0c541498c301..097d406ee21f 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,6 +930,9 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        root_id)
+                            return 0;
+                            ;;
                         c)
                             COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
                             ;;
@@ -937,13 +940,13 @@ _bpftool()
                             # emit extra options
                             case ${words[3]} in
                                 id|file)
-                                    _bpftool_once_attr 'format'
+                                    _bpftool_once_attr 'format root_id'
                                     ;;
                                 map|prog)
                                     if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                         COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
                                     fi
-                                    _bpftool_once_attr 'format'
+                                    _bpftool_once_attr 'format root_id'
                                     ;;
                                 *)
                                     ;;
-- 
2.46.0


