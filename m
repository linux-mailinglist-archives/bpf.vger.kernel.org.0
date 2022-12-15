Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5864E372
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOVom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 16:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLOVok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B15C76F
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:44:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78E8BB81CB1
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 21:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19FDC433D2;
        Thu, 15 Dec 2022 21:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140677;
        bh=i3iXc9o/3AlLp69RTaZJu2vMFQ9xRL+3fvgRIgYWcFc=;
        h=From:To:Cc:Subject:Date:From;
        b=pZpAfgQ/twZQV6+jQpKIXE8HjT/kZt1dgFrFDQt0cCnyxDg+RB0VtA41sBEFWRSr5
         axmKfopmUlFgtVN3aYJEmC8n0bMkMdWf/sBRAGKJNUe6zxcvazQiuDeF0JnatMW+lB
         krkxidQNrFbRSPfbb6QaJhu0w0alo/p41BU4UrT13DtXo0yRlsCwK7iQP79Bri9kY2
         nqqjdLFW1J/LOQo5wXfNCxGX87st4jR5o85CokVqMECmQq9G19/45OgbVYVYoHzGzn
         U59jFIvUAGNr19WfJ/CAEaqo1GBg1oRYUxMflYNetAf6GvHuoODJsplbbK/+XueMxa
         8bXODQMD+izJQ==
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
        Florent Revest <revest@chromium.org>
Subject: [PATCHv3 bpf-next 0/3] bpf: Get rid of trace_printk_lock
Date:   Thu, 15 Dec 2022 22:44:27 +0100
Message-Id: <20221215214430.1336195-1-jolsa@kernel.org>
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
In the last revision Andrii suggested we could have the buffer
provided by bpf_bprintf_prepare [1]. It's bit more changes but
it looks like more compact solution.

v3 changes:
  - added struct to hold return data in bpf_bprintf_prepare
  - fix bug in bpf_bprintf_cleanup
  - adjust printk helpers to use new bpf_bprintf_prepare
    data argument

thanks,
jirka


[1] https://lore.kernel.org/bpf/Y5pgxd9+G2wHROlp@krava/T/#m4b256e9138cdb37cd4477571f32e47a960aad317
---
Jiri Olsa (3):
      bpf: Add struct for bin_args arg in bpf_bprintf_prepare
      bpf: Do cleanup in bpf_bprintf_cleanup only when needed
      bpf: Remove trace_printk_lock

 include/linux/bpf.h      | 12 ++++++++++--
 kernel/bpf/helpers.c     | 67 +++++++++++++++++++++++++++++++++++++++----------------------------
 kernel/bpf/verifier.c    |  3 ++-
 kernel/trace/bpf_trace.c | 56 +++++++++++++++++++++++++++-----------------------------
 4 files changed, 78 insertions(+), 60 deletions(-)
