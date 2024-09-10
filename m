Return-Path: <bpf+bounces-39413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E91972C73
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098811C2434A
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7262186294;
	Tue, 10 Sep 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZBKD3mR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3D143879;
	Tue, 10 Sep 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957942; cv=none; b=ck2wYLwGDs+BeM8WMSf5lf7lt7U3aREArCIshOZoYIJxDRFG7lDfRtqBORd4UKjfyOMECaruczlmoDwFMjbuWsRDKo0tVnA5XQe7+py6mRtqsZspwjoV7yf7Mpys3IpPpyJFo82ODHKIYEiqebMxc7QRUBK0yOnTwNuACKKO2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957942; c=relaxed/simple;
	bh=QpyZtCDqQQJu1a8V1dLs7TdyctsPhBG0R9ftvYMKrS8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3hIYoLZJ3LxqO8xiUE0ThstkCGzaoUYZduPKZRlTcVE+R2T/EZypiZ5uWAEgs4YVX2dTEvy5IcaFxLPteo9UiqQKZxoFhgHW92UqcaVkXxT7uM6ujuNYeaBFnkklfGW96AzCwvmBN9RXtw3fBfebn/tvy/SVLABP8HZq5ad5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZBKD3mR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb6d3e260so4845605e9.1;
        Tue, 10 Sep 2024 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725957939; x=1726562739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIkOrRmHWmhfNqqRfQFcjf7c5Q9iWNzy9SkPqNn5Z44=;
        b=XZBKD3mRsS9TVWaR8hSv+CeKWlL7Awhw1b5Zb9CGrW+FiRWsJE3F6jGYT5uSEZQr/t
         h+7zYeTo11o00saks16AVfrUs4uma3uoOKQv+MH6MAhL5hHqEB9WgFOYEdFNfENK5HrB
         3Di7UDj0OKLaOQ5WfRyqWBza/eSew3zNZA8W7mJHMnXWi3P84XP6WOYGkdsyDvx6weIZ
         9li6OSDv5nO/VZc/JO7B/H/CH31lvs1c3/cOJ7veTd+OXFpoPq9hSclYZ5jOfmbcSzHu
         7Aihc1RqfCD+oetkxEb1mg3up3nsInMtpBUPPpXeJ66PyM3PuwK59d1T5806rttGo5yV
         ifbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725957939; x=1726562739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIkOrRmHWmhfNqqRfQFcjf7c5Q9iWNzy9SkPqNn5Z44=;
        b=Mmo8fyziHpZSgOZoLPrX/kGbe13w25uXl3/K80WkL730G4hHq94bIEYWdpKHgIAxpd
         lzB4itQRY1zak3hOVrNg4FRR99Fuke2n6/KOGNBPJQ8zCSli8MTZzwl8RpV5u0/KcQUA
         xFzeMlIz6Gl7ptOn9WulBvPbpXp0CQS6XYw4J7D6HuR9g2EIAbVudfqAkZ3Y7MQE59MK
         MstmrGhXdVhT4WgLawyh/s3S7RdZOFvzfrRD2DCQ1MpKiUkK18vv2oc0YfhZEK3OZEIJ
         spCprwxYzdAY3vVculOWGW2Jd9CslqXkk/aF77pTJ5vWKTEqdnY/yfQbrexaoRdW8BUZ
         jYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXX4LmunwYvIT0RctLmj8ZTdwgyaNT0JXN6WX9nPmnj27SrLZT2EMF8bNESl96QDCEcVw=@vger.kernel.org, AJvYcCWjdk0+fuSAh7NfnmVo+vNRfuxF6dsjqR7RGQUQschGhERMntsUP6CwgTyMYunP+0Tw3lTlR9MJGWje5VD6Ig6aiHTK@vger.kernel.org
X-Gm-Message-State: AOJu0YxlA/h53iRg+g8B4lGccaCmU3P/p1JmVDZ1bO1ZB61HfndGRJnK
	q/2ycsZUjSr/lTigkUNjT8/CqTG3eFKSf449bR+LarwXXJWbCcD9
X-Google-Smtp-Source: AGHT+IGSP1iStElNEUqnkIVwQpnmgWDKsL5h9UAuWr1rjlBTJwgZ8YnhPMbssUcSrchrj7h/t3OO5w==
X-Received: by 2002:a05:600c:4fc4:b0:42c:a90c:a8a with SMTP id 5b1f17b1804b1-42ca90c0abdmr89635365e9.21.1725957939079;
        Tue, 10 Sep 2024 01:45:39 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb742d0a1sm65323515e9.2.2024.09.10.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:45:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 10:45:36 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	ajor@meta.com, albancrequy@linux.microsoft.com,
	andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, rostedt@goodmis.org,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZuAHMLCAEWV9yve0@krava>
References: <20240830101209.GA24733@redhat.com>
 <ME0P300MB0416522C59231B4127E23C6F9D912@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <Ztrc6eJ14M26xmvr@krava>
 <20240906191814.GB17874@redhat.com>
 <Zt7Q6GVKtGTIdO1g@krava>
 <20240909183436.GC14058@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909183436.GC14058@redhat.com>

On Mon, Sep 09, 2024 at 08:34:36PM +0200, Oleg Nesterov wrote:
> On 09/09, Jiri Olsa wrote:
> >
> > On Fri, Sep 06, 2024 at 09:18:15PM +0200, Oleg Nesterov wrote:
> > >
> > > And btw... Can bpftrace attach to the uprobe tp?
> > >
> > > 	# perf probe -x ./test -a func
> > > 	Added new event:
> > > 	  probe_test:func      (on func in /root/TTT/test)
> > >
> > > 	You can now use it in all perf tools, such as:
> > >
> > > 		perf record -e probe_test:func -aR sleep 1
> > >
> > > 	# bpftrace -e 'tracepoint:probe_test:func { printf("%d\n", pid); }'
> > > 	Attaching 1 probe...
> > > 	ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
> > > 	ERROR: Error attaching probe: tracepoint:probe_test:func
> >
> > the problem here is that bpftrace assumes BPF_PROG_TYPE_TRACEPOINT type
> > for bpf program, but that will fail in perf_event_set_bpf_prog where
> > perf event will be identified as uprobe and demands bpf program type
> > to be BPF_PROG_TYPE_KPROBE
> 
> Yes, thanks, I know,
> 
> > I don't think
> > there's a way to find out the tracepoint subtype (kprobe/uprobe) from
> > the tracefs record
> 
> Hmm, indeed. it seems that it is not possible to derive tp_event->flags
> from tracefs...
> 
> Perhaps bpftrace could look for probe_test:func in [uk]probe_events?
> Or simply retry ioctl(PERF_EVENT_IOC_SET_BPF) with BPF_PROG_TYPE_KPROBE
> if BPF_PROG_TYPE_TRACEPOINT returns EINVAL? Ugly, yes.

yep, but will probably work, I created issue https://github.com/bpftrace/bpftrace/issues/3447
so it's not lost

jirka

