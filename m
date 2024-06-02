Return-Path: <bpf+bounces-31164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D831E8D7835
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015C01C209B8
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353E76EEA;
	Sun,  2 Jun 2024 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du4qhe7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7A81F;
	Sun,  2 Jun 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717362420; cv=none; b=dmdeciQ9+RggqurspW4yvzu1m6iXww3pB/NFr/wbYWqoVPk5hDx4DBwfekohPNCTFKbBPcrN6E6na4pHysf5pL0S1sieU2liP8nSdl23ojfcLnWiV8YF5XUD4mCgdu2cYmyWpi91cjfTZju+ql34k6Qs6YU55DPgljtRlLg5UWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717362420; c=relaxed/simple;
	bh=OGAM9AAuO65imAAPVgw+QhYz5OoRAm3Xj8ZIOpiNhjI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkdc9VnIJ4BuWDb/EPHIJ1/k63lwOMUOpj7+dEiHSlfX7bDfHfSCFVoEc6BXuFLFe5dKaL/JFAFT9gpld6HE5mthnjX95aR0e86JF4xVVaqfPwDU3JQ62xg8eWYz/VEkTgLsCa/1a6bNnsF+A/8gWBSe1UpJpvKilDNbU4gnZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du4qhe7x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so20743185e9.1;
        Sun, 02 Jun 2024 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717362417; x=1717967217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nP94ybM9FNYb88tz7HD/3vY+krh+IlSjX7kjHLs0wAc=;
        b=du4qhe7xNAltU2sYWi7qpAEmx16AfG/FIeicBjyw6Nv3xkTD8vRsg/tmRrWg78SpIu
         TrF0XUFLDIshoptKmq39DdIj7P+DIMfsOkWnnarDuN+udDYDkD3jPXqvNdW/Jeyj8EH/
         aPxpAOZDLQDMwWzeevsAeUphbHbDo2dYSHK2wRNrWcKYptyuSQtPf51uL6YtFwO/aoar
         50Je7U/v0w6ghV6Kkjq0OUXFun+vs+I/jMEEYLDIz8YSd6Jf6Zs+VUFb5KceTdhSpoMe
         BscItxzrNwIHM85gYU5CR8yWgVM4mBzQNrUNjOwDyajtIsP4kiOyZc3PzQkcegsBtK/R
         X75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717362417; x=1717967217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP94ybM9FNYb88tz7HD/3vY+krh+IlSjX7kjHLs0wAc=;
        b=hqk/IZ2fktYocJCblm9ntxg6raeiZglen/93Mssv2gzmDyukV787/rJEr3tB1TrOR5
         pxrbB3HazzrHJi2EbZEF5NWVQGW1yywL58pAAxcd3K/1GMXhRkX6YK2bllm5/2DcvKj7
         njBzrjEBy581wIL0ZO14jBHJ2u9UYJ2M+ClwXFFyWrPliGvAiE6VgnnQXvahk+ayqCNE
         W8HthXcbCgSgx8h5NVl1s0jRcXjzSC849QuOyQwmsZhhIiqwyHzCXW4ijXqBM9uSFm/5
         kB26bjU+YWSpGq0E+BKzNOtrNEslocKE8RC9YkjceYRMjpx/OuVdbStsMjZahvqwIw5c
         XAyw==
X-Forwarded-Encrypted: i=1; AJvYcCWhDOzSBl8kwcM/efi0JlsF3Hh1UuGmicv12/d/MoG3rg4z5uKa5SdqxMNknM44H3c8tOpQ7VS4WRLNETEpnnyMz5i4v5zBz41CmxH5K06LhmHnB0YxoTH9hrDdsFGPPZzaTIQeTfhbrlJSZq0LCoNQVvLB4Cmp04ebKhzIkn4IJoXZYwzK
X-Gm-Message-State: AOJu0YwXLZSfmChmniuAIXh4iFtSfk9q5sQr8+56ZANOFwoFqDPe8kfA
	KC9qlNhx3jsve1L5vmkXhnxUz0Ph5vm9YFcwGFReKxncXT79LCZd
X-Google-Smtp-Source: AGHT+IE9bKDGV2rae0v7hv3k7gf4Dv+ETcHfnP82kQkmzUNLWD1YWO3uYbNFTz/pADFJD16sGpjrTw==
X-Received: by 2002:a05:600c:474a:b0:420:29dd:84d4 with SMTP id 5b1f17b1804b1-4212ddb68e8mr65427985e9.13.1717362417280;
        Sun, 02 Jun 2024 14:06:57 -0700 (PDT)
Received: from krava ([83.240.60.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm14484845e9.0.2024.06.02.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 14:06:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Jun 2024 23:06:54 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (May 2024)
Message-ID: <Zlze7nGNJcAvKJR2@krava>
References: <00000000000061fac40619ba66f6@google.com>
 <20240602120950.8f08ef16ad9c485db374c08d@kernel.org>
 <Zlzbm0rvNN9XY5v_@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlzbm0rvNN9XY5v_@krava>

On Sun, Jun 02, 2024 at 10:52:43PM +0200, Jiri Olsa wrote:
> On Sun, Jun 02, 2024 at 12:09:50PM +0900, Masami Hiramatsu wrote:
> > On Thu, 30 May 2024 23:50:32 -0700
> > syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello trace maintainers/developers,
> > > 
> > > This is a 31-day syzbot report for the trace subsystem.
> > > All related reports/information can be found at:
> > > https://syzkaller.appspot.com/upstream/s/trace
> > > 
> > > During the period, 1 new issues were detected and 0 were fixed.
> > > In total, 10 issues are still open and 35 have been fixed so far.
> > > 
> > > Some of the still happening issues:
> > > 
> > > Ref Crashes Repro Title
> > > <1> 705     Yes   WARNING in format_decode (3)
> > >                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
> > 
> > Could you send this to bpf folks? It seems bpf_trace_printk caused this errror.
> > (Maybe skipping fmt string check?)
> > 
> > > <2> 26      Yes   INFO: task hung in blk_trace_ioctl (4)
> > >                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> > 
> > This looks like debugfs_mutex lock leakage. Need to rerun with lockdep.
> > 
> > > <3> 7       Yes   WARNING in get_probe_ref
> > >                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
> > 
> > Hm, fail on register_trace_block_rq_insert(). blktrace issue.
> > 
> > > <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
> > >                   https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
> > 
> > This looks like debugfs_mutex lock leakage too.
> > 
> > > <5> 5       Yes   general protection fault in bpf_get_attach_cookie_tracing
> > >                   https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
> > 
> > This is also BPF problem.
> 
> this one seems to be easy to fix, can't reproduce with either the change
> below or with instrumenting __bpf_prog_test_run_raw_tp to set current->bpf_ctx
> as in __bpf_trace_run
> 
> will send a patch
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 593efccc2030..fc303c20f402 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1148,6 +1148,8 @@ BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)

nah sry, sent wrong change, should be in bpf_get_attach_cookie_tracing
will send formal patch

jirka

>  {
>  	struct bpf_trace_run_ctx *run_ctx;
>  
> +	if (!current->bpf_ctx)
> +		return 0;
>  	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
>  	return run_ctx->bpf_cookie;
>  }

