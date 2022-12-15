Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF764DC2C
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLONYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 08:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLONYB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 08:24:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1115E2AFF;
        Thu, 15 Dec 2022 05:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F1BBB81AAC;
        Thu, 15 Dec 2022 13:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E785C433D2;
        Thu, 15 Dec 2022 13:23:47 +0000 (UTC)
Date:   Thu, 15 Dec 2022 08:23:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] trace: allocate space from temparary trace
 sequence buffer
Message-ID: <20221215082345.56276315@gandalf.local.home>
In-Reply-To: <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1671078807-20748-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671078807-20748-2-git-send-email-quic_linyyuan@quicinc.com>
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

On Thu, 15 Dec 2022 12:33:27 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -95,6 +95,7 @@ extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
>  extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
>  			      int prefix_type, int rowsize, int groupsize,
>  			      const void *buf, size_t len, bool ascii);
> +void *trace_seq_alloc_buffer(struct trace_seq *s, int len);

So, I really don't like the name with "alloc" in it. That makes the
assumption that it also needs to be freed. Which it does not, and why it
confused me last night.

A better name would be trace_seq_acquire(s, len);

And it should return a char *, as it it process stings and not arbitrary
binary data.

> +/**
> + * trace_seq_alloc_buffer - allocate seq buffer with size len
> + * @s: trace sequence descriptor
> + * @len: size of buffer to be allocated
> + *
> + * allocate space with size of @len from seq buffer for output usage,
> + * On success, it returns start address of the allocated buffer,
> + * user can fill data start from the address, user should make sure the
> + * data length not exceed the @len, if it exceed, behavior is undefined.
> + *
> + * Returns NULL if no buffer can be allocated, it also means system will
> + * crash, it is user responsiblity to make sure total buffer used will
> + * not exceed PAGE_SIZE.
> + *
> + * it allow multiple usage in one trace output function call.
> + */
> +void *trace_seq_alloc_buffer(struct trace_seq *s, int len)

char *trace_seq_acquire(struct trace_seq *s, int len)

> +{
> +	char *buf = trace_seq_buffer_ptr(s);
> +

You need to check the length first before committing:

	if (seq_buf_buffer_left(&s->seq) < len)
		return NULL;

	
> +	seq_buf_commit(&s->seq, len);

Because the above is a bug if len is too big.

> +
> +	if (unlikely(seq_buf_has_overflowed(&s->seq))) {

And then we don't need this either.

I must apologize for the response last night. It was past my normal bed
time, and I must really avoid reviewing patches when I should be going to
bed ;-)

-- Steve


> +		s->full = 1;
> +		return NULL;
> +	}
> +
> +	return (void *)buf;
> +}
> +EXPORT_SYMBOL(trace_seq_alloc_buffer);
