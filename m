Return-Path: <bpf+bounces-46803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD49F0228
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A8516C63A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA1152E1C;
	Fri, 13 Dec 2024 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZSaplK9h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PY5oTQXq"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D63140E3C;
	Fri, 13 Dec 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053084; cv=none; b=e8dXwpV7QZk3GPprd0OnTaZxxBn8Q9AJ+uKTQyd0fskfWi44PUs7C/LJmwEDFxMrITQReqiKl9bTNf8M3Bi67v6UiKC373i3PuNtm9WCV4F+qTqhy8CoJhuA06NrR15ci6NVSUtyYr8cRAeQFtNuLa6Ux81v58BIAuKOZYWPM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053084; c=relaxed/simple;
	bh=QuBBOqOn9skmD/yQ2slK+O2S+eRa5jWm0OTerYyplK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka+xrrsJWiXDL7gH1oOyuc6qPG/7tdnKTCYuSnfxI9VTyItWv1xPz/bsqGBWNqriw/mUlh7Y3O8YKlDfhhlM4s9DO1HWt8Cmj18bddlz7Q9KjqT4n6mQOj0b8B1ELK1LsnK/rI3eLEEksFs0PH0EK2ch1LrllmQpZqGURTs9WEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=ZSaplK9h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PY5oTQXq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 514EF138419E;
	Thu, 12 Dec 2024 20:24:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Dec 2024 20:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734053081; x=
	1734139481; bh=4P+JI44Oh/HBRFwdfuPqepgrqtXY6Ln0AAuCdeRjQbA=; b=Z
	SaplK9h8pttqfKmNsiyBlQVqBsw5Jrce4bU3Ur33TF06Jd6KwUIePxVozmoqHkNd
	PedLL4zdFw7sCXsQx5UtcRFOhV3WdDJyIG/Q3Y2UF0YEXdJ3cxXRTTA2D87Qofvm
	zG+spd7vRS4gtMTaahiIC7ZocpLRSnQ8uCH/oGgUBrdAZ5amHjxpW31gTI/irMNj
	CbPJ86ksmjGpLOuSWfZCBguhv7TqznfV73cfJRpg4Xdyc7JuH2H3iNWLVZ3V76wc
	QTouy6maempRj0Vsyjv/Df6nGpCDzbtA+WXFKzYJYXERwa5AU9Y3BWAMHPzpRAP8
	SgweztOAixgx95e6XFd+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734053081; x=1734139481; bh=4
	P+JI44Oh/HBRFwdfuPqepgrqtXY6Ln0AAuCdeRjQbA=; b=PY5oTQXqv1sTk7P8T
	nU0bcIunY9QbR38JdEjSDqhE2eDhcNdn0+fUuRwJTlY+BOK5kXz8LGJ5FQ14QEmJ
	TMl5aB7zE/Fl84HutcHcmto/4M+8hCEsNafgd5/RkrMKamBdMkJbVYDHKjBk6Nqn
	xeNv7aiIEG1Ofsjgpv7z9bqmCIn9v4U0yf/4wU1xNbis4tJk+sP2bFM6PUK5Pwjo
	jE6wgXKIYrO1RM29u8xS9dUrTaTbGCWgmCrAwN8FFrmOwDylcy48HzgxnI22K5/1
	+V9YbGDgbegUWp6MfDNkKiTk1Yy/ie51lbfhOv1ND8v+YkOaDMTjpPSQGzES6ghj
	YWg6w==
X-ME-Sender: <xms:2IxbZ07O5KCImYeP-rGyw164IGIiNgbxlpJtgycO83kXfJFS1MFfcA>
    <xme:2IxbZ14HpC4NF_PDDegAOTfWcD0zFV1VmNHy9Tdw9Vp7p2_C3uLyy5l4yRo0PJRY_
    JjM2FHc4vjlZF5Hlw>
X-ME-Received: <xmr:2IxbZzfvfYBIQYcEKmG3ZDF5MXhqP0WCS1Hmw0fPtRCjFN-A0zWa2Zvs1rTzkWwQSU-OoKXazwRgWxOdoSgGj2I0zWMd9WTbFnslHh_nHGw3Bg1hDoDb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehqmhhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehmrg
    hrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopegvugguhiiikeejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2IxbZ5KwIVgmEJR4Ekrwu2g1qp5_lcruXgdekXytCNAUNtRSEVJkwA>
    <xmx:2IxbZ4Ie12lO9mirXfk_jlzbLhPJs-3MEBEH5syc9vHsY_uHnp2DJQ>
    <xmx:2IxbZ6xlv7JFtpIsIFBN2xskh44gTZMzwytQo2nKKj_76xjo2ijRGg>
    <xmx:2IxbZ8JjBGYLwieqSd9IJbSZIhvb2tZBYuu5a4LVez3e7lIOWYD-qg>
    <xmx:2YxbZ9CgxoZt1dPg4hUWKZlHza_czZUrFl9hRKpqRAG8pTHUJaonWCnF>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 20:24:38 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net
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
	andrii.nakryiko@gmail.com,
	antony@phenome.org,
	toke@kernel.org
Subject: [PATCH bpf-next v4 4/4] bpftool: bash: Add bash completion for root_id argument
Date: Thu, 12 Dec 2024 18:24:16 -0700
Message-ID: <7aa45a2c19ac50b72be1921e0d94f9bc77c97896.1734052995.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734052995.git.dxu@dxuuu.xyz>
References: <cover.1734052995.git.dxu@dxuuu.xyz>
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


