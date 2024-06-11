Return-Path: <bpf+bounces-31875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBFA904432
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76511C23F88
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F17D3FA;
	Tue, 11 Jun 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtGX2L2d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F84D8A1;
	Tue, 11 Jun 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132664; cv=none; b=MgXAMUXoq0TYmcFpAnGrrnDfg/beH7FdDkW94klrbIep0UAcTlyUqxbJXWHbhDV9WSp4siZoh7p4p3IkQPRAiQVIZE9uKZEZn91mPp7otJ/Ej9BiWtf/Vww3B+S8bwOCVpOY0a694bd9P8U3ZgzInPx9MbzEkKAE4+12Skn1s5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132664; c=relaxed/simple;
	bh=wNucI9SiN2b1lnbZOW1JG2d4K+JH4U133O/uPob/RNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP1PSB5XijA0qN+4ifiF102d6qxNW60HoTwiijLubWTCRFnF5dUI11anBhVzuokk1YHbR0ksDNgh7CDaXf7gZj5plKi33nvT5PNrko7jRIfj2wlopWsMZwiUvanKk01r/oQO94fjT2GBF/humNxODEdlv4sclpROCD+MCBPTx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtGX2L2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24528C2BD10;
	Tue, 11 Jun 2024 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718132663;
	bh=wNucI9SiN2b1lnbZOW1JG2d4K+JH4U133O/uPob/RNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtGX2L2dYN4hCehUl0y3SxFxJu5MQ/dPP6ys1EP2hBcD6NZI2FmqtjuJa+lA5LhMC
	 mmpiUt8fUsFg+N0+VczFK8O1e9IcXtjwMFh8JsRjNEr97OVlXSI4Yrnu7RELmM7sIr
	 nCe+kit1/a+qH81cu6ALL+3FhAmPXSfbXQSEQRgCzwLnMkY7WpZRV79KyoQ6zl5P/U
	 pLziINjf7oWiIAWxBIO64BB8wDgwQSo/HcluyFI/qj3h4tPj79am1/7Zz/RWZbOcvs
	 nqVrinmL9kqxkDWEfZhb4NRqRfVXPvtCJNbJn2Ez+M0CNODWOi3ezDje9iwTttyuJ1
	 ja3B6Iyulyxgg==
Date: Tue, 11 Jun 2024 16:04:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, mic@digikod.net, gnoack@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: BTF-based enum pretty printing
Message-ID: <ZmiftHw-66m3WymK@x1>
References: <20240610131032.516323-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610131032.516323-1-howardchu95@gmail.com>

On Mon, Jun 10, 2024 at 09:10:32PM +0800, Howard Chu wrote:
> This is a feature implemented on the basis of the previous bug fix
> https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t
> 
> In this patch, I use BTF to turn enum value to the corresponding name.
> There is only one system call that uses enum value as its argument,
> that is `landlock_add_rule`.
> 
> The vmlinux btf is loaded lazily, when user decided to trace the
> `landlock_add_rule` syscall. But if one decide to run `perf trace`
> without any arguments, the behaviour is to trace `landlock_add_rule`,
> so vmlinux btf will be loaded by default.
> 
> The laziest behaviour is to load vmlinux btf when a
> `landlock_add_rule` syscall hits. But I think you could lose some
> samples when loading vmlinux btf at run time, for it can delay the
> handling of other samples. I might need your precious opinions on
> this...
> 
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

On perf-tools-next, with the patch fixing the traversal of sctbl
entries:

⬢[acme@toolbox c]$ rm -f ./landlock_add_rule 
⬢[acme@toolbox c]$ cat landlock_add_rule.c 
#include <linux/landlock.h>  /* Definition of LANDLOCK_* constants */
#include <sys/syscall.h>     /* Definition of SYS_* constants */
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>
#include <stdio.h>

/* Provide own perf_event_open stub because glibc doesn't */
__attribute__((weak))
int landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type, const void *rule_attr, uint32_t flags)
{
	return syscall(SYS_landlock_add_rule, ruleset_fd, rule_type, rule_attr, flags);
}

int main(int argc, char *argv[])
{
	struct landlock_path_beneath_attr attr = { .allowed_access = 1, };
	int err = landlock_add_rule(1, LANDLOCK_RULE_PATH_BENEATH, &attr, 0);

	printf("landlock_add_rule(1, LANDLOCK_RULE_PATH_BENEATH, { .allowed_access = 1, }, 0) = %d (%s)\n", err, strerror(errno));

	attr = (struct landlock_path_beneath_attr){ .parent_fd = 222, };

	err = landlock_add_rule(2, LANDLOCK_RULE_NET_PORT, &attr, 0);

	printf("landlock_add_rule(2, LANDLOCK_RULE_NET_PORT, { .parent_fd = 222, }, 0) = %d (%s)\n", err, strerror(errno));

	return err;
}
⬢[acme@toolbox c]$ make landlock_add_rule
cc     landlock_add_rule.c   -o landlock_add_rule
⬢[acme@toolbox c]$ ./landlock_add_rule 
landlock_add_rule(1, LANDLOCK_RULE_PATH_BENEATH, { .allowed_access = 1, }, 0) = -1 (File descriptor in bad state)
landlock_add_rule(2, LANDLOCK_RULE_NET_PORT, { .parent_fd = 222, }, 0) = -1 (File descriptor in bad state)
⬢[acme@toolbox c]$


And then in 'perf trace', after your patch:

root@number:~# perf trace --call-graph dwarf -e landlock_add_rule 
     0.000 ( 0.025 ms): landlock_add_r/67823 landlock_add_rule(ruleset_fd: 1, rule_type: LANDLOCK_RULE_PATH_BENEATH, rule_attr: 0x7ffe96ad2fd0) = -1 EBADFD (File descriptor in bad state)
                                       syscall (/usr/lib64/libc.so.6)
                                       landlock_add_rule (/home/acme/c/landlock_add_rule)
                                       main (/home/acme/c/landlock_add_rule)
                                       __libc_start_call_main (/usr/lib64/libc.so.6)
                                       __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
                                       _start (/home/acme/c/landlock_add_rule)
     0.130 ( 0.008 ms): landlock_add_r/67823 landlock_add_rule(ruleset_fd: 2, rule_type: LANDLOCK_RULE_NET_PORT, rule_attr: 0x7ffe96ad2fd0) = -1 EBADFD (File descriptor in bad state)
                                       syscall (/usr/lib64/libc.so.6)
                                       landlock_add_rule (/home/acme/c/landlock_add_rule)
                                       main (/home/acme/c/landlock_add_rule)
                                       __libc_start_call_main (/usr/lib64/libc.so.6)
                                       __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
                                       _start (/home/acme/c/landlock_add_rule)
^Croot@number:~#

Getting the enumeration from BTF using pahole:

root@number:~# pahole landlock_rule_type
enum landlock_rule_type {
	LANDLOCK_RULE_PATH_BENEATH = 1,
	LANDLOCK_RULE_NET_PORT     = 2,
};

root@number:~#

So it all works, please take a look at some comments below.
 
> P.S.
> If you don't apply the patch "perf trace: Fix syscall untraceable
> bug", there will be no output whatsoever when running
> `perf trace -e landlock_add_rule`
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 69 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5cbe1748911d..5acb9a910ea1 100644
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
> @@ -110,6 +111,7 @@ struct syscall_arg_fmt {
>  	const char *name;
>  	u16	   nr_entries; // for arrays
>  	bool	   show_zero;
> +	bool	   is_enum;
>  };
>  
>  struct syscall_fmt {
> @@ -140,6 +142,7 @@ struct trace {
>  #ifdef HAVE_BPF_SKEL
>  	struct augmented_raw_syscalls_bpf *skel;
>  #endif
> +	struct btf		*btf;
>  	struct record_opts	opts;
>  	struct evlist	*evlist;
>  	struct machine		*host;
> @@ -887,6 +890,36 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
>  
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
>  
> +static size_t btf_enum_scnprintf(char *bf, size_t size, int val,
> +			  struct btf *btf, const char *type)
> +{
> +	const struct btf_type *bt;
> +	struct btf_enum *e;
> +	char enum_prefix[][16] = {"enum", "const enum"}, *ep;

                                 Add spaces after { and before }

> +	int id;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> +		ep = enum_prefix[i];
> +		if (strlen(type) > strlen(ep) + 1 && strstr(type, ep) == type)
> +			type += strlen(ep) + 1;
> +	}
> +
> +	id = btf__find_by_name(btf, type);

	int id = ...

> +	if (id < 0)

Shouldn't we have some warning here? ok, I see you do it later, in
trace__read_syscall_info().

Also I looked at the btf_enum_scnprintf() caller and if this isn't found
nothing is printed, it is better to fallback to printing the integer
value, as done in other parts, see:

size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)

That intfmt is configurable to show hex or decimal and is used when the
'val' isn't found in the strarray, so we should use the same approach
with BTF.

> +		return 0;
> +
> +	bt = btf__type_by_id(btf, id);
> +	e = btf_enum(bt);

Declare 'bt' and 'e' here

> +
> +	for (int i = 0; i < btf_vlen(bt); i++, e++) {
> +		if (e->val == val)
> +			return scnprintf(bf, size, "%s",
> +					 btf__name_by_offset(btf, e->name_off));

Multi line if block should be enclosed with {}

> +	}
> +
> +	return 0;
> +}
> +
>  #define STRARRAY(name, array) \
>  	  { .scnprintf	= SCA_STRARRAY, \
>  	    .strtoul	= STUL_STRARRAY, \
> @@ -1238,6 +1271,7 @@ struct syscall {
>  	bool		    is_exit;
>  	bool		    is_open;
>  	bool		    nonexistent;
> +	bool		    use_btf;
>  	struct tep_format_field *args;
>  	const char	    *name;
>  	const struct syscall_fmt  *fmt;
> @@ -1756,6 +1790,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			continue;
>  
>  		len = strlen(field->name);
> +		arg->is_enum = false;
>  
>  		if (strcmp(field->type, "const char *") == 0 &&
>  		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
> @@ -1782,6 +1817,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			 * 7 unsigned long
>  			 */
>  			arg->scnprintf = SCA_FD;
> +		} else if (strstr(field->type, "enum")) {
> +			arg->is_enum = true;
>  		} else {
>  			const struct syscall_arg_fmt *fmt =
>  				syscall_arg_fmt__find_by_name(field->name);
> @@ -1798,7 +1835,13 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  
>  static int syscall__set_arg_fmts(struct syscall *sc)
>  {
> -	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> +	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args),
> +				*field = sc->args;
> +	struct syscall_arg_fmt *arg = sc->arg_fmt;
> +
> +	for (; field; field = field->next, ++arg)
> +		if (arg->is_enum)
> +			sc->use_btf = true;

Instead of retraversing the fields, pass &sc->use_btf to
syscall_arg_fmt__init_array() and then you set it when you set
arg->is_enum.

Note that syscall_arg_fmt__init_array() is also used for other
tracepoints in evsel__init_tp_arg_scnprintf() and we want to use
btf_enum_scnprintf() in enum tracepoint args too.

Now in you can pass NULL from evsel__init_tp_arg_scnprintf() and make
syscall_arg_fmt__init_array() check if it is NULL before setting it to
'true', later we lift this check when/if we add support for !syscall
tracepoint args.

And while we have just this landlock one in syscalls, for tracepoints we
have quite a few:

root@number:~# grep -w field:enum /sys/kernel/tracing/events/*/*/format | wc -l
210
root@number:~# grep -w field:enum /sys/kernel/tracing/events/*/*/format | head
/sys/kernel/tracing/events/cfg80211/cfg80211_cac_event/format:	field:enum nl80211_radar_event evt;	offset:28;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_chandef_dfs_required/format:	field:enum nl80211_band band;	offset:40;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_notify/format:	field:enum nl80211_band band;	offset:28;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_ch_switch_started_notify/format:	field:enum nl80211_band band;	offset:28;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_cqm_rssi_notify/format:	field:enum nl80211_cqm_rssi_threshold_event rssi_event;	offset:28;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format:	field:enum nl80211_band band;	offset:40;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format:	field:enum ieee80211_bss_type bss_type;	offset:60;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_get_bss/format:	field:enum ieee80211_privacy privacy;	offset:64;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_ibss_joined/format:	field:enum nl80211_band band;	offset:36;	size:4;	signed:0;
/sys/kernel/tracing/events/cfg80211/cfg80211_inform_bss_frame/format:	field:enum nl80211_band band;	offset:40;	size:4;	signed:0;
root@number:~# pahole nl80211_band
enum nl80211_band {
	NL80211_BAND_2GHZ  = 0,
	NL80211_BAND_5GHZ  = 1,
	NL80211_BAND_60GHZ = 2,
	NL80211_BAND_6GHZ  = 3,
	NL80211_BAND_S1GHZ = 4,
	NL80211_BAND_LC    = 5,
	NUM_NL80211_BANDS  = 6,
};

root@number:~#

This is shaping up super nicely, great!

I'm pushing the simplified first patch to my tmp.perf-tools-next branch
in my tree at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf-tools-next

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next

Some more comments below.

>  	if (last_field)
>  		sc->args_size = last_field->offset + last_field->size;
> @@ -1811,6 +1854,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	char tp_name[128];
>  	struct syscall *sc;
>  	const char *name = syscalltbl__name(trace->sctbl, id);
> +	int err;
>  
>  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
>  	if (trace->syscalls.table == NULL) {
> @@ -1883,7 +1927,17 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
>  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
>  
> -	return syscall__set_arg_fmts(sc);
> +	err = syscall__set_arg_fmts(sc);

> +	/* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
> +	if (sc->use_btf && trace->btf == NULL) {
> +		trace->btf = btf__load_vmlinux_btf();
> +		if (verbose > 0)
> +			fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> +							    "Failed to load vmlinux BTF\n");
> +	}

One suggestion here is to get the body of the above if and have it in a
trace__load_vmlinux_btf(), as that call and the test under verbose will
be used in other places, for instance, when supporting using BTF to
pretty print non-syscall tracepoints.

This function probably will grow to support detached BTF, possibly that
idea about generating BTF from the scrape scripts, etc.

Thanks,

- Arnaldo

> +	return err;
>  }
>  
>  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> @@ -2050,7 +2104,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  				      unsigned char *args, void *augmented_args, int augmented_args_size,
>  				      struct trace *trace, struct thread *thread)
>  {
> -	size_t printed = 0;
> +	size_t printed = 0, p;
>  	unsigned long val;
>  	u8 bit = 1;
>  	struct syscall_arg arg = {
> @@ -2103,6 +2157,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			if (trace->show_arg_names)
>  				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> +			if (sc->arg_fmt[arg.idx].is_enum == true && trace->btf) {
> +				p = btf_enum_scnprintf(bf + printed, size - printed, val,
> +						       trace->btf, field->type);
> +				if (p) {
> +					printed += p;
> +					continue;
> +				}
> +			}
> +
>  			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
>  								  bf + printed, size - printed, &arg, val);
>  		}
> -- 
> 2.45.2

