Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FCF4E4D68
	for <lists+bpf@lfdr.de>; Wed, 23 Mar 2022 08:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiCWHgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Mar 2022 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiCWHgu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Mar 2022 03:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F84D615;
        Wed, 23 Mar 2022 00:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587B4616C2;
        Wed, 23 Mar 2022 07:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C7AC340E8;
        Wed, 23 Mar 2022 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648020920;
        bh=GS31mOGgzdEg+8jaaFasyFhp0pEGXHSbytmQFTeZidE=;
        h=From:To:Cc:Subject:Date:From;
        b=dzwzhAF07Qxg401VV8pCqHNmPfelIJIwLThX+EWsQkoxjXRBAuo4ojQ0e01nSD7jh
         0PtCS6cECvSuZExiC3JAgD2LLOcFI0rYvE3YXDQMbHEtrl2AXiaQCK3cC8mVr6bbXy
         XrpqqNEd128yG9ZgJ+qvlGzd+lYvOhw/oXh7UBswr9tofO149Ekg0k7+HE3cGfMdpf
         /1hjZglTMMpmaOvM7HDjnlx+hJpTmMgDLKKlWlJAVN8j/BOz6Uuvw9B4J9VNDoRUaH
         0PkDqVzXXiuUrWsjE7JHVrifWwNUKvnRnMXbrgPfFb9/cSyCXhWhZd0NkBfQtvrBTA
         JzMDaMuFrv0Kw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] fprobe: Fixes for Sparse and Smatch warnings
Date:   Wed, 23 Mar 2022 16:35:15 +0900
Message-Id: <164802091567.1732982.1242854551611267542.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

These fprobe patches are for fixing the warnings by Smatch and sparse.
This is arch independent part of the fixes.


Thank you,

---

Masami Hiramatsu (2):
      fprobe: Fix smatch type mismatch warning
      fprobe: Fix sparse warning for acccessing __rcu ftrace_hash


 kernel/trace/fprobe.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
