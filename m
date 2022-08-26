Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227CD5A2F58
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbiHZSuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345350AbiHZStX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094292B182
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 11:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB0561E6C
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 18:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD78C433D6;
        Fri, 26 Aug 2022 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661539574;
        bh=H2AZaf3KORxht12iu4ifDB/RaNp45oW7C5Mv1SEa9T8=;
        h=From:To:Cc:Subject:Date:From;
        b=W0pFU/ZPW4tUuFc2tY6kX6WPgwG0Nht9VbViN9FOuiQ7dQ6rPDytMnS6qqQpKkbZO
         jrRi2z7vPwP9KflQ40DrUJ3Wc9WfgfOgxSqRMc2Yc44Hd2c/aEbueacRUnuTFGbOUS
         OabazQkEY00jGQ/l1rX2XlWSmhFtQkq6RIUz5RrvPoSVqIwuobatOt/EBZ0Z//8Hkw
         bMpAUjGJHoQTBMhIukXWAMxwI6voGzbMttSojLao5DB62FcXUbukoKe5SjN4nxGV5k
         1faKoDt0JlgEdH56FWLU7Vd6IYykky4ZLO+KobBYOP/m3H+oPIKtIHmM89UQlG0Rgm
         n3nQNMxAb9THQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
Date:   Fri, 26 Aug 2022 20:46:06 +0200
Message-Id: <20220826184608.141475-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
as discussed [1] sending fix that moves bpf dispatcher function of out
ftrace locations together with Peter's HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
dependency change.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
---
Jiri Olsa (1):
      bpf: Move bpf_dispatcher function out of ftrace locations

Peter Zijlstra (Intel) (1):
      ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE

 arch/x86/Kconfig                  |  1 +
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 include/linux/bpf.h               |  2 ++
 kernel/trace/Kconfig              |  6 ++++++
 tools/objtool/check.c             |  3 ++-
 5 files changed, 21 insertions(+), 2 deletions(-)
