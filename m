Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE40A4C305D
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiBXPxQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 10:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiBXPxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 10:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAC16DADB;
        Thu, 24 Feb 2022 07:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C28B826EB;
        Thu, 24 Feb 2022 15:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AD7C340E9;
        Thu, 24 Feb 2022 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645717963;
        bh=5PIGB+4IM8Fn9hA2P/gMQ/CRlNKBfAwnseV7hJCN9w4=;
        h=From:To:Cc:Subject:Date:From;
        b=VFFKlZFLLJ2lSxC1U0v70U0jBFnfX1tnVHRJK9w16q4yqkGGrv7nPL1BRxq5rVc9i
         jYAfc7mnYQFsN5XJYwpiIrds/bckMQ3kj2tkdxLE1gB4shbbPZe0l+l+cGROS2DxHo
         GyYiooq23FhrZVdUjwkGKWHSaEDpvEOXEKEcC3Nfm2+UwzLW6lmeiL/RxqEgX34NwK
         MvtTfPFXmpglBNxD0F7W5201f3hLG8+8pt/duiWGyv9rNs3BzlBgufxWNumJzbigjV
         DdTs8rzmg1msstKb8z+Q+f7jvWcAizvNSh+8mIvDXv0nVTjBufRXo6Sd7kXJX9WjNx
         7jrMDRUk2rB+A==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv3 0/2] perf/bpf: Replace deprecated code
Date:   Thu, 24 Feb 2022 16:52:36 +0100
Message-Id: <20220224155238.714682-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.1
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
the original patchset [1] removed the whole perf functionality
with the hope nobody's using that. But it turned out there's
actually bpf script using prologue functionality, so there
might be users of this.

v3 changes:
  - sending priv related changes, because they can be already
    merged, the rest will need more discussion and work

  - this version gets rid of and adds workaround (and keeps the
    current functionality) for following deprecated libbpf functions:

      bpf_program__set_priv
      bpf_program__priv
      bpf_map__set_priv
      bpf_map__priv

    Basically it implements workarounds suggested by Andrii in [2].

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/depre

thanks,
jirka


[1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
[2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
---
Jiri Olsa (2):
      perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
      perf tools: Remove bpf_map__set_priv/bpf_map__priv usage

 tools/perf/util/bpf-loader.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 141 insertions(+), 23 deletions(-)
