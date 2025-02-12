Return-Path: <bpf+bounces-51237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87521A32377
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 11:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AC73A4AFA
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F952080FE;
	Wed, 12 Feb 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XN/z+1b9"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F41E500C;
	Wed, 12 Feb 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356104; cv=none; b=N5uGYNt9fRu2nDgwla9KHz+XB+4w3A38KBEP/tLrKtXiyQXjXtG9PR59WPO6R0+qbGRhT6D//JSjfSwvQlUgEQ9ydRTWi7I5ydu7RwTqefIcvhDz2Zd55v8MMkhEPzfZWRjGyugxhyXglOmd5kAZu6GGF9o4XzIngfOQkaii7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356104; c=relaxed/simple;
	bh=Wz6iXmcsFrEVmG+EnId6NIbwPCBvteN3+pwH0yeRkCw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=B8q3vvfaSFSXsC407dlqOWQeNOYOMTZzSuaBZl4biEDLJIuBRwhGbuZ+zVYnofHzauo7bXiuTTNwnad+68qPx6PG9Lwc38UKQ1uzaa9R7SAhpM0hy/n4o8mRV1i6mD+3f1p73Mcshi1zuPjDAtB8Qmvp/hponqGqwv8u9sW2GWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XN/z+1b9; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739356098;
	bh=oSSe/GgjHh0szYlaaSrh9h5S5lfXg+8ynEri0cdnafE=;
	h=From:To:Cc:Subject:Date;
	b=XN/z+1b9lnObCyfUBddYK18Quw9q3Oul84P+30onmtZ4zg0TFVI/GXfNNLFJB4FZ2
	 +Q+umUnph7CR/RKXA7QxwPFg/bzWrvvmDcmC+BJHUkhDapnPleaIbcsmw8uVQqrE9K
	 aRUG0LOrWCF0b+wVx6XarGl3RrBn7EhBrFzSQq+4=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 3A13BEE0; Wed, 12 Feb 2025 18:14:33 +0800
X-QQ-mid: xmsmtpt1739355273tjnp76cxp
Message-ID: <tencent_515567355C0AA854BDA68C3A219A18040B0A@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAFZpyS7yx/QaJJ5E7k2RZ6evFMt+32t2NM12PZiwQMFH+K4aC5f
	 1Tf6QWtScoaM4kvdwK0TnyxmcOVNVR8SI5kQkD8d3tc1i2RzJYO2GEDa34Ikj16eoKMW3VMtV1Np
	 uMtmNG5yBMXbkpjeJbXYz1lpYXfH6PIaB+5LJq+apOAIxvQTkCbcTlgZ1hY1eVOsfFHIE2A8KN5T
	 KTlN7R3pB2CCX69SIK9WOOIt4oWkX/I4XaiMRrKhESZ5ljjlFicwDxzJt44Qo3JfEcZR5ojhcbSb
	 Ao7q9gbQCRcVPLq7FYt6+0yqSddNNOYP3kwMO9f1TWqcQkaj2VBLPLA0tjHydeQrW+yDeExqjFKH
	 SX9E/JjGZYX4JjNgibNL+NSJynrD7oSt4FDcZw9LMD+6H6uw+/ELlgNPkxkOlNSM12TcTr16ahT/
	 EDuN+hhRoqFDOVZT9dxSeo9G7RliqLxwpf0OkVG0Ctq6bju/E1LAhyObswmEBQuTfK9tOx1oDdTl
	 x4C03VQHDEQmjceejL3Y303Cepdk1Ci8keLeMHpuR80xWE90FkvnifoB+P2XuvlMrTrdmdDnMP/A
	 fvnETyPayttdYyxFcejzyeiRujLomRERYX/k/ZCNfVl2+65y6fkTWFKBDJWkRvr/aEjq415jLSk8
	 8RV7Q7l/tB6Vh4nF2k6n1Xd6BN1CVauNp/M10oC62WwDUZ2o2bI6Iumtkrltqc9d/qsHDIN0eLsf
	 tu4hQ0fRbi3Tvu6mbdLG6V37dXVo3GKnxIvpGzqSbX4tsz5O6ujDuBFz0rzAgv4EMWG5OTnqnBPX
	 0hWC6QRS3ayPrR3WLYV/PIXHUFwjAovFUNu9pyy2fw3HRRxsDGVFnFqE34XdjArdxoA1CfT1FcGW
	 P+79qZri1+CHVlERhAS48DaFayKkKFwN/axoaTClp5AZEccO1cj6ppAq7MAIj6Jq/rOMMQ02S29b
	 KH/fEvqWvjAO4Gz/CX/EsRQoS6iNR1LTeVFDr2PTIkKXVD9Ch7/LHiQlwy1Lw3
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Rong Tao <rtoax@foxmail.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: rongtao@cest.ccn,
	rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] bpftool: bash-completion: Add nopasswd sudo prefix for bpftool
Date: Wed, 12 Feb 2025 18:14:30 +0800
X-OQ-MSGID: <20250212101432.186343-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

In the bpftool script of bash-completion, many bpftool commands require
superuser privileges to execute. Otherwise, Operation not permission will
be displayed. Here, we check whether ordinary users are exempt from
entering the sudo password. If so, we need to add the sudo prefix to the
bpftool command to be executed. In this way, we can obtain the correct
command completion content instead of the wrong one.

For example, when updating array_of_maps, the wrong 'hex' is completed:

    $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
    $ sudo bpftool map update name arr_maps key 0 0 0 0 value hex

However, what we need is "id name pinned". Similarly, there is the same
problem in getting the map 'name' and 'id':

    $ sudo bpftool map show name [tab] < get nothing
    $ sudo bpftool map show id [tab]   < get nothing

This commit fixes the issue.

    $ sudo bpftool map update name arr_maps key 0 0 0 0 value [tab]
    id      name    pinned

    $ sudo bpftool map show name
    arr_maps         cgroup_hash      inner_arr1       inner_arr2

    $ sudo bpftool map show id
    11    1383  4091  4096

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/bpftool/bash-completion/bpftool | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 1ce409a6cbd9..25fb859cdfa4 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -5,6 +5,15 @@
 #
 # Author: Quentin Monnet <quentin.monnet@netronome.com>
 
+# In the bpftool script of bash-completion, many bpftool commands require
+# superuser privileges to be executed. Otherwise, EPERM will occur. Here,
+# it is detected whether ordinary users are exempt from sudo passwords. If
+# so, it is necessary to add the "sudo" prefix to the required bpftool
+# command execution.
+if sudo --non-interactive true 2>/dev/null; then
+    _sudo=sudo
+fi
+
 # Takes a list of words in argument; each one of them is added to COMPREPLY if
 # it is not already present on the command line. Returns no value.
 _bpftool_once_attr()
@@ -46,7 +55,7 @@ _bpftool_one_of_list()
 
 _bpftool_get_map_ids()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp map  2>&1 | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -54,14 +63,14 @@ _bpftool_get_map_ids()
 _bpftool_get_map_ids_for_type()
 {
     local type="$1"
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp map  2>&1 | \
         command grep -C2 "$type" | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_map_names()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp map  2>&1 | \
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -69,38 +78,38 @@ _bpftool_get_map_names()
 _bpftool_get_map_names_for_type()
 {
     local type="$1"
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp map  2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp map  2>&1 | \
         command grep -C2 "$type" | \
         command sed -n 's/.*"name": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_prog_ids()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp prog 2>&1 | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_prog_tags()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp prog 2>&1 | \
         command sed -n 's/.*"tag": "\(.*\)",$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_prog_names()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp prog 2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp prog 2>&1 | \
         command sed -n 's/.*"name": "\(.*\)",$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_btf_ids()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp btf 2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp btf 2>&1 | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
 _bpftool_get_link_ids()
 {
-    COMPREPLY+=( $( compgen -W "$( bpftool -jp link 2>&1 | \
+    COMPREPLY+=( $( compgen -W "$( ${_sudo} bpftool -jp link 2>&1 | \
         command sed -n 's/.*"id": \(.*\),$/\1/p' )" -- "$cur" ) )
 }
 
@@ -156,7 +165,7 @@ _bpftool_map_guess_map_type()
     [[ -z $ref ]] && return 0
 
     local type
-    type=$(bpftool -jp map show $keyword $ref | \
+    type=$(${_sudo} bpftool -jp map show $keyword $ref | \
         command sed -n 's/.*"type": "\(.*\)",$/\1/p')
     [[ -n $type ]] && printf $type
 }
-- 
2.48.1


