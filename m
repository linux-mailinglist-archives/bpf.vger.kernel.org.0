Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F155912D
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 07:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiFXE4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 00:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFXE4w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 00:56:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85EC7
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 21:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36786B8266D
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 04:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BCC341CB;
        Fri, 24 Jun 2022 04:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656046609;
        bh=k/MGH+qCB7ZIP2qLM1T9ww/cFOO66/mqi6hNZlFhKjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fM1xuRiU4m4TtugBqFPXHV25QKKqNvdWrq9fb7BM0hP/PfuF/LGP7sd62iJixl6Kj
         YfwFazOKpc+BRwk6ZBZ6o521wX5lVUYD0zesRT9igdGpcfXml7wJxgIMpplPihVYa/
         5vOzh77IuC7VHUqeGJGb50H2dk/ZSCXxS18d3DbS9qB2FHFCJFPq5avINMrQoRg4rE
         AS0erLYMFlkDsRbh9xeOG+34Nq6RX+xcXEHsEW0PN5rFLSMCAejiVTqSNn91OnJa36
         zj6LI2rN00RhbKa5aM/ACO5UNb2Pyb6TcI9WCzduC7nb+s0OnuQ+7AD24Z6o38jVzq
         TWXGr2g70trqw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v4 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
Date:   Fri, 24 Jun 2022 04:56:34 +0000
Message-Id: <20220624045636.3668195-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220624045636.3668195-1-kpsingh@kernel.org>
References: <20220624045636.3668195-1-kpsingh@kernel.org>
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
index b31e8d8f2d4d..9f289b346790 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7260,6 +7260,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.37.0.rc0.104.g0611611a94-goog

