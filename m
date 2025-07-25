Return-Path: <bpf+bounces-64376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F845B11FC6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E221CE4DE1
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D422A1D4;
	Fri, 25 Jul 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbpbv5nD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24025191F98;
	Fri, 25 Jul 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452418; cv=none; b=nCp/hN5ST2F1ThIYJve5igHPo4Q37Ut0+d9U29VEdisdevTpOBq3bYNNwTWy0PnAw/IXPMvEJ/p09XA9fJKDdRcEO+vsltxG0Z47p5ZlMHfgb2y2+t04iXMI3FW01HXxuow9LjhRe3zcWa0uSlyS292jOyjPEDaMcz79td4jNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452418; c=relaxed/simple;
	bh=0sHxsVN7hMLmzA+CO4COWGSOUftchLAHQU5UHoG3HYI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B27/gBwOFnwyRWurK3jcSaEMqdpAGisRqxQsLCf2A2CxAMBoC6kXr/1iVl1HSqYnsnVDgdlv1AwbUKO1mNaG66xZUR5dcH90vF5ENm1mmoLu1e5JEhD/jkLgf3L+NIRwfHPud7MXFVgfVu+QF05hjxw5qVYl0l6e0wNgy6p3NKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbpbv5nD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so3413394a12.1;
        Fri, 25 Jul 2025 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753452414; x=1754057214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iYC2RBfL93R6tkl4NfCFlwnnmZvyntwBirSaOeVipg=;
        b=bbpbv5nDXqX+MCVDKOlsZcjX9hYF6OuAgkOnp8jX7H4zyzfHf5mo4c5hRny7/FDvJX
         eckKTfWN6X+4Wx2NFUaIiXozHXLQol1AD5Gp/svURu7iyG5eZrCvYSs7V+rnNQebrGjD
         ei3HDwwqF442N06e0rH2HtWhcRgsj40D8WZoJv2+rQg0YXYIC6jLnQyKSlRNOVT3hKlJ
         5L7XG4wqgGCNXDvHCdJwdH6c+4zOO7EHbLetqcrCVgW4GEdJ8/JScmLRQw1chX1YPVKf
         I06hWzNk06eR6mhXho26g/ESBBd6XwjwmlS3U/rKycbXNQtB6ZNSfYY/JBLTXCzHbo5B
         /jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452414; x=1754057214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iYC2RBfL93R6tkl4NfCFlwnnmZvyntwBirSaOeVipg=;
        b=un7W/Qeda31va7Sb31ldGrZRlJTf0N+2KHCX0Pq/+JftlCk88uf9uhFe5+nFPG+A63
         o0vxkDU4xZuaRwtiHYITpKZShtGOHXX4IGVoPKarUhzFphC5TTzZTTTafb6ehFt8LIU2
         15bosRwb0ifmnEky6ZVNiLHIgKPeEaL1dr183SMUKuml89v8AoJpKMS8528VNEjHw2Kn
         wyIKrxAmeS7ssmIN/GG+tQ1hO+g5bI/0EZeZfngZxeOranmEc9Min24lu9UPv/DaphKc
         f0Zvra0VgKepUiKmkzfG6nFvQoPOFtmMAUNYUqOQQeekOkkjbx3GQ7lmDGxs3jho8oPG
         RCLw==
X-Forwarded-Encrypted: i=1; AJvYcCUMVYjjEoRuaVRPCxyEaTFtv+tjpSabHMMGEvucXDi1u3mIHkcCuMN0tJE3DDbfOyZIQJLFnaL8mbhGJw==@vger.kernel.org, AJvYcCVfpEwAJOMvTmqR7QpqWk+oUOQ3s+rB4OOFZPpPDA0CeQvuDVUnFRHGV/y/wTFsnJD+F9vLZtMt9E+ZSHhRI4qdUw==@vger.kernel.org, AJvYcCWgOZCpn8brSHjNrgc6MoIWaw1biNfrUE5VMQeyPeaYesFiHy16dhCuzv3SF10dmRMcYic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bNzljoBbKPcYeaHoLNiPStOwh9JbOD34Riigo0kYSmtarFH7
	31uhIPdfSTTgjbdaM1rJuk512OlBK12dOIRPGHeCR8hhh0Jeh23vpvHoQl6lmDPA
X-Gm-Gg: ASbGncvkYGeADYFGKLzMKiYC/+Zwoclaq1QPMZ07HfY0V9StczStkuIQt4kI7r7KkhF
	MvWDX/IhZRyUWeRJPwptgIdHBd9uHtOMuD9kbGsTdme79gL5IP4hftgG9to0OQbwpHIkPM/8wcl
	UHOoidC3NMis3jpu8GzO55JnWAlyAT0r/GeHdzsk5nLnqPVkGHdv/yCeMCV+Y+Q6otNb50/pJAs
	utl/M0NwuSSBvuTZ+zqepxbzCzfibn1blJY5mNtijeDktzeJlQJBL58FoQZX8ZjWHwZpe0sks2j
	c8IMZjqFr0IxVFsJRWIlcMzQVSQUR1YiuRHOufjxHaEek0Iy21hjsLAaz8kwZfkhJ0MkAEM9nxN
	5A1BBGJPgAKUEtkqqSA0=
X-Google-Smtp-Source: AGHT+IE1E/OuEbrE4EU1xp+/4I+7DDGhzzSK9OIzrZsyqP1Q1iuEgEEpnsqBtZkyIJJKJkVRV7oOlg==
X-Received: by 2002:a17:907:971f:b0:ad8:8529:4f8f with SMTP id a640c23a62f3a-af61d37c54amr266352366b.45.1753452398566;
        Fri, 25 Jul 2025 07:06:38 -0700 (PDT)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f861d7bsm269469266b.119.2025.07.25.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 07:06:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 25 Jul 2025 16:06:35 +0200
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	namhyung@kernel.org, bpf@vger.kernel.org, agordeev@linux.ibm.com,
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
	japo@linux.ibm.com, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf] libbpf: eBPF fails on events with auxiliary data
Message-ID: <aIOPa25nzPHEqr0n@krava>
References: <20250725093405.3629253-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725093405.3629253-1-tmricht@linux.ibm.com>

On Fri, Jul 25, 2025 at 11:34:05AM +0200, Thomas Richter wrote:
> On linux-next
> commit b4c658d4d63d61 ("perf target: Remove uid from target")
> introduces a regression on s390. In fact the regression exists
> on all platforms when the event supports auxiliary data gathering.
> 
> Command
>    # ./perf record -u 0 -aB --synth=no -- ./perf test -w thloop
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.011 MB perf.data ]
>    # ./perf report --stats | grep SAMPLE
>    #
> 
> does not generate samples in the perf.data file.
> On x86 command 
>   # sudo perf record -e intel_pt// -u 0 ls
> is broken too.
> 
> Looking at the sequence of calls in 'perf record' reveals this
> behavior:
> 1. The event 'cycles' is created and enabled:
>    record__open()
>    +-> evlist__apply_filters()
>        +-> perf_bpf_filter__prepare()
> 	   +-> bpf_program.attach_perf_event()
> 	       +-> bpf_program.attach_perf_event_opts()
> 	           +-> __GI___ioctl(..., PERF_EVENT_IOC_ENABLE, ...)
>    The event 'cycles' is enabled and active now. However the event's
>    ring-buffer to store the samples generated by hardware is not
>    allocated yet. This happens now after enabling the event:
> 
> 2. The event's fd is mmap() to create the ring buffer:
>    record__open()
>    +-> record__mmap()
>        +-> record__mmap_evlist()
> 	   +-> evlist__mmap_ex()
> 	       +-> perf_evlist__mmap_ops()
> 	           +-> mmap_per_cpu()
> 	               +-> mmap_per_evsel()
> 	                   +-> mmap__mmap()
> 	                       +-> perf_mmap__mmap()
> 	                           +-> mmap()
> 
>    This allocates the ring-buffer for the event 'cycles'.  With mmap()
>    the kernel creates the ring buffer:
> 
>    perf_mmap(): kernel function to create the event's ring
>    |            buffer to save the sampled data.
>    |
>    +-> ring_buffer_attach(): Allocates memory for ring buffer.
>        |        The PMU has auxiliary data setup function. The
>        |        has_aux(event) condition is true and the PMU's
>        |        stop() is called to stop sampling. It is not
>        |        restarted:
>        |        if (has_aux(event))
>        |                perf_event_stop(event, 0);
>        |
>        +-> cpumsf_pmu_stop():
> 
>    Hardware sampling is stopped. No samples are generated and saved
>    anymore.
> 
> 3. After the event 'cycles' has been mapped, the event is enabled a
>    second time in:
>    __cmd_record()
>    +-> evlist__enable()
>        +-> __evlist__enable()
> 	   +-> evsel__enable_cpu()
> 	       +-> perf_evsel__enable_cpu()
> 	           +-> perf_evsel__run_ioctl()
> 	               +-> perf_evsel__ioctl()
> 	                   +-> __GI___ioctl(., PERF_EVENT_IOC_ENABLE, .)
>    The second
>       ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
>    is just a NOP in this case. The first invocation in (1.) sets the
>    event::state to PERF_EVENT_STATE_ACTIVE. The kernel functions
>    perf_ioctl()
>    +-> _perf_ioctl()
>        +-> _perf_event_enable()
>            +-> __perf_event_enable() returns immediately because
> 	              event::state is already set to
> 		      PERF_EVENT_STATE_ACTIVE.
> 
> This happens on s390, because the event 'cycles' offers the possibility
> to save auxilary data. The PMU call backs setup_aux() and
> free_aux() are defined. Without both call back functions,
> cpumsf_pmu_stop() is not invoked and sampling continues.
> 
> To remedy this, remove the first invocation of
>    ioctl(..., PERF_EVENT_IOC_ENABLE, ...).
> in step (1.) Create the event in step (1.) and enable it in step (3.)
> after the ring buffer has been mapped.
> 
> Output after:
>  # ./perf record -aB --synth=no -u 0 -- ./perf test -w thloop 2
>  [ perf record: Woken up 3 times to write data ]
>  [ perf record: Captured and wrote 0.876 MB perf.data ]
>  # ./perf  report --stats | grep SAMPLE
>               SAMPLE events:      16200  (99.5%)
>               SAMPLE events:      16200
>  #
> 
> The software event succeeded before and after the patch:
>  # ./perf record -e cpu-clock -aB --synth=no -u 0 -- ./perf test -w thloop 2
>  [ perf record: Woken up 7 times to write data ]
>  [ perf record: Captured and wrote 2.870 MB perf.data ]
>  # ./perf  report --stats | grep SAMPLE
>               SAMPLE events:      53506  (99.8%)
>               SAMPLE events:      53506
>  #
> 
> Fixes: 63f2f5ee856ba ("libbpf: add ability to attach/detach BPF program to perf event")
> To: Andrii Nakryiko <andriin@fb.com>
> To: Ian Rogers <irogers@google.com>
> To: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 162ebd16a59f..5973412a1031 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10960,12 +10960,6 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>  		}
>  		link->link.fd = pfd;
>  	}
> -	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
> -		err = -errno;
> -		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
> -			prog->name, pfd, errstr(err));
> -		goto err_out;
> -	}

I think this might break existing users depending on this

could we instead add some 'enable' flag to bpf_perf_event_opts and perf
would use bpf_program__attach_perf_event_opts function instead?

jirka

