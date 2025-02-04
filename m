Return-Path: <bpf+bounces-50338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E938A26891
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5413A5AB7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E327453;
	Tue,  4 Feb 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xco+aQ89"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39F25A657
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629043; cv=none; b=X73H4ItgJi5DoVCwc1mEc/o/keqpBJn6vcOItZYX/9r6p2yPRDuCmyxM9/B51xdfHHktMj12TDHao6iz8v6Z8kBmgbr1BfpdDp1FbaHteFlWaelWjjdjjHevwo2NdEGJzhof9Th1gXaUL/z1kHKymjRglj97f9Sq5zUfPRWB4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629043; c=relaxed/simple;
	bh=88fbyMU7mFkpG3/Lz8zZPB3Vws0Niqn3ee7ryzNfNGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ263vcB64XClC3mPmCwEMIJw+LLWJuxk9xiXvA7smdvyjoVin8TqjAQ0Qzdxr6XepZ6x3hPaHdkVhlEeJYNBQ3c0+GuL5SeRVQMaHur1hLNxi+xrlUs+bASc3HHX6nGwjEjvq9TkwweaWIsXQ53JcOjHcrqrcRNs8d2XkfvXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xco+aQ89; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f032484d4so32755ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 16:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738629040; x=1739233840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEzrHrdt0goZW6xuyG7hCMqy+oltKW4CxtAbZ+3uSb8=;
        b=xco+aQ89VYMK3xEiJtKgPUKOiqonDfwdxUqZ6s+YUcKs0mQ3GVxzd0tw7M5KvQELO5
         HI+aWfn7G1SW2BXCFI15CmJLx3aaKagC6Ascmx3QEf8V7aT1leSpvc3RLas5epzbX+Hp
         FDFeBPQXCsME12ndjM1ZUywVF98Q4OizGV4aCg5hHlssDiGfNGVc/HAHTAf9YEjyvgYP
         pRqjM6V40GWvNp4TlJzhXU6SeO0OHlNkd41hrx6qaf5w9xIJwdJ9Mc2LuO4WC1o0cVm9
         9SHvsnYMdqQCjMa5PVHNVpE6+eHEz47rp7/fbowdZfZ98aisyK6Ch0LaZYTlQevExi2l
         ehnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629040; x=1739233840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEzrHrdt0goZW6xuyG7hCMqy+oltKW4CxtAbZ+3uSb8=;
        b=fcbpqdcLSM3K3aoQfLICEU8tO3z8TBQ13InGXwsIRUY0RVPkOO42wNxM2AEv6u25Pe
         hYOxslO2GxgKF3LW96RxVE3O2yNVTW4+pCQK3do5eleVDIReXXxxL+ngaXNDjmh9gGEL
         FtgfG+cQswMdOjvt3sXnGfMhUWmUPoNxR/3rBO1feI7XHZY6AIBcjGz2S7NLEz1JPLYf
         iaPJWgk7GVzHSsLlARbN3NSDrofqMGPeJczo0pduGxC9+xDHVRq9XxAi3x64Ce23aYX/
         jHz66Rk0tPA5iyc79+Qv3Fbol4ycl2BDflnSM4eb5mEsxJhu7vat6JiYnkIOiQSOd+Fq
         rXDg==
X-Gm-Message-State: AOJu0YzsBMvV1/jmyzOaCYbHpmU2hlUtGHj3HFArS6W5VKqAGm2uVeBZ
	k2xj52ZeUD/EO/Kq+VVwZU2xJpcQGitd2zpxV8dO9Qx9blnvVA/pN5ytkiDFgA==
X-Gm-Gg: ASbGncsQaJ9YgSXCUTwpxh4QizdWHMoBHuHjubr5IGfqCfI1fLI/jAr6drsnZYCgOSB
	A7Zgu88vudcFuwtdycyl70ii55tkb4FxCQAE1F9QC89tnpk9YSzhdygpDcJ3VL7p+cXEWNAguvz
	cng2bJX0DonFppT8MtSuqZIwC3Xoeo3H0r17J5k9GEqvBUrpkQ3EcUOkgzh1GMjuchXgTBZhd2G
	A+JOdVpL3PvvbZ8hin+lMTWapYDoiYwPqKfm1hoUdI8w9MyqXESDFG5g34P/ArLXIYAcgcNzaMk
	oabDTjafZT5RAKt0otKEYp4eFoPReixlvG2NBiHI8sr1a6+1nvVdlJU=
X-Google-Smtp-Source: AGHT+IHikxLNTW3iYhv8Z5ZOqr8vWjwaYU1u/+FyXYyb6zbBw/ySBIpLXMurmcvACGA5bpuElmc2/w==
X-Received: by 2002:a17:902:eb8d:b0:21d:dbe3:fc48 with SMTP id d9443c01a7336-21f005bb8b2mr1164915ad.28.1738629040175;
        Mon, 03 Feb 2025 16:30:40 -0800 (PST)
Received: from google.com (147.141.16.34.bc.googleusercontent.com. [34.16.141.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3334694sm82930165ad.257.2025.02.03.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:30:39 -0800 (PST)
Date: Tue, 4 Feb 2025 00:30:34 +0000
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
Message-ID: <Z6Ffquq8IORjCqrI@google.com>
References: <cover.1737763916.git.yepeilin@google.com>
 <3f2de7c6e5d2def7bdfb091347c1dacea0915974.1737763916.git.yepeilin@google.com>
 <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131a817f7f2749e78e527a251ca7971588cf62f8.camel@gmail.com>

Hi Eduard,

One more question (for my understanding):

On Tue, Jan 28, 2025 at 05:06:03PM -0800, Eduard Zingerman wrote:
> On Sat, 2025-01-25 at 02:19 +0000, Peilin Ye wrote:
> > --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> > +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> [...]
> 
> > +SEC("raw_tp/sys_enter")
> > +int load_acquire(const void *ctx)
> > +{
> > +	if (pid != (bpf_get_current_pid_tgid() >> 32))
> > +		return 0;
> 
> Nit: This check is not needed, since bpf_prog_test_run_opts() is used
>      to run the tests.

Could you explain a bit more why it's not needed?

I read commit 0f4feacc9155 ("selftests/bpf: Adding pid filtering for
atomics test") which added those 'pid' checks to atomics/ tests.  The
commit message [1] says the purpose was to "make atomics test able to
run in parallel with other tests", which I couldn't understand.

How using bpf_prog_test_run_opts() makes those 'pid' checks unnecessary?

[1] https://lore.kernel.org/bpf/20211006185619.364369-11-fallentree@fb.com/#r

Thanks,
Peilin Ye


