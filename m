Return-Path: <bpf+bounces-56500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2AA99486
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C5924B0A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F03428C5DF;
	Wed, 23 Apr 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKB56hZl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AC28BAA9;
	Wed, 23 Apr 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423474; cv=none; b=dIT+h51xFVAjMDF3wE1tbwLmk0UJt5+brXLXzuQqArrN0h9P7AQDzGB4/+CZapVIznNqHOMYaExlD86LbyKGw3EcZtXSxlIovxQlbDNQBKMAiLTXMjBegZkhZqoBWgZj4EibQHz7AL4fkbq+cWwY6Ab1XiFlYZjdNe4AbCsJ+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423474; c=relaxed/simple;
	bh=aa7/f5Zh9n06yla3BDP8426xRfbXJ+bYThqtSMu5iMI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPWiNuIVnO45LCf2WbYeTCKPicb1uOsVTIXUcGTXBO/lZlSKwdLOxzVHQY81wZnuDCS4XW3yN0g2VjImVAswB359HvJGvEfB+y39JZdJ0j5muiUwN5rBwC07c+8k0mhDyS8zBWt9DgauyQMX6WERu8mLN+htRSxzZykuQt7xavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKB56hZl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf848528aso49448855e9.2;
        Wed, 23 Apr 2025 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745423471; x=1746028271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6aidtYCoBxwfa+luGgigfHv2I9RMSlPDA/HH3ouHUw=;
        b=nKB56hZl26a06tlMQWcS3UbiFrqStyCqMP6+kL+mcq8jvUP3zRVdW3wbtSyDZabY2P
         pQ7R+Gcox3dqVpTZt/p/ISqWwZYB1WZ3Mv7YouPiKoWhAot2t9RBLIhZKFn20ju/zvUl
         +U2ZTSeO7i6pQRIRBh0gA2Oqm+f/ZYbZ3lYPbBW1lq9jJdp+8boZyAvNzoj4sM+Y0zE/
         A4kwdPVTgndHScp4QzEQuEk2f1nEF2gpFkC6TeQsNyiBODHK+exDOBHK1AlKNktFfuf+
         cLIFskFo89Qk91zaa9tZq1eRfpHg1bRAXtGXdOaYlzhqfV8Dzmx92LxJwX/Y8tmrjaV/
         4utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423471; x=1746028271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6aidtYCoBxwfa+luGgigfHv2I9RMSlPDA/HH3ouHUw=;
        b=r4EwtPb0V1+wbRfT0QPKsDqAzvE/92jtGc7zfiokgpDaWqid2mt+TQvlXhuoUWvBqQ
         GKY1e8vLrO0GnZooluJZGj9ZudQ7o1Lp2/mY5UOrOhDNgg6vrV8QKRUi/1f9Ex9uhqI/
         8Zq5DDnQRv9EFlUCCEGGlQa7b2I/lnwiUbqoX3/4Rp7DnnfHL8EzcJxPsK7kNbUhcmhN
         JJk8vP2PiRpisS7PId8NgCZXv1UpnUKT1wnEhCbvZqjr7mUMLoPplICxytwhra0wvpNF
         V0QErintGK1Z6G+BGm6YoAhtJxtgHz+iyh6j2V69cgHs81FrVeLrRajCh7HNeF1YDYRB
         RKrg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUPV0hawQJk4W8LuFcOHT5zIoEjErl4kT8iGo5OlF38WeScyy2EE5kf80I7GMHlngS3o3ofB+XIBHnwdI@vger.kernel.org, AJvYcCXmaaQnoJwBkfH/qkOyYB5u9eZ7hf+i4xngXXOPnbr2iFIcgya6GrBDH2Wqf9mma2DDhUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VJbTftJ4CZ9UVBe5zUvCju3ACse7CfCix6WOXhDJSGXlvJ4D
	h/PfE+/mhSxSfjgsAPHxXFTgvMxWgTqfEwrvS4MOfDb2fhnX8GU+
X-Gm-Gg: ASbGnctELq/y/yjwzKevG7ioQURqsN2exY658VWrZJqY9vqvWIVHPkUOLROX6fHmCf8
	gTwunLZZU2eeCE/zDrW5vswHVPkByismXZrWBqV4uQCdKu0EkQ07Wimk/Nelp2WcgzJnKb30GN3
	hm0s1hqgLQkQ8nSY5QfLwc3qCwGVAPDu0ogt0tajieX37N0DD4E+HVXRFXdEueslpBTsuOxefQx
	LNzs2oX3Rzx6cl2H2V/K49Kf2XO5ehCaILW0ZCvXR/UKftq8xT1CWduIBFGG6XYLOfbjCz+mDg3
	aQN1cw1saKanKFEsr0899g96q8kQ8M+7bhkzK9CRCCgc/pg=
X-Google-Smtp-Source: AGHT+IGS33U0SQfEUtTQ/6SINRbclcHrXy1+ioipbh+69IqIa03G439XHh9lBMNutBMrCfUiOq1QHA==
X-Received: by 2002:a05:6000:cc6:b0:39f:a553:3d98 with SMTP id ffacd0b85a97d-3a06c43f9a4mr23357f8f.56.1745423470916;
        Wed, 23 Apr 2025 08:51:10 -0700 (PDT)
Received: from krava (85-193-35-16.rib.o2.cz. [85.193.35.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bee6sm18983897f8f.45.2025.04.23.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:51:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Apr 2025 17:51:08 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next] libbpf: remove sample_period init in
 perf_buffer
Message-ID: <aAkMbBdzWX_iE1zM@krava>
References: <20250422091558.2834622-1-chen.dylane@linux.dev>
 <aAedDw7fWAF2ej1f@krava>
 <aAfok3ha8QQkP8VB@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAfok3ha8QQkP8VB@google.com>

On Tue, Apr 22, 2025 at 12:05:55PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Apr 22, 2025 at 03:43:43PM +0200, Jiri Olsa wrote:
> > On Tue, Apr 22, 2025 at 05:15:58PM +0800, Tao Chen wrote:
> > > It seems that sample_period no used in perf buffer, actually only
> > > wakeup_events valid about events aggregation for wakeup. So remove
> > > it to avoid causing confusion.
> > 
> > I don't see too much confusion in keeping it, but I think it
> > should be safe to remove it
> > 
> > PERF_COUNT_SW_BPF_OUTPUT is "trigered" by bpf_perf_event_output,
> > AFAICS there's no path checking on sample_period for this event
> > used in context of perf_buffer__new, Namhyung, thoughts?
> 
> It seems to be ok to call mmap(2) for non-sampling events.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Tao Chen,
could you please resend without rfc tag? plz keeps acks

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> Thanks,
> Namhyung
> 
> > 
> > > 
> > > Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 194809da5172..1830e3c011a5 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
> > >  	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
> > >  	attr.type = PERF_TYPE_SOFTWARE;
> > >  	attr.sample_type = PERF_SAMPLE_RAW;
> > > -	attr.sample_period = sample_period;
> > >  	attr.wakeup_events = sample_period;
> > >  
> > >  	p.attr = &attr;
> > > -- 
> > > 2.43.0
> > > 

