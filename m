Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8545E68945B
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBCJtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjBCJti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 04:49:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26DD7712C6;
        Fri,  3 Feb 2023 01:49:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AEC3C14;
        Fri,  3 Feb 2023 01:50:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8BF3F8D6;
        Fri,  3 Feb 2023 01:49:33 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:49:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jolsa@kernel.org, xukuohai@huaweicloud.com
Subject: Re: [PATCH 0/8] Add ftrace direct call for arm64
Message-ID: <Y9zYmLVJmyDwihdq@FVFF77S0Q05N>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230202150647.518dea1a@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202150647.518dea1a@rorschach.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 03:06:47PM -0500, Steven Rostedt wrote:
> On Wed,  1 Feb 2023 17:34:12 +0100
> Florent Revest <revest@chromium.org> wrote:
> 
> > It is meant to apply on top of the arm64 tree which contains Mark Rutland's
> > series on CALL_OPS [1] under the for-next/ftrace tag.
> 
> Just a note for future ftrace patches. Could you add the link to the
> arm64 tree, so I don't need to go look for it ;-)

For the benefit of others looking for it now, the arm64 tree lives at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

Mark.
