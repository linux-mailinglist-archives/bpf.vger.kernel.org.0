Return-Path: <bpf+bounces-9544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587E798DD5
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB5C281D1F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038A14F95;
	Fri,  8 Sep 2023 18:18:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEFC14F8D
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF4FC43215;
	Fri,  8 Sep 2023 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197081;
	bh=6z5fHVoFtm3zAuIl+nLazhpZWYNxVKrPQUCEKNYBfdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzDroA9w3+/FuXog2jfZC19uuHNf4at+J31teCI3688Dd9eMUTYAa3nlLMfFEkQm4
	 JEQkRF3JAtAQRkbec4WqFJXulxgbo2iKw0kswAcUmEsP0RA3amby3ep1tYlFhz8HIe
	 cgOvnwT1NWCrtaQw2GxGLVQtunkD1ZuXYU/HKAD8CVqOLBKyYDTkdPfPwSsTvij0dT
	 Ej+58AFsGxjYICvkk5rwRHeR2B6PIqaBLWJP4gARWlE5in39Y4AGHB0YcXmsaaRgHC
	 KKO/LncWVjLyezxe3D8sBMw0LG3sKNtsvXaJV4w/ArcjXXFLVb80cW1HiZP8ojFf0r
	 KiMrvkL/oFgmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 40/41] bpf: Consider non-owning refs trusted
Date: Fri,  8 Sep 2023 14:15:54 -0400
Message-Id: <20230908181555.3459640-40-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 2a6d50b50d6d589d43a90d6ca990b8b811e67701 ]

Recent discussions around default kptr "trustedness" led to changes such
as commit 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the
verifier."). One of the conclusions of those discussions, as expressed
in code and comments in that patch, is that we'd like to move away from
'raw' PTR_TO_BTF_ID without some type flag or other register state
indicating trustedness. Although PTR_TRUSTED and PTR_UNTRUSTED flags mark
this state explicitly, the verifier currently considers trustedness
implied by other register state. For example, owning refs to graph
collection nodes must have a nonzero ref_obj_id, so they pass the
is_trusted_reg check despite having no explicit PTR_{UN}TRUSTED flag.
This patch makes trustedness of non-owning refs to graph collection
nodes explicit as well.

By definition, non-owning refs are currently trusted. Although the ref
has no control over pointee lifetime, due to non-owning ref clobbering
rules (see invalidate_non_owning_refs) dereferencing a non-owning ref is
safe in the critical section controlled by bpf_spin_lock associated with
its owning collection.

Note that the previous statement does not hold true for nodes with shared
ownership due to the use-after-free issue that this series is
addressing. True shared ownership was disabled by commit 7deca5eae833
("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"),
though, so the statement holds for now. Further patches in the series will change
the trustedness state of non-owning refs before re-enabling
bpf_refcount_acquire.

Let's add NON_OWN_REF type flag to BPF_REG_TRUSTED_MODIFIERS such that a
non-owning ref reg state would pass is_trusted_reg check. Somewhat
surprisingly, this doesn't result in any change to user-visible
functionality elsewhere in the verifier: graph collection nodes are all
marked MEM_ALLOC, which tends to be handled in separate codepaths from
"raw" PTR_TO_BTF_ID. Regardless, let's be explicit here and document the
current state of things before changing it elsewhere in the series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230821193311.3290257-3-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d24..b6e58dab8e275 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,7 +745,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	}
 }
 
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED | NON_OWN_REF)
 
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
-- 
2.40.1


