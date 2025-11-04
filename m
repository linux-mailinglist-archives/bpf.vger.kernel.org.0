Return-Path: <bpf+bounces-73421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4DC2FFD3
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 09:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2571886195
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80B3112D5;
	Tue,  4 Nov 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APiNfiQl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAD8634F
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245347; cv=none; b=Dsvnk3WyePz3yIxTSAFK/ZDQBIIsu1Pf5Ozv+X/+wX6nf5GUarehHQ9BEv362oW/ENRQoX/ZdSBmqhg5mjdnAKNNwxlqwe4G1i4tY91ndKm3owDVwvgIYiS6dQah7Eag4fO4T2W2G5yrrPrSy6gRk+nVQxWX2+BT8bj39Ge2TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245347; c=relaxed/simple;
	bh=N490/TG3XtRjts6kYFyxHc4CGDHNZTtWIrxRlPC+beY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMa9LP8czTnDOi4mbGK0j7+AhjXnFrVIvtYoGdntpZEwRaWsSKHK7x0Uz0Sv6rcLV9N/WwOb4vmG0hw+9IBLqfiQErlcwygGZJ992mHNP8iGjAwtZ2207Bgk9Dwsb1u4sX1xIu5T7nqefp27sSkGUEks2gvZFRUzBG0RGzk/pY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APiNfiQl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477442b1de0so16154945e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245344; x=1762850144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iRqZFu43lXJnLAXLjzrSZx/jk9otyggnor3WZ2EbNM=;
        b=APiNfiQl7NquLOVU/0OHmV00YbaxTltwrSz6kAhBrPe+ZLuryf0HyZsGRJ6xzmBili
         gMyNhvEklXMs0VWXm6WIKTY3NWINg7hiL023IKpSWuLgX5dhNLROaysj81/oi++zhJn/
         lw8rrqSKW5JzQT91MONXhEvbxyTNjY6b5s6Kic8Uf+FpSU8dFW+dcODWOjJVPkZ2eJHm
         XOl1pXojpAGl9CLAKTLQAQFNvfC2+g8WxO787swnv6lXjCuoHYU5P5LAkIrHSaYkdKY2
         dYS6jybsCCpcfdIZXNsNRzkN3iml15OTVVSK9RHpgn/gYSpXkK1gjgdCzZffqx3fpL4s
         8B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245344; x=1762850144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iRqZFu43lXJnLAXLjzrSZx/jk9otyggnor3WZ2EbNM=;
        b=S8XZu3m1udR7oClatgFCvZ3HIRbbId8GAJv1ag33/yF5t2d8iLM2tYeKBbAxzZWQhh
         f+GUaDfze9SSxuHkmW+vWq5WCx3VaaQGZRC7OhMwgITXJiFBUWFfBx0GLShqYA/TtNvP
         mtwV27+g6E2YaulYuwcA+7vgCCqGSwFOK0cF6tLx9tsFWWf/W39Qgud/4mcY/6yvAkug
         /j2/hks2crcKGdVq+5cuqQRQXEU6AnRThubB8Ul3/Gm2U4LBWsaQ3sYypjrLb1HasUfg
         hO2U/WQ2lk5qRKqXpP17Oc3ATFgEBqJUBF8PXTFZRXXExZRba71FGrqvGpXf5Myrf6tS
         fG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAIcRua5zjSTRvyfgZVKKkODw7gvkyl+Gmk4oOTV7v9nLQJyQRTUxXxch9YGVcqGzkZl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LL6OdBqYsxwInZnIwzyQFzb4Kwa8OGqc5wWeB4/UpjtNgZka
	4i+mlM++z7Iqaf31NZ35m748DCKvbwTOMq/ku/jTmOta6oojFoDWRoBH
X-Gm-Gg: ASbGncuhUEfNIBvQ3AQOf61iH6Lah/7eI92+8rVOKDedtRC4IZb98ZqVi00ptq4MRQo
	12xLqxh/2DKcpQNR+v3zhsdJ9KwuX0h57UD0u3qNTfN0piwaZ2p1UkdS1ZKocrS6ixcBBQ24kxQ
	t+XPalNckM7NrB5cZlbONo9HL9p5qt/cMuaopStVGNFCd0RjiRN+lF3CvJc3J5hQGwmccSwfcis
	OSDgI+E7ezUgKqNSNvfAMAUGAGEOCtyoXKhH21235bK3P/FH3q1JdmX7xQvJkPigTjoxdrne779
	Y1YmehVCzdoHbIxWFFCobGF7xv/fPgGsZLyJ3ZzHkpVM1HumhbTl2Rx1MKcU84KpKOwkKCBvc1m
	DmVjY73G5WpcteFEmAyHqD5Cf1fRg25lJ+zOPeo3VQ1Gpl23B6A==
X-Google-Smtp-Source: AGHT+IHu1BecoN7hPPRpZX/FIuxI3kKqiebd5/P0sYSuyDaOBlEppzCMNxt5Ft9U6yUF8ua9knS0tQ==
X-Received: by 2002:a5d:584a:0:b0:429:cda2:9ffd with SMTP id ffacd0b85a97d-429cda2a24dmr5997729f8f.9.1762245343780;
        Tue, 04 Nov 2025 00:35:43 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdae2sm3322788f8f.41.2025.11.04.00.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:35:43 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Nov 2025 09:35:41 +0100
To: bot+bpf-ci@kernel.org
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 4/4] selftests/bpf: Add stacktrace ips test for raw_tp
Message-ID: <aQm63ZvtqzEWvRfE@krava>
References: <20251103220924.36371-5-jolsa@kernel.org>
 <0fc522195058f867d14c8a652b6b698d03751d0d179fcffdf20a44bf4293039a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc522195058f867d14c8a652b6b698d03751d0d179fcffdf20a44bf4293039a@mail.kernel.org>

On Mon, Nov 03, 2025 at 11:47:36PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> > index 6fca459ba..282a068d2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
> > @@ -84,12 +84,58 @@ static void test_stacktrace_ips_kprobe_multi(bool retprobe)
> >  	stacktrace_ips__destroy(skel);
> >  }
> >
> > +static void test_stacktrace_ips_raw_tp(void)
> > +{
> 
> [ ... ]
> 
> > +	/* get bpf program address */
> > +	info.jited_ksyms = ptr_to_u64(&bpf_prog_ksym);
> > +	info.nr_jited_ksyms = 1;
> > +	err = bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.rawtp_test),
> > +				      &info, &info_len);
> > +	if (ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
> > +		goto cleanup;
>              ^^^^^^^^^^^^^^
> 
> Is the error check inverted in test_stacktrace_ips_raw_tp()?

ugh, it is.. will fix it in next version

thanks,
jirka

> 
> The ASSERT_OK macro returns true when err == 0 (success), so the code
> jumps to cleanup on success and continues on failure. Comparing with
> test_stacktrace_ips_kprobe_multi() at line 70, the pattern should be:
> 
>   if (!ASSERT_OK_PTR(...))
>       goto cleanup;
> 
> With the current code, bpf_prog_get_info_by_fd() success skips the test
> (trigger_module_test_read and check_stacktrace_ips), while failure
> continues with invalid bpf_prog_ksym data.
> 
> > +
> > +	trigger_module_test_read(1);
> > +
> > +	load_kallsyms();
> > +
> > +	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 2,
> > +			     bpf_prog_ksym,
> > +			     ksym_get_addr("bpf_trace_run2"));
> > +
> > +cleanup:
> > +	stacktrace_ips__destroy(skel);
> > +}
> > +
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19051288274


