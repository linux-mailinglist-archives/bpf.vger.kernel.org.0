Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0396294D2
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKOJuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 04:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiKOJuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 04:50:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C291210FC7
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 01:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC976157E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D3DC433C1;
        Tue, 15 Nov 2022 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668505848;
        bh=OoyzS1XqMqSfR/sjCelb3asBQoG2s5J9uPGMiKs42EY=;
        h=From:To:Cc:Subject:Date:From;
        b=MuuMvGJnq/ntCgCJ6pTe+uqAjqkmGOMuv520Ufj9hJD06Un3o7nWjiJwHsfUWr8Bi
         gX8aQaUVSG92SloOm93HUVPihj+TVGosuOCLdsigJMmkC3BhDwuu7dCe0UFMniDIER
         L6xz/s/XuZikajSNhsuI33zYlr0i7D4GOVXLVilKb0RTn5F82RpU4m08niJy8zT0Fj
         iQbFPoI6EMkduYpMkfTb0VF5wBd0KDJdhehudljFlJohjsQaneV3xKYtNZtYtSzW1/
         WJ/R4zGYMRCoJBrJzExeMF4rfO4wjdNsLRZ7kE4Q9EAcYDZw4BDMAoAb92VolriGZF
         RgHSH6DmzWxkQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>
Subject: [RFC bpf-next] bpf: Fix perf bpf event and audit prog id logging
Date:   Tue, 15 Nov 2022 10:50:43 +0100
Message-Id: <20221115095043.1249776-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
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

hi,
perf_event_bpf_event and bpf_audit_prog calls currently report zero
program id for unload path.

It's because of the [1] change moved those audit calls into work queue
and they are executed after the id is zeroed in bpf_prog_free_id.

I originally made a change that added 'id_audit' field to struct
bpf_prog, which would be initialized as id, untouched and used
in audit callbacks.

Then I realized we might actually not need to zero prog->aux->id
in bpf_prog_free_id. It seems to be called just once on release
paths. Tests seems ok with that.

thoughts?

thanks,
jirka


[1] d809e134be7a ("bpf: Prepare bpf_prog_put() to be called from irq context.")
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fdbae52f463f..426529355c29 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1991,7 +1991,6 @@ void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock)
 		__acquire(&prog_idr_lock);
 
 	idr_remove(&prog_idr, prog->aux->id);
-	prog->aux->id = 0;
 
 	if (do_idr_lock)
 		spin_unlock_irqrestore(&prog_idr_lock, flags);
-- 
2.38.1

