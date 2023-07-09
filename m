Return-Path: <bpf+bounces-4534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6505474C518
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5491C20932
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF7AD55;
	Sun,  9 Jul 2023 15:13:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928BAD4B
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E2C433C8;
	Sun,  9 Jul 2023 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915594;
	bh=uXdrSOZeeHVieKI5DkfEOklZyWMsP5TuvjKoqA0mSlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/48jTefdwjSO2fcLN2aJf36tzTFKK59h0mY/A1dGyuBeu+hHtHRsDF+UzpryCDjA
	 YBKnonvhN3OlFbOUFyRjqkwxEySYoo12Qd7p8oBZdn3YADxpuPEqrw2rWGp00ZJ6dh
	 0F+akPARq84FJZCK2k+v7E3hgfaRT9HrAZNhDLoPjyHbabVgw8sKSorz3qk/j5OgMO
	 9qSaagPDkSbOhUEtQW36TjKatM9OPaYDAOrSC75Fj1KQqyVvFXUDSqm3KfHsSwsCgG
	 LzHNDG8OufSjWC2Xknbd8VljGB6R1+GSY/a6McaJYEOMLkTxUg5y2DeVjLV9dahi8G
	 D8kJZkLGutfrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yhs@fb.com>,
	syzbot+958967f249155967d42a@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/26] bpf: Silence a warning in btf_type_id_size()
Date: Sun,  9 Jul 2023 11:12:39 -0400
Message-Id: <20230709151255.512931-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yhs@fb.com>

[ Upstream commit e6c2f594ed961273479505b42040782820190305 ]

syzbot reported a warning in [1] with the following stacktrace:
  WARNING: CPU: 0 PID: 5005 at kernel/bpf/btf.c:1988 btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
  ...
  RIP: 0010:btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
  ...
  Call Trace:
   <TASK>
   map_check_btf kernel/bpf/syscall.c:1024 [inline]
   map_create+0x1157/0x1860 kernel/bpf/syscall.c:1198
   __sys_bpf+0x127f/0x5420 kernel/bpf/syscall.c:5040
   __do_sys_bpf kernel/bpf/syscall.c:5162 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5160 [inline]
   __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5160
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

With the following btf
  [1] DECL_TAG 'a' type_id=4 component_idx=-1
  [2] PTR '(anon)' type_id=0
  [3] TYPE_TAG 'a' type_id=2
  [4] VAR 'a' type_id=3, linkage=static
and when the bpf_attr.btf_key_type_id = 1 (DECL_TAG),
the following WARN_ON_ONCE in btf_type_id_size() is triggered:
  if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
                   !btf_type_is_var(size_type)))
          return NULL;

Note that 'return NULL' is the correct behavior as we don't want
a DECL_TAG type to be used as a btf_{key,value}_type_id even
for the case like 'DECL_TAG -> STRUCT'. So there
is no correctness issue here, we just want to silence warning.

To silence the warning, I added DECL_TAG as one of kinds in
btf_type_nosize() which will cause btf_type_id_size() returning
NULL earlier without the warning.

  [1] https://lore.kernel.org/bpf/000000000000e0df8d05fc75ba86@google.com/

Reported-by: syzbot+958967f249155967d42a@syzkaller.appspotmail.com
Signed-off-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20230530205029.264910-1-yhs@fb.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 72b32b7cd9cd9..b88d30cf2ec4f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -485,25 +485,26 @@ static bool btf_type_is_fwd(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
 }
 
-static bool btf_type_nosize(const struct btf_type *t)
+static bool btf_type_is_datasec(const struct btf_type *t)
 {
-	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
-	       btf_type_is_func(t) || btf_type_is_func_proto(t);
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
 }
 
-static bool btf_type_nosize_or_null(const struct btf_type *t)
+static bool btf_type_is_decl_tag(const struct btf_type *t)
 {
-	return !t || btf_type_nosize(t);
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
 }
 
-static bool btf_type_is_datasec(const struct btf_type *t)
+static bool btf_type_nosize(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
+	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
+	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
+	       btf_type_is_decl_tag(t);
 }
 
-static bool btf_type_is_decl_tag(const struct btf_type *t)
+static bool btf_type_nosize_or_null(const struct btf_type *t)
 {
-	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
+	return !t || btf_type_nosize(t);
 }
 
 static bool btf_type_is_decl_tag_target(const struct btf_type *t)
-- 
2.39.2


