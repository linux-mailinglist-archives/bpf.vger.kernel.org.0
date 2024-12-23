Return-Path: <bpf+bounces-47562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775829FB61E
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8BA164FC0
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763F1D5CDD;
	Mon, 23 Dec 2024 21:35:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F4183CCA;
	Mon, 23 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734989711; cv=none; b=soo79vV6MvweViIzmXi5LB4/WXSGfkSDnQqTAG61IQM/OCWIgRA4gFTDs8Ld+9i7o3sByJRs4n6ZKzCmaFJOG2F2euyRorve+3GijVuRK9gPTlTP99vRjRAH61kJ4wNpT36hsaS1pFFAuTnXGJ/PGO/brxRG6aP/5JX0S/ff0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734989711; c=relaxed/simple;
	bh=l4SQtRYmrcUFccNUkrPL8ciNpBDIhL/cezGKc+yRFhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tm9zdBWABrnlmrkVmzQHtnX1PS4V2J+iXfSW8qMeC/sJE2AcOnJqdzdyAXPdqeq4QUy1YWIT0IqcmBYNQYA2W4hpdqUAeMy3KaecGdA1ZhT1qjP4z66VEI8IXKUq/F6K0Df2mZYLAOz00QS+BHj+MqiiZQjG/k9ISzXl2V9UppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485F9C4CED3;
	Mon, 23 Dec 2024 21:35:09 +0000 (UTC)
Date: Mon, 23 Dec 2024 16:36:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
Message-ID: <20241223163600.7162a557@gandalf.local.home>
In-Reply-To: <20241223201541.898496620@goodmis.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201541.898496620@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 15:13:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +void print_function_args(struct trace_seq *s, unsigned long *args,
> +			 unsigned long func)
> +{
> +	const struct btf_param *param;
> +	const struct btf_type *t;
> +	const char *param_name;
> +	char name[KSYM_NAME_LEN];
> +	unsigned long arg;
> +	struct btf *btf;
> +	s32 tid, nr = 0;
> +	int i;
> +
> +	trace_seq_printf(s, "(");
> +
> +	if (!args)
> +		goto out;
> +	if (lookup_symbol_name(func, name))
> +		goto out;
> +
> +	btf = bpf_get_btf_vmlinux();
> +	if (IS_ERR_OR_NULL(btf))
> +		goto out;
> +
> +	t = btf_find_func_proto(name, &btf);
> +	if (IS_ERR_OR_NULL(t))
> +		goto out;
> +
> +	param = btf_get_func_param(t, &nr);
> +	if (!param)
> +		goto out_put;
> +
> +	for (i = 0; i < nr; i++) {
> +		/* This only prints what the arch allows (6 args by default) */
> +		if (i == FTRACE_REGS_MAX_ARGS) {
> +			trace_seq_puts(s, "...");
> +			break;
> +		}
> +
> +		arg = args[i];
> +
> +		param_name = btf_name_by_offset(btf, param[i].name_off);
> +		if (param_name)
> +			trace_seq_printf(s, "%s=", param_name);
> +		t = btf_type_skip_modifiers(btf, param[i].type, &tid);
> +
> +		switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> +		case BTF_KIND_UNKN:
> +			trace_seq_putc(s, '?');
> +			/* Still print unknown type values */
> +			fallthrough;
> +		case BTF_KIND_PTR:
> +			trace_seq_printf(s, "0x%lx", arg);
> +			break;
> +		case BTF_KIND_INT:
> +			trace_seq_printf(s, "%ld", arg);
> +			break;
> +		case BTF_KIND_ENUM:
> +			trace_seq_printf(s, "%ld", arg);
> +			break;
> +		default:
> +			/* This does not handle complex arguments */
> +			trace_seq_printf(s, "0x%lx (%s)", arg, btf_type_str(t));

This will need to take into account the size of the type. STRUCTs show up,
and most of the time they are simply the size of the architecture's word.
But I hit this:

    timespec64_add_safe(lhs=0x6c2 (STRUCT), rhs=0x39c4153f (STRUCT))

Where it definitely isn't correct, as we have:

struct timespec64 {
	time64_t	tv_sec;			/* seconds */
	long		tv_nsec;		/* nanoseconds */
};

struct timespec64 timespec64_add_safe(const struct timespec64 lhs,
				const struct timespec64 rhs)


> +			break;
> +		}
> +		if (i < nr - 1)
> +			trace_seq_printf(s, ", ");
> +	}
> +out_put:
> +	btf_put(btf);
> +out:
> +	trace_seq_printf(s, ")");
> +}
> +#endif
> +

I updated to this (separating the args array from the BTF parameters):

@@ -684,6 +683,91 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	return !trace_seq_has_overflowed(s);
 }
 
+#ifdef CONFIG_FUNCTION_TRACE_ARGS
+void print_function_args(struct trace_seq *s, unsigned long *args,
+			 unsigned long func)
+{
+	const struct btf_param *param;
+	const struct btf_type *t;
+	const char *param_name;
+	char name[KSYM_NAME_LEN];
+	unsigned long arg;
+	struct btf *btf;
+	s32 tid, nr = 0;
+	int a, p, x;
+
+	trace_seq_printf(s, "(");
+
+	if (!args)
+		goto out;
+	if (lookup_symbol_name(func, name))
+		goto out;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR_OR_NULL(btf))
+		goto out;
+
+	t = btf_find_func_proto(name, &btf);
+	if (IS_ERR_OR_NULL(t))
+		goto out;
+
+	param = btf_get_func_param(t, &nr);
+	if (!param)
+		goto out_put;
+
+	for (a = 0, p = 0; p < nr; a++, p++) {
+		if (p)
+			trace_seq_puts(s, ", ");
+
+		/* This only prints what the arch allows (6 args by default) */
+		if (a == FTRACE_REGS_MAX_ARGS) {
+			trace_seq_puts(s, "...");
+			break;
+		}
+
+		arg = args[a];
+
+		param_name = btf_name_by_offset(btf, param[p].name_off);
+		if (param_name)
+			trace_seq_printf(s, "%s=", param_name);
+		t = btf_type_skip_modifiers(btf, param[p].type, &tid);
+
+		switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
+		case BTF_KIND_UNKN:
+			trace_seq_putc(s, '?');
+			/* Still print unknown type values */
+			fallthrough;
+		case BTF_KIND_PTR:
+			trace_seq_printf(s, "0x%lx", arg);
+			break;
+		case BTF_KIND_INT:
+			trace_seq_printf(s, "%ld", arg);
+			break;
+		case BTF_KIND_ENUM:
+			trace_seq_printf(s, "%ld", arg);
+			break;
+		default:
+			/* This does not handle complex arguments */
+			trace_seq_printf(s, "(%s)[0x%lx", btf_type_str(t), arg);
+			for (x = sizeof(long); x < t->size; x += sizeof(long)) {
+				trace_seq_putc(s, ':');
+				if (++a == FTRACE_REGS_MAX_ARGS) {
+					trace_seq_puts(s, "...]");
+					goto out_put;
+				}
+				trace_seq_printf(s, "0x%lx", args[a]);
+			}
+			trace_seq_putc(s, ']');
+			break;
+		}
+	}
+out_put:
+	btf_put(btf);
+out:
+	trace_seq_printf(s, ")");
+}
+#endif
+
 /**
  * ftrace_find_event - find a registered event
  * @type: the type of event to look for


And now I get this as output:

            less-912     [006] ...1.   240.085082: timespec64_add_safe(lhs=(STRUCT)[0xef:0x10c8f152], rhs=(STRUCT)[0x4:0x0]) <-__se_sys_poll
            less-914     [006] ...1.   241.241416: timespec64_add_safe(lhs=(STRUCT)[0xf0:0x1a1af859], rhs=(STRUCT)[0x4:0x0]) <-__se_sys_poll
            less-916     [006] ...1.   242.653586: timespec64_add_safe(lhs=(STRUCT)[0xf1:0x32ac56c9], rhs=(STRUCT)[0x4:0x0]) <-__se_sys_poll
  wpa_supplicant-488     [004] ...1.   246.771910: timespec64_add_safe(lhs=(STRUCT)[0xf5:0x39ba39d3], rhs=(STRUCT)[0x9:0x3b9ac618]) <-__se_sys_pselect6
  wpa_supplicant-488     [004] ...1.   256.783841: timespec64_add_safe(lhs=(STRUCT)[0xff:0x3a714d62], rhs=(STRUCT)[0xa:0x0]) <-__se_sys_pselect6
  NetworkManager-485     [006] ...1.   257.008653: timespec64_add_safe(lhs=(STRUCT)[0x100:0xc3ce7d5], rhs=(STRUCT)[0x0:0x16358818]) <-__se_sys_ppoll
  NetworkManager-485     [006] ...1.   257.008676: timespec64_add_safe(lhs=(STRUCT)[0x100:0xc3d477e], rhs=(STRUCT)[0x0:0x16352288]) <-__se_sys_ppoll
  NetworkManager-485     [006] ...1.   257.383973: timespec64_add_safe(lhs=(STRUCT)[0x100:0x229be0b6], rhs=(STRUCT)[0x11:0x11c46e70]) <-__se_sys_ppoll


Which looks much more reasonable.

-- Steve

