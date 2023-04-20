Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF56E9BE7
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDTSth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 14:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDTSth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 14:49:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE1268A;
        Thu, 20 Apr 2023 11:49:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so1237020a12.0;
        Thu, 20 Apr 2023 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682016575; x=1684608575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJJOeT8ibD8iyZ5GUD24l83wUeVOqbznkJco2Atseh0=;
        b=n/vcoDimgaMEp2z2kZkP2MIcN844TzzESZTRSnlrKXpYerPJ33WE0ZYXP9GnrIg0Yl
         KDC4stSBEv5aDKgLWp+jlnXYmGRKb1xNNNqqHgRjOWCdw5ROVyBtDKoX6AKRv6dXhu30
         uzaiOROHSIwweFxdZe4RqDMXJQ1yaedK5K497UydEv1IH3aOiqdk+9oc5eRHL9gEWEZX
         JcI692HsrA5Ty8I6gye3Y55lU9UHcyEqKEL+Kgqpv9LBtY86oSy+tRSbbwrSZtmR615U
         z4Sku0pcYP8xDpR1ZKrNCWvvZXeEXLVJt2VzYD5pF6XH2XU72xT9dgMdzeMGUTHCjNM5
         tn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682016575; x=1684608575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJJOeT8ibD8iyZ5GUD24l83wUeVOqbznkJco2Atseh0=;
        b=HhPT/d6ZvB5aVF4tUtZ7dS9yuXeL1i8CBGjPr1fgErrPZBuqhet+qtPAAbPLz85B3p
         cVQpkm9sdRhw3+OHmZDBgIV/O1OejJJTd4qnoAmen5NPPmnlxFBLctmSkPQD5FYA6KaO
         b3I0MlszukuxtpV6ESEhmW+hKGjhDlCxT5V87aNWzPRa/RxZ0lXFsg5t8+zS/0Z6X3HK
         6txL1bpbC5XtV0HSSR9vAWpiqvYm16EkUiBPXHGytP8gb2sOqsJkJDBKDvb6Qv3HPXu8
         56C6iHS8Clx8S04bosv07LyWt82kLS4f0Z3BRzDTHsa5qO7RBonsccX0coD6EpUaxlLd
         KLSg==
X-Gm-Message-State: AAQBX9eCYrjZoVKyiiYqLWeJNOtYkB2nI4mAcBNgwtwl4wPk4kTUNR0s
        4iBWx93+1YhB9AuX2UVy6IU9mpGPH+A=
X-Google-Smtp-Source: AKy350YTeB0qGP2vkm4k9QkfXw2nkCtEgcin24AWXmNiFgubN4bzizaUbG1Q3L0l/2HAU3bD5NyYHw==
X-Received: by 2002:a17:902:d2cb:b0:19d:611:2815 with SMTP id n11-20020a170902d2cb00b0019d06112815mr2802582plc.42.1682016575109;
        Thu, 20 Apr 2023 11:49:35 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::5:cf1d])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902a50d00b001a64ce7b18dsm1456565plq.165.2023.04.20.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:49:34 -0700 (PDT)
Date:   Thu, 20 Apr 2023 11:49:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 2/9] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-ID: <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google) wrote:
> +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +			    struct pt_regs *regs)
> +{
> +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> +	struct fentry_trace_entry_head *entry;
> +	struct hlist_head *head;
> +	int size, __size, dsize;
> +	int rctx;
> +
> +	if (bpf_prog_array_valid(call)) {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +		int ret;
> +
> +		ret = trace_call_bpf(call, regs);

Please do not call bpf from fprobe.
There is no use case for it.

> +
> +		/*
> +		 * We need to check and see if we modified the pc of the
> +		 * pt_regs, and if so return 1 so that we don't do the
> +		 * single stepping.
> +		 */
> +		if (orig_ip != instruction_pointer(regs))
> +			return 1;
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	head = this_cpu_ptr(call->perf_events);
> +	if (hlist_empty(head))
> +		return 0;
> +
> +	dsize = __get_data_size(&tf->tp, regs);
> +	__size = sizeof(*entry) + tf->tp.size + dsize;
> +	size = ALIGN(__size + sizeof(u32), sizeof(u64));
> +	size -= sizeof(u32);
> +
> +	entry = perf_trace_buf_alloc(size, NULL, &rctx);
> +	if (!entry)
> +		return 0;
> +
> +	entry->ip = entry_ip;
> +	memset(&entry[1], 0, dsize);
> +	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> +	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> +			      head, NULL);
> +	return 0;
> +}
> +NOKPROBE_SYMBOL(fentry_perf_func);
> +
> +static void
> +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> +		unsigned long ret_ip, struct pt_regs *regs)
> +{
> +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> +	struct fexit_trace_entry_head *entry;
> +	struct hlist_head *head;
> +	int size, __size, dsize;
> +	int rctx;
> +
> +	if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
> +		return;

Same here.
These two parts look like copy-paste from kprobes.
I suspect this code wasn't tested at all.
