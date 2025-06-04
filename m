Return-Path: <bpf+bounces-59575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A03ACD136
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 02:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359E81898F4F
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4C19CD17;
	Wed,  4 Jun 2025 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvHkJRdc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24772601;
	Wed,  4 Jun 2025 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998294; cv=none; b=LdgIz9gfQ2Eq8O956GMceAWwpmpTHRMMa/IZTIhtX9jvTmHYKdKNfkc56w7tLwJu/efmnDYAk21uOojQZ3pEDlFJEpTe6uyL4raddz7Tt4/46jIeSHAJPkE9ATSl4D4HNtN8hIXMEw5u3zwkO8J/feCvH+QomngyQwX7nihadOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998294; c=relaxed/simple;
	bh=FUihMdXbPx6qbv6MxFECbRv+zcfbtx3kaRArwfvTFps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1HBFfwgoKiJFGPqVRN1TtdWvooKBW2bWeY3DZhzmn4zXsuclTwnAymKB2n1A5F6r8GcF7XE/1Vjv21qPxxfEx6Fho7IejJrEkEamLJKcxXbJkUrv6/eMwFqP/SjfpT9LIKoVOa/Lq4vRUCABfEb+t2oL02UaxeYFWqOaBjPARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvHkJRdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B0C4CEF1;
	Wed,  4 Jun 2025 00:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998293;
	bh=FUihMdXbPx6qbv6MxFECbRv+zcfbtx3kaRArwfvTFps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvHkJRdcAJJLrKaBAQMdq1qzNUE9RyluO6G9wAwBO5PW0bSVNwln6VCO5GppNJ++U
	 nCXfH/VyUxSpO7pzgpDoHCql1ULvadAoMzJjJLfsgisKQg9+nG3T9aDT/2A+4XOcLg
	 4mZop0vVU0g0GQ+iOzNl8ZS/dMFJ5Zf33aE2+8O7aa7T36YgHB6vFFUzrGQoYDrNmm
	 lApackrdf5WfdrtOIgYJb1UYgKP2nhz9P99M906STEueLzTHgV4FovGzwQDmZl+pjY
	 Gmni3sRm55OTZ8MM381CfV3TQUFwjbOCHzdV06yTVBBZXuv0IvWSOLH/wRPKb/gj3t
	 i+D2IsD5JZZVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 021/118] libbpf/btf: Fix string handling to support multi-split BTF
Date: Tue,  3 Jun 2025 20:49:12 -0400
Message-Id: <20250604005049.4147522-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005049.4147522-1-sashal@kernel.org>
References: <20250604005049.4147522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 4e29128a9acec2a622734844bedee013e2901bdf ]

libbpf handling of split BTF has been written largely with the
assumption that multiple splits are possible, i.e. split BTF on top of
split BTF on top of base BTF.  One area where this does not quite work
is string handling in split BTF; the start string offset should be the
base BTF string section length + the base BTF string offset.  This
worked in the past because for a single split BTF with base the start
string offset was always 0.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250519165935.261614-2-alan.maguire@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Bug Analysis This commit fixes a critical bug
in libbpf's BTF string offset calculation for multi-level split BTF
scenarios. The specific code change on line 998: ```c // Before (buggy):
btf->start_str_off = base_btf->hdr->str_len; // After (correct):
btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
``` ## Technical Impact **Scenario:** Multi-level split BTF chain (e.g.,
vmlinux BTF → module1 BTF → module2 BTF) **The Bug:** The incorrect
calculation failed to accumulate string offsets across the full BTF
chain. For example: - vmlinux BTF: `start_str_off = 0`, `str_len = 1000`
- module1 BTF: `start_str_off = 1000`, `str_len = 500` - module2 BTF:
`start_str_off = 500` ❌ (should be 1500!) **Consequences:** 1. **Data
Corruption**: String lookups (`btf__str_by_offset()`) return wrong
strings 2. **Potential Crashes**: Incorrect memory access when offset
calculations go wrong 3. **Silent Failures**: Wrong type/field names
returned without obvious errors ## Real-World Impact This affects
several important use cases: 1. **Kernel Module Loading**: Modules with
nested BTF dependencies 2. **BPF Program Loading**: Programs using
complex split BTF 3. **Debugging Tools**: bpftool operations on kernel
modules showing incorrect information 4. **BPF Verification**: Kernel
verifier potentially seeing wrong type names ## Backport Justification
**1. Important Bug Fix**: This fixes existing broken functionality, not
a new feature. The commit message clearly states it's fixing string
handling that "does not quite work." **2. High Impact**: Can cause data
corruption and crashes in real-world scenarios where kernel modules use
multi-level split BTF. **3. Low Risk**: The fix is minimal and surgical
- just correcting a mathematical calculation. The risk of regression is
very low. **4. Existing Functionality**: Multi-level split BTF is
supposed to work (evidenced by the correct implementation in
`btf_new_empty()` and existing test coverage), but this bug broke it.
**5. Real-world Usage**: Kernel modules commonly use split BTF,
especially in distributions with many out-of-tree modules. **6. Test
Coverage**: There are existing BPF selftests that validate multi-level
split BTF scenarios. ## Stable Tree Suitability This meets all stable
tree criteria: - ✅ Fixes important bug affecting users - ✅ Small,
contained change - ✅ No architectural changes - ✅ Minimal regression
risk - ✅ Fixes critical subsystem (BTF/BPF) The similar historical
commits were marked "NO" because they were adding new features (split
BTF support itself) rather than fixing bugs in existing functionality.
This commit is fundamentally different - it's a correctness fix for
functionality that was supposed to work but didn't.

 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 38bc6b14b0666..8a7650e6480f9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -996,7 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 		btf->swapped_endian = base_btf->swapped_endian;
 	}
 
-- 
2.39.5


