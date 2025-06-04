Return-Path: <bpf+bounces-59587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B20ACD29E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F3C1886C99
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04024167B;
	Wed,  4 Jun 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH1GZ5bc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523FC1A315D;
	Wed,  4 Jun 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998647; cv=none; b=Q0NonNozjIur6IxMbKpvInTyaybRxK/r7TvCJxvueTK/Lufn0yy3UT24XxRQQxf961+3I/Gn8M+3uHAC7R4X+q3Nlo2czOaKw64zTqDsutUnqHOjqFixrmo1qWfbPBWI0i61iao/Ph6yTXz8YGLjI7cTUnVYhYer+lWDLoAdPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998647; c=relaxed/simple;
	bh=SFTdTKA7c2EuhIcP2Lr9BRD/MecKbH1xxQf//k5d1U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9rI9lQAVnlwcQ+b3RDKsoygGrsIl7W/7CFGOG615s8OrK5FKjc+4Omya0TM349DnuVULjJ/CfTuTBkpGj5A8XYf9H9Xno0KPlJpqd6JMr6XiUF+evCAZBsh4hdxVIrXAESZZm8Arf3dWB9OdXXwH+V5u2eh5hZubPY3ul0TcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH1GZ5bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3791BC4CEED;
	Wed,  4 Jun 2025 00:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998647;
	bh=SFTdTKA7c2EuhIcP2Lr9BRD/MecKbH1xxQf//k5d1U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bH1GZ5bcGQjVuIba7NCVBCYDAzwrlXVe4lpOEPItPt9Ol6KPiuNbkhG9Q9azWZCOA
	 yVLXIy3a5U74Vb64/XbdTtshcFm7Efcxm3kVLgqt+oeSayTslPM8b7UCeaGedai9eT
	 H+cOrQK0WzVzUlS01CjnJoBLizqGBVzD85y8BnmDvDWciCB2wFtXO7TiEF1OGLi7u3
	 /Y1/1hI2e0d23UiZLhZtrlRJWvTa00cURkKRQb23OQw2XBo0rx17tbVDcbb1O5DHQ7
	 VAzFdhUgK5RhOv9fkAA7nAnyBlVOAs4nZ/MyB1A68KUiG+CtFqZaQfvQ3xmMNgMp/B
	 L7sQ3RN8aHBFg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Takshak Chahande <ctakshak@meta.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 055/108] bpftool: Fix cgroup command to only show cgroup bpf programs
Date: Tue,  3 Jun 2025 20:54:38 -0400
Message-Id: <20250604005531.4178547-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit b69d4413aa1961930fbf9ffad8376d577378daf9 ]

The netkit program is not a cgroup bpf program and should not be shown
in the output of the "bpftool cgroup show" command.

However, if the netkit device happens to have ifindex 3,
the "bpftool cgroup show" command will output the netkit
bpf program as well:

> ip -d link show dev nk1
3: nk1@if2: ...
    link/ether ...
    netkit mode ...

> bpftool net show
tc:
nk1(3) netkit/peer tw_ns_nk2phy prog_id 469447

> bpftool cgroup show /sys/fs/cgroup/...
ID       AttachType      AttachFlags     Name
...      ...                             ...
469447   netkit_peer                     tw_ns_nk2phy

The reason is that the target_fd (which is the cgroup_fd here) and
the target_ifindex are in a union in the uapi/linux/bpf.h. The bpftool
iterates all values in "enum bpf_attach_type" which includes
non cgroup attach types like netkit. The cgroup_fd is usually 3 here,
so the bug is triggered when the netkit ifindex just happens
to be 3 as well.

The bpftool's cgroup.c already has a list of cgroup-only attach type
defined in "cgroup_attach_types[]". This patch fixes it by iterating
over "cgroup_attach_types[]" instead of "__MAX_BPF_ATTACH_TYPE".

Cc: Quentin Monnet <qmo@kernel.org>
Reported-by: Takshak Chahande <ctakshak@meta.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/r/20250507203232.1420762-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

This file seems unrelated to the current commit. Let me now analyze the
specific commit to understand if it should be backported. **Analysis of
the commit:** ## YES **Extensive explanation:** This commit should be
backported to stable kernel trees because it fixes a clear functional
bug with specific user-visible incorrect behavior. Here's why: ### 1.
**Fixes a clear user-visible bug** The commit fixes a specific issue
where `bpftool cgroup show` incorrectly displays non-cgroup BPF programs
(specifically netkit programs) when their interface index happens to
match the cgroup file descriptor. This is documented as causing
confusing output where netkit programs appear in cgroup listings where
they don't belong. ### 2. **Small, contained fix with minimal risk**
Looking at the code changes in `tools/bpf/bpftool/cgroup.c`: - **Lines
321-325**: Changed from `enum bpf_attach_type type;` to `unsigned int
i;` in `do_show()` - **Lines 373-381**: Changed from `for (type = 0;
type < __MAX_BPF_ATTACH_TYPE; type++)` to `for (i = 0; i <
ARRAY_SIZE(cgroup_attach_types); i++)` and using
`cgroup_attach_types[i]` instead of `type` - **Lines 403-405**: Same
pattern change in `do_show_tree_fn()` - **Lines 437-438**: Same pattern
change in the tree function loop The fix is straightforward: instead of
iterating through all possible BPF attach types
(`__MAX_BPF_ATTACH_TYPE`), it now only iterates through the predefined
array `cgroup_attach_types[]` which contains only cgroup-specific attach
types. ### 3. **Root cause is clearly identified** The bug occurs
because: - `target_fd` (cgroup_fd) and `target_ifindex` are in a union
in the BPF uapi - When iterating through all attach types including non-
cgroup types like `BPF_NETKIT_PRIMARY`, the kernel interprets the
cgroup_fd as an ifindex - When the cgroup_fd value (often 3) matches a
netkit device's ifindex, the query succeeds and incorrectly shows the
netkit program as a cgroup program ### 4. **Existing infrastructure used
correctly** The fix leverages the existing `cgroup_attach_types[]` array
that was already defined in the file (lines 22-52) but not being used in
the iteration loops. This array contains only legitimate cgroup attach
types, making the fix both correct and consistent with the existing
codebase. ### 5. **No functional changes to legitimate use cases** The
change only affects what gets queried - it will no longer query non-
cgroup attach types, which should never have been relevant to cgroup
operations anyway. All legitimate cgroup functionality remains
unchanged. ### 6. **Typical stable tree material** This fits the stable
tree criteria perfectly: - **Important bug fix**: Fixes
incorrect/confusing output that misleads users - **Small and obvious**:
The change is minimal and the fix is clear - **No architectural
changes**: This is just correcting the iteration logic - **Low
regression risk**: The change only restricts what gets queried to the
appropriate types - **Userspace tool fix**: While this is a userspace
tool, bpftool is part of the kernel tree and these fixes are commonly
backported ### 7. **Matches pattern of similar commits** Looking at the
similar commits provided, while they were marked as "NO" for
backporting, those were mostly feature additions (adding netkit support,
implementing new functionality, etc.). This commit is fundamentally
different - it's a pure bug fix that corrects existing functionality
rather than adding new features. The commit explicitly states it's a
"Fix" in the subject line and clearly describes the incorrect behavior
being corrected, making it a strong candidate for stable backporting.

 tools/bpf/bpftool/cgroup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 93b139bfb9880..a866033afd136 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -318,11 +318,11 @@ static int show_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 
 static int do_show(int argc, char **argv)
 {
-	enum bpf_attach_type type;
 	int has_attached_progs;
 	const char *path;
 	int cgroup_fd;
 	int ret = -1;
+	unsigned int i;
 
 	query_flags = 0;
 
@@ -370,14 +370,14 @@ static int do_show(int argc, char **argv)
 		       "AttachFlags", "Name");
 
 	btf_vmlinux = libbpf_find_kernel_btf();
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
 		/*
 		 * Not all attach types may be supported, so it's expected,
 		 * that some requests will fail.
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_bpf_progs(cgroup_fd, type, 0) == 0)
+		if (show_bpf_progs(cgroup_fd, cgroup_attach_types[i], 0) == 0)
 			ret = 0;
 	}
 
@@ -400,9 +400,9 @@ static int do_show(int argc, char **argv)
 static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 			   int typeflag, struct FTW *ftw)
 {
-	enum bpf_attach_type type;
 	int has_attached_progs;
 	int cgroup_fd;
+	unsigned int i;
 
 	if (typeflag != FTW_D)
 		return 0;
@@ -434,8 +434,8 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 	}
 
 	btf_vmlinux = libbpf_find_kernel_btf();
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
-		show_bpf_progs(cgroup_fd, type, ftw->level);
+	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++)
+		show_bpf_progs(cgroup_fd, cgroup_attach_types[i], ftw->level);
 
 	if (errno == EINVAL)
 		/* Last attach type does not support query.
-- 
2.39.5


