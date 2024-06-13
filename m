Return-Path: <bpf+bounces-32078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01356907279
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 785D5B28DBE
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23E143C62;
	Thu, 13 Jun 2024 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVO5Y11u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3220ED;
	Thu, 13 Jun 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282822; cv=none; b=qnOZBIWrrtYSvpLB00B5np44GR6O9EfyToHtHFnUMpjvy2n7NTS/XKFOvMtvzyAjvVWjix0RAx3QueM/SS/tSRk9v6CbUxt/mVsVezZ5IcXFKjspT2BapKiR0grZExg8y8FcsHIkviqEFaWtuzYIggvu2b5iLtnKZWgcz5eNREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282822; c=relaxed/simple;
	bh=gsUbpcLQpgDAJvsYM4jqhhT0OL75KDnPF5nPWEtzpLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbvRjWrqV0M+kFXcmA18KS4RgGsVMw9SDxi1Vzxpjo48C79ovL0oAM7vDwXPLOwaZ5DtCr8+874DStvRS57I6ETbmqM6BWKdhHYyLEDzW8ol4lNa1WA4Ht6ZbFo7mTaQ2VC6wkgUYlko9ZD2ruKBPySdLYSV9sjBbLEDlCmW/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVO5Y11u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A508EC2BBFC;
	Thu, 13 Jun 2024 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718282822;
	bh=gsUbpcLQpgDAJvsYM4jqhhT0OL75KDnPF5nPWEtzpLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVO5Y11uNzT4AUpyPio2UmlJzsTQsJdX3+Zu65KAy8hHUoBLse1vJVSdmW9Kfk+SQ
	 1Poet9RlIOuwPI1Pz30jTxQJ5G+w1T+fSnrpTPvZ8/Vq79k7djmABKaJGFuSVrOxvd
	 zOxdIeWkzzsaGLG2+xMNLvm/il7jaouz66O7sM/jm69Y4Wyg7ss9r9BTxkq8SwccO+
	 U0C+DK2N6taaCpxv8Iuugg/imW20pDLBWEa+F3rLrtbFFGgZZInQcyTkBVojRTVF/T
	 3OyuF1VTw6s3UWy3uY825MB0dSkz6hBYSmZSm8A/RgUfA84PoQzvEzRPqfpqE8avZq
	 7BEBYTEAnd7yQ==
Date: Thu, 13 Jun 2024 09:46:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: BTF-based enum pretty printing
Message-ID: <ZmrqQs64TvAt8XjK@x1>
References: <20240613042747.3770204-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613042747.3770204-1-howardchu95@gmail.com>

On Thu, Jun 13, 2024 at 12:27:47PM +0800, Howard Chu wrote:
> changes in v4:
> 
> - Add enum support to tracepoint arguments

That is cool, but see below the comment as having this as a separate
patch.

Also please, on the patch that introduces ! syscall tracepoint enum args
BTF augmentation include examples of tracepoints being augmented. I'll
try here while testing the patch as-is.

More comments below.
 
> - For tracing syscalls, move trace__load_vmlinux_btf() to
> syscall__set_arg_fmts() to make it more elegant
> 
> changes in v3:
> 
> - Fixed another awkward formatting issue in trace__load_vmlinux_btf()
> 
> changes in v2:
> 
> - Fix formatting issues

<SNIP>

> before:
> 
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
>      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
> ```
> 
> after:
> 
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
>      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> ```
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 121 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 111 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5cbe1748911d..0a168cb9b0c2 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -19,6 +19,7 @@
>  #ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include <bpf/btf.h>
>  #ifdef HAVE_BPF_SKEL
>  #include "bpf_skel/augmented_raw_syscalls.skel.h"
>  #endif
> @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
>  	const char *name;
>  	u16	   nr_entries; // for arrays
>  	bool	   show_zero;
> +	bool	   is_enum;
> +	struct {
> +		void	*entry;
> +		u16	nr_entries;
> +	}	   btf_entry;
>  };
>  
>  struct syscall_fmt {
> @@ -140,6 +146,7 @@ struct trace {
>  #ifdef HAVE_BPF_SKEL
>  	struct augmented_raw_syscalls_bpf *skel;
>  #endif
> +	struct btf		*btf;
>  	struct record_opts	opts;
>  	struct evlist	*evlist;
>  	struct machine		*host;
> @@ -887,6 +894,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
>  
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
>  
> +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> +{
> +	const struct btf_type *bt;
> +	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> +	int id;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> +		ep = enum_prefix[i];
> +		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> +			type += strlen(ep) + 1;
> +	}
> +
> +	id = btf__find_by_name(btf, type);
> +	if (id < 0)
> +		return -1;
> +
> +	bt = btf__type_by_id(btf, id);
> +	if (bt == NULL)
> +		return -1;
> +
> +	arg_fmt->btf_entry.entry      = btf_enum(bt);
> +	arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
> +
> +	return 0;
> +}
> +
> +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
> +				 struct syscall_arg_fmt *arg_fmt)
> +{
> +	struct btf_enum *be;
> +	int i;
> +
> +	/* if btf_entry is NULL, find and save it to arg_fmt */
> +	if (arg_fmt->btf_entry.entry == NULL)
> +		if (btf_enum_find_entry(btf, type, arg_fmt))
> +			return 0;
> +
> +	be = (struct btf_enum *)arg_fmt->btf_entry.entry;
> +
> +	for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
> +		if (be->val == val) {
> +			return scnprintf(bf, size, "%s",
> +					 btf__name_by_offset(btf, be->name_off));
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  #define STRARRAY(name, array) \
>  	  { .scnprintf	= SCA_STRARRAY, \
>  	    .strtoul	= STUL_STRARRAY, \
> @@ -1238,6 +1295,7 @@ struct syscall {
>  	bool		    is_exit;
>  	bool		    is_open;
>  	bool		    nonexistent;
> +	bool		    use_btf;
>  	struct tep_format_field *args;
>  	const char	    *name;
>  	const struct syscall_fmt  *fmt;
> @@ -1699,6 +1757,15 @@ static void trace__symbols__exit(struct trace *trace)
>  	symbol__exit();
>  }
>  
> +static void trace__load_vmlinux_btf(struct trace *trace)
> +{
> +	trace->btf = btf__load_vmlinux_btf();
> +	if (verbose > 0) {
> +		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> +						    "Failed to load vmlinux BTF\n");
> +	}
> +}
> +
>  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
>  {
>  	int idx;
> @@ -1744,7 +1811,8 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
>  }
>  
>  static struct tep_format_field *
> -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
> +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
> +			    bool *use_btf)
>  {
>  	struct tep_format_field *last_field = NULL;
>  	int len;
> @@ -1756,6 +1824,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			continue;
>  
>  		len = strlen(field->name);
> +		arg->is_enum = false;
>  
>  		if (strcmp(field->type, "const char *") == 0 &&
>  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> @@ -1782,6 +1851,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			 * 7 unsigned long
>  			 */
>  			arg->scnprintf = SCA_FD;
> +		} else if (strstr(field->type, "enum") && use_btf != NULL) {
> +			*use_btf = arg->is_enum = true;
>  		} else {
>  			const struct syscall_arg_fmt *fmt =
>  				syscall_arg_fmt__find_by_name(field->name);
> @@ -1796,9 +1867,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  	return last_field;
>  }
>  
> -static int syscall__set_arg_fmts(struct syscall *sc)
> +static int syscall__set_arg_fmts(struct trace *trace, struct syscall *sc)

See the comment about evsel__init_tp_arg_scnprintf() below. Also please
do patches on top of previous work, i.e. the v3 patch should be a
separate patch and this v4 should add the extra functionality, i.e. the
support for !syscall tracepoint enum BTF augmentation.

>  {
> -	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> +	bool use_btf;
> +	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> +									  &use_btf);
> +
> +	if (use_btf && trace->btf == NULL)
> +		trace__load_vmlinux_btf(trace);
>  
>  	if (last_field)
>  		sc->args_size = last_field->offset + last_field->size;
> @@ -1883,15 +1959,20 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
>  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
>  
> -	return syscall__set_arg_fmts(sc);
> +	return syscall__set_arg_fmts(trace, sc);
>  }
>  
> -static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> +static int evsel__init_tp_arg_scnprintf(struct trace *trace, struct evsel *evsel)

The convention here is that evsel__ is the "class" name, so the first
arg is a 'struct evsel *', if you really were transforming this into a
'struct trace' specific "method" you would change the name of the C
function to 'trace__init_tp_arg_scnprintf'.

But in this case instead of passing the 'struct trace' pointer all the
way down we should instead pass a 'bool *use_btf' argument, making it:


static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)

Then, when evlist__set_syscall_tp_fields(evlist, &use_btf) returns,
check that use_btf to check if we need to call
trace__load_vmlinux_btf(trace).

I'll test the patch as is now.

- Arnaldo

>  {
>  	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
> +	bool use_btf;
>  
>  	if (fmt != NULL) {
> -		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
> +		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, &use_btf);
> +
> +		if (use_btf && trace->btf == NULL)
> +			trace__load_vmlinux_btf(trace);
> +
>  		return 0;
>  	}
>  
> @@ -2103,6 +2184,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			if (trace->show_arg_names)
>  				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> +			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> +				size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
> +							      trace->btf, field->type,
> +							      &sc->arg_fmt[arg.idx]);
> +				if (p) {
> +					printed += p;
> +					continue;
> +				}
> +			}
> +
>  			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
>  								  bf + printed, size - printed, &arg, val);
>  		}
> @@ -2791,7 +2882,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
>  
>  		/* Suppress this argument if its value is zero and show_zero property isn't set. */
> -		if (val == 0 && !trace->show_zeros && !arg->show_zero)
> +		if (val == 0 && !trace->show_zeros && !arg->show_zero && !arg->is_enum)
>  			continue;
>  
>  		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> @@ -2799,6 +2890,15 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		if (trace->show_arg_names)
>  			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> +		if (arg->is_enum && trace->btf) {
> +			size_t p = btf_enum_scnprintf(bf + printed, size - printed, val, trace->btf,
> +						      field->type, arg);
> +			if (p) {
> +				printed += p;
> +				continue;
> +			}
> +		}
> +
>  		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
>  	}
>  
> @@ -4461,8 +4561,9 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
>  	}
>  }
>  
> -static int evlist__set_syscall_tp_fields(struct evlist *evlist)
> +static int evlist__set_syscall_tp_fields(struct trace *trace)
>  {
> +	struct evlist *evlist = trace->evlist;
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> @@ -4470,7 +4571,7 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
>  			continue;
>  
>  		if (strcmp(evsel->tp_format->system, "syscalls")) {
> -			evsel__init_tp_arg_scnprintf(evsel);
> +			evsel__init_tp_arg_scnprintf(trace, evsel);
>  			continue;
>  		}
>  
> @@ -4949,7 +5050,7 @@ int cmd_trace(int argc, const char **argv)
>  
>  	if (trace.evlist->core.nr_entries > 0) {
>  		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
> -		if (evlist__set_syscall_tp_fields(trace.evlist)) {
> +		if (evlist__set_syscall_tp_fields(&trace)) {
>  			perror("failed to set syscalls:* tracepoint fields");
>  			goto out;
>  		}
> -- 
> 2.45.2
> 

