Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392A64DADD
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 13:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLOMJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 07:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLOMJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 07:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F02DAB2;
        Thu, 15 Dec 2022 04:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE60861DB1;
        Thu, 15 Dec 2022 12:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF162C433EF;
        Thu, 15 Dec 2022 12:09:21 +0000 (UTC)
Date:   Thu, 15 Dec 2022 07:09:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] trace: allocate space from temparary trace
 sequence buffer
Message-ID: <20221215070919.52c899c3@gandalf.local.home>
In-Reply-To: <fea0e9c9-18b6-0b6f-9e5e-5632d7ab6eea@quicinc.com>
References: <1671078807-20748-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
        <20221214235402.5ea7489e@gandalf.local.home>
        <fea0e9c9-18b6-0b6f-9e5e-5632d7ab6eea@quicinc.com>
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

On Thu, 15 Dec 2022 13:08:21 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> On 12/15/2022 12:54 PM, Steven Rostedt wrote:
> > On Thu, 15 Dec 2022 12:33:27 +0800
> > Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
> >  
> >> there is one dwc3 trace event declare as below,
> >> DECLARE_EVENT_CLASS(dwc3_log_event,
> >> 	TP_PROTO(u32 event, struct dwc3 *dwc),
> >> 	TP_ARGS(event, dwc),
> >> 	TP_STRUCT__entry(
> >> 		__field(u32, event)
> >> 		__field(u32, ep0state)
> >> 		__dynamic_array(char, str, DWC3_MSG_MAX)
> >> 	),
> >> 	TP_fast_assign(
> >> 		__entry->event = event;
> >> 		__entry->ep0state = dwc->ep0state;
> >> 	),
> >> 	TP_printk("event (%08x): %s", __entry->event,
> >> 			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
> >> 				__entry->event, __entry->ep0state))
> >> );
> >> the problem is when trace function called, it will allocate up to
> >> DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
> >> during fast assignment, it only fill the buffer when output function are
> >> called, so this means if output function are not called, the buffer will
> >> never used.
> >>
> >> add __get_buf(len) which allocate space from iter->tmp_seq when trace
> >> output function called, it allow user write any data to allocatd space.
> >>
> >> the mentioned dwc3 trace event will changed as below,
> >> DECLARE_EVENT_CLASS(dwc3_log_event,
> >> 	TP_PROTO(u32 event, struct dwc3 *dwc),
> >> 	TP_ARGS(event, dwc),
> >> 	TP_STRUCT__entry(
> >> 		__field(u32, event)
> >> 		__field(u32, ep0state)
> >> 	),
> >> 	TP_fast_assign(
> >> 		__entry->event = event;
> >> 		__entry->ep0state = dwc->ep0state;
> >> 	),
> >> 	TP_printk("event (%08x): %s", __entry->event,
> >> 		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
> >> 				__entry->event, __entry->ep0state))
> >> );.
> >>
> >> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>  
> >
> > No!  

> ok, so you don't like a common function in trace_seq.c ?

Ah sorry, I got confused by the name "alloc" thinking you allocated a new
trace_seq. I misread your patch (it was late and I was about to go to bed
when I replied).

Let me look at it again when I'm more awake ;-)

-- Steve
