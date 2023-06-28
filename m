Return-Path: <bpf+bounces-3668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714AF7416AC
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040D0280DA8
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09119D2FA;
	Wed, 28 Jun 2023 16:46:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C1322E
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 16:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF24C433C9;
	Wed, 28 Jun 2023 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687970773;
	bh=Anh7J4kRhla0M1qr85cZBcy7HHbIz4mqCgOTHfAu7b4=;
	h=From:To:Cc:Subject:Date:From;
	b=jjWMAEUDSlBwfrfqiCEyfcuBYUqTlz/wwd8ni3Lu7xzaEwKOtQ9FP/L9et5oyjVVJ
	 ZgEmyFeNGrWs84CYZANfS8F0unnD0CWsQyPUjzVlxc9S5ZYyGA0QdYyBCdbdGDIgL5
	 NBszENm6/4vgSOv2dcK4+mWK0RCdyO8ikAxKJkL30Pc+LmNCAY4oKzF+wvoUMv4TJN
	 vFemQWAni9uVer6e2IFtc9+0Bn3sNFbxbPEj5I1GzKjXhc6rhin82rZeUfQ8IHbyUx
	 uk/s4bO9MhQ6bHDAlW4WUzKyjOXZeUwVRTX99QLpk4jtEoVuBmN2SR6blmjERdOiyY
	 9WFcjPJKmXOiA==
From: SeongJae Park <sj@kernel.org>
To: martin.lau@linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	Alexander.Egorenkov@ibm.com,
	ast@kernel.org,
	memxor@gmail.com,
	olsajiri@gmail.com,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date: Wed, 28 Jun 2023 16:46:11 +0000
Message-Id: <20230628164611.83038-1-sj@kernel.org>
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
Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
Changes from v1
(https://lore.kernel.org/all/20230626181120.7086-1-sj@kernel.org/)
- Fix Fixes: tag (Jiri Olsa)
- Add 'Acked-by: ' from Jiri Olsa

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


