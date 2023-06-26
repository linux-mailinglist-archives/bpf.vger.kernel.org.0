Return-Path: <bpf+bounces-3479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E05973E739
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF281C20973
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749B134C5;
	Mon, 26 Jun 2023 18:11:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE05134B3
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 18:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B96FC433C8;
	Mon, 26 Jun 2023 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687803095;
	bh=2U52dcWmqtT+N7qp8s667kFTtabBWUvZfK1aeU1/FE8=;
	h=From:To:Cc:Subject:Date:From;
	b=elzxVr08Xovc7Dg1NIDcPOJEwiTpTvW8iJxSpC8bvAMtqRAbW3nRD17TFPtBZNiLO
	 6ITijiI5XIuwMaHoB20aLVj/oQdhZrrRCn+i+LqN4h4RPHoQTp273MzXv2kh9g/xw3
	 VC4sZyY1sCRz4r6rRi6DlPVNU+ohBOGgiApkJnS72iQ8a7dWgVZuoKFYA4cqWaQpst
	 RVyKrk27vo+rH9LXtBvQp3pc63wSOxpewfgB1ElwAVuPwVDOOjrLhNfk1UVTl84t1s
	 zp/OL48ZW7d9OuvUPM6mChk3Sgapg+64aMs+DhZXn5CWmix/+wRquRTAJJNiHrcBCu
	 J7yY4Nmsvnkgg==
From: SeongJae Park <sj@kernel.org>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date: Mon, 26 Jun 2023 18:11:20 +0000
Message-Id: <20230626181120.7086-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__register_btf_kfunc_id_set() assumes .BTF to be part of the module's
.ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
the function prints an error message and return an error.  As a result,
such modules cannot be loaded.

However, the section could be stripped out during a build process.  It
would be better to let the modules loaded, because their basic
functionalities have no problem[1], though the BTF functionalities will
not be supported.  Make the function to lower the level of the message
from error to warn, and return no error.

[1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/

Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
Cc: <stable@vger.kernel.org> # 5.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 kernel/bpf/btf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b682b8e4b50..d683f034996f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf) {
-		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
+		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register kfuncs\n");
 		return 0;
 	}
 	if (IS_ERR(btf))
-- 
2.25.1


