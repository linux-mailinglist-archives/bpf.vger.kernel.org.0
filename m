Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0965528FB
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiFUB2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 21:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbiFUB2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 21:28:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629191929B
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 18:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18703B811EC
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F971C341C4;
        Tue, 21 Jun 2022 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655774901;
        bh=CbobNexbSTRL4hb1DX7jZ8y8Bnbyzx+ASnJ+WrY38Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T11K8BnWYo8+1G92f9KAlcTd1u4z9tmrZNvh2ZtQjkijWG2fBVYEZEuLYtTKn82nX
         nxC6TJOc6FzzUxNPAQHC8rAbU+8T8tDFiX1SWDSfTUTfGF1f1sGWMBapZ6N7Uk5ocy
         7V40y/wXGBxhRI9YJAHEUGqmSHNsdamIPP9+x/GX7MzQ7PuQ4LXdU8aSkqTGVXrq/r
         DKWdZBAk1debCOhSaasTRAtbo23cpVRt7mAsdqpbN5JalijYr8PVhacR7j0NMlsgIj
         iwCMfKwELIUpfdD2UkF6ZpX2J6mUHSvp2S56KG+N69CqxN8K1J9HyRZxsheFmya/ee
         lp/xqZCUEQpmg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v2 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
Date:   Tue, 21 Jun 2022 01:28:09 +0000
Message-Id: <20220621012811.2683313-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621012811.2683313-1-kpsingh@kernel.org>
References: <20220621012811.2683313-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for the addition of bpf_getxattr kfunc.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 02d7951591ae..541cf4635aa1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.37.0.rc0.104.g0611611a94-goog

