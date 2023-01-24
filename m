Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E281D67A3C6
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjAXUZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAXUZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 15:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAAC83E9;
        Tue, 24 Jan 2023 12:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A51AB816AD;
        Tue, 24 Jan 2023 20:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49CFC433EF;
        Tue, 24 Jan 2023 20:25:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKPr1-003dz3-2D;
        Tue, 24 Jan 2023 15:25:15 -0500
Message-ID: <20230124202238.563854686@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 24 Jan 2023 15:22:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: [PATCH 0/2] tracing: Have bpf and perf reuse the tracefs TRACE_EVENT macros
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When reviewing Linyu Yuan patches[1] where the change was to move most
the macros from perf and bpf into stages, I realized that the macros
that makes up perf and bpf events are duplicated from the tracefs
macros that were moved into the stages directory. One reason to move
them into that directory was to remove duplicate code.

Remove the macros that are duplicated in the bpf and perf code and use
stage 6, which is the macros used to build the data needed to record
the TRACE_EVENT() TP_fast_assign() into the trace. This will mean they
will pick up bug fixes, as well as any enhacements that are added.

[1] https://lore.kernel.org/lkml/1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com/

Steven Rostedt (Google) (2):
      perf/tracing: Use stage6 of tracing to not duplicate macros
      bpf/tracing: Use stage6 of tracing to not duplicate macros

----
 include/trace/bpf_probe.h                    | 45 +--------------------------
 include/trace/perf.h                         | 46 +---------------------------
 include/trace/stages/stage6_event_callback.h |  3 ++
 3 files changed, 5 insertions(+), 89 deletions(-)
