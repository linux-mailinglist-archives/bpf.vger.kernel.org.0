Return-Path: <bpf+bounces-46894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE69F16AE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB1167EF1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665D1F4E30;
	Fri, 13 Dec 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Yy6RW/j4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uE/ld55m"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E941F470F;
	Fri, 13 Dec 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119075; cv=none; b=k/Fo3z3Fu0w59rXYjmEiehVz8cP77RB85AnWfZYQiXjUEeuT4bXJ2/QyM7jjEPCfYp81Odcb5mEZ/hirtxr4JXt3vvLo+B6AhiFz9i86+B1CFoodHEC78sPa4KAJ4T+sTFVFk9kEjWeheOXARHWj5NaBX8BTYVOYZjZgOuL3fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119075; c=relaxed/simple;
	bh=4yPh3o5msytngK0b2M7uPcwE2itl/ZpxnSyMzy56frI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6NtYaXVQQPHLr61iT69uQBUT1VsnFlVCkNmxb/XV6q2Kpf019+pqzbv3fUIzMITqXkqaDumn7vlmyqPQxJhbmSFi9wLEN28X2ymIXKoFGNo/E2lk1FH60Z1lEMUn+vWoxVt/OtQDk8kDSL0tmxlBFBDCQiGhaUik0bXNdIULTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Yy6RW/j4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uE/ld55m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 21B221383EA2;
	Fri, 13 Dec 2024 14:44:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 14:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734119073; x=
	1734205473; bh=Hqyz5RNb3bsM+MDynbvfut+TaE71hr9iEdgs6WRLNZg=; b=Y
	y6RW/j4DzmIVsOhUtNyY4kwRgU2nowV3hrmkcOcCyskn5owUGwY9k++uthZVAX5k
	7K+LTdhMNPDTILtv0+p0TPimK9/kf4Yh4KVXK2RJdynO3Ep0RoAdqyg7LzaRPGsO
	yp1b2PIuKexsZimhSkPpfykkEN23YuAXfqbjhiDsINUZL1jzfgTGXnAQB31KB0BN
	l8D2lX73YkYkLZWflZEnit3PqSpEn5UWcHzLQOaPzRKReVjbgDNmqBCQJpeBReCL
	wITxuHD/czdEwlb2yA1U/iFU2HeLnXNivudQTdF79+V+k7+LfRgWZO7SC5oGiFHE
	aUL7SVWyYh56U7XpLlwtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734119073; x=1734205473; bh=H
	qyz5RNb3bsM+MDynbvfut+TaE71hr9iEdgs6WRLNZg=; b=uE/ld55mV5AApECKd
	GD9Kq4A3t64CFfCyFZfplrEd+OkxqpNjLnQiATYpMFJwn/vPCZGHSunJAp92Nc8V
	J5PTiYrrV/fSKVwbTu2/rzDh2TbLT81cIascAgiWfjwMforTiebRgTiu2j9Uxzod
	hlRFqNGtIp6KlyV0zXkHLXNuIRyTFlVhEeohqPfT8eDBjXXbFrz1MJCbgW7CmB2k
	P57nRwKHlF/+UnoT3aTJtaMKsFJRIJSE7We7b+TtZxz4kVqZe5vnL5c3ifkpBW9S
	Hgp2Z/AHz2iZKQB70cu9iR3PuMzCkaMV6EZwoxhA2pkNo5vytQhEX5SfgipW66Cb
	c5qeg==
X-ME-Sender: <xms:oI5cZ1IxIeM-cN_Vg5MamFRsMAvAEEU6NSg6jFTU4IStukH6cFqUUw>
    <xme:oI5cZxLI_2LTe5Vpg0ZuledKWIM-UmvX0Yw-JuX_ZdwjAtroFQ4xQ-27RkvoGVE9J
    jqp5zrOS9mCrWMVHQ>
X-ME-Received: <xmr:oI5cZ9uzoPjla25aydrmgB_xCvZ6IL0D1DpgAfg5IOG--iwXYxUkzSnkXbdeWUy6A64uycDjLEKhquPBKL6OF6Z-yEWKi6BBKlIA3DsMyRVuf1LBHILP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    hqmhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    grrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjees
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtthho
    pehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oI5cZ2bCyjrkJ8-HGNOEZszi-yplizMugX983rDuGe1jDq1kjkRwmw>
    <xmx:oI5cZ8YtSBlgRX4SPshDFH0A0Mg1CWdYq4JYYSuan1xd-We8k9IMhA>
    <xmx:oI5cZ6D9SQTLf0EkLhXr_dNG0ywFs-8RHJfo_3RAms-D0UaSxnzmyQ>
    <xmx:oI5cZ6ZOfE9G0NGor4cytPLyrc175kR0hgDqg07ITp-CRkTpysaDPw>
    <xmx:oY5cZ5RNbT8es2vYhjdxoIn9V6URR2F320_r4tlZvHgmswfsjdk4weVT>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 14:44:30 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	qmo@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
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
Subject: [PATCH bpf-next v5 4/4] bpftool: bash: Add bash completion for root_id argument
Date: Fri, 13 Dec 2024 12:44:12 -0700
Message-ID: <37016c786620761e621a88240e36f6cb27a8f628.1734119028.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734119028.git.dxu@dxuuu.xyz>
References: <cover.1734119028.git.dxu@dxuuu.xyz>
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
 tools/bpf/bpftool/bash-completion/bpftool | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 0c541498c301..1ce409a6cbd9 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,19 +930,24 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        root_id)
+                            return 0;
+                            ;;
                         c)
-                            COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "unsorted root_id" -- "$cur" ) )
                             ;;
                         *)
                             # emit extra options
                             case ${words[3]} in
                                 id|file)
+                                    COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                     _bpftool_once_attr 'format'
                                     ;;
                                 map|prog)
                                     if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                         COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
                                     fi
+                                    COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                     _bpftool_once_attr 'format'
                                     ;;
                                 *)
-- 
2.46.0


