Return-Path: <bpf+bounces-55130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C2A78A90
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BBD189488E
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A45236434;
	Wed,  2 Apr 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfeOoC5m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD32356DE;
	Wed,  2 Apr 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584514; cv=none; b=rcRYNXRJNWcmkhPGVKkUdCAJjUy/ih2od1kFZXctJjohDjvdI2JxX+N9UWnjanv+KLeyD5KRD9ICphN2dz4VfFdo3NskjkRuy+cPmB4SIoQ4EZQBupj1CCsnrBDQERXlkCNnKM7ZZGYCRsLy6Rl+ktOlS2nfni2dC7OOcqcbWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584514; c=relaxed/simple;
	bh=rUgBe89BqhMYnqzWNw2OJtoHYtL70hIT/ZCa+5v7IJk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHzZYcAyzyMLUbD84b5VCDEYS/j5AmZmhw4xPZpJDf3y/BuQ0O4xz3206UjBiAM6J4tifekcl1jQ6eFCZb5SSBFALFfXBZzYBNEZrn1JHaLZp4ac3s7JMnMepVMbsiKqAQeQCoeBWZST2l7nJRc9y6qe2wj77T1f4ksFAAc0vnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfeOoC5m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so46945625e9.1;
        Wed, 02 Apr 2025 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743584511; x=1744189311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Dq9mtnwptIR9k2AlS6ej/m5KQmWK6XyLNHgYnm7w6Y=;
        b=QfeOoC5m3+Snuwf4uHu553r1URQh6CaWcBLmZVFcCt5XWke7flyMhmdkUsW69TU+ba
         oQQR1247bq2lcqJ9RDUeKwTtrXDLh4tcg4JdIHQsyn5gyMpMWAJo2w6yrOj67GEzz1Xb
         kRGhBptDB7gyZ7fQlp67j6tkdPh8seZ9A3TZbMQztnNxlQVQtAWka5Xli9OeK2RABmA4
         IkyiOIpFt8/Sas5Ff1zE4olX3Xn/lg+Cc3Uu8VE6V19Ybu/2rdlFWSGvl5JUSrqoEL2R
         wwvW4UEoV4ERIZNGdLM42FoVoXAcH93KKVTb9pM4JkIlWMI8cqJjxVP45B9G5N8owVxO
         mSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743584511; x=1744189311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Dq9mtnwptIR9k2AlS6ej/m5KQmWK6XyLNHgYnm7w6Y=;
        b=NtXgyx8m1oxT6xeeM9V6sZhCNpFVgkAkSOKqF1ZyfvPN3vRN4pwpjV8RMFMlSXpTPg
         kyJe+gGU04+seZRcCfHjTaxOXcpiTLTLeIOGELN5YVQib1EWHM8eHbaNUS7fGFbzr9+8
         fNnb7qlFBnolnT7mOhytzAkxWa/r/8tJZ+/6guqlCTZZCGpBiX4P+IzJBU3yNRPubZeA
         sBFEPhAX5rG2wHH2xRVwRMX8NsV2laYJYhaUiK4lsYyv1yqulwCsN63Pm47s/63TbE2j
         ivkQyVJW7DYSp0WNjxyqjat6sShnVxInVbuo0/LkWAdWumP/xPpKSu7auZMI9YoT5KYa
         Nngg==
X-Forwarded-Encrypted: i=1; AJvYcCVGDueThGzOTgpaK8zM19J97wgxlA+KBz/6cOmeJlONCG0cOSQA2R6FYzNES4cDPng54sII4ZqlxAWAm4vd@vger.kernel.org, AJvYcCXdVEze+uQCK0EZhCWOT+VNM/maMJv3Z8HN+0/G7I2hmavBNnCK8OR1aDeSaBhec0OMy6E=@vger.kernel.org, AJvYcCXvHPoMFzBicWhLI+RlyZ5lphNKdYb4Q7nyXGC4bc8BgktvwF8DHJ97NIbdnNF6rSwyEUDCG9td4En3P4WdCOttTFbv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QXlh+HdHRnNNaCw4mzkFRefIHjw5ZgsZfrdBsLbCjfbLzC0O
	nu+iBr9yFY4WEXuMe5XBqmXRF36++tTwAo6avVsJ4M1aBNYQotu/
X-Gm-Gg: ASbGnctS5z4MdGusN1Cupx3f85kn4rXKA3TR5ssDckERf886umAhoq+/2L8VD7anblf
	6FEUiHlRW7MxDFJAerhMVu88tBoRTNdzYqwPDBlxYyJZD0O0/8sx28PgvpfFNxzxJMo6AgvbnB2
	IpRsjp0OOxBo90jGXxigG+sRpH8uf8vabEZL5pyCJI0g46sl3l52HKIvQRR9P24xZsr44KW2SCz
	EK+jFGjf86z1oWm5jQthV6/545dEJfb6AL3isISeb+Yne5PnnLXuk2Qm7lHnda3XdF/g8xuA5Qm
	3cAUYe78zLPWhJUhQ278qqsflkPcIhFu/5BtFo3jCg==
X-Google-Smtp-Source: AGHT+IG0akru2d47uWQZ/jfoM9IqOcUx7LeoqZ3ObOwfRvPTm/hzLKBweBVAcA1U2Y6Ogk4pYNJ/cQ==
X-Received: by 2002:a05:600c:4f0e:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43db61b3623mr129163115e9.6.1743584511238;
        Wed, 02 Apr 2025 02:01:51 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658803sm16038374f8f.6.2025.04.02.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 02:01:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Apr 2025 11:01:48 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Jiri Olsa <olsajiri@gmail.com>,
	song@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, laoar.shao@gmail.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for
 multi_uprobe
Message-ID: <Z-z8_HlpMk39SHUD@krava>
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev>
 <Z-vH_HiJhR3cwLhF@krava>
 <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
 <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>

On Tue, Apr 01, 2025 at 03:06:22PM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 1, 2025 at 5:40 AM Tao Chen <chen.dylane@linux.dev> wrote:
> >
> > 在 2025/4/1 19:03, Jiri Olsa 写道:
> > > On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
> > >> The target_fd and flags in link_create no used in multi_uprobe
> > >> , return -EINVAL if they assigned, keep it same as other link
> > >> attach apis.
> > >>
> > >> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> > >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > >> ---
> > >>   kernel/trace/bpf_trace.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > >> index 2f206a2a2..f7ebf17e3 100644
> > >> --- a/kernel/trace/bpf_trace.c
> > >> +++ b/kernel/trace/bpf_trace.c
> > >> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > >>      if (sizeof(u64) != sizeof(void *))
> > >>              return -EOPNOTSUPP;
> > >>
> > >> +    if (attr->link_create.target_fd || attr->link_create.flags)
> > >> +            return -EINVAL;
> > >
> > > I think the CI is failing because usdt code does uprobe multi detection
> > > with target_fd = -1 and it fails and perf-uprobe fallback will fail on
> > > not having enough file descriptors
> > >
> >
> > Hi jiri
> >
> > As you said, i found it, thanks.
> >
> > static int probe_uprobe_multi_link(int token_fd)
> > {
> >          LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> >                  .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
> >                  .token_fd = token_fd,
> >                  .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
> >          );
> >          LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> >          struct bpf_insn insns[] = {
> >                  BPF_MOV64_IMM(BPF_REG_0, 0),
> >                  BPF_EXIT_INSN(),
> >          };
> >          int prog_fd, link_fd, err;
> >          unsigned long offset = 0;
> >
> >          prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> >                                  insns, ARRAY_SIZE(insns), &load_opts);
> >          if (prog_fd < 0)
> >                  return -errno;
> >
> >          /* Creating uprobe in '/' binary should fail with -EBADF. */
> >          link_opts.uprobe_multi.path = "/";
> >          link_opts.uprobe_multi.offsets = &offset;
> >          link_opts.uprobe_multi.cnt = 1;
> >
> >          link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI,
> > &link_opts);
> >
> > > but I think at this stage we will brake some user apps by introducing
> > > this check, link ebpf go library, which passes 0
> > >
> >
> > So is it ok just check the flags?
> 
> good catch, Jiri! Yep, let's validate just flags?

I think so.. I'll test that with ebpf/go to make sure we are safe
at least there ;-) I'll let you know

jirka

> 
> pw-bot: cr
> 
> >
> > > jirka
> > >
> > >
> > >> +
> > >>      if (!is_uprobe_multi(prog))
> > >>              return -EINVAL;
> > >>
> > >> --
> > >> 2.43.0
> > >>
> >
> >
> > --
> > Best Regards
> > Tao Chen
> >

