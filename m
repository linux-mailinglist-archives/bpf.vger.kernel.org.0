Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD264D57F
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 04:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLODQP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 14 Dec 2022 22:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLODQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 22:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221072C11C;
        Wed, 14 Dec 2022 19:16:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4DA061CC8;
        Thu, 15 Dec 2022 03:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731CFC433EF;
        Thu, 15 Dec 2022 03:16:11 +0000 (UTC)
Date:   Wed, 14 Dec 2022 22:16:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] trace: allocate temparary buffer for trace
 output usage
Message-ID: <20221214221609.1d8f62be@gandalf.local.home>
In-Reply-To: <125146b7-3371-2d66-4d25-b829d9f334ea@quicinc.com>
References: <1671027102-21403-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671027102-21403-2-git-send-email-quic_linyyuan@quicinc.com>
        <20221214092550.1691829e@gandalf.local.home>
        <f929751c-d299-b1d4-7163-74a3ffb18bfe@quicinc.com>
        <125146b7-3371-2d66-4d25-b829d9f334ea@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Dec 2022 09:53:27 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> is it possible add a generic macro like #define __get_buf(offset, len)  
> (p->buffer + (offset))  ?
> 
> it only use buffer filed of struct trace_seq .

If it works for you, I guess. I'd like to see the patch and use case.

-- Steve
