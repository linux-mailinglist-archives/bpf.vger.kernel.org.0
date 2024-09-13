Return-Path: <bpf+bounces-39818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112F0977D20
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8890A1F22BDE
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2921C1AB8;
	Fri, 13 Sep 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDlpPhtp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3131272A6;
	Fri, 13 Sep 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222681; cv=none; b=UHRQ2Rz9Xoza+EIoaB4EzrqUi3xjnCR0YBWUfid2VufulTCJNlA/TjXfwyR5RTIe/iGPoxcV+6HOKGjNSwCeuyZOx5NItp5O2TUDtF5kE9/v23dwwVauUWR/je6/VPctQBuTdd6cPDplAFodXeLvr81Oa9OtJpySYxJ0SsNHvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222681; c=relaxed/simple;
	bh=mb4hlqzLZqpsZ4AxO0z+em82+5g8YGAdooUgrrZ2lZg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3QEU71Z/Usu0Prv9lyPixbBDTK+xww6e9mIP7XOQumWxbM+5ZiPFP4IaLyWhCskwMCMVYtVt2h1WFsIvzJqsQ/0SfE4hrz1f4r69nlYRR0bQ2gI7QGzXHADLDmgjY/WQjFpv2dhHZLV5vgnBKVGNk4jKdP48fMiUbsmhjGKnMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDlpPhtp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c180d123so473199f8f.3;
        Fri, 13 Sep 2024 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726222678; x=1726827478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqj3wUp4UEHqzM7aKhxol0z8Pjo7StQRIlTDvracW5o=;
        b=VDlpPhtpzg4dM0+bbzkzBIjSCLecNTHA9x5wioMZ/8/9n2HiVGmXJ4xh9GRbY+7Vi+
         3C9mhA9OlcWk1tstaJQwKVDoR/9Vscodm2VtDQp/zHNTo/PSDtH4O+3baByRP/fSfpnr
         oGNY3ONJEzWAk2IkbfqcbPj4SliPiseHC72+kacIMDUxQ/sVYC6yDyAlL21Z81gfoWDP
         N/X0T3ziTRylZzr2GdFejEueAAKwhNHxHARcE4y6InTv8Tdqzg60SzNSGe3/48D4cqpV
         0Jxuxd4p4wRTioO1XHwypk7E424W4dYvs1572QIQP4xRu0o+hfhpOJqgRSthrnUBwkjZ
         wD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222678; x=1726827478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqj3wUp4UEHqzM7aKhxol0z8Pjo7StQRIlTDvracW5o=;
        b=SzUGs9+GbwGEdP221qzu1OisFt1eHW8I6Al3jgUyyO285vx62AhP63U73rjXR9qxYj
         jaaD9jvK0GNlvMtbMxveUFxgMm60LW9PhD2dEVz6txoVeK9uVR1fiRGwe9F9itIgBsj4
         IH01IY/563oy8kNIoWT6173mGX3CcfwpBPd1FYaSegL40pzFjC5DyRUNr/aBTciJY+Ry
         DarSu5uDs7FkGXbVcvpNs79Bp+fUCQ05pWEHTmGl8bw4APtZKdpgwMJB2XXNDKIatuXV
         0kQzFL6S7QPp9C42sTms83gR+U3w5V2IH65+psppibXDqMFEF64km3YJc/hLsVwzNdJ/
         hnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3zNzt5w4VYP9V5XxR/pteNngnTSeYWpvRiC3g+RNCPiV+IVkPCiqtyTF+Wd74NevyDDoweGd51+VZ9QW@vger.kernel.org, AJvYcCWjvEKCVEWQaz5HCmMrP3xXRkz1xrYZ0p9MRkBWvytRrLOpWBCniG9NqrcL85yMPzGLVJQ=@vger.kernel.org, AJvYcCXoCROMFmtACzk3oGrwF+uj8DfWH4YpZuRLwRIeTBb1e0IW+7gBtpXV//9wuMv7dIC2FD15EDP2UyiLOgPfTJ5FvCQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YyNg4C7o6l+xF15WCcZ0LOXTTyM04Rn/gi6ZNY0wwOG3d+rBtRa
	hEe4gjA2eMkP4IfGTVlAm6HlYGDDdm/8FdmuTzXD6m+cOXL+Q25D
X-Google-Smtp-Source: AGHT+IFNWkP4dq7zE97dWHauTQqGFq1yc4hsZNl89bVCvsIJIg9JOfDDoSjSCMqMpEPk5aymR7PaxQ==
X-Received: by 2002:adf:fa10:0:b0:374:b6f4:d8d1 with SMTP id ffacd0b85a97d-378d61e2528mr1286065f8f.13.1726222678081;
        Fri, 13 Sep 2024 03:17:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de02esm16530785f8f.109.2024.09.13.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:17:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Sep 2024 12:17:56 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <ZuQRVJ1VwUoVj6DD@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <20240912163539.GE27648@redhat.com>
 <ZuP5dyfgT0PHaf_4@krava>
 <20240913093201.GA19305@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913093201.GA19305@redhat.com>

On Fri, Sep 13, 2024 at 11:32:01AM +0200, Oleg Nesterov wrote:
> On 09/13, Jiri Olsa wrote:
> >
> > On Thu, Sep 12, 2024 at 06:35:39PM +0200, Oleg Nesterov wrote:
> > > >  	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> > > >  				 srcu_read_lock_held(&uprobes_srcu)) {
> > > > +		/*
> > > > +		 * If we don't find return consumer, it means uprobe consumer
> > > > +		 * was added after we hit uprobe and return consumer did not
> > > > +		 * get registered in which case we call the ret_handler only
> > > > +		 * if it's not session consumer.
> > > > +		 */
> > > > +		ric = return_consumer_find(ri, &iter, uc->id);
> > > > +		if (!ric && uc->session)
> > > > +			continue;
> > > >  		if (uc->ret_handler)
> > > > -			uc->ret_handler(uc, ri->func, regs);
> > > > +			uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> > >
> > > So why do we need the new uc->session member and the uc->session above ?
> > >
> > > If return_consumer_find() returns NULL, uc->ret_handler(..., NULL) can handle
> > > this case itself?
> >
> > I tried to explain that in the comment above.. we do not want to
> > execute session ret_handler at all in this case, because its entry
> > counterpart did not run
> 
> I understand, but the session ret_handler(..., __u64 *data) can simply do
> 
> 	// my ->handler() didn't run or it didn't return 0
> 	if (!data)
> 		return;
> 
> at the start?

I see, that's actualy the only usage of the 'session' flag, so we could
get rid of it and we'd do above check in uprobe_multi layer.. good idea

thanks,
jirka

