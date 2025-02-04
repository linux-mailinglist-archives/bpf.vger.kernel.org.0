Return-Path: <bpf+bounces-50355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE012A269DA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D22E7A29A6
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37286323;
	Tue,  4 Feb 2025 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgSroyYF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA578F37
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738632601; cv=none; b=Zn9lDccsmRF03z1chaOuH+S0eqm0dTRUeXAMaFWkchY8XacNfmZYEpiEWwYockHuYC0NjBBPifknVsTro8hRJvBwm/acKvOQ5Hu44W97wwrhSlogmOqj28MKznAv1gsPwvnuIJizTSMHH5WbQJ7Uk/7UTXRvacEW03zaWLHXyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738632601; c=relaxed/simple;
	bh=1CSFQ+ydcdLecFubxFtMF9SlqEvCyjwJEBoso/Dy1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwe9V6qreNR3MLgv6ghuqGIRbrYY9q9+yXmDkoUSrXbE6f7ypL8q+clgNgtKhXSItNpYZaY9VPXd19t7nRzWCDmuKM8QsGzG+Bk5b+K8MKu/Z4Mt0YLb4R5I8iaxFc6GS1PrurRLOtYhgDnEtVOv4ewsm/S2Lgp+QkpRREh+bL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DgSroyYF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f6ca9a81so24855ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 17:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738632599; x=1739237399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgs22GMIvih+rvIPBu4CVSrVFT+Ext8GsAWJW9535gA=;
        b=DgSroyYFEtUdX23m7XMdf8MQ49UeKKYPWGmKmrQnx83rDVABBzykYDbyQuFqXoEZJG
         VzCcr90s6aZfb5YUtLOIwTcNi/p/LlsiQZQiO95uMEACqLqc03t4t0OMj3SKCxqEFhVY
         FgZxhy/HbyiQsS2ukYwGd4eALN4QCzSBMWeADI3t+HNfXMRBjBt0gKdpf9ccuzgHe2NJ
         T+v99152ke7xaTvAYO96lOWZqLL8nW6Izo3Jlk8miz3IM5V9cpb4pLDZARwEshQloDgs
         aY8yYS41VTukGh5b7FoINq9FvoKmj3N7SjOPdWVnoohmZRZcwDhLwbu10zfQBFBemBq1
         zDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738632599; x=1739237399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgs22GMIvih+rvIPBu4CVSrVFT+Ext8GsAWJW9535gA=;
        b=tuvDNcfeGLJKmrWmMy9DIQc1aRU5a/PzCUrZinpjjrYV+BJKQ0I6KF//8hAZiY8HyD
         N2AedojXQcDRO4M2VkRTu4TZs73oiRky/va3RfsPb/aTFFRPQlNxzbJlU1rG6+E3dttW
         DcTUd9IRQ015g+NfjV1W7bG0HmmEIYTJCsqnw0//wsFaoI5uQbdUN943QgHc09CEUv9u
         wBAeOuh+DI9sI0PC7uOQUeUSBa7OjjACk/WdVafb/2l5Z/FZwfx2BkkSPfkcnLAMPZLH
         5EA1v1mZ0kQ+YyKaXZVS49WOeErZz7hZFoy7q9mu3XSRF9aNCU3H50dcsi/GidFvVcKL
         PEHQ==
X-Gm-Message-State: AOJu0Yx/iWF807FcYSur7j5uWP0UmuziQHmpPbjE6z6IhyksCc3NmeAb
	rs1gid2jSJtFeyYfIzq3tYWVsv9ljUMW9WSvkgqbyoae+LzvGT2gZVfUitbp7A==
X-Gm-Gg: ASbGncuZB5J6gbhBHcXDNE3yRh424/fzggMUWvRu7MpRtyWU5kaMTP+YPKjECTKpEcZ
	I4H5qH1xJRmpQ/2hlRsEU+Qd0yVVVQQOPppn7uGDZZRiiwnhDDUdDaGs/gtPIQr0uppVl90t9az
	NzABQO1bZrpTG0dDZGJ03XKYcGmHJZoC+YlcJavYWmXnXxslhx8SsZE0KwKuFj/geJlr5KdgzSu
	rDwsavbbiFomWVzkNfkvLlJpxifbS6OkRjdgNjHTNSs+tNU9ONgvZtUOxktjMr1tDQRVnYLi+Rc
	L6y+2Zt06gy81EdQ7nWNLrzSc51x1lG4TgbLj1h8c8HWtOyz1EwVlTI=
X-Google-Smtp-Source: AGHT+IHWUc7R5dlQvBOepVJMbNATdkSv/zYRIZ13MFf9lk+DkYICE0KTYJsxO5+u8NDbE883OqLPNA==
X-Received: by 2002:a17:902:bc8a:b0:215:86bf:7e46 with SMTP id d9443c01a7336-21f03b3c62dmr686735ad.7.1738632598666;
        Mon, 03 Feb 2025 17:29:58 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331fabdsm83432105ad.221.2025.02.03.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:29:58 -0800 (PST)
Date: Tue, 4 Feb 2025 01:29:53 +0000
From: Peilin Ye <yepeilin@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bpf@ietf.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	David Vernet <void@manifault.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 7/8] selftests/bpf: Add selftests for
 load-acquire and store-release instructions
Message-ID: <Z6FtkchYQjgjdv1x@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
 <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
 <Z6Ffquq8IORjCqrI@google.com>
 <dead664fa11ac274db00b509931c533883dd4fdf.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dead664fa11ac274db00b509931c533883dd4fdf.camel@gmail.com>

On Mon, Feb 03, 2025 at 04:52:52PM -0800, Eduard Zingerman wrote:
> > > > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > > > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> > > [...]
> > > 
> > > > +SEC("raw_tp/sys_enter")
> > > > +int load_acquire(const void *ctx)
> > > > +{
> > > > +	if (pid != (bpf_get_current_pid_tgid() >> 32))
> > > > +		return 0;
> > > 
> > > Nit: This check is not needed, since bpf_prog_test_run_opts() is used
> > >      to run the tests.
> > 
> > Could you explain a bit more why it's not needed?
> > 
> > I read commit 0f4feacc9155 ("selftests/bpf: Adding pid filtering for
> > atomics test") which added those 'pid' checks to atomics/ tests.  The
> > commit message [1] says the purpose was to "make atomics test able to
> > run in parallel with other tests", which I couldn't understand.
> > 
> > How using bpf_prog_test_run_opts() makes those 'pid' checks unnecessary?
> > 
> > [1] https://lore.kernel.org/bpf/20211006185619.364369-11-fallentree@fb.com/#r
> 
> Hi Peilin,
> 
> The entry point for the test looks as follows:
> 
>     void test_arena_atomics(void)
>     {
>     	...
>     	skel = arena_atomics__open();
>     	if (!ASSERT_OK_PTR(skel, "arena atomics skeleton open"))
>     		return;
>     
>     	if (skel->data->skip_tests) { ... }
>     	err = arena_atomics__load(skel);
>     	if (!ASSERT_OK(err, "arena atomics skeleton load"))
>     		return;
>     	skel->bss->pid = getpid();
>     
>     	if (test__start_subtest("add"))
>     		test_add(skel);
>             ...
>     
>     cleanup:
>     	arena_atomics__destroy(skel);
>     }
> 
> Note arena_atomics__{open,load} calls but absence of the
> arena_atomics__attach call. W/o arena_atomics__attach call the
> programs would not be hooked to the designated extension points,
> e.g. "raw_tp/sys_enter".
> 
> The bpf_prog_test_run_opts() invokes BPF_PROG_TEST_RUN command of the
> bpf system call, which does not attach the program either,
> but executes jitted code directly with fake context.
> (See bpf_prog_ops->test_run callback (method?) and
>  bpf_prog_test_run_raw_tp()).
> 
> Same happens in prog{,_tests}/arena.c: no attachment happens after
> commit [2]. Commit [1] is unnecessary after [2].
> 
> [2] commit 04fcb5f9a104 ("selftests/bpf: Migrate from bpf_prog_test_run")

I see.  Thanks for the quick reply as always!

Peilin Ye


