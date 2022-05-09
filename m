Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53B520724
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiEIV6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 17:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiEIVzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 17:55:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EE12CE238
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 14:49:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAA58B8199E
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A718C385BF;
        Mon,  9 May 2022 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652132964;
        bh=i2UCswjjKE5vlPuQXaaDcYWxxn1pNf4mH7D2sECUYak=;
        h=From:To:Cc:Subject:Date:From;
        b=Ia1KD7BOC+sxGEpDlqkREEu4jqmUnrh4H2LmZtPHrYc+fMHXzXCmP7oYOb8DfHHQd
         iqFYMJthdEGeCMzOeGzuyRz7oQjvQz2yektFpeDXqc92tdtaU8LkPusKaVkaYwOHYO
         +a2fP2S2LIMr4lH32ws9OceFFa3A62Pkt1bEADXdodimFBzc/K9vvxeQ2dDSPCoGfM
         dzBHhWfjzFqo9dZtWrfKd9t+qm9j7iFeL29usfhMdiiFuFGfGlJm+HGEcDO8Y0WbyF
         VKHAmDmEPL0mUUveJKuLWz3TqlkyLq1jxmcAJjlCpGYIthLo2EuH2iAUZAr6aUrJeR
         qqZdw4e2LcJdQ==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] bpftool: bpf_link_get_from_fd support for LSM programs in lskel
Date:   Mon,  9 May 2022 21:49:05 +0000
Message-Id: <20220509214905.3754984-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
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

bpf_link_get_from_fd currently returns a NULL fd for LSM programs.
LSM programs are similar to tracing programs and can also use
skel_raw_tracepoint_open.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/bpf/bpftool/gen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 7678af364793..e4a2bd3898a6 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -549,6 +549,7 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			printf("\tint fd = skel_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
 			break;
 		case BPF_PROG_TYPE_TRACING:
+		case BPF_PROG_TYPE_LSM:
 			if (bpf_program__expected_attach_type(prog) == BPF_TRACE_ITER)
 				printf("\tint fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);\n");
 			else
-- 
2.36.0.512.ge40c2bad7a-goog

