Return-Path: <bpf+bounces-35830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B293E52D
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439261C20B92
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12534205D;
	Sun, 28 Jul 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVH2NLpp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB8208C4;
	Sun, 28 Jul 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171339; cv=none; b=qCqc2NBCFsWiNuNriT4soph7VFM3yPRwKib1MVFSWXHzTApTZ9nhONYxH7wrAEfzqQCvGcky7/SM6oUffaOOdcPxPan7NSUo6HT2ysJXX81dj1KG0L3MDP3AN2ywLmXURwB0XeCP+VCYxDC4VlFPAc6gmK80w4IW4tDq0TmPMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171339; c=relaxed/simple;
	bh=JioBmylOb34B+co4W08oDCq6CBN2Fyp2/xuM6TUCWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpnGijyPPeRZOPwRc6YbI9wq9snjwvaNoX9yn+q1UozfLllEOHdBlnT+7vdbg1AdJ8X5/BLRbfz7qiO2ZzDoUfObIJT9WsDox+P8m/JiDuWZ+iwiR3EpVY9uEcRNTJTiyCT4ulkynQl833NRPjxNh8469cn5mpBNLcTnZxhWb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVH2NLpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C82C116B1;
	Sun, 28 Jul 2024 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722171338;
	bh=JioBmylOb34B+co4W08oDCq6CBN2Fyp2/xuM6TUCWbk=;
	h=From:To:Cc:Subject:Date:From;
	b=KVH2NLpp4frRQVpGyUl3VIn5biWiIC0nriPNC32OGBJC/LJ8FuE2m0hjOXMUJdmCt
	 r+XUD70N02RQ7fJ0SZFGIOw45TQCN0SCLJcfUjVvbdsDhuNLDnNf3yuQFLgAbcMdaE
	 wcaCNIL2hh8S1GBOhQTLts3xuBhiQvCTqpomztLYR+UovQ0EwIM6FXsuQsiSlb5FR9
	 1TgSprJ0iSmmD+LpN31I0t3FIlaJj/qwr94V9arEcfjX9raHbdo+emFRN/HFNcJUc6
	 pwmlg4RJy58E5sDf+iTMRmv6pJi5VUOq1vuPNFyr22CkDGV4XBfwK/uc8vn0uBm8Lo
	 f3gfuyeyn3iSw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] kbuild: pahole-version: avoid errors if executing fails
Date: Sun, 28 Jul 2024 14:55:27 +0200
Message-ID: <20240728125527.690726-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like patch "rust: suppress error messages from
CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT" [1], do not assume the file existing
and being executable implies executing it will succeed. Instead, bail
out if executing it fails for any reason.

For instance, `pahole` may be built for another architecture, may be a
program we do not expect or may be completely broken:

    $ echo 'bad' > bad-pahole
    $ chmod u+x bad-pahole
    $ make PAHOLE=./bad-pahole defconfig
    ...
    ./bad-pahole: 1: bad: not found
    init/Kconfig:112: syntax error
    init/Kconfig:112: invalid statement

Link: https://lore.kernel.org/rust-for-linux/20240727140302.1806011-1-masahiroy@kernel.org/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/pahole-version.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/pahole-version.sh b/scripts/pahole-version.sh
index f8a32ab93ad1..a35b557f1901 100755
--- a/scripts/pahole-version.sh
+++ b/scripts/pahole-version.sh
@@ -5,9 +5,9 @@
 #
 # Prints pahole's version in a 3-digit form, such as 119 for v1.19.
 
-if [ ! -x "$(command -v "$@")" ]; then
+if output=$("$@" --version 2>/dev/null); then
+	echo "$output" | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
+else
 	echo 0
 	exit 1
 fi
-
-"$@" --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'

base-commit: 256abd8e550ce977b728be79a74e1729438b4948
-- 
2.45.2


