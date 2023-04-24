Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860A6ED5EA
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjDXUJS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjDXUJR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 16:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4153C5B8C;
        Mon, 24 Apr 2023 13:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13FD628BF;
        Mon, 24 Apr 2023 20:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C997BC433EF;
        Mon, 24 Apr 2023 20:09:14 +0000 (UTC)
Date:   Mon, 24 Apr 2023 16:09:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Florent Revest <revest@chromium.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/5] Add ftrace direct call for arm64
Message-ID: <20230424160908.44c80452@rorschach.local.home>
In-Reply-To: <ZDZ+3dNnIdEpmWiP@FVFF77S0Q05N>
References: <20230405180250.2046566-1-revest@chromium.org>
        <ZDWDPUY2tZiMbk8V@FVFF77S0Q05N>
        <20230411124749.7aeea715@gandalf.local.home>
        <20230411170807.GA23143@willie-the-truck>
        <20230411134456.728551f8@gandalf.local.home>
        <20230411175423.GD23143@willie-the-truck>
        <ZDZ+3dNnIdEpmWiP@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 12 Apr 2023 10:50:21 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> Perhaps we could queue 1 and 2 via the arm64 tree, 3 and 4 via the ftrace tree,
> and follow up with patch 5 via the bpf tree after -rc1?

Any patches that you want through the ftrace tree, please send as a
separate queue to the linux-trace-kernel mailing list (and lkml) if you
haven't done that already. I'm still a thousand emails behind, and
walking through them while at the airport lounge.

-- Steve
