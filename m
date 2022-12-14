Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4064CC1B
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 15:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiLNOZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 09:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNOZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 09:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299E6BF56;
        Wed, 14 Dec 2022 06:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0F861ABD;
        Wed, 14 Dec 2022 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1170C433D2;
        Wed, 14 Dec 2022 14:25:52 +0000 (UTC)
Date:   Wed, 14 Dec 2022 09:25:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] trace: allocate temparary buffer for trace
 output usage
Message-ID: <20221214092550.1691829e@gandalf.local.home>
In-Reply-To: <1671027102-21403-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1671027102-21403-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671027102-21403-2-git-send-email-quic_linyyuan@quicinc.com>
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

On Wed, 14 Dec 2022 22:11:42 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> there is one dwc3 trace event declare as below,
> DECLARE_EVENT_CLASS(dwc3_log_event,
> 	TP_PROTO(u32 event, struct dwc3 *dwc),
> 	TP_ARGS(event, dwc),
> 	TP_STRUCT__entry(
> 		__field(u32, event)
> 		__field(u32, ep0state)
> 		__dynamic_array(char, str, DWC3_MSG_MAX)
> 	),
> 	TP_fast_assign(
> 		__entry->event = event;
> 		__entry->ep0state = dwc->ep0state;
> 	),
> 	TP_printk("event (%08x): %s", __entry->event,
> 			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
> 				__entry->event, __entry->ep0state))
> );
> the problem is when trace function called, it will allocate up to
> DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
> during fast assignment, it only fill the buffer when output function are
> called, so this means if output function are not called, the buffer will
> never used.
> 
> add __alloc_buf() and __get_buf() which will not allocate event buffer
> when trace function called, but when trace output function called, it will
> kmalloc buffer with size DWC3_MSG_MAX for temprary usage and free it
> before trace output function return.

This looks exactly like what the trace_seq *p is to be used for.

static notrace enum print_line_t					\
trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
			struct trace_event *trace_event)		\
{									\
	struct trace_seq *s = &iter->seq;				\
	struct trace_seq __maybe_unused *p = &iter->tmp_seq;		\
                                        ^^^^^^^^^^^^^^^^^^^^

	struct trace_event_raw_##call *field;				\
	int ret;							\
									\
	field = (typeof(field))iter->ent;				\
									\
	ret = trace_raw_output_prep(iter, trace_event);			\
	if (ret != TRACE_TYPE_HANDLED)					\
		return ret;						\
									\
	trace_event_printf(iter, print);				\
									\
	return trace_handle_return(s);					\
}									\

That is a trace_seq buffer that is for temporary usage during the output.

See:
  include/trace/events/libata.h
  include/trace/events/scsi.h

As well as the macros trace_print_bitmask_seq(), trace_print_flags_seq(),
trace_print_symbols_seq(), etc.

-- Steve

