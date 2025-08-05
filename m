Return-Path: <bpf+bounces-65043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58CB1B0B0
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A448D189D9C5
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82125A2A7;
	Tue,  5 Aug 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Advo4snv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1811514DC;
	Tue,  5 Aug 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384833; cv=none; b=SAaoVdCymNWj6HokXx3P9KtfffW3cI44O8x9u98+4L5uFh8M+JWk2Qd/L7G/pmyG7mw282cXCGd+g68gWHN14CFsaWkI1vlA9IePgezQcUBCaEFB5fC9T9O3hBE9yvL9tUVIfMq70pd/aBO/hdhitEIhDVKLlUC5fxN9WVYhLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384833; c=relaxed/simple;
	bh=faBJaGs9C9Ph67u+bDQnOU9XnsGXvqwFp7XSvu37l+Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkdryX2rhAzcV/ktw/OacGVVMSHzzOLwvA/1YDddu886mSZwJb6pYBDiR6iBXGwTl1EgUIyOO4Jz2X+8SVZbR5LxB2pBwYy3vl4nge1+9z0vZelySvuRwzBze+5vp4hrEysC0ZBtlwKnvkDuyMiOZN5RUO20Al97QuQ2YbFL018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Advo4snv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso7988126a12.3;
        Tue, 05 Aug 2025 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754384830; x=1754989630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyNh3TTSdT5ikwcTgpmj5kIoEpVgpn9sYixky6RydE0=;
        b=Advo4snvpvGdfbLoLX8LwskAOu6BjdxArNvH8FnYPmQSDDK9KQN2yYj5DzWAki9cJL
         ++JJGBGALjl5MsKNbjG2UJfcCE2WhmyIXBsfvjM6mUh5KXEGhtK6GQ6sYFHBtihZQq2C
         l2fgHqWboWvv2zROrBZ4fpToDrcSO9e4UF4+bDJ8opQNmo9sl3DHU0j4sGnMhtmWYxqr
         4ZTQbjQHrwaIibagTqtc4IiLUR4aQnid4702JRTF7NrfhHOR7xdAhjHqk5H1pb6tKVX1
         jolkhNVLC7SKsHOLS91/VdVubvbjiNAdx4HkskhZduCHZOxkk2b54aiIQEAFqZPBFxF9
         QP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754384830; x=1754989630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyNh3TTSdT5ikwcTgpmj5kIoEpVgpn9sYixky6RydE0=;
        b=X0juWiSctjSAuukFqMsIIw1agA/AfuWn1AZpIK/1tjm+AdYSXahcWLb02gpCbqbXi0
         L9kBSVk8uIUjPnUFpnVA5zQBs+xhlpcBqhGujXfBC3FSU5zkEHwyoi3+Ro5ykoLj1K/+
         xsAnuGwWtl9yI2RkXpz+0dP+og+BR6IiWDCX1nVMy1mCONcLLLdhILY5mysMLOVMLmm8
         tuiMlHkIIoUq2ZSQbXreM/6rOkhikJti3QApzdrh4QXeZ0WEUK1PczG03ovr+AJmsj0i
         33Mzo7gAYxccYDkmBqr0YVCrWx2xrGQl+yZV67Na19+pdWo0Usuy5Q2vFZPpC6eZjo+0
         y0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUNaKUCrhnGbSRu6sZpnROs6aM9NbUMDrO0zpaFfmeuOoud3clXT4VZitkS976qqruJsMk=@vger.kernel.org, AJvYcCW3NCeqTKqs72TJjaK4Ug23gHxNfnbSMyB6F/paviYIb9IOsJ+Fc+k0Dh9B1UvcnLYBx3pVRRGFLrcJx6kx@vger.kernel.org, AJvYcCXnXiJ7WNTSyRJ6bzcqysT4bz2uxnyg6Evxqebe46LdggwlaTWCxc5SEW0jQ9EgyqkHj0BM1uk0EXUSq/VgRWpsuAqL@vger.kernel.org
X-Gm-Message-State: AOJu0YydPWjT+j0YCiandvVwGsUKJRHM9XqDKhpiDw3ikzN2YkwHnLfJ
	6SyxzbUBeiKteM+J22Ul/MZuxfkWVJktbrH8pO/26J0B++huRbaf9AAb
X-Gm-Gg: ASbGncsb1K1pTbFyVJNg5Qslb8b+8dsqP85pyDJQedN4Ttb6g+i9p1nuUkumY4FSPiS
	bldLhfISwgJZcoJMdJHNE85x09ZtVA3x1n2xEm/OJuXp3Cjqk7/UiKnvVPYmiXF2E9VhKHTv1Sf
	ExliybAZWgq1uwAMNcF8AnC2/NJbCoW6YUw/AN18CnlhfrSTiMrcF0KNNWoLs20NVbnKONNZ4D2
	KLzkn2xy4RLwjVt7H9QdCQhDbi24JO69y2Cjal4JUioGZrezTOYoSqQcyiOuc1er095C5te4jdI
	MtgB7WpmZemu/pnh/nsTkEg5em1f06oWyq2lu9++uBRa5H9tBp432m5HfsH1n2vBDoB9nJjxEyk
	nCBPOdP7w
X-Google-Smtp-Source: AGHT+IEzCiSmyuLmfUx18KB60+ygqynD6yx9VZBZASLxgazQZQeay8sylzl5qh1Mwtjxao9WR3Xxaw==
X-Received: by 2002:a17:907:9812:b0:ade:44f8:569 with SMTP id a640c23a62f3a-af94022be56mr1192403966b.42.1754384829598;
        Tue, 05 Aug 2025 02:07:09 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fec4sm871953366b.121.2025.08.05.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:07:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Aug 2025 11:07:07 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Disable migrate when kprobe_multi attach
 to access bpf_prog_active
Message-ID: <aJHJu6dOeKVIc7JV@krava>
References: <20250804121615.1843956-1-chen.dylane@linux.dev>
 <aJCvY7G-gVR8taLh@krava>
 <c5e66881-2fca-479b-9ef6-c9ada34e731c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e66881-2fca-479b-9ef6-c9ada34e731c@linux.dev>

On Mon, Aug 04, 2025 at 10:15:46PM +0800, Tao Chen wrote:
> 在 2025/8/4 21:02, Jiri Olsa 写道:
> > On Mon, Aug 04, 2025 at 08:16:15PM +0800, Tao Chen wrote:
> > > The syscall link_create not protected by bpf_disable_instrumentation,
> > > accessing percpu data bpf_prog_active should use cpu local_lock when
> > > kprobe_multi program attach.
> > > 
> > > Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >   kernel/trace/bpf_trace.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 3ae52978cae..f6762552e8e 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2728,23 +2728,23 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> > >   	struct pt_regs *regs;
> > >   	int err;
> > > +	migrate_disable();
> > >   	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > 
> > this is called all the way from graph tracer, which disables preemption in
> > function_graph_enter_regs, so I think we can safely use __this_cpu_inc_return
> > 
> > 
> > >   		bpf_prog_inc_misses_counter(link->link.prog);
> > >   		err = 1;
> > >   		goto out;
> > >   	}
> > > -	migrate_disable();
> > 
> > hum, but now I'm not sure why we disable migration in here then
> > 
> 
> It seems that there is a cant_migrate() check in bpf_prog_run, so it should
> be disabled before run.

yes, but disabled preemption will take care of that

I think we can do change below plus some comment that Yonghong
is suggesting in the other reply

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..74e8d9543c6d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2734,14 +2734,12 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		goto out;
 	}
 
-	migrate_disable();
 	rcu_read_lock();
 	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
-	migrate_enable();
 
  out:
 	__this_cpu_dec(bpf_prog_active);

