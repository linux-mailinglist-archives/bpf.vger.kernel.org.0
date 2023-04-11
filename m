Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE086DE16B
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDKQr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDKQrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 12:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E2558A;
        Tue, 11 Apr 2023 09:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA51A62972;
        Tue, 11 Apr 2023 16:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D4DC4339C;
        Tue, 11 Apr 2023 16:47:51 +0000 (UTC)
Date:   Tue, 11 Apr 2023 12:47:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Florent Revest <revest@chromium.org>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Message-ID: <20230411124749.7aeea715@gandalf.local.home>
In-Reply-To: <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
        <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 11 Apr 2023 16:56:45 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> IIUC Steve was hoping to take the FUNCTION_GRAPH_RETVAL series through the
> trace tree, and if that's still the plan, maybe both should go that way?

The conflict is minor, and I think I prefer to still have the ARM64 bits go
through the arm64 tree, as it will get better testing, and I don't like to
merge branches ;-)

I've added Linus to the Cc so he knows that there will be conflicts, but as
long as we mention it in our pull request, with a branch that includes the
solution, it should be fine going through two different trees.

-- Steve
