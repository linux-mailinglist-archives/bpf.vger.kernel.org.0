Return-Path: <bpf+bounces-10145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64907A1C4B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206E21C20EC1
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86790FC05;
	Fri, 15 Sep 2023 10:32:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79063A5
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E70C433C9;
	Fri, 15 Sep 2023 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694773953;
	bh=glvBzi50Crt0kBAVuW8cHMSxgrYkWeEer7JHK1luND0=;
	h=From:To:Cc:Subject:Date:From;
	b=FRPtM5EikGG7NjshReM5LVaTC7UgRBagdiFOnhnZfpIcyljUykUREpuh0n+zWMnRh
	 0iAVKXEdHzP2A3nJtCaaf1yxicxIAFUmef9OTDepYDyguLmzzkaVkKrkGqnRO0JkB2
	 wrwBMsFcg7k/OpW4ZDxampJpiKT/JHC3NZpPqIXLDyDUVmyz71jy7XGUZ2UXa8HVer
	 ppbUbbrZ8S8gbSDNhs0u+r7WGbG3RBiZeh5Zeng9VU6tkzeOJ9sykO5XTdyUwKSGBA
	 bMmrmsyjI9ptR8tK1VGWjUpc1c+6UHeYMwQtLE0YkSGwBs9akMd1c/Rh/lLfr8ja8b
	 BZ1/kxAkEHSHA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Marcus Seyfarth <m.seyfarth@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Fix BTF_ID symbol generation
Date: Fri, 15 Sep 2023 12:32:28 +0200
Message-ID: <20230915103228.1196234-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marcus and Nick reported issue where BTF_ID macro generates same
symbol in separate objects and that breaks final vmlinux link.

Adding __LINE__ number suffix to make BTF_ID symbol more unique,
which is not real fix, but it would help for now and meanwhile
we can work on better solution as suggested by Andrii in [2].

[1] https://github.com/ClangBuiltLinux/linux/issues/1913
[2] https://lore.kernel.org/bpf/ZQQVr35crUtN1quS@krava/T/#m64d7c29c407d6adf0e7b420359958b3aafa7bf69
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a3462a9b8e18..a9cb10b0e2e9 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -49,7 +49,7 @@ word							\
 	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
-- 
2.41.0


