Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B239D674C83
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjATFgy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjATFgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CF6A319
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9BB5B8248E
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7138BC433D2;
        Thu, 19 Jan 2023 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674137617;
        bh=wdgWMlRC8fN5MqUQAppUmBygLdghwkSWAmHknN8Juuc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ahy6GF5wZVRwtJNOmXEV0CP6bfLWXMDGG2w/Fhv6NQjwvyuTiizbXq2drc8yAsD5s
         M5pwsdZV2KAgVMP236H7fmsOjthQNFLmJwhCbcBE5Mb2yWp1KT6o7JFUOoxowM0cFt
         pkXV3gIa2G7jg+2SOvfnI6UGq2c3vW/6dGwcouFz+Z3a8Tf0g3z2H+lbZwyh6foOGa
         pD7KIiO3fyNLfeg6fow575VerSxLsg2hZXeNL5f2avQKFM5SOZRoFyEgy/B0dNR7Fh
         exG7q9IEPjeT+FkSGxHK2iulzZOOMJS2BhQNnbsRjqhn7d97n8EOdNhxQYBHjSrPdG
         VGSdbU0VpPQNw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
Date:   Thu, 19 Jan 2023 15:13:31 +0100
Message-Id: <20230119141331.962281-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We take the BTF reference before we register dtors and we need
to put it back when it's done.

We probably won't se a problem with kernel BTF, but module BTF
would stay loaded (because of the extra ref) even when its module
is removed.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 5ce937d613a4 ("bpf: Populate pairs of btf_id and destructor kfunc in btf")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7dd8af06413..b7017cae6fd1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7782,9 +7782,9 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 
 	sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
 
-	return 0;
 end:
-	btf_free_dtor_kfunc_tab(btf);
+	if (ret)
+		btf_free_dtor_kfunc_tab(btf);
 	btf_put(btf);
 	return ret;
 }
-- 
2.39.0

