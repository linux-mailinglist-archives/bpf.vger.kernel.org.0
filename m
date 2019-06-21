Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51C94DDFE
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2019 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfFUAHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 20:07:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39833 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfFUAHG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 20:07:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so2418503pgc.6
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2019 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StIE6v7U5HAOa9bemwMa9PRQlT4TJuB7JizOWyHuTRA=;
        b=DGtskwLmmZmUlzbDl5But6cSa9W+OYogMXV2qLhVm+WO56yXQOmn+tJf3rIOPlT5rd
         u7xeho71onooB/Lv+ERkkJgqIlORdm0CCycumCatStj6kkbWhbDaXD9AQ13VRcJxXouk
         CEHNcmFaMHIdSrPDH9Zjuowo/re/1eyrzhZNlt8I/cBDmP/KHTlfCUhuNVQvUB6u/oUS
         I4IbGQTlhmWHSxNVh0fcf8J9VmY9u1wI/ow2IoTO0rxSoKx/cZlUnZ02Sg4chZvqfMVE
         ryozx7vzZXJS1lBQA2TKHpMqIeGyPTrCZM7rQKJOw+fdq4O0UTnHwniwTnVugr72HxmV
         02bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=StIE6v7U5HAOa9bemwMa9PRQlT4TJuB7JizOWyHuTRA=;
        b=eJP3xgqno+QTjZ6b0QORevbCXxbUPwiEvYdlUcVR1ulHenGAZEc6astMx75zMGGlIP
         nAtuA80n2EIjWD/5wOg6fW4ftn4gX+jHL+bYHibWagNC+zdA4UNYDrHXVwHJ2BDJxxmK
         4V/OLkyR96cLq3yHaDlSFLa7uC1hEq8mdAj6EUHkt4RTXasoMfKj6x/zutS0rHjp3HQ9
         VcJGL/slWqz9BQgrHo528qKMw+5YKKBPsEi+MlD4eWbW5DsuCdYz3m9Rpx7afCw7tlC9
         rQnIGfaT16ayEXp5tkJ+HeWqjSwXbfJMf/24Cxt8kBtZ+RSRo7xzWoOxVK8BSB6rT/vo
         WhFQ==
X-Gm-Message-State: APjAAAVBIYxa3xctqkV72FaDOVsKvTszIDUmaYrxyJ0r6FxGwHSvlWDa
        3t1yUZzKlB1lIQTSnEV5FbKRmQ==
X-Google-Smtp-Source: APXvYqx9wFYxo3e7M/mZRGUhONpbh0AVXSTpzuD8gPECgCu/7LdDVobYRZy9W5ssfEzqs/walaO2PA==
X-Received: by 2002:a63:6245:: with SMTP id w66mr8998037pgb.117.1561075625275;
        Thu, 20 Jun 2019 17:07:05 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id f2sm609339pgs.83.2019.06.20.17.07.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 17:07:04 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:07:04 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, ast@fb.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 4/7] libbpf: add tracepoint/raw tracepoint
 attach API
Message-ID: <20190621000704.GC1383@mini-arch>
References: <20190620230951.3155955-1-andriin@fb.com>
 <20190620230951.3155955-5-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620230951.3155955-5-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/20, Andrii Nakryiko wrote:
> Add APIs allowing to attach BPF program to kernel tracepoints. Raw
> tracepoint attach API is also added for uniform per-BPF-program API,
> but is mostly a wrapper around existing bpf_raw_tracepoint_open call.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/libbpf.c   | 99 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  5 ++
>  tools/lib/bpf/libbpf.map |  2 +
>  3 files changed, 106 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 11329e05530e..cefe67ba160b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4176,6 +4176,105 @@ int bpf_program__attach_uprobe(struct bpf_program *prog, bool retprobe,
>  	return pfd;
>  }
>  
> +static int determine_tracepoint_id(const char* tp_category, const char* tp_name)
> +{
> +	char file[PATH_MAX];
> +	int ret;
> +
> +	ret = snprintf(file, sizeof(file),
> +		       "/sys/kernel/debug/tracing/events/%s/%s/id",
> +		       tp_category, tp_name);
> +	if (ret < 0)
> +		return -errno;
> +	if (ret >= sizeof(file)) {
> +		pr_debug("tracepoint %s/%s path is too long\n",
> +			 tp_category, tp_name);
> +		return -E2BIG;
> +	}
> +	return parse_uint_from_file(file);
> +}
> +
> +static int perf_event_open_tracepoint(const char* tp_category,
> +				      const char* tp_name)
> +{
> +	struct perf_event_attr attr = {};
> +	char errmsg[STRERR_BUFSIZE];
> +	int tp_id, pfd, err;
> +
[..]
> +	tp_id = determine_tracepoint_id(tp_category, tp_name);
Why no assign to attr.config directly here?
You can move all other constants to the initialization as well:

struct perf_event_attr attr = {
	.type = PERF_TYPE_TRACEPON,
	.size = sizeof(struct perf_event_attr),
};

attr.config = determine_tracepoint_id(...);

(I guess that's a matter of style, but something to consider).

> +	if (tp_id < 0){
> +		pr_warning("failed to determine tracepoint '%s/%s' perf ID: %s\n",
> +			   tp_category, tp_name,
> +			   libbpf_strerror_r(tp_id, errmsg, sizeof(errmsg)));
> +		return tp_id;
> +	}
> +
[..]
> +	memset(&attr, 0, sizeof(attr));
Not needed since you do attr = {}; above?

> +	attr.type = PERF_TYPE_TRACEPOINT;
> +	attr.size = sizeof(attr);
> +	attr.config = tp_id;
> +
> +	pfd = syscall( __NR_perf_event_open, &attr, -1 /* pid */, 0 /* cpu */,
> +			-1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
> +	if (pfd < 0) {
> +		err = -errno;
> +		pr_warning("tracepoint '%s/%s' perf_event_open() failed: %s\n",
> +			   tp_category, tp_name,
> +			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return err;
> +	}
> +	return pfd;
> +}
> +
> +int bpf_program__attach_tracepoint(struct bpf_program *prog,
> +				   const char *tp_category,
> +				   const char *tp_name)
> +{
> +	char errmsg[STRERR_BUFSIZE];
> +	int pfd, err;
> +
> +	pfd = perf_event_open_tracepoint(tp_category, tp_name);
> +	if (pfd < 0) {
> +		pr_warning("program '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
> +			   bpf_program__title(prog, false),
> +			   tp_category, tp_name,
> +			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> +		return pfd;
> +	}
> +	err = bpf_program__attach_perf_event(prog, pfd);
> +	if (err) {
> +		libbpf_perf_event_disable_and_close(pfd);
> +		pr_warning("program '%s': failed to attach to tracepoint '%s/%s': %s\n",
> +			   bpf_program__title(prog, false),
> +			   tp_category, tp_name,
> +			   libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> +		return err;
> +	}
> +	return pfd;
> +}
> +
> +int bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
> +				       const char *tp_name)
> +{
> +	char errmsg[STRERR_BUFSIZE];
> +	int bpf_fd, pfd;
> +
> +	bpf_fd = bpf_program__fd(prog);
> +	if (bpf_fd < 0) {
> +		pr_warning("program '%s': can't attach before loaded\n",
> +			   bpf_program__title(prog, false));
> +		return -EINVAL;
> +	}
> +	pfd = bpf_raw_tracepoint_open(tp_name, bpf_fd);
> +	if (pfd < 0) {
> +		pr_warning("program '%s': failed to attach to raw tracepoint '%s': %s\n",
> +			   bpf_program__title(prog, false), tp_name,
> +			   libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> +		return pfd;
> +	}
> +	return pfd;
> +}
> +
>  enum bpf_perf_event_ret
>  bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
>  			   void **copy_mem, size_t *copy_size,
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index a7264f06aa5f..bf7020a565c6 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -176,6 +176,11 @@ LIBBPF_API int bpf_program__attach_uprobe(struct bpf_program *prog,
>  					  pid_t pid,
>  					  const char *binary_path,
>  					  size_t func_offset);
> +LIBBPF_API int bpf_program__attach_tracepoint(struct bpf_program *prog,
> +					      const char *tp_category,
> +					      const char *tp_name);
> +LIBBPF_API int bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
> +						  const char *tp_name);
>  
>  struct bpf_insn;
>  
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 1a982c2e1751..2382fbda4cbb 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -174,6 +174,8 @@ LIBBPF_0.0.4 {
>  		bpf_object__load_xattr;
>  		bpf_program__attach_kprobe;
>  		bpf_program__attach_perf_event;
> +		bpf_program__attach_raw_tracepoint;
> +		bpf_program__attach_tracepoint;
>  		bpf_program__attach_uprobe;
>  		libbpf_num_possible_cpus;
>  		libbpf_perf_event_disable_and_close;
> -- 
> 2.17.1
> 
