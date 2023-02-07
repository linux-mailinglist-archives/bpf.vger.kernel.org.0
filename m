Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3368DD1D
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 16:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBGPf1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 10:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBGPf0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 10:35:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECBC17F;
        Tue,  7 Feb 2023 07:35:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A134B819F0;
        Tue,  7 Feb 2023 15:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F11EC433D2;
        Tue,  7 Feb 2023 15:35:21 +0000 (UTC)
Date:   Tue, 7 Feb 2023 10:35:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jolsa@kernel.org, xukuohai@huaweicloud.com
Subject: Re: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with
 _ftrace_direct_multi
Message-ID: <20230207103519.1f0ef013@gandalf.local.home>
In-Reply-To: <CABRcYmL7exDGnBTzj-DHLSf49_tz6bSDfjn9CDLO9ZEbfFyh-w@mail.gmail.com>
References: <20230201163420.1579014-1-revest@chromium.org>
        <20230201163420.1579014-2-revest@chromium.org>
        <Y9vPAdFBJF/gKXaO@FVFF77S0Q05N.cambridge.arm.com>
        <CABRcYmLrYXuP-yio0dy4WskENn81Qw2WS0ArMp=rdHuiGyjYhQ@mail.gmail.com>
        <CABRcYmL7exDGnBTzj-DHLSf49_tz6bSDfjn9CDLO9ZEbfFyh-w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 7 Feb 2023 16:21:49 +0100
Florent Revest <revest@chromium.org> wrote:

> Actually, I'm not sure anymore if we should delete the !multi samples...
> 
> I realized that they are also used as part of the ftrace selftests in:
> - tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> - tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> 
> It does not really make sense to use the ftrace-direct-muti sample as
> a drop-in replacement for the ftrace-direct sample there since they
> don't really do the same thing so we would either need to change the
> test a bit or the multi sample.
> Also, we would still need to adapt the ftrace-direct-too sample since
> it has no multi equivalent and is required there.

Let's not delete the samples, and they do test slightly different use cases
(although the code may be somewhat the same). I rather still keep that test
coverage.

-- Steve
