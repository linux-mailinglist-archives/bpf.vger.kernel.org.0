Return-Path: <bpf+bounces-69375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC31B95735
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7065F2E47A2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC0249E5;
	Tue, 23 Sep 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqpzq42Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63A224F6
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623902; cv=none; b=TZK6L+dobteLv8fXwKDfslGzc7ngr7lz69Ziujor6k3bUOXhp8uQNYTxz0HBimPvVGLsBiE2+x+ku+mokW5HRZGU+zU+4iiKZVR2NAWt1/98/1/Hi6qAf8EUst7kA6W1QYOdMbecG62jzYv1y9l/7HqnsUZ3Xdr+4gbDcGhe/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623902; c=relaxed/simple;
	bh=Ujp7T5/hWZd9CQrjXZV3duTLu85SKVkdnq+OWyd3e0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKWEhN5uLqHiLrMzyUwYh+fk4A/FB2+iUum5xaM4yEnAQpoTlIi5tzE6iweTa0PO3mnNhwzRWMZVvXndHY7Ygh5K8mgsU5xcTpeepk3tsWkus3HoEZ/mfJU8d3w52RmpE7FH+B2mhS92DcoZ5nHwXNzXDA35r1LGyFZVhpPvH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqpzq42Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A9C116B1;
	Tue, 23 Sep 2025 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758623901;
	bh=Ujp7T5/hWZd9CQrjXZV3duTLu85SKVkdnq+OWyd3e0s=;
	h=From:To:Cc:Subject:Date:From;
	b=sqpzq42QjfMGp3mu/++AR3p/4kGJ4kP+R6PzyVJSHeiPdqbWHTlBV3VbbBccFzJvn
	 Sez173TSFrD3G0rkFyfn74oARnRf1v9w1QAsYqbaEdfBaKAZFhqYryvNf8hp37lpHO
	 7nddR9Uv3GNqK/ntQx+UxiWYErKivG47znejTUrlWLQW7d0oFjZv9iNboEipw2cuPm
	 WzEEI1s2pKQwU3MqjYZbf5OGhq0QFiC7onLL2c5+++lM+wyZDTw/Z1ov4Sd5+c9GBU
	 IanogPgYxFTINlJFa/S1A/UBjPlmslI5G3tUdX07icspXKbOpEeotSLH1MgSLXzRsN
	 wYFufKDGkdSkA==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
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
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Add bash completion for program signing options
Date: Tue, 23 Sep 2025 11:38:02 +0100
Message-ID: <20250923103802.57695-1-qmo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
added new options for "bpftool prog load" and "bpftool gen skeleton".
This commit brings the relevant update to the bash completion file.

We rework slightly the processing of options to make completion more
resilient for options that take an argument.

Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 26 +++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 527bb47ac462..53bcfeb1a76e 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -262,7 +262,7 @@ _bpftool()
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
         local c='--version --json --pretty --bpffs --mapcompat --debug \
-            --use-loader --base-btf'
+            --use-loader --base-btf --sign -i -k'
         COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
         return 0
     fi
@@ -283,7 +283,7 @@ _bpftool()
             _sysfs_get_netdevs
             return 0
             ;;
-        file|pinned|-B|--base-btf)
+        file|pinned|-B|--base-btf|-i|-k)
             _filedir
             return 0
             ;;
@@ -296,13 +296,21 @@ _bpftool()
     # Remove all options so completions don't have to deal with them.
     local i pprev
     for (( i=1; i < ${#words[@]}; )); do
-        if [[ ${words[i]::1} == - ]] &&
-            [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
-            words=( "${words[@]:0:i}" "${words[@]:i+1}" )
-            [[ $i -le $cword ]] && cword=$(( cword - 1 ))
-        else
-            i=$(( ++i ))
-        fi
+        case ${words[i]} in
+            # Remove option and its argument
+            -B|--base-btf|-i|-k)
+                words=( "${words[@]:0:i}" "${words[@]:i+2}" )
+                [[ $i -le $(($cword + 1)) ]] && cword=$(( cword - 2 ))
+                ;;
+            # No argument, remove option only
+            -*)
+                words=( "${words[@]:0:i}" "${words[@]:i+1}" )
+                [[ $i -le $cword ]] && cword=$(( cword - 1 ))
+                ;;
+            *)
+                i=$(( ++i ))
+                ;;
+        esac
     done
     cur=${words[cword]}
     prev=${words[cword - 1]}
-- 
2.43.0


