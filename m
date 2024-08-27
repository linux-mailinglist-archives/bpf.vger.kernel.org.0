Return-Path: <bpf+bounces-38158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6783960C10
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 15:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89371C22470
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0431BF32A;
	Tue, 27 Aug 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOo12Bep"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6D19B5BD;
	Tue, 27 Aug 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765537; cv=none; b=I7ThXBGgcMGggfMTlTDx64beqRbEdZcEei99Bflmkeeva4xtEViVSQNKjOsRl646Y/WhLA628x6qqAer7MvohsKu0Bupt99RIPK12a0K5aiTOkk74QDk1cN4ED/ULhQf9o9ictB0v8VifrRQbZszH90pPMe2KXwluveDa+HNDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765537; c=relaxed/simple;
	bh=tJf3nuXtgEa6l+6Sb/O8iVL1TaZps1ZJVpCaE9aNiJg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxxtwF5Y0vbVisiKwH4hfIBYwKrYgJ9QqTfFL9EBfpb6fBJQrNciaaO7Vf0n8h8Dh4EHK/qTxX1MQc67vMOIWlcXpLYoGbb9RNI6gHdWg1YRkaiqmB4sEXlgo1D25XG/AZg6rtRWjTP2rGjCQhSnqVCmAN/qt+D58vkuSo8v8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOo12Bep; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4100681e87.1;
        Tue, 27 Aug 2024 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724765534; x=1725370334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpqyatG096Bpa5vwnMgnoZFTUsK0l3esjuEWmJtsSjg=;
        b=hOo12Bepwh6rNnEjIFz75XcgX5vavKGxTr8q35j8sMc+f852tabXJ0BgUPnSAE0QPD
         jwRWguwpB+5JtEgsmvHrylnKYZmJH3YKo+RGX3p3lSEEVK0Wb8RpmfK3FTC5A9j8M0DZ
         spyVuNwP53WeCpYwGi8vCin2uV5/05yGRYXjplkkvAn8IZhHBhkU9ytzTiGo0g8QXhjz
         bm80rfT/2hdx7lxvPzx0ujX2lJ2P7Qcok2ADltxfHMkw9Ovmc8txX6D/zMMp+mY7WpqR
         Ajw9hlGEG8zkTa29ohhbVie7+FeBlGbkVfhsShPWbjXaWvWL7qD1KDym7E0F6ESillq5
         7ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724765534; x=1725370334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpqyatG096Bpa5vwnMgnoZFTUsK0l3esjuEWmJtsSjg=;
        b=QMrMZA27OHZBdroVepaCd/tj+ksshCRMFbSFdhCSuRktH1vd8cOJTxYQIXvIwxqLiN
         To+ZSO8PgG5nJgnY+P6BKKPaIpkpcSb4IPTi4X2LVmQWK4EHI8G4mWJmF8Ehm3ei5ptc
         MElikB/1MCLSu5yXzMQ6w+9tsuo1h4aODkQXZm1oT/x0l8DXbypLx/grqeB7JTM+55zW
         vp01uGQfni7siyatObP2TghIPzKxV+FdGAXKQ2tyAsxllXe2xPF8L22Sob7dUqUwdcmK
         EZbo830oH0kmEhuwYKvnUAhH+8+y3PVNPRKc8hA3sdyZCUVprWFi6Qj2B66ItfV3gRVW
         m0nw==
X-Forwarded-Encrypted: i=1; AJvYcCVr9WceHmKhPv9DxKGV6aYoN8dinrjzHBqlQt5Cllv981qlCLZVbkzxkLn0ZtmHvspAdXE=@vger.kernel.org, AJvYcCWpT/PNqjttc+AUjTvg2PpFd43i4hlv0ghCNem26ZzyaX7pNMrlpN0oz6eqdSsxRGAZMxqo0HPP1pb7qPsJ7vJwWDq5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GMEQajSsIK0SYngF3F+JRbYTe4bul76SQrWesJ2uVusAC6fb
	ywNOR5Tdg5JBd/r2G3HUXmNSaJl9zr99cSoP+RFQK74+KfF1bhHu1jwzql9Iqs9t/g==
X-Google-Smtp-Source: AGHT+IE6OR02jIRC/j+cLgwb02ssmmEb380GSD4wwI57OrxqnK9m2/PhfQ3+WbxP2rijRxfMT+AlHg==
X-Received: by 2002:a05:6512:124f:b0:533:526a:cd08 with SMTP id 2adb3069b0e04-53438773434mr10562846e87.14.1724765533476;
        Tue, 27 Aug 2024 06:32:13 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878455sm110451666b.160.2024.08.27.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:32:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 15:32:10 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs3VWu2axL2tQXkc@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
 <20240827104052.GD30765@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827104052.GD30765@redhat.com>

On Tue, Aug 27, 2024 at 12:40:52PM +0200, Oleg Nesterov wrote:
> On 08/27, Jiri Olsa wrote:
> >
> > On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> > >
> > > So perhaps we need
> > >
> > > 	-	if (link->task && current->mm != link->task->mm)
> > > 	+	if (link->task && !same_thread_group(current, link->task))
> > >
> > > in uprobe_prog_run() to make "filter by *process*" true, but this won't
> > > fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().
> >
> > would the same_thread_group(current, link->task) work in such case?
> > (zombie leader with other alive threads)
> 
> Why not? task_struct->signal is stable, it can't be changed.
> 
> But again, uprobe_multi_link_filter() won't work if the leader,
> uprobe->link->task, exits or it has already exited.
> 
> Perhaps something like the additional change below...
> 
> Oleg.
> 
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3322,13 +3322,28 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>  	return err;
>  }
>  
> +
>  static bool
>  uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
>  {
>  	struct bpf_uprobe *uprobe;
> +	struct task_struct *task, *t;
> +	bool ret = false;
>  
>  	uprobe = container_of(con, struct bpf_uprobe, consumer);
> -	return uprobe->link->task->mm == mm;
> +	task = uprobe->link->task;
> +
> +	rcu_read_lock();
> +	for_each_thread(task, t) {
> +		struct mm_struct *mm = READ_ONCE(t->mm);
> +		if (mm) {
> +			ret = t->mm == mm;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();

that seems expensive if there's many threads

could we check the leader first and only if it's gone fallback to this?

thanks,
jirka

