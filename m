Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2825E34261B
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 20:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCSTVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 15:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231152AbhCSTV0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 15:21:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBE7361962;
        Fri, 19 Mar 2021 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616181686;
        bh=DColqhi4bJMbEWnOeMyhyGFQdglgX+BH1SDZZ6XcyI0=;
        h=From:To:Cc:Subject:Date:From;
        b=ep+LmIFAPlsBCd+rkb06kARKKPfAOOU4LGjOZhElgxJmrL64QCnGQ85nGNkAdiHma
         CKEqZ4QT0LXSlD+Sc9rAJSw09Bg/elLTArkTWLj9rIxtWjLnFfG341ebXfMAGEd2XN
         8dLY0knpo1lDbwaKIggjH0PfI4PgVzMuNlXsR/5zDGg5HSShyT7muoU29VulZiLvN4
         uDKb2N9bNoR5WZXhWK76ARy0RBRJx2rEl+JejWMPi0fN8Ygjh4XoIF9bwD9DaPPcgp
         LelwAwwCfkCQkZ21fz72bZ679ZHOyOpthPL0C0iGsTKsQ0rWoBz9Ra3iHMHqQtIm0d
         6VLj7Kr10Temw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] libbpf: Add explicit padding to btf_dump_emit_type_decl_opts
Date:   Fri, 19 Mar 2021 19:21:17 +0000
Message-Id: <20210319192117.2310658-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to
https://lore.kernel.org/bpf/20210313210920.1959628-2-andrii@kernel.org/

When DECLARE_LIBBPF_OPTS is used with inline field initialization, e.g:

  DCLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
    .field_name = var_ident,
    .indent_level = 2,
    .strip_mods = strip_mods,
  );

and compiled in debug mode, the compiler generates code which
leaves the padding uninitialized and triggers errors within libbpf APIs
which require strict zero initialization of OPTS structs.

Adding anonymous padding field fixes the issue.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 9f81654eebe8 ("libbpf: Expose BTF-to-C type declaration emitting API")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/btf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 3b0b17ba94a1..b54f1c3ebd57 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -176,6 +176,7 @@ struct btf_dump_emit_type_decl_opts {
 	int indent_level;
 	/* strip all the const/volatile/restrict mods */
 	bool strip_mods;
+	size_t :0;
 };
 #define btf_dump_emit_type_decl_opts__last_field strip_mods
 
-- 
2.31.0.rc2.261.g7f71774620-goog

