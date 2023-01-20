Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC167544E
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 13:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjATMV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 07:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjATMV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 07:21:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26932A579B
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 04:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE7E61F34
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CCBC433EF;
        Fri, 20 Jan 2023 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674217314;
        bh=sJlSk7pXrC6V7wgXhoxvqEvnzXsduWRYRPTy3OmZfTM=;
        h=From:To:Cc:Subject:Date:From;
        b=K2zleOxCauGv9g57JKdkKohoqSEhF40JoTifb5KNq6aGy9t69/3jd4EP7NkikfLP7
         KQaq3ZrGX68ariPL+K/1FI7jhCKSU/OUbT1ZuJC1348InWUom0VEAYmhvWrEkhHV6b
         6Heg16f6jo7Om+8izmaEtyTB/44mPczQDjScHUq0mY18MZg+dUkZgUvHXNPUFMNAG0
         0HSj1G5Mvw3BFDYRAw4lRxMsSAuAa5QaJcgDwrOs7gcKmcYRoaYJnGYKSk0BrwKE5B
         j8TvhdaXeQUIfaiB9TnJmfLoQne0cpNUrbsjb4guyczy1YRrhf+gZe/vZGnzQPcL1s
         PeEkj/KfjS49g==
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
Subject: [PATCHv2 bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
Date:   Fri, 20 Jan 2023 13:21:48 +0100
Message-Id: <20230120122148.1522359-1-jolsa@kernel.org>
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
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v2 changes:
  - resend and added Kumar's ack

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

