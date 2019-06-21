Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9814DE01
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2019 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUAIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 20:08:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39929 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfFUAIV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 20:08:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so2419838pgc.6
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2019 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtcKIxOBJDXb1YMFFIKUvp1vj9xeUODj/cxc0fShO6E=;
        b=JR+vY5ckPMpLQTFRWE+dKEzucxSXr3U8cKh2SX70QW3oRIM5NQiQofHAHaqUcUin/w
         JWhBfabLkE8q1TKlsVYB7wWIsp+xECyB/2hX0EEyvOZZNs9PDszBZSDS+ReRDNALQBmX
         q+KICZEeoSs1v/HyBbxrlsS2b/tCrRCrmXcxFalgJs3mYr59KHQ+jEoQaaN6KgvVO2nJ
         3PwCrM2LCwjPw2DLEO8rW+XihvpTWn9t2mdW1x4dpMJlDQF4Eo9vTKFYVLp/AaJw7WP5
         M2RJ+xEui2m2Dc+LFRosM0LAyBGzfatBskHXexbDLX/k+LXmyRcAHgCyn4UkSXoGhs9i
         VY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtcKIxOBJDXb1YMFFIKUvp1vj9xeUODj/cxc0fShO6E=;
        b=t2+LhENW/1F+P9sMzkg+Vb3T6BsXxOviUNBz9GSlTennmSUW/uktMmx/G2vYmx8Hb3
         zoZP1qvwfhFqcCb3kxx0otyC+uhFloG9x0nJh4eWzNc2YWKqhyI/SBCmTPl/9tbYQTK2
         X7wn/Hm3IM0bT9dn//LGWy70w66fJjrlObCvl8sd9T5CavA8TGBt5csJMcgCWf7N/gwO
         LT6w88YGery+hO+IsCN6F5VeHsHbwaYPZLogZC1HnMlB2LU4ygBl/jrDfMnPxjR4AW08
         FT1YgaHbuVNq5jMOsWk9mFqRFD/WnEEZDvPQgTSN/muQhcABIAcmV5p6fi93jr/hurcH
         wGYw==
X-Gm-Message-State: APjAAAWVTi1VLKL5hdfzL5cMEQWpVZ68y3o+nZgDpLx0qoI+i5LnWfWO
        VYpOaaCiBm1S+FezQGAgnOF79w==
X-Google-Smtp-Source: APXvYqxgYBWiFOrj5HNpz+/FCpzyLc7TZlx+EJAQx5cJoqMOCKZUY1H+JFA3fOapkxLNA+Ssa5evfg==
X-Received: by 2002:a17:90a:216f:: with SMTP id a102mr2521250pje.29.1561075700506;
        Thu, 20 Jun 2019 17:08:20 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id k13sm659448pgq.45.2019.06.20.17.08.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 17:08:20 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:08:19 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, ast@fb.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: switch test to new
 attach_perf_event API
Message-ID: <20190621000819.GD1383@mini-arch>
References: <20190620230951.3155955-1-andriin@fb.com>
 <20190620230951.3155955-6-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620230951.3155955-6-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/20, Andrii Nakryiko wrote:
> Use new bpf_program__attach_perf_event() in test previously relying on
> direct ioctl manipulations.
Maybe use new detach/disable routine at the end of the
test_stacktrace_build_id_nmi as well?

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../bpf/prog_tests/stacktrace_build_id_nmi.c     | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> index 1c1a2f75f3d8..1bbdb0b82ac5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
> @@ -17,6 +17,7 @@ static __u64 read_perf_max_sample_freq(void)
>  void test_stacktrace_build_id_nmi(void)
>  {
>  	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> +	const char *prog_name = "tracepoint/random/urandom_read";
>  	const char *file = "./test_stacktrace_build_id.o";
>  	int err, pmu_fd, prog_fd;
>  	struct perf_event_attr attr = {
> @@ -25,6 +26,7 @@ void test_stacktrace_build_id_nmi(void)
>  		.config = PERF_COUNT_HW_CPU_CYCLES,
>  	};
>  	__u32 key, previous_key, val, duration = 0;
> +	struct bpf_program *prog;
>  	struct bpf_object *obj;
>  	char buf[256];
>  	int i, j;
> @@ -39,6 +41,10 @@ void test_stacktrace_build_id_nmi(void)
>  	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
>  		return;
>  
> +	prog = bpf_object__find_program_by_title(obj, prog_name);
> +	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
> +		goto close_prog;
> +
>  	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>  			 0 /* cpu 0 */, -1 /* group id */,
>  			 0 /* flags */);
> @@ -47,16 +53,10 @@ void test_stacktrace_build_id_nmi(void)
>  		  pmu_fd, errno))
>  		goto close_prog;
>  
> -	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
> -	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
> -		  err, errno))
> +	err = bpf_program__attach_perf_event(prog, pmu_fd);
> +	if (CHECK(err, "attach_perf_event", "err %d\n", err))
>  		goto close_pmu;
>  
> -	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
> -	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
> -		  err, errno))
> -		goto disable_pmu;
> -
>  	/* find map fds */
>  	control_map_fd = bpf_find_map(__func__, obj, "control_map");
>  	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
> -- 
> 2.17.1
> 
