Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983775A9943
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiIANnD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiIANmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 09:42:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4286077
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 06:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA24B826E4
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 13:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFE3C433C1;
        Thu,  1 Sep 2022 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662039718;
        bh=WpGvwJpnsLt2icgJsAk+6krfw2chqtjgQsgN5j+1HsI=;
        h=From:To:Cc:Subject:Date:From;
        b=eiw07sji+41sUwEcJEGsiHouq0+G/a1xp+SA6ZtpUQLKfK1AvmNWFiOvgd+c/AVfs
         xEpmtk1No/vXwItPIU29JjTQ67avd+iqrR+UR7RWIs4CojIdUJT66x0eaey+VFD97T
         J/gZHxcWUpnS7Gs1u71YCzu8R2iX/55X6vpkYqMmUKa8h0NAX3t5n3PPnpf+lFUA5S
         f7i31cVUzqvvN0DJ/uE0N+HAcw1GKYictFGR9DYFcEw1r+EO14ZkKSo85JyKazM7Yo
         rJnVsL0+icJFTlFvZpfUy8dGJDdOeuPCesf4Uj3ZJiceayZe/Kw8l3c+64ZUFQ62dA
         dsTunqb3ZDl7g==
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
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
Date:   Thu,  1 Sep 2022 15:41:48 +0200
Message-Id: <20220901134150.418203-1-jolsa@kernel.org>
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

v2 changes:
  - fixing s390x CI build failure by enabling attributes
    only for x86_64 [Ilya Leoshkevic]

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
 include/linux/bpf.h               |  8 ++++++++
 kernel/trace/Kconfig              |  6 ++++++
 tools/objtool/check.c             |  3 ++-
 5 files changed, 27 insertions(+), 2 deletions(-)
