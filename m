Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBC67A52E
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 22:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjAXVpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 16:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXVpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 16:45:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CC47082;
        Tue, 24 Jan 2023 13:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F8E61353;
        Tue, 24 Jan 2023 21:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454AC433EF;
        Tue, 24 Jan 2023 21:45:00 +0000 (UTC)
Date:   Tue, 24 Jan 2023 16:44:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] trace: acquire buffer from temparary trace
 sequence
Message-ID: <20230124164458.4deab059@gandalf.local.home>
In-Reply-To: <1671181385-5719-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1671181385-5719-1-git-send-email-quic_linyyuan@quicinc.com>
        <1671181385-5719-2-git-send-email-quic_linyyuan@quicinc.com>
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

On Fri, 16 Dec 2022 17:03:05 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> index 66374df..f60c453 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -139,3 +139,11 @@
>  		u64 ____val = (u64)(value);		\
>  		(u32) do_div(____val, NSEC_PER_SEC);	\
>  	})
> +
> +/* Macros with flow control statements should be avoided */
> +#undef __get_buf
> +#define __get_buf(len)							\
> +	({								\
> +		WARN_ON_ONCE(seq_buf_buffer_left(&p->seq) < (len));	\

The WARN_ON_ONCE() should be part of the trace_seq_acquire().

> +		trace_seq_acquire(p, (len));				\
> +	})
> diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
> index 8795429..bcb960d 100644
> --- a/include/trace/stages/stage7_class_define.h
> +++ b/include/trace/stages/stage7_class_define.h
> @@ -23,6 +23,7 @@
>  #undef __get_rel_sockaddr
>  #undef __print_array
>  #undef __print_hex_dump
> +#undef __get_buf
>  
>  /*
>   * The below is not executed in the kernel. It is only what is
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index 9c90b3a..c900b7c 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -403,3 +403,25 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
>  	return 1;
>  }
>  EXPORT_SYMBOL(trace_seq_hex_dump);
> +
> +/**
> + * trace_seq_acquire - acquire seq buffer with size len
> + * @s: trace sequence descriptor
> + * @len: size of buffer to be acquired
> + *
> + * acquire buffer with size of @len from trace_seq for output usage,
> + * user can fill string into that buffer.
> + *
> + * Returns start address of acquired buffer.
> + *
> + * it allow multiple usage in one trace output function call.
> + */
> +char *trace_seq_acquire(struct trace_seq *s, size_t len)
> +{
> +	char *ret = trace_seq_buffer_ptr(s);

	if (!WARN_ON_ONCE(seq_buf_buffer_left(&p->seq) < (len)))
> +
> +		seq_buf_commit(&s->seq, len);

As seq_buf_commit() should never be called without enough length.

-- Steve

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(trace_seq_acquire);
> -- 
