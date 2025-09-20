Return-Path: <bpf+bounces-69112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9D6B8D1BF
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 00:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFF817FB8B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682F2877FE;
	Sat, 20 Sep 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsKS8oV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAE27B35B
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758406673; cv=none; b=bKEQwFIzlOGOMnk6lVOsMP/QfOSl6KPLESANaDt9Gd/BnKtwib9rPa1TP0eNNo6iFPDnefX4QNT1eXdDApQX7B9AdJ5PUvQR7hqrFmc0UkoI1V1C3UXGFIaVVSFdtYLYeEqDjKmMHdl6YJ3iFMIfTQgUZxMlte5kEH0nwbI07eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758406673; c=relaxed/simple;
	bh=96dxx70d/BFqImcMeVoXOM+8YDlRuIcpQzt1VmBfil0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvaQJ3KBFXnrmOiYVE08nVfH4AlNe19MJMjAdA4g4w1JPOWNK6v9rPwWYRDECea/VqRpcMBlE7l/zfA2fYMiFBZtw7EDbrjlvO/eHdR9n+KOvgPJnuxgaJjm/3q8s+QltdvoodKciCSPCB8zHBpTwG1IB68xMEuX0G9CPyz+gjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsKS8oV0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so3971935a12.1
        for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758406669; x=1759011469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HgtdynmY0igjvNZnpu91IhlMXMmcHk6gD8131LsDf8=;
        b=TsKS8oV0Ec0JLnc+mKCN31OZwyskRpLNrWsMigl1/dOchWeXQssOd/lTV4qyybo6s1
         JsqpSWMGeSJcsO+VYB9ZWS7kuT7UpSLnyCJEwMDbp8gjgvmq8Xq/9EM0ZtS7pbpT/4Sp
         AFSmjvITqXq803uTKWjAMela4Vpt8rWFBSLfEMmIG+7Cm4lx5QW7g6j5Rxb+Vi+bKbqJ
         bnPWZpRnR6OjzM6SkJ1VnYTpVwstiNe+G7vR2cii07FYmvv7IPN+FAl138+pLVXb1u6T
         OyKkY5uGxnElZy6Ht6eBZOCYr5m8bIHai4bXZq1WcdlFkT81xM8nWAIXwOR3SMua7NHo
         zZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758406669; x=1759011469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HgtdynmY0igjvNZnpu91IhlMXMmcHk6gD8131LsDf8=;
        b=F9n0wVPSKCYPdevcT6mzQ9dY4rdnV6lJCH85jY6PIc+9VZu5XVKTyvp4JdcbTTc6Lu
         KHih5igU0H/+6G4hxEYbJp9TXzsVQsMTv8sRgb+bleY0b6vAlXA6jkI3lFxJ2JLOV3Qn
         0VQ+FvtzI2vWaJZgZrdmGPlc+WyVvrva9VuTNlAm7nO3WrJN7DlAwKxFthPUffJHwgDL
         vETGnuWAYdfCUQL/p4UTpjXd4um//jcmzEv9UNkQtCzwJL4ngO1slqZL2LLRuRtxk6UX
         GA8qJ3KvKM4oRwGAJtELwekOOX86DsNHYUT3GIFi4OxADV4jxkcn/03TZM2vH+4fnrCl
         d4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXsFE9pU1MEGD/1td2Ntb19+jqfdoKwtOvy2q4Tza2zTa5h9RUzpjJX014rr/xkpbrftYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpKcm+g6wqvYgMgdG6M+6/eD3J1LJFk1hMZcGBbmAcwJZPO2R
	cZR7YqZAPShFxyiS4gzYqEK4DRudP+IS0U5EtESTDOM4bBU0WkftwPST
X-Gm-Gg: ASbGnct84bNjLSYXcC9C+RU4VjYFLkQzi0+Bl9VCtsMMDt5oK+sjz6YwU9+3nI4crlw
	6XgkeLBZLHXXkX/2rxwB8uVPfd8sIqz7CI0Kb8QYbCuKtCqmLxfb5/CBkJRj+Zs+9FHkLxVqdb+
	Pa8Ujj1KFQNHWQmjOUejKO5stC7nNpeUMWm7OnDntDBYcyorRT/zF62Fe138Eayi8b40GOEt3Ik
	rDtc2+igfLg7CSztbP4HRFarGDqyKQbvH+ZhsGzh28LS4F/W9BRhAWD/1L9rpUvNnvMzor8g9t4
	G67kg9AAM+BR5AsGzCU8hM5yRcsLKJBOvCEGxqGO/UdGi0OW/C1SfYo1NLZiUpbE/tiyd8VccWG
	EPWIH4xXu3wmwppooP/KMfkI7bgamVDTTwASIm/D4Hp8=
X-Google-Smtp-Source: AGHT+IHuYXbv1MwgeFhgGHEnoMk2vC63tOuKqEj+eah5xHgaTZ82uYXktvX8jVWZFLF7LGFrAO/urA==
X-Received: by 2002:a17:907:7245:b0:afe:7027:56f9 with SMTP id a640c23a62f3a-b24ef58d811mr815980866b.17.1758406668905;
        Sat, 20 Sep 2025 15:17:48 -0700 (PDT)
Received: from krava (37-188-197-68.red.o2.cz. [37.188.197.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2864cd8376sm218759666b.80.2025.09.20.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:17:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 21 Sep 2025 00:17:42 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Will Deacon <will@kernel.org>
Cc: Feng Yang <yangfeng59949@163.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-ID: <aM8oBvEJoR56w2Dk@krava>
References: <20250919071902.554223-1-yangfeng59949@163.com>
 <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>

On Fri, Sep 19, 2025 at 07:56:20PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> >
> > For example:
> > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > index 9e1ca8e34913..844fa88cdc4c 100644
> > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> >  __u64 kretprobe_test7_result = 0;
> >  __u64 kretprobe_test8_result = 0;
> >
> > +typedef __u64 stack_trace_t[2];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +       __uint(max_entries, 1024);
> > +       __type(key, __u32);
> > +       __type(value, stack_trace_t);
> > +} stacks SEC(".maps");
> > +
> >  static void kprobe_multi_check(void *ctx, bool is_return)
> >  {
> >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> >  SEC("kprobe.multi")
> >  int test_kprobe_manual(struct pt_regs *ctx)
> >  {
> > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> 
> ftrace_partial_regs() supposed to work on x86 and arm64,
> but since multi-kprobe is the only user...
> I suspect the arm64 implementation wasn't really tested.
> Or maybe there is some other issue.
> 
> Masami, Jiri,
> thoughts?

hi,
I did quick test for kprobe multi and I can reproduce the issue
on arm64 with ci:
  https://github.com/kernel-patches/bpf/pull/9809

but can't really tell what's missing on arm side.. cc-ing Will

thanks,
jirka

