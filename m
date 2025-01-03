Return-Path: <bpf+bounces-47839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C622A0083B
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F477A03D8
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667521F9A96;
	Fri,  3 Jan 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGJDFs5C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0C1C4635;
	Fri,  3 Jan 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902615; cv=none; b=eAqWbBNgPwwkV0wsktLjp+FhZeEG3cr3IZSmfS0siP82eqA49UqA3Lzpt3qMENcj6+gcmP12/Uf1ExFJuEotfM23ppBRygeELwatf49EjkudKA1Wk9woiDozvcOGXAhq2tPLtkcjQx0sVGUqZOEmhDklyDZVBow4P3Pa5xU7VrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902615; c=relaxed/simple;
	bh=Ze4eJzwcK/KUkWPpneAol28wxSGpMqiePIpcjeFyYZ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbWzte3ZqFKfJdey1llP5DtLayhLzNRpu+zbUL+iSIQqigwVIeV6O44dUaZm4C9IXKPSW2Lb1GoR+bXPitwMmehdmaTEtj173Hr3mEk+an5pG0kD6wRGOK9THYP6hSDdqHLZCxiyVJBEZiuyhp6RgYSg8DUpZ5DpXBnPjvza/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGJDFs5C; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab925654d9so2112533766b.2;
        Fri, 03 Jan 2025 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735902611; x=1736507411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raSUDG1efQpnAZdheaNpN+DyWekBT2EYpVKSDG3K0tI=;
        b=AGJDFs5Ct0Z5KQ4KwOHdbpl5DNnaI4ue2FmjfvovnCrPLIys671zkvdOst4qJ87a95
         NFl720r2K6wujOxPIY2EotJBlupkEkLjDMxQ+A7Ur16nyejjaYJPAZRlolhq84AMpbcF
         mnXnn7w4VtFgwqsKtKYHPaGSbjkB65jlEvx+FXCYsckrX3eIqwQMS0wiVeD7txG3u786
         9gPwyPCTxvGtzsvhWlUHKUuXCuzqweUFKo+9JwCiccckj7M+MwyHljo3+kg2pHvYzAsD
         CCQb/4NX9fWAF4L6kjh46BWW3K89rMkP9hqwn0q1/uoYoBl49+Vqinql5pNPInXAETXi
         Orbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735902611; x=1736507411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raSUDG1efQpnAZdheaNpN+DyWekBT2EYpVKSDG3K0tI=;
        b=ItyWCMCO6zIJCShrzdXhvnA9mVqnHvbhrvBOPdMWHbiS3IdyZEvjBpcqCppW/GkveW
         sMCzo1ksEdZH6eGHHlSh5u6PJ7q7gBW/osSi+6WmMh97sRQlE+1JekOMYL143Z+jZgFi
         l+OqaDZHgGNpR75cOE+GHAUCKhVXOAKRj3G/WSF5SuMZi+mGanIlXipZIR+3AkuPvcC6
         0N4NJ0n9q2iZhf61rvIerHmvwhvpV35t6Qx/3Fup86qsSUYqOGwqLhRmWuWFxV470jKo
         QAc8R6qOXycTcg+yBmv3FyC90O4GdMA2UzFgSpucV+tmtHt69I8pNWPcAPdbTxwrKEP2
         Urdw==
X-Forwarded-Encrypted: i=1; AJvYcCUCzbjxL9lQ4WsiZjHwTTFEHSvP7ay6qGMjpV/Tv1d7ro2ZHWr7p+iT24tegttqtEclqfFRGNEJD2WclP8+KFyYBY9Z@vger.kernel.org, AJvYcCUHFFTjEQBLq+clyN6dGdYoxkSmCy5EaWOWiolNBCTRtWY6ohZGOTuomtN9jocs5ogsqYQ=@vger.kernel.org, AJvYcCUL4fpK7bEmuweGm9tYVcVOOMnxUAzYfGcIs6GCYXUUTLgba1vw3oEjRMNMu0P8KUSEM25MsD4vqYKT5AMD@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRYgrHTpLvGXzUybGCa1t63gIoDp98GklePOlFC6zr+l5V4jc
	i+EcPJDkUah4z6xOu6IWCWt9oh3N59n3NNLujGRATl+heW0Z3uTL
X-Gm-Gg: ASbGncuhyzP6/eRBx9syH/dqC7BvFpdHAeGwvIEXIgeONEOsR0SCH1ZNvjtFDLZrqyT
	qBROYIF9IrzPkdx7iZ1DFxNR3lKzaQefnTULNKaxbzwWYRd1frTVM3PNyYrjREo5+VVOM5IZDyS
	wiZcWEhLcOgwiStZ6PJUoG3DKc3jY4lrBSgAha52dhSJEp1wbJxjE7wOCRpPXX2S9I147l+NhGF
	A0hLyBglAhu/W/xUKc81ZN8YlZtrbdxjgdbqi0Y1Yk=
X-Google-Smtp-Source: AGHT+IEmg7dSIikzq5GmH3EZ/FM5STANq0USgua9EpkWnTC6EVtr9nUKPs56790MgNPxL/rquu/C8Q==
X-Received: by 2002:a17:907:7250:b0:aa6:7737:199c with SMTP id a640c23a62f3a-aac2b0a5b5cmr5354284066b.15.1735902610336;
        Fri, 03 Jan 2025 03:10:10 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f2e8sm1906489966b.29.2025.01.03.03.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:10:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jan 2025 12:10:08 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Message-ID: <Z3fFkHCPl_68hN4H@krava>
References: <20250102185845.928488650@goodmis.org>
 <20250102190105.506164167@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102190105.506164167@goodmis.org>

On Thu, Jan 02, 2025 at 01:58:59PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When a function is annotated as "weak" and is overridden, the code is not
> removed. If it is traced, the fentry/mcount location in the weak function
> will be referenced by the "__mcount_loc" section. This will then be added
> to the available_filter_functions list. Since only the address of the
> functions are listed, to find the name to show, a search of kallsyms is
> used.
> 
> Since kallsyms will return the function by simply finding the function
> that the address is after but before the next function, an address of a
> weak function will show up as the function before it. This is because
> kallsyms does not save names of weak functions. This has caused issues in
> the past, as now the traced weak function will be listed in
> available_filter_functions with the name of the function before it.
> 
> At best, this will cause the previous function's name to be listed twice.
> At worse, if the previous function was marked notrace, it will now show up
> as a function that can be traced. Note that it only shows up that it can
> be traced but will not be if enabled, which causes confusion.
> 
>  https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/
> 
> The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> adding weak function") was a workaround to this by checking the function
> address before printing its name. If the address was too far from the
> function given by the name then instead of printing the name it would
> print: __ftrace_invalid_address___<invalid-offset>
> 
> The real issue is that these invalid addresses are listed in the ftrace
> table look up which available_filter_functions is derived from. A place
> holder must be listed in that file because set_ftrace_filter may take a
> series of indexes into that file instead of names to be able to do O(1)
> lookups to enable filtering (many tools use this method).
> 
> Even if kallsyms saved the size of the function, it does not remove the
> need of having these place holders. The real solution is to not add a weak
> function into the ftrace table in the first place.
> 
> To solve this, the sorttable.c code that sorts the mcount regions during
> the build is modified to take a "nm -S vmlinux" input, sort it, and any
> function listed in the mcount_loc section that is not within a boundary of
> the function list given by nm is considered a weak function and is zeroed
> out. Note, this does not mean they will remain zero when booting as KASLR
> will still shift those addresses.

hi,
fyi this seems to remove several functions from available_filter_functions,
that bpf relay on.. like update_socket_protocol or bpf_rstat_flush:

	__bpf_hook_start();

	__weak noinline int update_socket_protocol(int family, int type, int protocol)
	{
		return protocol;
	}

	__bpf_hook_end();


	[root@qemu-1 tracing]# cat available_filter_functions | grep update_socket_protocol
	[root@qemu-1 tracing]# cat /proc/kallsyms | grep update_socket_protocol
	ffffffff821d58b0 W __pfx_update_socket_protocol
	ffffffff821d58c0 W update_socket_protocol

not sure why that fits the condition above for removal

jirka


> 
> On boot up, when the ftrace table is created from the mcount_loc section,
> it will skip any address that matches kaslr_offset(). This stops the weak
> functions from ever being added to the ftrace table and also keeps from
> needing place holders in available_filter_functions.
> 
> Before:
> 
>  ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
>  556
> 
> After:
> 
>  ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
>  0
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c   |  14 +++++
>  scripts/link-vmlinux.sh |   4 +-
>  scripts/sorttable.c     | 131 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 146 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9b17efb1a87d..5963ae76b31a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7077,6 +7077,20 @@ static int ftrace_process_locs(struct module *mod,
>  			continue;
>  		}
>  
> +		/*
> +		 * At build time, a check is made against: nm -S vmlinux
> +		 * to make sure all functions are found within the
> +		 * size range of symbols listed by nm. If not, it's likely
> +		 * a weak function that was overridden. We do not want those.
> +		 * The script will zero them out, but kaslr will still
> +		 * update them. If the address is the same as the kaslr_offset()
> +		 * then skip the record.
> +		 */
> +		if (addr == kaslr_offset()) {
> +			skipped++;
> +			continue;
> +		}
> +
>  		end_offset = (pg->index+1) * sizeof(pg->records[0]);
>  		if (end_offset > PAGE_SIZE << pg->order) {
>  			/* We should have allocated enough */
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index d853ddb3b28c..976808c46665 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -177,12 +177,14 @@ mksysmap()
>  
>  sorttable()
>  {
> -	${objtree}/scripts/sorttable ${1}
> +	${NM} -S ${1} > .tmp_vmlinux.nm-sort
> +	${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}
>  }
>  
>  cleanup()
>  {
>  	rm -f .btf.*
> +	rm -f .tmp_vmlinux.nm-sort
>  	rm -f System.map
>  	rm -f vmlinux
>  	rm -f vmlinux.map
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index da9e1a82e886..d1d52bd12adb 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -446,6 +446,98 @@ static void *sort_orctable(void *arg)
>  #endif
>  
>  #ifdef MCOUNT_SORT_ENABLED
> +struct func_info {
> +	uint64_t	addr;
> +	uint64_t	size;
> +};
> +
> +/* List of functions created by: nm -S vmlinux */
> +static struct func_info *function_list;
> +static int function_list_size;
> +
> +/* Allocate functions in 1k blocks */
> +#define FUNC_BLK_SIZE	1024
> +#define FUNC_BLK_MASK	(FUNC_BLK_SIZE - 1)
> +
> +static int add_field(uint64_t addr, uint64_t size)
> +{
> +	struct func_info *fi;
> +	int fsize = function_list_size;
> +
> +	if (!(fsize & FUNC_BLK_MASK)) {
> +		fsize += FUNC_BLK_SIZE;
> +		fi = realloc(function_list, fsize * sizeof(struct func_info));
> +		if (!fi)
> +			return -1;
> +		function_list = fi;
> +	}
> +	fi = &function_list[function_list_size++];
> +	fi->addr = addr;
> +	fi->size = size;
> +	return 0;
> +}
> +
> +/* Only return match if the address lies inside the function size */
> +static int cmp_func_addr(const void *K, const void *A)
> +{
> +	uint64_t key = *(const uint64_t *)K;
> +	const struct func_info *a = A;
> +
> +	if (key < a->addr)
> +		return -1;
> +	return key >= a->addr + a->size;
> +}
> +
> +/* Find the function in function list that is bounded by the function size */
> +static int find_func(uint64_t key)
> +{
> +	return bsearch(&key, function_list, function_list_size,
> +		       sizeof(struct func_info), cmp_func_addr) != NULL;
> +}
> +
> +static int cmp_funcs(const void *A, const void *B)
> +{
> +	const struct func_info *a = A;
> +	const struct func_info *b = B;
> +
> +	if (a->addr < b->addr)
> +		return -1;
> +	return a->addr > b->addr;
> +}
> +
> +static int parse_symbols(const char *fname)
> +{
> +	FILE *fp;
> +	char addr_str[20]; /* Only need 17, but round up to next int size */
> +	char size_str[20];
> +	char type;
> +
> +	fp = fopen(fname, "r");
> +	if (!fp) {
> +		perror(fname);
> +		return -1;
> +	}
> +
> +	while (fscanf(fp, "%16s %16s %c %*s\n", addr_str, size_str, &type) == 3) {
> +		uint64_t addr;
> +		uint64_t size;
> +
> +		/* Only care about functions */
> +		if (type != 't' && type != 'T')
> +			continue;
> +
> +		addr = strtoull(addr_str, NULL, 16);
> +		size = strtoull(size_str, NULL, 16);
> +		if (add_field(addr, size) < 0)
> +			return -1;
> +	}
> +	fclose(fp);
> +
> +	qsort(function_list, function_list_size, sizeof(struct func_info), cmp_funcs);
> +
> +	return 0;
> +}
> +
>  static pthread_t mcount_sort_thread;
>  
>  struct elf_mcount_loc {
> @@ -464,6 +556,23 @@ static void *sort_mcount_loc(void *arg)
>  	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
>  	unsigned char *start_loc = (void *)emloc->ehdr + offset;
>  
> +	/* zero out any locations not found by function list */
> +	if (function_list_size) {
> +		void *end_loc = start_loc + count;
> +
> +		for (void *ptr = start_loc; ptr < end_loc; ptr += long_size) {
> +			uint64_t key;
> +
> +			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
> +			if (!find_func(key)) {
> +				if (long_size == 4)
> +					*(uint32_t *)ptr = 0;
> +				else
> +					*(uint64_t *)ptr = 0;
> +			}
> +		}
> +	}
> +
>  	qsort(start_loc, count/long_size, long_size, compare_extable);
>  	return NULL;
>  }
> @@ -504,7 +613,10 @@ static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
>  	pclose(file_start);
>  	pclose(file_stop);
>  }
> +#else /* MCOUNT_SORT_ENABLED */
> +static inline int parse_symbols(const char *fname) { return 0; }
>  #endif
> +
>  static int do_sort(Elf_Ehdr *ehdr,
>  		   char const *const fname,
>  		   table_sort_t custom_sort)
> @@ -936,14 +1048,29 @@ int main(int argc, char *argv[])
>  	int i, n_error = 0;  /* gcc-4.3.0 false positive complaint */
>  	size_t size = 0;
>  	void *addr = NULL;
> +	int c;
> +
> +	while ((c = getopt(argc, argv, "s:")) >= 0) {
> +		switch (c) {
> +		case 's':
> +			if (parse_symbols(optarg) < 0) {
> +				fprintf(stderr, "Could not parse %s\n", optarg);
> +				return -1;
> +			}
> +			break;
> +		default:
> +			fprintf(stderr, "usage: sorttable [-s nm-file] vmlinux...\n");
> +			return 0;
> +		}
> +	}
>  
> -	if (argc < 2) {
> +	if ((argc - optind) < 1) {
>  		fprintf(stderr, "usage: sorttable vmlinux...\n");
>  		return 0;
>  	}
>  
>  	/* Process each file in turn, allowing deep failure. */
> -	for (i = 1; i < argc; i++) {
> +	for (i = optind; i < argc; i++) {
>  		addr = mmap_file(argv[i], &size);
>  		if (!addr) {
>  			++n_error;
> -- 
> 2.45.2
> 
> 
> 

