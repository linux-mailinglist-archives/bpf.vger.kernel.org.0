Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008D162833E
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiKNOxF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNOxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 09:53:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6392123EB3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 06:53:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9CF6121E
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 14:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3680C433C1;
        Mon, 14 Nov 2022 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668437582;
        bh=InvThceZLRx8jaaQdKyjt1EkX3LUbW1Em85f5vTOk0k=;
        h=From:To:Cc:Subject:Date:From;
        b=g1c/Reu1zxaNbZ+6MujMg0ShwK6j/xwm5akWHfg4JVWlanBnZciBB3/KuPtARSaTV
         /5CYzvZFNispKINydLm7++dBOAjCXks5qOcpRO89F1oe1CZuPs5/N3pXSNCjF6H+46
         dVqaa7cdMUcNZuht91H1CoCpHHnFQTaSL1N/xeywWxJ9lJaHjJ890iptE5B32K06wZ
         45v2gFNubWM5aQe1NxArKJV0cjO2XTIBm72sdjWn2CoK6cQY8LuiatK5WobDZrhf8f
         Ue1aPtcZtEiEI41Vo3S5wqnzEzBW0G+GgHMPln1A7vUYWDKuw0Bw5v6XsY52/DlPDN
         /zJMXV4vM1P5g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] libbpf: Use correct return pointer in attach_raw_tp
Date:   Mon, 14 Nov 2022 15:52:57 +0100
Message-Id: <20221114145257.882322-1-jolsa@kernel.org>
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

We need to pass '*link' to final libbpf_get_error,
because that one holds the return value, not 'link'.

Fixes: 4fa5bcfe07f7 ("libbpf: Allow BPF program auto-attach handlers to bail out")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1d263885d635..4a97e3adbe84 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11223,7 +11223,7 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
 	}
 
 	*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
-	return libbpf_get_error(link);
+	return libbpf_get_error(*link);
 }
 
 /* Common logic for all BPF program types that attach to a btf_id */
-- 
2.38.1

