Return-Path: <bpf+bounces-26696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE98A3A0F
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D361F228A1
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF04C66;
	Sat, 13 Apr 2024 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc8aHkCB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D15235
	for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970915; cv=none; b=rtFoQ6Ib0+grwauSA+Sk695WGxJrbvaCqHiE/SFIbV5CmwuHVVhES+TfmJxxVIQA6wWTmd/PLWPKSmkjYLG2XnMrHSNgAd+6fcB3VD/9Qmz6K5bLUbEYbJF4b2whsJejWGRPaB7XVD3uu8ciymXqgu3Ma78pwNZyefm/XG2EfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970915; c=relaxed/simple;
	bh=Ft8/C1o11SLtPSkJIkD9IffrpNxa7a46tc1iNripE6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ym91RXcC52kJ/xvi+G70V2AK3VxTXapIE0VDywEOzdZtjx5RhGh/c8+9ZYpfwlMzAIK96etXkf4JbdFEyA5dH22rmvIMDA9IiLzvUDrm8oIbBoVwmlG+WJ8nE8uNYX2+Z4HK+PGhUTrdZc8PbnbU+eRObstce4FJN1fyoOruEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc8aHkCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCA0C32786;
	Sat, 13 Apr 2024 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712970914;
	bh=Ft8/C1o11SLtPSkJIkD9IffrpNxa7a46tc1iNripE6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uc8aHkCBeF/mgPjs1P9YfH/Zp8fqPD07gGvABv67BK3AsiwqC6Hhk25cWITwuN/4w
	 Y2NuCbmgOlQGS3EjiTxgpW1mci5ndfNqoAoJxByFGrO5VeajlCQhTk1g0alktbpm/j
	 zgjlmKgV95yF2BwGfKIzVKQU1xe3Of2BKG/+qmYCARvJgNJighX0Jh8zzf5e/LoVCq
	 Z1S2BpvGI/i3zShzh2HvnWEUN9eWe2hfMj+rGPGcSox99wwC4o2HJHGLv8w4fmiLew
	 +xH1DpqmfTz+9kouf7GMcW5CxyqkDgb3oLmLNzNSkVMqWt4vJCUCKQeXmd+cz8GG8K
	 zaTuPFngCrElA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 2/2] bpftool: Address minor issues in bash completion
Date: Sat, 13 Apr 2024 02:14:27 +0100
Message-Id: <20240413011427.14402-3-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240413011427.14402-1-qmo@kernel.org>
References: <20240413011427.14402-1-qmo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit contains a series of clean-ups and fixes for bpftool's bash
completion file:

- Make sure all local variables are declared as such.
- Make sure variables are initialised before being read.
- Update ELF section ("maps" -> ".maps") for looking up map names in
  object files.
- Fix call to _init_completion.
- Move definition for MAP_TYPE and PROG_TYPE higher up in the scope to
  avoid defining them multiple times, reuse MAP_TYPE where relevant.
- Simplify completion for "duration" keyword in "bpftool prog profile".
- Fix completion for "bpftool struct_ops register" and "bpftool link
  (pin|detach)" where we would repeatedly suggest file names instead of
  suggesting just one name.
- Fix completion for "bpftool iter pin ... map MAP" to account for the
  "map" keyword.
- Add missing "detach" suggestion for "bpftool link".

Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 61 ++++++++++-------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 6e4f7ce6bc01..04afe2ac2228 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -106,19 +106,19 @@ _bpftool_get_link_ids()
 
 _bpftool_get_obj_map_names()
 {
-    local obj
+    local obj maps
 
     obj=$1
 
-    maps=$(objdump -j maps -t $obj 2>/dev/null | \
-        command awk '/g     . maps/ {print $NF}')
+    maps=$(objdump -j .maps -t $obj 2>/dev/null | \
+        command awk '/g     . .maps/ {print $NF}')
 
     COMPREPLY+=( $( compgen -W "$maps" -- "$cur" ) )
 }
 
 _bpftool_get_obj_map_idxs()
 {
-    local obj
+    local obj nmaps
 
     obj=$1
 
@@ -136,7 +136,7 @@ _sysfs_get_netdevs()
 # Retrieve type of the map that we are operating on.
 _bpftool_map_guess_map_type()
 {
-    local keyword ref
+    local keyword idx ref=""
     for (( idx=3; idx < ${#words[@]}-1; idx++ )); do
         case "${words[$((idx-2))]}" in
             lookup|update)
@@ -255,8 +255,9 @@ _bpftool_map_update_get_name()
 
 _bpftool()
 {
-    local cur prev words objword json=0
-    _init_completion || return
+    local cur prev words cword comp_args
+    local json=0
+    _init_completion -- "$@" || return
 
     # Deal with options
     if [[ ${words[cword]} == -* ]]; then
@@ -293,7 +294,7 @@ _bpftool()
     esac
 
     # Remove all options so completions don't have to deal with them.
-    local i
+    local i pprev
     for (( i=1; i < ${#words[@]}; )); do
         if [[ ${words[i]::1} == - ]] &&
             [[ ${words[i]} != "-B" ]] && [[ ${words[i]} != "--base-btf" ]]; then
@@ -307,7 +308,7 @@ _bpftool()
     prev=${words[cword - 1]}
     pprev=${words[cword - 2]}
 
-    local object=${words[1]} command=${words[2]}
+    local object=${words[1]}
 
     if [[ -z $object || $cword -eq 1 ]]; then
         case $cur in
@@ -324,8 +325,12 @@ _bpftool()
         esac
     fi
 
+    local command=${words[2]}
     [[ $command == help ]] && return 0
 
+    local MAP_TYPE='id pinned name'
+    local PROG_TYPE='id pinned tag name'
+
     # Completion depends on object and command in use
     case $object in
         prog)
@@ -346,8 +351,6 @@ _bpftool()
                     ;;
             esac
 
-            local PROG_TYPE='id pinned tag name'
-            local MAP_TYPE='id pinned name'
             local METRIC_TYPE='cycles instructions l1d_loads llc_misses \
                 itlb_misses dtlb_misses'
             case $command in
@@ -457,7 +460,7 @@ _bpftool()
                     obj=${words[3]}
 
                     if [[ ${words[-4]} == "map" ]]; then
-                        COMPREPLY=( $( compgen -W "id pinned" -- "$cur" ) )
+                        COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
                         return 0
                     fi
                     if [[ ${words[-3]} == "map" ]]; then
@@ -541,20 +544,9 @@ _bpftool()
                             COMPREPLY=( $( compgen -W "$METRIC_TYPE duration" -- "$cur" ) )
                             return 0
                             ;;
-                        6)
-                            case $prev in
-                                duration)
-                                    return 0
-                                    ;;
-                                *)
-                                    COMPREPLY=( $( compgen -W "$METRIC_TYPE" -- "$cur" ) )
-                                    return 0
-                                    ;;
-                            esac
-                            return 0
-                            ;;
                         *)
-                            COMPREPLY=( $( compgen -W "$METRIC_TYPE" -- "$cur" ) )
+                            [[ $prev == duration ]] && return 0
+                            _bpftool_once_attr "$METRIC_TYPE"
                             return 0
                             ;;
                     esac
@@ -612,7 +604,7 @@ _bpftool()
                     return 0
                     ;;
                 register)
-                    _filedir
+                    [[ $prev == $command ]] && _filedir
                     return 0
                     ;;
                 *)
@@ -638,9 +630,12 @@ _bpftool()
                         pinned)
                             _filedir
                             ;;
-                        *)
+                        map)
                             _bpftool_one_of_list $MAP_TYPE
                             ;;
+                        *)
+                            _bpftool_once_attr 'map'
+                            ;;
                     esac
                     return 0
                     ;;
@@ -652,7 +647,6 @@ _bpftool()
             esac
             ;;
         map)
-            local MAP_TYPE='id pinned name'
             case $command in
                 show|list|dump|peek|pop|dequeue|freeze)
                     case $prev in
@@ -793,13 +787,11 @@ _bpftool()
                             # map, depending on the type of the map to update.
                             case "$(_bpftool_map_guess_map_type)" in
                                 array_of_maps|hash_of_maps)
-                                    local MAP_TYPE='id pinned name'
                                     COMPREPLY+=( $( compgen -W "$MAP_TYPE" \
                                         -- "$cur" ) )
                                     return 0
                                     ;;
                                 prog_array)
-                                    local PROG_TYPE='id pinned tag name'
                                     COMPREPLY+=( $( compgen -W "$PROG_TYPE" \
                                         -- "$cur" ) )
                                     return 0
@@ -821,7 +813,7 @@ _bpftool()
                             esac
 
                             _bpftool_once_attr 'key'
-                            local UPDATE_FLAGS='any exist noexist'
+                            local UPDATE_FLAGS='any exist noexist' idx
                             for (( idx=3; idx < ${#words[@]}-1; idx++ )); do
                                 if [[ ${words[idx]} == 'value' ]]; then
                                     # 'value' is present, but is not the last
@@ -893,7 +885,6 @@ _bpftool()
             esac
             ;;
         btf)
-            local PROG_TYPE='id pinned tag name'
             local MAP_TYPE='id pinned name'
             case $command in
                 dump)
@@ -1033,7 +1024,6 @@ _bpftool()
                     local BPFTOOL_CGROUP_ATTACH_TYPES="$(bpftool feature list_builtins attach_types 2>/dev/null | \
                         grep '^cgroup_')"
                     local ATTACH_FLAGS='multi override'
-                    local PROG_TYPE='id pinned tag name'
                     # Check for $prev = $command first
                     if [ $prev = $command ]; then
                         _filedir
@@ -1086,7 +1076,6 @@ _bpftool()
             esac
             ;;
         net)
-            local PROG_TYPE='id pinned tag name'
             local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload'
             case $command in
                 show|list)
@@ -1193,14 +1182,14 @@ _bpftool()
                 pin|detach)
                     if [[ $prev == "$command" ]]; then
                         COMPREPLY=( $( compgen -W "$LINK_TYPE" -- "$cur" ) )
-                    else
+                    elif [[ $pprev == "$command" ]]; then
                         _filedir
                     fi
                     return 0
                     ;;
                 *)
                     [[ $prev == $object ]] && \
-                        COMPREPLY=( $( compgen -W 'help pin show list' -- "$cur" ) )
+                        COMPREPLY=( $( compgen -W 'help pin detach show list' -- "$cur" ) )
                     ;;
             esac
             ;;
-- 
2.34.1


