Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DA3569459
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiGFV3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiGFV3P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 17:29:15 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93E27145
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 14:29:13 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 3763624010B
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 23:29:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657142952; bh=9homCnqwI15GIWOQULXVSDjYJLGAe6h8MyQUPuLRBJ0=;
        h=From:To:Subject:Date:From;
        b=g7cLiMHqUtaaMzeVp7FEXerI/wPYKFPYDMwM7bbGxMv7nPKWxm9bdNWnNFkM+uS+K
         gPsSBnepmjXEtSITu6RJRZxnUx3H3wplTzRkzycL3Loriv3fXgR3z/e2ub8ymUruMN
         7TP1PGWRWpcvBZpsowfsGblcoEQTgbnv7j9HzWAiXiSiGI7E8M1cd4G5GyWRpXw+Kh
         GoWGpzPDBYu3b6sFzVDQrsndcK/qTTFvx+oVRVFksMsoDhNo2iKFCBGBE9ZFmrLG+g
         fF32G5mmjyAdAuruPKaaFKjQjbJ1cYw3FHv1QwDSe5oy4TsQyorEXBWEGo/DZFC5cO
         DJ8nMVqdqjbCQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LdXjg3G0bz9rxM;
        Wed,  6 Jul 2022 23:29:11 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, quentin@isovalent.com, kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpftool: Add support for KIND_RESTRICT to gen min_core_btf command
Date:   Wed,  6 Jul 2022 21:28:54 +0000
Message-Id: <20220706212855.1700615-2-deso@posteo.net>
In-Reply-To: <20220706212855.1700615-1-deso@posteo.net>
References: <20220706212855.1700615-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change adjusts bpftool's type marking logic, as used in conjunction
with TYPE_EXISTS relocations, to correctly recognize and handle the
RESTRICT BTF kind.

[0]: https://lore.kernel.org/bpf/20220623212205.2805002-1-deso@posteo.net/T/#m4c75205145701762a4b398e0cdb911d5b5305ffc

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/bpf/bpftool/gen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 3d35fbc..1cf53b 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1762,6 +1762,7 @@ btfgen_mark_type(struct btfgen_info *info, unsigned int type_id, bool follow_poi
 		}
 		break;
 	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_TYPEDEF:
 		err = btfgen_mark_type(info, btf_type->type, follow_pointers);
-- 
2.30.2

