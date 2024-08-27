Return-Path: <bpf+bounces-38170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FC960DD3
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 16:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D520E1C23095
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B01C57B5;
	Tue, 27 Aug 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGIphRFZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AC1C5793;
	Tue, 27 Aug 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769718; cv=none; b=KelIgRdzEUnKtcaYdH6H0X7WBin0zNc9nUNzor8uqMqKQWfSUGVCYbncOcRJ8CGpbElvxrIT3CHmI4P8TuLHiiSSptaBbv7+Ogxifd/k6QWbPZl+idsHmYumRIvEISHD7yWMfASGtLpv9VxsR/cpQyOALrldmQilLRIdDJ5VvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769718; c=relaxed/simple;
	bh=9XA5Tvf4m3mFzbkx8Mntr/6JTMjJVvRIgFSfUOTNP7U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U56B5JnrQYhYnC0p17c9NABnskSKBZUPG4BWtgR6RvNNYCesZmn8oiVUxowriyb3Q5CcjulK3w0iEOL5mh4rJ9QGpD/qyIsA/I0mxTclF26mpDP+7KSisWHmbt5Lc82wEvVL32KGccjc92PJpG+SqqiaMPra4ZgcIkY7aqTwE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGIphRFZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso64400451fa.3;
        Tue, 27 Aug 2024 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724769714; x=1725374514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwPfwK5ypJOpYnj6NBgi0Hz6PUIW6DZrmjhXCqXJegM=;
        b=RGIphRFZpHKwtNwjD/frw/wDomf78Tw1jl2XhmoA64QYXgubKnfcKV9OenIQNomY/0
         mvuRcTXKkyh9ql075UpCkmUui+DUg3LUmB2A30iaj7axOli1FupvZiiMBL2qm16DziJi
         75LuctjDLcb01XMaqe8WJD2kkWGOWZSVu/p8U3QTHhYgCOit8H0HZ3/7+qILvWvL9DlU
         wwBdHa3Yu4EBoXOpf7JMIJ8r/2rQcicgXFdzRwUVfO8tD2J3PKu6PYdab5VUXe/JEG0T
         /NqtzI9Uu5sOR7QvNEXJNRLkQyG8Z2QtD9xhKFeao8aAUmWB7U1HscB3s4A3lOctevJS
         E5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769714; x=1725374514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwPfwK5ypJOpYnj6NBgi0Hz6PUIW6DZrmjhXCqXJegM=;
        b=BMEXyqvqJn3jXkbtkTy0eUMq9bSOmQYQlThQxnKJ/ij+0TXAFwxyuC67mG0kU67cON
         cTJwHSSLiJL7rHCFzv0LqHEuMG4h3XmU+dlrWUgP5e8LH6/uoZI8vonpvs+wyOdaEaFi
         BqPkDC2gSIkkcdMnAalkgRibdiXyqrGFPocfzuoDZKglRnYJKhCQz6rwOLni6qKTqCDh
         +1WMu67/BXxNkXK4oerLWznAa9JBUk6HeCxBVAovARwak5eCQfhFdHdPVHDt9Q4G97wn
         Nalv/zepIPlyzBRAcnFHW+NjwwTVFzyyESvG/2RioGHtIaXvJlAesFPIadPnw+XWSRx6
         w9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUa1wumbOKd7JpaAp0+epNEobyMD6IFHI8fzz/GUEW8vVn5odCKtH17aH8kWIoPpGiS8KxLt3bR3JtSULp3u5xz6Zhn@vger.kernel.org, AJvYcCWMSqhx5SUvUztMAEg762lMBiCa/Az3CZptZTf0W5E31MGYrCkTnCpvkpWJu6UW0TCjlhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbx4SUkGFUqYqAdyHxl5OKgL3h6JoZYvnQxVYYKdQw9PxkwNCe
	Xtzx4yWo7JBJl/0FWT7tVMavy2iIUkax9LizwpiXFRmdiE/PL2On
X-Google-Smtp-Source: AGHT+IHVnhfg0ZFjNAAQ3QGfSkOkv7p85b/5sM23Oura285dpiA7CmSTrXWzs/41LSjiD5oyAZZWGw==
X-Received: by 2002:a2e:f12:0:b0:2ec:56b9:259b with SMTP id 38308e7fff4ca-2f514bb98a9mr19200031fa.49.1724769713804;
        Tue, 27 Aug 2024 07:41:53 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb2156dfsm1088071a12.53.2024.08.27.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:41:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 16:41:51 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs3lr8gwlZKDL398@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
 <20240827104052.GD30765@redhat.com>
 <Zs3VWu2axL2tQXkc@krava>
 <20240827142607.GF30765@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827142607.GF30765@redhat.com>

On Tue, Aug 27, 2024 at 04:26:08PM +0200, Oleg Nesterov wrote:
> On 08/27, Jiri Olsa wrote:
> >
> > On Tue, Aug 27, 2024 at 12:40:52PM +0200, Oleg Nesterov wrote:
> > >  static bool
> > >  uprobe_multi_link_filter(struct uprobe_consumer *con, struct mm_struct *mm)
> > >  {
> > >  	struct bpf_uprobe *uprobe;
> > > +	struct task_struct *task, *t;
> > > +	bool ret = false;
> > >
> > >  	uprobe = container_of(con, struct bpf_uprobe, consumer);
> > > -	return uprobe->link->task->mm == mm;
> > > +	task = uprobe->link->task;
> > > +
> > > +	rcu_read_lock();
> > > +	for_each_thread(task, t) {
> > > +		struct mm_struct *mm = READ_ONCE(t->mm);
> > > +		if (mm) {
> > > +			ret = t->mm == mm;
> > > +			break;
> > > +		}
> > > +	}
> > > +	rcu_read_unlock();
> >
> > that seems expensive if there's many threads
> 
> many threads with ->mm == NULL? In the likely case for_each_thread()
> stops after the first t->mm check.

aah the mm will be the same.. right, nice

thanks,
jirka

