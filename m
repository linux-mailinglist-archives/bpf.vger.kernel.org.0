Return-Path: <bpf+bounces-55853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C6A87F7F
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EC818991D6
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 11:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6A29B212;
	Mon, 14 Apr 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAwcgp7+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E542980BA;
	Mon, 14 Apr 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631026; cv=none; b=RJV9zHw2vu20LnKfmrzHGGbUDQ/RvBJTTJfutg2h2kyizYTs/FDe5DFbiIQcsDEQqIiy8v1Wvx8H3nwsGrhBz0Ftw57U4Jssi5NSDovV8kzKb1h39ckegbMPgXggs8s9d9VsTAhnKC4rIUJVtM/BD9p+slP810It5wkxGffv22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631026; c=relaxed/simple;
	bh=b+tGT8ALWImEyrM3hR1O1a30ak6//1ppI7ugRh3arlo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyfs0+fjcurUFDtjVzIIWXQREKNtG3LX64r6a6XghOwVU195+H1xHUKRXknzO4oQDA12PQUFzXhekvciJEBQFx8WmQlF/wFEHC0Yh8q/KYgyeDHEjZ4IzmSG7qX2zor13Gkur4JzHRN8USKISOMuQnNEBmx/ATcC6U50PytSx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAwcgp7+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso45637525e9.0;
        Mon, 14 Apr 2025 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744631022; x=1745235822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/x3U/n4gPTYX9Sq/wzVcsTOyId4mQ8jcherfAtEeKw8=;
        b=ZAwcgp7+fPAiVouNqBiS8YFrO+wFSkupSpE2vXBudk4342aQ7sxuqzzHocgMQB+Hqj
         JeAIQ3R5C52vMl984MuZfOeNcX1/QttaFzYNxSV5GlJw0K9KsUm08tvELXWSdbEQADMk
         cW+3v0q7fvyB7KczrpgkcF3Zj5Wp53dwIdr1D3S1pajSe2Zu+xtz3B/RenSBKrAyimoA
         EN8QpgmO7/rGBPw1x1SkEVE4/o4W8ztNq9N5qg8kt8KY2YIKwQzrbkvxCMG0jiO34ORA
         CWCqbt/+5Yx1UzamHHXNUysQHhT2I0oDULsqb2jIAD9iIptM/XE/doTqNAk3G3YlRoy4
         M2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744631022; x=1745235822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x3U/n4gPTYX9Sq/wzVcsTOyId4mQ8jcherfAtEeKw8=;
        b=KQ9OxS72siIIoOsw7dMDNVhyrR6FSl8QEHz+c2woxX1eSarLhoHCdVv0mDoW3cCFJb
         VmNixP601UuQ/HUnAaGSVUQSuD2WkYo+N+wGaUR6DCs+hyZBjdh3YKqGZC+SJbQXHkQ/
         T2q4efC0bcWbYQIUpMOSgjC/6ALhm64pzm+1j3xGOMW34S/XDjOMNlLiR8Waz83/W4I5
         n8SWIGFXyKEOu3lF3vXG/wC75esvfEBJF8hElJONIVKNAgx+hRQrtU7DLFCgEiWD+LMm
         7hY2YGeXoVnewoCjmSy1GhmJkT0q9H5LtD7H0UqSK2Ssef1ixdYvdrS9kFmOvvimqU+t
         7gpw==
X-Forwarded-Encrypted: i=1; AJvYcCWkvb9KwOeStgRPTbg2KwtzMHSFaAz3r3KgbO6f+9+lmwUa1xsd24K4R0qVPEQF2thUtNM=@vger.kernel.org, AJvYcCXOgyKWevjRKGSEAj+ZM7K/m8rloMrAnbj6O2txeuKTRNhF9LdUYw9KNJlwjKxt9rOr/bZQznHG2A8ZOalF@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCTh16RqGMZCJRWYepJTGJh4gOqDJNB1rhC6TKfQGg3rNnBXD
	+rOQE7tJdootwnP9JzQ1vH0WlyZlzidkF+wSUnBEDJKI7b+8Xnxm
X-Gm-Gg: ASbGncvjinEr+3ok0cLSvT9FLBU8kkFB26C3wcFFumo7ltdLNCPPrud45KfKmI0v5TZ
	vUWZscBu3TDIcJtbQSvULguaxMKtXoA/F2QryWo5XkzaqsHsbkTxzKpTyR359KnDSJsbGGi3Kce
	HxXuwL6e53nGmmWWGPtdtlUf9o1JBrbNVx+54hIcw1MNEW60VWxtbas4i1VJJ+5A4yc4rnpcnKf
	i1Gn/lCuyZk5fEmd37fnphDt78dqzQaxjsjR4pOEYZJMPNqO8QaJnqWhAUncRxl2W2Vnrm9ITLd
	g+wx6HswwAemPhPJyiA36nddR8rLJ2ilkbJxqkiWIA==
X-Google-Smtp-Source: AGHT+IEYt0BorsoQ8oSyxasmzvntXa56cCHnWGwK675iqO52T5O5Kpc3Mya8zaEVcZpX2WQoGP8jTQ==
X-Received: by 2002:a05:600c:4e0a:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-43f3a9beedfmr137678125e9.31.1744631022013;
        Mon, 14 Apr 2025 04:43:42 -0700 (PDT)
Received: from krava ([2a00:102a:4007:73e1:1681:405:90b2:869b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db88sm176345815e9.6.2025.04.14.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:43:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Apr 2025 13:43:38 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	hengqi.chen@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/3] libbpf: Fix event name too long error
Message-ID: <Z_z06uND92kzrXfJ@krava>
References: <20250414093402.384872-1-yangfeng59949@163.com>
 <20250414093402.384872-2-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414093402.384872-2-yangfeng59949@163.com>

On Mon, Apr 14, 2025 at 05:34:00PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> When the binary path is excessively long, the generated probe_name in libbpf
> exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> This causes legacy uprobe event attachment to fail with error code -22.
> 
> Before Fix:
> 	./test_progs -t attach_probe/kprobe-long_name
> 	......
> 	libbpf: failed to add legacy kprobe event for 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0': -EINVAL
> 	libbpf: prog 'handle_kprobe': failed to create kprobe 'bpf_kfunc_looooooooooooooooooooooooooooooong_name+0x0' perf event: -EINVAL
> 	test_attach_kprobe_long_event_name:FAIL:attach_kprobe_long_event_name unexpected error: -22
> 	test_attach_probe:PASS:uprobe_ref_ctr_cleanup 0 nsec
> 	#13/11   attach_probe/kprobe-long_name:FAIL
> 	#13      attach_probe:FAIL
> 
> 	./test_progs -t attach_probe/uprobe-long_name
> 	......
> 	libbpf: failed to add legacy uprobe event for /root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9: -EINVAL
> 	libbpf: prog 'handle_uprobe': failed to create uprobe '/root/linux-bpf/bpf-next/tools/testing/selftests/bpf/test_progs:0x13efd9' perf event: -EINVAL
> 	test_attach_uprobe_long_event_name:FAIL:attach_uprobe_long_event_name unexpected error: -22
> 	#13/10   attach_probe/uprobe-long_name:FAIL
> 	#13      attach_probe:FAIL
> After Fix:
> 	./test_progs -t attach_probe/uprobe-long_name
> 	#13/10   attach_probe/uprobe-long_name:OK
> 	#13      attach_probe:OK
> 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> 	./test_progs -t attach_probe/kprobe-long_name
> 	#13/11   attach_probe/kprobe-long_name:OK
> 	#13      attach_probe:OK
> 	Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
> Fixes: cc10623c6810 ("libbpf: Add legacy uprobe attaching support")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b2591f5cab65..9e047641e001 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -60,6 +60,8 @@
>  #define BPF_FS_MAGIC		0xcafe4a11
>  #endif
>  
> +#define MAX_EVENT_NAME_LEN	64
> +
>  #define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
>  
>  #define BPF_INSN_SZ (sizeof(struct bpf_insn))
> @@ -11142,10 +11144,10 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>  	static int index = 0;
>  	int i;
>  
> -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> -		 __sync_fetch_and_add(&index, 1));
> +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> +		 __sync_fetch_and_add(&index, 1), kfunc_name, offset);

so the fix is to move unique id before kfunc_name to make sure it gets
to the event name right? would be great to have it in changelog

>  
> -	/* sanitize binary_path in the probe name */
> +	/* sanitize kfunc_name in the probe name */
>  	for (i = 0; buf[i]; i++) {
>  		if (!isalnum(buf[i]))
>  			buf[i] = '_';
> @@ -11270,7 +11272,7 @@ int probe_kern_syscall_wrapper(int token_fd)
>  
>  		return pfd >= 0 ? 1 : 0;
>  	} else { /* legacy mode */
> -		char probe_name[128];
> +		char probe_name[MAX_EVENT_NAME_LEN];
>  
>  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name, 0);
>  		if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
> @@ -11328,7 +11330,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>  					    func_name, offset,
>  					    -1 /* pid */, 0 /* ref_ctr_off */);
>  	} else {
> -		char probe_name[256];
> +		char probe_name[MAX_EVENT_NAME_LEN];
>  
>  		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
>  					     func_name, offset);
> @@ -11878,9 +11880,12 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
>  static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
>  					 const char *binary_path, uint64_t offset)
>  {
> +	static int index = 0;
>  	int i;
>  
> -	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
> +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> +		 __sync_fetch_and_add(&index, 1),
> +		 basename((void *)binary_path), (size_t)offset);

gen_kprobe_legacy_event_name and gen_uprobe_legacy_event_name seem to
be identical now, maybe we can have just one ?

thanks,
jirka

>  
>  	/* sanitize binary_path in the probe name */
>  	for (i = 0; buf[i]; i++) {
> @@ -12312,7 +12317,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
>  					    func_offset, pid, ref_ctr_off);
>  	} else {
> -		char probe_name[PATH_MAX + 64];
> +		char probe_name[MAX_EVENT_NAME_LEN];
>  
>  		if (ref_ctr_off)
>  			return libbpf_err_ptr(-EINVAL);
> -- 
> 2.43.0
> 

